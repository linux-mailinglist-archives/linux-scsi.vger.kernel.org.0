Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 827F12029EA
	for <lists+linux-scsi@lfdr.de>; Sun, 21 Jun 2020 11:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbgFUJ7D (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 21 Jun 2020 05:59:03 -0400
Received: from hosting.gsystem.sk ([212.5.213.30]:45494 "EHLO
        hosting.gsystem.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729628AbgFUJ7D (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 21 Jun 2020 05:59:03 -0400
X-Greylist: delayed 524 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Jun 2020 05:59:03 EDT
Received: from [192.168.0.2] (188-167-68-178.dynamic.chello.sk [188.167.68.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 351B47A026D;
        Sun, 21 Jun 2020 11:50:18 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Arun Easi <aeasi@marvell.com>
Subject: Re: NULL pointer dereference in qla24xx_abort_command
Date:   Sun, 21 Jun 2020 11:50:14 +0200
User-Agent: KMail/1.9.10
Cc:     linux-scsi@vger.kernel.org
References: <202003251906.40982.linux@zary.sk> <alpine.LRH.2.21.9999.2003251431090.28238@irv1user01.caveonetworks.com> <202005151521.50091.linux@zary.sk>
In-Reply-To: <202005151521.50091.linux@zary.sk>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202006211150.15194.linux@zary.sk>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Friday 15 May 2020 15:21:49 Ondrej Zary wrote:
> On Wednesday 25 March 2020, Arun Easi wrote:
> > On Wed, 25 Mar 2020, 11:06am, Ondrej Zary wrote:
> > > Hi Himanshu,
> > > could you please look into this bug?
> > > https://urldefense.proofpoint.com/v2/url?u=https-3A__www.spinics.net_list
> > >s_linux-2Dscsi_msg138637.html&d=DwICAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=XB49zT5-
> > >k3oWvfMuBJCeRK5Sk6o3bkGM6ewB3QuTOME&m=ezZ2dt9wVYnM-c6jJKx9bPQ0-7vbSf5HQ0bG
> > >qri_iNE&s=wriOIaA9pVuKVrGPMvcZstNdYbzcZgFVw_OKiM0idIg&e=
> > >
> ...
> > 
> > Ondrej,
> >
> > Could you pick up the latest upstream kernel and retry your test (even if
> > it takes longer to reproduce)? That way we do not need to spend time on an
> > issue that may have already been fixed.
> >
> > Regards,
> > -Arun
> 
> It crashed again yesterday (4.19.118-2), almost two months since the last 
> crash :(
> 
> Now I installed 5.5.17-1~bpo10+1 from Debian backports and am going to wait 
> another 2 months...

It survived with this kernel (occured after 27 days uptime):
[2420004.525111] qla2xxx [0000:0e:00.0]-801c:4: Abort command issued nexus=4:0:0 -- 2003.
[2420004.541110] qla2xxx [0000:0e:00.0]-8009:4: DEVICE RESET ISSUED nexus=4:0:0 cmd=00000000ce4d99b9.
[2420004.546654] qla2xxx [0000:0e:00.0]-800e:4: DEVICE RESET SUCCEEDED nexus:4:0:0 cmd=00000000ce4d99b9.
[2420004.546797] sd 4:0:0:0: Power-on or device reset occurred
[2420004.568334] sd 3:0:0:0: Power-on or device reset occurred

-- 
Ondrej Zary
