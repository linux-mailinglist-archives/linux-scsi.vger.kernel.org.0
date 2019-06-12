Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 936D442986
	for <lists+linux-scsi@lfdr.de>; Wed, 12 Jun 2019 16:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408764AbfFLOil (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 12 Jun 2019 10:38:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:46414 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392115AbfFLOil (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 12 Jun 2019 10:38:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 49E31AD36;
        Wed, 12 Jun 2019 14:38:39 +0000 (UTC)
Subject: Re: [PATCH 1/2] qedi: Check targetname while finding boot target
 information
To:     Nilesh Javali <njavali@marvell.com>, martin.petersen@oracle.com,
        cleech@redhat.com
Cc:     linux-scsi@vger.kernel.org, QLogic-Storage-Upstream@cavium.com
References: <20190612080542.17272-1-njavali@marvell.com>
 <20190612080542.17272-2-njavali@marvell.com>
From:   Lee Duncan <lduncan@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=lduncan@suse.com; prefer-encrypt=mutual; keydata=
 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
 a7PzlXQ=
Organization: SUSE
Message-ID: <092b2efb-618b-6aba-e3b2-6f9ded18c662@suse.com>
Date:   Wed, 12 Jun 2019 10:38:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190612080542.17272-2-njavali@marvell.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/12/19 4:05 AM, Nilesh Javali wrote:
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
> 

Reviewed-by: Lee Duncan <lduncan@suse.com>
