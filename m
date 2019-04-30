Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 352FD101ED
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Apr 2019 23:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfD3Vj3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 30 Apr 2019 17:39:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33588 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfD3Vj2 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 30 Apr 2019 17:39:28 -0400
Received: by mail-pg1-f194.google.com with SMTP id k19so7461790pgh.0
        for <linux-scsi@vger.kernel.org>; Tue, 30 Apr 2019 14:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n89y6uCweejceG0PyPvn60VcWvTyT1rqrfzI2gNhFO4=;
        b=DLyiSBq4W1/s3OTNUkV7xoYk7MkZD6RH09P0mnvZ+0eB+EfX/4E/FAYmkEGihLooNe
         1Ri76jt0Gr278bYWGsKHjAnxxqosRZ9UsVV9dbKkN80Jh+zA+vxCMKGU+9g3UxfwbsB7
         3vhZ577GhKoQjcY3kHSlBncBs4OnHd3ljvOuv3SfnSm1+sWBWCzuDbgsYCzl27kyHd+5
         m94JY2bmn+ilPqAtpo66+IoN29k59x3hVvyYzEK0ALS7J3YfINABsQzNN995u5/szD2D
         1RtBqQlHv3TX8yAqxG1OEV6F0aZyC8gfyXST5Ap7siPwvnrs1lKdzaux+gOd/XJVEbCP
         tkfA==
X-Gm-Message-State: APjAAAU96wY4BsmCwnu5vdtkiuLw9R9qTac5Na9lZGblEZT/mKCgfBqp
        hjbyj6C22g4Mxmkq2JnZ0no=
X-Google-Smtp-Source: APXvYqzKBd4bddxDvCFx7OpVKXdv2kLzGPyik1r3V5aSTkSbuxhe9LKldkbcbeWUjHyrlrjpe8JWFQ==
X-Received: by 2002:a65:62c3:: with SMTP id m3mr42960670pgv.159.1556660367810;
        Tue, 30 Apr 2019 14:39:27 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id h4sm39379820pgv.61.2019.04.30.14.39.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 14:39:27 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Pavel Machek <pavel@ucw.cz>,
        Bart Van Assche <bvanassche@acm.org>,
        Lee Duncan <lduncan@suse.com>, Hannes Reinecke <hare@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 1/2] sd: Rely on the driver core for asynchronous probing
Date:   Tue, 30 Apr 2019 14:39:18 -0700
Message-Id: <20190430213919.97437-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190430213919.97437-1-bvanassche@acm.org>
References: <20190430213919.97437-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

As explained during the 2018 LSF/MM session about increasing SCSI disk
probing concurrency, the problems with the current probing approach are as
follows:

- The driver core is unaware of asynchronous SCSI LUN probing.
  wait_for_device_probe() waits for all asynchronous probes except
  asynchronous SCSI disk probes.

- There is unnecessary serialization between sd_probe() and sd_remove().
  This can lead to a deadlock.

Hence this patch that modifies the sd driver such that it uses the driver
core framework for asynchronous probing. The async domain and
get_device()/put_device() pairs that became superfluous due to this change
are removed.

This patch does not affect the time needed for loading the scsi_debug
kernel module with parameters delay=0 and max_luns=256.

This patch depends on commit ef0ff68351be ("driver core: Probe devices
asynchronously instead of the driver") that went upstream in kernel version
v5.1-rc1.

Cc: Lee Duncan <lduncan@suse.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi.c      | 12 +++---------
 drivers/scsi/scsi_pm.c   |  6 +-----
 drivers/scsi/scsi_priv.h |  1 -
 drivers/scsi/sd.c        | 12 +++---------
 4 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 99a7b9f520ae..f5cd632606cf 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -85,15 +85,10 @@ unsigned int scsi_logging_level;
 EXPORT_SYMBOL(scsi_logging_level);
 #endif
 
-/* sd, scsi core and power management need to coordinate flushing async actions */
-ASYNC_DOMAIN(scsi_sd_probe_domain);
-EXPORT_SYMBOL(scsi_sd_probe_domain);
-
 /*
- * Separate domain (from scsi_sd_probe_domain) to maximize the benefit of
- * asynchronous system resume operations.  It is marked 'exclusive' to avoid
- * being included in the async_synchronize_full() that is invoked by
- * dpm_resume()
+ * Domain for asynchronous system resume operations.  It is marked 'exclusive'
+ * to avoid being included in the async_synchronize_full() that is invoked by
+ * dpm_resume().
  */
 ASYNC_DOMAIN_EXCLUSIVE(scsi_sd_pm_domain);
 EXPORT_SYMBOL(scsi_sd_pm_domain);
@@ -820,7 +815,6 @@ static void __exit exit_scsi(void)
 	scsi_exit_devinfo();
 	scsi_exit_procfs();
 	scsi_exit_queue();
-	async_unregister_domain(&scsi_sd_probe_domain);
 }
 
 subsys_initcall(init_scsi);
diff --git a/drivers/scsi/scsi_pm.c b/drivers/scsi/scsi_pm.c
index 7639df91b110..bc8c72a6356d 100644
--- a/drivers/scsi/scsi_pm.c
+++ b/drivers/scsi/scsi_pm.c
@@ -175,11 +175,7 @@ static int scsi_bus_resume_common(struct device *dev,
 
 static int scsi_bus_prepare(struct device *dev)
 {
-	if (scsi_is_sdev_device(dev)) {
-		/* sd probing uses async_schedule.  Wait until it finishes. */
-		async_synchronize_full_domain(&scsi_sd_probe_domain);
-
-	} else if (scsi_is_host_device(dev)) {
+	if (scsi_is_host_device(dev)) {
 		/* Wait until async scanning is finished */
 		scsi_complete_async_scans();
 	}
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 5f21547b2ad2..cc2859d76d81 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -175,7 +175,6 @@ static inline void scsi_autopm_put_host(struct Scsi_Host *h) {}
 #endif /* CONFIG_PM */
 
 extern struct async_domain scsi_sd_pm_domain;
-extern struct async_domain scsi_sd_probe_domain;
 
 /* scsi_dh.c */
 #ifdef CONFIG_SCSI_DH
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 2b2bc4b49d78..ae6634885afe 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -567,6 +567,7 @@ static struct scsi_driver sd_template = {
 		.name		= "sd",
 		.owner		= THIS_MODULE,
 		.probe		= sd_probe,
+		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 		.remove		= sd_remove,
 		.shutdown	= sd_shutdown,
 		.pm		= &sd_pm_ops,
@@ -3284,12 +3285,8 @@ static int sd_format_disk_name(char *prefix, int index, char *buf, int buflen)
 	return 0;
 }
 
-/*
- * The asynchronous part of sd_probe
- */
-static void sd_probe_async(void *data, async_cookie_t cookie)
+static void sd_probe_part2(struct scsi_disk *sdkp)
 {
-	struct scsi_disk *sdkp = data;
 	struct scsi_device *sdp;
 	struct gendisk *gd;
 	u32 index;
@@ -3343,7 +3340,6 @@ static void sd_probe_async(void *data, async_cookie_t cookie)
 	sd_printk(KERN_NOTICE, sdkp, "Attached SCSI %sdisk\n",
 		  sdp->removable ? "removable " : "");
 	scsi_autopm_put_device(sdp);
-	put_device(&sdkp->dev);
 }
 
 /**
@@ -3435,8 +3431,7 @@ static int sd_probe(struct device *dev)
 	get_device(dev);
 	dev_set_drvdata(dev, sdkp);
 
-	get_device(&sdkp->dev);	/* prevent release before async_schedule */
-	async_schedule_domain(sd_probe_async, sdkp, &scsi_sd_probe_domain);
+	sd_probe_part2(sdkp);
 
 	return 0;
 
@@ -3472,7 +3467,6 @@ static int sd_remove(struct device *dev)
 	scsi_autopm_get_device(sdkp->device);
 
 	async_synchronize_full_domain(&scsi_sd_pm_domain);
-	async_synchronize_full_domain(&scsi_sd_probe_domain);
 	device_del(&sdkp->dev);
 	del_gendisk(sdkp->disk);
 	sd_shutdown(dev);
-- 
2.21.0.196.g041f5ea1cf98

