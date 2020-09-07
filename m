Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B12EE260565
	for <lists+linux-scsi@lfdr.de>; Mon,  7 Sep 2020 22:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbgIGUJe (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 7 Sep 2020 16:09:34 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54130 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728879AbgIGUJd (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 7 Sep 2020 16:09:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599509370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U92wTgfb7ujMAMgyGUmBIOFduv/fE1sLDpeelLKtrVQ=;
        b=XszdPtDmMlypeXn1b+jK0nemqIyd4SgCvAT3PFq7zd5/dG/zfix4QkvSIggcIkSUyRq/Pf
        rgbx4KhiYvsM3X094Ah2libhob6CFYo0RmmPaGFC1SWX2kpblRHRvqdUZFjYHoX1d0s93b
        jsD/gCWV+5GAw6EqMuthlTVZV4qDuWA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-fjWJHNl0N9Ov255GyB_UAw-1; Mon, 07 Sep 2020 16:09:29 -0400
X-MC-Unique: fjWJHNl0N9Ov255GyB_UAw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32C3E1074646;
        Mon,  7 Sep 2020 20:09:28 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.205])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A42A9805F0;
        Mon,  7 Sep 2020 20:09:27 +0000 (UTC)
Subject: Re: [PATCH] scsi: take module reference during async scan
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org
References: <20200907154745.20145-1-thenzl@redhat.com>
 <1599500808.4232.19.camel@HansenPartnership.com>
From:   Tomas Henzl <thenzl@redhat.com>
Message-ID: <f3095df4-4a34-1e0c-04e7-8983ffeac973@redhat.com>
Date:   Mon, 7 Sep 2020 22:09:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1599500808.4232.19.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 9/7/20 7:46 PM, James Bottomley wrote:
> On Mon, 2020-09-07 at 17:47 +0200, Tomas Henzl wrote:
>> During an async scan the driver shost->hostt structures are used,
>> that may cause issues when the driver is removed at that time.
>> As protection take the module reference.
> 
> Can I just ask what issues?  Today, our module model is that
> scsi_device_get() bumps the module refcount and therefore makes the
> module ineligible to be removed.  scsi_host_get() doesn't do this
> because the way the host model is supposed to be coded, we can call
> remove at any time but the module won't get freed until the last put of
> the host.  I can see we have a potential problem with
> scsi_forget_host() racing with the async scan thread ... is that what
> you see? What's supposed to happen is that scsi_device_get() starts
> failing as soon as the module begins it's exit routine, so if a scan is
> in progress, it can't add any new devices ... in theory this means that
> the list is stable for scsi_forget_host(), so knowing how that
> assumption is breaking would be useful.

I think that the problem is that async scan uses callbacks to the module
and when the module is being removed during scan it is not protected.

modprobe mpt3sas && rmmod  mpt3sas

[  370.031614] INFO: task rmmod:3120 blocked for more than 120 seconds.
[  370.037967]       Not tainted 4.18.0-193.el8.x86_64 #1
[  370.043105] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  370.050931] rmmod           D    0  3120   2460 0x00004080
[  370.056414] Call Trace:
[  370.058889]  ? __schedule+0x24f/0x650
[  370.062554]  schedule+0x2f/0xa0
[  370.065738]  async_synchronize_cookie_domain+0xad/0x140
[  370.070983]  ? finish_wait+0x80/0x80
[  370.074580]  __x64_sys_delete_module+0x166/0x280
[  370.079198]  do_syscall_64+0x5b/0x1a0
[  370.082876]  entry_SYSCALL_64_after_hwframe+0x65/0xca
[  370.087946] RIP: 0033:0x7f6de460a7db
[  370.091534] Code: Bad RIP value.
[  370.094777] RSP: 002b:00007ffe9971e798 EFLAGS: 00000206 ORIG_RAX:
00000000000000b0
[  370.102341] RAX: ffffffffffffffda RBX: 00005592370d37b0 RCX:
00007f6de460a7db
[  370.109481] RDX: 000000000000000a RSI: 0000000000000800 RDI:
00005592370d3818
[  370.116606] RBP: 0000000000000000 R08: 00007ffe9971d711 R09:
0000000000000000
[  370.123748] R10: 00007f6de467c8e0 R11: 0000000000000206 R12:
00007ffe9971e9c0
[  370.130888] R13: 00007ffe99720333 R14: 00005592370d32a0 R15:
00005592370d37b0


> 
> James
> 

