Return-Path: <linux-scsi+bounces-21481-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAg+MUQnqWkL2gAAu9opvQ
	(envelope-from <linux-scsi+bounces-21481-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 05 Mar 2026 07:48:36 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF4820BDBB
	for <lists+linux-scsi@lfdr.de>; Thu, 05 Mar 2026 07:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E6853026A8B
	for <lists+linux-scsi@lfdr.de>; Thu,  5 Mar 2026 06:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A2230BB93;
	Thu,  5 Mar 2026 06:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="NTM/u94y"
X-Original-To: linux-scsi@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15BD336896;
	Thu,  5 Mar 2026 06:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772693230; cv=none; b=L/eJ7tKLGNMdxZRbSqw0YvQsGnyUiaKQn3eB68OToWngY5/RHQiuzXrzrXejDN5HCSRMSgsxGojtCG75jCtUGcHsN2uVVE4eKESjhDSUL5oqly9dz1oJqN/L1P2wYALNaF2nTmqMaJ77ASpkBCH8dZKF++WlZgQGEVCcQRU35Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772693230; c=relaxed/simple;
	bh=T+S8kftzIEGtGBHHY4aqv28KBazVlbZNJZhSMsbai4U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ncTVdZA0Wmo0A25XUNSQj3d5bDh2fGMB7nYwU589Ne7sxkcU3vkFX+BUrALWtx9/fNJ1MaXaYG/W9jJrB4iijimd/U/xs0wxbjpJAEgZuDw5BdmGgr5pcGurilkxQAvaE+BYfyCHFA2RgE5NIpwgYuusdJl5g2ZS+LhkZwmdSE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=NTM/u94y; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=NAv6EiRKzKHrk4156Api7kyciszsULpevwMZqz+i+SM=;
	b=NTM/u94ynFSa/VuVDI4FieDR3yxNG0SVxkwncgMg3/U+0uZ3yYUs0npiljF+/1WSyoerhmiW8
	29IOQTJd72xUYXewHH2QmQaj+3BZQsRMU1+DihyB2J9pGPt2rwzPhi6c7eQKDfg6+4JCxv00Kmd
	7+BqkmTdZL197Xzde/hkmzE=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fRKhf4Gq7zRhSc;
	Thu,  5 Mar 2026 14:42:10 +0800 (CST)
Received: from kwepemh200005.china.huawei.com (unknown [7.202.181.112])
	by mail.maildlp.com (Postfix) with ESMTPS id 83DCC2025F;
	Thu,  5 Mar 2026 14:47:01 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemh200005.china.huawei.com (7.202.181.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 5 Mar 2026 14:47:00 +0800
From: Yihang Li <liyihang9@huawei.com>
To: <martin.petersen@oracle.com>, <James.Bottomley@HansenPartnership.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yangxingui@h-partners.com>, <linuxarm@huawei.com>, <prime.zeng@huawei.com>,
	<liyihang9@h-partners.com>, <liuyonglong@huawei.com>
Subject: [RESEND PATCH 1/2] scsi: hisi_sas: Correct the printing format issues
Date: Thu, 5 Mar 2026 14:46:59 +0800
Message-ID: <20260305064700.116033-2-liyihang9@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260305064700.116033-1-liyihang9@huawei.com>
References: <20260305064700.116033-1-liyihang9@huawei.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemh200005.china.huawei.com (7.202.181.112)
X-Rspamd-Queue-Id: 1CF4820BDBB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[huawei.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[h-partners.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[liyihang9@huawei.com,linux-scsi@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-21481-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[h-partners.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[h-partners.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:mid,huawei.com:email]
X-Rspamd-Action: no action

There are some print format errors, fix them.

Signed-off-by: Yihang Li <liyihang9@huawei.com>
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


