Return-Path: <linux-scsi+bounces-2055-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CCE8442E7
	for <lists+linux-scsi@lfdr.de>; Wed, 31 Jan 2024 16:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAE20B2D7EA
	for <lists+linux-scsi@lfdr.de>; Wed, 31 Jan 2024 14:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFAA684A3A;
	Wed, 31 Jan 2024 14:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SvTkfkLS"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB6784A37
	for <linux-scsi@vger.kernel.org>; Wed, 31 Jan 2024 14:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712729; cv=none; b=nCaYxIsUAAcqfnzUVJx4W+mJVHDtaSW26cli+PN7u3dkTvEVM5ZQg3cWy90C+HWu/sYuaEIyhS2yyHLQAvyPdXV6ehCcnDb7hEAswZeP6/1hXAqTMM9jvWHzYs/7pIjmvFulpSkAFJdNvbk6r9ns+AUaVm/RlQVus4kuDYWlW6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712729; c=relaxed/simple;
	bh=nDqHNmXaVk3iaCWIIVwOup1ibiGG+7ca/P1Jg6Usy9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=ZLJEZYicJhfIXngt3aH+g0ZTENN/LNb/t/PjtWSmfpAi8bZp8zIhrp5OCHoVkvCKxSA3jYYSMQaWrprcItD/tM88fTdJRnv9u/mRx65z+WTjvitsLBuALIp0Ki/8+N5Hbxv0JjB7Rd8ZJEo60swzNQsYiViB6PxH02kfGGL3mCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=SvTkfkLS; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240131145203epoutp02e257ee24e433f9315b731adad7784feb~vdi3jpnh70507505075epoutp02-
	for <linux-scsi@vger.kernel.org>; Wed, 31 Jan 2024 14:52:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240131145203epoutp02e257ee24e433f9315b731adad7784feb~vdi3jpnh70507505075epoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1706712723;
	bh=nDqHNmXaVk3iaCWIIVwOup1ibiGG+7ca/P1Jg6Usy9M=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=SvTkfkLSARvTM/hX0lgNUO5dHUGCY0mRexaP3+SvsdA1cAekvO6CRCcLOxwI8NEyK
	 8Z39PURxENzdt+DPpZ2CIbpbrEOLS4VEkHem9lE8D0HNww1Pw1NFrz339HamJAl1fH
	 7l+L+AEbBvdCzK+TNX+SJYYQjZYR2nzBoFRYZeFQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240131145202epcas5p2067081da3a03d524ff34259fe8e0eefd~vdi27StRZ2177721777epcas5p29;
	Wed, 31 Jan 2024 14:52:02 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4TQ4kT2pZPz4x9Pp; Wed, 31 Jan
	2024 14:52:01 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	64.B0.10009.19E5AB56; Wed, 31 Jan 2024 23:52:01 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240131145200epcas5p2e92f2e6299d39e32d50be7c195ccf363~vdi1bLSnU2177721777epcas5p27;
	Wed, 31 Jan 2024 14:52:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240131145200epsmtrp19c5cc249ffbe5fdd0a49d13858b91e4f~vdi1aUZIJ1115911159epsmtrp1d;
	Wed, 31 Jan 2024 14:52:00 +0000 (GMT)
X-AuditID: b6c32a4a-261fd70000002719-08-65ba5e91f201
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	44.23.08755.09E5AB56; Wed, 31 Jan 2024 23:52:00 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20240131145158epsmtip1e16bd5031d35b659be96c09027adea27~vdizkYyXF2128021280epsmtip1j;
	Wed, 31 Jan 2024 14:51:58 +0000 (GMT)
Message-ID: <72867a15-95ba-1990-aff2-169d19e4eefc@samsung.com>
Date: Wed, 31 Jan 2024 20:21:57 +0530
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v9 01/19] fs: Fix rw_hint validation
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, "Martin K . Petersen"
	<martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Christoph
	Hellwig <hch@lst.de>, Daejun Park <daejun7.park@samsung.com>, Jeff Layton
	<jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Stephen Rothwell
	<sfr@canb.auug.org.au>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240130214911.1863909-2-bvanassche@acm.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUwTZxzee9deD2L1rBDedcx1t5ANNrCFFq7GOjOZXkAXFhNNcAEPuAHr
	Z3otU0OyEgJBHONrcVBhgwkYiritQQSxGwMn1AxF+RKmIqFkDtIFZDoYEddyzPHf8/vleZ7f
	1/viqKQPk+LZBgtrNjA6EgsUtPeGR0SWp1xh5QOOrVTL/VKMmut9DKgz88so9fz+7wjleHiE
	am75BaGWmxwiyjXxNnXV5RZQp8c6MOp83ypCXXKNiKhbz/qEe8T00HAinXf3LkYPDVhpp+MU
	RneN2zB6YWZCQH/R5gD0onM77fR4kaSAZO2uLJbJYM0y1pBuzMg2ZGrIxEOpe1NVsXJFpEJN
	xZEyA6NnNWT8gaTIfdk6X9OkLIfRWX2pJIbjyB27d5mNVgsryzJyFg3JmjJ0JqUpimP0nNWQ
	GWVgLTsVcnm0ykc8ps1qbpsUmrzguH11BrWB66AYBOCQUMKJklasGATiEqILwC8f5Yv44DGA
	3ZdGED54CmBZvscnwdckYwvrCheAd379XMAHXgBXPfdEfl8xsRv2Dz9ZqyEgwuDX1efW81uh
	u9oj8ONgIg3+M1KzZrqNoOBv7Tn+NEqEwAnPN4gfBxEpsMA+C/z+KFGCwrnuXpGfjxHhcLDS
	6ucEEDvhWN0jjNe+Bi97a1A/HxLDOBxv7MT4puNhfncwP/I2ONvXJuKxFP5RWriO0+Gd6psI
	jy1w+urP6/hdWHCjFPXboL6y313ZwZfaDEtWPAjvLoZFhRKe/Tp8UDEj5HEInKpqWMc0vO24
	KHqxtjPzS1gZkNk3LMW+YXr7hmns/1euAwIHeJk1cfpMllOZog3spy/OnW7UO8Hai45I6ABT
	D+ejegCCgx4AcZQMEjdv72Ql4gzmxEnWbEw1W3Us1wNUvuuUo9LgdKPvSxgsqQqlWq6MjY1V
	qmNiFWSIeK6gNkNCZDIWVsuyJtb8nw7BA6Q2JFn1/j7ZvdqwfnCUnd2fMv5cY0X7z46GFk0z
	X2nVD9DoMeftNn3FyYGwPcXeus6PL3SU57qWj1oHp/eXPbl8s8uzpfrDREVLTLsOZve/t+VV
	ob0x+68ftcK0kISfPjrbULzyZslS6NNz5wuX3HENk97JzTZF+Ikc27VPPhvz1Pf9ECz/dm9t
	ZG/MtSNvadAgY1r9aJ6ictNCGtp7KyqvtfF77ACmUmU+c/9NDo5+cPDQCoqfZo7RnVPqN/C4
	47qEwwvL7j9b6pHueG6xqfK6K/DCK7KilypNo4sXq0ZsmtJNB3N7TrnNFVXJSWpV4XRoLt3d
	ekOKpC8NLUab3jlc09RACrgsRhGBmjnmX4udgzBaBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRmVeSWpSXmKPExsWy7bCSnO6EuF2pBucPmlqsvtvPZvH68CdG
	i2kffjJb/L/7nMli1YNwi5WrjzJZ/Fy2it1i7y1tiz17T7JYdF/fwWax/Pg/Joute6+yW5z/
	e5zVgdfj8hVvj8YbN9g8Lp8t9di0qpPNY/fNBjaPj09vsXj0bVnF6PF5k5zHpidvmQI4o7hs
	UlJzMstSi/TtErgyVm65z1rwlrFi1r+nzA2Mxxi7GDk4JARMJK5/ZOti5OIQEtjNKDFr1ywg
	hxMoLi7RfO0HO4QtLLHy33N2iKLXjBL7z01jAUnwCthJnLjylRHEZhFQlZg3czE7RFxQ4uTM
	J2A1ogJJEnvuNzKBLBMWsJC4va0MJMwMNP/Wk/lMILaIQJzE4f03wOYzC/QzS8xZ+oUVYtle
	Rom9Z9rYQJrZBDQlLkwuBWngFLCSuL7gBRvEIDOJrq1djBC2vMT2t3OYJzAKzUJyxiwk+2Yh
	aZmFpGUBI8sqRsnUguLc9NxiwwLDvNRyveLE3OLSvHS95PzcTYzgiNTS3MG4fdUHvUOMTByM
	hxglOJiVRHhXyu1MFeJNSaysSi3Kjy8qzUktPsQozcGiJM4r/qI3RUggPbEkNTs1tSC1CCbL
	xMEp1cA0L11Rf6/Ntchca3O99hdM5yo9g2P4BZb9yD5j9ebVlXzm1StfijoYxFy3fFkb4XN4
	9U9H4xR1JsY17KGFOdtO1HMcUy/Im2mm1bnVKMIxurfy1H5F0WdnmA/N5Dhed0Pxex3rGfnj
	IQm3367ZPVPk2WOjTpudS8X2Gjy5sDBtTb7t+nNPN19kvWlm4V/HKv7drPEDj+QctamL1jJK
	hp8PmKlmfXPdM8mSorDFbXMl1Q2Su5t+n5NkcTLYGV/962Pngsf/Zeo3CZp+nzxl6uGZ8kGa
	X67+kKnOCDjuu9ja/EDJpizvn07sYl9+5xR5qfNPlnLZdmUNB9+5/FOs265Y7343P04k7IXh
	md86mfVKLMUZiYZazEXFiQC+MizYNwMAAA==
X-CMS-MailID: 20240131145200epcas5p2e92f2e6299d39e32d50be7c195ccf363
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240130214935epcas5p27eab3ae6d0a21c4bbd37a513d279b59a
References: <20240130214911.1863909-1-bvanassche@acm.org>
	<CGME20240130214935epcas5p27eab3ae6d0a21c4bbd37a513d279b59a@epcas5p2.samsung.com>
	<20240130214911.1863909-2-bvanassche@acm.org>

On 1/31/2024 3:18 AM, Bart Van Assche wrote:
> Reject values that are valid rw_hints after truncation but not before
> truncation by passing an untruncated value to rw_hint_valid().

Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>

