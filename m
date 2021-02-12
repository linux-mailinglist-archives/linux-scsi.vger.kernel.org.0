Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD38F319745
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Feb 2021 01:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhBLAEj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-scsi@lfdr.de>); Thu, 11 Feb 2021 19:04:39 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:3018 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhBLAEh (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 11 Feb 2021 19:04:37 -0500
Received: from DGGEMM402-HUB.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4DcDG32f6fzR6mN;
        Fri, 12 Feb 2021 08:02:35 +0800 (CST)
Received: from dggemi711-chm.china.huawei.com (10.3.20.110) by
 DGGEMM402-HUB.china.huawei.com (10.3.20.210) with Microsoft SMTP Server (TLS)
 id 14.3.498.0; Fri, 12 Feb 2021 08:03:52 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi711-chm.china.huawei.com (10.3.20.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Fri, 12 Feb 2021 08:03:52 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.2106.006;
 Fri, 12 Feb 2021 08:03:52 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Finn Thain <fthain@telegraphics.com.au>
CC:     tanxiaofei <tanxiaofei@huawei.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>,
        "linux-m68k@vger.kernel.org" <linux-m68k@vger.kernel.org>
Subject: RE: Re: [PATCH for-next 00/32] spin lock usage optimization for SCSI
 drivers
Thread-Topic: Re: [PATCH for-next 00/32] spin lock usage optimization for SCSI
 drivers
Thread-Index: AdcAYpckfegWyL1RTeK8yhWOZkcCaAAK/seAABDAZzA=
Date:   Fri, 12 Feb 2021 00:03:52 +0000
Message-ID: <0d104f0e26134b1ea9c530be895e65d1@hisilicon.com>
References: <417fa728c3ff4418ac87e0d409b5a084@hisilicon.com>
 <c7fdb63e-e84-c685-35f4-6b6f663cd867@telegraphics.com.au>
In-Reply-To: <c7fdb63e-e84-c685-35f4-6b6f663cd867@telegraphics.com.au>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.201.23]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



> -----Original Message-----
> From: Finn Thain [mailto:fthain@telegraphics.com.au]
> Sent: Friday, February 12, 2021 12:57 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: tanxiaofei <tanxiaofei@huawei.com>; jejb@linux.ibm.com;
> martin.petersen@oracle.com; linux-scsi@vger.kernel.org;
> linux-kernel@vger.kernel.org; linuxarm@openeuler.org;
> linux-m68k@vger.kernel.org
> Subject: RE: Re: [PATCH for-next 00/32] spin lock usage optimization for SCSI
> drivers
> 
> 
> On Thu, 11 Feb 2021, Song Bao Hua (Barry Song) wrote:
> 
> >
> > Actually in m68k, I also saw its IRQ entry disabled interrupts by
> > ' move	#0x2700,%sr		/* disable intrs */'
> >
> > arch/m68k/include/asm/entry.h:
> >
> > .macro SAVE_ALL_SYS
> > 	move	#0x2700,%sr		/* disable intrs */
> > 	btst	#5,%sp@(2)		/* from user? */
> > 	bnes	6f			/* no, skip */
> > 	movel	%sp,sw_usp		/* save user sp */
> > ...
> >
> > .macro SAVE_ALL_INT
> > 	SAVE_ALL_SYS
> > 	moveq	#-1,%d0			/* not system call entry */
> > 	movel	%d0,%sp@(PT_OFF_ORIG_D0)
> > .endm
> >
> > arch/m68k/kernel/entry.S:
> >
> > /* This is the main interrupt handler for autovector interrupts */
> >
> > ENTRY(auto_inthandler)
> > 	SAVE_ALL_INT
> > 	GET_CURRENT(%d0)
> > 					|  put exception # in d0
> > 	bfextu	%sp@(PT_OFF_FORMATVEC){#4,#10},%d0
> > 	subw	#VEC_SPUR,%d0
> >
> > 	movel	%sp,%sp@-
> > 	movel	%d0,%sp@-		|  put vector # on stack
> > auto_irqhandler_fixup = . + 2
> > 	jsr	do_IRQ			|  process the IRQ
> > 	addql	#8,%sp			|  pop parameters off stack
> > 	jra	ret_from_exception
> >
> > So my question is that " move	#0x2700,%sr" is actually disabling
> > all interrupts? And is m68k actually running irq handlers
> > with interrupts disabled?
> >
> 
> When sonic_interrupt() executes, the IPL is 2 or 3 (since either IRQ may
> be involved). That is, SR & 0x700 is 0x200 or 0x300. The level 3 interrupt
> may interrupt execution of the level 2 handler so an irq lock is used to
> avoid re-entrance.
> 
> This patch,
> 
> diff --git a/drivers/net/ethernet/natsemi/sonic.c
> b/drivers/net/ethernet/natsemi/sonic.c
> index d17d1b4f2585..041354647bad 100644
> --- a/drivers/net/ethernet/natsemi/sonic.c
> +++ b/drivers/net/ethernet/natsemi/sonic.c
> @@ -355,6 +355,8 @@ static irqreturn_t sonic_interrupt(int irq, void *dev_id)
>          */
>         spin_lock_irqsave(&lp->lock, flags);
> 
> +       printk_once(KERN_INFO "%s: %08lx\n", __func__, flags);
> +
>         status = SONIC_READ(SONIC_ISR) & SONIC_IMR_DEFAULT;
>         if (!status) {
>                 spin_unlock_irqrestore(&lp->lock, flags);
> 
> produces this output,
> 
> [    3.800000] sonic_interrupt: 00002300

I actually hope you can directly read the register rather than reading
a flag which might be a software one not from register.

> 
> I ran that code in QEMU, but experience shows that Apple hardware works
> exactly the same. Please do confirm this for yourself, if you still think
> the code and comments in sonic_interrupt are wrong.
> 
> > Best Regards
> > Barry
> >

Thanks
Barry

