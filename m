Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA4A342D74
	for <lists+linux-scsi@lfdr.de>; Wed, 12 Jun 2019 19:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409600AbfFLR2N (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 12 Jun 2019 13:28:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40660 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407682AbfFLR2M (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 12 Jun 2019 13:28:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 98FFE3004425
        for <linux-scsi@vger.kernel.org>; Wed, 12 Jun 2019 17:28:12 +0000 (UTC)
Received: from localhost.localdomain (ovpn-124-193.rdu2.redhat.com [10.10.124.193])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2974564036
        for <linux-scsi@vger.kernel.org>; Wed, 12 Jun 2019 17:28:12 +0000 (UTC)
Date:   Wed, 12 Jun 2019 10:28:09 -0700
From:   Chris Leech <cleech@redhat.com>
To:     linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/2] qedi: Check targetname while finding boot target
 information
Message-ID: <20190612172809.GB16360@localhost.localdomain>
Mail-Followup-To: Chris Leech <cleech@redhat.com>,
        linux-scsi@vger.kernel.org
References: <20190612080542.17272-1-njavali@marvell.com>
 <20190612080542.17272-2-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612080542.17272-2-njavali@marvell.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Wed, 12 Jun 2019 17:28:12 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Jun 12, 2019 at 01:05:41AM -0700, Nilesh Javali wrote:
> The kernel panic was observed during iSCSI discovery via offload
> with below call trace,
> 
> [ 2115.646901] BUG: unable to handle kernel NULL pointer dereference at (null)
> [ 2115.646909] IP: [<ffffffffacf7f0cc>] strncmp+0xc/0x60
> [ 2115.646927] PGD 0
> [ 2115.646932] Oops: 0000 [#1] SMP
> [ 2115.647107] CPU: 24 PID: 264 Comm: kworker/24:1 Kdump: loaded Tainted: G
>                OE  ------------   3.10.0-957.el7.x86_64 #1
> [ 2115.647133] Workqueue: slowpath-13:00. qed_slowpath_task [qed]
> [ 2115.647135] task: ffff8d66af80b0c0 ti: ffff8d66afb80000 task.ti: ffff8d66afb80000
> [ 2115.647136] RIP: 0010:[<ffffffffacf7f0cc>]  [<ffffffffacf7f0cc>] strncmp+0xc/0x60
> [ 2115.647141] RSP: 0018:ffff8d66afb83c68  EFLAGS: 00010206
> [ 2115.647143] RAX: 0000000000000001 RBX: 0000000000000007 RCX: 000000000000000a
> [ 2115.647144] RDX: 0000000000000100 RSI: 0000000000000000 RDI: ffff8d632b3ba040
> [ 2115.647145] RBP: ffff8d66afb83c68 R08: 0000000000000000 R09: 000000000000ffff
> [ 2115.647147] R10: 0000000000000007 R11: 0000000000000800 R12: ffff8d66a30007a0
> [ 2115.647148] R13: ffff8d66747a3c10 R14: ffff8d632b3ba000 R15: ffff8d66747a32f8
> [ 2115.647149] FS:  0000000000000000(0000) GS:ffff8d66aff00000(0000) knlGS:0000000000000000
> [ 2115.647151] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2115.647152] CR2: 0000000000000000 CR3: 0000000509610000 CR4: 00000000007607e0
> [ 2115.647153] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 2115.647154] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 2115.647155] PKRU: 00000000
> [ 2115.647157] Call Trace:
> [ 2115.647165]  [<ffffffffc0634cc5>] qedi_get_protocol_tlv_data+0x2c5/0x510 [qedi]
> [ 2115.647184]  [<ffffffffc05968f5>] ? qed_mfw_process_tlv_req+0x245/0xbe0 [qed]
> [ 2115.647195]  [<ffffffffc05496cb>] qed_mfw_fill_tlv_data+0x4b/0xb0 [qed]
> [ 2115.647206]  [<ffffffffc0596911>] qed_mfw_process_tlv_req+0x261/0xbe0 [qed]
> [ 2115.647215]  [<ffffffffacce0e8e>] ? dequeue_task_fair+0x41e/0x660
> [ 2115.647221]  [<ffffffffacc2a59e>] ? __switch_to+0xce/0x580
> [ 2115.647230]  [<ffffffffc0546013>] qed_slowpath_task+0xa3/0x160 [qed]
> [ 2115.647278] RIP  [<ffffffffacf7f0cc>] strncmp+0xc/0x60
> 
> Fix kernel panic by validating the session targetname before providing
> TLV data and confirming the presence of boot targets.
> 
> Signed-off-by: Nilesh Javali <njavali@marvell.com>

Reviewed-by: Chris Leech <cleech@redhat.com>

> ---
>  drivers/scsi/qedi/qedi_main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/scsi/qedi/qedi_main.c b/drivers/scsi/qedi/qedi_main.c
> index 8814bfc..f210a3e 100644
> --- a/drivers/scsi/qedi/qedi_main.c
> +++ b/drivers/scsi/qedi/qedi_main.c
> @@ -987,6 +987,9 @@ static int qedi_find_boot_info(struct qedi_ctx *qedi,
>  		if (!iscsi_is_session_online(cls_sess))
>  			continue;
>  
> +		if (!sess->targetname)
> +			continue;
> +
>  		if (pri_ctrl_flags) {
>  			if (!strcmp(pri_tgt->iscsi_name, sess->targetname) &&
>  			    !strcmp(pri_tgt->ip_addr, ep_ip_addr)) {
> -- 
> 1.8.3.1
> 
