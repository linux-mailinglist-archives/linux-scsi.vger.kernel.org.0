Return-Path: <linux-scsi+bounces-720-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1230D80974D
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Dec 2023 01:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFF771F20F71
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Dec 2023 00:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331D2A3D
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Dec 2023 00:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SWpHk2xF"
X-Original-To: linux-scsi@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BCDD5B;
	Thu,  7 Dec 2023 16:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Mt3Imikle95I2T0moDd1ayBWvk34SQ07JgzqC/mp+9E=; b=SWpHk2xFkLlIJxCT0fxLVd5bYg
	5FE7UImoYtlwlR/1XUB/VweP+8Pv+6Oqju00FN+DTrUqiHManr3vamB14YtigJXUXgVAeA2lusfor
	u/UiVU5UiSs+VxHUyIXI7jDAiYuG44vl74gIRZuzzkKRk+u0xJY16793JjZ7grfW31yRjN601maJA
	LajsngDsk/1+UO+S6+Lb5We6wr3H70cqi/hb/+7fRPpGAjdDBBa6iVibIbVvTm2RF7SF82vCZjZjf
	yDBPpa93XyV1VPYFPz/ooF4xQ0+fR29i/vrpP8i7kM4DSixLPoRaMHzRNpR4T6+qg1oxZdwG055yl
	c9r94uKA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rBOlC-00EKHi-1u;
	Fri, 08 Dec 2023 00:30:31 +0000
Message-ID: <d228bf5d-24e3-4fd1-a2eb-f54395697907@infradead.org>
Date: Thu, 7 Dec 2023 16:30:27 -0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mpi3mr: fix printk() format strings
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>,
 Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
 Kashyap Desai <kashyap.desai@broadcom.com>,
 Sumit Saxena <sumit.saxena@broadcom.com>,
 Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
 "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Chandrakanth patil <chandrakanth.patil@broadcom.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Ranjan Kumar <ranjan.kumar@broadcom.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231207142813.935717-1-arnd@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231207142813.935717-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/7/23 06:28, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly introduced error messages get multiple format strings wrong: size_t must
> be printed using the %z modifier rather than %l and dma_addr_t must be printed
> by reference using the special %pad pointer type:
> 
> drivers/scsi/mpi3mr/mpi3mr_app.c: In function 'mpi3mr_build_nvme_prp':
> include/linux/kern_levels.h:5:25: error: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'dma_addr_t' {aka 'unsigned int'} [-Werror=format=]
> drivers/scsi/mpi3mr/mpi3mr_app.c:949:25: note: in expansion of macro 'dprint_bsg_err'
>   949 |                         dprint_bsg_err(mrioc,
>       |                         ^~~~~~~~~~~~~~
> include/linux/kern_levels.h:5:25: error: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
> drivers/scsi/mpi3mr/mpi3mr_app.c:1112:41: note: in expansion of macro 'dprint_bsg_err'
>  1112 |                                         dprint_bsg_err(mrioc,
>       |                                         ^~~~~~~~~~~~~~
> 
> Fixes: 9536af615dc9 ("scsi: mpi3mr: Support for preallocation of SGL BSG data buffers part-3")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

LGTM. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

> ---
>  drivers/scsi/mpi3mr/mpi3mr_app.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/mpi3mr/mpi3mr_app.c b/drivers/scsi/mpi3mr/mpi3mr_app.c
> index 4b93b7440da6..0380996b5ad2 100644
> --- a/drivers/scsi/mpi3mr/mpi3mr_app.c
> +++ b/drivers/scsi/mpi3mr/mpi3mr_app.c
> @@ -947,8 +947,8 @@ static int mpi3mr_build_nvme_prp(struct mpi3mr_ioc *mrioc,
>  		dma_addr = drv_buf_iter->dma_desc[count].dma_addr;
>  		if (dma_addr & page_mask) {
>  			dprint_bsg_err(mrioc,
> -				       "%s:dma_addr 0x%llx is not aligned with page size 0x%x\n",
> -				       __func__,  dma_addr, dev_pgsz);
> +				       "%s:dma_addr %pad is not aligned with page size 0x%x\n",
> +				       __func__,  &dma_addr, dev_pgsz);
>  			return -1;
>  		}
>  	}
> @@ -1110,7 +1110,7 @@ static int mpi3mr_build_nvme_prp(struct mpi3mr_ioc *mrioc,
>  				if ((++desc_count) >=
>  				   drv_buf_iter->num_dma_desc) {
>  					dprint_bsg_err(mrioc,
> -						       "%s: Invalid len %ld while building PRP\n",
> +						       "%s: Invalid len %zd while building PRP\n",
>  						       __func__, length);
>  					goto err_out;
>  				}

-- 
~Randy

