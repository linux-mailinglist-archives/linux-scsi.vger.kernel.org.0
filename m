Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 214137037A
	for <lists+linux-scsi@lfdr.de>; Mon, 22 Jul 2019 17:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfGVPSx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 22 Jul 2019 11:18:53 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34297 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfGVPSx (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 22 Jul 2019 11:18:53 -0400
Received: by mail-qk1-f196.google.com with SMTP id t8so28889570qkt.1
        for <linux-scsi@vger.kernel.org>; Mon, 22 Jul 2019 08:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gpiccoli-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JmSc9WFYzR3PHi025ZIgVCOWEAkk9unY2S5ILJ0IpK4=;
        b=PzH5wNnYnxuvcsZi/2rEASC0MXxkNHoL5L1TbvOxMl2Z6GfPgS1izZJzVufUdM9J19
         WMej1ZfszLUkyFhJX+XLEr8zE5cwfnnwl/s0OHBzy2IBAyKGcPoJy/tP9YA7/R+IikF8
         aPz/x1QE/pFbRciN2xWu3nHFhxfCWVLgSLnQd7pPwvPacK8xW4yd2+VrfvkSXXEDB5cb
         aKZmcknbH/JEhNXwb1SbDCv69r1Thqg+qlBnvSIDNO5c9XELTBr5nvl+uMONz85y0JmS
         aGtssuSjiGjBx/XEv1whDpjIii/fY1XUSA/wyQrb/JdWAw7I6pllHZMoIeJ+wW40LeU1
         7aag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JmSc9WFYzR3PHi025ZIgVCOWEAkk9unY2S5ILJ0IpK4=;
        b=PkJ5NKNcBDivWMcoLCQLqxT5Ofh4cGQH2s1+CVUHJInA0qWiuNx9JF3ddtZMwLCVmR
         w/hHYt5Y8f5+NRLrIDsspsAQVkgHnUK8Wsf4vdyU174JnsBLtx1+XIuU1FCFDd6MxDGj
         5r6pMp5bJmM1m3d2dAPVgsZwZ7viIqlk8Zg3j27G8uiF1XTBBzGGW4n/dOmPBtth+eaD
         ukv5b/6dWOJ0pj+U73bNPcLDv/Xx/YzE1W5FAZcdGF2Ul8LUKn7grJv4JWjMJPSgmxfV
         OZklSdDyfnxvFuCkZoGB4GPDqLVxPRg8MzyTs+jZdWBmyFfN9Ldt/JH699KKK8Z8ysXj
         W+Vw==
X-Gm-Message-State: APjAAAWLZhIIXYVohtRIEN+z2gP57TqNnli19N2FX1drFSHOf1tvnP4c
        w84Xk6AEsc3zczQzs9yBonMtzJqx7X896UzL8/8=
X-Google-Smtp-Source: APXvYqy7Z5uxbr/Zjzdm8AwwtNEXlP36Y73Wn0Oz8TA4Z7/DVbyOAJLWmvuqwWCwc3DA7IJoO6hgpCIlAoFS+5BYOBE=
X-Received: by 2002:a05:620a:247:: with SMTP id q7mr49835114qkn.265.1563808732696;
 Mon, 22 Jul 2019 08:18:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190722092038.17659-1-hch@lst.de>
In-Reply-To: <20190722092038.17659-1-hch@lst.de>
From:   "Guilherme G. Piccoli" <kernel@gpiccoli.net>
Date:   Mon, 22 Jul 2019 12:18:16 -0300
Message-ID: <CALJn8nNbj1zu0HyvLiLe-6oC6D5vb1tzT41otL52rZ+MaF9QvQ@mail.gmail.com>
Subject: Re: [PATCH] scsi: fix the dma_max_mapping_size call
To:     Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, Bart Van Assche <bvanassche@acm.org>,
        tom.leiming@gmail.com, dexuan.linux@gmail.com,
        Damien.LeMoal@wdc.com,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Christoph, thanks for the fix. I just faced a crash[0] booting
v5.3-rc1 in a KVM guest, and your patch fixed it.
Feel free to add:

Tested-by: Guilherme G. Piccoli <gpiccoli@canonical.com>

Cheers,


Guilherme

[0]
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] SMP PTI
Workqueue: events_unbound async_run_entry_fn
RIP: 0010:dma_direct_max_mapping_size+0x26/0x80
RSP: 0018:ffffa316c0843bc0 EFLAGS: 00010202
RAX: 0000000000000000 RBX: ffff8d98a88eb810 RCX: 0000000000000000
RDX: ffff8d98a86cab80 RSI: 000000000000007e RDI: ffff8d98a88eb810
RBP: ffffa316c0843bd0 R08: ffff8d98af9b00e0 R09: ffff8d98ad8072c0
R10: ffffa316c0843a70 R11: 00000000000311a0 R12: 0000000000000000
R13: ffff8d98a88eb810 R14: 000000000000ffff R15: ffff8d98a3dbd000
FS:  0000000000000000(0000) GS:ffff8d98af980000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000429d08000 CR4: 00000000000006e0
Call Trace:
 dma_max_mapping_size+0x39/0x50
 __scsi_init_queue+0x7f/0x140
 scsi_mq_alloc_queue+0x38/0x60
 scsi_alloc_sdev+0x1da/0x2b0
 scsi_probe_and_add_lun+0x471/0xe60
 ? __pm_runtime_resume+0x5b/0x80
 __scsi_scan_target+0xfc/0x610
 ? __switch_to_asm+0x40/0x70
 ? __switch_to_asm+0x34/0x70
 ? __switch_to_asm+0x40/0x70
 scsi_scan_channel+0x66/0xa0
 scsi_scan_host_selected+0xf3/0x160
 do_scsi_scan_host+0x93/0xa0
 do_scan_async+0x1c/0x190
[...]
