Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 127367E1A1
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388025AbfHAR5F (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:57:05 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32979 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731544AbfHAR5F (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:57:05 -0400
Received: by mail-pf1-f193.google.com with SMTP id g2so34511141pfq.0
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YBi43r5WqDhFjbBA0FQuVkDw+Mc7jN/LC6t2g75LxJ4=;
        b=YC2SIbwftRHn9GohUJgo260HFKBJP0n/Z9VnhYGDF8eEcxG6afHX/bW5gjgFbV4YEf
         yfCwyJo9rRof3dOK5SfwH4ujBbS7YkCRCsWzqK+FhgtNaHPhlEefT7BPkdq8pwR6MveW
         ldnRGhBHZJnHuVd5kzGoKjVSnm5vL4utZWLe9Sna8y/XKBfIq1SX/+RIzzjW2Ju+aF8W
         QT6zf+MIP2wWjbynxk7X/IOZekCulRYLXtZFWFt+q68zF/3rBSm3TUiyUxX7t+Qyk4d6
         egFgymS5noVhdVc1wmeRNHvVEYVW5rsoo99R6yiwVgqaTdQLLSXzZpWRi1tmFvsi0PKz
         gWtQ==
X-Gm-Message-State: APjAAAVanSE+GNr8siEhFI7CPmQxE8DIfU4mEEYkmQ/PkN3RUI5SxE9C
        GwzIhMFLX8ASazd/fZSAldg=
X-Google-Smtp-Source: APXvYqwawYQqUJn6c717BfrSLGN7xihZ3xEQcpvCbct43FzLASoDx1yvs5yEIVFC4VQy4tunDBe5EQ==
X-Received: by 2002:a63:4846:: with SMTP id x6mr84617517pgk.332.1564682224450;
        Thu, 01 Aug 2019 10:57:04 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.57.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:57:03 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 32/59] qla2xxx: Declare fourth qla2x00_set_model_info() argument const
Date:   Thu,  1 Aug 2019 10:55:47 -0700
Message-Id: <20190801175614.73655-33-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Make it clear to humans and also to the compiler that the string passed
as fourth argument is not modified.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_gbl.h  | 4 ++--
 drivers/scsi/qla2xxx/qla_init.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index 6f6801722a09..fc54e7c86463 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -822,8 +822,8 @@ extern int qla82xx_device_state_handler(scsi_qla_host_t *);
 extern void qla8xxx_dev_failed_handler(scsi_qla_host_t *);
 extern void qla82xx_clear_qsnt_ready(scsi_qla_host_t *);
 
-extern void qla2x00_set_model_info(scsi_qla_host_t *, uint8_t *,
-				   size_t, char *);
+extern void qla2x00_set_model_info(scsi_qla_host_t *, uint8_t *, size_t,
+				   const char *);
 extern int qla82xx_mbx_intr_enable(scsi_qla_host_t *);
 extern int qla82xx_mbx_intr_disable(scsi_qla_host_t *);
 extern void qla82xx_start_iocbs(scsi_qla_host_t *);
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index cab5f2f90714..1fd9a086748e 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -4426,7 +4426,7 @@ qla2x00_configure_hba(scsi_qla_host_t *vha)
 
 inline void
 qla2x00_set_model_info(scsi_qla_host_t *vha, uint8_t *model, size_t len,
-	char *def)
+		       const char *def)
 {
 	char *st, *en;
 	uint16_t index;
-- 
2.22.0.770.g0f2c4a37fd-goog

