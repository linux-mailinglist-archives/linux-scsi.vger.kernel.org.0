Return-Path: <linux-scsi+bounces-25093-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 73k+D2tJNmqd9AYAu9opvQ
	(envelope-from <linux-scsi+bounces-25093-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Sat, 20 Jun 2026 10:03:55 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 894116A8882
	for <lists+linux-scsi@lfdr.de>; Sat, 20 Jun 2026 10:03:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Pwv3og2J;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25093-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25093-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AA12302C915
	for <lists+linux-scsi@lfdr.de>; Sat, 20 Jun 2026 08:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEF51D9A66;
	Sat, 20 Jun 2026 08:03:50 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4534EE573
	for <linux-scsi@vger.kernel.org>; Sat, 20 Jun 2026 08:03:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781942630; cv=none; b=CX8jbDp5cZDDHl/Z/dVSR6RRXl6Pd7nI+pTIXXG6nuiHSwhuEGgfc/VqK5++gwViUAKBahsz2f15c/nAqiKDtwBmCCN7uMcXCLQ+22S02ch/Tm09UeSGjfJd67N162kRHbwulhKEnA2nBiv0wZ3nSL6xzXlNf3ylGKQrp5iVeOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781942630; c=relaxed/simple;
	bh=+fkzQYdnQDenudI4D0tu9At92Bz6KfRxkZyRKU/l0+k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U89/WjfMqjqrcqSZxBgUIahRkZPyMp5jItAYLCkGTsoynII8hB1fXn9+g0OWLIv5ENl3mTQ77tktmRePpjSGF3tsV+V+YdWrhQNTjEd+tgkbrmv+FL1npf3LWzzCkieI48q+lfNN3a0wS18ShKvoHpoMkzZ1MpmLt5G6lNZgBH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pwv3og2J; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65K3Q9sn2624097;
	Sat, 20 Jun 2026 08:03:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=NiagI6vv4nNRjrn1I7yaYZ/XTIBTZ0bE3SW
	I1OmGY5Y=; b=Pwv3og2JxiirFkXA8tTtrQRfNKlHiZ9pnACUGZasz7NEzf8szr+
	G/ZqHcEl7K6/Em2EfcbCkScq8WfY54sr5RZhlIJbK/eXM1MNE91rC7lxscngFnsP
	eZ9jIm+WYVmHYQDzsO7q3UfG21O7hh5Zp1x1Oo64esuYSlPJU7ZqVuUXCMPpXhS/
	fsX6y0UV/sSWgekkBf4T22YypAaM8VbR8VOENuzseNfzkHb/cEXmw5tHkJ+Z5xu+
	lT1EZKrxaedh1Z/PK073UgFeImqs8o6f76cyGcstmFYEK+fR0pTkA8251mJyKIon
	yRJNDB6XFHfQy2zUiY1nSUJ4Ungng7J+Pzg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewjxu8fax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Jun 2026 08:03:29 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 65K83SK7015468;
	Sat, 20 Jun 2026 08:03:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 4ewkxj15wy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Jun 2026 08:03:28 +0000 (GMT)
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 65K83SwL015409;
	Sat, 20 Jun 2026 08:03:28 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-cang-lv.qualcomm.com [10.81.25.255])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 65K83Spx015346
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Jun 2026 08:03:28 +0000 (GMT)
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 359480)
	id 5FEED644; Sat, 20 Jun 2026 01:03:28 -0700 (PDT)
From: Can Guo <can.guo@oss.qualcomm.com>
To: bvanassche@acm.org, beanhuo@micron.com, peter.wang@mediatek.com,
        martin.petersen@oracle.com, mani@kernel.org
Cc: linux-scsi@vger.kernel.org, Can Guo <can.guo@oss.qualcomm.com>
Subject: [PATCH 0/3] scsi: ufs: Harden TX EQTR error handling paths
Date: Sat, 20 Jun 2026 01:03:19 -0700
Message-Id: <20260620080322.3765210-1-can.guo@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIwMDA3NyBTYWx0ZWRfXyospuc3vggho
 z+a5FnS4oICUDeezyhzBktYLXUDejtaD+rNHTUQoLpM0Yttqkx3F7ciO5/q5wMTevKNt3zfbWiE
 Ar9XNELKkAYuUwFioAqW5YZGhOQPBrE=
X-Authority-Analysis: v=2.4 cv=G/ws1dk5 c=1 sm=1 tr=0 ts=6a364951 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=RRY_MtapdLpyJEs6RdQA:9
X-Proofpoint-ORIG-GUID: xLvs3hh8jkg8_Krg-sbb7if10o49u1MC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIwMDA3NyBTYWx0ZWRfXw6dMNhYfgbHN
 fvX4VDoLdXQwUln3r6xaTjNsAZ7tTc5c5TSA54VIPclTwiYt+FTRaa3wyS+XyE+x3OSmJBUurCM
 ZStqFVAxwoeaW5iAO7aOblNh0FisJTlzBpNoiF8pxwhobPG9XxWjSMOU2ftLtSkjS9TsEV3ucUg
 HEf84CU+Rd+vTZO+2HpFNzoiwVtv2zZEt4IQBwlInw5yEZek/R8DM4KRjC4agAyoU6k0OyeCksw
 C/TYz/3C3eN0qEWaOL9KM7GDGtWzz5wI/yQvu6VKjMHcH/SyImz8D/QkkCgewdYOIt9/kyezUf4
 q2XyPT3uIHzPHsVAAW/l4zJy28gfguYzaV/7yLSCmMEsd4YjVwSOI/FKFoPtXYbT3e/U30bJJ3N
 A0RmUb0r7dGB+D/6oCPv3WGduW7lqQuO1iJi+H/Oaw+IzjEIs2jd8WLqa6gKySy+7DH8kiMLUDG
 8mphvLTGbHi838Mn8vA==
X-Proofpoint-GUID: xLvs3hh8jkg8_Krg-sbb7if10o49u1MC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-20_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606200077
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25093-lists,linux-scsi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 894116A8882

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

Can Guo (3):
  scsi: ufs: ufs-qcom: Restore TX Equalization settings on FOM failure
  scsi: ufs: core: Tolerate RX_FOM read failures in TX EQTR
  scsi: ufs: core: Always run tx_eqtr POST_CHANGE notify

 drivers/ufs/core/ufs-txeq.c | 34 +++++++++++++++++++++++++---------
 drivers/ufs/host/ufs-qcom.c |  9 ++++-----
 2 files changed, 29 insertions(+), 14 deletions(-)

-- 
2.34.1

