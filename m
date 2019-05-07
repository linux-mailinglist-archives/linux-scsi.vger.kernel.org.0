Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3728C168B9
	for <lists+linux-scsi@lfdr.de>; Tue,  7 May 2019 19:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfEGRGU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 May 2019 13:06:20 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41122 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfEGRGU (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 May 2019 13:06:20 -0400
Received: by mail-pf1-f194.google.com with SMTP id l132so4017717pfc.8
        for <linux-scsi@vger.kernel.org>; Tue, 07 May 2019 10:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b8LcUew8y2c2qcOdIdJueDfN1EbZQu2fqTFNgaHgjzU=;
        b=G1PAIRrM3KcZOhSVQcedKOn05jhjYULKBUoYvtnVwIeAQ2GgPwm3jdw7INdRbDZ8MC
         GrX4Se/YMJ/8+p8uHBgWVpS1ZeFIlyGSDxgLH1F3fPYLFaTWdbvzh95WOViI3IIRdKLw
         U94x7rTTW44WgWIUaYhuRlO+d9PBSz75dpU24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b8LcUew8y2c2qcOdIdJueDfN1EbZQu2fqTFNgaHgjzU=;
        b=AuNtzo0PK1cbgKu90aksQo9H99nWOrd2iMXu+yfKxKd6d9ETCMDzF8t1WzBIodvJlp
         0VUxZvKOuI4aQ7nQS9YNAyooKDGZ/Q6JAKceE8jyRbqo3o7tDOHzJdJxcxRs/fyD+pEK
         c1Ut2n7of/4S5+z6SrSz/Wo2c/Qg29pmyuzZct48uDMxUxEPsB6fu2zrC/54VFfR6Ce0
         pyL/5XEXaaUi+KZdLIMkSY3gabMpq6UsCKUIPYbmzGh2H1AePONmyp0XDkO8LgZKfVsu
         j7gA51ZFuIsy77izLPkziO3c+ejVk1zq+qI/LByyvwlkVh4MWG5bmro/5FwpltC7Q5JB
         hbSg==
X-Gm-Message-State: APjAAAXPyAmtxWBvs+++7HIb4Adq3PU/UOPNHbhYstcGDCa8RJ/hqFzz
        Z7KWvl4RpedPL4+9aAmabl0s7y7KguTfTIHO/3nTGIEunjg0UQwOa0A8cTIK5EmrGC0uRs0FV5o
        c4z0M+LiaUOhbi3Tg80xtu333ls9sWcEiTny4e/L0ldetDz5Zp8eyDYcDxUNVqYQkOMkMb67Gwa
        PhPO2xoX77QX/53nVSpn4s
X-Google-Smtp-Source: APXvYqwxF19A9qrp22LN+ibwSpxgfXiEC3WtpVzs20sU81vHdCR/8kC4xFIoY3xoLTC9giWZ4UmdNw==
X-Received: by 2002:a65:4649:: with SMTP id k9mr17341404pgr.239.1557248779515;
        Tue, 07 May 2019 10:06:19 -0700 (PDT)
Received: from dhcp-135-24-192-142.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r74sm17527791pfa.71.2019.05.07.10.06.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 10:06:18 -0700 (PDT)
From:   Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     kashyap.desai@broadcom.com, sumit.saxena@broadcom.com,
        kiran-kumar.kasturi@broadcom.com, sankar.patra@broadcom.com,
        sasikumar.pc@broadcom.com,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Subject: [PATCH v2 03/21] megaraid_sas: fw_reset_no_pci_access required for MFI adapters only
Date:   Tue,  7 May 2019 10:05:32 -0700
Message-Id: <1557248750-4099-4-git-send-email-shivasharan.srikanteshwara@broadcom.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
References: <1557248750-4099-1-git-send-email-shivasharan.srikanteshwara@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

fw_reset_no_pci_access is only applicable for MFI controllers and is not
used for Fusion controllers.

For all Fusion controllers, driver can check reset adapter bit in
status register before performing a chip reset, without
setting "fw_reset_no_pci_access".

Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
---
 drivers/scsi/megaraid/megaraid_sas_base.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_base.c b/drivers/scsi/megaraid/megaraid_sas_base.c
index d2714fc833ae..77db6e773a01 100644
--- a/drivers/scsi/megaraid/megaraid_sas_base.c
+++ b/drivers/scsi/megaraid/megaraid_sas_base.c
@@ -5489,7 +5489,6 @@ static int megasas_init_fw(struct megasas_instance *instance)
 	int i, j, loop, fw_msix_count = 0;
 	struct IOV_111 *iovPtr;
 	struct fusion_context *fusion;
-	bool do_adp_reset = true;
 
 	fusion = instance->ctrl_context;
 
@@ -5536,13 +5535,18 @@ static int megasas_init_fw(struct megasas_instance *instance)
 	}
 
 	if (megasas_transition_to_ready(instance, 0)) {
-		if (instance->adapter_type >= INVADER_SERIES) {
+		if (instance->adapter_type != MFI_SERIES) {
 			status_reg = instance->instancet->read_fw_status_reg(
 					instance);
-			do_adp_reset = status_reg & MFI_RESET_ADAPTER;
-		}
-
-		if (do_adp_reset) {
+			if (status_reg & MFI_RESET_ADAPTER) {
+				instance->instancet->adp_reset
+					(instance, instance->reg_set);
+				if (megasas_transition_to_ready(instance, 0))
+					goto fail_ready_state;
+			} else {
+				goto fail_ready_state;
+			}
+		} else {
 			atomic_set(&instance->fw_reset_no_pci_access, 1);
 			instance->instancet->adp_reset
 				(instance, instance->reg_set);
@@ -5556,8 +5560,6 @@ static int megasas_init_fw(struct megasas_instance *instance)
 
 			if (megasas_transition_to_ready(instance, 0))
 				goto fail_ready_state;
-		} else {
-			goto fail_ready_state;
 		}
 	}
 
-- 
2.16.1

