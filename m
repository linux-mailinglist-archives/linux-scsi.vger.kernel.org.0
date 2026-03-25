Return-Path: <linux-scsi+bounces-22495-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAQ7BgIBxGmlvQQAu9opvQ
	(envelope-from <linux-scsi+bounces-22495-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 25 Mar 2026 16:36:34 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AAF328233
	for <lists+linux-scsi@lfdr.de>; Wed, 25 Mar 2026 16:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4228730C2D8E
	for <lists+linux-scsi@lfdr.de>; Wed, 25 Mar 2026 15:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4FFD3C3453;
	Wed, 25 Mar 2026 15:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hCrtGHdB"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635A63DCD9E;
	Wed, 25 Mar 2026 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774452202; cv=none; b=CZ/rlPlmizoP2u7KXj0X1YwOuwyVqLKyiGVEajOoonb3iIgRSsN49Wkp3G/wNwm6dk3sl9KEezwitGoMVJeGF+ziwedElq0wjdqJmu5aspUi3xPg2CtBmr3NEjSUbREyPPZXCXkA00QfKd0b1gZhIV7VfgfOKDgI+XTbK800brk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774452202; c=relaxed/simple;
	bh=8WB7+o8pbyIwNCcq3DXHiZo+ksDR9XtMtR8v6H3QayA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sjfX+bA+l8fxjnRBbNtvM4NrIyukQs7ogX8ol4jkRAdMjG0PPcNsbcPrBfKYrRSaGbrZMBYm5NG7a3t66RqNgbYAwe2R7lquLmd9oO+pV1BquCqYz/O/z5f8HgV0nFgIMic1NXT2od87+eU7HTMkAIBafBtoipHulwH2AhWEujU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hCrtGHdB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PFHFsP1258230;
	Wed, 25 Mar 2026 15:22:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=euxC6EyehTY
	aOpzCPvAMnIph3/JzI8dsl36sn2Y+hEY=; b=hCrtGHdBojY8sqhKT1ZLR4GVk9s
	+eT7/NePquSRJAadVe7A7BQEt9jfLNVkkLpQ2rg/iXnFVxZeCt6XXrm5eRqAFnR6
	jopLanhet8kK4IjBcX6hAlXEsOZueN2aOZNC8bMd6BM0mF1JF1ZhOt6ig6wIooSm
	Eemvur/JzBbtcmVDI/LS2lEEr3TKF7Pb/nOG4JwxTaGlSg9xPCaiwwLQ3euPy42V
	IYVIM2J3mX01qPDxMuCbemhxBcNY2sGu+Ij2J4zOAgJI39i96d6+eKuMuRPzw4fT
	1cpGJq4TnhakUVX5vvMnGwhu/m/M25+KTa9n9EJVgCWb+veH4ROuaMDK5Gg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4dm2s521-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 15:22:58 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PFMvxE009869;
	Wed, 25 Mar 2026 15:22:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 4d445x0tv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 15:22:57 +0000
Received: from NALASPPMTA02.qualcomm.com (NALASPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 62PFMvCe009862;
	Wed, 25 Mar 2026 15:22:57 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-cang-lv.qualcomm.com [10.81.25.255])
	by NALASPPMTA02.qualcomm.com (PPS) with ESMTPS id 62PFMvrd009861
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 15:22:57 +0000
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 359480)
	id 3C1F75B9; Wed, 25 Mar 2026 08:22:57 -0700 (PDT)
From: Can Guo <can.guo@oss.qualcomm.com>
To: avri.altman@wdc.com, bvanassche@acm.org, beanhuo@micron.com,
        peter.wang@mediatek.com, martin.petersen@oracle.com, mani@kernel.org
Cc: linux-scsi@vger.kernel.org, Can Guo <can.guo@oss.qualcomm.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 03/12] scsi: ufs: core: Add UFS_HS_G6 and UFS_HS_GEAR_MAX to enum ufs_hs_gear_tag
Date: Wed, 25 Mar 2026 08:21:45 -0700
Message-Id: <20260325152154.1604082-4-can.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325152154.1604082-1-can.guo@oss.qualcomm.com>
References: <20260325152154.1604082-1-can.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDExMCBTYWx0ZWRfX/TACAWO6UUdL
 RAGOtDalPGvMYbqH3/HidpzoqUMb1ok6T8OLWDCCz+GyeughFbQhRWME/XQ0RnMyosOv8ShsvZf
 SfjMGDGib10UDQo5nXPanzfudeeRnaFfPcdKr90iYWfU2XsBuXMQtVGMERPGeFzc2/iE7HG67Kf
 VxWaPvfGeIWxmTbkl31sIjWOgz84OFyVg4kNANuRkQ7/Zd4JUWCho7KUQgLVEKTt7n1K4hOUfwj
 mO6XyNMIs5zzY4GEm5n3pr8PZz+4log2mCLIY0lbPen6GzaAqu7p67nq3HvlTzQWjFSZK2JwmCA
 KwGoG3L0q8FloPXYnGpIl8Har5TlPhy/95+j+cV67lcMT5QTPENkE0O26Bf5UomyywOivWcLGJw
 OeIauZ0+XSYd5RK+xVkepVEWpK2/g+qAGdehxzNeVtpQBXoN9pLSpDGhR5cIhPyF83VDZ/qRk/6
 ayJapYdqFnooB04QyAw==
X-Proofpoint-GUID: slshi9JwgwBZy_-ScBdN57gK7_vNjonE
X-Authority-Analysis: v=2.4 cv=Fo0IPmrq c=1 sm=1 tr=0 ts=69c3fdd2 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=N54-gffFAAAA:8 a=PY6Zn8H8AAAA:8 a=EUspDBNiAAAA:8
 a=eBzKeFCim48PKetIR0oA:9 a=ySS05r0LPNlNiX1MMvNp:22
X-Proofpoint-ORIG-GUID: slshi9JwgwBZy_-ScBdN57gK7_vNjonE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250110
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22495-lists,linux-scsi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,acm.org:email,micron.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[can.guo@oss.qualcomm.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 19AAF328233
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add UFS_HS_G6 to enum ufs_hs_gear_tag. In addition, add UFS_HS_GEAR_MAX to
enum ufs_hs_gear_tag to facilitate iteration over valid High Speed Gears.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Bean Huo <beanhuo@micron.com>
Signed-off-by: Can Guo <can.guo@oss.qualcomm.com>
---
 include/ufs/unipro.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/ufs/unipro.h b/include/ufs/unipro.h
index 59de737490ca..71a5f643400c 100644
--- a/include/ufs/unipro.h
+++ b/include/ufs/unipro.h
@@ -233,7 +233,9 @@ enum ufs_hs_gear_tag {
 	UFS_HS_G2,		/* HS Gear 2 */
 	UFS_HS_G3,		/* HS Gear 3 */
 	UFS_HS_G4,		/* HS Gear 4 */
-	UFS_HS_G5		/* HS Gear 5 */
+	UFS_HS_G5,		/* HS Gear 5 */
+	UFS_HS_G6,		/* HS Gear 6 */
+	UFS_HS_GEAR_MAX = UFS_HS_G6,
 };
 
 enum ufs_lanes {
-- 
2.34.1


