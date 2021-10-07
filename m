Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6CD425E80
	for <lists+linux-scsi@lfdr.de>; Thu,  7 Oct 2021 23:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234018AbhJGVU5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 7 Oct 2021 17:20:57 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:45628 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbhJGVU5 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 7 Oct 2021 17:20:57 -0400
Received: by mail-pj1-f44.google.com with SMTP id ls14-20020a17090b350e00b001a00e2251c8so6188150pjb.4
        for <linux-scsi@vger.kernel.org>; Thu, 07 Oct 2021 14:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kt2zmEnNC8kSXDLhEYevleO6rodk/ecgntNNeLHdi2w=;
        b=qwe7ZbmLgBLQEUmW2l5z1F3ZcWeos9bmt6rYnQwaNjxov+IdUwVxrJ1g4OweECVMkm
         +kZ5wxj610IJhCjkOW2nV88CKom8zPDrRQlvNe4xbtm+ZAGlnigh6+bCUb+baaMKzdno
         HeYDDmxFILmw1jlTFGfdREFVIv7k8Wwy28LMHds9T8FZNaQzfqzo8iYbEh72jXStXMlV
         9Nu9uZ6mB6F7ptTpGe7UGR7nYHS+f6mMzVUfAxNoQP1m1trmugPq8pZ0daLq0WzuHDta
         eOis2pslxdCkt/rwzAAP0GpJEDDUdvckoGGlnMCjbK0J43fpVD+a8+hzQLF9QiXUl/Pb
         DVWw==
X-Gm-Message-State: AOAM5334uhiKtPpRKuNN47EidEfLUs10GOySi0nghuYKXTSoP7+PoHMP
        jmSOgvnFVVBqjh97rSoOrC4=
X-Google-Smtp-Source: ABdhPJzGNFte1mriNFCUpldNsgtmi4PP8YXRxEgeAT/N5tN7xccSYtW08jG5nYMKujQqZxWMKadeZQ==
X-Received: by 2002:a17:902:7c8d:b0:13a:768b:d6c0 with SMTP id y13-20020a1709027c8d00b0013a768bd6c0mr6024177pll.83.1633641542615;
        Thu, 07 Oct 2021 14:19:02 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ae88:8f16:b90b:5f1d])
        by smtp.gmail.com with ESMTPSA id o2sm243290pgc.47.2021.10.07.14.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 14:19:02 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v2 01/46] scsi: core: Register sysfs attributes earlier
Date:   Thu,  7 Oct 2021 14:18:07 -0700
Message-Id: <20211007211852.256007-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
In-Reply-To: <20211007211852.256007-1-bvanassche@acm.org>
References: <20211007211852.256007-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

A quote from Documentation/driver-api/driver-model/device.rst:
"Word of warning:  While the kernel allows device_create_file() and
device_remove_file() to be called on a device at any time, userspace has
strict expectations on when attributes get created.  When a new device is
registered in the kernel, a uevent is generated to notify userspace (like
udev) that a new device is available.  If attributes are added after the
device is registered, then userspace won't get notified and userspace will
not know about the new attributes."

Hence register SCSI host sysfs attributes before the SCSI host shost_dev
uevent is emitted instead of after that event has been emitted.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/hosts.c       | 23 ++++++++++-
 drivers/scsi/scsi_priv.h   |  4 +-
 drivers/scsi/scsi_sysfs.c  | 81 +++++++++++++++++++-------------------
 include/scsi/scsi_device.h |  7 ++++
 include/scsi/scsi_host.h   | 12 ++++++
 5 files changed, 84 insertions(+), 43 deletions(-)

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index 3f6f14f0cafb..3443f009a9e8 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -376,7 +376,7 @@ static struct device_type scsi_host_type = {
 struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *sht, int privsize)
 {
 	struct Scsi_Host *shost;
-	int index;
+	int index, i, j = 0;
 
 	shost = kzalloc(sizeof(struct Scsi_Host) + privsize, GFP_KERNEL);
 	if (!shost)
@@ -480,7 +480,26 @@ struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *sht, int privsize)
 	shost->shost_dev.parent = &shost->shost_gendev;
 	shost->shost_dev.class = &shost_class;
 	dev_set_name(&shost->shost_dev, "host%d", shost->host_no);
-	shost->shost_dev.groups = scsi_sysfs_shost_attr_groups;
+	shost->shost_dev.groups = shost->shost_dev_attr_groups;
+	shost->shost_dev_attr_groups[j++] = &scsi_shost_attr_group;
+	if (sht->shost_attrs) {
+		shost->lld_attr_group = (struct attribute_group){
+			.attrs = scsi_convert_dev_attrs(&shost->shost_gendev,
+							sht->shost_attrs)
+		};
+		if (shost->lld_attr_group.attrs)
+			shost->shost_dev_attr_groups[j++] =
+				&shost->lld_attr_group;
+	}
+	if (sht->shost_groups) {
+		for (i = 0; sht->shost_groups[i] &&
+			     j < ARRAY_SIZE(shost->shost_dev_attr_groups);
+		     i++, j++) {
+			shost->shost_dev_attr_groups[j] =
+				sht->shost_groups[i];
+		}
+	}
+	WARN_ON_ONCE(j >= ARRAY_SIZE(shost->shost_dev_attr_groups));
 
 	shost->ehandler = kthread_run(scsi_error_handler, shost,
 			"scsi_eh_%d", shost->host_no);
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 6d9152031a40..a5a2f18cc734 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -137,13 +137,15 @@ extern int scsi_sysfs_add_sdev(struct scsi_device *);
 extern int scsi_sysfs_add_host(struct Scsi_Host *);
 extern int scsi_sysfs_register(void);
 extern void scsi_sysfs_unregister(void);
+struct attribute **scsi_convert_dev_attrs(struct device *dev,
+					  struct device_attribute **dev_attr);
 extern void scsi_sysfs_device_initialize(struct scsi_device *);
 extern int scsi_sysfs_target_initialize(struct scsi_device *);
 extern struct scsi_transport_template blank_transport_template;
 extern void __scsi_remove_device(struct scsi_device *);
 
 extern struct bus_type scsi_bus_type;
-extern const struct attribute_group *scsi_sysfs_shost_attr_groups[];
+extern const struct attribute_group scsi_shost_attr_group;
 
 /* scsi_netlink.c */
 #ifdef CONFIG_SCSI_NETLINK
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 86793259e541..05b4d69d53d4 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -424,15 +424,10 @@ static struct attribute *scsi_sysfs_shost_attrs[] = {
 	NULL
 };
 
-static struct attribute_group scsi_shost_attr_group = {
+const struct attribute_group scsi_shost_attr_group = {
 	.attrs =	scsi_sysfs_shost_attrs,
 };
 
-const struct attribute_group *scsi_sysfs_shost_attr_groups[] = {
-	&scsi_shost_attr_group,
-	NULL
-};
-
 static void scsi_device_cls_release(struct device *class_dev)
 {
 	struct scsi_device *sdev;
@@ -1333,7 +1328,7 @@ static int scsi_target_add(struct scsi_target *starget)
  **/
 int scsi_sysfs_add_sdev(struct scsi_device *sdev)
 {
-	int error, i;
+	int error;
 	struct scsi_target *starget = sdev->sdev_target;
 
 	error = scsi_target_add(starget);
@@ -1386,23 +1381,6 @@ int scsi_sysfs_add_sdev(struct scsi_device *sdev)
 		}
 	}
 
-	/* add additional host specific attributes */
-	if (sdev->host->hostt->sdev_attrs) {
-		for (i = 0; sdev->host->hostt->sdev_attrs[i]; i++) {
-			error = device_create_file(&sdev->sdev_gendev,
-					sdev->host->hostt->sdev_attrs[i]);
-			if (error)
-				return error;
-		}
-	}
-
-	if (sdev->host->hostt->sdev_groups) {
-		error = sysfs_create_groups(&sdev->sdev_gendev.kobj,
-				sdev->host->hostt->sdev_groups);
-		if (error)
-			return error;
-	}
-
 	scsi_autopm_put_device(sdev);
 	return error;
 }
@@ -1442,10 +1420,6 @@ void __scsi_remove_device(struct scsi_device *sdev)
 		if (res != 0)
 			return;
 
-		if (sdev->host->hostt->sdev_groups)
-			sysfs_remove_groups(&sdev->sdev_gendev.kobj,
-					sdev->host->hostt->sdev_groups);
-
 		if (IS_ENABLED(CONFIG_BLK_DEV_BSG) && sdev->bsg_dev)
 			bsg_unregister_queue(sdev->bsg_dev);
 		device_unregister(&sdev->sdev_dev);
@@ -1584,23 +1558,31 @@ EXPORT_SYMBOL(scsi_register_interface);
  **/
 int scsi_sysfs_add_host(struct Scsi_Host *shost)
 {
-	int error, i;
-
-	/* add host specific attributes */
-	if (shost->hostt->shost_attrs) {
-		for (i = 0; shost->hostt->shost_attrs[i]; i++) {
-			error = device_create_file(&shost->shost_dev,
-					shost->hostt->shost_attrs[i]);
-			if (error)
-				return error;
-		}
-	}
-
 	transport_register_device(&shost->shost_gendev);
 	transport_configure_device(&shost->shost_gendev);
 	return 0;
 }
 
+/*
+ * Convert an array of struct device_attribute pointers into an array of
+ * struct attribute pointers.
+ */
+struct attribute **scsi_convert_dev_attrs(struct device *dev,
+					  struct device_attribute **dev_attr)
+{
+	struct attribute **attrs;
+	int i;
+
+	for (i = 0; dev_attr[i]; i++)
+		;
+	attrs = devm_kzalloc(dev, (i + 1) * sizeof(*attrs), GFP_KERNEL);
+	if (!attrs)
+		return NULL;
+	for (i = 0; dev_attr[i]; i++)
+		attrs[i] = &dev_attr[i]->attr;
+	return attrs;
+}
+
 static struct device_type scsi_dev_type = {
 	.name =		"scsi_device",
 	.release =	scsi_device_dev_release,
@@ -1609,8 +1591,10 @@ static struct device_type scsi_dev_type = {
 
 void scsi_sysfs_device_initialize(struct scsi_device *sdev)
 {
+	int i, j = 0;
 	unsigned long flags;
 	struct Scsi_Host *shost = sdev->host;
+	struct scsi_host_template *hostt = shost->hostt;
 	struct scsi_target  *starget = sdev->sdev_target;
 
 	device_initialize(&sdev->sdev_gendev);
@@ -1618,6 +1602,23 @@ void scsi_sysfs_device_initialize(struct scsi_device *sdev)
 	sdev->sdev_gendev.type = &scsi_dev_type;
 	dev_set_name(&sdev->sdev_gendev, "%d:%d:%d:%llu",
 		     sdev->host->host_no, sdev->channel, sdev->id, sdev->lun);
+	sdev->gendev_attr_groups[j++] = &scsi_sdev_attr_group;
+	if (hostt->sdev_attrs) {
+		sdev->lld_attr_group = (struct attribute_group){
+			.attrs = scsi_convert_dev_attrs(&sdev->sdev_gendev,
+							hostt->sdev_attrs)
+		};
+		if (sdev->lld_attr_group.attrs)
+			sdev->gendev_attr_groups[j++] = &sdev->lld_attr_group;
+	}
+	if (hostt->sdev_groups) {
+		for (i = 0; hostt->sdev_groups[i] &&
+			     j < ARRAY_SIZE(sdev->gendev_attr_groups);
+		     i++, j++) {
+			sdev->gendev_attr_groups[j] = hostt->sdev_groups[i];
+		}
+	}
+	WARN_ON_ONCE(j >= ARRAY_SIZE(sdev->gendev_attr_groups));
 
 	device_initialize(&sdev->sdev_dev);
 	sdev->sdev_dev.parent = get_device(&sdev->sdev_gendev);
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index b97e142a7ca9..01732aabd7c3 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -225,6 +225,13 @@ struct scsi_device {
 
 	struct device		sdev_gendev,
 				sdev_dev;
+	struct attribute_group	lld_attr_group;
+	/*
+	 * The array size 6 provides space for one attribute group for the
+	 * SCSI core, four attribute groups defined by SCSI LLDs and one
+	 * terminating NULL pointer.
+	 */
+	const struct attribute_group *gendev_attr_groups[6];
 
 	struct execute_work	ew; /* used to get process context on put */
 	struct work_struct	requeue_work;
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index bc9c45ced145..ab8775811e6f 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -483,6 +483,11 @@ struct scsi_host_template {
 	 */
 	struct device_attribute **sdev_attrs;
 
+	/*
+	 * Pointer to the SCSI host sysfs attribute groups, NULL terminated.
+	 */
+	const struct attribute_group **shost_groups;
+
 	/*
 	 * Pointer to the SCSI device attribute groups for this host,
 	 * NULL terminated.
@@ -695,6 +700,13 @@ struct Scsi_Host {
 
 	/* ldm bits */
 	struct device		shost_gendev, shost_dev;
+	struct attribute_group	lld_attr_group;
+	/*
+	 * The array size 3 provides space for one attribute group defined by
+	 * the SCSI core, one attribute group defined by the SCSI LLD and one
+	 * terminating NULL pointer.
+	 */
+	const struct attribute_group *shost_dev_attr_groups[3];
 
 	/*
 	 * Points to the transport data (if any) which is allocated
