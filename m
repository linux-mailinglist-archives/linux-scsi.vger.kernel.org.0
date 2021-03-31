Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B046A34ED6F
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Mar 2021 18:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhC3QSN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 30 Mar 2021 12:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbhC3QRu (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 30 Mar 2021 12:17:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83408C061574;
        Tue, 30 Mar 2021 09:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=iV6sCX9X2hk1kAMEncdX18HrNbEV0YbR1UcnrSP5QxQ=; b=J7cxyCNKvNMMspOm5dbdjhDIQb
        w6T2yxDd4KZ6T+ICfWC2ifD055APOKLZ2utoTY4Dja9g9APGl+/TN/1TX63ZFmG1pGo0HnTNn5YAE
        wIDuh8+3vx0mr6lBeO54r6GevuPGXfzysUcP+H8bsZbEdieKhsGEzLA+1VJGtZhGdtkcfYByfk+xB
        rcIiirlOY7foT+bAYSk/zGKjYzk2pKVGNM8f6Ylxlde4C4usPiTZn3oQPkNwx3FrY+d/N9HSdNQfQ
        4OPPSmM31eQnJNNfAsNGBd1G7H+4SN+Zl4deij0A6h65piix5lnJFhTHuMaZk/Gks5PzK9o/Z0C9i
        jMdP9jug==;
Received: from [185.12.131.45] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lRH3o-008aKP-Tf; Tue, 30 Mar 2021 16:17:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>
Cc:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 05/15] md: refactor mddev_find_or_alloc
Date:   Tue, 30 Mar 2021 18:17:17 +0200
Message-Id: <20210330161727.2297292-6-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210330161727.2297292-1-hch@lst.de>
References: <20210330161727.2297292-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Allocate the new mddev first speculatively, which greatly simplifies
the code flow.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md.c | 60 ++++++++++++++++++++-----------------------------
 1 file changed, 24 insertions(+), 36 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 8e60bcc9c1d10c..ea9c92c113619b 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -784,57 +784,45 @@ static struct mddev *mddev_find(dev_t unit)
 
 static struct mddev *mddev_find_or_alloc(dev_t unit)
 {
-	struct mddev *mddev, *new = NULL;
+	struct mddev *mddev = NULL, *new;
 
 	if (unit && MAJOR(unit) != MD_MAJOR)
-		unit &= ~((1<<MdpMinorShift)-1);
+		unit &= ~((1 << MdpMinorShift) - 1);
 
- retry:
-	spin_lock(&all_mddevs_lock);
+	new = kzalloc(sizeof(*new), GFP_KERNEL);
+	if (!new)
+		return NULL;
+	mddev_init(new);
 
+	spin_lock(&all_mddevs_lock);
 	if (unit) {
 		mddev = mddev_find_locked(unit);
 		if (mddev) {
 			mddev_get(mddev);
-			spin_unlock(&all_mddevs_lock);
-			kfree(new);
-			return mddev;
+			goto out_free_new;
 		}
 
-		if (new) {
-			list_add(&new->all_mddevs, &all_mddevs);
-			spin_unlock(&all_mddevs_lock);
-			new->hold_active = UNTIL_IOCTL;
-			return new;
-		}
-	} else if (new) {
+		new->unit = unit;
+		if (MAJOR(unit) == MD_MAJOR)
+			new->md_minor = MINOR(unit);
+		else
+			new->md_minor = MINOR(unit) >> MdpMinorShift;
+		new->hold_active = UNTIL_IOCTL;
+	} else {
 		new->unit = mddev_alloc_unit();
-		if (!new->unit) {
-			spin_unlock(&all_mddevs_lock);
-			kfree(new);
-			return NULL;
-		}
+		if (!new->unit)
+			goto out_free_new;
 		new->md_minor = MINOR(new->unit);
 		new->hold_active = UNTIL_STOP;
-		list_add(&new->all_mddevs, &all_mddevs);
-		spin_unlock(&all_mddevs_lock);
-		return new;
 	}
-	spin_unlock(&all_mddevs_lock);
-
-	new = kzalloc(sizeof(*new), GFP_KERNEL);
-	if (!new)
-		return NULL;
 
-	new->unit = unit;
-	if (MAJOR(unit) == MD_MAJOR)
-		new->md_minor = MINOR(unit);
-	else
-		new->md_minor = MINOR(unit) >> MdpMinorShift;
-
-	mddev_init(new);
-
-	goto retry;
+	list_add(&new->all_mddevs, &all_mddevs);
+	spin_unlock(&all_mddevs_lock);
+	return new;
+out_free_new:
+	spin_unlock(&all_mddevs_lock);
+	kfree(new);
+	return mddev;
 }
 
 static struct attribute_group md_redundancy_group;
-- 
2.30.1

