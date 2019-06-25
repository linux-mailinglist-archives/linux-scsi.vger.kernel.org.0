Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFC154D23
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Jun 2019 13:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbfFYLFD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 25 Jun 2019 07:05:03 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38463 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfFYLFC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 25 Jun 2019 07:05:02 -0400
Received: by mail-pl1-f195.google.com with SMTP id g4so8639835plb.5
        for <linux-scsi@vger.kernel.org>; Tue, 25 Jun 2019 04:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ao3L+nsrX/w76VkkQgVXFDTTGZFNBOjj6cS0RAgCCzo=;
        b=AKhO3uc00SEKDky+6QGFmw116YX1QFH65G+WCWVxYjPoe480Bajn4715Wf/jv71JYA
         npAPeQsaQ8WbWeITAGN2Xfx24q0cvR761rsqEMy0XhGkmuXqXFGbbMU6HIYFMpDGe+1s
         NDbpnpARyqUSBWr6tQNXfDDUNidWvtCHmZCrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ao3L+nsrX/w76VkkQgVXFDTTGZFNBOjj6cS0RAgCCzo=;
        b=iE34P7PfVSCTGXBSV8Qcoh73XaMsaPcZ9Y6vUwyUWdYm31ReBEymaYYBK8Bgmn9E6X
         CTnnSueQQV0du0uZPDoqT07e3/LkQQ870dmpOP8CWC1/zoGXsi+Pha9g5LaCu7Idk6uT
         07CRNlo4qht0UxjqMcZMhbYmc4ITITFCc6mG5Wbd6mpO/rXf5b43OrancllRkJ89OVO6
         UPOnyqtycuOSonLp1pAo+ihRc2eGGHLX+KAWiocQGGBnH3qPrxcqaYZX39uVGWiqJ1v4
         hmsHm4jmRZguFieqKUJOUNT2fYtYpY+2qY6x2MreM4L8+CfSha3UnvP8ge0EGjKDgxnf
         qR1w==
X-Gm-Message-State: APjAAAVkcIsfaVbRIIz9/GgUstZr3IehJiPT6Do0WvtYKallEAth1cvI
        eP/xZXq0LbN8JvKkTj2M+BxCmpCRg0jzuc8qUU3e2xqGKwaUmjxJmsKai/diT5/EBU3fH9E6MzU
        zMV+tuJ4W2UWp/rxiN5MfyPMqRF+a8666B0KqJ9vjbe+pYYenXR/z8cb+lTsa5xeImN9/+koA4t
        lpAWv96kLQ2G8J
X-Google-Smtp-Source: APXvYqxVpYVV23V8kLWpw20GJn4qSrR7cmTeDe1rgSwiEvKY1yzn97jnsDi5byHa4xcyg9oQgJBpsw==
X-Received: by 2002:a17:902:2a69:: with SMTP id i96mr144681440plb.108.1561460701649;
        Tue, 25 Jun 2019 04:05:01 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id t5sm14757389pgh.46.2019.06.25.04.04.58
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 04:05:01 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        anand.lodnoor@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH v3 03/18] megaraid_sas: Remove few debug counters from IO path
Date:   Tue, 25 Jun 2019 16:34:21 +0530
Message-Id: <20190625110436.4703-4-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190625110436.4703-1-chandrakanth.patil@broadcom.com>
References: <20190625110436.4703-1-chandrakanth.patil@broadcom.com>
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
index 4411408..dac8552 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -2066,7 +2066,6 @@ megasas_is_prp_possible(struct megasas_instance *instance,
 			    mega_mod64(sg_dma_address(sg_scmd),
 				       mr_nvme_pg_size)) {
 				build_prp = false;
-				atomic_inc(&instance->sge_holes_type1);
 				break;
 			}
 		}
@@ -2076,7 +2075,6 @@ megasas_is_prp_possible(struct megasas_instance *instance,
 					sg_dma_len(sg_scmd)),
 					mr_nvme_pg_size))) {
 				build_prp = false;
-				atomic_inc(&instance->sge_holes_type2);
 				break;
 			}
 		}
@@ -2085,7 +2083,6 @@ megasas_is_prp_possible(struct megasas_instance *instance,
 			if (mega_mod64(sg_dma_address(sg_scmd),
 				       mr_nvme_pg_size)) {
 				build_prp = false;
-				atomic_inc(&instance->sge_holes_type3);
 				break;
 			}
 		}
@@ -2218,7 +2215,6 @@ megasas_make_prp_nvme(struct megasas_instance *instance, struct scsi_cmnd *scmd,
 	main_chain_element->Length =
 			cpu_to_le32(num_prp_in_chain * sizeof(u64));
 
-	atomic_inc(&instance->prp_sgl);
 	return build_prp;
 }
 
@@ -2293,7 +2289,6 @@ megasas_make_sgl_fusion(struct megasas_instance *instance,
 			memset(sgl_ptr, 0, instance->max_chain_frame_sz);
 		}
 	}
-	atomic_inc(&instance->ieee_sgl);
 }
 
 /**
-- 
2.9.5

