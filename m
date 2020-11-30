Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4101F2C88FA
	for <lists+linux-scsi@lfdr.de>; Mon, 30 Nov 2020 17:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbgK3QHz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 30 Nov 2020 11:07:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:42188 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728551AbgK3QHy (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 30 Nov 2020 11:07:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 11AD3AC8F;
        Mon, 30 Nov 2020 16:07:13 +0000 (UTC)
Date:   Mon, 30 Nov 2020 17:07:11 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-scsi@vger.kernel.org,
        Finn Thain <fthain@telegraphics.com.au>,
        GR-QLogic-Storage-Upstream@marvell.com,
        Hannes Reinecke <hare@kernel.org>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        John Garry <john.garry@huawei.com>,
        linux-m68k@lists.linux-m68k.org,
        Manish Rangankar <mrangankar@marvell.com>,
        Michael Schmitz <schmitzmic@gmail.com>,
        MPT-FusionLinux.pdl@broadcom.com,
        Nilesh Javali <njavali@marvell.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Vikram Auradkar <auradkar@google.com>,
        Xiang Chen <chenxiang66@hisilicon.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S . Darwish" <a.darwish@linutronix.de>
Subject: Re: [PATCH 14/14] scsi: message: fusion: Remove in_interrupt() usage
 in mptsas_cleanup_fw_event_q().
Message-ID: <20201130160711.64tn56vt5qshsaim@beryllium.lan>
References: <20201126132952.2287996-1-bigeasy@linutronix.de>
 <20201126132952.2287996-15-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126132952.2287996-15-bigeasy@linutronix.de>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Nov 26, 2020 at 02:29:52PM +0100, Sebastian Andrzej Siewior wrote:
> mptsas_cleanup_fw_event_q() uses in_interrupt() to determine if it is
> safe to cancel a worker item.
> 
> Aside of that in_interrupt() is deprecated as it does not provide what the
> name suggests. It covers more than hard/soft interrupt servicing context
> and is semantically ill defined.
> 
> Looking closer there are a few problems with the current construct:
> - It could be invoked from an interrupt handler / non-blocking context
>   because cancel_delayed_work() has no such restriction. Also,
>   mptsas_free_fw_event() has no such restriction.
> 
> - The list is accessed unlocked. It may dequeue a valid work-item but at
>   the time of invoking cancel_delayed_work() the memory may be released
>   or reused because the worker has already run.
> 
> mptsas_cleanup_fw_event_q() is invoked via mptsas_shutdown() which is
> always invoked from preemtible context on device shutdown.
> It is also invoked via mptsas_ioc_reset(, MPT_IOC_POST_RESET) which is a
> MptResetHandlers callback. The only caller here are
> mpt_SoftResetHandler(), mpt_HardResetHandler() and
> mpt_Soft_Hard_ResetHandler().

mpt_diag_reset(), iterates over all reset handler...

> All these functions have a `sleepFlag'

...and also uses the same flag.

> argument and each caller uses caller uses `CAN_SLEEP' here and according
> to current documentation:
> |      @sleepFlag: Indicates if sleep or schedule must be called
> 
> So it is safe to sleep.
> 
> Add mptsas_hotplug_event::users member. Initialize it to one by default
> so mptsas_free_fw_event() will free the memory.
> mptsas_cleanup_fw_event_q() will increment its value for items it
> dequeues and then it may keep a pointer after dropping the lock.
> Invoke cancel_delayed_work_sync() to cancel the work item and wait if
> the worker is currently busy. Free the memory afterwards since it owns
> the last reference to it.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Sathya Prakash <sathya.prakash@broadcom.com>
> Cc: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
> Cc: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
> Cc: MPT-FusionLinux.pdl@broadcom.com

Reviewed-by: Daniel Wagner <dwagner@suse.de>
