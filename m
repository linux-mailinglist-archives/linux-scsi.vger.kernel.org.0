Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E352605A7
	for <lists+linux-scsi@lfdr.de>; Mon,  7 Sep 2020 22:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbgIGUYq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 7 Sep 2020 16:24:46 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51228 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729189AbgIGUYp (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 7 Sep 2020 16:24:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 8008E8EE0F8;
        Mon,  7 Sep 2020 13:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1599510284;
        bh=F/PS9ltnHUh6+sJAcOQuchTo/9AZ5wWeFQY7oDWBw6I=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=dC+T6JFIOGUuWeYnpvKx6jPz4kYW9DL+VsnVan0m+2c/QRAPjyCCL+9+LOyIgyqkY
         1CNi6qnmoDxTSwsbP1B11vfWyM+/AefugOhzX5oKwvVF1Ns3PFt+nMWf+kNcV3tdVa
         3TA0OHSoBC9xMusx0Y73bmINMHcgrB5Q+go3Pq8s=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7_g6SsBGDByx; Mon,  7 Sep 2020 13:24:44 -0700 (PDT)
Received: from [153.66.254.174] (c-73-35-198-56.hsd1.wa.comcast.net [73.35.198.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 07D488EE0E9;
        Mon,  7 Sep 2020 13:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1599510284;
        bh=F/PS9ltnHUh6+sJAcOQuchTo/9AZ5wWeFQY7oDWBw6I=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=dC+T6JFIOGUuWeYnpvKx6jPz4kYW9DL+VsnVan0m+2c/QRAPjyCCL+9+LOyIgyqkY
         1CNi6qnmoDxTSwsbP1B11vfWyM+/AefugOhzX5oKwvVF1Ns3PFt+nMWf+kNcV3tdVa
         3TA0OHSoBC9xMusx0Y73bmINMHcgrB5Q+go3Pq8s=
Message-ID: <1599510282.4232.54.camel@HansenPartnership.com>
Subject: Re: [PATCH] scsi: take module reference during async scan
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Tomas Henzl <thenzl@redhat.com>, linux-scsi@vger.kernel.org
Date:   Mon, 07 Sep 2020 13:24:42 -0700
In-Reply-To: <f3095df4-4a34-1e0c-04e7-8983ffeac973@redhat.com>
References: <20200907154745.20145-1-thenzl@redhat.com>
         <1599500808.4232.19.camel@HansenPartnership.com>
         <f3095df4-4a34-1e0c-04e7-8983ffeac973@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, 2020-09-07 at 22:09 +0200, Tomas Henzl wrote:
> On 9/7/20 7:46 PM, James Bottomley wrote:
> > On Mon, 2020-09-07 at 17:47 +0200, Tomas Henzl wrote:
> > > During an async scan the driver shost->hostt structures are used,
> > > that may cause issues when the driver is removed at that time.
> > > As protection take the module reference.
> > 
> > Can I just ask what issues?  Today, our module model is that
> > scsi_device_get() bumps the module refcount and therefore makes the
> > module ineligible to be removed.  scsi_host_get() doesn't do this
> > because the way the host model is supposed to be coded, we can call
> > remove at any time but the module won't get freed until the last
> > put of the host.  I can see we have a potential problem with
> > scsi_forget_host() racing with the async scan thread ... is that
> > what you see? What's supposed to happen is that scsi_device_get()
> > starts failing as soon as the module begins it's exit routine, so
> > if a scan is in progress, it can't add any new devices ... in
> > theory this means that the list is stable for scsi_forget_host(),
> > so knowing how that assumption is breaking would be useful.
> 
> I think that the problem is that async scan uses callbacks to the
> module and when the module is being removed during scan it is not
> protected.

As I said above: the module shouldn't be freed until the scans are
completed or aborted ... I don't think we have a use after free
problem.  What you show below seems to be a deadlock:

> modprobe mpt3sas && rmmod  mpt3sas
> 
> [  370.031614] INFO: task rmmod:3120 blocked for more than 120
> seconds.
> [  370.037967]       Not tainted 4.18.0-193.el8.x86_64 #1
> [  370.043105] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [  370.050931] rmmod           D    0  3120   2460 0x00004080
> [  370.056414] Call Trace:
> [  370.058889]  ? __schedule+0x24f/0x650
> [  370.062554]  schedule+0x2f/0xa0
> [  370.065738]  async_synchronize_cookie_domain+0xad/0x140
> [  370.070983]  ? finish_wait+0x80/0x80
> [  370.074580]  __x64_sys_delete_module+0x166/0x280
> [  370.079198]  do_syscall_64+0x5b/0x1a0
> [  370.082876]  entry_SYSCALL_64_after_hwframe+0x65/0xca
> [  370.087946] RIP: 0033:0x7f6de460a7db
> [  370.091534] Code: Bad RIP value.
> [  370.094777] RSP: 002b:00007ffe9971e798 EFLAGS: 00000206 ORIG_RAX:
> 00000000000000b0
> [  370.102341] RAX: ffffffffffffffda RBX: 00005592370d37b0 RCX:
> 00007f6de460a7db
> [  370.109481] RDX: 000000000000000a RSI: 0000000000000800 RDI:
> 00005592370d3818
> [  370.116606] RBP: 0000000000000000 R08: 00007ffe9971d711 R09:
> 0000000000000000
> [  370.123748] R10: 00007f6de467c8e0 R11: 0000000000000206 R12:
> 00007ffe9971e9c0
> [  370.130888] R13: 00007ffe99720333 R14: 00005592370d32a0 R15:
> 00005592370d37b0

This seems to be showing something different: I think the
async_synchronize_full() in delete_module is where we're stuck. That
seems to indicate something has just stopped inside the async scan code
... likely due to something reacting badly to scsi_device_get()
failing.

James

