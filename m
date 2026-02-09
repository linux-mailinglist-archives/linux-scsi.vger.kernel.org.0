Return-Path: <linux-scsi+bounces-20737-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDfjKlabiWkv/gQAu9opvQ
	(envelope-from <linux-scsi+bounces-20737-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 09 Feb 2026 09:31:18 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CACA210CFF7
	for <lists+linux-scsi@lfdr.de>; Mon, 09 Feb 2026 09:31:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E32333005A94
	for <lists+linux-scsi@lfdr.de>; Mon,  9 Feb 2026 08:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C9C30ACF6;
	Mon,  9 Feb 2026 08:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SW7E0+WG"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB132D9EE2
	for <linux-scsi@vger.kernel.org>; Mon,  9 Feb 2026 08:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770625870; cv=none; b=tybgWWo1LbQPRSEzftscjfuuM8InYwqYzC+0aS0Uy3BlCjTRsYjo8/dudYZmXQ50hMb2vecbp5dbb1/GxeFG/gJi1cpPooqwx+vxn+miw52JsmLVGLU8crM4+fdVMDp1/1GMNBdVzSERzjW9ExTo657PZhohIXjhF/WjopGqr0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770625870; c=relaxed/simple;
	bh=tci7v2/wQTTIxNhWNESlUdGSCNVzxUUpG/hqElOpV+A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UtvoHlt8X7wX6x5UKfIREwfx4cPpMGXUhyoWBPsT0+YfozuG3AusKc6rEPDJijY3Wo5wOXNKYLGw7Zxumd4F0trAPqDKDbwQN8xvQ2M4ZFQD9XRz8wWSDg3X/V9PIMebbGoQtn8ZdRBD1a5NMw/5nXIjiLXCkkDL53TOH1EsLBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=SW7E0+WG; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: a78bb11e059111f185319dbc3099e8fb-20260209
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=zBbgwfdwqkk84YzciCaVx0h7HtDk3xYdkMUNRbsDpew=;
	b=SW7E0+WGAoa5qojAmF0HKgMKdP9/VAHqHde4u/u9vtqb0427EuuI9vzdpYKFXIK9+OXyr7PIsEO1+jvyla4MlbaQwlksoN4/j5y7Q93axy1RhIGMTEUd2fV1OKOvgC34IwOHr5PwXIWJUMB8g/A4eda9aWmAot0VfnkVSJFuf1c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:30f760f6-4e77-4bb3-82a7-1f21611d9084,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:8bd4165b-a957-4259-bcca-d3af718d7034,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|123|836|888|898,TC:-5,Cont
	ent:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0
	,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a78bb11e059111f185319dbc3099e8fb-20260209
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <peter.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 389915741; Mon, 09 Feb 2026 16:30:56 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 9 Feb 2026 16:30:55 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 9 Feb 2026 16:30:55 +0800
From: <peter.wang@mediatek.com>
To: <linux-scsi@vger.kernel.org>, <martin.petersen@oracle.com>,
	<avri.altman@sandisk.com>, <alim.akhtar@samsung.com>, <jejb@linux.ibm.com>
CC: <wsd_upstream@mediatek.com>, <linux-mediatek@lists.infradead.org>,
	<peter.wang@mediatek.com>, <chun-hung.wu@mediatek.com>,
	<alice.chao@mediatek.com>, <cc.chou@mediatek.com>,
	<chaotian.jing@mediatek.com>, <tun-yu.yu@mediatek.com>,
	<eddie.huang@mediatek.com>, <naomi.chu@mediatek.com>, <ed.tsai@mediatek.com>,
	<bvanassche@acm.org>
Subject: [PATCH v1 2/2] ufs: core: add debug log for mcq commnad timoeut
Date: Mon, 9 Feb 2026 16:28:48 +0800
Message-ID: <20260209083053.1467647-3-peter.wang@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260209083053.1467647-1-peter.wang@mediatek.com>
References: <20260209083053.1467647-1-peter.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[mediatek.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20737-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[17];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.wang@mediatek.com,linux-scsi@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mediatek.com:email,mediatek.com:dkim,mediatek.com:mid]
X-Rspamd-Queue-Id: CACA210CFF7
X-Rspamd-Action: no action

From: Peter Wang <peter.wang@mediatek.com>

It is difficult to debug situations where a mcq command timeout
occurs, the corresponding CQ tag response is received, but the
request is not completed.
Add a one-line log to indicate when the CQ entry is abnormal.

Signed-off-by: Peter Wang <peter.wang@mediatek.com>
---
 drivers/ufs/core/ufs-mcq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 9ab91b4c05b0..ad0ada57959a 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -301,6 +301,8 @@ static void ufshcd_mcq_process_cqe(struct ufs_hba *hba,
 		ufshcd_compl_one_cqe(hba, tag, cqe);
 		/* After processed the cqe, mark it empty (invalid) entry */
 		cqe->command_desc_base_addr = 0;
+	} else {
+		dev_err(hba->dev, "Abnormal CQ entry!\n");
 	}
 }
 
-- 
2.45.2


