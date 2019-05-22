Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A439B25B46
	for <lists+linux-scsi@lfdr.de>; Wed, 22 May 2019 02:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbfEVAt2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 21 May 2019 20:49:28 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41020 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728153AbfEVAt2 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 21 May 2019 20:49:28 -0400
Received: by mail-pl1-f195.google.com with SMTP id f12so171025plt.8
        for <linux-scsi@vger.kernel.org>; Tue, 21 May 2019 17:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/417Jjd7m4X8lFU69iO0S8Ju3qoLuM52ru+/43vM4hA=;
        b=sF6a+XDEalu4+4tB3My4xT+UD/FD9sDy5Wxn9nnPANwgJcuKZ6JVuKRV77yimKDsny
         lI7w0fWovFWXwt0Vd6GOlr+IkgZqk48ASo3R8gMIaqq9u5a0epXMpESvQdPpUrlIhemk
         AMrEy7YBWgTCAhXaq60n/IvJnSuiCerpFsJYt9qlexCVR9rKIgC0s3XZtmDlQKhq/UqU
         i5DR5RPmWton5cR1TGXY8Qwq5xcW1/HrCP2WbFqX2VrLsBzYTEMDI5v3xi9Irp1xhQKf
         dmwoNCmcQHO/oOEKTNtrZVcZ/37qLoBK7DjNvB2SeC+m91dn8uzudJ5fL92IQDLoa5CU
         RhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/417Jjd7m4X8lFU69iO0S8Ju3qoLuM52ru+/43vM4hA=;
        b=oK1l/TO33KguxA5vDTcxQnGuIurIpvJMJPtrC9WM6f0hTZ+9MR7ZhqW9VCCECKbGIb
         dV+BTEioluTwiIvXIHdubTmC6o6h5feFlbkfQuQG6t6n7A/6Kow3GmDiLR4HkUXEpE2t
         KbItNc/3++HE+drBR46h+xWs4pgSL5RHhMH/pFxF6ZGT2YIZOUt0J2FslZkBNA2dTJuH
         vUnpE7w+SYTaF4k/6QIl4aObxmRx9OIMp1ldMHAPtRAlVlqgRW1vXrJIkGWNI4MrXM2/
         9E31okz/y8nE6rWAq8pt0M9Zx/N1kk+gf+wqaWxQS+hStTj92ehr1ySJrQTwbtaCJqzG
         m4jg==
X-Gm-Message-State: APjAAAXORwWUDRJDGr0tHOM+J/4h610/zdovqxvYaKXK2EY4jaf+mSK9
        nyBvWSLDJbd7iAqeqJHh0FJqkupT
X-Google-Smtp-Source: APXvYqzmxiDXOT/FbWF4u2lu+/dgqmu6+MXCMqRVdzcNWkettGiSNhIpuQYXIhV41HVR6tbh/l345w==
X-Received: by 2002:a17:902:a613:: with SMTP id u19mr72109139plq.42.1558486167682;
        Tue, 21 May 2019 17:49:27 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j184sm22550121pge.83.2019.05.21.17.49.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 May 2019 17:49:27 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 07/21] lpfc: Revert message logging on unsupported topology
Date:   Tue, 21 May 2019 17:48:57 -0700
Message-Id: <20190522004911.573-8-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190522004911.573-1-jsmart2021@gmail.com>
References: <20190522004911.573-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Turns out the message change in 12.2.0.1 for unsupported topology
makes the linux driver out of sync with other products.

Revert the message back to the prior content for product consistency.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>

---
As this is not a technical issue, I've not added a Fixes line
---
 drivers/scsi/lpfc/lpfc_attr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index e9adb3f1961d..aabd42c4c6f8 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -4090,9 +4090,9 @@ lpfc_topology_store(struct device *dev, struct device_attribute *attr,
 		}
 		if ((phba->pcidev->device == PCI_DEVICE_ID_LANCER_G6_FC ||
 		     phba->pcidev->device == PCI_DEVICE_ID_LANCER_G7_FC) &&
-		    val != FLAGS_TOPOLOGY_MODE_PT_PT) {
+		    val == 4) {
 			lpfc_printf_vlog(vport, KERN_ERR, LOG_INIT,
-				"3114 Only non-FC-AL mode is supported\n");
+				"3114 Loop mode not supported\n");
 			return -EINVAL;
 		}
 		phba->cfg_topology = val;
-- 
2.13.7

