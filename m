Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6469E1473AF
	for <lists+linux-scsi@lfdr.de>; Thu, 23 Jan 2020 23:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgAWWVN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 23 Jan 2020 17:21:13 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:33802 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728988AbgAWWVN (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 23 Jan 2020 17:21:13 -0500
Received: by mail-pj1-f65.google.com with SMTP id f2so23428pjq.1
        for <linux-scsi@vger.kernel.org>; Thu, 23 Jan 2020 14:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aOcxg7DsFkYHqwW8hr47b+HAI2mUE5xc6hC+CMJmCGU=;
        b=MiRqD2qOxLy+bwx8i1OetxGjPc+Nci3fZjYhurcW8hf+8jxVDpfnh7r+pnHT2mHhYv
         EVBklXOvuHXpQ7/oyjSZwgHKOJ/sEtUYlFiOcbF64vDyIaoh+H9oqGsbjzuOP7ykaX8+
         1/stTcA2sbFO4pkKmfsiCtEmkje76hQXtradF96msmiSLjCIjPdCMlYR96AIBmf3hfSU
         pS6qW26NnSkkSfpGBeH8biaF4edjVCs9YqQdQtfZFd2OVuAjOMb8jDVcXe5Z9T7gtRNh
         Zyky5GthiCjCLCiav5pJ6uj/NzR5U6Gbf3YfvDW4DII2yK/vM5OpiG8W6CqGURHY6kfZ
         ZsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aOcxg7DsFkYHqwW8hr47b+HAI2mUE5xc6hC+CMJmCGU=;
        b=eY4cGoer7ijM2Za2fc5Oxo+lQzKhgoAOEPcs+Wscscyx4dUfvEOFHsTWtOFzKZawbj
         qcGPw4mgLnK5j3oMQeKKTzfVZTYXiu+jpmIPKmTbXFvJWuWY0KiwcMDEL3ZvyDCx8L9q
         wO3Cw6Vir0f3uBtifBP7Efv20T2kzRVqyUjg+HR/t/0ja7cZC9YnyZQhh7YrZAXz5oX7
         YzhKJteZw8DYU61xrP0mTqjSW4wt9KKKulPW4+Gv4vs1z9oyOg06Y7+l6P9sPtgX6iNN
         psAD9Aahjl4Es6QKGctP5/RIK0IVnrll/OIdsz2zpmG92syPcmzzR1yZsXVYNDbwLYbE
         1j5w==
X-Gm-Message-State: APjAAAXv6PzIEtm9qoq4f1XpSzl2/KhQy3VAhICwcaXRGvpGs9V67Qh1
        GchItuq2hqsOTdJ5896oZxbDu6ZZ
X-Google-Smtp-Source: APXvYqzLacguDwPJsX5uPUU4Hr+BgSi2BP1Db4MO5FBqaj03gAIFBzPcSBN57nF2o3AvtS3SJXjuDA==
X-Received: by 2002:a17:90a:2e88:: with SMTP id r8mr9730pjd.85.1579818071642;
        Thu, 23 Jan 2020 14:21:11 -0800 (PST)
Received: from os42.localdomain ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g8sm3616660pfh.43.2020.01.23.14.21.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Jan 2020 14:21:11 -0800 (PST)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>
Subject: [PATCH v2 2/3] scsi: add shost helper to set max queue depth on all of its devices
Date:   Thu, 23 Jan 2020 14:21:01 -0800
Message-Id: <20200123222102.23383-3-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200123222102.23383-1-jsmart2021@gmail.com>
References: <20200123222102.23383-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Create a helper routine to loop through all devices on an shost and
change their current and maximum queue depth. The helper is created
such that is lldd callable.

Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/scsi.c        | 32 ++++++++++++++++++++++++++++++++
 include/scsi/scsi_device.h |  1 +
 2 files changed, 33 insertions(+)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 195c0b11260a..f5bb8ce4661f 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -272,6 +272,38 @@ scsi_change_max_queue_depth(struct scsi_device *sdev, int depth)
 }
 
 /**
+ * shost_change_max_queue_depths -  helper to walk all devices on a
+ *         shost and change their max queue depth.
+ * @shost: shost whose devices we want to iterate over.
+ * @depth: number of commands allowed to be queued to the driver
+ *
+ * Validates the shost allows a change of queue depth, the value is valid,
+ * then traverses over all devices and sets their maximum queue depth.
+ */
+int shost_change_max_queue_depths(struct Scsi_Host *shost, int depth)
+{
+	struct scsi_device *sdev;
+	int retval;
+
+	if (!shost->hostt->change_queue_depth)
+		return -ENOTSUPP;
+
+	if (depth < 1 || depth > shost->can_queue)
+		return -EINVAL;
+
+	shost_for_each_device(sdev, shost) {
+		retval = scsi_change_max_queue_depth(sdev, depth);
+		if (retval != 0)
+			sdev_printk(KERN_INFO, sdev,
+				"failed to set queue depth to %d (err %d)",
+				depth, retval);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(shost_change_max_queue_depths);
+
+/**
  * scsi_track_queue_full - track QUEUE_FULL events to adjust queue depth
  * @sdev: SCSI Device in question
  * @depth: Current number of outstanding SCSI commands on this device,
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index f8312a3e5b42..38c4b97fc1b8 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -392,6 +392,7 @@ extern struct scsi_device *__scsi_iterate_devices(struct Scsi_Host *,
 
 extern int scsi_change_queue_depth(struct scsi_device *, int);
 extern int scsi_track_queue_full(struct scsi_device *, int);
+extern int shost_change_max_queue_depths(struct Scsi_Host *shost, int depth);
 
 extern int scsi_set_medium_removal(struct scsi_device *, char);
 
-- 
2.13.7

