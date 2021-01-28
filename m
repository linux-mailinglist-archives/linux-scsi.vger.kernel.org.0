Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48AC2307B82
	for <lists+linux-scsi@lfdr.de>; Thu, 28 Jan 2021 17:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbhA1Q5O (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 28 Jan 2021 11:57:14 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:32697 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbhA1Q5A (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 28 Jan 2021 11:57:00 -0500
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 28 Jan 2021 08:55:33 -0800
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 28 Jan 2021 08:55:32 -0800
X-QCInternal: smtphost
Received: from nitirawa-linux.qualcomm.com ([10.206.25.176])
  by ironmsg02-blr.qualcomm.com with ESMTP; 28 Jan 2021 22:25:05 +0530
Received: by nitirawa-linux.qualcomm.com (Postfix, from userid 2342877)
        id B641D2A73; Thu, 28 Jan 2021 22:25:05 +0530 (IST)
From:   Nitin Rawat <nitirawa@codeaurora.org>
To:     asutoshd@codeaurora.org, cang@codeaurora.org,
        stummala@codeaurora.org, vbadigan@codeaurora.org,
        alim.akhtar@samsung.com, avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com
Cc:     bvanassche@acm.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nitin Rawat <nitirawa@codeaurora.org>,
        "Bao D . Nguyen" <nguyenb@codeaurora.org>
Subject: [PATCH V1 2/3] scsi: ufs: add a vops to configure VCC voltage level
Date:   Thu, 28 Jan 2021 22:24:58 +0530
Message-Id: <1611852899-2171-3-git-send-email-nitirawa@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611852899-2171-1-git-send-email-nitirawa@codeaurora.org>
References: <1611852899-2171-1-git-send-email-nitirawa@codeaurora.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add a vops to configure VCC voltage VCC voltage level
for platform supporting both ufs2.x and ufs 3.x devices.

Signed-off-by: Nitin Rawat <nitirawa@codeaurora.org>
Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>
Signed-off-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
---
 drivers/scsi/ufs/ufshcd.c |  5 +++++
 drivers/scsi/ufs/ufshcd.h | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 000a03a..3b2e026 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -7772,6 +7772,11 @@ static int ufshcd_add_lus(struct ufs_hba *hba)
 	if (ret)
 		goto out;

+	if (ufshcd_vops_setup_vcc_regulators(hba))
+		dev_err(hba->dev,
+			"%s: Failed to set the VCC regulator values, continue with 2.7v\n",
+			__func__);
+
 	/* Initialize devfreq after UFS device is detected */
 	if (ufshcd_is_clkscaling_supported(hba)) {
 		memcpy(&hba->clk_scaling.saved_pwr_info.info,
diff --git a/drivers/scsi/ufs/ufshcd.h b/drivers/scsi/ufs/ufshcd.h
index 1410c95..250cff5 100644
--- a/drivers/scsi/ufs/ufshcd.h
+++ b/drivers/scsi/ufs/ufshcd.h
@@ -324,6 +324,7 @@ struct ufs_pwr_mode_info {
  * @device_reset: called to issue a reset pulse on the UFS device
  * @program_key: program or evict an inline encryption key
  * @event_notify: called to notify important events
+ * @setup_vcc_regulators : update vcc regulator level
  */
 struct ufs_hba_variant_ops {
 	const char *name;
@@ -360,6 +361,7 @@ struct ufs_hba_variant_ops {
 			       const union ufs_crypto_cfg_entry *cfg, int slot);
 	void	(*event_notify)(struct ufs_hba *hba,
 				enum ufs_event_type evt, void *data);
+	int    (*setup_vcc_regulators)(struct ufs_hba *hba);
 };

 /* clock gating state  */
@@ -1269,6 +1271,14 @@ static inline void ufshcd_vops_config_scaling_param(struct ufs_hba *hba,
 		hba->vops->config_scaling_param(hba, profile, data);
 }

+static inline int ufshcd_vops_setup_vcc_regulators(struct ufs_hba *hba)
+{
+	if (hba->vops && hba->vops->setup_vcc_regulators)
+		return hba->vops->setup_vcc_regulators(hba);
+
+	return 0;
+}
+
 extern struct ufs_pm_lvl_states ufs_pm_lvl_states[];

 /*
--
2.7.4

