Return-Path: <linux-scsi+bounces-25718-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XNsiGVuVTGpdmgEAu9opvQ
	(envelope-from <linux-scsi+bounces-25718-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 07:57:47 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD22A717A7E
	for <lists+linux-scsi@lfdr.de>; Tue, 07 Jul 2026 07:57:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=marvell.com header.s=pfpt0220 header.b="EObwe/lb";
	dmarc=pass (policy=quarantine) header.from=marvell.com;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25718-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25718-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A65CE3025C19
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jul 2026 05:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6845474E;
	Tue,  7 Jul 2026 05:56:09 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7751CAA78
	for <linux-scsi@vger.kernel.org>; Tue,  7 Jul 2026 05:56:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783403769; cv=none; b=Qovnh+2rVMqu2auMcJUEfkgip3G0rSdOjI+KnnF7oVIyEEDUjLEBS1cgxBHMt4IL5A3Eo+Dw7WnrrxGX7KJJvbJ0DeBHayN0lOQEsJk+uojAk/kycl9MohGlhC6yQLPKaHqGyRpy0b7/BditGLagH+v2WmqTRBXURQO2TpU0LwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783403769; c=relaxed/simple;
	bh=XBweKRoe2iV+j+QDP57gNIPWkFSpzqNvh5kItWbGoY8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B7RHk1YdxyFoDpS6ZjG9+CFbLMMQITu8ZkLKo089qFpqGTq2tq8+2LYqPoCJBtF/44HXkpmCgTeJ0oqL0deM1+a7WxpIEen0DS53Zz+v6nIsJFRkW4lDas/nTmB828le/agFGQJYB865zdO9P0wwI1T3syZ4DI5mlKCRN+4yJXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=EObwe/lb; arc=none smtp.client-ip=67.231.156.173
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667481Pr872631;
	Mon, 6 Jul 2026 22:56:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=T
	G9Rjbv/gWTuYO3pC+FOHAYqPLzfSVkpZiKVpas+3tk=; b=EObwe/lbPnt0rzD1/
	9SzHot31GbdSV9jtgMTVo5kWfRiC3XKG5rbtDwi6yeUW8fK+NsYPqGY9XBslw/E3
	LAPCAQ5CcLKNKAR3kh9DXnUQUvnjrbh+j1YOnZmUyXzdNa6UIw4n4WhZ2JfpbPi6
	2oedKysTmPD9UxbftKraIIxSwe4xFDsDY/RQEjJ6h7JzKgsm5xZpF98mn5ccgdU/
	KxpIt2PYjcKwqaCMsKNZGcUybTZIEEtkEg1mE2nPOEMkzcdxAheR7LtEUwsZtPvG
	dUTmV9yhQXSBpEP/hMP7gjyuW1fRHH4QQj3kDaCFsx3/wTF5UwXe8L3rF1GIrqE/
	Q8nqQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4f8f9waa1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 22:56:05 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 6 Jul 2026 22:56:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 6 Jul 2026 22:56:05 -0700
Received: from stgdev-a5u16.punelab.marvell.com (stgdev-a5u16.punelab.marvell.com [10.31.33.164])
	by maili.marvell.com (Postfix) with ESMTP id 5058F3F7066;
	Mon,  6 Jul 2026 22:56:02 -0700 (PDT)
From: Nilesh Javali <njavali@marvell.com>
To: <martin.petersen@oracle.com>
CC: <linux-scsi@vger.kernel.org>, <GR-FC-Storage-Upstream@marvell.com>,
        <agurumurthy@marvell.com>, <emilne@redhat.com>, <jmeneghi@redhat.com>,
        <hare@suse.com>
Subject: [PATCH v3 22/88] scsi: qla2xxx: Enable qla2x00_shutdown for 29xx
Date: Tue, 7 Jul 2026 11:23:29 +0530
Message-ID: <20260707055435.2680300-23-njavali@marvell.com>
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
X-Proofpoint-ORIG-GUID: XJyudH1XmnP-r9ixPMv6vWaxZI0yh_zb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA1NCBTYWx0ZWRfXxC8a/3x4+IIO
 fkKayfu/KTZ4rtP4ZI51bkArwOxQNyjg03nPjv1EvWGyE5Zj+SKP01XBOSzEwxNhKCFakH+4pin
 IqRBbUH2omJPuIx408KAP5jv4LXaKeomhAYXtL0gqZyQxNJcmdA1pmzq7DCA7L0fr8Vt5YEjwll
 WoEfgjsiJKn+8eiNQWr5x0EF44+p7NEKMJRohhZk7bN0HKS2G6ubCYKCyTTH9lMfSGqD9vovG4r
 4ZXg3ssZlCqd10cfRJyYAbJFyvb9bL/d9kkYSkneorX/L3pzw/A6pU4vW/cKPMzzJSyPvDXeV9o
 LpOU+gxQpipLvQBthQFPw2WYARfqdnBh6HYuk2wVrmgHd0Ah6CGkhT/tAvFmj/DvitNbL0XHCxW
 Onm9GnnyRWCtS3W+xBcozo5oXbI5fnN3f8vxb0rVUdRybt+9stzAkmwrPshOAtmXOOtWoXZv/kt
 j8O1FNiMMnX1ppDRDcA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA1NCBTYWx0ZWRfX8X2IZSP26RQ9
 ZMW9IqT13N9PiPJ5o+WVySlnvrmH8mHiROeJVZjHH3RGUvr2IAHExSrSIUvNa74jJRRaZlNVqKT
 qMjTKjnlRQTb7/6D7fDIS40EClzPd34=
X-Proofpoint-GUID: XJyudH1XmnP-r9ixPMv6vWaxZI0yh_zb
X-Authority-Analysis: v=2.4 cv=SY/HsPRu c=1 sm=1 tr=0 ts=6a4c94f5 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=VwQbUJbxAAAA:8
 a=C3ITPKR1BmyQqgtea3sA:9 a=OBjm3rFKGHvpk9ecZwUJ:22
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
	TAGGED_FROM(0.00)[bounces-25718-lists,linux-scsi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,marvell.com:from_mime,marvell.com:email,marvell.com:mid,marvell.com:dkim,vger.kernel.org:from_smtp];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD22A717A7E

Enable qla2x00_shutdown for 29xx adapter by adding IS_QLA29XX check
to the shutdown path that performs firmware abort cleanup.

Signed-off-by: Nilesh Javali <njavali@marvell.com>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/scsi/qla2xxx/qla_os.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 146701445485..5450c40259bf 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -3840,7 +3840,7 @@ qla2x00_shutdown(struct pci_dev *pdev)
 		qla2x00_disable_eft_trace(vha);
 
 	if (IS_QLA25XX(ha) ||  IS_QLA2031(ha) || IS_QLA27XX(ha) ||
-	    IS_QLA28XX(ha)) {
+	    IS_QLA28XX(ha) || IS_QLA29XX(ha)) {
 		if (ha->flags.fw_started)
 			qla2x00_abort_isp_cleanup(vha);
 	} else {
-- 
2.47.3


