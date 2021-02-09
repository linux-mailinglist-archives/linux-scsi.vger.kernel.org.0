Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE663147E2
	for <lists+linux-scsi@lfdr.de>; Tue,  9 Feb 2021 06:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhBIFG5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 9 Feb 2021 00:06:57 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:50758 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbhBIFGu (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 9 Feb 2021 00:06:50 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id C47A52ADCA;
        Tue,  9 Feb 2021 00:06:02 -0500 (EST)
Date:   Tue, 9 Feb 2021 16:06:06 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
cc:     tanxiaofei <tanxiaofei@huawei.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        linux-m68k@vger.kernel.org
Subject: RE: [Linuxarm]  Re: [PATCH for-next 00/32] spin lock usage optimization
 for SCSI drivers
In-Reply-To: <e949a474a9284ac6951813bfc8b34945@hisilicon.com>
Message-ID: <f0a3339d-b1db-6571-fa2f-6765e150eb9d@telegraphics.com.au>
References: <1612697823-8073-1-git-send-email-tanxiaofei@huawei.com> <31cd807d-3d0-ed64-60d-fde32cb3833c@telegraphics.com.au> <e949a474a9284ac6951813bfc8b34945@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, 9 Feb 2021, Song Bao Hua (Barry Song) wrote:

> > -----Original Message-----
> > From: Finn Thain [mailto:fthain@telegraphics.com.au]
> > Sent: Monday, February 8, 2021 8:57 PM
> > To: tanxiaofei <tanxiaofei@huawei.com>
> > Cc: jejb@linux.ibm.com; martin.petersen@oracle.com;
> > linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linuxarm@openeuler.org
> > Subject: [Linuxarm] Re: [PATCH for-next 00/32] spin lock usage optimization
> > for SCSI drivers
> > 
> > On Sun, 7 Feb 2021, Xiaofei Tan wrote:
> > 
> > > Replace spin_lock_irqsave with spin_lock in hard IRQ of SCSI drivers.
> > > There are no function changes, but may speed up if interrupt happen too
> > > often.
> > 
> > This change doesn't necessarily work on platforms that support nested
> > interrupts.
> > 
> > Were you able to measure any benefit from this change on some other
> > platform?
> 
> I think the code disabling irq in hardIRQ is simply wrong.
> Since this commit
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e58aa3d2d0cc
> genirq: Run irq handlers with interrupts disabled
> 
> interrupt handlers are definitely running in a irq-disabled context
> unless irq handlers enable them explicitly in the handler to permit
> other interrupts.
> 

Repeating the same claim does not somehow make it true. If you put your 
claim to the test, you'll see that that interrupts are not disabled on 
m68k when interrupt handlers execute.

The Interrupt Priority Level (IPL) can prevent any given irq handler from 
being re-entered, but an irq with a higher priority level may be handled 
during execution of a lower priority irq handler.

sonic_interrupt() uses an irq lock within an interrupt handler to avoid 
issues relating to this. This kind of locking may be needed in the drivers 
you are trying to patch. Or it might not. Apparently, no-one has looked.
