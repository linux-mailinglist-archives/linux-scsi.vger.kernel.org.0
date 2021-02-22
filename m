Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399B8320F4C
	for <lists+linux-scsi@lfdr.de>; Mon, 22 Feb 2021 03:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhBVCFM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Sun, 21 Feb 2021 21:05:12 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2906 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbhBVCFK (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 21 Feb 2021 21:05:10 -0500
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4DkQRk5Y3Hz5TwC;
        Mon, 22 Feb 2021 10:02:26 +0800 (CST)
Received: from dggemi762-chm.china.huawei.com (10.1.198.148) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Mon, 22 Feb 2021 10:04:24 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi762-chm.china.huawei.com (10.1.198.148) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Mon, 22 Feb 2021 10:04:24 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Mon, 22 Feb 2021 10:04:24 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Finn Thain <fthain@telegraphics.com.au>,
        tanxiaofei <tanxiaofei@huawei.com>
CC:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        "linux-m68k@vger.kernel.org" <linux-m68k@vger.kernel.org>
Subject: RE: [Linuxarm] Re: [PATCH for-next 00/32] spin lock usage
 optimization for SCSI drivers
Thread-Topic: [Linuxarm] Re: [PATCH for-next 00/32] spin lock usage
 optimization for SCSI drivers
Thread-Index: AQHXBcVsHfRcgE5/oku9/SZGNaGMW6pf/eSAgANvFTA=
Date:   Mon, 22 Feb 2021 02:04:24 +0000
Message-ID: <8c99b5c060eb4e5aa5b604666a8db516@hisilicon.com>
References: <1612697823-8073-1-git-send-email-tanxiaofei@huawei.com>
 <31cd807d-3d0-ed64-60d-fde32cb3833c@telegraphics.com.au>
 <e949a474a9284ac6951813bfc8b34945@hisilicon.com>
 <f0a3339d-b1db-6571-fa2f-6765e150eb9d@telegraphics.com.au>
 <7bc39d19-f4cc-8028-11e6-c0e45421a765@huawei.com>
 <588a87f-ae42-0b7-749e-c780ce5c3e4f@telegraphics.com.au>
In-Reply-To: <588a87f-ae42-0b7-749e-c780ce5c3e4f@telegraphics.com.au>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.172]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



> -----Original Message-----
> From: Finn Thain [mailto:fthain@telegraphics.com.au]
> Sent: Saturday, February 20, 2021 6:18 PM
> To: tanxiaofei <tanxiaofei@huawei.com>
> Cc: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>; jejb@linux.ibm.com;
> martin.petersen@oracle.com; linux-scsi@vger.kernel.org;
> linux-kernel@vger.kernel.org; linuxarm@openeuler.org;
> linux-m68k@vger.kernel.org
> Subject: Re: [Linuxarm] Re: [PATCH for-next 00/32] spin lock usage optimization
> for SCSI drivers
> 
> On Thu, 18 Feb 2021, Xiaofei Tan wrote:
> 
> > On 2021/2/9 13:06, Finn Thain wrote:
> > > On Tue, 9 Feb 2021, Song Bao Hua (Barry Song) wrote:
> > >
> > > > > On Sun, 7 Feb 2021, Xiaofei Tan wrote:
> > > > >
> > > > > > Replace spin_lock_irqsave with spin_lock in hard IRQ of SCSI
> > > > > > drivers. There are no function changes, but may speed up if
> > > > > > interrupt happen too often.
> > > > >
> > > > > This change doesn't necessarily work on platforms that support
> > > > > nested interrupts.
> > > > >
> > > > > Were you able to measure any benefit from this change on some
> > > > > other platform?
> > > >
> > > > I think the code disabling irq in hardIRQ is simply wrong.
> > > > Since this commit
> > > >
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/
> ?id=e58aa3d2d0cc
> > > > genirq: Run irq handlers with interrupts disabled
> > > >
> > > > interrupt handlers are definitely running in a irq-disabled context
> > > > unless irq handlers enable them explicitly in the handler to permit
> > > > other interrupts.
> > > >
> > >
> > > Repeating the same claim does not somehow make it true. If you put
> > > your claim to the test, you'll see that that interrupts are not
> > > disabled on m68k when interrupt handlers execute.
> > >
> > > The Interrupt Priority Level (IPL) can prevent any given irq handler
> > > from being re-entered, but an irq with a higher priority level may be
> > > handled during execution of a lower priority irq handler.
> > >
> > > sonic_interrupt() uses an irq lock within an interrupt handler to
> > > avoid issues relating to this. This kind of locking may be needed in
> > > the drivers you are trying to patch. Or it might not. Apparently,
> > > no-one has looked.
> > >
> >
> > According to your discussion with Barry, it seems that m68k is a little
> > different from other architecture, and this kind of modification of this
> > patch cannot be applied to m68k. So, could help to point out which
> > driver belong to m68k architecture in this patch set of SCSI? I can
> > remove them.
> >
> 
> If you would claim that "there are no function changes" in your patches
> (as above) then the onus is on you to support that claim.
> 
> I assume that there are some platforms on which your assumptions hold.
> 
> With regard to drivers for those platforms, you might want to explain why
> your patches should be applied there, given that the existing code is
> superior for being more portable.

I don't think it has nothing to do with portability. In the case of
sonic_interrupt() you pointed out, on m68k, there is a high-priority
interrupt can preempt low-priority interrupt, they will result in
access the same critical data. M68K's spin_lock_irqsave() can disable
the high-priority interrupt and avoid the race condition of the data.
So the case should not be touched. I'd like to accept the reality
and leave sonic_interrupt() alone.

However, even on m68k, spin_lock_irqsave is not needed for other
ordinary cases.
If there is no other irq handler coming to access same critical data,
it is pointless to hold a redundant irqsave lock in irqhandler even
on m68k.

In thread contexts, we always need that if an irqhandler can preempt
those threads and access the same data. In hardirq, if there is an
high-priority which can jump out on m68k to access the critical data
which needs protection, we use the spin_lock_irqsave as you have used
in sonic_interrupt(). Otherwise, the irqsave is also redundant for
m68k.

> 
> > BTW, sonic_interrupt() is from net driver natsemi, right?  It would be
> > appreciative if only discuss SCSI drivers in this patch set. thanks.
> >
> 
> The 'net' subsystem does have some different requirements than the 'scsi'
> subsystem. But I don't see how that's relevant. Perhaps you can explain
> it. Thanks.

The difference is that if there are two co-existing interrupts which can
access the same critical data on m68k. I don't think net and scsi matter.
What really matters is the specific driver.

Thanks
Barry

