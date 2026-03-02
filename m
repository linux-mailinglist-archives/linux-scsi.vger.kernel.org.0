Return-Path: <linux-scsi+bounces-21295-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AA+BMxs0pWmh5gUAu9opvQ
	(envelope-from <linux-scsi+bounces-21295-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 02 Mar 2026 07:54:19 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 515CF1D397F
	for <lists+linux-scsi@lfdr.de>; Mon, 02 Mar 2026 07:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADD9130401B4
	for <lists+linux-scsi@lfdr.de>; Mon,  2 Mar 2026 06:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85FB1862A;
	Mon,  2 Mar 2026 06:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="dP7Mgxo7"
X-Original-To: linux-scsi@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A297737FF62;
	Mon,  2 Mar 2026 06:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772434317; cv=none; b=EhnY400UXaVbS3Fg1coXmZQze4RTSx2fJ+N6A7M7pyQoV5dPGXHfNfQEFZ9TBvFspkSyIT1/ewEBFZ45nltYrufDENYVipaZGvVtYevRLR1RK6nkcTHCPy//Rch+2Rs3rDngoqyzgz9yaLsCtI2Rogw9BIdjVzfybz51ti/dVSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772434317; c=relaxed/simple;
	bh=NXL1fSdw2j8VrVqLQwKYTnfZ2QpPruguXE/wymW+wo8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hPqO1q7ygemFZ8nIcAmtevoVXvZgUNtcnTyiy+mH3xO3cv78QFE7eoXBs+ZDgwCUoEwM6N1BeJInIdl6Ymd3ovTlgzcKkrCJNr18K0bytUs49Dxbp3JIclC1/hr1Xz6Yx9P5mrHmSkG/TkRhhFBffrx/eTYzHUiTTBteEnEKHhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=dP7Mgxo7; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=jcMQo5PHKJimYbvXJBwbsloW3Yqpul6ZzVeuzezcJ8E=;
	b=dP7Mgxo7mKsZ2MoDMMFcxuhhKeaSxpHSe/YD0AtGODmhZlJv9nZUtEvFew1tYRsde1lqvPOAL
	ACyJUXKXAIDQD4AT8+kX/uX+UPAQQppLLxeunY6traTsAveR5EYzk2ImO8gsbi9cvnOdCzQmVl9
	yCzc2CkgjIjrW8QNGuyYq1Q=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fPTxm6SxvznTW0;
	Mon,  2 Mar 2026 14:47:08 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
	by mail.maildlp.com (Postfix) with ESMTPS id C16674056C;
	Mon,  2 Mar 2026 14:51:46 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 2 Mar 2026 14:51:46 +0800
From: Xingui Yang <yangxingui@huawei.com>
To: <martin.petersen@oracle.com>, <James.Bottomley@HansenPartnership.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yangxingui@huawei.com>, <linuxarm@huawei.com>, <prime.zeng@huawei.com>,
	<liyihang9@huawei.com>, <liuyonglong@huawei.com>, <kangfenglong@huawei.com>
Subject: [PATCH 1/2] scsi: hisi_sas: Correct the printing format issues
Date: Mon, 2 Mar 2026 14:51:34 +0800
Message-ID: <20260302065135.841653-2-yangxingui@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260302065135.841653-1-yangxingui@huawei.com>
References: <20260302065135.841653-1-yangxingui@huawei.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemj100018.china.huawei.com (7.202.194.12)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[h-partners.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[yangxingui@huawei.com,linux-scsi@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21295-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[h-partners.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:mid,huawei.com:email,h-partners.com:dkim]
X-Rspamd-Queue-Id: 515CF1D397F
X-Rspamd-Action: no action

From: Yihang Li <liyihang9@huawei.com>

There are some print format errors, fix them.

Signed-off-by: Yihang Li <liyihang9@huawei.com>
Signed-off-by: Xingui Yang <yangxingui@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 2 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 30a9c6612651..00e4b59ff711 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1326,7 +1326,7 @@ static int hisi_sas_control_phy(struct asd_sas_phy *sas_phy, enum phy_func func,
 
 	if (sts && !wait_for_completion_timeout(&completion,
 		HISI_SAS_WAIT_PHYUP_TIMEOUT)) {
-		dev_warn(dev, "phy%d wait phyup timed out for func %d\n",
+		dev_warn(dev, "phy%d wait phyup timed out for func %u\n",
 			 phy_no, func);
 		if (phy->in_reset)
 			ret = -ETIMEDOUT;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 2f9e01717ef3..6a841d53bb10 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -896,7 +896,7 @@ static void setup_itct_v3_hw(struct hisi_hba *hisi_hba,
 			qw0 = HISI_SAS_DEV_TYPE_SATA << ITCT_HDR_DEV_TYPE_OFF;
 		break;
 	default:
-		dev_warn(dev, "setup itct: unsupported dev type (%d)\n",
+		dev_warn(dev, "setup itct: unsupported dev type (%u)\n",
 			 sas_dev->dev_type);
 	}
 
@@ -2847,7 +2847,7 @@ static void wait_cmds_complete_timeout_v3_hw(struct hisi_hba *hisi_hba,
 static ssize_t intr_conv_v3_hw_show(struct device *dev,
 				    struct device_attribute *attr, char *buf)
 {
-	return scnprintf(buf, PAGE_SIZE, "%u\n", hisi_sas_intr_conv);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", hisi_sas_intr_conv);
 }
 static DEVICE_ATTR_RO(intr_conv_v3_hw);
 
@@ -3293,7 +3293,7 @@ static int debugfs_set_bist_v3_hw(struct hisi_hba *hisi_hba, bool enable)
 	u32 *fix_code = &hisi_hba->debugfs_bist_fixed_code[0];
 	struct device *dev = hisi_hba->dev;
 
-	dev_info(dev, "BIST info:phy%d link_rate=%d code_mode=%d path_mode=%d ffe={0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x} fixed_code={0x%x, 0x%x}\n",
+	dev_info(dev, "BIST info:phy%u link_rate=%u code_mode=%u path_mode=%u ffe={0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x, 0x%x} fixed_code={0x%x, 0x%x}\n",
 		 phy_no, linkrate, code_mode, path_mode,
 		 ffe[FFE_SAS_1_5_GBPS], ffe[FFE_SAS_3_0_GBPS],
 		 ffe[FFE_SAS_6_0_GBPS], ffe[FFE_SAS_12_0_GBPS],
@@ -3650,7 +3650,7 @@ static void debugfs_print_reg_v3_hw(u32 *regs_val, struct seq_file *s,
 	int i;
 
 	for (i = 0; i < reg->count; i++) {
-		int off = i * HISI_SAS_REG_MEM_SIZE;
+		u32 off = i * HISI_SAS_REG_MEM_SIZE;
 		const char *name;
 
 		name = debugfs_to_reg_name_v3_hw(off, reg->base_off,
-- 
2.33.0


