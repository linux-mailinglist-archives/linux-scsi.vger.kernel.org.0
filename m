Return-Path: <linux-scsi+bounces-24286-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENvmKEtgHWo/ZwkAu9opvQ
	(envelope-from <linux-scsi+bounces-24286-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 01 Jun 2026 12:34:51 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0025861D8F3
	for <lists+linux-scsi@lfdr.de>; Mon, 01 Jun 2026 12:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 52DBF301F811
	for <lists+linux-scsi@lfdr.de>; Mon,  1 Jun 2026 10:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86B33932C0;
	Mon,  1 Jun 2026 10:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="DgJUAPHG"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E07D2BE65B
	for <linux-scsi@vger.kernel.org>; Mon,  1 Jun 2026 10:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309791; cv=none; b=l6/dZweXAD775bY4K/SCXScFozo0moiahQobQaXjJ2yxV885BBaQ1qJIcjJNWmO9MWRf6axC/z9SlAasVLMcPCaK43heXIPtoiNmSua2cQFBxl9uETXiPpZG3T2R141PioXmpUKnOBYJCWwSs+J6HZ9/B4S86I1Be9fAUYxS0SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309791; c=relaxed/simple;
	bh=aovmORRTgRZrUa+OoQYIGWLllaAhuvu2XM/c7QFhjxo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k3ckktIq/yB5jv5awcTYP5X0ijuX1QVm1PuV7Oo1ZWl3I8qHyov0xhUiTR/zpQWFIGfhIz/NdjMSoQnXQ0bFEzztsVx5JtsapY4z0329AfPkm+b4QIubulz4dXkQ4tXyAwFz8x/J4vdOCCr61f7Aj6ESvYUw/n93ynZwMfsrCww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=DgJUAPHG; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64VKPZeB857198;
	Mon, 1 Jun 2026 03:29:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=x
	yZGUdhcL+KnEOhDhPqcTb9+RkFZSj5N9DzwEZYwCx0=; b=DgJUAPHGE4IOXXDgh
	iyWXcLsCNXA1227ZMukZSCkdIhITSm+dNxX/0fsv1MP32sq9rLFewjlAK0OwOti6
	AgGvbkd7r3fHJGnL03By2WDz3QrjrSUYqmrKEA1QwiQTaELyoC9wP10DU3SpowqV
	pOwpMsKvStoq14RMffEbhDkjx4Fu53tN4qk8RYvknSgcVSstgOuFIPeRE0EYrTeQ
	MSSFercUVtPxWqcTJAneyy/KRqxTtGww7ahOwu5mpHKXO8EIHsXIpUwKgg3VXj6Z
	B3dS/AwVA6sXWJULS0gfPGGjMDmLzi7K+Pk4D5GHxfuy5r1CluNfic7/o6grkF+F
	JW53A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4efw8hwpmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jun 2026 03:29:47 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 1 Jun 2026 03:29:46 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 1 Jun 2026 03:29:46 -0700
Received: from stgdev-a5u16.punelab.marvell.com (stgdev-a5u16.punelab.marvell.com [10.31.33.164])
	by maili.marvell.com (Postfix) with ESMTP id D6C033F7053;
	Mon,  1 Jun 2026 03:29:43 -0700 (PDT)
From: Nilesh Javali <njavali@marvell.com>
To: <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <GR-QLogic-Storage-Upstream@marvell.com>,
        <agurumurthy@marvell.com>, <emilne@redhat.com>, <jmeneghi@redhat.com>,
        <hare@suse.com>
Subject: [PATCH 10/44] scsi: qla2xxx: Add extended status continuation and marker IOCBs
Date: Mon, 1 Jun 2026 15:58:19 +0530
Message-ID: <20260601102853.328426-11-njavali@marvell.com>
X-Mailer: git-send-email 2.23.1
In-Reply-To: <20260601102853.328426-1-njavali@marvell.com>
References: <20260601102853.328426-1-njavali@marvell.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDEwNSBTYWx0ZWRfX/52qOIBMCGcl
 9LP8d76d4xPBKhc61DPok0IADCBYxwm8Ra2fkWDzW4by3gVMRRAAffTDfsb15o0JAFlgCYRZaDT
 dfQgFVyPCF8T1ey7RSqmBo8LRKIcYpF7i6JQCxaqhkIIuPDhRAgUbyxM2s3x+89tKRqglcVrFoZ
 h7yEKYeYBSvM5lHYH0sMTBSw/a8GJQL9ky5N1GNqgmcvO4O5K/b6V8JhFnOLu2NonwCxWzcl7xb
 5OyPbauIAqza6NpCyRCpYoP4ncAVs5hY+Bd3UHmcC2fjEC4jvV6xCgiJkrpLCj3WoLYBc1a5U7c
 muaMV+y0SyIa4rQyGR8C8+hoY20UqqTF7dbE7ldCHM13rE3iZ7vRalTM+nSLJ/GM0ApwYRAC05P
 QLEQaJsgahTfPg5reSNHyUBIdp1VoIEJu+A0yD55ppKxuUGhXe7Rl/2vRMbqjuRPGJbkGtzw2yS
 jhYjap7P94F8pehPATA==
X-Proofpoint-GUID: EvJntJV6WTp9Nv1SHAZP5st1uyqQJMoO
X-Proofpoint-ORIG-GUID: EvJntJV6WTp9Nv1SHAZP5st1uyqQJMoO
X-Authority-Analysis: v=2.4 cv=F99nsKhN c=1 sm=1 tr=0 ts=6a1d5f1b cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8
 a=dH9mCnKsI0P63bTXedQA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_03,2026-05-28_03,2025-10-01_01
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24286-lists,linux-scsi=lfdr.de];
	DKIM_TRACE(0.00)[marvell.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,marvell.com:email,marvell.com:mid,marvell.com:dkim];
	TAGGED_RCPT(0.00)[linux-scsi];
	FROM_NEQ_ENVFROM(0.00)[njavali@marvell.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 0025861D8F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Anil Gurumurthy <agurumurthy@marvell.com>

Add the 128-byte sts_cont_entry_ext_t and mrk_entry_ext_t
structures required by 29xx firmware.  Include the qla_fw29.h
header from qla_def.h so the new types are available throughout
the driver.

Cc: stable@vger.kernel.org
Signed-off-by: Anil Gurumurthy <agurumurthy@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_def.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 7423687578dc..485c744a59fb 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -337,6 +337,7 @@ static inline void wrt_reg_dword(volatile __le32 __iomem *addr, u32 data)
 
 #define MAX_CMDSZ	16		/* SCSI maximum CDB size. */
 #include "qla_fw.h"
+#include "qla_fw29.h"
 
 struct name_list_extended {
 	struct get_name_list_extended *l;
@@ -2360,6 +2361,38 @@ typedef struct {
 	uint8_t reserved_2[48];
 } mrk_entry_t;
 
+/* 29xx definitions */
+struct sts_cont_entry_ext {
+	uint8_t entry_type;		/* Entry type. */
+	uint8_t entry_count;		/* Entry count. */
+	uint8_t sys_define;		/* System defined. */
+	uint8_t entry_status;		/* Entry Status. */
+	uint8_t data[124];		/* data */
+};
+
+/*
+ * ISP queue - marker entry structure definition.
+ */
+struct mrk_entry_ext {
+	uint8_t entry_type;		/* Entry type. */
+	uint8_t entry_count;		/* Entry count. */
+	uint8_t handle_count;		/* Handle count. */
+	uint8_t entry_status;		/* Entry Status. */
+	uint32_t sys_define_2;		/* System defined. */
+	target_id_t target;		/* SCSI ID */
+	uint8_t modifier;		/* Modifier (7-0). */
+#define MK_SYNC_ID_LUN	0		/* Synchronize ID/LUN */
+#define MK_SYNC_ID	1		/* Synchronize ID */
+#define MK_SYNC_ALL	2		/* Synchronize all ID/LUN */
+#define MK_SYNC_LIP	3		/* Synchronize all ID/LUN, */
+					/* clear port changed, */
+					/* use sequence number. */
+	uint8_t reserved_1;
+	__le16	sequence_number;	/* Sequence number of event */
+	__le16	lun;			/* SCSI LUN */
+	uint8_t reserved_2[112];
+};
+
 /*
  * ISP queue - Management Server entry structure definition.
  */
-- 
2.47.3


