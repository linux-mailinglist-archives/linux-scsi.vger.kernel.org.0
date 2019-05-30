Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A056530362
	for <lists+linux-scsi@lfdr.de>; Thu, 30 May 2019 22:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfE3UlW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 30 May 2019 16:41:22 -0400
Received: from hosting.gsystem.sk ([212.5.213.30]:44920 "EHLO
        hosting.gsystem.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3UlW (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 30 May 2019 16:41:22 -0400
Received: from [192.168.0.2] (188-167-68-178.dynamic.chello.sk [188.167.68.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id EE59D7A01F5;
        Thu, 30 May 2019 22:41:19 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Subject: Re: [Patch v2] wd719x: pass GFP_ATOMIC instead of GFP_KERNEL linux-kernel@vger.kernel.org
Date:   Thu, 30 May 2019 22:41:15 +0200
User-Agent: KMail/1.9.10
Cc:     David Rientjes <rientjes@google.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
References: <20190529175851.GA10760@hari-Inspiron-1545> <alpine.DEB.2.21.1905291412360.242480@chino.kir.corp.google.com> <20190530181044.GA7760@hari-Inspiron-1545>
In-Reply-To: <20190530181044.GA7760@hari-Inspiron-1545>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="ansi_x3.4-1968"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201905302241.16233.linux@zary.sk>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thursday 30 May 2019 20:10:44 Hariprasad Kelam wrote:
> On Wed, May 29, 2019 at 02:13:18PM -0700, David Rientjes wrote:
> > On Wed, 29 May 2019, Hariprasad Kelam wrote:
> > 
> > > dont acquire lock before calling wd719x_chip_init.
> > > 
> > > Issue identified by coccicheck
> > > 
> > > Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> > > -----
> > > changes in v1: Replace GFP_KERNEL with GFP_ATOMIC.
> > > changes in v2: Call wd719x_chip_init  without lock as suggested
> > > 		in review
> > 
> > Why was host_lock taken here initially?  I assume it's to protect some 
> > race in init that leads to an undefined state.
> 
> wd719x_chip_init is getting called from wd719x_host_reset
> and wd719x_board_found.
> 
> In wd719x_board_found case its not acquiring any lock.
> In wd719x_host_reset it is called under spin_lock.
> 
> Acquiring spin_lock in wd719x_host_reset is there from initial commit
> so its better we wont remove this lock.

Looks like I haven't tested it properly before. Host reset is broken - sg_reset -N -H /dev/sdX will oops:

wd719x 0000:02:01.0: host reset requested
------------[ cut here ]------------
kernel BUG at fs/buffer.c:1218!
invalid opcode: 0000 [#1] SMP
CPU: 0 PID: 1913 Comm: sg_reset Not tainted 5.1.0+ #323
Hardware name:  /848P-ICH5, BIOS 6.00 PG 02/03/2005
EIP: check_irqs_on+0xb/0xf
...

That's because of request_firmware called under the spin lock, as Christoph pointed out.
Patch v2 is also wrong - wd719x_finish_cmd must be called under lock.

I'm currently testing a proper fix (disable chip and flush SCBs under lock, then initialize chip without lock). It works mostly but I can crash it easily by doing a device reset under load (e.g. dd from a SCSI drive) and then doing a host reset - NULL pointer dereference in list_del.

> I think we Patch v1 is  correct fix(pass GFP_ATOMIC instead of GPF_KERNEL )
> 
> 


-- 
Ondrej Zary
