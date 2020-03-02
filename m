Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B12FF1766E1
	for <lists+linux-scsi@lfdr.de>; Mon,  2 Mar 2020 23:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgCBW0M (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 2 Mar 2020 17:26:12 -0500
Received: from hosting.gsystem.sk ([212.5.213.30]:33146 "EHLO
        hosting.gsystem.sk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgCBW0M (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 2 Mar 2020 17:26:12 -0500
Received: from [192.168.0.2] (188-167-68-178.dynamic.chello.sk [188.167.68.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 1FA2B7A02F6;
        Mon,  2 Mar 2020 23:26:11 +0100 (CET)
From:   Ondrej Zary <linux@zary.sk>
To:     Bart Van Assche <bvanassche@acm.org>
Subject: Re: NULL pointer dereference in qla24xx_abort_command, kernel 4.19.98 (Debian)
Date:   Mon, 2 Mar 2020 23:26:08 +0100
User-Agent: KMail/1.9.10
Cc:     qla2xxx-upstream@qlogic.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Hernandez <michael.hernandez@cavium.com>,
        Sawan Chandak <sawan.chandak@cavium.com>,
        Himanshu Madhani <himanshu.madhani@cavium.com>
References: <202002231929.01662.linux@zary.sk> <1fbad673-1b8c-0813-c60e-a4f56330a972@acm.org> <202002271809.07717.linux@zary.sk>
In-Reply-To: <202002271809.07717.linux@zary.sk>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202003022326.08698.linux@zary.sk>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thursday 27 February 2020 18:09:07 Ondrej Zary wrote:
> 
> On Tuesday 25 February 2020 04:41:48 Bart Van Assche wrote:
> > On 2020-02-24 00:20, Ondrej Zary wrote:
> > > Looks like it's in some inlined function.
> > > 
> > > /usr/src/linux-source-4.19# gdb /lib/modules/4.19.0-8-amd64/kernel/drivers/scsi/qla2xxx/qla2xxx.ko
> > > GNU gdb (Debian 8.2.1-2+b3) 8.2.1
> > > ...
> > > Reading symbols from /lib/modules/4.19.0-8-amd64/kernel/drivers/scsi/qla2xxx/qla2xxx.ko...Reading symbols 
> > > from /usr/lib/debug//lib/modules/4.19.0-8-amd64/kernel/drivers/scsi/qla2xxx/qla2xxx.ko...done.
> > > done.
> > > 
> > > (gdb) list *(qla24xx_async_abort_cmd+0x1b)
> > > 0xf88b is in qla24xx_async_abort_cmd (./arch/x86/include/asm/atomic.h:97).
> > > 92       *
> > > 93       * Atomically increments @v by 1.
> > > 94       */
> > > 95      static __always_inline void arch_atomic_inc(atomic_t *v)
> > > 96      {
> > > 97              asm volatile(LOCK_PREFIX "incl %0"
> > > 98                           : "+m" (v->counter) :: "memory");
> > > 99      }
> > > 100     #define arch_atomic_inc arch_atomic_inc
> > >
> > > [ ... ]
> > > 
> > > (gdb) disassemble qla24xx_async_abort_cmd
> > > Dump of assembler code for function qla24xx_async_abort_cmd:
> > >    0x000000000000f870 <+0>:     callq  0xf875 <qla24xx_async_abort_cmd+5>
> > >    0x000000000000f875 <+5>:     push   %r15
> > >    0x000000000000f877 <+7>:     push   %r14
> > >    0x000000000000f879 <+9>:     push   %r13
> > >    0x000000000000f87b <+11>:    push   %r12
> > >    0x000000000000f87d <+13>:    push   %rbp
> > >    0x000000000000f87e <+14>:    push   %rbx
> > >    0x000000000000f87f <+15>:    mov    0x28(%rdi),%r13
> > >    0x000000000000f883 <+19>:    mov    0x20(%rdi),%r15
> > >    0x000000000000f887 <+23>:    mov    0x48(%rdi),%r14
> > >    0x000000000000f88b <+27>:    lock incl 0x4(%r14)
> > >    0x000000000000f890 <+32>:    mfence
> > 
> > Thanks, this is very helpful. I think the above means that the crash is
> > triggered by the following code:
> > 
> > 	sp = qla2xxx_get_qpair_sp(cmd_sp->qpair, cmd_sp->fcport,
> > 		GFP_KERNEL);
> > 
> > From the start of qla2xxx_get_qpair_sp():
> > 
> > 	QLA_QPAIR_MARK_BUSY(qpair, bail);
> > 
> > From qla_def.h:
> > 
> > #define QLA_QPAIR_MARK_BUSY(__qpair, __bail) do {	\
> > 	atomic_inc(&__qpair->ref_count);		\
> > 	mb();						\
> > 	if (__qpair->delete_in_progress) {		\
> > 		atomic_dec(&__qpair->ref_count);	\
> > 		__bail = 1;				\
> > 	} else {					\
> > 	       __bail = 0;				\
> > 	}						\
> > } while (0)
> > 
> > One of the changes between kernel version v4.9.210 and v4.19.98 is the
> > following: "qla2xxx: Add multiple queue pair functionality". I think the
> >  above information means that the cmd_sp->qpair pointer is NULL. I will
> > let QLogic recommend a solution.
> 
> Thank you very much for the analysis.
> Unfortunately, QLogic does not seem to care...

Let's try to CC the people at Cavium that signed-off the commit.

-- 
Ondrej Zary
