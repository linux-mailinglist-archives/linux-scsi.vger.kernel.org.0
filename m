Return-Path: <linux-scsi+bounces-26141-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VLjkHmIIVmouyQAAu9opvQ
	(envelope-from <linux-scsi+bounces-26141-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 11:58:58 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7A2753277
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 11:58:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b=hzw0Mpg2;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-26141-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-26141-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DBEE307E2CD
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jul 2026 09:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129162E2840;
	Tue, 14 Jul 2026 09:55:22 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C0732A3D7
	for <linux-scsi@vger.kernel.org>; Tue, 14 Jul 2026 09:55:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784022922; cv=none; b=joVlGBRRkSKSjNEjWoKSb5DsgEWqQoiZF5Z/ARqVsWP0wzYv6dibTxMGQoQlhvYNJ/NMqiLs+cNGTXpwcnhSglbiBr3xvO3Y8Wj2g/0Xfv1k2sfFLcSoy2Odc4vgREjH5gH+otysyOUbISQIZlL4FKg6IcWTCPNXmUmT06voFVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784022922; c=relaxed/simple;
	bh=G6IwbmWILAY0i6RA6QdZI2TUa73HGC8W81qYhqz8uaw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LBAr6VPkmkCkUfhg37mUcuXVKyt+x2w5OyV2deqnyOGA4/56AoyDdqis8EIpcicr9OXfC95PbYSdUGIJqFW+d79NcAMt3sqTfZnKMnoiWwAA9Bp80M9riXe6hGWIE7vPmRbfFvvXvni99t2v2apaPEfOlt28GqW5tEA7cE/d8cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=hzw0Mpg2; arc=none smtp.client-ip=67.231.148.174
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E6URw52353949;
	Tue, 14 Jul 2026 02:55:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=7
	6nQHS2XaPB5RmNTf2weDS9yVzLEYnhIBdqFVZA9GW0=; b=hzw0Mpg2zsx0efX7B
	lQynawvpSg2mjwa9jipP/0jtaRaGLoALOWBi997e8BeVe2gxzsspJjq63RIzhKFa
	NvxssVbLnt2ovoOj4qbt6BlIXGfM0XLJ76LPfmOg25BhmLyKBC6Gf2tS4AKMX9PP
	QHXXQI6S0bF9X6mJSAS13tY3lNWKo2ngvrwTmNAh0u3jhTPj2wJ74PyR7IDgOA8T
	Oqsy+bhOihun3R9DMgiWXkFeUojVpV/2enUOYW4l64MFP1y72BW57pRMxg5BLh7e
	6K0qEz+IQeSexEfxl2d7zOR4kU7fqsdEptubBu/8dtTrWFsKkNqkCpvfJy4qZGRY
	jHqUA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4fca36nhvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 02:55:16 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 14 Jul 2026 02:55:15 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 14 Jul 2026 02:55:15 -0700
Received: from stgdev-a5u16.punelab.marvell.com (stgdev-a5u16.punelab.marvell.com [10.31.33.164])
	by maili.marvell.com (Postfix) with ESMTP id 367635E6867;
	Tue, 14 Jul 2026 02:55:12 -0700 (PDT)
From: Nilesh Javali <njavali@marvell.com>
To: <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <GR-FC-Storage-Upstream@marvell.com>,
        <agurumurthy@marvell.com>, <emilne@redhat.com>, <jmeneghi@redhat.com>,
        <hare@suse.com>
Subject: [PATCH v4 23/56] scsi: qla2xxx: Use ring-slot helpers in __qla2x00_alloc_iocbs
Date: Tue, 14 Jul 2026 15:23:20 +0530
Message-ID: <20260714095353.289460-24-njavali@marvell.com>
X-Mailer: git-send-email 2.23.1
In-Reply-To: <20260714095353.289460-1-njavali@marvell.com>
References: <20260714095353.289460-1-njavali@marvell.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEwMyBTYWx0ZWRfX2CANG53F2iXc
 e3OcCsXtG27sACixzamgpJKVCwtwSPC88ZWfza8SrI2k15ZTalXEzBKAghZesZCr+9CvQ94zss9
 /cCfkHMXnHKfhWZv3OU1N3PKRdU2W0BQYj2B7mlsRFMNnkPs1r6ReFTVEHyMBO+ssIstQ7bFn8Q
 QjGLBR8gjb735kqpYtB6wkJ8NHypyKoDVbUDi7COPOpEb8m9lT1+RvzKSnvMt0uX7Rd0VMvBZJS
 LqXo1F4eak9DcfOUTp33H9HewUlTkDgdS9UkqLyLviHFCIaS8LmvDKYF6PD0vkBpibdChh6rZq1
 khXeReF/Jtw2az5MHLtjsujLyUcDCwdyKFdR0KmTcvJbp7EDH+ytMpKldMJicmhxEFdAn9f67vv
 J4ob3Gh8cssUI0/oDNFG0t3GYAE0U0SPr0lwT1BUfmxAjsBW/9ImI4nIqCeUERiXTiSCPxPeLTP
 hidae31pGnQju0ojdgw==
X-Authority-Analysis: v=2.4 cv=EeT4hvmC c=1 sm=1 tr=0 ts=6a560784 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8
 a=x7bcZWNirRMrbHSgiDIA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEwMyBTYWx0ZWRfX4Mz2J/3E7mas
 bqLe4WCDK3DkYZ1UnJnWoTGfBMF8/ZNTuc+aic4ndISHrfdTmxiPma48YeFoEHNp/8LqYp4QtcT
 IYV7OBYVQuuNtJ09VKeFuPpdx7AHC+8=
X-Proofpoint-ORIG-GUID: o_Ggo72DrUC6CbsGOgD4RqY4AqD41IzW
X-Proofpoint-GUID: o_Ggo72DrUC6CbsGOgD4RqY4AqD41IzW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
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
	TAGGED_FROM(0.00)[bounces-26141-lists,linux-scsi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[marvell.com:from_mime,marvell.com:mid,marvell.com:email,marvell.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0A7A2753277

__qla2x00_alloc_iocbs() open-codes ring pointer selection and entry
size based on IS_QLA29XX(ha): 29xx reaches the slot via ring_ext_ptr
and zeroes REQUEST_ENTRY_SIZE_EXT bytes, while other adapters use
ring_ptr with REQUEST_ENTRY_SIZE bytes.

Replace the two branches with the qla_req_ring_slot() and
qla_req_entry_size() helpers, and initialise pkt at declaration.
The IS_QLAFX00 register-mapped writes remain guarded because
IS_QLAFX00 and IS_QLA29XX cannot be true simultaneously.

No functional change: the bytes written to the firmware-visible IOCB
are identical.

Signed-off-by: Nilesh Javali <njavali@marvell.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/scsi/qla2xxx/qla_iocb.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 7136ad4ec9a8..71fb6f3584ea 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -2465,10 +2465,9 @@ __qla2x00_alloc_iocbs(struct qla_qpair *qpair, srb_t *sp)
 	struct req_que *req = qpair->req;
 	device_reg_t *reg = ISP_QUE_REG(ha, req->id);
 	uint32_t handle;
-	request_t *pkt;
 	uint16_t cnt, req_cnt;
+	request_t *pkt = NULL;
 
-	pkt = NULL;
 	req_cnt = 1;
 	handle = 0;
 
@@ -2529,13 +2528,8 @@ __qla2x00_alloc_iocbs(struct qla_qpair *qpair, srb_t *sp)
 	 * layout-compatible once we return the pkt as request_t *.
 	 */
 	req->cnt -= req_cnt;
-	if (IS_QLA29XX(ha)) {
-		pkt = (request_t *)req->ring_ext_ptr;
-		memset(pkt, 0, REQUEST_ENTRY_SIZE_EXT);
-	} else {
-		pkt = req->ring_ptr;
-		memset(pkt, 0, REQUEST_ENTRY_SIZE);
-	}
+	pkt = qla_req_ring_slot(ha, req);
+	memset(pkt, 0, qla_req_entry_size(ha));
 	if (IS_QLAFX00(ha)) {
 		wrt_reg_byte((u8 __force __iomem *)&pkt->entry_count, req_cnt);
 		wrt_reg_dword((__le32 __force __iomem *)&pkt->handle, handle);
-- 
2.47.3


