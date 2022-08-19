Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18F859926B
	for <lists+linux-scsi@lfdr.de>; Fri, 19 Aug 2022 03:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243470AbiHSBS0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 18 Aug 2022 21:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240055AbiHSBSS (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 18 Aug 2022 21:18:18 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA86255AD
        for <linux-scsi@vger.kernel.org>; Thu, 18 Aug 2022 18:18:16 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id b9so2426405qka.2
        for <linux-scsi@vger.kernel.org>; Thu, 18 Aug 2022 18:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=MpkPfHv8oQ4oe5xZE/mgn7voKKidkrfvyTtqN7y5MB0=;
        b=EoN1613eT0XIk33EWUNyfJC3RN46CE2M0JiVgfeyLjh7MHBFJCjVTc8GuF6GmcXopy
         cA75LdIbTns2ojumGnBdLDEA+/KPaQG+aWPQmDwUY0XPeiPfQ0gRtOPjaO0CUgOx3/hx
         6CwbilAaxl0+kPF8MKq4erPxw0iSWILjUHCGEKmXJhlBSYrPr2G6pThsss9bNGO+fRSL
         qlLgGpSJ9+FF2IydScyQS2g8YIAEfA5pldzA7BBOhk65ze5eoSmroi8ejwLLzd5cyIim
         o0dqLzjBymEuydCHPtjkZsLX5dWpRQyUsc7XRUr1PXwalUUTmYGENeVhns8Ne4hmyYii
         5r3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=MpkPfHv8oQ4oe5xZE/mgn7voKKidkrfvyTtqN7y5MB0=;
        b=64hBbBUlObmbFosgtvWAAAGPzzYIZRKsaLBUHBnr75tNnzjTQ+GIZw9uW5q3TNhhHr
         TaMnHzxzXzlx1+sHuW9ikKwOI7xIsaJvkLGquqBq4cCJgYRTOoyf5xjLu0aujTYZG+JT
         tvd6hrhlUvXYOdHB3UxwrRlHVij04TlDehpEjpAqALdh6DepCrCNLPU+dT3D729zuFW2
         tbAcyA9Ul3iuD2OUVb4dHWdCia0cqzNV/7ttcPR4zOaw/6yGxBLbl4oM5qfosPhH5web
         2C/sMbni0dYI5HSYMIZK7W4WHXg2j6/nQQqHmLu0OZOCw9ZkS5Vy8wKG2ZQMIq5S843m
         iwiA==
X-Gm-Message-State: ACgBeo0HPyHKXzW00n0seXRsR2oMXlUKXhTsPtLVGkW7XhS9A/vgJMnP
        z5Dfip9QfqEgo+8ZDhDfbYsGTnXN6HU=
X-Google-Smtp-Source: AA6agR6ynDvFXWQQ/0J3QY3GnxBOdXUjiZpVs27ERq+xmgVn+d0AaiUeURHDLTtNzgrBWAnIczGtYw==
X-Received: by 2002:a05:620a:bc9:b0:6b6:66b2:d417 with SMTP id s9-20020a05620a0bc900b006b666b2d417mr4036172qki.3.1660871895626;
        Thu, 18 Aug 2022 18:18:15 -0700 (PDT)
Received: from mail-ash-it-01.broadcom.com (ip98-164-255-77.oc.oc.cox.net. [98.164.255.77])
        by smtp.gmail.com with ESMTPSA id u5-20020a05620a0c4500b006b5e296452csm2612502qki.54.2022.08.18.18.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 18:18:15 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Justin Tee <justin.tee@broadcom.com>
Subject: [PATCH 6/7] lpfc: Update lpfc version to 14.2.0.6
Date:   Thu, 18 Aug 2022 18:17:35 -0700
Message-Id: <20220819011736.14141-7-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220819011736.14141-1-jsmart2021@gmail.com>
References: <20220819011736.14141-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Update lpfc version to 14.2.0.6

Co-developed-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_version.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_version.h b/drivers/scsi/lpfc/lpfc_version.h
index 63eba9928e4b..aa89225e0595 100644
--- a/drivers/scsi/lpfc/lpfc_version.h
+++ b/drivers/scsi/lpfc/lpfc_version.h
@@ -20,7 +20,7 @@
  * included with this package.                                     *
  *******************************************************************/
 
-#define LPFC_DRIVER_VERSION "14.2.0.5"
+#define LPFC_DRIVER_VERSION "14.2.0.6"
 #define LPFC_DRIVER_NAME		"lpfc"
 
 /* Used for SLI 2/3 */
-- 
2.26.2

