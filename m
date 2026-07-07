Return-Path: <linux-scsi+bounces-25760-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Yae8AxOWTGqWmgEAu9opvQ
	(envelope-from <linux-scsi+bounces-25760-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 08:00:51 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 013BD717B15
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 08:00:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=RcMpg0+N;
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25760-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25760-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E3B303009388
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jul 2026 05:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F793101CE;
	Tue,  7 Jul 2026 05:58:10 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AE737C902
	for <linux-scsi@vger.kernel.org>; Tue,  7 Jul 2026 05:58:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783403890; cv=none; b=B3cFyrvYEOwwjDnNEm+1tkv/KDfbqk27x54fb+9P0OvgI1ALMvX9sOcTSvcxCE+TB4uaYf620/ftkPYaQJMJz6F6U6BYxmyTr0wxikFjtKcmi8dUCnThX17Vm8icjhBY/FbfXOt+tAK4v7onkKjG7Pvp8aUM/8siWOJFrwNKkgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783403890; c=relaxed/simple;
	bh=w7jSaf1bSkmJZDCU4pDBOPdY3z+jz0bc5/R1Y9phK8A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jsYtPFXKpvq/LMdp6o8iAjC0HGiGL2p4JwJYhND6yFDoCbI4j9hOFxjFLgezGSlRpJxEN0okLTZhwOLVfTzzBKsRtCy5vZopdAhEig61ZyuOVYVIFmrYKoISIjsNCyZVRX0SRhMJ4S5ZQFRk1GI6FRavphI8ztwceNKbFOQfP3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=RcMpg0+N; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66748kWC1656479;
	Mon, 6 Jul 2026 22:58:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=z
	s41WJTpkCyjT4S7ESDO2r3yIQD7kNbY2ocOrZolkbU=; b=RcMpg0+NJQ3ElRoDA
	nBT5vcxoDsa0nr2cIh66DaRsdRdzsl+lbdbI/hZMTq5dUmDExg6DCPn1tEKnfn9v
	GiPAJUielmdGXt66pSL9aIkzfjzrBBdT89Jbspqfcvo06FzWIF3hHfWkH6/Hpsm1
	GrFNZFF8LIUYA0VvCJIRUC9elF/I5eInnOdqqv8Z9vA7XM8pWUARdl79+9iLS9YB
	C6If4rE6e3YD15kmqdlexVkQ0aFWAoFw2oTfEdzREo1ZXIYchq8Y+tvIhbg9nKWw
	26/SbTAGKXnH4M1J8td1oIZUHevuJ4RJgAyGlzR9ncM0FnepMbA2pLbLVpyYA45p
	L/yRg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4f71phqe1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 22:58:06 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 6 Jul 2026 22:58:06 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 6 Jul 2026 22:58:06 -0700
Received: from stgdev-a5u16.punelab.marvell.com (stgdev-a5u16.punelab.marvell.com [10.31.33.164])
	by maili.marvell.com (Postfix) with ESMTP id ABC863F7066;
	Mon,  6 Jul 2026 22:58:03 -0700 (PDT)
From: Nilesh Javali <njavali@marvell.com>
To: <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <GR-FC-Storage-Upstream@marvell.com>,
        <agurumurthy@marvell.com>, <emilne@redhat.com>, <jmeneghi@redhat.com>,
        <hare@suse.com>
Subject: [PATCH v3 64/88] scsi: qla2xxx: Fix FCE trace enable parsing in debugfs
Date: Tue, 7 Jul 2026 11:24:11 +0530
Message-ID: <20260707055435.2680300-65-njavali@marvell.com>
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
X-Proofpoint-GUID: c2qIphDakJVhACdug9oJCA4xg53PR8YL
X-Authority-Analysis: v=2.4 cv=Hf4kiCE8 c=1 sm=1 tr=0 ts=6a4c956f cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=kHUOPGJzchApZ1z3-SAA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: c2qIphDakJVhACdug9oJCA4xg53PR8YL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA1NCBTYWx0ZWRfXw7uRWcP0lgoO
 t6ZceWfFqMEiC61MN/R8JbbjT2/+EwUFJ3OoRlu9DelKwnOmpXd8eLGrkoZWv25755KOaw0qhY7
 9o6NT+F+RdxjPvWeRsEpYqxhRS4ddA4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA1NCBTYWx0ZWRfX/MIqSUdRpmIj
 NKONrkJ8p0vegRSM3452sLIA3UPF64Ce+mQwrhhkGOkDADlGRHZnGL/TwD5GyQ4A/MIu/xk43ik
 FvhVPSlK5NNb3nOCkwHiZ0aCudv4XZyEu/Us2ASZEVUavu79SgzsdD9IDOA61JwlCgEoiDYl4A8
 eMj3uX1KcSqwR3luJshx7E+5hB8mabp4eg2MmGFY/RhhD0rvYX85xSza3bysXRrnsfbNVYKj7Bp
 34czN0Np5trFt3LtpyZV3O1ygPNABQo4fAByUDydNnI+/wGgeQN4HMNvY+RFBz5/e6AMikh7Qt6
 XEGDG67DNSv5YqK0VZJC2qo/KG5B0NR26azN1Z6USswYpq46/payYGAlbkQG2jsEPibBGRHNEDE
 O5NlElHUpkz7c/pnNbNGVW7ubeMLfH/No4oSE/8WfaIX8DdrRnXRFE97aXCQXdc0FL1yednRbpo
 e2yKn069JY+1GrpB6Ww==
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25760-lists,linux-scsi=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[njavali@marvell.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:GR-FC-Storage-Upstream@marvell.com,m:agurumurthy@marvell.com,m:emilne@redhat.com,m:jmeneghi@redhat.com,m:hare@suse.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[njavali@marvell.com,linux-scsi@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:from_mime,marvell.com:email,marvell.com:mid,marvell.com:dkim,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 013BD717B15

qla2x00_dfs_fce_write() called kstrtoul() with a NULL result pointer,
so a successful parse would dereference NULL and oops. Worse, the int
return value (0 on success, negative errno on failure) was assigned to
the unsigned long enable flag, inverting the intended logic: a valid
number was treated as "disable" while a parse failure enabled FCE.

Parse the value into enable and propagate parse errors to userspace.

Fixes: 841df27d619e ("scsi: qla2xxx: Move FCE Trace buffer allocation to user control")
Cc: stable@vger.kernel.org
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_dfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_dfs.c b/drivers/scsi/qla2xxx/qla_dfs.c
index 177d47e92e49..5d08bdbcf70a 100644
--- a/drivers/scsi/qla2xxx/qla_dfs.c
+++ b/drivers/scsi/qla2xxx/qla_dfs.c
@@ -510,7 +510,9 @@ qla2x00_dfs_fce_write(struct file *file, const char __user *buffer,
 		return PTR_ERR(buf);
 	}
 
-	enable = kstrtoul(buf, 0, 0);
+	rc = kstrtoul(buf, 0, &enable);
+	if (rc)
+		goto out_free;
 	rc = count;
 
 	mutex_lock(&ha->fce_mutex);
-- 
2.47.3


