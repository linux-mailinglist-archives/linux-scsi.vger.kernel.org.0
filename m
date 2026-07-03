Return-Path: <linux-scsi+bounces-25498-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jLExHmMeR2rATQAAu9opvQ
	(envelope-from <linux-scsi+bounces-25498-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 03 Jul 2026 04:28:51 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC076FDE94
	for <lists+linux-scsi@lfdr.de>; Fri, 03 Jul 2026 04:28:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=h-partners.com header.s=dkim header.b=lVrRZU0x;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=huawei.com (policy=quarantine);
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25498-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25498-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD381302C5D4
	for <lists+linux-scsi@lfdr.de>; Fri,  3 Jul 2026 02:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2ED926A1CF;
	Fri,  3 Jul 2026 02:28:41 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876D7262FD0;
	Fri,  3 Jul 2026 02:28:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783045721; cv=none; b=lsoY0ck1exsPj2uDUAYKd950nt+8A0xpTsJMWJX+LLBtTmuoERMV6U2MVX8EmelrmriaPGsrjmwy7JR05fCt7Z8lghHFTBNy5k36eszIIxg/rbTjaHNfD3/sYkvz5qnB/wI5XDGZ66P/nySlF0iiRaRwXHof2yG41j2Ci7Tn/Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783045721; c=relaxed/simple;
	bh=sf/24DL0fFpGICAVrF3DqgY44jsNGU9dRHFKkjZcsuU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iu4+nx5tvzXTxxYml8am1Eg6Nd6qiCNH1x2+K1ZjZokXGyl0HVbZDfH5t5giSVp0W5By4Cw1ViBOZTU4NzOZEho/fFVH0XGx0wYK2RX3CFQfBVR74LgGsh7PAFU20h4D6apBcldaJgnFnhwpZNKF/MXXquJ+o/LqZUpTUMY/YrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=lVrRZU0x; arc=none smtp.client-ip=113.46.200.216
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=991Kmgojy9ZGsIfwhC+pPNdOVELMJu3ABmq1jJJWuWQ=;
	b=lVrRZU0xi+2vbkiYtakzh3MGPn3aviAK5/rx2AAgJJ/KpDWszxmOaaa5nwNnXj8e9ZIdj7/jC
	UiiktARaHHJlgK3WLEndI0gTaQdCTjAIOAwyNLZBdE/j+hdsoFsF14RY6P3RmuPJDclyqjlhBL0
	0lNCaBHuHfi7PocW08qyzEM=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gryBR4r97z1T4L9;
	Fri,  3 Jul 2026 10:19:43 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
	by mail.maildlp.com (Postfix) with ESMTPS id D384D4057D;
	Fri,  3 Jul 2026 10:28:36 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 3 Jul 2026 10:28:36 +0800
From: Xingui Yang <yangxingui@huawei.com>
To: <James.Bottomley@HansenPartnership.com>, <martin.petersen@oracle.com>,
	<john.g.garry@oracle.com>, <dlemoal@kernel.org>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <yangxingui@huawei.com>, <liuyonglong@huawei.com>,
	<kangfenglong@huawei.com>
Subject: [PATCH v2 2/2] scsi: hisi_sas: add spinup_notify callback to handle Active_Wait/Idle_Wait SSP devices
Date: Fri, 3 Jul 2026 10:28:33 +0800
Message-ID: <20260703022833.36847-3-yangxingui@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260703022833.36847-1-yangxingui@huawei.com>
References: <20260703022833.36847-1-yangxingui@huawei.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemj100018.china.huawei.com (7.202.194.12)
X-Rspamd-Action: no action
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
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-25498-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:john.g.garry@oracle.com,m:dlemoal@kernel.org,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linuxarm@huawei.com,m:yangxingui@huawei.com,m:liuyonglong@huawei.com,m:kangfenglong@huawei.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[yangxingui@huawei.com,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yangxingui@huawei.com,linux-scsi@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[h-partners.com:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_SENDER_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,huawei.com:from_mime,huawei.com:email,huawei.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CFC076FDE94

When a SAS HDD disk connected via SSP (Serial Attached SCSI Protocol) is in
Active_Wait or Idle_Wait state (typical after power-up with RNOT=1), it
does not respond to standard SCSI START_STOP spinup commands. Instead it
returns NOT_READY with ASC/ASCQ = 0x04/0x11 ("notify (enable spinup)
required").

The hisi_sas controller pulses the SL_CONTROL.NOTIFY_EN bit to send a
NOTIFY(ENABLE SPINUP) primitive to the SSP device, allowing it to exit the
waiting state.

Because the spinup_notify callback runs in softirq context and
sl_notify_ssp() contains msleep(1), the callback queues a
HISI_PHYE_SPINUP_NOTIFY work item to the driver's ordered workqueue
(hisi_hba->wq) and defers the actual hardware access to process context.
The ordered workqueue serializes execution, preventing concurrent RMW
races on SL_CONTROL, and queue_work() deduplicates concurrent invocations.

Signed-off-by: Xingui Yang <yangxingui@huawei.com>
---
 drivers/scsi/hisi_sas/hisi_sas.h       |  2 ++
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 34 ++++++++++++++++++++++++++
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c |  1 +
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c |  1 +
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  1 +
 5 files changed, 39 insertions(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index 1323ed8aa717..6e21af66442d 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -163,6 +163,7 @@ enum hisi_sas_phy_event {
 	HISI_PHYE_PHY_UP   = 0U,
 	HISI_PHYE_LINK_RESET,
 	HISI_PHYE_PHY_UP_PM,
+	HISI_PHYE_SPINUP_NOTIFY,
 	HISI_PHYES_NUM,
 };
 
@@ -689,4 +690,5 @@ extern void hisi_sas_sync_cqs(struct hisi_hba *hisi_hba);
 extern void hisi_sas_sync_poll_cqs(struct hisi_hba *hisi_hba);
 extern void hisi_sas_controller_reset_prepare(struct hisi_hba *hisi_hba);
 extern void hisi_sas_controller_reset_done(struct hisi_hba *hisi_hba);
+extern void hisi_sas_spinup_notify(struct scsi_device *sdev);
 #endif
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 944ce19ae2fc..14cf01466a75 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -996,10 +996,22 @@ static void hisi_sas_phyup_pm_work(struct work_struct *work)
 	pm_runtime_put_sync(dev);
 }
 
+static void hisi_sas_spinup_notify_work(struct work_struct *work)
+{
+	struct hisi_sas_phy *phy =
+		container_of(work, typeof(*phy), works[HISI_PHYE_SPINUP_NOTIFY]);
+	struct hisi_hba *hisi_hba = phy->hisi_hba;
+	int phy_no = phy->sas_phy.id;
+
+	hisi_hba->hw->sl_notify_ssp(hisi_hba, phy_no);
+	dev_info(hisi_hba->dev, "spinup notify primitive on phy%d\n", phy_no);
+}
+
 static const work_func_t hisi_sas_phye_fns[HISI_PHYES_NUM] = {
 	[HISI_PHYE_PHY_UP] = hisi_sas_phyup_work,
 	[HISI_PHYE_LINK_RESET] = hisi_sas_linkreset_work,
 	[HISI_PHYE_PHY_UP_PM] = hisi_sas_phyup_pm_work,
+	[HISI_PHYE_SPINUP_NOTIFY] = hisi_sas_spinup_notify_work,
 };
 
 bool hisi_sas_notify_phy_event(struct hisi_sas_phy *phy,
@@ -2474,6 +2486,28 @@ int hisi_sas_get_fw_info(struct hisi_hba *hisi_hba)
 }
 EXPORT_SYMBOL_GPL(hisi_sas_get_fw_info);
 
+void hisi_sas_spinup_notify(struct scsi_device *sdev)
+{
+	struct domain_device *dev = sdev_to_domain_dev(sdev);
+	struct sas_ha_struct *sha;
+	struct hisi_hba *hisi_hba;
+	struct sas_phy *local_phy;
+	struct hisi_sas_phy *phy;
+
+	if (dev->parent && dev_is_expander(dev->parent->dev_type))
+		return;
+
+	sha = SHOST_TO_SAS_HA(sdev->host);
+	hisi_hba = sha->lldd_ha;
+
+	local_phy = sas_get_local_phy(dev);
+	phy = &hisi_hba->phy[local_phy->number];
+	if (phy->identify.target_port_protocols & SAS_PROTOCOL_SSP)
+		hisi_sas_notify_phy_event(phy, HISI_PHYE_SPINUP_NOTIFY);
+	sas_put_local_phy(local_phy);
+}
+EXPORT_SYMBOL_GPL(hisi_sas_spinup_notify);
+
 static struct Scsi_Host *hisi_sas_shost_alloc(struct platform_device *pdev,
 					      const struct hisi_sas_hw *hw)
 {
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index fa94d7110714..0179c33f08d4 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -1760,6 +1760,7 @@ static const struct scsi_host_template sht_v1_hw = {
 	.sdev_init		= hisi_sas_sdev_init,
 	.shost_groups		= host_v1_hw_groups,
 	.host_reset		= hisi_sas_host_reset,
+	.spinup_notify		= hisi_sas_spinup_notify,
 };
 
 static const struct hisi_sas_hw hisi_sas_v1_hw = {
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index f3516a0611dd..82708a3e71c2 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3597,6 +3597,7 @@ static const struct scsi_host_template sht_v2_hw = {
 	.host_reset		= hisi_sas_host_reset,
 	.map_queues		= map_queues_v2_hw,
 	.host_tagset		= 1,
+	.spinup_notify		= hisi_sas_spinup_notify,
 };
 
 static const struct hisi_sas_hw hisi_sas_v2_hw = {
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 901f508e8be7..330da2503b75 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -3417,6 +3417,7 @@ static const struct scsi_host_template sht_v3_hw = {
 	.host_reset		= hisi_sas_host_reset,
 	.host_tagset		= 1,
 	.mq_poll		= queue_complete_v3_hw,
+	.spinup_notify		= hisi_sas_spinup_notify,
 };
 
 static const struct hisi_sas_hw hisi_sas_v3_hw = {
-- 
2.43.0


