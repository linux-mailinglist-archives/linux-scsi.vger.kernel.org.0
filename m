Return-Path: <linux-scsi+bounces-1824-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D6D8385B0
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jan 2024 03:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A0E4B2AE39
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jan 2024 02:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935F053E0E;
	Tue, 23 Jan 2024 02:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BYRBrXIw"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E18153818
	for <linux-scsi@vger.kernel.org>; Tue, 23 Jan 2024 02:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705977517; cv=none; b=o+SMex8j8Ijq52cTEA1ZjgSer5D82niPL47q1r2+W31aaRDKGRtUny5tBNKoHauvHk8dVbtMwd4olqEbg6323NnDXcNfJ9YjjWTLJj6ggFH8TWjsb3G9K8YwDJitLPy9wgBL9f6pXGCBGZ8ABOXrodSG2+yYZ00aeIMxnuCCX6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705977517; c=relaxed/simple;
	bh=NMkbvQWBpaDquBXyQNuJ0RBaQWQpPGCLwk3DU4gb0wU=;
	h=From:To:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=KXkX5xkH35EwuV5rJCTmjuVaSvm+UCq5AMI73lTqf1ZWX9ug//YsThJHxLxlfEWviR537Ku1QcGmC2niuBYyIFkMcovqg9tV15wTxOTeEZWMlT8Z/DPGfSELgopRhQ/hND2lnE8evrSQ/a+sP19thKEqMjPrfUAzDxhJhpflDFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BYRBrXIw; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240123023832epoutp0348692a53f82da9905fa6555a032b2d06~s2YJcz3-91751717517epoutp03Y
	for <linux-scsi@vger.kernel.org>; Tue, 23 Jan 2024 02:38:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240123023832epoutp0348692a53f82da9905fa6555a032b2d06~s2YJcz3-91751717517epoutp03Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1705977512;
	bh=S3jPkNa3/PZ2OJO8zbSOhbe22tNmJ2PWhwjWuMp+BO4=;
	h=From:To:In-Reply-To:Subject:Date:References:From;
	b=BYRBrXIwKX8Va09yN64Lyrmlnnwfiyt0LPs7QCJCTCNxuhi86IyBOL6FZQean9TEK
	 hVsLuvDTc6nFUSeqPmtcF8cyoDPoKCB5b4Xrh5AyCcPFFctLSKt8CpGYIKk0//PnGt
	 P9HzZ1IBXox/iROkGwbogDAEJsJbrhk/6mocLlo0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20240123023832epcas2p2622dffc68dd43308307825bb95150098~s2YI3bwyr1646216462epcas2p2W;
	Tue, 23 Jan 2024 02:38:32 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.99]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4TJrqq36Ljz4x9Q4; Tue, 23 Jan
	2024 02:38:31 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	78.F5.09607.7A62FA56; Tue, 23 Jan 2024 11:38:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20240123023830epcas2p2fc4934719efacb4eccf527d014793589~s2YHwn-Eo2358723587epcas2p2Y;
	Tue, 23 Jan 2024 02:38:30 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240123023830epsmtrp15a8f18e5a5e59e0fe1b49d3c037d2d9c~s2YHv0uTV0336603366epsmtrp1b;
	Tue, 23 Jan 2024 02:38:30 +0000 (GMT)
X-AuditID: b6c32a48-bcdfd70000002587-7a-65af26a79c04
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	56.14.08755.6A62FA56; Tue, 23 Jan 2024 11:38:30 +0900 (KST)
Received: from KORCO118546 (unknown [10.229.38.108]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240123023830epsmtip1e6e4b034681e02732908f0820cc7e993~s2YHhMFMk0091800918epsmtip1O;
	Tue, 23 Jan 2024 02:38:30 +0000 (GMT)
From: "hoyoung seo" <hy50.seo@samsung.com>
To: "'Bart Van Assche'" <bvanassche@acm.org>, <linux-scsi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <alim.akhtar@samsung.com>,
	<avri.altman@wdc.com>, <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
	<beanhuo@micron.com>, <kwangwon.min@samsung.com>, <kwmad.kim@samsung.com>,
	<sh425.lee@samsung.com>, <sc.suh@samsung.com>, <quic_nguyenb@quicinc.com>,
	<cpgs@samsung.com>, <grant.jung@samsung.com>, <junwoo80.lee@samsung.com>
In-Reply-To: <06e0ae57-f567-4b90-ad68-4ae73909c29e@acm.org>
Subject: RE: [PATCH v1] scsi: ufs: core: Remove the ufshcd_release in
 ufshcd_err_handling_prepare
Date: Tue, 23 Jan 2024 11:38:30 +0900
Message-ID: <017501da4da5$405e5ec0$c11b1c40$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQH1h0Q8JIMtOyfGxnoTUCtVKJ9etQJjCVVCAjugl6SwizYtgA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTZxTf13u9vbDVXErdPjBBvG5mgPTBqxcUQiaaOqZpMpYsLg46+lka
	+kpvcQzmZDMC1oXHMhZplUDnJDPMTsXyEATKGBF0CRVj0aiAwMRBUvGxAQHXlxv//c45v985
	v/M9SIz/BxFJqnUmZNQpNDQRijv6Y6TxzVvtSLw8uoEZb3AQzOziLYLpmziOMz94FjFm1hnD
	LK3YuYzN7eAwnStHOcxldwfOjLUO4MzNzlMEc+J2O8E0D65ymLpHg1zGfM8NmJ9W5/FMSnZz
	NFtWY+sFsr/tlYTsyfQdXFbb9ZWsqvUckD29GCWr6D3BkZP7C3cUIIUSGaORLl+vVOtU6XT2
	h7k7c5NTxJJ4SSojpaN1Ci1Kp7M+kMfvVmu8/unoQwpNkTclV7AsLcrYYdQXmVB0gZ41pdPI
	oNQYpAYhq9CyRTqVUIdMaRKxOCHZS8wrLFj+xs4x/CMoHjnmIspAT5gZhJCQSoJNjcOYGYSS
	fKodwIapXiIQLAD48tuzweAFgF//7CFeSRytLq4P86luAB/PJAdIswD++fsZ3FcgqFhYPd/q
	VwuoTgxeuN/sLZBkCLUddv6S4eOEU/nw1os6fyOcegeOHR32D+BRqbB2ahwP4DB4rX7KjzFq
	E2ybP4UFTETDxemz63xYQL0HB545QYAjgNbj5f59IDVOwumOoaAgC570OIM4HD4ebOUGcCSc
	rS7n+rxBioWWptKAtgxAp9US5CRCy0wF8HEwKgbaO0UB+hb4252gtfWwsn8lyObBsgvLwY48
	WFnOD6RpeP303WAawj6rpgbQljU7WtbsaFmzi+X/sY0APwfeRAZWq0JsgiHpv6vO12svAv/D
	jpW1A+u8R+gEHBI4ASQxWsBzR5xHfJ5S8UUJMupzjUUaxDpBsvfUa7HIDfl678/QmXIlSani
	pJQUiTQhWSyl3+LdP3ZayadUChMqRMiAjK90HDIksozTv+vA91G2T7QtgO6Nkp3ZkqORrzaH
	Mokll7PGE1M0e19SnxanqebK39jt3pfWUa/9Tr7r3Rsjzw+Pt1waHtsqtQwfLFto+dL4YHJj
	ToQbcV0t5j7rdqxuaaRkyB0nOfzUXnrkysdXewbULBpUh7UcaPsrPkdYPPpR18MEkXhf5uuc
	hz0Re6cdbbflCD3Pa/9xW5dloqFiMz10vj97vVYwNaelhY1v70G2zOoF4aWJzx5EbqsXmp8V
	nqx8MlMqvXrvelzq592b2vK6XzMPLFmadrruXrHtn3t/cp3woKe2pHRz1SOrR6RM3BgnQo1H
	2iblNXZb+J6QX5euibAMV9WNQzTOFigksZiRVfwLRL9yt2EEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsWy7bCSnO4ytfWpBpcumVo8mLeNzeLlz6ts
	FgcfdrJYTPvwk9ni5SFNi19/17NbLLqxjcli199mJoutN3ayWNzccpTF4vKuOWwW3dd3sFks
	P/6PyWLqi+PsFl13bzBaLP33lsVBwOPyFW+PCYsOMHp8X9/B5vHx6S0Wj4l76jz6tqxi9Pi8
	Sc6j/UA3UwBHFJdNSmpOZllqkb5dAlfG76b1TAU/RCoutl5ia2DcL9jFyMkhIWAisW3LJfYu
	Ri4OIYHdjBLNP3exQSQkJP4vbmKCsIUl7rccYYUoes4osWPDQrAEm4CWRP/bLWwgCRGBc8wS
	Jze+YIGo2sUoMWXhMaAWDg5OAWuJXWvtQBqEBRIl7r8/yQpiswioStxsPg22jVfAUmLikwcs
	ELagxMmZT8BsZgFtiac3n0LZ8hLb385hhrhIQeLn02Vgc0QEnCSOfjnECFEjIjG7s415AqPQ
	LCSjZiEZNQvJqFlIWhYwsqxilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAiOVS3NHYzb
	V33QO8TIxMF4iFGCg1lJhPeG5LpUId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rziL3pThATSE0tS
	s1NTC1KLYLJMHJxSDUxnl53QVshdEG0mKGC5c035kuUJZ5SPV7D9mujwu91ijVbr7ekSOkmF
	XNN3WwgcFntt2LNubVrq8p6iZZrpV16/0p0uxTJph4Lj2md9y2/1qrw95RfgMP/gls8rcxfm
	S5xh1Uj3TOdN3ZHb9kZO7eR9x7tBSRfc3zyZY/+0jF90W9rMOxz2JtvfJmoGJspunrDnRn5j
	478gnU/z3X5pRS/1D8+sdqlw3/fHil3N55fWZ06PZ/J1Lc0dJ3bJ7HOzjFZhKH+75u9nbuYF
	B+ZzOnVPM4jyDfm7tj/+T+zOFXzv3gbUnTyZ0ZjHHCi2pubv0sYZV342qP07+WCBUsZBnh03
	lphGT5kwW/r+F/1rnopKLMUZiYZazEXFiQDAo9L8RAMAAA==
X-CMS-MailID: 20240123023830epcas2p2fc4934719efacb4eccf527d014793589
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240122083204epcas2p26a1bca522e201972ca072e0b24d23a52
References: <CGME20240122083204epcas2p26a1bca522e201972ca072e0b24d23a52@epcas2p2.samsung.com>
	<20240122083324.11797-1-hy50.seo@samsung.com>
	<06e0ae57-f567-4b90-ad68-4ae73909c29e@acm.org>

> -----Original Message-----
> From: Bart Van Assche <bvanassche@acm.org>
> Sent: Tuesday, January 23, 2024 5:37 AM
> To: SEO HOYOUNG <hy50.seo@samsung.com>; linux-scsi@vger.kernel.org; linux-
> kernel@vger.kernel.org; alim.akhtar@samsung.com; avri.altman@wdc.com;
> jejb@linux.ibm.com; martin.petersen@oracle.com; beanhuo@micron.com;
> kwangwon.min@samsung.com; kwmad.kim@samsung.com; sh425.lee@samsung.com;
> sc.suh@samsung.com; quic_nguyenb@quicinc.com; cpgs@samsung.com;
> grant.jung@samsung.com; junwoo80.lee@samsung.com
> Subject: Re: [PATCH v1] scsi: ufs: core: Remove the ufshcd_release in
> ufshcd_err_handling_prepare
> 
> On 1/22/24 00:33, SEO HOYOUNG wrote:
> > If err_handler is performed in the suspend/resume situation,
> > ufs_release can be called twice and active_reqs valid can be negative.
> > This is because ufshcd_errhandling_prepare() and
> > ufshcd_err_handling_unprepare() repeatedly release calls.
> > Eventually, active_reqs have a value different from the intention.
> > To prevent this, release duplication processing was removed.
> >
> > Signed-off-by: SEO HOYOUNG <hy50.seo@samsung.com>
> > ---
> >   drivers/ufs/core/ufshcd.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> > index 7c59d7a02243..423e83074a20 100644
> > --- a/drivers/ufs/core/ufshcd.c
> > +++ b/drivers/ufs/core/ufshcd.c
> > @@ -6351,7 +6351,6 @@ static void ufshcd_err_handling_prepare(struct
> ufs_hba *hba)
> >   		ufshcd_hold(hba);
> >   		if (!ufshcd_is_clkgating_allowed(hba))
> >   			ufshcd_setup_clocks(hba, true);
> > -		ufshcd_release(hba);
> >   		pm_op = hba->is_sys_suspended ? UFS_SYSTEM_PM :
> UFS_RUNTIME_PM;
> >   		ufshcd_vops_resume(hba, pm_op);
> >   	} else {
> 
> I think that the above ufshcd_release() call pairs with the ufshcd_hold()
> call three lines above it and hence that removing that call would be wrong.
> 
> Thanks,
> 
> Bart.

Hi,

It was a different when I tested it.
If __ufshcd_wl_resume() is called active_reqs is 1.
Because ufshcd_hold() is called in __ufshcd_wl_suspend().
If occurred hibern8_exit failed in __ufschd_wl_resume(), ufshcd_release()
is called in the :out syntax, and active_reqs becomes 0.
After that, active_reqs becomes 0 because ufshcd_hold() is called 
from ufshcd_err_handling_repare()and ufshcd_release() is called again while
err_handler is operating.
When err_handler is completed, active_reqs becomes negative because 
ufshcd_release() is called again in ufshcd_err_handling_unprepare().
I tested it while printing the log, and if I misanalyzed it, let me know.

Thanks,

SEO.


