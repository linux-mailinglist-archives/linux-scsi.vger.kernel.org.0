Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2B40153EFF
	for <lists+linux-scsi@lfdr.de>; Thu,  6 Feb 2020 07:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgBFG5n (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 6 Feb 2020 01:57:43 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:30176 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727963AbgBFG5m (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 6 Feb 2020 01:57:42 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580972262; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=XQ+uh2aLUSTUdkOMogurM1PlrBMvbhA+iCSkFZCbigU=; b=KirBmBy1voF88FHRLZZaojNu1COTsB0P0Cmk2CAwrysjjLS43J0D/yeEhA3KEGgQ705FVVbL
 sr4+oBZbXudyDsLhaYStft6xdL7qUpj4QP0BPhtYUd9J3wWukqMCrnR/LLQyWCBSHIORCscN
 mrRNL0B6VTq6pugcaOW1/LZDBZM=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3bb8e4.7f1e7ccf2570-smtp-out-n02;
 Thu, 06 Feb 2020 06:57:40 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A2DEAC447A2; Thu,  6 Feb 2020 06:57:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 58769C447AD;
        Thu,  6 Feb 2020 06:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 58769C447AD
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=cang@codeaurora.org
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, rnayak@codeaurora.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        saravanak@google.com, salyzyn@google.com, cang@codeaurora.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Pedro Sousa <sousa@synopsys.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 8/8] scsi: ufs: Select INITIAL adapt for HS Gear4
Date:   Wed,  5 Feb 2020 22:56:51 -0800
Message-Id: <1580972212-29881-9-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1580972212-29881-1-git-send-email-cang@codeaurora.org>
References: <1580972212-29881-1-git-send-email-cang@codeaurora.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

ADAPT is added specifically for HS Gear4 mode only, select INITIAL adapt
before do power mode change to G4 and select no adapt before switch to
non-G4 modes.

Signed-off-by: Can Guo <cang@codeaurora.org>
Reviewed-by: Asutosh Das <asutoshd@codeaurora.org>
Reviewed-by: Hongwu Su <hongwus@codeaurora.org>
Reviewed-by: Bean Huo <beanhuo@micron.com>

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 76beaf9..1fe0a97 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -4069,6 +4069,17 @@ static int ufshcd_change_power_mode(struct ufs_hba *hba,
 		ufshcd_dme_set(hba, UIC_ARG_MIB(PA_HSSERIES),
 						pwr_mode->hs_rate);
 
+	if (hba->ufs_version >= UFSHCI_VERSION_30) {
+		if (pwr_mode->gear_tx == UFS_HS_G4)
+			/* INITIAL ADAPT */
+			ufshcd_dme_set(hba, UIC_ARG_MIB(PA_TXHSADAPTTYPE),
+					PA_INITIAL_ADAPT);
+		else
+			/* NO ADAPT */
+			ufshcd_dme_set(hba, UIC_ARG_MIB(PA_TXHSADAPTTYPE),
+					PA_NO_ADAPT);
+	}
+
 	ufshcd_dme_set(hba, UIC_ARG_MIB(PA_PWRMODEUSERDATA0),
 			DL_FC0ProtectionTimeOutVal_Default);
 	ufshcd_dme_set(hba, UIC_ARG_MIB(PA_PWRMODEUSERDATA1),
@@ -8447,7 +8458,8 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
 	if ((hba->ufs_version != UFSHCI_VERSION_10) &&
 	    (hba->ufs_version != UFSHCI_VERSION_11) &&
 	    (hba->ufs_version != UFSHCI_VERSION_20) &&
-	    (hba->ufs_version != UFSHCI_VERSION_21))
+	    (hba->ufs_version != UFSHCI_VERSION_21) &&
+	    (hba->ufs_version != UFSHCI_VERSION_30))
 		dev_err(hba->dev, "invalid UFS version 0x%x\n",
 			hba->ufs_version);
 
diff --git a/drivers/scsi/ufs/ufshci.h b/drivers/scsi/ufs/ufshci.h
index c2961d3..f2ee816 100644
--- a/drivers/scsi/ufs/ufshci.h
+++ b/drivers/scsi/ufs/ufshci.h
@@ -104,6 +104,7 @@ enum {
 	UFSHCI_VERSION_11 = 0x00010100, /* 1.1 */
 	UFSHCI_VERSION_20 = 0x00000200, /* 2.0 */
 	UFSHCI_VERSION_21 = 0x00000210, /* 2.1 */
+	UFSHCI_VERSION_30 = 0x00000300, /* 3.0 */
 };
 
 /*
diff --git a/drivers/scsi/ufs/unipro.h b/drivers/scsi/ufs/unipro.h
index 3dc4d8b..5a724b2 100644
--- a/drivers/scsi/ufs/unipro.h
+++ b/drivers/scsi/ufs/unipro.h
@@ -146,6 +146,12 @@
 #define PA_SLEEPNOCONFIGTIME	0x15A2
 #define PA_STALLNOCONFIGTIME	0x15A3
 #define PA_SAVECONFIGTIME	0x15A4
+#define PA_TXHSADAPTTYPE	0x15D4
+
+/* Adpat type for PA_TXHSADAPTTYPE attribute */
+#define PA_REFRESH_ADAPT	0x00
+#define PA_INITIAL_ADAPT	0x01
+#define PA_NO_ADAPT		0x03
 
 #define PA_TACTIVATE_TIME_UNIT_US	10
 #define PA_HIBERN8_TIME_UNIT_US		100
@@ -203,6 +209,7 @@ enum ufs_hs_gear_tag {
 	UFS_HS_G1,		/* HS Gear 1 (default for reset) */
 	UFS_HS_G2,		/* HS Gear 2 */
 	UFS_HS_G3,		/* HS Gear 3 */
+	UFS_HS_G4,		/* HS Gear 4 */
 };
 
 enum ufs_unipro_ver {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
