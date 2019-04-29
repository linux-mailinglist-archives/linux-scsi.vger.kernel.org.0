Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86428EA09
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Apr 2019 20:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbfD2SWG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 29 Apr 2019 14:22:06 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44339 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729015AbfD2SWG (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 29 Apr 2019 14:22:06 -0400
Received: by mail-pl1-f195.google.com with SMTP id l2so2695966plt.11
        for <linux-scsi@vger.kernel.org>; Mon, 29 Apr 2019 11:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TUmgAy8958VI/A+M8UDWr1ULHTa/Ia6ALcfRur8w/gQ=;
        b=bL3mP9fKbthvJQ0scIEuPSenjNf4xC4Yo7HlQOeI9yN5ImZaVHh8V3YFULGJ8+4NAZ
         IXpsbRipVgFduoNGzL1C0ermDvveRX4P0MFJ6tEEtCHqmspxyHeDjqz82E2Z8kWJqqnT
         dY6XoETMEHu/hzx/n0/8DhbfcWmO7vVUDNVlHpqMKmuzljBD18xjOPmRlCLZR+BfQtqx
         XLbzx/FggxjKvyJmTL/cK9PsMLoHtnBsacAJo1L+CwB4I7aQamy0j+6iyDxqMsKnTtuf
         BtbvGAEr+Y+8QZAagfZmyQZG2rGYIRHIDhETPL1VjfylSXLsz84l1PJR0qnWmRqEtHq+
         wHEQ==
X-Gm-Message-State: APjAAAW/FuEUjwYw3QN16BkRs2FBiQNQ9K3y2E+zhYiL6GHL3s9o2pLl
        ybvWX45kH21M1E3T12Wezag=
X-Google-Smtp-Source: APXvYqzcpaER1R3f9AmxG3938oj35PnHBYzzxMfqTtr3rxY1/6lYabmEpMQl70SdqNoYTMgARYj9Ow==
X-Received: by 2002:a17:902:141:: with SMTP id 59mr63406842plb.132.1556562125166;
        Mon, 29 Apr 2019 11:22:05 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id z22sm35657227pgv.23.2019.04.29.11.22.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 11:22:03 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Pavel Machek <pavel@ucw.cz>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 2/2] sd: Revert "Rely on the driver core for asynchronous probing"
Date:   Mon, 29 Apr 2019 11:21:53 -0700
Message-Id: <20190429182153.206292-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190429182153.206292-1-bvanassche@acm.org>
References: <20190429182153.206292-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hibernation hangs as follows due to commit 21e6ba3f0e02 when using SATA:

Call Trace:
 __schedule+0x464/0xe70
 schedule+0x4e/0xd0
 blk_queue_enter+0x5fe/0x7e0
 generic_make_request+0x313/0x950
 submit_bio+0x9b/0x250
 submit_bio_wait+0xc9/0x110
 hib_submit_io+0x17d/0x1c0
 write_page+0x61/0xa0
 swap_write_page+0x4b/0x1f0
 swsusp_write+0x2f9/0x3d0
 hibernate.cold.10+0x108/0x231
 state_store+0xf7/0x100
 kobj_attr_store+0x37/0x50
 sysfs_kf_write+0x87/0xa0
 kernfs_fop_write+0x186/0x240
 __vfs_write+0x4d/0x90
 vfs_write+0xfa/0x260
 ksys_write+0xb9/0x1a0
 __x64_sys_write+0x43/0x50
 do_syscall_64+0x71/0x210
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Hence revert commit 21e6ba3f0e02.

Cc: Pavel Machek <pavel@ucw.cz>
Reported-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi.c      | 14 ++++++++++++++
 drivers/scsi/scsi_pm.c   | 22 ++++++++++++++++++++--
 drivers/scsi/scsi_priv.h |  3 +++
 drivers/scsi/sd.c        | 13 ++++++++++---
 4 files changed, 47 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 41b25486e303..99a7b9f520ae 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -85,6 +85,19 @@ unsigned int scsi_logging_level;
 EXPORT_SYMBOL(scsi_logging_level);
 #endif
 
+/* sd, scsi core and power management need to coordinate flushing async actions */
+ASYNC_DOMAIN(scsi_sd_probe_domain);
+EXPORT_SYMBOL(scsi_sd_probe_domain);
+
+/*
+ * Separate domain (from scsi_sd_probe_domain) to maximize the benefit of
+ * asynchronous system resume operations.  It is marked 'exclusive' to avoid
+ * being included in the async_synchronize_full() that is invoked by
+ * dpm_resume()
+ */
+ASYNC_DOMAIN_EXCLUSIVE(scsi_sd_pm_domain);
+EXPORT_SYMBOL(scsi_sd_pm_domain);
+
 /**
  * scsi_put_command - Free a scsi command block
  * @cmd: command block to free
@@ -807,6 +820,7 @@ static void __exit exit_scsi(void)
 	scsi_exit_devinfo();
 	scsi_exit_procfs();
 	scsi_exit_queue();
+	async_unregister_domain(&scsi_sd_probe_domain);
 }
 
 subsys_initcall(init_scsi);
diff --git a/drivers/scsi/scsi_pm.c b/drivers/scsi/scsi_pm.c
index 560baaad71d5..7639df91b110 100644
--- a/drivers/scsi/scsi_pm.c
+++ b/drivers/scsi/scsi_pm.c
@@ -55,6 +55,9 @@ static int scsi_dev_type_suspend(struct device *dev,
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 	int err;
 
+	/* flush pending in-flight resume operations, suspend is synchronous */
+	async_synchronize_full_domain(&scsi_sd_pm_domain);
+
 	err = scsi_device_quiesce(to_scsi_device(dev));
 	if (err == 0) {
 		err = cb(dev, pm);
@@ -151,7 +154,18 @@ static int scsi_bus_resume_common(struct device *dev,
 	else
 		fn = NULL;
 
-	if (!fn) {
+	if (fn) {
+		async_schedule_domain(fn, dev, &scsi_sd_pm_domain);
+
+		/*
+		 * If a user has disabled async probing a likely reason
+		 * is due to a storage enclosure that does not inject
+		 * staggered spin-ups.  For safety, make resume
+		 * synchronous as well in that case.
+		 */
+		if (strncmp(scsi_scan_type, "async", 5) != 0)
+			async_synchronize_full_domain(&scsi_sd_pm_domain);
+	} else {
 		pm_runtime_disable(dev);
 		pm_runtime_set_active(dev);
 		pm_runtime_enable(dev);
@@ -161,7 +175,11 @@ static int scsi_bus_resume_common(struct device *dev,
 
 static int scsi_bus_prepare(struct device *dev)
 {
-	if (scsi_is_host_device(dev)) {
+	if (scsi_is_sdev_device(dev)) {
+		/* sd probing uses async_schedule.  Wait until it finishes. */
+		async_synchronize_full_domain(&scsi_sd_probe_domain);
+
+	} else if (scsi_is_host_device(dev)) {
 		/* Wait until async scanning is finished */
 		scsi_complete_async_scans();
 	}
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index b1edf15704c0..5f21547b2ad2 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -174,6 +174,9 @@ static inline int scsi_autopm_get_host(struct Scsi_Host *h) { return 0; }
 static inline void scsi_autopm_put_host(struct Scsi_Host *h) {}
 #endif /* CONFIG_PM */
 
+extern struct async_domain scsi_sd_pm_domain;
+extern struct async_domain scsi_sd_probe_domain;
+
 /* scsi_dh.c */
 #ifdef CONFIG_SCSI_DH
 void scsi_dh_add_device(struct scsi_device *sdev);
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index f29c0ca8a5f1..2b2bc4b49d78 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -567,7 +567,6 @@ static struct scsi_driver sd_template = {
 		.name		= "sd",
 		.owner		= THIS_MODULE,
 		.probe		= sd_probe,
-		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 		.remove		= sd_remove,
 		.shutdown	= sd_shutdown,
 		.pm		= &sd_pm_ops,
@@ -3285,8 +3284,12 @@ static int sd_format_disk_name(char *prefix, int index, char *buf, int buflen)
 	return 0;
 }
 
-static void sd_probe_part2(struct scsi_disk *sdkp)
+/*
+ * The asynchronous part of sd_probe
+ */
+static void sd_probe_async(void *data, async_cookie_t cookie)
 {
+	struct scsi_disk *sdkp = data;
 	struct scsi_device *sdp;
 	struct gendisk *gd;
 	u32 index;
@@ -3340,6 +3343,7 @@ static void sd_probe_part2(struct scsi_disk *sdkp)
 	sd_printk(KERN_NOTICE, sdkp, "Attached SCSI %sdisk\n",
 		  sdp->removable ? "removable " : "");
 	scsi_autopm_put_device(sdp);
+	put_device(&sdkp->dev);
 }
 
 /**
@@ -3431,7 +3435,8 @@ static int sd_probe(struct device *dev)
 	get_device(dev);
 	dev_set_drvdata(dev, sdkp);
 
-	sd_probe_part2(sdkp);
+	get_device(&sdkp->dev);	/* prevent release before async_schedule */
+	async_schedule_domain(sd_probe_async, sdkp, &scsi_sd_probe_domain);
 
 	return 0;
 
@@ -3466,6 +3471,8 @@ static int sd_remove(struct device *dev)
 	devt = disk_devt(sdkp->disk);
 	scsi_autopm_get_device(sdkp->device);
 
+	async_synchronize_full_domain(&scsi_sd_pm_domain);
+	async_synchronize_full_domain(&scsi_sd_probe_domain);
 	device_del(&sdkp->dev);
 	del_gendisk(sdkp->disk);
 	sd_shutdown(dev);
-- 
2.21.0.196.g041f5ea1cf98

