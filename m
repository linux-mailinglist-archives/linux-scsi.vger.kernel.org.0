Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60BFA4CC51
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Jun 2019 12:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731253AbfFTKwt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 Jun 2019 06:52:49 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35461 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfFTKws (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 20 Jun 2019 06:52:48 -0400
Received: by mail-pl1-f193.google.com with SMTP id p1so1253931plo.2
        for <linux-scsi@vger.kernel.org>; Thu, 20 Jun 2019 03:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ao3L+nsrX/w76VkkQgVXFDTTGZFNBOjj6cS0RAgCCzo=;
        b=NVU9C85b911tDn/rgZjDyOUQE+o3FQBUVryOctC2Oap/RMdY/41g+lol5kgsaLx8cD
         oAj60a/io7k6QumP6U9artIUzNY5Dfq5VOe4mr1QeyuvxFAz3ijM+w8jNuYbeaJ/6vSd
         CJTWM+GwvH7XrF0WIjNOgyyLfOIDXDObtA1ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ao3L+nsrX/w76VkkQgVXFDTTGZFNBOjj6cS0RAgCCzo=;
        b=iN9iJCMqKlUavkTcjgal0yIZiGEe4nAP6DVE/7qS5BB0NSM0osleZbaTLCLdaih7k7
         10So+5rSF1hkFdxRLAwlh0jE/TAtYZ9v8/2OhB15UXAlVWX+1S7WOM8ghSeB4fmqIHE+
         8Zk2EjIo7czxFAHva1CSr5FKKdy2ZBNZxXhPFqlKgeNSvee/GJYno2eJTHJm8wCuBaA+
         6mUTgmWRXHEStzWEdsWXjzZpQXCidXL5l6c39wAW7kaqx0fWs3Uf/gS3xbr1n+KTDmDm
         doyzArw3QCiHGc43u3QnzYWD+xocghehYPdPJVVz8pA+Bp4IhP0MBRPLWkH0I83eo09h
         MI1w==
X-Gm-Message-State: APjAAAVvQ60rQufnB/rlIO0bQlGnhH4mOdF1CcFo/K6m2sDnog9N0fkE
        7SRX0A82Q7yJhs10VaUKcuszCuJl0oJZr/Q/mri+bQjptfvWUIVzy+I62AVBKOWnlJ3fZeIHoM/
        gf67QmM9r3dcOYI1W/5cFG7KrqynblA8BrfUaHsqM7+sjqYByA+zbUnyMv1TG9E2bT3uEnlsvZD
        ARQRQltsX9yQFcSdw=
X-Google-Smtp-Source: APXvYqwHAz98+SyCVYRyiKlmqvS69B8ghuvp2tYQJ4+OqxbD1ISKqJjE09QPkDMRwaokiTUC2AWZrw==
X-Received: by 2002:a17:902:ab90:: with SMTP id f16mr121854134plr.262.1561027967917;
        Thu, 20 Jun 2019 03:52:47 -0700 (PDT)
Received: from dhcp-10-123-20-30.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id l7sm24793995pfl.9.2019.06.20.03.52.45
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 03:52:47 -0700 (PDT)
From:   Chandrakanth Patil <chandrakanth.patil@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        Chandrakanth Patil <chandrakanth.patil@broadcom.com>
Subject: [PATCH v2 03/18] megaraid_sas: Remove few debug counters from IO path
Date:   Thu, 20 Jun 2019 16:21:53 +0530
Message-Id: <20190620105208.15011-4-chandrakanth.patil@broadcom.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190620105208.15011-1-chandrakanth.patil@broadcom.com>
References: <20190620105208.15011-1-chandrakanth.patil@broadcom.com>
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

