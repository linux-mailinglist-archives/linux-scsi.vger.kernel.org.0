Return-Path: <linux-scsi+bounces-7895-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1584E96A09E
	for <lists+linux-scsi@lfdr.de>; Tue,  3 Sep 2024 16:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97C9F1F287CB
	for <lists+linux-scsi@lfdr.de>; Tue,  3 Sep 2024 14:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F3818454E;
	Tue,  3 Sep 2024 14:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dXf5XGmS"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D131850AF
	for <linux-scsi@vger.kernel.org>; Tue,  3 Sep 2024 14:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725373758; cv=none; b=mB1bmwyHlrYFXwPqrmg3bTvBNFxJ6uVQs1lEFfjxQLghW8HRm2cjB6XxsOk840ul0wjiEaEfxZRaNyW8MtOc4mZxa/wSeQbG/Ky/tl063wqzaIE5o0gZdSOjXJt8zGq5H/s6imOdi4uwdMJAmsRYUyDhou73tjX1P6ZcQopfrAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725373758; c=relaxed/simple;
	bh=C4OepwpWUwZYfWEN62YehIeNQxnvoW6TjY4oGs/S4jI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=mvh2pvHNMvVeMohcweLQ0wjNyJjZ2GRx6n+7dLv2O16GpRW3OXq8kFlgtjLZC6n11uIHEtffPVYp1EvvtPDWwVLgszM8290HmNi4Ky86Mdt2EvzZJ/tzcOjAryszNU+/vVR6oAXt1mWU/hf8OHGAb0t/wYzOlrvgC5S31Vwfl2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=dXf5XGmS; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240903142908epoutp03a6e563b811c7eccbea9c43a2278ab48b~xwkhxWiSP0881808818epoutp03Q
	for <linux-scsi@vger.kernel.org>; Tue,  3 Sep 2024 14:29:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240903142908epoutp03a6e563b811c7eccbea9c43a2278ab48b~xwkhxWiSP0881808818epoutp03Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1725373748;
	bh=ZyxS7Jgq+upway2nH7AdIfd0btQEY6emF32Emx9SW/8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=dXf5XGmS/hMnvgd21AcVokU6nw+790aFJyrkgM9/KTD1nEQrUnrpNumdVyeL05Lam
	 PDBBhDOUDoRqr5mM1n8TeoRae+bWsFOuAV7zCiKzAeUfDKulUxI96gMb8tS4cLGdsQ
	 3ilbhQrVlzgHMGviaan/ryKCNJmlBsTOcTSE/FbU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20240903142907epcas5p4a9f0f4aa7112c618f68d7d05ae1d1289~xwkg6I31I1473514735epcas5p4m;
	Tue,  3 Sep 2024 14:29:07 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Wyp0K6Qvmz4x9Pv; Tue,  3 Sep
	2024 14:29:05 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	83.D9.09640.13D17D66; Tue,  3 Sep 2024 23:29:05 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240903142905epcas5p291db855dce2f39166615e1fabe310cfc~xwkegJToW2054720547epcas5p2E;
	Tue,  3 Sep 2024 14:29:05 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240903142905epsmtrp2fc57eb738fa5ff0ae8d83e58537abfc0~xwked9JON1474714747epsmtrp2g;
	Tue,  3 Sep 2024 14:29:05 +0000 (GMT)
X-AuditID: b6c32a49-aabb8700000025a8-bb-66d71d319416
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	74.54.08456.03D17D66; Tue,  3 Sep 2024 23:29:05 +0900 (KST)
Received: from [107.122.11.51] (unknown [107.122.11.51]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240903142901epsmtip236b0a2311ddfd5a5f904d3d83a26f651~xwka47R8B0182501825epsmtip2a;
	Tue,  3 Sep 2024 14:29:01 +0000 (GMT)
Message-ID: <20a9df07-f49e-ee58-3d0b-b0209e29c6af@samsung.com>
Date: Tue, 3 Sep 2024 19:58:46 +0530
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
	Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v4 0/5] Write-placement hints and FDP
Content-Language: en-US
To: amir73il@gmail.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
	brauner@kernel.org, jack@suse.cz, jaegeuk@kernel.org, jlayton@kernel.org,
	chuck.lever@oracle.com, bvanassche@acm.org, "axboe@kernel.dk"
	<axboe@kernel.dk>
Cc: linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, gost.dev@samsung.com, vishak.g@samsung.com,
	javier.gonz@samsung.com
From: Kanchan Joshi <joshi.k@samsung.com>
In-Reply-To: <20240826170606.255718-1-joshi.k@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te1BUVRzu3L3c3cXZui0QRyrZbtgEBOwmbAdHiCmkS1jD5GgzTYobXHYR
	2N32QVoy7kCylvIQCHQXkRREoDDAB/KwWozX4MBItkKurjxqxh0UXOOhBe0r47/v+873zXd+
	5zeHw+J/yQ7gZMg1jEouyaIIb/xCT3BImOhFc7qwuVSERpqbAGqyFBPI1vMAoIrZJRZasfyJ
	obGfLmGooekXDBkr8zE0ddbAQi3FHDR5085GS6cb2ajU9BtA3eOh6NrJd1BX9wCOTpyeZqND
	5nYC1fctY6jZdh9Hw4YqdpwfPfprEn3JYGHTw7dacLqidJCgR69q6dbGrwi6rXY/3Vljx+jO
	MR1Bz02P43TRuUZAD9VcYdP21nXJvI8yN8kYSRqjEjDyVEVahlwaQyVtTXk7JUosFIWJotEb
	lEAuyWZiqPgtyWEJGVmOcSlBjiRL65CSJWo1FRG7SaXQahiBTKHWxFCMMi1LGakMV0uy1Vq5
	NFzOaDaKhMLXoxzGXZmyM7PHvZTfcPc0DgwSOlDP/hpwOZCMhHOWEgf25vDJTgCrbY9xN3kA
	4LWTfZibzAPYU/fdk4jx9nnCfdANYH/7oicyA6BuyoA7XTwyFhbOD7oSOBkEa0vqMLf+LBw4
	NuXy+JGfwEfXq4AT+5DR0HR1xsuJWaQ/HJ864ar2Jb/HoG2ylOUkLGeDzVDjIBwOQQbDkTKt
	M8AlN8KV2ftsdzgQXpypcvkhWc+FZ+b6PfeOh5frjxFu7APv9p3z6AHQfq/bo2dC64QVd+N9
	sL2tyMuN34S6v294OXtZjt6zHRHurqdh4eMpzClDkgcPFvDd7pfgrdJpT9If3jla68E0HO98
	6Grik4UAjhQklgCBYdWzGFaNb1g1jeH/4hqAN4K1jFKdLWXUUUqRnPnsycZTFdmtwPUdQhLb
	gcU6G24CGAeYAOSwKF/ejpbr6XxemmTv54xKkaLSZjFqE4hy7OcIK8AvVeH4T3JNiigyWhgp
	FosjozeIRZQ/z3bgeBqflEo0TCbDKBnVfzmMww3QYbFD+m/XviAQXR7wj+hcbk7pasut1TOB
	+OHFPGlXgjG/6AtT73PaSSZuXrem/IPqbYkTuQ3m20P/xP11sfpjfUHOp+nE0rYDRytzoWzm
	5tC7/IeVT1l2vna+f6ESiBT8Dp/aheULNaPBO95an3eqY8L6yoJxeHyEu2+5f7ZXJtRRgvln
	+jG+0ZJEWevtOb7eK+J1QRWPzGVbm2331sdL+2y63lPDr4L3ln3357Tk7i0J0r8cv/2G5SAR
	WFadUdB6x1CXX1VxJVSZYF80x+nfr8j4sHhD0GaNmfu7+efyhh/LrLt2H9Hn3UXR+jXEdlvL
	WGjB7ueN5SE5vlt+2Lzz0J4/DBSulklEISyVWvIvoDE5FZcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUyMcRzf73menue5dNvjCr+immNGuGQtPy87xuiRrWXW8rLk6Cnpyrmn
	i8yoXWwduZwTXaik1N0OXUq5WrlYq6G8HqfkpZYtreOMvMZ1bP33/X4/r398aVz0hgigU9Iz
	OGW6TC4mvYn6NnHwwrBAe9Kill6Auq+aADL1akk01PYJoELnNxyN9Q5i6EVrI4aqTXcxVHxW
	jaH+awYc1Whp9K7HRaFvlUYK6WzPAGp2zEePLkWipuYOApVUDlDouL2BRFfaf2Po6tAIgboM
	56lVU9jHTzawjYZeiu16VUOwhbpOkn18X8VajHkkW3v5CGstdWGs9UU2yX4ccBDsyRtGwN4r
	vUOxLktQjHCr94pETp6SySlDpTu8d1c5L3gpzggOGDs6yWxwhdIAAQ2ZcFjcV0dqgDctYqwA
	tujaCQ8wDaqfjf4j+cLq34OUhzQEYN7LW8ANCBkpzP/SOU4imNnwckEF5rlPhh1F/eNGU5id
	sKkvZ/zuyyyFtvvDXu4Z/xvg6C/B3KZ+jBmDtv7rwL3gzDCAR1vvEJ64fABN7dq/BWmaZObB
	7tMqt1rALINjzhHK4xQBNXUa4JmD4c3h83gBEBkmFDFMCDRMkBgmSEoBYQT+nIJPS07jwxSL
	07n9El6WxqvSkyW79qZZwPgXhIQ0gCajU2IDGA1sANK42E8YX/M0SSRMlGUd5JR7E5QqOcfb
	wHSaEE8TfhnKTxQxybIMLpXjFJzyP4rRgoBszBzn061f8v5HWYiudiZZFPV50mZ9/eiZrFq/
	+LK18savPbj6ubVZnnFRn1JrP3Tsoanape2bGihSCcvVM5TlczMkUf56n6XSQal0JDP8l/YC
	e/dezJ5ZmqAsc8nbmMzGXB0QBZTlFSTmhh/sWW587bq1WvUz6FIOH2h5qmmg49RVesHAqW0p
	hc7vCR/OZVc54PoTizp8vYjIirAFxySxPYUtuKw+1PEz9ldDRVIRtmDqg2jzzdzlloiSTdaV
	tKuatx+ODr7YtG7NdGnuxsr47RG++4Agx6duTgxa+PaTMvXw6xZRAPujPnVsftZcM1IYblek
	ZgbFVdrbtpxKiOwSE/xuWVgIruRlfwANmZIHdAMAAA==
X-CMS-MailID: 20240903142905epcas5p291db855dce2f39166615e1fabe310cfc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240826171409epcas5p306ba210a9815e202556778a4c105b440
References: <CGME20240826171409epcas5p306ba210a9815e202556778a4c105b440@epcas5p3.samsung.com>
	<20240826170606.255718-1-joshi.k@samsung.com>

Hi Amir,


On 8/26/2024 10:36 PM, Kanchan Joshi wrote:
> Current write-hint infrastructure supports 6 temperature-based data life
> hints.
> The series extends the infrastructure with a new temperature-agnostic
> placement-type hint. New fcntl codes F_{SET/GET}_RW_HINT_EX allow to
> send the hint type/value on file. See patch #3 commit description for
> the details.
> 
> Overall this creates 128 placement hint values [*] that users can pass.
> Patch #5 adds the ability to map these new hint values to nvme-specific
> placement-identifiers.
> Patch #4 restricts SCSI to use only life hint values.
> Patch #1 and #2 are simple prep patches.
> 
> [*] While the user-interface can support more, this limit is due to the
> in-kernel plumbing consideration of the inode size. Pahole showed 32-bit
> hole in the inode, but the code had this comment too:
> 
> /* 32-bit hole reserved for expanding i_fsnotify_mask */
> 
> Not must, but it will be good to know if a byte (or two) can be used
> here.

Since having one extra byte will simplify things, I can't help but ask - 
do you still have the plans to use this space (in entirety) within inode?

