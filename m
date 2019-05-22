Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21A2725B55
	for <lists+linux-scsi@lfdr.de>; Wed, 22 May 2019 02:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfEVAtk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 21 May 2019 20:49:40 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:42460 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728236AbfEVAtj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 21 May 2019 20:49:39 -0400
Received: by mail-pl1-f175.google.com with SMTP id go2so168056plb.9
        for <linux-scsi@vger.kernel.org>; Tue, 21 May 2019 17:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vjbieRIJLeqeCax1MXZpL9yhGeOMw3FLIQHHtfwCpe8=;
        b=bScRWNpLjchx5/KWf0W4jDOc9MREm0pU+IyxrhG78CSSbZtAKFsgcOTpu0DimCRK8z
         fHtoHRTxYDWvSnAj+sJXny3zvKyu9kKuIZROfDjZ6MSn/vOC/MmcOn0BDc9vMA+ATQwY
         MFVhtLD29SAbwDu/hV4GXFGOtqU/Fi4dLpwXDdz7ZLLDPYzYd/XTaTj5gj5Hb++hvsUU
         Y9ENkWYYpeppsfU/9RKfxOFzQumXMFrvcoPDFaR6d95AhEZL3LEsa8p/iwpnI5v6RG6I
         tFhTapSwclI6d0iqT2r4gw239GmS57SBsxfWJ5SGCItvf/C/bTIfbWWvGd9Qn9F/oNme
         t19g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vjbieRIJLeqeCax1MXZpL9yhGeOMw3FLIQHHtfwCpe8=;
        b=RgryrMBuWRcTgSrWB+RcSrXPDf25ipodrcXAkMf9ApwE1xGQVdF+EI3QbqGGpvMm40
         LooXuPz79cSuqhgx336sBMIiiE1H3F6W4CooPYxRdKSNYyu/ipMZxzaKOHTOcbL3A0wg
         tSdm9BkO/G4DnI1acyDzfWKWmclgacXbj/UyCMOUVKgmxNBH379KVI6NYd9gMGEUIiHA
         mMeKMhNGgVUyMoK9V45QdS+NmlZxTzviIABE1oY0J8ZKhB7sfNhqiZorKO3iegYksJo3
         Q5r5L+vq9nO8CcNkxAEfMk60fyhYdHFccG9LBijOy7lAyZ+2OfZVfxeLyb4UPWSXIGcL
         0qUQ==
X-Gm-Message-State: APjAAAWqmDYcKdf4Sajowagc++tUrwydOZXiL7MbtTZImNrJ47dNne+z
        edixKy0NV3MzFT937JHZ8MGWVgK6
X-Google-Smtp-Source: APXvYqz342yjuf6axlKfKkpErvEDXLyJ+CMLjmJTaK57rp0Z/dPH/kvO/EYzlyPmWebtRBlpQKDrlw==
X-Received: by 2002:a17:902:b58f:: with SMTP id a15mr43193182pls.201.1558486178581;
        Tue, 21 May 2019 17:49:38 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j184sm22550121pge.83.2019.05.21.17.49.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 May 2019 17:49:38 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 21/21] lpfc: Update lpfc version to 12.2.0.3
Date:   Tue, 21 May 2019 17:49:11 -0700
Message-Id: <20190522004911.573-22-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190522004911.573-1-jsmart2021@gmail.com>
References: <20190522004911.573-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Update lpfc version to 12.2.0.3

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_version.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_version.h b/drivers/scsi/lpfc/lpfc_version.h
index f7d9ef428417..f7e93aaf1e00 100644
--- a/drivers/scsi/lpfc/lpfc_version.h
+++ b/drivers/scsi/lpfc/lpfc_version.h
@@ -20,7 +20,7 @@
  * included with this package.                                     *
  *******************************************************************/
 
-#define LPFC_DRIVER_VERSION "12.2.0.1"
+#define LPFC_DRIVER_VERSION "12.2.0.3"
 #define LPFC_DRIVER_NAME		"lpfc"
 
 /* Used for SLI 2/3 */
-- 
2.13.7

