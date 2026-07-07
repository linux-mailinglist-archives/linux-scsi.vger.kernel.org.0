Return-Path: <linux-scsi+bounces-25739-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /xk0HeaVTGqJmgEAu9opvQ
	(envelope-from <linux-scsi+bounces-25739-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 08:00:06 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F119F717B01
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 08:00:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=U3RSwYap;
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25739-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25739-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF2C530068C6
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jul 2026 05:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E866202C48;
	Tue,  7 Jul 2026 05:57:10 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FDD5474E
	for <linux-scsi@vger.kernel.org>; Tue,  7 Jul 2026 05:57:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783403830; cv=none; b=roREjlk+mXX0GagUhvexJZXprInYHI3XFRuCJl3xCNYV6xX2Mgv3/qUXG3jXCBz3Zz9ehqJ/202yE0WlWJ5zcZuJHf1y7lnF+bWh6XxTSx5Td0N09oIM2DipDsfM1uikpd7tah2GZFVWKA4UPJah+RNuM4wD6AvpQQtRY/EvJ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783403830; c=relaxed/simple;
	bh=KW8CvhQhJ1zrrKmUR5pywi3tJFWGDrn/LdERECmFyPY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t3tcsULSHx3Xxh/ILJaVGVxS/YSLmAqfu+eJ3VJzEb7EFxb+oUGXAhVOmnDlSS+k0WE9KsoXcLUZdqiIyr5jw1nSrQNI4Zj8LyM/Tp8UVzRzujOq/OO+XDHxqXdt/Zoi+dy4DDIDFzDiGih3l7DYASMwrDQ+MQdlA4OWAh4G5K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=U3RSwYap; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66748bub1656070;
	Mon, 6 Jul 2026 22:57:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=u
	8RBmwOK6utyZcPJ1llZgyOfxNdqEsC4BSbQTkY/kRo=; b=U3RSwYapOcmni6kwO
	O8vtbxIMyO8I9AIlisHtnJOwkAylzlViFwokkvztNqpj729DLsdNhpvsBq70kvmR
	03DWEsED+UxIR1pdCFqESQpzvk2tczwnoHN6IvP4IoS/jeQNTki3ysEfV9WKB0O7
	xsl1iE0+wyYaTY/vbOGEaE916da6ilMFmJQdwjYnr1f+FR9GQJyYSxyfRG1iB30G
	poQy2xNjigkCwTTiWJ8j9wQHVEzelDcjmUx9Guozft2Lf+EiQO0VBNGF5Coh1CsC
	hqRfANUFScOloBsIXPJNEDXwq1v1Cot6O060GT40uDMdCYwdXZClhu8U+4YQ3Gxx
	pVNWQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4f71phqdxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 22:57:06 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 6 Jul 2026 22:57:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 6 Jul 2026 22:57:05 -0700
Received: from stgdev-a5u16.punelab.marvell.com (stgdev-a5u16.punelab.marvell.com [10.31.33.164])
	by maili.marvell.com (Postfix) with ESMTP id AE3953F7067;
	Mon,  6 Jul 2026 22:57:02 -0700 (PDT)
From: Nilesh Javali <njavali@marvell.com>
To: <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <GR-FC-Storage-Upstream@marvell.com>,
        <agurumurthy@marvell.com>, <emilne@redhat.com>, <jmeneghi@redhat.com>,
        <hare@suse.com>
Subject: [PATCH v3 43/88] scsi: qla2xxx: Use 64-bit FPM word counters for 29xx host stats
Date: Tue, 7 Jul 2026 11:23:50 +0530
Message-ID: <20260707055435.2680300-44-njavali@marvell.com>
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
X-Proofpoint-GUID: jWSkii4voyWDZOvODIVwM7dq8kYKjMKi
X-Authority-Analysis: v=2.4 cv=Hf4kiCE8 c=1 sm=1 tr=0 ts=6a4c9532 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8
 a=iV06YDqDG_NXW1ljYX4A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-ORIG-GUID: jWSkii4voyWDZOvODIVwM7dq8kYKjMKi
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA1NCBTYWx0ZWRfX+vmYp8WpPovp
 Un8g637LvgUd2Mp0ySeMeageBDBKDt6ibmoH4uQFJMpM7uCVWwjXbzwojyRWxjLVR4yIHFAcqAN
 Eo8EjiPIdZZQUgEDh24PQGmtKHBqAC4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA1NCBTYWx0ZWRfX1Yu1LeGb4iVn
 m6ETMmDuuDqaqPbOoWZcN5FK6+WZFGdIEGyWFXhwy8YXEudVWgD/x8eJbyQAEpY77ZB+KfGrMOp
 djwroQD0gF7nIX5UE3X1oWMjt3BJ1r2kDVD61AgnkVCMCp1qZp5j3dwVt0yq5NxB1PF1ng4fS3E
 W1wIl9OREB8kf4eJVJhZA5NJamsx2wiqbDPaaqSPRdQswEfpJ5RkXDRPYRCZ04Aqkyk99TVWgDN
 sOC1ymN/KtAx5sLHMCqiprDOcfSJu0yPYlFLCEhQ+inE2lJClk8uNLq1pp8096jCsIBc7qKQhWZ
 4UyS2ITVVfCkRCkX4ZJvANxFffksGuWHODiaNAq0Xy3mvtHjy9VkMtoi8aVSKQ0Ezx4HXbuEJU5
 LV7r+PD2DYbGrbKHA/Kj9tFOOMvYNH1ILnPgPw11UjF9t80i7kl2fxQWHdrQQ45VjRsTvoWwdVj
 nf7kVkND0IWdSt/EWHQ==
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25739-lists,linux-scsi=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[njavali@marvell.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:GR-FC-Storage-Upstream@marvell.com,m:agurumurthy@marvell.com,m:emilne@redhat.com,m:jmeneghi@redhat.com,m:hare@suse.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[njavali@marvell.com,linux-scsi@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:from_mime,marvell.com:email,marvell.com:mid,marvell.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F119F717B01

29xx provides the 64-bit FPM transmit/receive word counters in the link
statistics block, like 83xx/27xx/28xx.  qla2x00_get_fc_host_stats()
only consumed those counters for the older families and fell back to the
software approximation (input/output bytes >> 2) on 29xx, reporting less
accurate rx_words/tx_words.

Add IS_QLA29XX() to the high-speed branch so 29xx reports the hardware
word counters.

Signed-off-by: Nilesh Javali <njavali@marvell.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/scsi/qla2xxx/qla_attr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
index 19aa66b8ca52..6cf74f8c9628 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -2990,7 +2990,8 @@ qla2x00_get_fc_host_stats(struct Scsi_Host *shost)
 		p->error_frames =
 		    le32_to_cpu(stats->dropped_frames) +
 		    le32_to_cpu(stats->discarded_frames);
-		if (IS_QLA83XX(ha) || IS_QLA27XX(ha) || IS_QLA28XX(ha)) {
+		if (IS_QLA83XX(ha) || IS_QLA27XX(ha) || IS_QLA28XX(ha) ||
+		    IS_QLA29XX(ha)) {
 			p->rx_words = le64_to_cpu(stats->fpm_recv_word_cnt);
 			p->tx_words = le64_to_cpu(stats->fpm_xmit_word_cnt);
 		} else {
-- 
2.47.3


