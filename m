Return-Path: <linux-scsi+bounces-5260-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B20928D7581
	for <lists+linux-scsi@lfdr.de>; Sun,  2 Jun 2024 15:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 395A71F220E8
	for <lists+linux-scsi@lfdr.de>; Sun,  2 Jun 2024 13:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6AF3B290;
	Sun,  2 Jun 2024 13:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SKRqhHmf"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4D73D549
	for <linux-scsi@vger.kernel.org>; Sun,  2 Jun 2024 13:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717333311; cv=none; b=M/2/YuClhRTmFlnodyqSXLfXQQjJUlarnTDLGgj4Hvikk0nUw/BcYFY3p0vbjbcTf+u4X2nC+iIJaJVa3XMsJA0lomZjbhmT4cZb5yr4H9wFQVkxv1MRaccU7HLTWvmu/0RoDh+3emk09yfqV3Db0GPqG7GN4MW+T/B4/gwQlg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717333311; c=relaxed/simple;
	bh=rHCZCFCbAOCe+0obDysUSNu4wORZPi6NKPSAyIbFDII=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=ZsSTvd60MInr2R/3cfGG9T5SjyOM03CFzyvwCA8yMt4GJ6nFyVfLp97WZkQuZbvQUXQMbqUeBeQoU5NpNaaWHlvGYeL99OpjZ/fnbaUP+4b5PAoVn/14dIlDKcFy17XdFSv5mPKySyM2GDaJhmMf55m1kv5UkMmY67+L/Sd15ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=SKRqhHmf; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240602130141epoutp04fe10dfbbecb2489a8a991a1cd411fa08~VMYn8ZuPE2181721817epoutp04c
	for <linux-scsi@vger.kernel.org>; Sun,  2 Jun 2024 13:01:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240602130141epoutp04fe10dfbbecb2489a8a991a1cd411fa08~VMYn8ZuPE2181721817epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717333301;
	bh=rHCZCFCbAOCe+0obDysUSNu4wORZPi6NKPSAyIbFDII=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SKRqhHmfBSPkcAIqZvms8GLmHDo2PwGcOTDGLPbSti0I/AVPzEX3DbCyTMq5p0VfY
	 G3MlwRC4bK5x8QDJZbX4sDElfRe+jHDX+V3f+0TZ0rGxg9GMBwd4Pau0mHmFtxPILu
	 hnmwyKfX+W6O1XXAzG1BwU2eozdlCtGVS0illt5w=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240602130140epcas5p25c2d695eda36cf366a0a4a4a01c4d72e~VMYnNGZ7q1672216722epcas5p2-;
	Sun,  2 Jun 2024 13:01:40 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4VscSM49VPz4x9Ps; Sun,  2 Jun
	2024 13:01:39 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1B.21.08853.33D6C566; Sun,  2 Jun 2024 22:01:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240531140203epcas5p1fed913b6729b684e0916dfd62787be13~Ul6w9HJG72010620106epcas5p1W;
	Fri, 31 May 2024 14:02:03 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240531140203epsmtrp1d3e14a45850cff935f0c63202c392ca7~Ul6w8M3W40787407874epsmtrp1N;
	Fri, 31 May 2024 14:02:03 +0000 (GMT)
X-AuditID: b6c32a44-d67ff70000002295-79-665c6d33bd5b
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	35.7D.18846.B58D9566; Fri, 31 May 2024 23:02:03 +0900 (KST)
Received: from nj.shetty?samsung.com (unknown [107.99.41.245]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240531140201epsmtip127bef841828dca583bedc8f707b5bfe0~Ul6uqPXcn2218222182epsmtip19;
	Fri, 31 May 2024 14:02:01 +0000 (GMT)
Date: Fri, 31 May 2024 13:55:01 +0000
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, Richard Weinberger <richard@nod.at>, Anton
	Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg
	<johannes@sipsolutions.net>, Josef Bacik <josef@toxicpanda.com>, Ilya
	Dryomov <idryomov@gmail.com>, Dongsheng Yang <dongsheng.yang@easystack.cn>,
	Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>,
	linux-um@lists.infradead.org, linux-block@vger.kernel.org,
	nbd@other.debian.org, ceph-devel@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org, Bart Van Assche
	<bvanassche@acm.org>
Subject: Re: [PATCH 13/14] block: remove unused queue limits API
Message-ID: <20240531135501.c3yes3jbg7dl3g5w@nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240531074837.1648501-14-hch@lst.de>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf1RTZRg+371328UaXSYcPyA8eD1WQsAWY1xIFI8cuxzMFvpHPw+N7bIR
	+9U2JLEQTKoxCQjiwIIpVCJoioAIEnCCgwocwYJE6ICa48gPicEy6EirwYbH/573ed/nfb/n
	e78PR3lzbD88VW1gdGqJkmRvwJq7t78YEq56L4VfXBhAPSy7iFFnxwvYVKntH5SyjX6NUKWW
	YUDVnu1BqDuWL9jUQv0iRq3cE1DtY8GUaaSFTeXX7aNqrjkQ6vHkjwhV3PoQUGWD37GopaZi
	JNaLHhpOoB/Unkbp2eJCQOdeeoZuNY9z6KEb6XTj90fpbtswRreNZrPpUctH9MLkGEb/9vdn
	KF2Q34zRhY0XWbS9YbP4uXfSdigYiYzRBTJqqUaWqpbHkAkHkvYkRYj4ghBBFBVJBqolKiaG
	jNsnDtmbqnRaJAMPSZTpTkos0evJsJ07dJp0AxOo0OgNMSSjlSm1Qm2oXqLSp6vloWrGEC3g
	81+JcBZ+kKa4XDoFtEbWx01/5nGyQQeWBzxwSAjhlyvL7DywAecRbQA2LPZwXMEigPMDd8GT
	4NJVK7Iu+aOxAnElWgHsnx3CXIEdwKqiCbBahRHb4LlyCysP4DibCIb9/+GrtDdBwsmZG2td
	UeIuBud+6ljrupGIhY9Kbq1pucQeONE6jbqwF+wtt2KrfTyIcDifd3hVCwkbDvN/nuK4ThQH
	/6276ja0Ec5ca3LzfnC64HM3zoC1JWfYLvFxAM0jZuBK7IK5fQVrw1BCAevn7G4+AH7Tdx5x
	8Z4w//G6fS5ssazjrfDchVNsF/aFt5Zy3JiG1ok+9xWdB3B2YBgtBJvNTxkyPzXPhaOh0XaM
	ZXYaRQl/WOPAXXA7vHAl7BRg1QFfRqtXyRlphFagZjKerFmqUTWAtXcfFNcCbp90hHYBBAdd
	AOIo6c39KuvdFB5XJjmcyeg0Sbp0JaPvAhHOBRWhfj5SjfPjqA1JAmEUXygSiYRR4SIBuYk7
	m1sp4xFyiYFJYxgto1vXIbiHXzbiFfns7jSrDakcXzkoDYqt3zL1a8eRm1s4C6I7jClr28jr
	XP83tZ1hh2bzOMZXl+vGgnrt3sKZxF3enUm+Ro71jUd6n5qdwX9JM+9Z7NU+g4tG0w9bPzkx
	ai17O96abD16OqJNMcWoxidr24ubxcrMhIrfddoMqV6crJtJmV8uqRT7H7Dw9zvOvHAzsQo+
	32Lq2XSlyDjQzSn7BXn/2GAv6Xm/IUv4rcCRfV22d8kUudumO1jd451TwXopueStFc/5+M7+
	/ZdfSwF4dahg4cPpHMeRsZL4cB56XK6hh5GeyHL5g1hWP2uhShVwn/fpbVWDyaPmut0+Fn2y
	3X/y5aBEEtMrJIIgVKeX/A8paUBugAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsWy7bCSnG70jcg0g1vHTS3ezNjIYrH6bj+b
	xbQPP5ktPtycxGQxbd4VRouVq48yWdyf185m8XHDJxaLPw8NLfbe0rbovr6DzaJ3lY/F8uP/
	mCx+P13LZDF55xtGixnnF7NafN8ymclB0OPyFW+P5yuXMXu8njyB0aN1K7fHzll32T0uny31
	2Lyk3uPwhyssHrtvNrB53JxX6PHx6S0Wj6vfmpk9+nu3sXhM2LyR1ePzJrkA/igum5TUnMyy
	1CJ9uwSujD/7bQt2M1V8enaMrYGxi6mLkZNDQsBE4tHmOUA2F4eQwHZGiSnbN7FDJCQllv09
	wgxhC0us/PecHaLoI6PEnJPnWUESLAKqEmtmzgOyOTjYBLQlTv/nAAmLCChJPH11lhGknlng
	GYtE39JLjCAJYQEHia9TroHZvALOEvd2vgRbICQQJdE96SQTRFxQ4uTMJywgNrOAmcS8zQ+Z
	QeYzC0hLLP/HAWJyChhLvO+qnMAoMAtJwywkDbMQGhYwMq9iFE0tKM5Nz00uMNQrTswtLs1L
	10vOz93ECI5LraAdjMvW/9U7xMjEwXiIUYKDWUmE91d6RJoQb0piZVVqUX58UWlOavEhRmkO
	FiVxXuWczhQhgfTEktTs1NSC1CKYLBMHp1QDU92Ng1vsGPLZ9/Q3P6mtF/45JfwVp+XRWxsW
	apxjUN5zSTn9x97PQjtt5hWJVNTdbBAvnpmak8O3T19A1IH3/3uhr9PzeZwuyp+6p5068b/2
	Hb7Ddlpxl3Z8eJcsea0gdc5h+U3zNBmru1/vKYx7nXojdu2t/6/CL3/+I/p8qtLl3847l/5I
	+hpaaCMbIiBwtjV3+znPnq+mtwT3cV5/6Nhav/KTjWQiry5nqdvE889vHWljnrvFWmF3widZ
	Jh5PsaeyPenOihs/rz4wo6X+69O0LY+uO5zK4zue1bpstc3vov3FFnpScyVmdtadnPWge7ag
	6hZ7nlV37kiItZ5dy7z6pSATKw+vXcq5aeV3NZVYijMSDbWYi4oTAW59SSg6AwAA
X-CMS-MailID: 20240531140203epcas5p1fed913b6729b684e0916dfd62787be13
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----4kURd6qQA_jt7Hem8gQqXiu1-FVD8qSeML2_RvQot6TDP4ZY=_48cac_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240531140203epcas5p1fed913b6729b684e0916dfd62787be13
References: <20240531074837.1648501-1-hch@lst.de>
	<20240531074837.1648501-14-hch@lst.de>
	<CGME20240531140203epcas5p1fed913b6729b684e0916dfd62787be13@epcas5p1.samsung.com>

------4kURd6qQA_jt7Hem8gQqXiu1-FVD8qSeML2_RvQot6TDP4ZY=_48cac_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 31/05/24 09:48AM, Christoph Hellwig wrote:
>Remove all APIs that are unused now that sd and sr have been converted
>to the atomic queue limits API.
>
>Signed-off-by: Christoph Hellwig <hch@lst.de>
>Reviewed-by: Bart Van Assche <bvanassche@acm.org>
>---
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>

------4kURd6qQA_jt7Hem8gQqXiu1-FVD8qSeML2_RvQot6TDP4ZY=_48cac_
Content-Type: text/plain; charset="utf-8"


------4kURd6qQA_jt7Hem8gQqXiu1-FVD8qSeML2_RvQot6TDP4ZY=_48cac_--

