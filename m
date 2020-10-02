Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CEA280CA1
	for <lists+linux-scsi@lfdr.de>; Fri,  2 Oct 2020 06:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgJBETN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 2 Oct 2020 00:19:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:48538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbgJBETM (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 2 Oct 2020 00:19:12 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 589E920796;
        Fri,  2 Oct 2020 04:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601612352;
        bh=VNJapsQTTyEmiuSQJg6sqrJGIXXBuxZSpS+OAzNcVm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K89zENm0GcOS4C1dUyty0oeWptjfCLrtXMUt+15Jp1eDyjKnqtAMoQu3Rm8qKyOqV
         FSWS8i5Et4I+SWKlOybASR3Rop8GkaQxP8PR/YO7B3rQk3++v0QjWYixya02T8PFzj
         P1hTfSpOYbwF+jnynnoWJGD6S1QevfuVs1ZlktJw=
Date:   Thu, 1 Oct 2020 21:19:10 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Pujin Shi <shipujin.t@gmail.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Satya Tangirala <satyat@google.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hankinsea@gmail.com
Subject: Re: [PATCH 1/2] scsi: ufs: Use memset to initialize variable in
 ufshcd_crypto_keyslot_program
Message-ID: <20201002041910.GB78003@sol.localdomain>
References: <20201002040518.1224-1-shipujin.t@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002040518.1224-1-shipujin.t@gmail.com>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, Oct 02, 2020 at 12:05:17PM +0800, Pujin Shi wrote:
> Clang warns:
> 
> drivers/scsi/ufs/ufshcd-crypto.c:62:8: warning: missing braces around initializer [-Wmissing-braces]
>   union ufs_crypto_cfg_entry cfg = { 0 };
>         ^
> 

Which version of clang?  I don't see the warning with clang 10.0.1
(or with gcc 10.2.0).

> Signed-off-by: Pujin Shi <shipujin.t@gmail.com>
> ---
>  drivers/scsi/ufs/ufshcd-crypto.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/ufs/ufshcd-crypto.c b/drivers/scsi/ufs/ufshcd-crypto.c
> index d2edbd960ebf..8fca2a40c517 100644
> --- a/drivers/scsi/ufs/ufshcd-crypto.c
> +++ b/drivers/scsi/ufs/ufshcd-crypto.c
> @@ -59,9 +59,11 @@ static int ufshcd_crypto_keyslot_program(struct blk_keyslot_manager *ksm,
>  	u8 data_unit_mask = key->crypto_cfg.data_unit_size / 512;
>  	int i;
>  	int cap_idx = -1;
> -	union ufs_crypto_cfg_entry cfg = { 0 };
> +	union ufs_crypto_cfg_entry cfg;
>  	int err;
>  
> +	memset(&cfg, 0, sizeof(cfg));
> +

How about an empty initializer?

	union ufs_crypto_cfg_entry cfg = {};

Same comments on your other patch.

- Eric
