Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2EC12A3533
	for <lists+linux-scsi@lfdr.de>; Mon,  2 Nov 2020 21:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgKBUfZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 2 Nov 2020 15:35:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:32910 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgKBUfZ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 2 Nov 2020 15:35:25 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604349323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zR+88Sdp7BuaikCJ0w896+tv8a4qTUALQu7lJ2As4us=;
        b=e3fsqo3g+7Oe2+twrXYwyyLDc3b+43hSXvxIHLgMY5KLv9hFlXPtsIHijKdPcyIzK6v/5+
        YR2Da4OUK++66AgoVwAsQshMk/k7USPrH5gKZ29Jft4zTtTsZIMbQPSBc7W+i2OorNVA22
        H5zhWww6NvMwRYHO5WOGuJGy89mYLQEQ3n/1Ji91k35dqJOVJcCf6ywzc0uQzqDKhGyr0b
        i1gZ/AmMHjiFDdN8nR6vkfp92/LEvsUpb13MKGchc0ehbqCJnMB1FsIlSvNg8gg/bCgm7A
        wgdYRS+wgpwXm8n8xupWhKOP0sU5f1rUgkMEj0ZfRfmX4qGz0w0I30ujtZm2jA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604349323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zR+88Sdp7BuaikCJ0w896+tv8a4qTUALQu7lJ2As4us=;
        b=Wq3FCG3ipI+69Li4OYL4pTjWSRiTSQd7WfysGJrZgYfP5Ug/2tkD9gmnaCYN7QMHIw7Cv9
        Eo9QH8MHTDxlgYBQ==
To:     John Garry <john.garry@huawei.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     linuxarm@huawei.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
Subject: Re: [PATCH v2 1/3] genirq/affinity: Add irq_update_affinity_desc()
In-Reply-To: <ce13a36e-967c-c7ec-fd34-d53262313a5d@huawei.com>
References: <1603888387-52499-1-git-send-email-john.garry@huawei.com> <1603888387-52499-2-git-send-email-john.garry@huawei.com> <87eelifbx6.fsf@nanos.tec.linutronix.de> <ce13a36e-967c-c7ec-fd34-d53262313a5d@huawei.com>
Date:   Mon, 02 Nov 2020 21:35:23 +0100
Message-ID: <87blgf8pkk.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Nov 02 2020 at 17:32, John Garry wrote:
> On 28/10/2020 18:22, Thomas Gleixner wrote:
>> But all of this can't work on x86 due to the way how vector allocation
>> works. Let me think about that.
>
> Is the problem that we reserve per-cpu managed interrupt space when 
> allocated irq vectors on x86, and so later changing managed vs 
> non-managed setting for irqs messes up this accounting somehow?

Correct. I have a halfways working solution for that, but I need to fix
some other thing first.

Thanks,

        tglx
