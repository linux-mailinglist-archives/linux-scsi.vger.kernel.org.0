Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992CA63F6AD
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Dec 2022 18:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiLARrh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Dec 2022 12:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiLARq6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Dec 2022 12:46:58 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E1FCD9AE
        for <linux-scsi@vger.kernel.org>; Thu,  1 Dec 2022 09:45:45 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id c15so2532007pfb.13
        for <linux-scsi@vger.kernel.org>; Thu, 01 Dec 2022 09:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8CMRsJAWw5Kl2y6C4bQ/udAroFdc5lkzkoFkDtAV0k=;
        b=L9ZGHIuIN4pPpIQ02mKvPDbt7rsp+sys+Lik1R2XQTVkFu+uRC89PbR+dZwc52D8Q7
         g11NpkjDgJTJiTpWG/PbIwmXqJ22q/CAgB0sdJB4kjkpmvKdGsfzPUJFka0G9hBGXSka
         qfMUADxnUudncW+CM4fhFdPDrOiQuhVjxu4Fx8YZPXJuni6pnL07h9Y4l9+cyKgoJz23
         CEUnpzZoPOyMDeBy9l5ALrJI/57dx03ck+PieN6055E5ZoB9AR7kZ5Gum8iHrUAah0RB
         Qxn2i9gkfZe4YxEgUpH2qSa9m/9fqpxXD5UuKg0mY4EY8J+PGfD0JHGQu12n0WhzJJyL
         z7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8CMRsJAWw5Kl2y6C4bQ/udAroFdc5lkzkoFkDtAV0k=;
        b=UfP8an92i4DOQwmwlihPvvZnDlEkLCLwYCenfuy4KDVWbjLUyqcEZSFUmgeGhnKF2g
         SjSyFfL+Yz0XHkCUhThgXNkWdC/Z2f4yzTK4mlXuLP7WNLVCT4vOmzK/IOxAf1sP/4IJ
         X8TeNGFKvFQT+FcBAxmDiFEqG/MrFTIzFdyKJq/9VNG7x+i5IGBU/rVbBH3K5VhczBr2
         MnJ1mb4st4vFjwbW/kSgSenVXdLxEN2zEG/v2sob0rimg462WJumXbShVg4pCVOnz6y+
         tG6bu0Vf0vud2Mqo6dNgVEtox/Gq4W0f7rZNJIr6H306eweAB9guVmNtun/WqoDY6tN9
         41xg==
X-Gm-Message-State: ANoB5plhFfEUKxkVIKk+MbAVB/TujU10b+56Lhn0DxXInh+uw+wXswOT
        usWPalfr9ECdzxfwMC/7N/Y1
X-Google-Smtp-Source: AA0mqf7y7AzxCwbyVg7CsylxaJhKbOLur7jj9QPpD1O9t/GU02NyTqdu+AdHJk3FLBpzUInJiq6H1w==
X-Received: by 2002:a63:2361:0:b0:477:b603:f683 with SMTP id u33-20020a632361000000b00477b603f683mr39094258pgm.93.1669916745385;
        Thu, 01 Dec 2022 09:45:45 -0800 (PST)
Received: from localhost.localdomain ([220.158.159.39])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016d9b101413sm3898743pll.200.2022.12.01.09.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 09:45:44 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org
Cc:     quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        abel.vesa@linaro.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 18/23] scsi: ufs: core: Add reinit_notify() callback
Date:   Thu,  1 Dec 2022 23:13:23 +0530
Message-Id: <20221201174328.870152-19-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org>
References: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

reinit_notify() callback can be used by the UFS controllers to perform
changes required for UFS core reinit.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/core/ufshcd-priv.h | 6 ++++++
 include/ufs/ufshcd.h           | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index a9e8e1f5afe7..2ce3c98e0711 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -226,6 +226,12 @@ static inline void ufshcd_vops_config_scaling_param(struct ufs_hba *hba,
 		hba->vops->config_scaling_param(hba, p, data);
 }
 
+static inline void ufshcd_vops_reinit_notify(struct ufs_hba *hba)
+{
+	if (hba->vops && hba->vops->reinit_notify)
+		hba->vops->reinit_notify(hba);
+}
+
 extern const struct ufs_pm_lvl_states ufs_pm_lvl_states[];
 
 /**
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 5cf81dff60aa..af8c95077d96 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -297,6 +297,7 @@ struct ufs_pwr_mode_info {
  * @config_scaling_param: called to configure clock scaling parameters
  * @program_key: program or evict an inline encryption key
  * @event_notify: called to notify important events
+ * @reinit_notify: called to notify UFS core reinit
  */
 struct ufs_hba_variant_ops {
 	const char *name;
@@ -335,6 +336,7 @@ struct ufs_hba_variant_ops {
 			       const union ufs_crypto_cfg_entry *cfg, int slot);
 	void	(*event_notify)(struct ufs_hba *hba,
 				enum ufs_event_type evt, void *data);
+	void	(*reinit_notify)(struct ufs_hba *);
 };
 
 /* clock gating state  */
-- 
2.25.1

