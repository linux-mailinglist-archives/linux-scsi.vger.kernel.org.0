Return-Path: <linux-scsi+bounces-22915-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LtrI+ak3Wl8hAkAu9opvQ
	(envelope-from <linux-scsi+bounces-22915-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Apr 2026 04:22:30 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0AE3F4FFF
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Apr 2026 04:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA7BF3068F5B
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Apr 2026 02:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9790B3370F0;
	Tue, 14 Apr 2026 02:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eNfodIRk"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A388326927;
	Tue, 14 Apr 2026 02:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776133184; cv=none; b=SWxOTmHviV8OpAFG+sAxGQJT0p9if6fTt/BnFiPJJdh+z4DGeKG3u1kPTmJbFz2vakTjpYVZOhg04aquXsDRghnutF1jIkpHMDYLUUgCkl3XNGVS6ct5ZidLa5fZgurFmQu1pPFMsLHArJUIbaJwacm+o2qoEouOIrBk3VofCKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776133184; c=relaxed/simple;
	bh=wyjuvlpG9V06umbCzLNlV6E/HW/gIAuo2OmGQFbhgx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdh8wgR7sSUjjAzvjWIA9BpIPTNcnDEknO5f2eMr2mITnk7i+SpSvWnFBqKdmAwCIPsAP4+WYZGn0ThNq1gJfO2cXtSTRdwo2e3IBplvw0K/+mX1DASUvqMPfAMKnAliV9P7CwccrKZlJpf7IZz805ZHKRyPcnCSaEHd6Rt4zAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eNfodIRk; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DLA2BL778579;
	Tue, 14 Apr 2026 02:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=I4Sf2zOstUATUO2/ellcp7/baCsECBYUVIJz6rNNyig=; b=
	eNfodIRkRD3s9ny0eqqvYK3sUQgwzQRvgtwNDWAW2SOAGC0eIzzmXtagUZFl/6Gs
	OwY7Y7B7aAfWdCOuXt6AIAiKHdUZI8r1/cU4yOHLX38fQfS717cN1wiZqihSkimt
	7ofrD3IKxdyrefw/+ceKUZqq4zVZYHaBnp80FL2Tpw/gEzzbHLqnDe+x4uLEuWYD
	LVYpkZXH+UbjMkuzEXlf0BWJhC0zoHQE+T7u6KVzL3cPJlGXFQ7GNMLZqztnMsxF
	KZa2YvTHVwEPT6mf6GGxlykVWpb6CcrGSpP1lpdKv2zP/Z9wHV6hITLcYzdfMclw
	muUHQWoU78tMw+MhZXyKAw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh85qgbc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 02:19:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63E2EJYR023512;
	Tue, 14 Apr 2026 02:19:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dh7nj0nvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Apr 2026 02:19:35 +0000 (GMT)
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 63E2JTjn036955;
	Tue, 14 Apr 2026 02:19:35 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4dh7nj0nr0-7;
	Tue, 14 Apr 2026 02:19:34 +0000 (GMT)
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Aaron Kling <webgeek1234@gmail.com>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: core: Disable timestamp for Kioxia THGJFJT0E25BAIP
Date: Mon, 13 Apr 2026 22:19:21 -0400
Message-ID: <177595422532.3963380.6064074585798633468.b4-ty@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403-thgjfjt0e25baip-no-timestamp-v1-1-1ddb34225133@gmail.com>
References: <20260403-thgjfjt0e25baip-no-timestamp-v1-1-1ddb34225133@gmail.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=724 spamscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604070000 definitions=main-2604140019
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDAyMCBTYWx0ZWRfXxbUWpv8iWKpO
 saQVr40jRZ0z14J8D23VM4zEE/62FEWM01n1DjtYzEarmRI3mVus0R/U2pMCe4JdOPoyLjKW6uW
 DpsZ6SluwSu2TsuGetr7YYzIueHHNvgGjhpRVNyoFO0IiAC2OTXI3FdClmhBQA4OQwGI1SZkfrC
 4a7oDcB3oQ+I+lrC0Ude8YPMeZDcUPNswH5SdGhvZiANz6GUq6Eb7MIzOEdQ6V3VZvPDMNmS2c1
 vFGPMXQ8MTcxV8kvyAiBezg3MRvoEWFiBILeRsC0LpzK56VyKtVCO4CrILAB+0asukzy2wEERK/
 rB+MrAU7uVBI5glzvkiZiQ2bFeUEBgKk8JgCdxbDezFbRJHI1NHjQI73Ex3TcORbaEGhp+l5Kp1
 ND5g6Tm6uRpfZJp0qny9MHcqUQ0Kz5TlIxDa4AVK4ldUn7aX4KF6rpHvuqMNOsNF3SDKFc+NU0S
 BlhEDgiB9/1s67jVfLA==
X-Authority-Analysis: v=2.4 cv=Lo6iDHdc c=1 sm=1 tr=0 ts=69dda438 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VwQbUJbxAAAA:8
 a=rqcKahpmklfOZa9TjmQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0hO0wdnAd2JsR22gLsaazEo0Dn5bveax
X-Proofpoint-ORIG-GUID: 0hO0wdnAd2JsR22gLsaazEo0Dn5bveax
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22915-lists,linux-scsi=lfdr.de];
	FREEMAIL_TO(0.00)[samsung.com,wdc.com,acm.org,HansenPartnership.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:dkim,oracle.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.petersen@oracle.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2B0AE3F4FFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 03 Apr 2026 13:41:34 -0500, Aaron Kling wrote:

> Kioxia has another product that does not support the qTimestamp
> attribute.
> 
> 

Applied to 7.1/scsi-queue, thanks!

[1/1] scsi: ufs: core: Disable timestamp for Kioxia THGJFJT0E25BAIP
      https://git.kernel.org/mkp/scsi/c/e423f1c71956

-- 
Martin K. Petersen

