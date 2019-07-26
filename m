Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A211F76B90
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jul 2019 16:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfGZO0A (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Jul 2019 10:26:00 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34595 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727366AbfGZO0A (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 26 Jul 2019 10:26:00 -0400
Received: by mail-qt1-f195.google.com with SMTP id k10so52820651qtq.1
        for <linux-scsi@vger.kernel.org>; Fri, 26 Jul 2019 07:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=WTNB9/sSUp3RvghC3N7AVUzrEDJYp8g0FPiSPT+2XmY=;
        b=IE0RZWx//RRo+SUPna44fGwa3H83J/6k6ORc+Rz2IlkOveVpNT1DGd4MnPYXZ+04AV
         9XQxJEG26nX0gY91WPbL6hMCTPqAfleSp43IEFQhaJ54PMVaProxdSjOFyWv5n4JdvDn
         o5R3X0qyI6AyUarBkYZVyT7V6WwJZypymVQskeQlX1uSoPnJD3ru+AQq3CvOJFFIJpuE
         JtVzLWHBhyqcT4pSq2h0Tbv5n7nw/Kp9NGb8fBMnUKSceZrVeNu9YCe2bLVa3zuGIoMW
         ab4MfMKbtuXDez7tfWTxgQ77j3aYEkeD+4efnKuyjhaIHHimKHhL1vvvi9uH/AASXbA8
         Wc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WTNB9/sSUp3RvghC3N7AVUzrEDJYp8g0FPiSPT+2XmY=;
        b=bc3PqMKYK/1cGnZOhHbYWRKQz6bDjVBi8SgiXhqnoln2NODYcy82oKfhAMgljwl7lU
         nRT1r1+PwTmpphVcPI2Mqo75b5cmlMt0rrJd34Ow6p9Mf/4D6O30JYtkSo89I4pxtZ3E
         zXzAJYoqRKkk9sgMc9X0DdgvS2A9/eMkvNs/7sCw4wCAwu9pTrbIGARwDApWt2smDztH
         OPW2kri9jMtRHlc7hhhu8XPNYNIjUZnSo/JnuDj3VooiS17tChaOt6ZW0yYceNbqYPMp
         HeGg4PLFBnvdc9NV5v8t0oBQuaN3v3XyLv84lrKxhzPFgvgcHYL3cbGVFEHvE40PnIMz
         GsaA==
X-Gm-Message-State: APjAAAUAaX6c7U6NSf6bQlkQjCP/HlPPpbaWfsB3OGqeNHmBJGaZ2pkf
        X+7HFsWDwMeLxkrEtfksxmAoEQ==
X-Google-Smtp-Source: APXvYqw7RxbbTRB1wYmPz1aZ7z6CkuQJpFWipr6DnxLizs1HK6WYvq1PfoOxTVIsTZP+MX2WlhfIww==
X-Received: by 2002:a0c:d066:: with SMTP id d35mr66686999qvh.221.1564151159483;
        Fri, 26 Jul 2019 07:25:59 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id l19sm30771521qtb.6.2019.07.26.07.25.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 07:25:58 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     martin.petersen@oracle.com
Cc:     jejb@linux.ibm.com, kashyap.desai@broadcom.com,
        sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] scsi/megaraid_sas: fix a compilation warning
Date:   Fri, 26 Jul 2019 10:25:43 -0400
Message-Id: <1564151143-22889-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The commit de516379e85f ("scsi: megaraid_sas: changes to function
prototypes") introduced a comilation warning due to it changed the
function prototype of read_fw_status_reg() to take an instance pointer
instead, but forgot to remove an unused variable.

drivers/scsi/megaraid/megaraid_sas_fusion.c: In function
'megasas_fusion_update_can_queue':
drivers/scsi/megaraid/megaraid_sas_fusion.c:326:39: warning: variable
'reg_set' set but not used [-Wunused-but-set-variable]
  struct megasas_register_set __iomem *reg_set;
                                       ^~~~~~~
Fixes: de516379e85f ("scsi: megaraid_sas: changes to function prototypes")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index a32b3f0fcd15..e8092d59d575 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -323,9 +323,6 @@ inline void megasas_return_cmd_fusion(struct megasas_instance *instance,
 {
 	u16 cur_max_fw_cmds = 0;
 	u16 ldio_threshold = 0;
-	struct megasas_register_set __iomem *reg_set;
-
-	reg_set = instance->reg_set;
 
 	/* ventura FW does not fill outbound_scratch_pad_2 with queue depth */
 	if (instance->adapter_type < VENTURA_SERIES)
-- 
1.8.3.1

