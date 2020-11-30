Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777792C878B
	for <lists+linux-scsi@lfdr.de>; Mon, 30 Nov 2020 16:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727905AbgK3PRR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 30 Nov 2020 10:17:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:58412 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727893AbgK3PRQ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 30 Nov 2020 10:17:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9A8AAAEDE;
        Mon, 30 Nov 2020 15:16:34 +0000 (UTC)
Date:   Mon, 30 Nov 2020 16:16:34 +0100
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
Subject: Re: [PATCH 09/14] scsi: mpt3sas: Remove in_interrupt().
Message-ID: <20201130151634.seijadk2nvxnobt6@beryllium.lan>
References: <20201126132952.2287996-1-bigeasy@linutronix.de>
 <20201126132952.2287996-10-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126132952.2287996-10-bigeasy@linutronix.de>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Nov 26, 2020 at 02:29:47PM +0100, Sebastian Andrzej Siewior wrote:
> From: "Ahmed S. Darwish" <a.darwish@linutronix.de>
> 
> _scsih_fw_event_cleanup_queue() waits for all outstanding firmware
> events wokrqueue handlers to finish. If in_interrupt() is true, it
> cancels itself and return early.
> 
> That in_interrupt() check is ill-defined and does not provide what the
> name suggests: it does not cover all states in which it is safe to block
> and call functions like cancel_work_sync().
> 
> That check is also not needed: _scsih_fw_event_cleanup_queue() is always
> invoked from process context. Below is an analysis of its callers:
> 
>   - scsih_remove(), bound to PCI ->remove(), process context
> 
>   - scsih_shutdown(), bound to PCI ->shutdown(), process context
> 
>   - mpt3sas_scsih_clear_outstanding_scsi_tm_commands(), called by
>       => _base_clear_outstanding_commands(), called by
>         =>_base_fault_reset_work(), workqueue
>         => mpt3sas_base_hard_reset_handler(), locks mutex
> 
> Remove the in_interrupt() check. Change _scsih_fw_event_cleanup_queue()
> specification to a purely process-context function and mark it with
> "Context: task, can sleep".
> 
> Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Sathya Prakash <sathya.prakash@broadcom.com>
> Cc: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
> Cc: Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
> Cc: <MPT-FusionLinux.pdl@broadcom.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
