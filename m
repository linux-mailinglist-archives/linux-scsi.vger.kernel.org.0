Return-Path: <linux-scsi+bounces-25741-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l1QXFv6VTGqNmgEAu9opvQ
	(envelope-from <linux-scsi+bounces-25741-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 08:00:30 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A226F717B0A
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 08:00:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=bmfQoT2e;
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25741-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25741-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF7CC3041244
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jul 2026 05:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5483A386C15;
	Tue,  7 Jul 2026 05:57:17 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E244537C902
	for <linux-scsi@vger.kernel.org>; Tue,  7 Jul 2026 05:57:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783403837; cv=none; b=htwNl3kp0IxGZMSMtpiSlGmtxAKlYyX3JvXBF87hrWTiMTeHqZH0gUqfOcwhasfIwFd9ktfUDghSu6pAbPdM1ZJzEPZ1ksxoKF7e5cFYRRNmaM9b2w5fdFAwZSEiWcpqTL9XCkrUsH+qp/5p6xRR3Kacy08lwQh09ZaPS2SUKrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783403837; c=relaxed/simple;
	bh=O4sQGQU4b6fdPzFyaZTPQlMCOUzyLU24c2nhRqRW8Wo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c4EP1l86ajXGZJikrs8s5sJy3+kI586hEJQAEeLSmM/RuKDHGf0d+QJnkRa7nHzo4q+XQNH+zjbSg51aqWaN2WUjzmNy8zXQL8wTzjc4cyVaRgOEcSsZnaWL90H7QpmYw8wN1V4FPpnxM8tW9Zt6gwixcMWiI0UzsUvW7VZFcOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=bmfQoT2e; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667482Gb872799;
	Mon, 6 Jul 2026 22:57:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=/
	6Cb0dgXoIC1ZIaQTn5yCtTjRGgeiWdgD+BYAFNDpYA=; b=bmfQoT2e1XdatiK7a
	c0qNjs8xGucGN18GDv0veOeCd8FvYcmXz2SwPnkFRuVszErc8KOZf82Sp7dwTNbv
	OP2tIcchlrGG7mX9SZHWQqiPS3e7o/hNp0m8yc+s+ML5bP0DE+K0TUZToZbkFWBh
	pRh+qtQtnC8wyH/EIMSeh/5W4LyiBNEpx2Zaxih1wvgzuYW41+hrcpTDQHO4ETgH
	1N/hCiuL9R11pxs8JE37zgQmHadVV3RUGpulgiAxbGBaTkTOl5TwSBRbGvAGyL5W
	yhWToucwaDhaahg6//6M1rVV6aKuKLofSJyvfU7LGwRAs40QibgT61HEoS0h0N2B
	oBRFg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4f8f9waa5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 22:57:12 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 6 Jul 2026 22:57:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 6 Jul 2026 22:57:11 -0700
Received: from stgdev-a5u16.punelab.marvell.com (stgdev-a5u16.punelab.marvell.com [10.31.33.164])
	by maili.marvell.com (Postfix) with ESMTP id E1B063F7066;
	Mon,  6 Jul 2026 22:57:08 -0700 (PDT)
From: Nilesh Javali <njavali@marvell.com>
To: <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <GR-FC-Storage-Upstream@marvell.com>,
        <agurumurthy@marvell.com>, <emilne@redhat.com>, <jmeneghi@redhat.com>,
        <hare@suse.com>
Subject: [PATCH v3 45/88] scsi: qla2xxx: Fix 64G link speed reporting in get_data_rate
Date: Tue, 7 Jul 2026 11:23:52 +0530
Message-ID: <20260707055435.2680300-46-njavali@marvell.com>
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
X-Proofpoint-ORIG-GUID: wsuIzt-zqMDmTWRSyZyILWlNmhmegiDf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA1NCBTYWx0ZWRfXzVr4FTYtwXlo
 WOeckXqe6d5ar1tFbH5JhBiB+rnNFn+XnXW10UWzO+TrqgI2PsAihrJ0f4jRZOWuwK8NwWygRVk
 udZEJSCZixl/8Dvq92F2beQCD6HFJpcdSvm8banWxDvjYgemOA5TGckCR6cl3dfdtOpLIFM4J6g
 d5NY0ZtAb7GvYJ5Uu5NsJCOdRe/6OSJiJkO+EAQ6N+37PtREFfWu5cwGU1eYDNSgEkIIwqFbAXP
 vGUh7gAmYNiVHmk4qmEO0ubjHC4sW1AL2E37Ze57S5TYOEFdnhpMtBTVV0qI3QzUdA6fsC5nsmP
 XQM9ZiHSzdthDVzkTZ4P6jfysqfb28UutDS2fvCsD2fSIUW8KKFZFaGKdhMRIeBGL+svh+tlJlP
 gxLW9hlwprYymV1E9WxJqMgR3TffuK6PPlG33tzQVEZh3zhifoi8bsFGX9gA2dIIsjWxSVcCy86
 Q40ImImxfFlQNpHOvuQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA1NCBTYWx0ZWRfXxIAkawXeqqcn
 QERvSLv/Lds0HKfl88ht0UNT3eK0yFd7yOTKhRjcd+NHsljMtub+PY7WTAd6qR2dMTAi0mXPnyJ
 Ac5Na3hkaSyZTcr5Iz52C/QbidrmAtA=
X-Proofpoint-GUID: wsuIzt-zqMDmTWRSyZyILWlNmhmegiDf
X-Authority-Analysis: v=2.4 cv=SY/HsPRu c=1 sm=1 tr=0 ts=6a4c9538 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8
 a=utjVkuT23_eo-L5YqD0A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25741-lists,linux-scsi=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[njavali@marvell.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:GR-FC-Storage-Upstream@marvell.com,m:agurumurthy@marvell.com,m:emilne@redhat.com,m:jmeneghi@redhat.com,m:hare@suse.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[njavali@marvell.com,linux-scsi@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[marvell.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: A226F717B0A

qla2x00_get_data_rate() skips updating ha->link_data_rate when the
firmware returns mcp->mb[1] == 0x7.  That value was a legacy sentinel
from before 64G hardware existed, but PORT_SPEED_64GB is now defined as
0x07 and ha->link_data_rate is decoded with the PORT_SPEED_* encoding.
On a 64G-capable adapter a genuine 64G link is therefore dropped, and
the port speed is misreported (port_speed sysfs, fc_host speed, FDMI).

Only 28xx and 29xx support 64G, so accept 0x07 on those adapters while
keeping the legacy filter for older ones.  Also drop the duplicate
copy of the check at the end of the success branch; it repeated the
first assignment with no intervening change.

Fixes: ecc89f25e225 ("scsi: qla2xxx: Add Device ID for ISP28XX")
Cc: stable@vger.kernel.org
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/scsi/qla2xxx/qla_mbx.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index ba822c196894..b32ca8ed274d 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -5785,10 +5785,11 @@ qla2x00_get_data_rate(scsi_qla_host_t *vha)
 		ql_dbg(ql_dbg_mbx, vha, 0x1107,
 		    "Failed=%x mb[0]=%x.\n", rval, mcp->mb[0]);
 	} else {
-		if (mcp->mb[1] != 0x7)
+		if (mcp->mb[1] != 0x7 || IS_QLA28XX(ha) || IS_QLA29XX(ha))
 			ha->link_data_rate = mcp->mb[1];
 
-		if (IS_QLA83XX(ha) || IS_QLA27XX(ha) || IS_QLA28XX(ha) || IS_QLA29XX(ha)) {
+		if (IS_QLA83XX(ha) || IS_QLA27XX(ha) || IS_QLA28XX(ha) ||
+		    IS_QLA29XX(ha)) {
 			if (mcp->mb[4] & BIT_0)
 				ql_log(ql_log_info, vha, 0x11a2,
 				    "FEC=enabled (data rate).\n");
@@ -5796,8 +5797,6 @@ qla2x00_get_data_rate(scsi_qla_host_t *vha)
 
 		ql_dbg(ql_dbg_mbx + ql_dbg_verbose, vha, 0x1108,
 		    "Done %s.\n", __func__);
-		if (mcp->mb[1] != 0x7)
-			ha->link_data_rate = mcp->mb[1];
 	}
 
 	return rval;
-- 
2.47.3


