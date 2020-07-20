Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228B0225606
	for <lists+linux-scsi@lfdr.de>; Mon, 20 Jul 2020 04:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgGTC6A (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 19 Jul 2020 22:58:00 -0400
Received: from smtp.infotech.no ([82.134.31.41]:42987 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbgGTC57 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 19 Jul 2020 22:57:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 5711A204259;
        Mon, 20 Jul 2020 04:57:58 +0200 (CEST)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BXsHtHzXluDp; Mon, 20 Jul 2020 04:57:56 +0200 (CEST)
Received: from xtwo70.bingwo.ca (host-45-78-251-166.dyn.295.ca [45.78.251.166])
        by smtp.infotech.no (Postfix) with ESMTPA id EE14420425C;
        Mon, 20 Jul 2020 04:57:54 +0200 (CEST)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de
Subject: [PATCH v5 9/9] scsi_host: switch ida to idr to hold shost ptr
Date:   Sun, 19 Jul 2020 22:57:42 -0400
Message-Id: <20200720025742.349296-10-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200720025742.349296-1-dgilbert@interlog.com>
References: <20200720025742.349296-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Previously the scsi_host code was using a global static "ida"
array to make sure host numbers where unique and issued in a
predictable ascending integer order. Extend that ida to an
idr array so that it can additionally hold the pointer to
the scsi_host object. This enables scsi_host_lookup() to do
a O(ln(n)) search replacing class_find_device() which is O(n).
This makes all the SCSI exported " lookup" functions O(ln(n)).

iSCSI seems to be the largest user of scsi_host_lookup().

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/hosts.c | 37 +++++++++++--------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index aebef37684e8..7734dc63606d 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -50,7 +50,7 @@ module_param_named(eh_deadline, shost_eh_deadline, int, S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(eh_deadline,
 		 "SCSI EH timeout in seconds (should be between 0 and 2^31-1)");
 
-static DEFINE_IDA(host_index_ida);
+static DEFINE_IDR(host_index_idr);	/* store index and shost pointer */
 
 
 static void scsi_host_cls_release(struct device *dev)
@@ -343,7 +343,7 @@ static void scsi_host_dev_release(struct device *dev)
 
 	kfree(shost->shost_data);
 
-	ida_simple_remove(&host_index_ida, shost->host_no);
+	idr_remove(&host_index_idr, shost->host_no);
 
 	if (parent)
 		put_device(parent);
@@ -390,8 +390,8 @@ struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *sht, int privsize)
 	init_waitqueue_head(&shost->host_wait);
 	mutex_init(&shost->scan_mutex);
 
-	index = ida_simple_get(&host_index_ida, 0, 0, GFP_KERNEL);
-	if (index < 0)
+	index = idr_alloc(&host_index_idr, shost, 0, 0, GFP_KERNEL);
+	if (unlikely(index < 0))
 		goto fail_kfree;
 	shost->host_no = index;
 
@@ -501,22 +501,13 @@ struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *sht, int privsize)
  fail_kthread:
 	kthread_stop(shost->ehandler);
  fail_index_remove:
-	ida_simple_remove(&host_index_ida, shost->host_no);
+	idr_remove(&host_index_idr, shost->host_no);
  fail_kfree:
 	kfree(shost);
 	return NULL;
 }
 EXPORT_SYMBOL(scsi_host_alloc);
 
-static int __scsi_host_match(struct device *dev, const void *data)
-{
-	struct Scsi_Host *p;
-	const unsigned short *hostnum = data;
-
-	p = class_to_shost(dev);
-	return p->host_no == *hostnum;
-}
-
 /**
  * scsi_host_lookup - get a reference to a Scsi_Host by host no
  * @hostnum:	host number to locate
@@ -525,20 +516,14 @@ static int __scsi_host_match(struct device *dev, const void *data)
  *	A pointer to located Scsi_Host or NULL.
  *
  *	The caller must do a scsi_host_put() to drop the reference
- *	that scsi_host_get() took. The put_device() below dropped
- *	the reference from class_find_device().
+ *	that scsi_host_get() took.
  **/
 struct Scsi_Host *scsi_host_lookup(unsigned short hostnum)
 {
-	struct device *cdev;
-	struct Scsi_Host *shost = NULL;
-
-	cdev = class_find_device(&shost_class, NULL, &hostnum,
-				 __scsi_host_match);
-	if (cdev) {
-		shost = scsi_host_get(class_to_shost(cdev));
-		put_device(cdev);
-	}
+	struct Scsi_Host *shost = idr_find(&host_index_idr, hostnum);
+
+	if (shost)
+		shost = scsi_host_get(shost);
 	return shost;
 }
 EXPORT_SYMBOL(scsi_host_lookup);
@@ -600,7 +585,7 @@ int scsi_init_hosts(void)
 void scsi_exit_hosts(void)
 {
 	class_unregister(&shost_class);
-	ida_destroy(&host_index_ida);
+	idr_destroy(&host_index_idr);
 }
 
 int scsi_is_host_device(const struct device *dev)
-- 
2.25.1

