Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB2E720A899
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jun 2020 01:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407680AbgFYXKo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 25 Jun 2020 19:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404432AbgFYXKn (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 25 Jun 2020 19:10:43 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6E9C08C5C1;
        Thu, 25 Jun 2020 16:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=+df13v+AvbHRI+0q7hSJ2DFnkMwltHAJzFloMEs+1FI=; b=ff8pJTwLFHOxuLoV2FtHmAGtv
        Sf2fkGNbigss0aeXBRx5PHD2LTkdASaEarZAWFoIeihoyJBSMTFesT54Ou2UxgDHgiZYR2Msj3zrY
        ojzZ67bwf2raqyhWhUTPHLkNBpnSed0G9GhM3v6Wau2DvWi40YIyIhnF4uAj7UfidxsHYJCVY06L6
        uoaGwU+Bxsx3LES1EVTRKP+vJ2TELzzNmv4T8ESLYYG8AziYCI9Wd+ofeiGK/Ram/bm8SZysWWTwL
        i1iqkYoCRzcrDrzyNlTkyr5NgidasoYt8UvgdAnaKe3I/kIuKMBjlTWTzZ5bRku9X/6cFDxcwnbUz
        hdZwTBbPg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59774)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1job0x-0004mx-8F; Fri, 26 Jun 2020 00:10:39 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1job0n-0003Sj-6B; Fri, 26 Jun 2020 00:10:29 +0100
Date:   Fri, 26 Jun 2020 00:10:29 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-arm-kernel@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] scsi: cumana_2: Fix different dev_id between
 'request_irq()' and 'free_irq()'
Message-ID: <20200625231029.GN1551@shell.armlinux.org.uk>
References: <20200530073555.577414-1-christophe.jaillet@wanadoo.fr>
 <20200625204730.943520-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625204730.943520-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Jun 25, 2020 at 10:47:30PM +0200, Christophe JAILLET wrote:
> The dev_id used in 'request_irq()' and 'free_irq()' should match.
> Use 'info' in both cases.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

Thanks Christophe.

> ---
> V2: update free_irq instead of request_irq in order not to obviously break
>     code
> ---
>  drivers/scsi/arm/cumana_2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/arm/cumana_2.c b/drivers/scsi/arm/cumana_2.c
> index 65691c21f133..29294f0ef8a9 100644
> --- a/drivers/scsi/arm/cumana_2.c
> +++ b/drivers/scsi/arm/cumana_2.c
> @@ -450,7 +450,7 @@ static int cumanascsi2_probe(struct expansion_card *ec,
>  
>  	if (info->info.scsi.dma != NO_DMA)
>  		free_dma(info->info.scsi.dma);
> -	free_irq(ec->irq, host);
> +	free_irq(ec->irq, info);
>  
>   out_release:
>  	fas216_release(host);
> -- 
> 2.25.1
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
