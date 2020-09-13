Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A19267E52
	for <lists+linux-scsi@lfdr.de>; Sun, 13 Sep 2020 09:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725912AbgIMHFu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 13 Sep 2020 03:05:50 -0400
Received: from mail.skyhub.de ([5.9.137.197]:50984 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgIMHFs (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 13 Sep 2020 03:05:48 -0400
Received: from zn.tnic (p200300ec2f290b00e66ccb465e44ee87.dip0.t-ipconnect.de [IPv6:2003:ec:2f29:b00:e66c:cb46:5e44:ee87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 077D61EC0501;
        Sun, 13 Sep 2020 09:05:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599980747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OVqZD4pYNkNpPSFfc89n1FpB/shJKN07pzLTpRSGN5g=;
        b=UDW10Ceyb9oKNXUT78oo33TQ8tyLcHif79Kzh2Rpemr3ycQQ08fQcnTQy2dPyS1kEAcCdG
        4ZO9mKmH81ZM9gn8e+a2tEmy3Vvy2+lm6u3Hr5yI7LdV7oKqpDMNVri3W/a0ji8PnzkjdH
        Mlyl7kl24jHu89MUg2IiswN+BydNFWc=
Date:   Sun, 13 Sep 2020 09:05:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH 1/2] scsi: Fix handling of host-aware ZBC disks
Message-ID: <20200913070546.GB5213@zn.tnic>
References: <20200913060304.294898-1-damien.lemoal@wdc.com>
 <20200913060304.294898-2-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200913060304.294898-2-damien.lemoal@wdc.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sun, Sep 13, 2020 at 03:03:03PM +0900, Damien Le Moal wrote:
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index 95018e650f2d..7f0371185a45 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -2968,22 +2968,36 @@ static void sd_read_block_characteristics(struct scsi_disk *sdkp)
>  	} else {
>  		sdkp->zoned = (buffer[8] >> 4) & 3;
>  		if (sdkp->zoned == 1 && !disk_has_partitions(sdkp->disk)) {
> +#ifdef CONFIG_BLK_DEV_ZONED

You could make that

		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))

and get rid of the ugly ifdeffery.

Just a nitpick anyway.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
