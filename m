Return-Path: <linux-scsi+bounces-25131-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F/2wOuLiOWqPygcAu9opvQ
	(envelope-from <linux-scsi+bounces-25131-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 03:35:30 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E39446B3401
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 03:35:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=EeYJyLXJ;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25131-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25131-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C31C0305A141
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 01:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2165388E66;
	Tue, 23 Jun 2026 01:31:01 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F3938887C;
	Tue, 23 Jun 2026 01:30:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782178261; cv=none; b=dBHnahC2pSZOY/JW/P49jOrEJz3pKjMvzMFl4XNKWKxd8DAgQvOSqXgZ7QeASnsGFK88x6urbN5MIvIsk/pGFMUNbaaiDQ0ix8a4tTtAiAYO9kqQ+3hPU9qEV84XgNJb+YwtbiE/qJsdgafIXzGgUhXOiOzVEPNzf94NoV83eMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782178261; c=relaxed/simple;
	bh=Cm07z2AMqUFQh+A8rZ2WBKMWCYwCQ8jnHW2uOpk46yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EEVgfbNwFxl3sCAE/Ma+BxPzRTRe9YijD3akEbFUwXFyWhNmtj7KiMGssvDcxaC/n9pKT9fzXPVdnCR2HpGpkPpy8LQhG18MkskTrHNUyftIV05FZwtI3bLVTgH7zYasrFlnoBwZtfCygP3wduhT1Z8TlGYe2CKHbq8Fjep26Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EeYJyLXJ; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N0mJkn550492;
	Tue, 23 Jun 2026 01:30:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kMFloVTbM/kUSPP9y
	9CuLryVeLEV2safqOGi+1EDYo0=; b=EeYJyLXJiUqMAyYrdlseRidydnx5cCyZd
	dTQAFunIpmpxYNz1sivFxDEnvtaRya4TrHI3xLAg89Wqo8D4+GzZiF3A7RDFJhdY
	P6anRapD3EsJCUyhRyEdwLw28ADJ0dOm6WngTDtrkHPYcvIQsdv2Sagdp7l4rcaB
	zMhkBUirI/1HrahioYb1zo2Hlj+cbe/lyPzI7CDfk9AkQWVAKPXpe8cTtmYqz+Qo
	WXg4UILGtH7LmRkiR1lwQi0mr1MqWF+PU+sE4Qz8jlAyHStWDV4S/SBn/thNev9L
	YcMS55gzV9FbzwJp6C6dkOvs7BhHRq5Uw3v5cE7RNWDEjxqPbgVjQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhqm1s7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 01:30:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65N1JhBV027950;
	Tue, 23 Jun 2026 01:30:48 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66k0xyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 01:30:48 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65N1UlXV22414008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 01:30:47 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E37B158056;
	Tue, 23 Jun 2026 01:30:46 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 507685805A;
	Tue, 23 Jun 2026 01:30:46 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.188.206])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 01:30:46 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH 12/29] ibmvfc: add NVMe/FC Implicit Logout and Move Login support
Date: Mon, 22 Jun 2026 18:30:18 -0700
Message-ID: <20260623013035.3436640-13-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623013035.3436640-1-tyreld@linux.ibm.com>
References: <20260623013035.3436640-1-tyreld@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a39e1c9 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=vOiCItosospfXf71XmMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAwOCBTYWx0ZWRfX8+F1YM/W3zFT
 1bXj7AfnxaY7TSWY9EMLW/3/41KCS0qcyohu44tJi0pVhjQt3O+uYQX0XHeBgLxSDGBUzcNvNZ9
 QKhNwmD9Aw0VIhen7k4dpTHox8nbw2cBS/KIpx2Db8WHq7RELLU5kZ6z1MkMM/XFVmqvNgbtWKl
 FNUfkyhpgF5OMoCD8oumkLBY6bQ/1biZdbMLzb3MIVtoRpYBOlxxIdwofK1k+6h5NGMOfmhdgC7
 dU2nOglm1vaN4gFSYLeybPQoCUqxzIVBTJTN2Zus8eA/ZE6E8KMf/FrqYNauJfDj9r9MmGwAslq
 ifQECJlXJ123Rh4uMY1gxVaysfj/sh3fXG9srFFny7OZgUbOvVUr9SbCJxuSF1S7VUKcltsN104
 krSBrTxe6s+/Wj9UqRheImJ4JBzovaDz0BNTVo/tzTyvMSdv7X8A6E20aXcM+lPCqXUXzYAWBha
 Scb0N6M4JVD0WC6DfXA==
X-Proofpoint-GUID: se9HKlmAomAnm0S1sRbgUJw8Qae_41an
X-Proofpoint-ORIG-GUID: se9HKlmAomAnm0S1sRbgUJw8Qae_41an
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAwOCBTYWx0ZWRfXznsWqeWH9EgW
 M3v1MeZ8xEbm8/S+3kTSE7WtKHd/cokoyZ4WInzcXBboYdD4OIaFnOsv4EckIzvK85g9+RLZMwt
 TnCi8mUMEpvJ5nPVSdQo3P7EsUuZPpI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230008
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25131-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:james.bottomley@hansenpartnership.com,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:brking@linux.ibm.com,m:davemarq@linux.ibm.com,m:tyreld@linux.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[tyreld@linux.ibm.com,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[tyreld@linux.ibm.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.ibm.com:mid,linux.ibm.com:from_mime];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E39446B3401

Add protocol-specific handling for implicit logout and move-login
operations on NVMe/FC targets.

Select the NVMe/FC-specific implicit logout opcode when operating on an
NVMe target and update the associated logging so protocol-specific
operations are visible in debug output. This extends the existing target
relogin and migration-related flows to work with NVMe targets as well as
SCSI targets.

These changes are needed so target reauthentication and target movement
continue to work once NVMe/FC targets are added to the driver's state
machine.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 33 +++++++++++++++++++----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 53480d150042..3e3d77e0d517 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -4316,7 +4316,7 @@ static void ibmvfc_tgt_implicit_logout_done(struct ibmvfc_event *evt)
 
 	switch (status) {
 	case IBMVFC_MAD_SUCCESS:
-		tgt_dbg(tgt, "Implicit Logout succeeded\n");
+		tgt_dbg(tgt, "%s Implicit Logout succeeded\n", proto_type[tgt->protocol]);
 		break;
 	case IBMVFC_MAD_DRIVER_FAILED:
 		kref_put(&tgt->kref, ibmvfc_release_tgt);
@@ -4324,7 +4324,8 @@ static void ibmvfc_tgt_implicit_logout_done(struct ibmvfc_event *evt)
 		return;
 	case IBMVFC_MAD_FAILED:
 	default:
-		tgt_err(tgt, "Implicit Logout failed: rc=0x%02X\n", status);
+		tgt_err(tgt, "%s Implicit Logout failed: rc=0x%02X\n",
+			proto_type[tgt->protocol], status);
 		break;
 	}
 
@@ -4357,7 +4358,10 @@ static struct ibmvfc_event *__ibmvfc_tgt_get_implicit_logout_evt(struct ibmvfc_t
 	mad = &evt->iu.implicit_logout;
 	memset(mad, 0, sizeof(*mad));
 	mad->common.version = cpu_to_be32(1);
-	mad->common.opcode = cpu_to_be32(IBMVFC_IMPLICIT_LOGOUT);
+	if (tgt->protocol == IBMVFC_PROTO_SCSI)
+		mad->common.opcode = cpu_to_be32(IBMVFC_IMPLICIT_LOGOUT);
+	else
+		mad->common.opcode = cpu_to_be32(IBMVFC_NVMF_IMPLICIT_LOGOUT);
 	mad->common.length = cpu_to_be16(sizeof(*mad));
 	mad->old_scsi_id = cpu_to_be64(tgt->scsi_id);
 	return evt;
@@ -4393,7 +4397,7 @@ static void ibmvfc_tgt_implicit_logout(struct ibmvfc_target *tgt)
 		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_NONE);
 		kref_put(&tgt->kref, ibmvfc_release_tgt);
 	} else
-		tgt_dbg(tgt, "Sent Implicit Logout\n");
+		tgt_dbg(tgt, "%s Sent Implicit Logout\n", proto_type[tgt->protocol]);
 }
 
 /**
@@ -4423,7 +4427,8 @@ static void ibmvfc_tgt_implicit_logout_and_del_done(struct ibmvfc_event *evt)
 	else
 		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_DEL_AND_LOGOUT_RPORT);
 
-	tgt_dbg(tgt, "Implicit Logout %s\n", (status == IBMVFC_MAD_SUCCESS) ? "succeeded" : "failed");
+	tgt_dbg(tgt, "%s Implicit Logout %s\n", proto_type[tgt->protocol],
+		(status == IBMVFC_MAD_SUCCESS) ? "succeeded" : "failed");
 	kref_put(&tgt->kref, ibmvfc_release_tgt);
 	wake_up(&vhost->work_wait_q);
 }
@@ -4456,7 +4461,7 @@ static void ibmvfc_tgt_implicit_logout_and_del(struct ibmvfc_target *tgt)
 		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_DEL_RPORT);
 		kref_put(&tgt->kref, ibmvfc_release_tgt);
 	} else
-		tgt_dbg(tgt, "Sent Implicit Logout\n");
+		tgt_dbg(tgt, "%s Sent Implicit Logout\n", proto_type[tgt->protocol]);
 }
 
 /**
@@ -4476,7 +4481,8 @@ static void ibmvfc_tgt_move_login_done(struct ibmvfc_event *evt)
 	ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_NONE);
 	switch (status) {
 	case IBMVFC_MAD_SUCCESS:
-		tgt_dbg(tgt, "Move Login succeeded for new scsi_id: %llX\n", tgt->new_scsi_id);
+		tgt_dbg(tgt, "%s Move Login succeeded for new scsi_id: %llX\n",
+			proto_type[tgt->protocol], tgt->new_scsi_id);
 		tgt->ids.node_name = wwn_to_u64(rsp->service_parms.node_name);
 		tgt->ids.port_name = wwn_to_u64(rsp->service_parms.port_name);
 		tgt->scsi_id = tgt->new_scsi_id;
@@ -4497,8 +4503,9 @@ static void ibmvfc_tgt_move_login_done(struct ibmvfc_event *evt)
 		level += ibmvfc_retry_tgt_init(tgt, ibmvfc_tgt_move_login);
 
 		tgt_log(tgt, level,
-			"Move Login failed: new scsi_id: %llX, flags:%x, vios_flags:%x, rc=0x%02X\n",
-			tgt->new_scsi_id, be32_to_cpu(rsp->flags), be16_to_cpu(rsp->vios_flags),
+			"%s Move Login failed: new scsi_id: %llX, flags:%x, vios_flags:%x, rc=0x%02X\n",
+			proto_type[tgt->protocol], tgt->new_scsi_id,
+			be32_to_cpu(rsp->flags), be16_to_cpu(rsp->vios_flags),
 			status);
 		break;
 	}
@@ -4538,7 +4545,10 @@ static void ibmvfc_tgt_move_login(struct ibmvfc_target *tgt)
 	move = &evt->iu.move_login;
 	memset(move, 0, sizeof(*move));
 	move->common.version = cpu_to_be32(1);
-	move->common.opcode = cpu_to_be32(IBMVFC_MOVE_LOGIN);
+	if (tgt->protocol == IBMVFC_PROTO_SCSI)
+		move->common.opcode = cpu_to_be32(IBMVFC_MOVE_LOGIN);
+	else
+		move->common.opcode = cpu_to_be32(IBMVFC_NVMF_MOVE_LOGIN);
 	move->common.length = cpu_to_be16(sizeof(*move));
 
 	move->old_scsi_id = cpu_to_be64(tgt->scsi_id);
@@ -4551,7 +4561,8 @@ static void ibmvfc_tgt_move_login(struct ibmvfc_target *tgt)
 		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_DEL_RPORT);
 		kref_put(&tgt->kref, ibmvfc_release_tgt);
 	} else
-		tgt_dbg(tgt, "Sent Move Login for new scsi_id: %llX\n", tgt->new_scsi_id);
+		tgt_dbg(tgt, "Sent %s Move Login for new scsi_id: %llX\n",
+			proto_type[tgt->protocol], tgt->new_scsi_id);
 }
 
 /**
-- 
2.54.0


