Return-Path: <linux-scsi+bounces-25268-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BbShAM4cPWqwxAgAu9opvQ
	(envelope-from <linux-scsi+bounces-25268-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Jun 2026 14:19:26 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A71DB6C57DD
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Jun 2026 14:19:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=WaxtMbb8;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25268-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25268-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2639B3109CDB
	for <lists+linux-scsi@lfdr.de>; Thu, 25 Jun 2026 12:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3163E0250;
	Thu, 25 Jun 2026 12:13:32 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293643E00BE
	for <linux-scsi@vger.kernel.org>; Thu, 25 Jun 2026 12:13:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389612; cv=none; b=G2EisvLr9ks83pc81I8N27wGEnsG3FdGB9vSngQMqZvTjXyIsH3+rrp8kgqq6cgdJT80ptqZRW1npbsjn4/ZZKON5VJApwhyfWBnMvl2xfYa5iuYWoJnW8UOWAj2YQ0P33P5h9Zjk5chm+JVsiuM7kZYfwHBqD0IPb3aS17+zTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389612; c=relaxed/simple;
	bh=lXGfjbv1UjIm0TomVvuyzsgYVMoePwOeTU2bSL7pWL8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qYpjzfu3vzbaIZvHAfy77sBzFeNQXzGcUVVt92cvPyBLDhfDCGFss9tFGJfynR1xclCZa2e9sHk+xRVpRi8HeTKkuMv9uoNsRBQBceVz1k3sK0CxsQkuGKNBnx9UcYEBNm4Q/Rg502Eyk4ZnhWgx3WZE++9D78KRxaIXAHGj2wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WaxtMbb8; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P9jvTT1754134;
	Thu, 25 Jun 2026 12:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=F5bIUIl7l1M5m4iS14r2bxX9rNZ++FCuA+H
	hte/3NOs=; b=WaxtMbb8aKfOS7wYiBwQKfW5qTi7884LHqivtiEopLDRb4rql34
	HnJ4QRTKwwicgs28+IViFfVVZro25q3LS3sP2yece9S3igh2mDF5ZljMcGn0xkFQ
	YyHbe5QH9Z8lwjh3KBCrmsibpKQj7dPxf6vtLdVLPyiuxJvOjo/+p6G6uU6JbehW
	BXLqyFCxCMCq3zzHzmQXhv6t0La2sYRvxTXfop7e4Yf165lSpWeNl1zbP6d6d6YE
	XqWiOUtcm30PdH6xDfBDkZ1cdx9M2I5fG8Ux7NRhf5BU9VnyTbUzTssAIP0U2aPc
	LhwUtid1a6SkleC3+YpxfXWgGZdseNNF8hQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0w0q1qpq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 12:13:10 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 65PCD83D006693;
	Thu, 25 Jun 2026 12:13:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 4f0q1qxr86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 12:13:08 +0000 (GMT)
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 65PCD7Uw006685;
	Thu, 25 Jun 2026 12:13:07 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-cang-lv.qualcomm.com [10.81.25.255])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 65PCD7Nm006684
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Jun 2026 12:13:07 +0000 (GMT)
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 359480)
	id E8308620; Thu, 25 Jun 2026 05:13:07 -0700 (PDT)
From: Can Guo <can.guo@oss.qualcomm.com>
To: bvanassche@acm.org, beanhuo@micron.com, peter.wang@mediatek.com,
        martin.petersen@oracle.com, mani@kernel.org
Cc: linux-scsi@vger.kernel.org, Can Guo <can.guo@oss.qualcomm.com>
Subject: [PATCH v2 0/3] scsi: ufs: Harden TX EQTR error handling paths
Date: Thu, 25 Jun 2026 05:13:02 -0700
Message-Id: <20260625121306.1655467-1-can.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: lZmkX6be0LvEcYXdRAL6UduKjOQRKm-8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEwNCBTYWx0ZWRfX4y0T+9nnjEsc
 vlYX3SwqJzRnebQ/3s3BeguVNiQV0yjv5FSOPt8bI3NfjQlbnEbFE9LZcHHPbR5F0bfueE1HgAb
 FZHYsbFD18CCGTgN6hCLUGwdwmw5NSc=
X-Proofpoint-GUID: lZmkX6be0LvEcYXdRAL6UduKjOQRKm-8
X-Authority-Analysis: v=2.4 cv=R6Ez39RX c=1 sm=1 tr=0 ts=6a3d1b56 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=RRY_MtapdLpyJEs6RdQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEwNCBTYWx0ZWRfX9SJT6IJVkRDm
 EBjs2FPqXxPyht8WpFQ8fQUiL3mUJ67DtKL56fCAT6arBy49T4nqLB5Lvr9LhRjGfJM/+sQ2/Hs
 4zz60woWk1fUfayAbYlSAv78tQZiNzlorWVy6FBL1FDQgF+Zw1CsWO4+e77s87rILY/D9HtCupG
 ZDSKX4Kw8l2IxcNlesE1beFWw6RGQ4vBHvwUAGTwVc7yncITz3HfLGbNKdRo/OhCkzl/S86xL9H
 ZucyVyJVP3t3DOF0Ac4BTWuQAAiiS0iKozDvamuEFowqV+F9xI//SwtJxbgXz+YBYMUObJ0zljS
 mcsTq56gcvB+QoVgbh+/WonuX9GxlJBobd6HLaO+Xl3IAjfNQ71ipmcmpwCOU3yt4Lf10sa30VH
 aR+0Y4ceMxWQzmz4TmnvCSf7vFJ7TxDrxaaq0EktSkuJeMWOKSU1IM580khpvzKGrMGh+5InKIk
 2OmviOj6j7LB1mgbMiQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250104
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25268-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bvanassche@acm.org,m:beanhuo@micron.com,m:peter.wang@mediatek.com,m:martin.petersen@oracle.com,m:mani@kernel.org,m:linux-scsi@vger.kernel.org,m:can.guo@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[can.guo@oss.qualcomm.com,linux-scsi@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[can.guo@oss.qualcomm.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A71DB6C57DD

TX Equalization training currently has a few error-path gaps that can
make the flow brittle and can leave variant/device cleanup incomplete.

This series hardens TX EQTR in three places:

1. ufs-qcom: route SW FOM setup failures through the shared cleanup path
   so temporary device TX EQ settings are restored and link recovery is
   always attempted before exit.
2. core: treat RX_FOM DME read failures as best effort so TX EQTR can
   continue, and force failed lanes to deterministic 0 FOM.
3. core: always run tx_eqtr POST_CHANGE notify once PRE_CHANGE succeeds,
   even when TX EQTR fails, so variant cleanup is not skipped.

Together these changes improve TX EQTR robustness without changing the
normal success path.

Dependency note:
PATCH 3/3 depends on the patch below, which is still under review:
https://lore.kernel.org/all/c71af930-c7b4-4480-b125-f35cbe35a16f@oss.qualcomm.com/

Please apply this series on top of that patch (or a tree containing it).

v1 -> v2:
- Adopted Peter's comment (Patch 2)

Can Guo (3):
  scsi: ufs: ufs-qcom: Restore TX Equalization settings on FOM failure
  scsi: ufs: core: Tolerate RX_FOM read failures in TX EQTR
  scsi: ufs: core: Always run tx_eqtr POST_CHANGE notify

 drivers/ufs/core/ufs-txeq.c | 33 ++++++++++++++++++++++++---------
 drivers/ufs/host/ufs-qcom.c |  9 ++++-----
 2 files changed, 28 insertions(+), 14 deletions(-)

-- 
2.34.1


