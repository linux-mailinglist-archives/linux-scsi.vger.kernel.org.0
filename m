Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386AA35AF44
	for <lists+linux-scsi@lfdr.de>; Sat, 10 Apr 2021 19:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbhDJRbI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 10 Apr 2021 13:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbhDJRbF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 10 Apr 2021 13:31:05 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7A6C06138B
        for <linux-scsi@vger.kernel.org>; Sat, 10 Apr 2021 10:30:49 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id nh5so4459863pjb.5
        for <linux-scsi@vger.kernel.org>; Sat, 10 Apr 2021 10:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e14H//ZExwZjjG3XlbWrBxfMo9QPyT+IgqonFSeGhWg=;
        b=im8D1jEEToyhBSsb1uaxj0cEdt/M45bP+TwIwttM3R/EQb6J0UPRv8MdbP/CJkvmki
         sW3eTU/yHg30XR/yjnx8i21APQvCMWCeyV4iAi0VrxmLbrcJfm7yaLBuLJJtTKsusaPw
         gxw7EXxo/orfgeA24lZLBIoLKOkDRoNWre7rD3i/KaDgMeoDedEFmfvg/CqOnpvGqpBV
         yjXL711B5uzAHj3DEHgTmQPRvGR1MwDEnmacAh7uRFh4t4fataU4o+XzLx0vw/r26eFP
         DAKD94uk6ebiHSunfPoIuCB5v+I81yXoa+VWC7LtYj76v9HcjwEXJGv8+PuyBUyKrnTm
         hC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e14H//ZExwZjjG3XlbWrBxfMo9QPyT+IgqonFSeGhWg=;
        b=BIhGpPqpiKgvM45OLk3tj+iIeNNYEU3RmCiGF534HqajIM63+BXuO9Ti+/qbAJXQt9
         aQjLwt34CeKU9aa3d9Tq5/xDkADfWquQGyGxVSVGVEbrYxs3pOp8kMG5Fn+qPfWLFpNG
         sSYKI0Xo+W8ulncuBFBR1KJubf12COuDdhtdFvxb6XU8nWAHlFprlNO9O/SGaznCzm8Y
         Bca4RTNcOa/w8mZ57MlI36tx4EdKkSxoEZL+1d9+OIl9ovFeVjmP0nOcx3M63iEpZGK1
         2M45gODLGqUJ7J2Z543bI/zDU0ud3eZ3ZNOX3mhPY6LPQOxmPYrAD2OZaUVWSvllB6lP
         xObA==
X-Gm-Message-State: AOAM531Hj4yaLto6GjblHjjFHu7/atjm79AbLTyelM176eGYQnVuIC00
        /oPKqTNCJPb+1Rk0/V37441KQlwW7N4=
X-Google-Smtp-Source: ABdhPJwBBYUubM06Z88ufuaAnAEx0myn0XEYjhiQ7Kly+Lg5RMvRS3YG/3Ot++CgmuXpQdryhJ+KbQ==
X-Received: by 2002:a17:902:a589:b029:e9:21cc:4aac with SMTP id az9-20020a170902a589b02900e921cc4aacmr18361056plb.21.1618075849220;
        Sat, 10 Apr 2021 10:30:49 -0700 (PDT)
Received: from localhost.localdomain ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x25sm5578861pfu.189.2021.04.10.10.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Apr 2021 10:30:49 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Justin Tee <justin.tee@broadcom.com>
Subject: [PATCH 08/16] lpfc: Fix silent memory allocation failure in lpfc_sli4_bsg_link_diag_test()
Date:   Sat, 10 Apr 2021 10:30:26 -0700
Message-Id: <20210410173034.67618-9-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210410173034.67618-1-jsmart2021@gmail.com>
References: <20210410173034.67618-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

In the unlikely case of a failure to allocate an LPFC_MBOXQ_t structure,
no return status is set, thus the routine never logs an error and
returns success to the callee.

Fix by setting a return code on failure.

Co-developed-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_bsg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
index 503540cf2041..48a6b0cc58ef 100644
--- a/drivers/scsi/lpfc/lpfc_bsg.c
+++ b/drivers/scsi/lpfc/lpfc_bsg.c
@@ -2435,8 +2435,10 @@ lpfc_sli4_bsg_link_diag_test(struct bsg_job *job)
 		goto job_error;
 
 	pmboxq = mempool_alloc(phba->mbox_mem_pool, GFP_KERNEL);
-	if (!pmboxq)
+	if (!pmboxq) {
+		rc = -ENOMEM;
 		goto link_diag_test_exit;
+	}
 
 	req_len = (sizeof(struct lpfc_mbx_set_link_diag_state) -
 		   sizeof(struct lpfc_sli4_cfg_mhdr));
-- 
2.26.2

