Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715C742722D
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Oct 2021 22:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242800AbhJHU1b (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 8 Oct 2021 16:27:31 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:36659 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243027AbhJHU10 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 8 Oct 2021 16:27:26 -0400
Received: by mail-pl1-f172.google.com with SMTP id k8so1440564pls.3
        for <linux-scsi@vger.kernel.org>; Fri, 08 Oct 2021 13:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zRZkSfeTymcwyw907t2wyI9vj50Y1Nohnx58Np7XFFM=;
        b=v13ZVOHjasySoqJNj7X7bCUj+8QtdSRLzw+rwxS/oTwqn95FY0W6kL11Gf+IcWC6Dx
         iDDVTKXxbyYF1YzwMitAVQX6lxmidRqpLvIkJNpTt4yqTG+dnMoVKsX9zxvSiLKP/N4X
         06cL6KGxzKv2RS4HeOp3lXgAfbq2CbluQEMg1QxNy9jOCErgKjO2Jsiu5KDsvAJQQJUg
         4mPq1j0m3Vzem/zgXbqRIBzYYNPAkwBiEAW4fXc9rBDn/engcKBvr2j/tg8EqZRfl502
         ZWEKogq+x3kpoXH1ZNaYkvSiMMvnh9CbJi+JqVuUkn0cdcFM+RSj1IC3NGr+NPpQSBGn
         qpxg==
X-Gm-Message-State: AOAM531oLGbbdIdKHxofBRfeUv0AAR4SEL9hZvSLNZki0TEo2WbhDO94
        /TwcrvConoIE9btkKJ5L1Fg=
X-Google-Smtp-Source: ABdhPJyTQUnStKDmFdL5TtxVzyzh7/7v9BYbkRL6Rek436WPLC9J5HfEjEGGQM1+Hpp1d3yRyKWgYg==
X-Received: by 2002:a17:90a:1a4c:: with SMTP id 12mr14739504pjl.89.1633724731017;
        Fri, 08 Oct 2021 13:25:31 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:a8e9:7950:57f8:970])
        by smtp.gmail.com with ESMTPSA id x21sm170858pfa.186.2021.10.08.13.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 13:25:30 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v3 46/46] scsi: core: Remove two host template members that are no longer used
Date:   Fri,  8 Oct 2021 13:23:53 -0700
Message-Id: <20211008202353.1448570-47-bvanassche@acm.org>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
In-Reply-To: <20211008202353.1448570-1-bvanassche@acm.org>
References: <20211008202353.1448570-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

All SCSI drivers have been converted to use shost_groups and sdev_groups
instead of shost_attrs or sdev_attrs. Hence remove shost_attrs and
sdev_attrs.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/hosts.c       |  9 ---------
 drivers/scsi/scsi_priv.h   |  2 --
 drivers/scsi/scsi_sysfs.c  | 28 ----------------------------
 include/scsi/scsi_device.h |  1 -
 include/scsi/scsi_host.h   | 11 -----------
 5 files changed, 51 deletions(-)

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index 3443f009a9e8..b3b7b55a90c6 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -482,15 +482,6 @@ struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *sht, int privsize)
 	dev_set_name(&shost->shost_dev, "host%d", shost->host_no);
 	shost->shost_dev.groups = shost->shost_dev_attr_groups;
 	shost->shost_dev_attr_groups[j++] = &scsi_shost_attr_group;
-	if (sht->shost_attrs) {
-		shost->lld_attr_group = (struct attribute_group){
-			.attrs = scsi_convert_dev_attrs(&shost->shost_gendev,
-							sht->shost_attrs)
-		};
-		if (shost->lld_attr_group.attrs)
-			shost->shost_dev_attr_groups[j++] =
-				&shost->lld_attr_group;
-	}
 	if (sht->shost_groups) {
 		for (i = 0; sht->shost_groups[i] &&
 			     j < ARRAY_SIZE(shost->shost_dev_attr_groups);
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index a5a2f18cc734..b7a82c426058 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -137,8 +137,6 @@ extern int scsi_sysfs_add_sdev(struct scsi_device *);
 extern int scsi_sysfs_add_host(struct Scsi_Host *);
 extern int scsi_sysfs_register(void);
 extern void scsi_sysfs_unregister(void);
-struct attribute **scsi_convert_dev_attrs(struct device *dev,
-					  struct device_attribute **dev_attr);
 extern void scsi_sysfs_device_initialize(struct scsi_device *);
 extern int scsi_sysfs_target_initialize(struct scsi_device *);
 extern struct scsi_transport_template blank_transport_template;
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 05b4d69d53d4..2e69fad0dc51 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1563,26 +1563,6 @@ int scsi_sysfs_add_host(struct Scsi_Host *shost)
 	return 0;
 }
 
-/*
- * Convert an array of struct device_attribute pointers into an array of
- * struct attribute pointers.
- */
-struct attribute **scsi_convert_dev_attrs(struct device *dev,
-					  struct device_attribute **dev_attr)
-{
-	struct attribute **attrs;
-	int i;
-
-	for (i = 0; dev_attr[i]; i++)
-		;
-	attrs = devm_kzalloc(dev, (i + 1) * sizeof(*attrs), GFP_KERNEL);
-	if (!attrs)
-		return NULL;
-	for (i = 0; dev_attr[i]; i++)
-		attrs[i] = &dev_attr[i]->attr;
-	return attrs;
-}
-
 static struct device_type scsi_dev_type = {
 	.name =		"scsi_device",
 	.release =	scsi_device_dev_release,
@@ -1603,14 +1583,6 @@ void scsi_sysfs_device_initialize(struct scsi_device *sdev)
 	dev_set_name(&sdev->sdev_gendev, "%d:%d:%d:%llu",
 		     sdev->host->host_no, sdev->channel, sdev->id, sdev->lun);
 	sdev->gendev_attr_groups[j++] = &scsi_sdev_attr_group;
-	if (hostt->sdev_attrs) {
-		sdev->lld_attr_group = (struct attribute_group){
-			.attrs = scsi_convert_dev_attrs(&sdev->sdev_gendev,
-							hostt->sdev_attrs)
-		};
-		if (sdev->lld_attr_group.attrs)
-			sdev->gendev_attr_groups[j++] = &sdev->lld_attr_group;
-	}
 	if (hostt->sdev_groups) {
 		for (i = 0; hostt->sdev_groups[i] &&
 			     j < ARRAY_SIZE(sdev->gendev_attr_groups);
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 01732aabd7c3..b1e9b3bd3a60 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -225,7 +225,6 @@ struct scsi_device {
 
 	struct device		sdev_gendev,
 				sdev_dev;
-	struct attribute_group	lld_attr_group;
 	/*
 	 * The array size 6 provides space for one attribute group for the
 	 * SCSI core, four attribute groups defined by SCSI LLDs and one
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index ab8775811e6f..c2b4d6677a76 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -473,16 +473,6 @@ struct scsi_host_template {
 	 */
 #define SCSI_DEFAULT_HOST_BLOCKED	7
 
-	/*
-	 * Pointer to the sysfs class properties for this host, NULL terminated.
-	 */
-	struct device_attribute **shost_attrs;
-
-	/*
-	 * Pointer to the SCSI device properties for this host, NULL terminated.
-	 */
-	struct device_attribute **sdev_attrs;
-
 	/*
 	 * Pointer to the SCSI host sysfs attribute groups, NULL terminated.
 	 */
@@ -700,7 +690,6 @@ struct Scsi_Host {
 
 	/* ldm bits */
 	struct device		shost_gendev, shost_dev;
-	struct attribute_group	lld_attr_group;
 	/*
 	 * The array size 3 provides space for one attribute group defined by
 	 * the SCSI core, one attribute group defined by the SCSI LLD and one
