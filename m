Return-Path: <linux-scsi+bounces-24208-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGqyAo7rGGpnowgAu9opvQ
	(envelope-from <linux-scsi+bounces-24208-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 29 May 2026 03:27:42 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAEB5FC027
	for <lists+linux-scsi@lfdr.de>; Fri, 29 May 2026 03:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D980830670A2
	for <lists+linux-scsi@lfdr.de>; Fri, 29 May 2026 01:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED752E4257;
	Fri, 29 May 2026 01:26:28 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD888834;
	Fri, 29 May 2026 01:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780017988; cv=none; b=Y9VP/uxiWazu4iNxH9EuhkTmWAbKbps7mg2NPX4KEQkorJJGMh64i5sg5VTXVc1Iw3Tb3VawhfGTE6MvU2ng3uzhTjXMUB4KtyT4PDC8nzk/PUzChFANG5bmimL3tv+gx6C8n42D+/M7Au6gdyUd073SwMrSh2RaX6BLQtXBjuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780017988; c=relaxed/simple;
	bh=A6jOFu3Ky9NEYtgpNyQIfXbOORWaLkn2b/tyjgDpK9A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J/tDsaapFB48R7z9WavTSSmuM6by6eOPd+QuMU3YqzPfHmAPeMO8I4/zS/pSpWpy45KUBnavza7VAf15Gbar+BaoTEFjpT5elONZ2hJD/AqkW6qiLldO0s2zkjF1vJcPB21k3ASQ114+wTOA8/BI44bUMIp0kGYN4ZLYg9OrCrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8BxNeg_6xhqOWIOAA--.34781S3;
	Fri, 29 May 2026 09:26:23 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJDx6+A+6xhqV2yUAA--.20589S2;
	Fri, 29 May 2026 09:26:22 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	Chandrakanth patil <chandrakanth.patil@broadcom.com>
Cc: James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	megaraidlinux.pdl@broadcom.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangtianyang@loongson.cn
Subject: [PATCH] scsi: megaraid_sas: Add dma read memory barrier during complete command poll
Date: Fri, 29 May 2026 09:26:20 +0800
Message-Id: <20260529012620.815886-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDx6+A+6xhqV2yUAA--.20589S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-24208-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[loongson.cn];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_NEQ_ENVFROM(0.00)[maobibo@loongson.cn,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,loongson.cn:mid,loongson.cn:email]
X-Rspamd-Queue-Id: 7BAEB5FC027
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Control dependencies do not guarantee load order across the condition,
allowing a CPU to predict and speculate memory reads.

Add a dma read barrier before reading the complete SMID entry in
structure reply_des and after the condition its contents depend on to
ensure the read order is determinsitic.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index 2699e4e09b5b..6ec6e5fa71ce 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -3589,6 +3589,8 @@ complete_cmd_fusion(struct megasas_instance *instance, u32 MSIxIndex,
 	while (d_val.u.low != cpu_to_le32(UINT_MAX) &&
 	       d_val.u.high != cpu_to_le32(UINT_MAX)) {
 
+		/* Read SIMD after ReplyFlags and d_val.word check */
+		dma_rmb();
 		smid = le16_to_cpu(reply_desc->SMID);
 		cmd_fusion = fusion->cmd_list[smid - 1];
 		scsi_io_req = (struct MPI2_RAID_SCSI_IO_REQUEST *)

base-commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7
-- 
2.39.3


