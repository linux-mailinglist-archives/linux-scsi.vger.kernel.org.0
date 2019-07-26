Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D66F776F55
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jul 2019 18:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387546AbfGZQtH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Jul 2019 12:49:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34013 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387538AbfGZQtG (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 26 Jul 2019 12:49:06 -0400
Received: by mail-pl1-f195.google.com with SMTP id i2so24993968plt.1
        for <linux-scsi@vger.kernel.org>; Fri, 26 Jul 2019 09:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N9YelK5WYZRpm22GcXyXzyRRIqzjdIleHNT4TwY1w+4=;
        b=FrZNciCvTDqm3Beam0Xpwlzl1eoyN72HgiqWGqcAPFZQrn/hgDdULfPmvTT6zIxVqi
         M367FDntFwUdjcrZvC0q0bS5WQdnlegwGCrZ9FyRw4Tn1qJ6s9ynZrt3jqirn5e874YO
         xH8EUUU5EXZrpWY8mCXz2HV4/4QcKd6JdZJaajG61ML2yZPXhLwxkKEE2JRKL9I9Bn88
         pQsw76DU+uopIPrVygEc9nG3yWRGXW94qskEBNigCPGL9no8H0DlZ0ORbr7+DJRrrH0E
         haNAb8fkPBJPPuLa8pDCPU06ZbfFPMlkX2atF82QUwlLb0OqJplCFggJ4HLh9PCFaRo1
         SL3g==
X-Gm-Message-State: APjAAAWRZ2ep+aTz6XqDPnJE0sHYuJ3od+DngOYXOIsutv0UvNYH537O
        jJmqdowUsGuNV2+GXUUZ8TA=
X-Google-Smtp-Source: APXvYqxH9LFJLmS65luMI1G1CWiKAhbtcESRmn5CWf8tcg4QjNCz7NlGMy31FbYv5hmRYmo188PoyA==
X-Received: by 2002:a17:902:f089:: with SMTP id go9mr96962167plb.81.1564159746028;
        Fri, 26 Jul 2019 09:49:06 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id b36sm80923246pjc.16.2019.07.26.09.49.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 09:49:05 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/4] Change the return type of scsi_target_block() from 'void' into 'int'
Date:   Fri, 26 Jul 2019 09:48:53 -0700
Message-Id: <20190726164855.130084-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
In-Reply-To: <20190726164855.130084-1-bvanassche@acm.org>
References: <20190726164855.130084-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Since scsi_target_block() can fail, return a value that indicates whether
or not this function succeeded.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/scsi_lib.c    | 24 +++++++++++++++++-------
 include/scsi/scsi_device.h |  2 +-
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 497cd4799e0a..bbed72eff9c9 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2741,26 +2741,36 @@ static int scsi_internal_device_unblock(struct scsi_device *sdev,
 static void
 device_block(struct scsi_device *sdev, void *data)
 {
-	scsi_internal_device_block(sdev);
+	int ret, *retp = data;
+
+	ret = scsi_internal_device_block(sdev);
+	if (*retp == 0 && ret != 0)
+		*retp = ret;
 }
 
 static int
 target_block(struct device *dev, void *data)
 {
+	int *retp = data;
+
 	if (scsi_is_target_device(dev))
-		starget_for_each_device(to_scsi_target(dev), NULL,
+		starget_for_each_device(to_scsi_target(dev), data,
 					device_block);
-	return 0;
+
+	return *retp;
 }
 
-void
-scsi_target_block(struct device *dev)
+int scsi_target_block(struct device *dev)
 {
+	int ret = 0;
+
 	if (scsi_is_target_device(dev))
-		starget_for_each_device(to_scsi_target(dev), NULL,
+		starget_for_each_device(to_scsi_target(dev), &ret,
 					device_block);
 	else
-		device_for_each_child(dev, NULL, target_block);
+		device_for_each_child(dev, &ret, target_block);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(scsi_target_block);
 
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 202f4d6a4342..e5d24abd292d 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -421,7 +421,7 @@ extern void scsi_scan_target(struct device *parent, unsigned int channel,
 			     unsigned int id, u64 lun,
 			     enum scsi_scan_mode rescan);
 extern void scsi_target_reap(struct scsi_target *);
-extern void scsi_target_block(struct device *);
+extern int scsi_target_block(struct device *);
 extern void scsi_target_unblock(struct device *, enum scsi_device_state);
 extern void scsi_remove_target(struct device *);
 extern const char *scsi_device_state_name(enum scsi_device_state);
-- 
2.22.0.709.g102302147b-goog

