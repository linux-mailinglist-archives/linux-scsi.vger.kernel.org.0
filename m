Return-Path: <linux-scsi+bounces-1783-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E83835E09
	for <lists+linux-scsi@lfdr.de>; Mon, 22 Jan 2024 10:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BA15B24B5B
	for <lists+linux-scsi@lfdr.de>; Mon, 22 Jan 2024 09:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F096D39FE1;
	Mon, 22 Jan 2024 09:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="TzJtnGkQ"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7C039FE0
	for <linux-scsi@vger.kernel.org>; Mon, 22 Jan 2024 09:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705915433; cv=none; b=ZfmpVe8iQdRfoGoUFck82k1NuEWNio1hOttfSZNE4cIyn43lhzQnw1pwwGj67UV3fUAgosHw2VXgVyvp2T1Uf6LIBEjBfHAqd+n7C3of5ifTHofNYn+gS0r/QaixNb/d90BmXmlg/wG0U4vmug/dnEQ4ijtxQ5ltkEotuQAPMEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705915433; c=relaxed/simple;
	bh=SwrScSab5wWDwtOlpQAVOaOc78P6dsbBs5Xsj7XG6ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=VRavOLITwbzggSZuaaEpr3XJI+UFyJ78Ud0RHviYiyBxic/3oVSZtMkiunriV4aEE3Tfvqworhc8OE/AiCnZsjrKVbDTpwMFdjQOPBZQt74/va/B7yYhCbY3qG3eUc8UNIXIVZgoWRAEVvUTUYX84ayLSIKeSMHv5QdCxJV3Gvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=TzJtnGkQ; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240122092344epoutp02440d2549e681d8fc3128405d8473d979~soQpGaHiA0353603536epoutp02w
	for <linux-scsi@vger.kernel.org>; Mon, 22 Jan 2024 09:23:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240122092344epoutp02440d2549e681d8fc3128405d8473d979~soQpGaHiA0353603536epoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1705915424;
	bh=zX0qWDTs/xgDr9Sr6z3Ege2Z/e+QPUCxSaBiFzBG1Fo=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=TzJtnGkQH6WxvI8ZnlqbYDSIo3pVlYoHOT6zewYErqx+tA0TRBepZ2fLKyyeQM6l4
	 TgtC6PR0YjWZZVWi4q2iGj1eSsnvB3+4KvboLsdbysqFn0vfg2Mv7fb9p2MtD8U2bv
	 z4MbdKON3M3JlOrI6nJ7TJHMySqaMVv/lTxH+pX8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240122092343epcas5p3a328d02426eeb514cf7c94cb99ee7281~soQocDGwD1149711497epcas5p3z;
	Mon, 22 Jan 2024 09:23:43 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4TJPsp0Tq3z4x9Pw; Mon, 22 Jan
	2024 09:23:42 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	9E.18.10009.D143EA56; Mon, 22 Jan 2024 18:23:41 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240122092341epcas5p47b118ee78ba8496ceea9e2d3ea4e04c4~soQmrwZ3w1654316543epcas5p4B;
	Mon, 22 Jan 2024 09:23:41 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240122092341epsmtrp264a8600a5b35daf860e534a3be7002cf~soQmqSbsu0236302363epsmtrp2Q;
	Mon, 22 Jan 2024 09:23:41 +0000 (GMT)
X-AuditID: b6c32a4a-261fd70000002719-50-65ae341dba2b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	E5.EF.07368.D143EA56; Mon, 22 Jan 2024 18:23:41 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240122092340epsmtip2cdc2da648ebb8e30e6ba99435a2cbdc7~soQlKp2M40565805658epsmtip21;
	Mon, 22 Jan 2024 09:23:40 +0000 (GMT)
Message-ID: <23354a9b-dd1e-5eed-f537-6a2de9185d7a@samsung.com>
Date: Mon, 22 Jan 2024 14:53:39 +0530
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v8 05/19] block, fs: Restore the per-bio/request data
 lifetime fields
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, "Martin K . Petersen"
	<martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, Christoph
	Hellwig <hch@lst.de>, Daejun Park <daejun7.park@samsung.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20231219000815.2739120-6-bvanassche@acm.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKJsWRmVeSWpSXmKPExsWy7bCmuq6sybpUgxV9Nhar7/azWbw+/InR
	YtqHn8wWqx6EW6xcfZTJYu8tbYs9e0+yWHRf38Fmsfz4PyaL83+PszpweVy+4u1x+Wypx6ZV
	nWweu282sHl8fHqLxaNvyypGj8+b5Dw2PXnLFMARlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8c
	b2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3SgkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRW
	KbUgJafApECvODG3uDQvXS8vtcTK0MDAyBSoMCE7o+XKH5aCdu6K7dtmMTcwdnJ2MXJySAiY
	SPTc2MHUxcjFISSwm1HiQ/cjVgjnE6NE276DUM43RokFCz+yw7S8/3qZESKxl1GiYWcLM4Tz
	llHi4OXvTCBVvAJ2Er09t5hBbBYBVYnFC46wQsQFJU7OfMICYosKJEn8ujqHEcQWFoiWaFs5
	EWwDs4C4xK0n88HmiAjESbTOegW2jVlgBpPEutfXgIo4ONgENCUuTC4FqeEUsJKY0raaGaJX
	XmL72zlgB0kI7OCQODljLStIvYSAi8T9D2oQHwhLvDq+BeobKYnP7/ayQdjJEpdmnmOCsEsk
	Hu85CGXbS7Se6mcGGcMMtHb9Ln2IVXwSvb+fMEFM55XoaBOCqFaUuDfpKSuELS7xcMYSKNtD
	4vKrh8zwcPvTdoB1AqPCLKRQmYXk+1lIvpmFsHkBI8sqRsnUguLc9NRi0wKjvNRyeIQn5+du
	YgSnXy2vHYwPH3zQO8TIxMF4iFGCg1lJhPeG5LpUId6UxMqq1KL8+KLSnNTiQ4ymwOiZyCwl
	mpwPzAB5JfGGJpYGJmZmZiaWxmaGSuK8r1vnpggJpCeWpGanphakFsH0MXFwSjUwCe8zV1C+
	9TTXevqREx2Vx9+z/569jcHpqayuQnGimvqzaAeLcnvG73W+3ouSVvsfFcn8Fu6+ky3RcrbN
	N+6/91UZfzxUqXX6b32Hb/7XPKt5iSInw51eijtFsit/Y1v2pZb70s3Qmlfc/w7P8PpoIC+0
	MTRrZfHlz5v2/Xc//fzdF9+yfsclm7+v2z7BWvnIgo1lp9Wb0k3LfvcLXt9wTPfMQTMOz6Db
	6WfOSJ2q3s+dvpdzgo37lzn2zI1zWS8yTOEsZpm/8pQMR7FVf7LIsaVvtH9OWVa8f19g7BFp
	r01z96WdT9husiBLNTCsKUmU3/t3Z9f9IqWPr6bPnnYuOkHwx0eH1Bbek/u2LT8qrMRSnJFo
	qMVcVJwIAMQkbcNIBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprEIsWRmVeSWpSXmKPExsWy7bCSvK6sybpUg1lv1CxW3+1ns3h9+BOj
	xbQPP5ktVj0It1i5+iiTxd5b2hZ79p5ksei+voPNYvnxf0wW5/8eZ3Xg8rh8xdvj8tlSj02r
	Otk8dt9sYPP4+PQWi0ffllWMHp83yXlsevKWKYAjissmJTUnsyy1SN8ugSuj5cofloJ27ort
	22YxNzB2cnYxcnJICJhIvP96mbGLkYtDSGA3o8Ts701sEAlxieZrP9ghbGGJlf+es0MUvWaU
	mPlpKliCV8BOorfnFjOIzSKgKrF4wRFWiLigxMmZT1hAbFGBJIk99xuZQGxhgWiJtpUTwXqZ
	gRbcejIfLC4iECdxeP8NsAXMArOYJJ6ff8gGsW0vo8TNFX+B7uPgYBPQlLgwuRSkgVPASmJK
	22pmiEFmEl1buxghbHmJ7W/nME9gFJqF5I5ZSPbNQtIyC0nLAkaWVYySqQXFuem5yYYFhnmp
	5XrFibnFpXnpesn5uZsYwdGmpbGD8d78f3qHGJk4GA8xSnAwK4nw3pBclyrEm5JYWZValB9f
	VJqTWnyIUZqDRUmc13DG7BQhgfTEktTs1NSC1CKYLBMHp1QD0+ppZ67ar/zkXbq8L9Pg97mb
	x3+l2+4022W3JuP9BdaVAS7yX4qcVz8LvNqvu9oiRitk6bN/0a/+bHn/n7Nvd+K5W6/2zihw
	EBGeePbKyoO/ZKWkrey2Po5rbD08TfKayPd16v1SntvmPtx9p9nZ+e4XjXsZ0WWBojub9TP/
	ZLvn9VWdzxLuOWn1vHnyMvPTC47/iqooDm27ek9i6XExJr9usVtXwv980jg+y/COd6+zE/Pk
	Y7JKk9fUG157eHuld5L7q0KN1l2hPx/5blaa/XWb037VmTWtusEM23oPJmZE3Tsp7qPwIYnl
	Euf9jNprj2z/8/7cvupFleLxo56HRdj/nH38ekK317L4TwuSSjWUWIozEg21mIuKEwGS6mrL
	JQMAAA==
X-CMS-MailID: 20240122092341epcas5p47b118ee78ba8496ceea9e2d3ea4e04c4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231219000844epcas5p277a34c3a0e212b4a3abec0276ea9e6c6
References: <20231219000815.2739120-1-bvanassche@acm.org>
	<CGME20231219000844epcas5p277a34c3a0e212b4a3abec0276ea9e6c6@epcas5p2.samsung.com>
	<20231219000815.2739120-6-bvanassche@acm.org>

On 12/19/2023 5:37 AM, Bart Van Assche wrote:

> diff --git a/block/fops.c b/block/fops.c
> index 0abaac705daf..787ce52bc2c6 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -73,6 +73,7 @@ static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
>   		bio_init(&bio, bdev, vecs, nr_pages, dio_bio_write_op(iocb));
>   	}
>   	bio.bi_iter.bi_sector = pos >> SECTOR_SHIFT;
> +	bio.bi_write_hint = file_inode(iocb->ki_filp)->i_write_hint;
>   	bio.bi_ioprio = iocb->ki_ioprio;
>   
>   	ret = bio_iov_iter_get_pages(&bio, iter);
> @@ -203,6 +204,7 @@ static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
>   
>   	for (;;) {
>   		bio->bi_iter.bi_sector = pos >> SECTOR_SHIFT;
> +		bio->bi_write_hint = file_inode(iocb->ki_filp)->i_write_hint;
>   		bio->bi_private = dio;
>   		bio->bi_end_io = blkdev_bio_end_io;
>   		bio->bi_ioprio = iocb->ki_ioprio;
> @@ -321,6 +323,7 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
>   	dio->flags = 0;
>   	dio->iocb = iocb;
>   	bio->bi_iter.bi_sector = pos >> SECTOR_SHIFT;
> +	bio->bi_write_hint = file_inode(iocb->ki_filp)->i_write_hint;

This (and two more places above) should rather be changed to:

bio.bi_write_hint = bdev_file_inode(iocb->ki_filp)->i_write_hint;

Note that at other places too (e.g., blkdev_fallocate, blkdev_mmap, 
blkdev_lseek) bdev inode is used and not file inode.

