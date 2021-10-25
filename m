Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F14439C98
	for <lists+linux-scsi@lfdr.de>; Mon, 25 Oct 2021 19:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbhJYREL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 25 Oct 2021 13:04:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234269AbhJYRDN (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 25 Oct 2021 13:03:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F40B261057;
        Mon, 25 Oct 2021 17:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635181251;
        bh=0EWXByH+MFNX7pjECu4ivLrBLdXZwqkSFX84O4pnqSY=;
        h=From:To:Cc:Subject:Date:From;
        b=EVcjFToDSwu0/31Mv/c0NPU1pOzicCQG1lUmgo7gwOvgzZ/Up2BIOXJWvCwWItSjt
         FE1IFCN78cSpaWy1RCDCKv5wGfk49nFkxXAv00uPzd6xc2dK0fxfEZljHkVcZbuq3U
         5b9aJYw27FoqyMbuRaGVbWitzpRkcpr3zvS1yFAIZNAc3OwcsbOd2sdrp9Cc+NmVxc
         17t5ubWK1NiaEHiMkhmRFDyRWhG5ch67aaPBvdahjErLgJJ6t0H1E6S0WlaxFUU18Z
         9EMk+Go4Bg8x46ZopRaXy41CQe47dFDsUUiI6Lfp/gM/2gsF6ivHqVGJSLlLYOxQC4
         OrxdOLO7gQlAA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Changhui Zhong <czhong@redhat.com>,
        Yi Zhang <yi.zhang@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 1/9] scsi: core: Put LLD module refcnt after SCSI device is released
Date:   Mon, 25 Oct 2021 13:00:40 -0400
Message-Id: <20211025170048.1394542-1-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit f2b85040acec9a928b4eb1b57a989324e8e38d3f ]

SCSI host release is triggered when SCSI device is freed. We have to make
sure that the low-level device driver module won't be unloaded before SCSI
host instance is released because shost->hostt is required in the release
handler.

Make sure to put LLD module refcnt after SCSI device is released.

Fixes a kernel panic of 'BUG: unable to handle page fault for address'
reported by Changhui and Yi.

Link: https://lore.kernel.org/r/20211008050118.1440686-1-ming.lei@redhat.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reported-by: Changhui Zhong <czhong@redhat.com>
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/scsi.c       | 4 +++-
 drivers/scsi/scsi_sysfs.c | 9 +++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 1f5b5c8a7f72..1ce3f90f782f 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -555,8 +555,10 @@ EXPORT_SYMBOL(scsi_device_get);
  */
 void scsi_device_put(struct scsi_device *sdev)
 {
-	module_put(sdev->host->hostt->module);
+	struct module *mod = sdev->host->hostt->module;
+
 	put_device(&sdev->sdev_gendev);
+	module_put(mod);
 }
 EXPORT_SYMBOL(scsi_device_put);
 
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 6aeb79e744e0..12064ce76777 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -438,9 +438,12 @@ static void scsi_device_dev_release_usercontext(struct work_struct *work)
 	struct list_head *this, *tmp;
 	struct scsi_vpd *vpd_pg80 = NULL, *vpd_pg83 = NULL;
 	unsigned long flags;
+	struct module *mod;
 
 	sdev = container_of(work, struct scsi_device, ew.work);
 
+	mod = sdev->host->hostt->module;
+
 	scsi_dh_release_device(sdev);
 
 	parent = sdev->sdev_gendev.parent;
@@ -481,11 +484,17 @@ static void scsi_device_dev_release_usercontext(struct work_struct *work)
 
 	if (parent)
 		put_device(parent);
+	module_put(mod);
 }
 
 static void scsi_device_dev_release(struct device *dev)
 {
 	struct scsi_device *sdp = to_scsi_device(dev);
+
+	/* Set module pointer as NULL in case of module unloading */
+	if (!try_module_get(sdp->host->hostt->module))
+		sdp->host->hostt->module = NULL;
+
 	execute_in_process_context(scsi_device_dev_release_usercontext,
 				   &sdp->ew);
 }
-- 
2.33.0

