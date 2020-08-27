Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B49DE255188
	for <lists+linux-scsi@lfdr.de>; Fri, 28 Aug 2020 01:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgH0XVO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 27 Aug 2020 19:21:14 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:52844 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbgH0XVO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 27 Aug 2020 19:21:14 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 18C9129D96;
        Thu, 27 Aug 2020 19:21:10 -0400 (EDT)
Date:   Fri, 28 Aug 2020 09:21:22 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Joe Perches <joe@perches.com>
cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Denis Efremov <efremov@linux.com>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH 17/19] z2ram: reindent
In-Reply-To: <b88538f92386f41b938c502ae2daec5800a85dcf.camel@perches.com>
Message-ID: <alpine.LNX.2.23.453.2008280859300.10@nippy.intranet>
References: <8570915f668159f93ba2eb845a3bbc05f8ee3a99.camel@perches.com>         <EF673A30-F88D-4E4E-8A2B-E942153830AC@physik.fu-berlin.de> <b88538f92386f41b938c502ae2daec5800a85dcf.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


> @@ -109,34 +111,28 @@ static void get_z2ram(void)
...
>  	}
> -
> -	return;
>  }
>  

It would be good to have a semantic patch for that change.

>  
> -		if (z2ram_map[z2ram_size] == 0) {
> +		if (z2ram_map[z2ram_size] == 0)
>  			break;
> -		}
>  

And that one.

Reason being, a semantic patch only has to be debugged once, whereas 
manual churn has to be done correctly over and over again.

TBH, this kind of transformation can happen when code is displayed.
It doesn't have to involve git at all. Otherwise, why have 5 billion 
transistors? You'd be better off with an Amiga.
