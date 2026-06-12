Return-Path: <linux-scsi+bounces-24794-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id L2O+GTfZK2prGQQAu9opvQ
	(envelope-from <linux-scsi+bounces-24794-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 12:02:31 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB99267891E
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 12:02:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=TX0SBimi;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24794-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24794-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CC4D34231B2
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jun 2026 09:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE6E303A04;
	Fri, 12 Jun 2026 09:56:47 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4AA3624B7
	for <linux-scsi@vger.kernel.org>; Fri, 12 Jun 2026 09:56:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781258207; cv=none; b=jXj5okL2n0jwqyMMkFo5xbAvU9H1+oWIHC0vTCYmuO8bcoGK8qP2BwWSnGnU7oLxzjvQqra7rbrgw95eD7uX7WNMu7uR+r4vpJuvhFNMgq0Bx8K5cvTRwt/L3lqukxzVejKzmlcHG0SuZsDc+XJkUfcqRT23erLojpxgwaGBNFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781258207; c=relaxed/simple;
	bh=z05Pz/Ir9bt9ZrhRvrfXMQMkEqMvA6ba89lUkRLBGes=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GHPmAuA36v0s4KxGuVkgfFtqZix5LvmzpVb+mMUHlS+lW/c5L4gTCv7duTCq0ukKpKJPOqpa8znoJFEWRQBDZ/a2qhs/EIdm1L8zHcx8pN3LCxUlIk0DgQQUgyLTjJ6IyIz0inNQBcQ5tH0cQ8Lu3uHMCGHKlp5KyYI6UGrT8ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=TX0SBimi; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C38x5Z3678669;
	Fri, 12 Jun 2026 02:56:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=K
	CO1F7nhPYQFuGHPlcX1je6FoIKo8C8ER7QqN0Kz+mE=; b=TX0SBimiwDLdAknxi
	XfQjlqP+8nWx1CkUBTJ+v88AdhjXhqgHWM5bpJ1GbI/zPYxz4pyWGrY/aB0F69Y1
	xCucNYhndVoc354/pjorJm4358RTEmonhaBBuhDkZ3cc+jkWUCRsyT4QXMSvwEks
	mZtVp5Nkb7QvmLr08U0KKCv5cdNrAFslD/ORBdoczrknTxlx19Sqfx1FHCLR7shi
	+7NKSM5nG3TvLWVdypLvdbPmumcf+Q/twiaEhzvSIK7/mic+K4NRFNPQxOBRuc95
	U3QADuNaRCt2C7J+Y5HGjxKstZKltDiemcDsP8NtyhJdnetsSivnW3NuxpgD9eX+
	tHOqA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4er9qn92nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jun 2026 02:56:41 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 12 Jun 2026 02:56:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 12 Jun 2026 02:56:40 -0700
Received: from stgdev-a5u16.punelab.marvell.com (stgdev-a5u16.punelab.marvell.com [10.31.33.164])
	by maili.marvell.com (Postfix) with ESMTP id 86D6C3F7040;
	Fri, 12 Jun 2026 02:56:37 -0700 (PDT)
From: Nilesh Javali <njavali@marvell.com>
To: <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <GR-FC-Storage-Upstream@marvell.com>,
        <agurumurthy@marvell.com>, <emilne@redhat.com>, <jmeneghi@redhat.com>,
        <hare@suse.com>
Subject: [PATCH v2 52/60] scsi: qla2xxx: Fix Name Server logout detection on FWI2 adapters
Date: Fri, 12 Jun 2026 15:23:25 +0530
Message-ID: <20260612095333.1666592-53-njavali@marvell.com>
X-Mailer: git-send-email 2.23.1
In-Reply-To: <20260612095333.1666592-1-njavali@marvell.com>
References: <20260612095333.1666592-1-njavali@marvell.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: gkoKkC4Rjk8eAas_T5U2fkPcN31Rph3g
X-Authority-Analysis: v=2.4 cv=Y9HIdBeN c=1 sm=1 tr=0 ts=6a2bd7d9 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=yW-34Apic8qcZ4Fw9d8A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA5MCBTYWx0ZWRfX9J6oJetsKfz7
 iAVg+biH9+J4ICUqSeBg4zZZL+VV6xz+ZIwkuKdhsxmECnZ6sW6STPOh3W35hGiAWZdmlyGwa6U
 DJmBhgRL/A9tvvpFK/mkPrN1cpsJSUU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA5MCBTYWx0ZWRfXwO4JcQB1FKqk
 3zj47pZKxLPGNM7hbx4YO3tETw5/CnD5wPkYQBh7E9wMyv4tap4wpE+DGLpzma9rQL7osxOm+MQ
 xJUT0qkbVvDrQioXWWae1DYD4j/TZikdyqu3RNT9nM5ZG8vGGvxxr+9rbSvaW5YAHcMIyTdrlw2
 1zSFUaeM2vjWIAdomMNPC+bAsdSjiQoj/j5sjioR/G5lj9OhKg442VU/5APqzObHJDWPur+FxW0
 2qijnuQggERJa/DCUo/NkLfbPJ0BodY6jltqmudK9Wd9X3hkU4w9pV1d/W/LpOA4jXOAVXF+Reh
 HPT7Xf0g/TVSsGsVx4K5n47KJ5xsdG5a+mIaxD5ahOjWzp1PhhVskkswIVDNkBUYY5ALUs8C8uc
 Tl6jsBBtqkmslDWHbXsO7/aA3AfG+Hmp9jqdc+MIyYryDphBGXwGBColml15kju3yw6STqycXqr
 cZpjJyfjIGURBNLkpNQ==
X-Proofpoint-GUID: gkoKkC4Rjk8eAas_T5U2fkPcN31Rph3g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[marvell.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[marvell.com:s=pfpt0220];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24794-lists,linux-scsi=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[njavali@marvell.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:GR-FC-Storage-Upstream@marvell.com,m:agurumurthy@marvell.com,m:emilne@redhat.com,m:jmeneghi@redhat.com,m:hare@suse.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[njavali@marvell.com,linux-scsi@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:dkim,marvell.com:email,marvell.com:mid,marvell.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BB99267891E

In the CS_PORT_LOGGED_OUT case of qla2x00_chk_ms_status(), the
FWI2-capable branch compared ms_pkt->loop_id.extended against NPH_SNS
to decide whether the Name Server had logged out. On FWI2 and later
adapters the response is a ct_entry_24xx / ct_entry_24xx_ext, where
loop_id.extended (via the legacy ms_iocb_entry_t view) aliases offset 8,
which is comp_status, not nport_handle (offset 10). As this code runs
under CS_PORT_LOGGED_OUT, the field read back 0x29 (CS_PORT_LOGGED_OUT)
and the comparison against NPH_SNS (0x7fc) was always false.

As a result the driver never recognized a Name Server logout on FWI2/
29xx adapters: it returned the generic QLA_FUNCTION_FAILED instead of
QLA_NOT_LOGGED_IN and skipped setting LOOP_RESYNC_NEEDED /
LOCAL_LOOP_UPDATE, so the fabric rediscovery triggered by an SNS logout
did not happen.

Read nport_handle from the ct_entry_24xx layout (offset 10) instead.
nport_handle is at the same offset in ct_entry_24xx and
ct_entry_24xx_ext, so a single cast covers 24xx-class and 29xx. The
non-FWI2 branch keeps using loop_id.extended, which is correct for the
ms_iocb_entry_t response on those adapters.

Fixes: b98ae0d748db ("scsi: qla2xxx: Fix name server relogin")
Cc: stable@vger.kernel.org
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_gs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index eefd1440d197..0d345009732a 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -192,8 +192,8 @@ qla2x00_chk_ms_status(scsi_qla_host_t *vha, ms_iocb_entry_t *ms_pkt,
 			break;
 		case CS_PORT_LOGGED_OUT:
 			if (IS_FWI2_CAPABLE(ha)) {
-				if (le16_to_cpu(ms_pkt->loop_id.extended) ==
-				    NPH_SNS)
+				if (le16_to_cpu(((struct ct_entry_24xx *)
+				    ms_pkt)->nport_handle) == NPH_SNS)
 					lid_is_sns = true;
 			} else {
 				if (le16_to_cpu(ms_pkt->loop_id.extended) ==
-- 
2.47.3


