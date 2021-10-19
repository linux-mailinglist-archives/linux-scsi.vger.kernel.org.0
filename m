Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEE9433027
	for <lists+linux-scsi@lfdr.de>; Tue, 19 Oct 2021 09:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbhJSH4k (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 19 Oct 2021 03:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbhJSH4k (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 19 Oct 2021 03:56:40 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A29C06161C;
        Tue, 19 Oct 2021 00:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+i+0ifREpsXZ+9ek7A6ZG2yGJqfiGvF9StnvRfcRozA=; b=TZM/20eKliVexHPqq8wNxQpsD+
        eUSlVaZhYYjoXXiX8wtUtyTQIy/vf6wnxgmRzPJzWZRo+CY1dwMly/IzoGx8Ff7uT71gOMicdaCbS
        M1MTWPAdCOU6c2P7SchhDSsvTOi+iybkFwpFpJ4UcHUyYSu16jrY8b23KGxV8Iw/00ubxqqvgFDLQ
        tIzsNhX2UIe9dE0p9AP3wMKWudbyUWXujrvhuShI0+cKPirJBEtX2uxTl0951RiSnsI1ly2QUVkjh
        O167ihaWLEMNI3aaL3gvX0uWaLqHG7bhjBnwCfFrDzpoXOIFs+CuBWL8ZPq1DDArLRMvVkbsbgenZ
        Lk+W3YVw==;
Received: from [2001:4bb8:180:8777:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcjx3-000T80-Q2; Tue, 19 Oct 2021 07:54:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH 2/7] sd: implement ->get_unique_id
Date:   Tue, 19 Oct 2021 09:54:13 +0200
Message-Id: <20211019075418.2332481-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019075418.2332481-1-hch@lst.de>
References: <20211019075418.2332481-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add the method to query for a uniqueue ID of a given type by looking
it up in the cached device identification VPD page.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sd.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index d8f6add416c0a..16e528c79762c 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1757,6 +1757,44 @@ static void sd_rescan(struct device *dev)
 	sd_revalidate_disk(sdkp->disk);
 }
 
+static int sd_get_unique_id(struct gendisk *disk, u8 id[16],
+		enum blk_uniqueue_id type)
+{
+	struct scsi_device *sdev = scsi_disk(disk)->device;
+	const struct scsi_vpd *vpd;
+	const unsigned char *d;
+	int ret = -ENXIO, len;
+
+	rcu_read_lock();
+	vpd = rcu_dereference(sdev->vpd_pg83);
+	if (!vpd)
+		goto out_unlock;
+
+	ret = -EINVAL;
+	for (d = vpd->data + 4; d < vpd->data + vpd->len; d += d[3] + 4) {
+		/* we only care about designators with LU association */
+		if (((d[1] >> 4) & 0x3) != 0x00)
+			continue;
+		if ((d[1] & 0xf) != type)
+			continue;
+
+		/*
+		 * Only exit early if a 16-byte descriptor was found.  Otherwise
+		 * keep looking as one with more entropy might still show up.
+		 */
+		len = d[3];
+		if (len != 8 && len != 12 && len != 16)
+			continue;
+		ret = len;
+		memcpy(id, d + 4, len);
+		if (len == 16)
+			break;
+	}
+out_unlock:
+	rcu_read_unlock();
+	return ret;
+}
+
 static char sd_pr_type(enum pr_type type)
 {
 	switch (type) {
@@ -1861,6 +1899,7 @@ static const struct block_device_operations sd_fops = {
 	.check_events		= sd_check_events,
 	.unlock_native_capacity	= sd_unlock_native_capacity,
 	.report_zones		= sd_zbc_report_zones,
+	.get_unique_id		= sd_get_unique_id,
 	.pr_ops			= &sd_pr_ops,
 };
 
-- 
2.30.2

