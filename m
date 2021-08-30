Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F293FBE25
	for <lists+linux-scsi@lfdr.de>; Mon, 30 Aug 2021 23:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238281AbhH3V1R (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 30 Aug 2021 17:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237560AbhH3V1E (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 30 Aug 2021 17:27:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8AEC06175F;
        Mon, 30 Aug 2021 14:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+F5KOCzrXZghph/UppvQA2s1yRYbitmFgtgTDMNdZxo=; b=g6G7Q57H2FAHUqlaR9L+v6sDB0
        WE9LESzO2ktJT4CDHl8/4lFV51UGHuWalXLANrTNskdjVAqbLeQcZ8MBM5huy4kZfbPTguKAY39AU
        zdgPFPVylW1iwCJY7LzzerYbclaC6mmBMfy+P8iZQ60pvo9t9fGi0oi+6sjeVz0vgJPxSWDfhZGew
        sd1RgARv+3wiYSr0ck6H0gtcFHWli8BiKHnTzw96sYEeXf0zgG+LAVDRvKxFG5Zt/B49B0GXm/O5b
        UPQYep4J2WSaDfiUeDgADxGkQmW71/HwXOmaPiU9LFTGiUhjnCkokGhH3pcKcJCXtuylp79lQqqHP
        3AfVdnNw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mKomk-000ci6-Fs; Mon, 30 Aug 2021 21:25:42 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, martin.petersen@oracle.com, jejb@linux.ibm.com,
        kbusch@kernel.org, sagi@grimberg.me, adrian.hunter@intel.com,
        beanhuo@micron.com, ulf.hansson@linaro.org, avri.altman@wdc.com,
        swboyd@chromium.org, agk@redhat.com, snitzer@redhat.com,
        josef@toxicpanda.com
Cc:     hch@infradead.org, hare@suse.de, bvanassche@acm.org,
        ming.lei@redhat.com, linux-scsi@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-mmc@vger.kernel.org,
        dm-devel@redhat.com, nbd@other.debian.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 1/8] scsi/sd: add error handling support for add_disk()
Date:   Mon, 30 Aug 2021 14:25:31 -0700
Message-Id: <20210830212538.148729-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210830212538.148729-1-mcgrof@kernel.org>
References: <20210830212538.148729-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/scsi/sd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 610ebba0d66e..8c1273fff23e 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3487,7 +3487,11 @@ static int sd_probe(struct device *dev)
 		pm_runtime_set_autosuspend_delay(dev,
 			sdp->host->hostt->rpm_autosuspend_delay);
 	}
-	device_add_disk(dev, gd, NULL);
+
+	error = device_add_disk(dev, gd, NULL);
+	if (error)
+		goto out_free_index;
+
 	if (sdkp->capacity)
 		sd_dif_config_host(sdkp);
 
-- 
2.30.2

