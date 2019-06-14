Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AECC946C4F
	for <lists+linux-scsi@lfdr.de>; Sat, 15 Jun 2019 00:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbfFNWYm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 14 Jun 2019 18:24:42 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39040 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbfFNWYm (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 14 Jun 2019 18:24:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id 196so2283685pgc.6
        for <linux-scsi@vger.kernel.org>; Fri, 14 Jun 2019 15:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h9liDC+rPAaeiJr15SU+98A3t7JSUEkDa+dy+76xMzY=;
        b=XfcFpfRAPebtTA4rH79YOqlxh7gKrQwE8sANPeKy98C8bCXn9nAzmT0veVvIgwEKRT
         UbwrV1pumn3lnO0YpPmmEe8d3gsCD38W6FZ9QXhaiD/o3eVbeIwiHYjhkVsO76bTp+ic
         EMoOxNhmCJMJPcgSi/5JW/gMUiXgmwk4UQjTTrNMT7t2fkyahiXSdbqkNsIOu84Iowbk
         VsPT6+jrwX0BxSmbhL73Wt2Zs5Cy2pcbzLGx/AN4ds+ANB90cqvMwrn42HqCuFx7BEZ3
         mLl00G6S5qZHpB6w9Wjsxu+9AR9EJFpEKjnXh6bQozHFUADM3u74JrH5vLHENO8gOZf8
         Y56g==
X-Gm-Message-State: APjAAAXyK5I9vmTsKrQOMT3IZQ7p7YvqnBVDlgeum+uhUoHmrY5omc5b
        8dG1pX/ZzlqvRxLh/pNs6EjwKcIU
X-Google-Smtp-Source: APXvYqx8JjwvLL5qbtFUNMieD5h8B/Xa3ZzNj4Y6Hv95up35L/XB79uaK9L0PCoF2xvrojLpSpQHfQ==
X-Received: by 2002:a63:5726:: with SMTP id l38mr39398497pgb.344.1560551080632;
        Fri, 14 Jun 2019 15:24:40 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id c129sm4905520pfa.106.2019.06.14.15.24.39
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 15:24:39 -0700 (PDT)
Subject: Re: [PATCH 3/3] qla2xxx: Fix NVME cmd and LS cmd timeout race
 condition
To:     Himanshu Madhani <hmadhani@marvell.com>,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org
References: <20190614221020.19173-1-hmadhani@marvell.com>
 <20190614221020.19173-4-hmadhani@marvell.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <dc2bad07-0ba0-06e7-b52a-57f774bc3ff2@acm.org>
Date:   Fri, 14 Jun 2019 15:24:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614221020.19173-4-hmadhani@marvell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/14/19 3:10 PM, Himanshu Madhani wrote:
> From: Quinn Tran <qutran@marvell.com>
> 
> This patch uses kref to protect access between fcp_abort
> path and nvme command and LS command completion path.
> Stack trace below shows the abort path is accessing stale
> memory (nvme_private->sp).
> 
> When command kref reaches 0, nvme_private & srb resource will
> be disconnected from each other.  Any subsequence nvme abort
> request will not be able to reference the original srb.
> 
> [ 5631.003998] BUG: unable to handle kernel paging request at 00000010000005d8
> [ 5631.004016] IP: [<ffffffffc087df92>] qla_nvme_abort_work+0x22/0x100 [qla2xxx]
> [ 5631.004086] Workqueue: events qla_nvme_abort_work [qla2xxx]
> [ 5631.004097] RIP: 0010:[<ffffffffc087df92>]  [<ffffffffc087df92>] qla_nvme_abort_work+0x22/0x100 [qla2xxx]
> [ 5631.004109] Call Trace:
> [ 5631.004115]  [<ffffffffaa4b8174>] ? pwq_dec_nr_in_flight+0x64/0xb0
> [ 5631.004117]  [<ffffffffaa4b9d4f>] process_one_work+0x17f/0x440
> [ 5631.004120]  [<ffffffffaa4bade6>] worker_thread+0x126/0x3c0
> 
> Signed-off-by: Quinn Tran <qutran@marvell.com>
> Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
> ---
>   drivers/scsi/qla2xxx/qla_def.h  |   2 +
>   drivers/scsi/qla2xxx/qla_nvme.c | 164 ++++++++++++++++++++++++++++------------
>   drivers/scsi/qla2xxx/qla_nvme.h |   1 +
>   3 files changed, 117 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
> index 602ed24bb806..85a27ee5d647 100644
> --- a/drivers/scsi/qla2xxx/qla_def.h
> +++ b/drivers/scsi/qla2xxx/qla_def.h
> @@ -532,6 +532,8 @@ typedef struct srb {
>   	uint8_t cmd_type;
>   	uint8_t pad[3];
>   	atomic_t ref_count;
> +	struct kref cmd_kref;	/* need to migrate ref_count over to this */
> +	void *priv;
>   	wait_queue_head_t nvme_ls_waitq;
>   	struct fc_port *fcport;
>   	struct scsi_qla_host *vha;

My feedback about this patch is as follows:
- I think that having two atomic counters in struct srb with a very
   similar purpose is overkill and also that a single atomic counter
   should be sufficient in this structure.
- The problem fixed by this patch not only can happen with NVMe-FC but
   also with FC. I would prefer to see all code paths fixed for which a
   race between completion and abort can occur.

Thanks,

Bart.
