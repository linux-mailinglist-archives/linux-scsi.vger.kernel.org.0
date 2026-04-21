Return-Path: <linux-scsi+bounces-23180-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEmnFmr452kVDgIAu9opvQ
	(envelope-from <linux-scsi+bounces-23180-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Apr 2026 00:21:30 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E347644020B
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Apr 2026 00:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABDA93032DF5
	for <lists+linux-scsi@lfdr.de>; Tue, 21 Apr 2026 22:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8B5379ED6;
	Tue, 21 Apr 2026 22:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nykTAoje"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EFD26B2DA
	for <linux-scsi@vger.kernel.org>; Tue, 21 Apr 2026 22:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776810013; cv=none; b=gY71KZY7Tc1OqFyG4CMitj62hnrxj13t9r47BiXwKKnn+0P1wvpmo6lv+EtEt3Q+IkOCYDRCJlpl1uisBMWhgQIw7xr/1/f3NtkFJmHpkoCBD1R4AbUtSg5kAq9hXwdW5jHcnN0gsMrLxQKFOC2dmXQ/XsopUQJHP32vBY1Rz2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776810013; c=relaxed/simple;
	bh=QDnzplnShSp84VnaWuFDlAriHRwc6rGWS3++dlxjNpc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=gHaDiVqpnml8GzTS0UJksQCh9kclo6h6c0Xq60otXBXXUmK/wljt/udIDNsf1dv1GZ1TQ8OsrJIefl+1qYKUAgQi0kbJ9D8pdqWztbJkWUbCesxqEURum1X2TMDCVQLkrw/wb65+xAEX2NmTms5XJmvG65vBh4NwQ3SBeXAXZuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nykTAoje; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260421222003epoutp04125375be05111d7546bda4695edf9a47~of0i4g2Mb2046620466epoutp04V
	for <linux-scsi@vger.kernel.org>; Tue, 21 Apr 2026 22:20:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260421222003epoutp04125375be05111d7546bda4695edf9a47~of0i4g2Mb2046620466epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1776810003;
	bh=QDnzplnShSp84VnaWuFDlAriHRwc6rGWS3++dlxjNpc=;
	h=From:To:Cc:Subject:Date:References:From;
	b=nykTAojerhaSlyTgLiAlONCK2MoxSntLQ383OJV8eaUgbc6RhoC7op5sYg8AUYKfE
	 9goL08RW1Tsmab3ftoPYBCTelwUBgoK6XAv43Pk8vtoMMnwZhYToFcHNtu3SYKN7us
	 pJIOlseE0Vc4pXuvJ2L+Ux8ut49H4zY0acrS6cco=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPS id
	20260421222002epcas2p366680424553d03e9461b728dbf82f43f~of0iMbY5-2379823798epcas2p3A;
	Tue, 21 Apr 2026 22:20:02 +0000 (GMT)
Received: from epcpadp1new (unknown [182.195.40.141]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4g0cH63lncz6B9m5; Tue, 21 Apr
	2026 22:20:02 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20260421110151epcas2p40628a13eb86c5c9b90626d14efc3b3ba~oWkZvLUGy0082500825epcas2p44;
	Tue, 21 Apr 2026 11:01:51 +0000 (GMT)
Received: from KORCO118546 (unknown [12.80.207.184]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20260421110151epsmtip2b798fd67b72782d1e07b85b8a00194ed~oWkZmlBNx2226522265epsmtip2Y;
	Tue, 21 Apr 2026 11:01:51 +0000 (GMT)
From: "hoyoung seo" <hy50.seo@samsung.com>
To: <can.guo@oss.qualcomm.com>
Cc: <James.Bottomley@HansenPartnership.com>, <adrian.hunter@intel.com>,
	<alim.akhtar@samsung.com>, <avri.altman@wdc.com>, <beanhuo@micron.com>,
	<bvanassche@acm.org>, <chullee@google.com>, <huobean@gmail.com>,
	<keosung.park@samsung.com>, <linux-kernel@vger.kernel.org>,
	<linux-scsi@vger.kernel.org>, <liu.song13@zte.com.cn>, <mani@kernel.org>,
	<martin.petersen@oracle.com>, <peter.wang@mediatek.com>,
	<rafael.j.wysocki@intel.com>, <ram.dwivedi@oss.qualcomm.com>,
	<tanghuan@vivo.com>, <vamshigajjela@google.com>, <kwangwon.min@samsung.com>,
	<kwmad.kim@samsung.com>, <cpgs@samsung.com>, <h10.kim@samsung.com>,
	<alim.akhtar@samsung.com>
Subject: Re: [PATCH 1/2] scsi: ufs: core: Introduce function
 ufshcd_query_attr_qword()
Date: Tue, 21 Apr 2026 20:01:46 +0900
Message-ID: <1891546521.01776810002507.JavaMail.epsvc@epcpadp1new>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdzRcWO56qlmc4MCTTyaeEevuRaU8Q==
Content-Language: ko
X-CMS-MailID: 20260421110151epcas2p40628a13eb86c5c9b90626d14efc3b3ba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260421110151epcas2p40628a13eb86c5c9b90626d14efc3b3ba
References: <CGME20260421110151epcas2p40628a13eb86c5c9b90626d14efc3b3ba@epcas2p4.samsung.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[HansenPartnership.com,intel.com,samsung.com,wdc.com,micron.com,acm.org,google.com,gmail.com,vger.kernel.org,zte.com.cn,kernel.org,oracle.com,mediatek.com,oss.qualcomm.com,vivo.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23180-lists,linux-scsi=lfdr.de];
	DKIM_TRACE(0.00)[samsung.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	RCPT_COUNT_TWELVE(0.00)[25];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hy50.seo@samsung.com,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: E347644020B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

How about you to add EXPORT_SYMBOL at ufshcd_query_attr_qword() function.=
=20
In the case of ufshcd_query_attr(), there is export_symbol so it can be use=
d in vendor driver.
Likewise, if export_symbol is registered in ufshcd_query_attr_qword(), it c=
an be used in the vendor driver and the pair will be correct.

Thanks.

SEO.



