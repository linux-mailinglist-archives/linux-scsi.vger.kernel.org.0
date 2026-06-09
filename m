Return-Path: <linux-scsi+bounces-24581-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qhxbCLBuJ2pcwgIAu9opvQ
	(envelope-from <linux-scsi+bounces-24581-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 09 Jun 2026 03:38:56 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1682C65BB09
	for <lists+linux-scsi@lfdr.de>; Tue, 09 Jun 2026 03:38:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=oracle.com header.s=corp-2025-04-25 header.b=mtCuWkiX;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24581-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24581-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=oracle.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F1E663019093
	for <lists+linux-scsi@lfdr.de>; Tue,  9 Jun 2026 01:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40F0346E4E;
	Tue,  9 Jun 2026 01:38:46 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B054345736;
	Tue,  9 Jun 2026 01:38:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780969126; cv=none; b=nt+2ZBEIIzsDMn4XLIptp0p+q8FhZED0Uv8tRJYrVyGuLaG4ykQL9+GHWNEhYRowTfTA+O5az7pZ9Kz7vzPUQRxrIy/mnqJYtbFEBf/E7WYDEkIMfEy3iO27/Cd3J5zsfMTg0S2zEQmCczUzBWYJz9beyAa8UXlDrqmlrHb0mQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780969126; c=relaxed/simple;
	bh=V6t92xEft3VnT3ansiZ6nhwCKscl+gmEeNcCYTPhOuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bO+GAa4xfEilA1yAG+4U5iFhi9/XqLE6XbmzTGlla7dyAeDCSWTymNY5COdnZonUTQ9h+k1c5bFqG1IbdLqv8+/YUwrUCEcKtAMGpZiQm4K25tl1p40TyhI/87u2eSH5OWfUH0QBClXDHQJvsImvGe1HRmkuIaqeN/PglOpHAzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mtCuWkiX; arc=none smtp.client-ip=205.220.165.32
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658HSXLG974725;
	Tue, 9 Jun 2026 01:38:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=c4Qa+qKOc+MfhoASk6SipBbSv9L+5fIfTiPTxsdk/I8=; b=
	mtCuWkiXfsLJlJCBJogKp78kyf7xN+qHIzZaEE1nsb2qSqPchiM9Xg2hAFsPoyky
	Oj22+MiqLZPu65jFZ/YvNxf9wfTy7S/MFVObnNFY0xtVYTApJl40ARx3prYKEGpZ
	TyFXUOpOGKfXOYimNcfvgk2f/ZsL7OBKRTkgdXTe1oAVATihyaamaK8BAeN025ih
	O1CZqGCs3L4FgnlsAX6ix/y+YOt821iHFZMuJe8/aH0b0T/Hn/qkyIwoF2XwLb4M
	t77omXIpOLY4XZizhtkG7nPM4DFYZO/6r5TIa//TIs+w8mJF0llSC0mjZFiJI6yc
	UMvqJQRYH1lMljQpOpQ/IA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4emaf93f21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jun 2026 01:38:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6591cXJB009151;
	Tue, 9 Jun 2026 01:38:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ema0pg4ku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jun 2026 01:38:37 +0000 (GMT)
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 6591caZV009632;
	Tue, 9 Jun 2026 01:38:36 GMT
Received: from ca-mkp2.ca.oracle.com.com (mpeterse-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.251.135])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4ema0pg4hp-1;
	Tue, 09 Jun 2026 01:38:36 +0000 (GMT)
From: "Martin K. Petersen" <martin.petersen@oracle.com>
To: target-devel@vger.kernel.org, David Disseldorp <ddiss@suse.de>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 0/2] scsi: target: minor CHAP fixes
Date: Mon,  8 Jun 2026 21:38:19 -0400
Message-ID: <178096908533.1867344.12907668340627366039.b4-ty@oracle.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605122019.24146-1-ddiss@suse.de>
References: <20260605122019.24146-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_06,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2606090013
X-Proofpoint-GUID: __ArfIXowBi2YVyIEZ3JawnX9hTLMkv7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDAxMyBTYWx0ZWRfX1TEL7QEuKK/l
 LwdknmarL9ibAKJfpfi0hZhH8P/CZkJMNDDpFBmDN/+/UyJKyl1WESMkdrv7/oiHnpNH+hzSdqB
 GRxHRyxzu0f2XGZnDaNPi+0kKCmXFViokdM6q5fryN59+ukYYZ9kV8h8+i1KO5fQBWcbSHh9Xqx
 1RoIRnR+uTn7G9T6Xhl7ksBBIQ4lvmEiEtRWeOP1L83b6MmsodolafKseRbpS08WF2NhcfdTabr
 B+wyk50IYBOSKi34/zYmQJWQkZAGmIpYFoJaepCzwDoZZ5YHwo+KmoPECB2J7BT1phEyLsqIlJg
 7FqyovnvGkar1BA4+S1klDY/1BtDFXm8rdYg4BwFPyR2oLCfOF0i60PN1iY1vKwBBwAI9Q3ojW9
 GICEiYK6LDOO0iMOZQ5q95kRCkaWyTzAg/Iy9c/Fn+JRUA+3FmzY2UkpO2fFcOAEJnhjakxKxvH
 iXXpHsrdgX9tbK5IjR4H09e5U2nY21TFpG/Nn1cY=
X-Proofpoint-ORIG-GUID: __ArfIXowBi2YVyIEZ3JawnX9hTLMkv7
X-Authority-Analysis: v=2.4 cv=OYeoyBTY c=1 sm=1 tr=0 ts=6a276e9e b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=c92rfblmAAAA:8
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=RmhqBowvpajRLK8GA0IA:9 a=QEXdDO2ut3YA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12312
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24581-lists,linux-scsi=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sashiko.dev:url,oracle.com:dkim,oracle.com:mid,oracle.com:from_mime];
	FORGED_SENDER(0.00)[martin.petersen@oracle.com,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:target-devel@vger.kernel.org,m:ddiss@suse.de,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.petersen@oracle.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1682C65BB09

On Fri, 05 Jun 2026 22:16:46 +1000, David Disseldorp wrote:

> These patches resolve a couple of other issues pointed out by the
> sashiko bot when reviewing a separate CHAP change:
> https://sashiko.dev/#/patchset/20260521151121.808477-1-hossu.alexandru%40gmail.com
> 
> Hexadecimal CHAP_I handling appears to have been broken for over a
> decade, so another option might be to pull out support for such encoded
> values.
> 
> [...]

Applied to 7.1/scsi-fixes, thanks!

[1/2] scsi: target: fix hexadecimal CHAP_I handling
      https://git.kernel.org/mkp/scsi/c/7e161211f1dd
[2/2] scsi: target: use constant-time crypto_memneq for CHAP digests
      https://git.kernel.org/mkp/scsi/c/cf14fc2be868

-- 
Martin K. Petersen

