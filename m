Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD4225B42
	for <lists+linux-scsi@lfdr.de>; Wed, 22 May 2019 02:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfEVAtX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 21 May 2019 20:49:23 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42954 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbfEVAtX (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 21 May 2019 20:49:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id go2so167851plb.9
        for <linux-scsi@vger.kernel.org>; Tue, 21 May 2019 17:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MIgeez25auR/8LV5piBQP5AWXOBRFasx1/Awg7vqAz4=;
        b=Yde+4yHVN58KM2l7ZLLM6YAnjePGaB0udRDVsy+H2mWi1ZKVaf27YRWJPS5akTiuuH
         rznyBWjgKEaa0wvoWXbbxUnSu398L4LgquEwdCNr0KCauKtUI8CwS9ag2Q40fHYYRQam
         JykhqEcrlkA3P6miZi2NxwIoKIo8YpxSA4Hyqovk+EtpG/1Dv7GBh8DXsvWaqZk9if6t
         9mIGPb3zdsDozHE/hhfygoT7sh0Ui1xSXXylIE6YONzK42iliaykr9dYPo4mOXqSY0qZ
         0dBaDTo43rykY9rzV4rxuN3+zRSmWeXKHPVRvcnFTtWSDUBN8X60RqvaoMF4t71BvCrW
         JQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MIgeez25auR/8LV5piBQP5AWXOBRFasx1/Awg7vqAz4=;
        b=EFhxcUnvhOZZrrcJl27jZ7p6o756VSoqh61GBOa+tT23KtbPi0bF7R/aRg5GeHP1ka
         NVxTSRPHTmovUlsELuqsK1NgjQmHPWlCu3F9KYISetq5mhNdNTVtZwCvVIkc7nzhZ2Sa
         KHv65fAz3BUHwSNwA5mP4Y2cv9B+l06kF6eiyu1DXeSclISd5WxjlvpuIS32PUXAHZEt
         2kWGyXuKWrF6oN1UaTyoEnKJH5FgPRdXVAd1rz/ZS5q5enFJELs6uyQ6Xb1iuDd2oCLH
         KjSI9dpPHJlXHyFPXzCpO09SoghC9mDeWoHX7Pr3cgzwKX3vcACt2YF/bFY+0Sld4OcV
         gTyw==
X-Gm-Message-State: APjAAAVts0MG/wMYVnRHtAYWhDyBBoDdeEptxGVCW/zmih16zgQqgRc9
        db771WpLN3R3pLyhmmagLWK3Iac3
X-Google-Smtp-Source: APXvYqzhzvyKHpdEd8EcOU+9+b0fzPr2qvKUCwgdD5PqqPgXuG4QXGnc5Y94WjwYEp26A5RL1fBO1w==
X-Received: by 2002:a17:902:8c82:: with SMTP id t2mr79086138plo.256.1558486162882;
        Tue, 21 May 2019 17:49:22 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j184sm22550121pge.83.2019.05.21.17.49.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 May 2019 17:49:22 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 01/21] lpfc: Fix alloc context on oas lun creations
Date:   Tue, 21 May 2019 17:48:51 -0700
Message-Id: <20190522004911.573-2-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190522004911.573-1-jsmart2021@gmail.com>
References: <20190522004911.573-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Softlockups are seen in low memory situations. They are due to
doing oas_lun allocation with GFP_KERNEL in atomic contexts.

Change the calls to oas_lun to indicate atomic context so that
GFP_ATOMIC is used.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index ba996fbde89b..3873d5b97bc6 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -5741,7 +5741,7 @@ lpfc_enable_oas_lun(struct lpfc_hba *phba, struct lpfc_name *vport_wwpn,
 
 	/* Create an lun info structure and add to list of luns */
 	lun_info = lpfc_create_device_data(phba, vport_wwpn, target_wwpn, lun,
-					   pri, false);
+					   pri, true);
 	if (lun_info) {
 		lun_info->oas_enabled = true;
 		lun_info->priority = pri;
-- 
2.13.7

