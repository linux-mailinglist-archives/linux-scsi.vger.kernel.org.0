Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93AB3C43A1
	for <lists+linux-scsi@lfdr.de>; Mon, 12 Jul 2021 07:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbhGLFz1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 12 Jul 2021 01:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhGLFz0 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 12 Jul 2021 01:55:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CF4C0613DD;
        Sun, 11 Jul 2021 22:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=fo3kNG7b55xaIkyx+YG36Cj/Alt4VuwOsi2pzRZrHB4=; b=BTcwuxlMqj9imJvf32IRsYQSXn
        rLM/SRHMzPnoB6C/CSpYJhwm9veSKoKaZntLqAnBinQdN3tfJou/6qGgsjmIHMt2TFQBY5tMVd/rG
        PD4d2xO6oV6oY6kcuqxnPipTSwgdEamXnm5XCM35xKA5ytmtqkDUdmptezQ4h9jWojjEPyByEK9oP
        iMm50OBx9w7+XMFEdw46HNFr+vDMKUXmvCi5D6zTh3cRO3uACAYhzVCGMkXrctwDufpQz+HmdiNt0
        90SD91/+DkPIIbS5FZW7k3QRXESQfDMyNd5PMf/Ud1kRGHGJ/DUJ6bEIIQ+B99xsa4O2gSeGnq0qI
        BaTN7BCw==;
Received: from [2001:4bb8:184:8b7c:bd9:61b8:39ba:d78a] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m2orI-00GvCV-LJ; Mon, 12 Jul 2021 05:52:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc:     Doug Gilbert <dgilbert@interlog.com>,
        =?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 08/24] cdrom: remove the call to scsi_cmd_blk_ioctl from cdrom_ioctl
Date:   Mon, 12 Jul 2021 07:48:00 +0200
Message-Id: <20210712054816.4147559-9-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210712054816.4147559-1-hch@lst.de>
References: <20210712054816.4147559-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Only the sr driver can handle SCSI passthrough requests, so move the
call to scsi_cmd_blk_ioctl there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/Kconfig        | 1 -
 drivers/block/paride/Kconfig | 1 -
 drivers/cdrom/cdrom.c        | 7 -------
 drivers/scsi/sr.c            | 3 +++
 4 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 63056cfd4b62..4652bcdb9efb 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -74,7 +74,6 @@ config N64CART
 
 config CDROM
 	tristate
-	select BLK_SCSI_REQUEST
 
 config GDROM
 	tristate "SEGA Dreamcast GD-ROM drive"
diff --git a/drivers/block/paride/Kconfig b/drivers/block/paride/Kconfig
index 7c6ae1036927..a295634597ba 100644
--- a/drivers/block/paride/Kconfig
+++ b/drivers/block/paride/Kconfig
@@ -27,7 +27,6 @@ config PARIDE_PCD
 	tristate "Parallel port ATAPI CD-ROMs"
 	depends on PARIDE
 	select CDROM
-	select BLK_SCSI_REQUEST # only for the generic cdrom code
 	help
 	  This option enables the high-level driver for ATAPI CD-ROM devices
 	  connected through a parallel port. If you chose to build PARIDE
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index feb827eefd1a..8882b311bafd 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -3357,13 +3357,6 @@ int cdrom_ioctl(struct cdrom_device_info *cdi, struct block_device *bdev,
 	void __user *argp = (void __user *)arg;
 	int ret;
 
-	/*
-	 * Try the generic SCSI command ioctl's first.
-	 */
-	ret = scsi_cmd_blk_ioctl(bdev, mode, cmd, argp);
-	if (ret != -ENOTTY)
-		return ret;
-
 	switch (cmd) {
 	case CDROMMULTISESSION:
 		return cdrom_ioctl_multisession(cdi, argp);
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index c5e163a659d2..7948416f40d5 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -579,6 +579,9 @@ static int sr_block_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 	case SCSI_IOCTL_GET_BUS_NUMBER:
 		break;
 	default:
+		ret = scsi_cmd_blk_ioctl(bdev, mode, cmd, argp);
+		if (ret != -ENOTTY)
+			goto put;
 		ret = cdrom_ioctl(&cd->cdi, bdev, mode, cmd, arg);
 		if (ret != -ENOSYS)
 			goto put;
-- 
2.30.2

