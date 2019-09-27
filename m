Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41566C0E8D
	for <lists+linux-scsi@lfdr.de>; Sat, 28 Sep 2019 01:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbfI0Xlm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 27 Sep 2019 19:41:42 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:43646 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728527AbfI0Xll (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 27 Sep 2019 19:41:41 -0400
X-Greylist: delayed 466 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Sep 2019 19:41:40 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 6F79829F44;
        Fri, 27 Sep 2019 19:33:51 -0400 (EDT)
Date:   Sat, 28 Sep 2019 09:33:59 +1000 (AEST)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Alan Stern <stern@rowland.harvard.edu>
cc:     Douglas Gilbert <dgilbert@interlog.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Justin Piszcz <jpiszcz@lucidpixels.com>
Subject: Re: [PATCH 0/2] Fix SCSI & USB Storage CHECK CONDITION handling
In-Reply-To: <Pine.LNX.4.44L0.1909271004470.1698-100000@iolanthe.rowland.org>
Message-ID: <alpine.LNX.2.21.1909280906530.76@nippy.intranet>
References: <Pine.LNX.4.44L0.1909271004470.1698-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

[snipped selective measurements of word usage]

On Fri, 27 Sep 2019, Alan Stern wrote:

> 
> So I guess this was never defined precisely.
> 

The O.E.D. defines these terms:

	residual
	a. [...]
	n. 1. a quantity remaining after other things have been subtracted 
	      or allowed for. [...]
	   2. [...]
	   3. [...]

and

	residue
	n. a small amount of something that remains after the main part 
	   has gone or been taken or used.


So, writing "residue" could be misleading as the connotation is that the 
remaining part is the lesser part.

I think that's probably why the term "residual" gets used in finance (and 
in SCSI transfers).

-- 
