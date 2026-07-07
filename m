Return-Path: <linux-scsi+bounces-25749-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Lw6BIl2VTGpemgEAu9opvQ
	(envelope-from <linux-scsi+bounces-25749-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 07:57:49 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF6A717A81
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 07:57:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=ksWUC8UK;
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25749-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25749-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 786603027783
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jul 2026 05:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0270202C48;
	Tue,  7 Jul 2026 05:57:39 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7546227466A
	for <linux-scsi@vger.kernel.org>; Tue,  7 Jul 2026 05:57:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783403859; cv=none; b=Lz5+YxdfO34uJcEGVbznwnO7lev4RRfOe/0t7jPURAnkpIJZB7Wt3X2rwPyhFbnw9GdnspMtoYy5QgtUgPYg6RqDtQyQbiOksSauLmmreTgNS54RxoWhmzkISTAy8kkvDq1m6yNyyRITWJ/K7HRJm5OY0/Sv6UJ8xBSYz/djUgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783403859; c=relaxed/simple;
	bh=zGdsvescZt/qJutSQkblgn3gWozeFE7uSu7/EFHYl9Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bMJkiGnKUEtpaPLR2Ngh3CIuKufLspWtIw5DzgNKwjXoDBLMkR4paGXS50KZS1NdbxFRMib0Bji9ayEFEmh74+zR01uG+WC/SEvj0QitdlB/UPrFGVGYF5IgznUlupVW/VTosnpLAU58jLJSCnNaueFHizzQTe98FHLLpO590zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=ksWUC8UK; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66748itd1619388;
	Mon, 6 Jul 2026 22:57:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=Q
	ydtLyhWLzUXPJZUFx8xQR/qfDzfsjyL6QJ66Z2wzlY=; b=ksWUC8UKFNQ8N/ryj
	kA41z0anHjtEbJPDe78Sw89kiugPF4TfJje9zeJLcu42VxDZTgD0map/j1DbLGMH
	ST1IbK8Of7TsfDII7cgtVs0zz5I1taeY63jHRo/7qCxDbmI2TLBAxMi28jkHlwyM
	ZtS7qUALloqjYh5YS8Cg5rj/NTN0+9YSfy+DJBgFECKoiVPoKF/L2QE23L1fJGQN
	t9vnow0vY4lQfAoipnL0LpV2yQwIl3hpVPXaOSQf0ThpIuMC/RDvGu63S3PI59F6
	y901jF1sQdxqI257T4j3A+MFu8kHs6GAKiV3IzFZGPJzYpguciG0GXK9L6351qS9
	4lbOg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4f8p31gqkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 22:57:34 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 6 Jul 2026 22:57:34 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 6 Jul 2026 22:57:34 -0700
Received: from stgdev-a5u16.punelab.marvell.com (stgdev-a5u16.punelab.marvell.com [10.31.33.164])
	by maili.marvell.com (Postfix) with ESMTP id 0B9FC3F7066;
	Mon,  6 Jul 2026 22:57:31 -0700 (PDT)
From: Nilesh Javali <njavali@marvell.com>
To: <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <GR-FC-Storage-Upstream@marvell.com>,
        <agurumurthy@marvell.com>, <emilne@redhat.com>, <jmeneghi@redhat.com>,
        <hare@suse.com>
Subject: [PATCH v3 53/88] scsi: qla2xxx: Zero dport diagnostics buffer to avoid info leak
Date: Tue, 7 Jul 2026 11:24:00 +0530
Message-ID: <20260707055435.2680300-54-njavali@marvell.com>
X-Mailer: git-send-email 2.23.1
In-Reply-To: <20260707055435.2680300-1-njavali@marvell.com>
References: <20260707055435.2680300-1-njavali@marvell.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA1NCBTYWx0ZWRfX9x+/VA/j4yeL
 7UUjqSDuNG3dVG9FWK6BhqMUQNMcPtbm9R2HZnbizjzl5r4ZHGilLRzazFjW2jkB2YCka5Ng0/a
 c9rrfUKNhYYStTkyvqtf6WLiuM6BoAQ=
X-Proofpoint-GUID: OUtC_bBDEpwpRfzK0tWfc--9xVm9B6e0
X-Proofpoint-ORIG-GUID: OUtC_bBDEpwpRfzK0tWfc--9xVm9B6e0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA1NCBTYWx0ZWRfX8YDwb0uBUqj+
 tzTbwkZ1wh7pVYi/+Qlj+J7hz78PiO/70bxnzS+8YMVUOwbewWWxjfrI7PjYvAKkr7RMzu+aEbY
 2XsM6tT8MOJkWrNoVG4satIJYGdGOd2mVPC9SpgwLflC5MLns32Pe9X+5EIbzkq4VCYfdvkd8lW
 NoK5tEh2u59FJ/8RSSa3N718B27z+y9Tqf7NyrRKJy6L8DHF+VBYkmfq1gqsrY/DWaNCh9r0D/D
 j97LuxJ+E8svw2xvqOlN6rYlW7FHnupsKANH5dePO862kSv2koeOVVwM3LQUD5pbI6HPz3WK69C
 24YmuZmJqxhVC36MPfwcyBy/m8Me//Jh38MdB4JdhtSkrZxn0X3Avl///55cfxrQp/cM3StOyde
 CK/5WK7Ny44XfqNcbvj8rtfPXmJgcbfA8KQemk0K++Gn1OvcgtSsayKxem4DaBZJqswyxbcylQw
 NH185C25EGfuj2iUe9A==
X-Authority-Analysis: v=2.4 cv=c5ubhx9l c=1 sm=1 tr=0 ts=6a4c954e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=cZcaXCM-GTnW6IyOXjwA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_01,2026-07-06_02,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25749-lists,linux-scsi=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[njavali@marvell.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:GR-FC-Storage-Upstream@marvell.com,m:agurumurthy@marvell.com,m:emilne@redhat.com,m:jmeneghi@redhat.com,m:hare@suse.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[njavali@marvell.com,linux-scsi@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:from_mime,marvell.com:email,marvell.com:mid,marvell.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2BF6A717A81

qla2x00_do_dport_diagnostics() allocates the qla_dport_diag response
buffer with kmalloc_obj() (non-zeroing) and, on success, copies the
full sizeof(*dd) back to user space via sg_copy_from_buffer(). The
inbound sg_copy_to_buffer() only fills as many bytes as the user
request payload provides, and qla26xx_dport_diagnostics() zeroes only
dd->buf. The options and unused[] fields are therefore copied out
uninitialized, leaking kernel heap contents to user space.

Allocate with kzalloc_obj(), matching qla2x00_do_dport_diagnostics_v2().

Fixes: ec89146215d1 ("qla2xxx: Add bsg interface to support D_Port Diagnostics.")
Cc: stable@vger.kernel.org
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/scsi/qla2xxx/qla_bsg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_bsg.c b/drivers/scsi/qla2xxx/qla_bsg.c
index fade3638d31c..e7739cead967 100644
--- a/drivers/scsi/qla2xxx/qla_bsg.c
+++ b/drivers/scsi/qla2xxx/qla_bsg.c
@@ -2792,7 +2792,7 @@ qla2x00_do_dport_diagnostics(struct bsg_job *bsg_job)
 	    !IS_QLA28XX(vha->hw) && !IS_QLA29XX(vha->hw))
 		return -EPERM;
 
-	dd = kmalloc_obj(*dd);
+	dd = kzalloc_obj(*dd);
 	if (!dd) {
 		ql_log(ql_log_warn, vha, 0x70db,
 		    "Failed to allocate memory for dport.\n");
-- 
2.47.3


