Return-Path: <linux-scsi+bounces-24734-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U8H+DoVEK2q25QMAu9opvQ
	(envelope-from <linux-scsi+bounces-24734-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 01:28:05 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A528675CED
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 01:28:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mediatek.com header.s=dk header.b=A06wnYr4;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24734-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24734-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=mediatek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D492E32DB85B
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Jun 2026 23:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACCF3845A4;
	Thu, 11 Jun 2026 23:26:56 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704E33002C8;
	Thu, 11 Jun 2026 23:26:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781220416; cv=none; b=ezZWwHPA/DMRYG7WRX1va7jKESZj9Mj4+jTt6Ss90f26rt+qFsKBfH0g01X+BF1tt+JyHafB129Hu51jv5C6SX4Tv1O8iWfCqZEBEvMFqQxAgHUjTuy3Xm+JMEFjkbis+9ro/vr1aXYgEbBOEhVCs/LkyHD8WNg8SCEOP7SO8Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781220416; c=relaxed/simple;
	bh=MICfE6cQGAmdF7kUk0Hc+xzu12IX/5p2zShir2wvd8o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQNw8I+UMsh+Gugtpx5CYnIPkLswIzmc5mwpWkUJKmSbCFFq7txc35Lt1exy/rq9GFlFud3QDQmV2vd/uy3Ml+3HcYqn501HWjc2SHVBZUEN/bYMVzR86X7fcnlFOxG4Ba0pTj8vnaW7FI9iw1BuYmvYyPZZ8eky3d13CHG2V0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=A06wnYr4; arc=none smtp.client-ip=60.244.123.138
X-UUID: 05820db665ed11f1b1788b6acf885367-20260612
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=6JiKlfx/HnUOYKUCQrKJ4KldBeolNglSfivSs4IkEkE=;
	b=A06wnYr4Ut5or/fSvpe8vHRkUAMySvhKh/14at03776+HHolRlFny6EtttmpDFFui6Ee8OFMO8OFiGmgRfA1Fii7TDy09puziaJE8MI/qUAZwLoPoZh5LW30Jlc7X4QeeZT71Ct0/7jqJEzcuNWHET0JRIAUO5r4W0h55bjSahM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:9e0d6456-71b4-4ea5-8ac4-191c5030efe4,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e276073,CLOUDID:4a617254-902f-47df-afe3-f34f8d753c22,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|123|836|865|888|898,TC:-5,
	Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 05820db665ed11f1b1788b6acf885367-20260612
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <ed.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 504422302; Fri, 12 Jun 2026 07:26:49 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Jun 2026 07:26:48 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 12 Jun 2026 07:26:48 +0800
From: <ed.tsai@mediatek.com>
To: <alim.akhtar@samsung.com>, <avri.altman@wdc.com>, <bvanassche@acm.org>,
	<James.Bottomley@HansenPartnership.com>, <martin.petersen@oracle.com>,
	<linux-scsi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
	<peter.wang@mediatek.com>, <alice.chao@mediatek.com>,
	<naomi.chu@mediatek.com>, <chun-hung.wu@mediatek.com>, Ed Tsai
	<ed.tsai@mediatek.com>
Subject: [PATCH v2 3/3] ufs: core: Remove max_num_rtt field from ufs_hba_variant_ops
Date: Fri, 12 Jun 2026 07:26:32 +0800
Message-ID: <20260611232632.2324422-4-ed.tsai@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260611232632.2324422-1-ed.tsai@mediatek.com>
References: <20260611232632.2324422-1-ed.tsai@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-24734-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[ed.tsai@mediatek.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:alim.akhtar@samsung.com,m:avri.altman@wdc.com,m:bvanassche@acm.org,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:wsd_upstream@mediatek.com,m:peter.wang@mediatek.com,m:alice.chao@mediatek.com,m:naomi.chu@mediatek.com,m:chun-hung.wu@mediatek.com,m:ed.tsai@mediatek.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ed.tsai@mediatek.com,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[mediatek.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mediatek.com:dkim,mediatek.com:email,mediatek.com:mid,mediatek.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A528675CED

From: Ed Tsai <ed.tsai@mediatek.com>

Remove the max_num_rtt field from ufs_hba_variant_ops as it has been
replaced by the get_hba_nortt() callback which provides more flexible
platform-specific RTT capability handling.

Signed-off-by: Ed Tsai <ed.tsai@mediatek.com>
---
 drivers/ufs/core/ufshcd.c | 4 +---
 include/ufs/ufshcd.h      | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 382b6041c716..00072bff9dcd 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8557,8 +8557,6 @@ static void ufshcd_set_rtt(struct ufs_hba *hba)
 	struct ufs_dev_info *dev_info = &hba->dev_info;
 	u32 rtt = 0;
 	u32 dev_rtt = 0;
-	int host_rtt_cap = hba->vops && hba->vops->max_num_rtt ?
-			   hba->vops->max_num_rtt : hba->nortt;
 
 	/* RTT override makes sense only for UFS-4.0 and above */
 	if (dev_info->wspecversion < 0x400)
@@ -8574,7 +8572,7 @@ static void ufshcd_set_rtt(struct ufs_hba *hba)
 	if (dev_rtt != DEFAULT_MAX_NUM_RTT)
 		return;
 
-	rtt = min_t(int, dev_info->rtt_cap, host_rtt_cap);
+	rtt = min_t(int, dev_info->rtt_cap, hba->nortt);
 
 	if (rtt == dev_rtt)
 		return;
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 421c286481e8..5d72b7f2dc68 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -370,7 +370,6 @@ struct ufshcd_tx_eq_params {
 /**
  * struct ufs_hba_variant_ops - variant specific callbacks
  * @name: variant name
- * @max_num_rtt: maximum RTT supported by the host
  * @init: called when the driver is initialized
  * @exit: called to cleanup everything done in init
  * @set_dma_mask: For setting another DMA mask than indicated by the 64AS
-- 
2.45.2


