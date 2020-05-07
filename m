Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75AA01C8C95
	for <lists+linux-scsi@lfdr.de>; Thu,  7 May 2020 15:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgEGNkC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 7 May 2020 09:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725879AbgEGNkC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 7 May 2020 09:40:02 -0400
X-Greylist: delayed 301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 May 2020 06:40:02 PDT
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E22CC05BD43
        for <linux-scsi@vger.kernel.org>; Thu,  7 May 2020 06:40:02 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:6572:4a1f:d283:9ae8])
        by michel.telenet-ops.be with bizsmtp
        id bpay2200G3ZRV0X06pay9M; Thu, 07 May 2020 15:34:59 +0200
Received: from geert (helo=localhost)
        by ramsan with local-esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jWgfy-0002Cj-Ev; Thu, 07 May 2020 15:34:58 +0200
Date:   Thu, 7 May 2020 15:34:58 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Damien Le Moal <damien.lemoal@wdc.com>
cc:     linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>
Subject: Re: [PATCH] scsi_debug: Fix compilation error on 32bits arch
In-Reply-To: <20200507023526.221574-1-damien.lemoal@wdc.com>
Message-ID: <alpine.DEB.2.21.2005071533400.8219@ramsan.of.borg>
References: <20200507023526.221574-1-damien.lemoal@wdc.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

 	Hi Damien,


On Thu, 7 May 2020, Damien Le Moal wrote:
> Allowing a non-power-of-2 zone size forces the use of direct division
> operations of 64bits sector values to obtain a zone number or number of
> zones. Doing so without using do_div() leads to compilation errors on
> 32bits architecture.

As reported by noreply@ellerman.id.au for m68k-allmodconfig:

     ERROR: modpost: "__udivdi3" [drivers/scsi/scsi_debug.ko] undefined!

> Devices with a zone size that is not a power of 2 do not exist today so
> allowing their emulation is of limited interest, as the sd driver will
> not support them anyway. So to fix this compilation error, instead of
> using do_div() for sector values divisions, simply disallow zone size
> values that are not a power of 2 value, allowing to use bitshift for
> divisions in all cases.
>
> Fixes: 98e0a689868c ("scsi: scsi_debug: Add zone_size_mb module parameter")
> Fixes: f0d1cf9378bd ("scsi: scsi_debug: Add ZBC zone commands")
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

And your patch fixes that, so

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
