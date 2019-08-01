Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2C8D7E1A4
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388027AbfHAR5J (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:57:09 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40423 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731544AbfHAR5J (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:57:09 -0400
Received: by mail-pf1-f194.google.com with SMTP id p184so34499409pfp.7
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:57:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CUBkCrrqrkFudTayzDFpPScgImweoWWnRYN4gMqL47I=;
        b=FahGrwWK+6WT8EpWalB10h8PsvQfYaIgS60S3qXzY52bTeNW89nScc6c3lLo0y/Eam
         Vcchnpej/X+n2NQdP2jKLdwzboP7cdVgPEQCJt15E3vRG8WuBzTu5w1o+Z62yjdMowWi
         WNWTY5He3QFD0S865TT9QdLXwBCBxCbAffaXxg3oBiHmr8TzuIWbLTawjsTAuykNco35
         Hh2Ku7c3qfXLMwoB7qlV7gK9yj9kFwGI2aSPWKfFIwqfLXW7/oL2tkYarqSE1JcJpgNx
         LMBSfEWg90eRo0TqJb4lxtpGLj/X5y/GOqfMbitNmXnxqEDwyRvBWQVJWvQ0mig/sAXf
         KXOg==
X-Gm-Message-State: APjAAAUnRNHPK1/l5GiQLpE6qUBFNPBIqAD2lBlRNZiCFW7VjYbV2HgK
        E0Qqcjvi9Ud8RnSUwYtwa3k=
X-Google-Smtp-Source: APXvYqw1lsX1IjQSUw250Fy/NRJEIsgr+xxqWkly2/ASoVs/6M6GGDtYqJnPh6YKQkW9iUuUj4qKnw==
X-Received: by 2002:a63:f50d:: with SMTP id w13mr120075402pgh.411.1564682228682;
        Thu, 01 Aug 2019 10:57:08 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.57.07
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:57:07 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 35/59] qla2xxx: Use memcpy() and strlcpy() instead of strcpy() and strncpy()
Date:   Thu,  1 Aug 2019 10:55:50 -0700
Message-Id: <20190801175614.73655-36-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch makes the string manipulation code easier to verify.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_init.c | 18 ++++++++++--------
 drivers/scsi/qla2xxx/qla_mr.c   |  6 ++++--
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 2d9a379fd8fb..5258d2486e25 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -4438,7 +4438,7 @@ qla2x00_set_model_info(scsi_qla_host_t *vha, uint8_t *model, size_t len,
 	if (len > sizeof(zero))
 		len = sizeof(zero);
 	if (memcmp(model, &zero, len) != 0) {
-		strncpy(ha->model_number, model, len);
+		memcpy(ha->model_number, model, len);
 		st = en = ha->model_number;
 		en += len - 1;
 		while (en > st) {
@@ -4451,21 +4451,23 @@ qla2x00_set_model_info(scsi_qla_host_t *vha, uint8_t *model, size_t len,
 		if (use_tbl &&
 		    ha->pdev->subsystem_vendor == PCI_VENDOR_ID_QLOGIC &&
 		    index < QLA_MODEL_NAMES)
-			strncpy(ha->model_desc,
+			strlcpy(ha->model_desc,
 			    qla2x00_model_name[index * 2 + 1],
-			    sizeof(ha->model_desc) - 1);
+			    sizeof(ha->model_desc));
 	} else {
 		index = (ha->pdev->subsystem_device & 0xff);
 		if (use_tbl &&
 		    ha->pdev->subsystem_vendor == PCI_VENDOR_ID_QLOGIC &&
 		    index < QLA_MODEL_NAMES) {
-			strcpy(ha->model_number,
-			    qla2x00_model_name[index * 2]);
-			strncpy(ha->model_desc,
+			strlcpy(ha->model_number,
+				qla2x00_model_name[index * 2],
+				sizeof(ha->model_number));
+			strlcpy(ha->model_desc,
 			    qla2x00_model_name[index * 2 + 1],
-			    sizeof(ha->model_desc) - 1);
+			    sizeof(ha->model_desc));
 		} else {
-			strcpy(ha->model_number, def);
+			strlcpy(ha->model_number, def,
+				sizeof(ha->model_number));
 		}
 	}
 	if (IS_FWI2_CAPABLE(ha))
diff --git a/drivers/scsi/qla2xxx/qla_mr.c b/drivers/scsi/qla2xxx/qla_mr.c
index 759fcfecc310..78b3679e1b9c 100644
--- a/drivers/scsi/qla2xxx/qla_mr.c
+++ b/drivers/scsi/qla2xxx/qla_mr.c
@@ -1939,8 +1939,10 @@ qlafx00_fx_disc(scsi_qla_host_t *vha, fc_port_t *fcport, uint16_t fx_type)
 	if (fx_type == FXDISC_GET_CONFIG_INFO) {
 		struct config_info_data *pinfo =
 		    (struct config_info_data *) fdisc->u.fxiocb.rsp_addr;
-		strcpy(vha->hw->model_number, pinfo->model_num);
-		strcpy(vha->hw->model_desc, pinfo->model_description);
+		strlcpy(vha->hw->model_number, pinfo->model_num,
+			ARRAY_SIZE(vha->hw->model_number));
+		strlcpy(vha->hw->model_desc, pinfo->model_description,
+			ARRAY_SIZE(vha->hw->model_desc));
 		memcpy(&vha->hw->mr.symbolic_name, pinfo->symbolic_name,
 		    sizeof(vha->hw->mr.symbolic_name));
 		memcpy(&vha->hw->mr.serial_num, pinfo->serial_num,
-- 
2.22.0.770.g0f2c4a37fd-goog

