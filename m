Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F258E49D55
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 11:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbfFRJci (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Jun 2019 05:32:38 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39033 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729272AbfFRJci (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 18 Jun 2019 05:32:38 -0400
Received: by mail-pl1-f193.google.com with SMTP id b7so5466206pls.6
        for <linux-scsi@vger.kernel.org>; Tue, 18 Jun 2019 02:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oVevDaw3s2CB150b1k9g5VrbFOe/gqw4FJZSe/bW9JM=;
        b=HvicAEO0JRSZtX7/QvtnIb76pwnvqqXea5X0BRV43sbD4OG3G0e62RG2Hr3ijeCfA2
         /zt59qXWtaXcQWSznZQmL231Chr1eEutOIqorRXrBtM89ti+Y+EAYhyKR1y22LQmR9XK
         3DAjn7A+Bq2AUELSRDbOFSNewOd8x22NVVgss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oVevDaw3s2CB150b1k9g5VrbFOe/gqw4FJZSe/bW9JM=;
        b=bWLdcOGDCJ0OpFn2Czx/yJA4Vz5cV5y/mEIWQdFsYQRYZoZKzcO/euA9rS0vF1jlDu
         /z976UiAOj0pV1M/mFUBkr3oAnKjtapbplDPDxpXv9bMIrj7F0hjsJraWC/zU60yJZM7
         5685GXU+2ZurNgIpAkbhi6rV9HR/3VvmCeowJxphkUXxyYIpdsiCaxPaA+fNKF6iAE6H
         8zKUD+3D8HGULzxBLoCFo1a3FgUIEZixNT2POkwXcDe+zOLdATSh9rE8wR78BjZoKNwX
         Ho3xZZy2chS62230DJ4pscBbX5Er4pDthchKeOS4Bn2SQO4tYDzuRwBaKvDBO2/+Xi87
         X8KQ==
X-Gm-Message-State: APjAAAW6KiGBDidhsSGIIA9pTamJjra/RT0c2C+j91yG9YlWlsGQ2EEV
        mUiato8w8HN6zPWX85gagmOAdrxRMiiUu2Hi9z4hJyGJUbpjHB6xzyskOpIqeSIsfm2wl5DqXFb
        laexUXY/SHFcn3VPoYqn9DG6duQiliiYEZsMkrUHmJ8ArAMp1vNMMcXYtlnc+WlxS7J9CIIqi49
        uxypdfv486xQ==
X-Google-Smtp-Source: APXvYqwKw7wUS519c4uxDpOr2P+qVUdxOwfI9OPAzX/RTrJm8zXH7SfZ8NaPiA6z0njD2dobUWJNbA==
X-Received: by 2002:a17:902:d916:: with SMTP id c22mr89063443plz.195.1560850357078;
        Tue, 18 Jun 2019 02:32:37 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z20sm21394809pfk.72.2019.06.18.02.32.34
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 02:32:36 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH 03/18] megaraid_sas: Remove few debug counters from IO path
Date:   Tue, 18 Jun 2019 15:01:52 +0530
Message-Id: <20190618093207.9939-4-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190618093207.9939-1-chandrakanth.patil@broadcom.com>
References: <20190618093207.9939-1-chandrakanth.patil@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Chandrakanth Patil <chandrakanth.patil@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas.h        | 5 -----
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas.h b/drivers/scsi/megaraid/megaraid_sas.h
index 61bcf7a..a972021 100644
--- a/drivers/scsi/megaraid/megaraid_sas.h
+++ b/drivers/scsi/megaraid/megaraid_sas.h
@@ -2323,11 +2323,6 @@ struct megasas_instance {
 	atomic_t fw_outstanding;
 	atomic_t ldio_outstanding;
 	atomic_t fw_reset_no_pci_access;
-	atomic_t ieee_sgl;
-	atomic_t prp_sgl;
-	atomic_t sge_holes_type1;
-	atomic_t sge_holes_type2;
-	atomic_t sge_holes_type3;
 	atomic64_t total_io_count;
 
 	struct megasas_instance_template *instancet;
diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index d4c1ee57..dc27da1 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -2068,7 +2068,6 @@ megasas_is_prp_possible(struct megasas_instance *instance,
 			    mega_mod64(sg_dma_address(sg_scmd),
 				       mr_nvme_pg_size)) {
 				build_prp = false;
-				atomic_inc(&instance->sge_holes_type1);
 				break;
 			}
 		}
@@ -2078,7 +2077,6 @@ megasas_is_prp_possible(struct megasas_instance *instance,
 					sg_dma_len(sg_scmd)),
 					mr_nvme_pg_size))) {
 				build_prp = false;
-				atomic_inc(&instance->sge_holes_type2);
 				break;
 			}
 		}
@@ -2087,7 +2085,6 @@ megasas_is_prp_possible(struct megasas_instance *instance,
 			if (mega_mod64(sg_dma_address(sg_scmd),
 				       mr_nvme_pg_size)) {
 				build_prp = false;
-				atomic_inc(&instance->sge_holes_type3);
 				break;
 			}
 		}
@@ -2220,7 +2217,6 @@ megasas_make_prp_nvme(struct megasas_instance *instance, struct scsi_cmnd *scmd,
 	main_chain_element->Length =
 			cpu_to_le32(num_prp_in_chain * sizeof(u64));
 
-	atomic_inc(&instance->prp_sgl);
 	return build_prp;
 }
 
@@ -2295,7 +2291,6 @@ megasas_make_sgl_fusion(struct megasas_instance *instance,
 			memset(sgl_ptr, 0, instance->max_chain_frame_sz);
 		}
 	}
-	atomic_inc(&instance->ieee_sgl);
 }
 
 /**
-- 
2.9.5

