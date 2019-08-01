Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4307E1A7
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 19:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388033AbfHAR5N (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Aug 2019 13:57:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34943 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731544AbfHAR5N (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Aug 2019 13:57:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id u14so34524414pfn.2
        for <linux-scsi@vger.kernel.org>; Thu, 01 Aug 2019 10:57:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iuBf0FBsxuQpmWDhvqySX4KX50cq2A7S1kKbZoywPZg=;
        b=KMSpmJFaMFc1o+tX9cW+bEgPywFcQMsTlN6uab85TvGBU1qAE6/Hu7QADUOOWUfVtW
         hoeJJH62eoncka+gAptw2y4oSCiNQ0SZul2lFAonS7DQZEMbzcLnqt9/jaTFMxP0BZfc
         lpMmUfqrzf2Y6wd8QzDMxH5SX267gqaCKVjYloLTbSD7LMVmrRR0iHwjZ2hfcg76CqGJ
         az53Rfm5U4A8adPeszfw4Wnvg4TRejQCzfFc4dzb9NLMuqtdp9qIeADz9HcZkGM7OAKV
         Uu1aB8pwaWdfcqqM6Bq/knlzxEgevYAiv91VLB/PSZtkHq5kg04SCnTDlO1LOnEsspqs
         xnGw==
X-Gm-Message-State: APjAAAUoVUehu+S4miCbXASm+0JFc1b4SKlVhlZkZpp6xIg6/MyUU5Pw
        GjezOilaz55hRVoajqWSu2o=
X-Google-Smtp-Source: APXvYqyGSdX/t9vZ3kugQKMWOo2nv6DxNx2r/+h7UScUULrB6vPRkLnawFdHHA/pGPV8PttrTmDiWQ==
X-Received: by 2002:aa7:8392:: with SMTP id u18mr55233928pfm.72.1564682232536;
        Thu, 01 Aug 2019 10:57:12 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id y10sm73144114pfm.66.2019.08.01.10.57.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 10:57:11 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Himanshu Madhani <hmadhani@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>
Subject: [PATCH 38/59] qla2xxx: Change the return type of qla24xx_read_flash_data()
Date:   Thu,  1 Aug 2019 10:55:53 -0700
Message-Id: <20190801175614.73655-39-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190801175614.73655-1-bvanassche@acm.org>
References: <20190801175614.73655-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This change makes it easier to detect qla24xx_read_flash_data() failures
and also to handle such failures. This change does not modify the behavior
of the driver since all callers ignore the qla24xx_read_flash_data()
return value.

Cc: Himanshu Madhani <hmadhani@marvell.com>
Cc: Giridhar Malavali <gmalavali@marvell.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/qla2xxx/qla_gbl.h | 2 +-
 drivers/scsi/qla2xxx/qla_sup.c | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index 2d9664086f15..aac664da419b 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -554,7 +554,7 @@ fc_port_t *qla2x00_find_fcport_by_nportid(scsi_qla_host_t *, port_id_t *, u8);
  * Global Function Prototypes in qla_sup.c source file.
  */
 extern void qla2x00_release_nvram_protection(scsi_qla_host_t *);
-extern uint32_t *qla24xx_read_flash_data(scsi_qla_host_t *, uint32_t *,
+extern int qla24xx_read_flash_data(scsi_qla_host_t *, uint32_t *,
     uint32_t, uint32_t);
 extern uint8_t *qla2x00_read_nvram_data(scsi_qla_host_t *, void *, uint32_t,
     uint32_t);
diff --git a/drivers/scsi/qla2xxx/qla_sup.c b/drivers/scsi/qla2xxx/qla_sup.c
index 1eb82384d933..764e1bb0f695 100644
--- a/drivers/scsi/qla2xxx/qla_sup.c
+++ b/drivers/scsi/qla2xxx/qla_sup.c
@@ -473,22 +473,24 @@ qla24xx_read_flash_dword(struct qla_hw_data *ha, uint32_t addr, uint32_t *data)
 	return QLA_FUNCTION_TIMEOUT;
 }
 
-uint32_t *
+int
 qla24xx_read_flash_data(scsi_qla_host_t *vha, uint32_t *dwptr, uint32_t faddr,
     uint32_t dwords)
 {
 	ulong i;
+	int ret = QLA_SUCCESS;
 	struct qla_hw_data *ha = vha->hw;
 
 	/* Dword reads to flash. */
 	faddr =  flash_data_addr(ha, faddr);
 	for (i = 0; i < dwords; i++, faddr++, dwptr++) {
-		if (qla24xx_read_flash_dword(ha, faddr, dwptr))
+		ret = qla24xx_read_flash_dword(ha, faddr, dwptr);
+		if (ret != QLA_SUCCESS)
 			break;
 		cpu_to_le32s(dwptr);
 	}
 
-	return dwptr;
+	return ret;
 }
 
 static int
-- 
2.22.0.770.g0f2c4a37fd-goog

