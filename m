Return-Path: <linux-scsi+bounces-25129-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q9wbC07iOWppygcAu9opvQ
	(envelope-from <linux-scsi+bounces-25129-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 03:33:02 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB8A6B3398
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 03:33:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=plEVeroX;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25129-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25129-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D1F6F3049BB0
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 01:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0233388379;
	Tue, 23 Jun 2026 01:30:58 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4DD387375;
	Tue, 23 Jun 2026 01:30:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782178258; cv=none; b=AP8jXQ+Sn8WOJ313wrQbWcTy0h18Kjed3arxS1vmXPNxGEq6J5OR+PqayHU9ce47mKf7LkO3eEx0xFSqI6BJTIEyv9GQIRzZHUC3q6m9iv3IyqVAmdb1QaZuCmYusQUnfGj3ahmlYXr8Q9eJDyXxKCrNPDOO6OtaUwQ3PuB+tz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782178258; c=relaxed/simple;
	bh=qUxG6GJoIxlHJyNHsJaWfWowKaqwpT8pZeP8k+hAVkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=urO1RaU5l9csUrRCkeF4c3EF8z3D70ASPnOBR9sdE+75vV1ZKJszEMcHHDnJffTZjqiJxDthU7s0xku4grVIwOoQEIESCCATx9vmibEd6vX0n99bZkCvzW6IKC4Xziect0JUbIPRogiJv7zWtymCswHiYioS0N8GwMSvoT1Hi18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=plEVeroX; arc=none smtp.client-ip=148.163.158.5
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N0nK76283967;
	Tue, 23 Jun 2026 01:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bIlgQQIBnCFUb9Jdr
	p/8wkcf6fgqiCPwHm8qFxmF6TM=; b=plEVeroXV1YQQVtvA7Wi2LypZbHEl2D0Q
	Xyw1sD9CgXcZH3hv4gJe26zOqY9Gg/u6elQeTf6K4dWaQsfoaCOO5oJKuq2hzG9Y
	5VqwHMbIXOmhAuz+YVHcX3s6FBya5fYrnqirnc3iN3QCJ70CgqmhO9IbD7BfvMfy
	gOVuA2ir2zHVM1VP+OFScheT4jmF/BeF7tiab5OWYemDmrz2Lrllv2wC6p7Iq/Ff
	4E0iCEOe28nYMtq0SKVq3hnG58GeyD5YTZOkMWnWBgXM/jEt/uNUsG0omJPiKTWj
	U/HqyJNlPYLZH81vyd75eJIGKtLvh2ngxnIl0VdxlVGOLlIASoKlw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgskyrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 01:30:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65N1JmYp027964;
	Tue, 23 Jun 2026 01:30:46 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66k0xyp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 01:30:46 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65N1UjqT62915030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 01:30:45 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B1F158064;
	Tue, 23 Jun 2026 01:30:45 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0B9258063;
	Tue, 23 Jun 2026 01:30:44 +0000 (GMT)
Received: from li-4c4c4544-0054-3910-8039-c3c04f423534.ibm.com.com (unknown [9.61.188.206])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 01:30:44 +0000 (GMT)
From: Tyrel Datwyler <tyreld@linux.ibm.com>
To: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, brking@linux.ibm.com,
        davemarq@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH 10/29] ibmvfc: allocate and free NVMe channel group discover buffer
Date: Mon, 22 Jun 2026 18:30:16 -0700
Message-ID: <20260623013035.3436640-11-tyreld@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAwOCBTYWx0ZWRfX30dHa9bnCpm6
 fqB6PZyGPBhbD+kHNNT2/CMGEPzLvws8vpovlQVD06Cd15TY7ld7dVkcSwRKm22g2tdWjT9S3fl
 GY0ffgn0/sKDkjaCvCDTmpbefiJvl6jMPTQ0c865k+R+TuVd6HjeXfyzxewmEiXJH0J757gMlUx
 GmU9CsSUk3wgGYa3za8Bb6qQoS2eysLq03NgRdBkbdkA8IxQO9hEUTjV12yeV3QvvAs7rtG4FUd
 54BkDA/jZhLJfKHXizXy7wCvVy3twRBTY4dWgjlPVjBsJnTdCiuFpJpnHxYYSpEYCYiJIndRLc0
 /hjf+GzLKxtzB58bfT7vRmxqeF+1X++ix0mSrWuNxSXk8FaWHYE9nJbbw/1UomurupuKBcnzt1f
 gpiqupMKdjf0/a600/mXXld5K2sIlNRb+idpf1MKuvY+rpCs27viN4zCGyfg8wT7i1HFhftSW9b
 OhbMf0I9kHr0TTFtLdg==
X-Proofpoint-GUID: k8Afx8YQgakSF2BiktXVirj1HzyrRDxN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAwOCBTYWx0ZWRfXwnrBhDyKq8aB
 n4CsyrxJGiZqL1CL9tMByFmaKjBHrxc4hU/moU7B+BakI5pTUFuFVd+AglFoEDHqIUwOHOPVBNK
 +wUbwIONubHDCpO/B7PbcfV0Rq0O5/Y=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a39e1c7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=FxNEJgEJPZLGpAZHG_oA:9
X-Proofpoint-ORIG-GUID: k8Afx8YQgakSF2BiktXVirj1HzyrRDxN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230008
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25129-lists,linux-scsi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.ibm.com:mid,linux.ibm.com:from_mime,vger.kernel.org:from_smtp];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BAB8A6B3398

Allocate a discovery buffer for the NVMe channel group and free it on
all teardown and error paths.

The existing discovery-buffer allocation only covered the SCSI channel
group. This patch is prepratory for sending NVMe/FC target discovery
MAD.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc-core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc-core.c b/drivers/scsi/ibmvscsi/ibmvfc-core.c
index 9cd688762150..efac82c48258 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc-core.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc-core.c
@@ -6365,6 +6365,7 @@ static void ibmvfc_free_mem(struct ibmvfc_host *vhost)
 	mempool_destroy(vhost->tgt_pool);
 	kfree(vhost->trace);
 	ibmvfc_free_disc_buf(vhost->dev, &vhost->scsi_scrqs);
+	ibmvfc_free_disc_buf(vhost->dev, &vhost->nvme_scrqs);
 	dma_free_coherent(vhost->dev, sizeof(*vhost->login_buf),
 			  vhost->login_buf, vhost->login_buf_dma);
 	dma_free_coherent(vhost->dev, sizeof(*vhost->channel_setup_buf),
@@ -6427,12 +6428,15 @@ static int ibmvfc_alloc_mem(struct ibmvfc_host *vhost)
 	if (ibmvfc_alloc_disc_buf(dev, &vhost->scsi_scrqs))
 		goto free_login_buffer;
 
+	if (ibmvfc_alloc_disc_buf(dev, &vhost->nvme_scrqs))
+		goto free_scsi_disc_buffer;
+
 	vhost->trace = kzalloc_objs(struct ibmvfc_trace_entry,
 				    IBMVFC_NUM_TRACE_ENTRIES);
 	atomic_set(&vhost->trace_index, -1);
 
 	if (!vhost->trace)
-		goto free_scsi_disc_buffer;
+		goto free_nvme_disc_buffer;
 
 	vhost->tgt_pool = mempool_create_kmalloc_pool(IBMVFC_TGT_MEMPOOL_SZ,
 						      sizeof(struct ibmvfc_target));
@@ -6458,6 +6462,8 @@ static int ibmvfc_alloc_mem(struct ibmvfc_host *vhost)
 	mempool_destroy(vhost->tgt_pool);
 free_trace:
 	kfree(vhost->trace);
+free_nvme_disc_buffer:
+	ibmvfc_free_disc_buf(dev, &vhost->nvme_scrqs);
 free_scsi_disc_buffer:
 	ibmvfc_free_disc_buf(dev, &vhost->scsi_scrqs);
 free_login_buffer:
-- 
2.54.0


