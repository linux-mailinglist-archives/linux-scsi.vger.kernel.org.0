Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41B420A086
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Jun 2020 16:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405331AbgFYOCF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 25 Jun 2020 10:02:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:41294 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405299AbgFYOBu (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 25 Jun 2020 10:01:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D473AAF2D;
        Thu, 25 Jun 2020 14:01:45 +0000 (UTC)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microchip.de>,
        Bart van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 10/22] scsi: Use dummy inquiry data for the host device
Date:   Thu, 25 Jun 2020 16:01:12 +0200
Message-Id: <20200625140124.17201-11-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200625140124.17201-1-hare@suse.de>
References: <20200625140124.17201-1-hare@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Attach the dummy inquiry data to the scsi host device and use it
to check if any given device is a scsi host device.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/scsi_scan.c  | 17 +++++++++++++++--
 drivers/scsi/scsi_sysfs.c |  3 ++-
 include/scsi/scsi_host.h  |  7 ++++---
 3 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 871c7609c159..34470605fd0a 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -1920,9 +1920,11 @@ struct scsi_device *scsi_get_host_dev(struct Scsi_Host *shost)
 		goto out;
 
 	sdev = scsi_alloc_sdev(starget, 0, NULL);
-	if (sdev)
+	if (sdev) {
 		sdev->borken = 0;
-	else
+		sdev->inquiry = (unsigned char *)scsi_null_inquiry;
+		sdev->inquiry_len = sizeof(scsi_null_inquiry);
+	} else
 		scsi_target_reap(starget);
 	put_device(&starget->dev);
  out:
@@ -1947,3 +1949,14 @@ void scsi_free_host_dev(struct scsi_device *sdev)
 }
 EXPORT_SYMBOL(scsi_free_host_dev);
 
+/**
+ * scsi_device_is_host_dev - Check if a scsi device is a host device
+ * @sdev: SCSI device to test
+ *
+ * Returns: true if @sdev is a host device, false otherwise
+ */
+bool scsi_device_is_host_dev(struct scsi_device *sdev)
+{
+	return ((const unsigned char *)sdev->inquiry == scsi_null_inquiry);
+}
+EXPORT_SYMBOL_GPL(scsi_device_is_host_dev);
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 163dbcb741c1..eeed2fcf9510 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -485,7 +485,8 @@ static void scsi_device_dev_release_usercontext(struct work_struct *work)
 		kfree_rcu(vpd_pg80, rcu);
 	if (vpd_pg89)
 		kfree_rcu(vpd_pg89, rcu);
-	kfree(sdev->inquiry);
+	if (!scsi_device_is_host_dev(sdev))
+		kfree(sdev->inquiry);
 	kfree(sdev);
 
 	if (parent)
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index b94938e87e3a..a6a11fe9bbc0 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -786,14 +786,15 @@ void scsi_host_busy_iter(struct Scsi_Host *,
 struct class_container;
 
 /*
- * These two functions are used to allocate and free a pseudo device
- * which will connect to the host adapter itself rather than any
- * physical device.  You must deallocate when you are done with the
+ * These three functions are used to allocate, free, and test for
+ * a pseudo device which will connect to the host adapter itself rather
+ * than any physical device.  You must deallocate when you are done with the
  * thing.  This physical pseudo-device isn't real and won't be available
  * from any high-level drivers.
  */
 extern void scsi_free_host_dev(struct scsi_device *);
 extern struct scsi_device *scsi_get_host_dev(struct Scsi_Host *);
+bool scsi_device_is_host_dev(struct scsi_device *);
 
 /*
  * DIF defines the exchange of protection information between
-- 
2.16.4

