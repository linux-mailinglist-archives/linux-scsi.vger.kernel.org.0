Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7B5255208
	for <lists+linux-scsi@lfdr.de>; Fri, 28 Aug 2020 02:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgH1A5h (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 27 Aug 2020 20:57:37 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:54266 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH1A5h (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 27 Aug 2020 20:57:37 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 403962ACE8;
        Thu, 27 Aug 2020 20:57:34 -0400 (EDT)
Date:   Fri, 28 Aug 2020 10:57:46 +1000 (AEST)
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
In-Reply-To: <5682daf68b94be288c05f859942ce06deec2b022.camel@perches.com>
Message-ID: <alpine.LNX.2.23.453.2008281052580.8@nippy.intranet>
References: <8570915f668159f93ba2eb845a3bbc05f8ee3a99.camel@perches.com>         <EF673A30-F88D-4E4E-8A2B-E942153830AC@physik.fu-berlin.de>         <b88538f92386f41b938c502ae2daec5800a85dcf.camel@perches.com>         <alpine.LNX.2.23.453.2008280859300.10@nippy.intranet>
 <5682daf68b94be288c05f859942ce06deec2b022.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, 27 Aug 2020, Joe Perches wrote:

> 
> checkpatch already does this.
> 

Did you use checkpatch to generate this patch?
