Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2D46ECD2F
	for <lists+linux-scsi@lfdr.de>; Sat,  2 Nov 2019 06:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfKBFCF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 2 Nov 2019 01:02:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:50520 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfKBFCF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 2 Nov 2019 01:02:05 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 06C1D615F9; Sat,  2 Nov 2019 05:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572670924;
        bh=jddr8MoBIT1xRLTGNsH2aNlw3qACJFJphVK1ta+sZIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nMd/8nGfu8flN8Kl8MXijHoVJ+AYVIi5ucVh0U29wn93E4YMakJwvLX9Fe/lydL5F
         TtO6bhajsI4diAtfGsKtOsmDaYbSiBg8UaGnheMyjrtQrJUBdTuditW5yHMJz9tzXp
         2K5Nkrvhj/hCLL5I3eu0rwIuOEIUtzd1GhZ6RnGY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cang@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9D4EC615DB;
        Sat,  2 Nov 2019 05:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572670922;
        bh=jddr8MoBIT1xRLTGNsH2aNlw3qACJFJphVK1ta+sZIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iXdihnSqSu2sfB6YTQfDtGWWidGHj3QM15p3QRaIDQZwUlUbg0DzagychrHvWm+BF
         Wd869Bej1uvmUZUz5uDA++jypb10OP8J8LbOog5CeJvGEtMSPcMKIg5lFG5YbBzHUc
         T7LK9Pp2+Y+x/elndRSTBmFxWX1OhwlQN99Nz3DA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9D4EC615DB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cang@codeaurora.org
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        rnayak@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com,
        cang@codeaurora.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 4/5] scsi: ufs: Do not clear the DL layer timers
Date:   Fri,  1 Nov 2019 22:01:37 -0700
Message-Id: <1572670898-750-5-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1572670898-750-1-git-send-email-cang@codeaurora.org>
References: <1572670898-750-1-git-send-email-cang@codeaurora.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

During power mode change, PACP_PWR_Req frame sends
PAPowerModeUserData parameters (and they are considered valid by device if
Flags[4] - UserDataValid bit is set in the same frame).
Currently we don't set these PAPowerModeUserData parameters and hardware
always sets UserDataValid bit which would clear all the DL layer timeout
values of the peer device after the power mode change.

This change sets the PAPowerModeUserData[0..5] to UniPro specification
recommended default values, in addition we are also setting the relevant
DME_LOCAL_* timer attributes as required by UFS HCI specification.

Signed-off-by: Can Guo <cang@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c | 20 ++++++++++++++++++++
 drivers/scsi/ufs/unipro.h | 11 +++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 979b161..d6e52b3 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -4108,6 +4108,26 @@ static int ufshcd_change_power_mode(struct ufs_hba *hba,
 		ufshcd_dme_set(hba, UIC_ARG_MIB(PA_HSSERIES),
 						pwr_mode->hs_rate);
 
+	ufshcd_dme_set(hba, UIC_ARG_MIB(PA_PWRMODEUSERDATA0),
+			DL_FC0ProtectionTimeOutVal_Default);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(PA_PWRMODEUSERDATA1),
+			DL_TC0ReplayTimeOutVal_Default);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(PA_PWRMODEUSERDATA2),
+			DL_AFC0ReqTimeOutVal_Default);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(PA_PWRMODEUSERDATA3),
+			DL_FC1ProtectionTimeOutVal_Default);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(PA_PWRMODEUSERDATA4),
+			DL_TC1ReplayTimeOutVal_Default);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(PA_PWRMODEUSERDATA5),
+			DL_AFC1ReqTimeOutVal_Default);
+
+	ufshcd_dme_set(hba, UIC_ARG_MIB(DME_LocalFC0ProtectionTimeOutVal),
+			DL_FC0ProtectionTimeOutVal_Default);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(DME_LocalTC0ReplayTimeOutVal),
+			DL_TC0ReplayTimeOutVal_Default);
+	ufshcd_dme_set(hba, UIC_ARG_MIB(DME_LocalAFC0ReqTimeOutVal),
+			DL_AFC0ReqTimeOutVal_Default);
+
 	ret = ufshcd_uic_change_pwr_mode(hba, pwr_mode->pwr_rx << 4
 			| pwr_mode->pwr_tx);
 
diff --git a/drivers/scsi/ufs/unipro.h b/drivers/scsi/ufs/unipro.h
index f539f87..3dc4d8b 100644
--- a/drivers/scsi/ufs/unipro.h
+++ b/drivers/scsi/ufs/unipro.h
@@ -161,6 +161,17 @@
 /* PHY Adapter Protocol Constants */
 #define PA_MAXDATALANES	4
 
+#define DL_FC0ProtectionTimeOutVal_Default	8191
+#define DL_TC0ReplayTimeOutVal_Default		65535
+#define DL_AFC0ReqTimeOutVal_Default		32767
+#define DL_FC1ProtectionTimeOutVal_Default	8191
+#define DL_TC1ReplayTimeOutVal_Default		65535
+#define DL_AFC1ReqTimeOutVal_Default		32767
+
+#define DME_LocalFC0ProtectionTimeOutVal	0xD041
+#define DME_LocalTC0ReplayTimeOutVal		0xD042
+#define DME_LocalAFC0ReqTimeOutVal		0xD043
+
 /* PA power modes */
 enum {
 	FAST_MODE	= 1,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

