Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB2F891AE9
	for <lists+linux-scsi@lfdr.de>; Mon, 19 Aug 2019 03:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfHSB7s (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 18 Aug 2019 21:59:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4728 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726103AbfHSB7r (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 18 Aug 2019 21:59:47 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3D388DF3FBBA2FC3561E;
        Mon, 19 Aug 2019 09:59:46 +0800 (CST)
Received: from [127.0.0.1] (10.184.213.217) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Mon, 19 Aug 2019
 09:59:39 +0800
Subject: Re: [PATCH v4] SCSI: fix queue cleanup race before
 scsi_requeue_run_queue is done
To:     Bart Van Assche <bvanassche@acm.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <ming.lei@redhat.com>,
        <linux-scsi@vger.kernel.org>
CC:     <houtao1@huawei.com>, <yanaijie@huawei.com>
References: <1565667334-22071-1-git-send-email-zhengbin13@huawei.com>
 <ae7561d6-e61d-c7a1-590b-2071598c0f49@acm.org>
From:   "zhengbin (A)" <zhengbin13@huawei.com>
Message-ID: <692b42b3-44a9-e3e2-234d-d60e1ffccb7f@huawei.com>
Date:   Mon, 19 Aug 2019 09:59:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <ae7561d6-e61d-c7a1-590b-2071598c0f49@acm.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.184.213.217]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2019/8/17 1:09, Bart Van Assche wrote:
> On 8/12/19 8:35 PM, zhengbin wrote:
>> KASAN reports a use-after-free in 4.19-stable,
>> which won't happen after commit 47cdee29ef9d
>> ("block: move blk_exit_queue into __blk_release_queue").
>
> This patch doesn't apply on top of kernel v4.19.67:
>
> $ git am ~/\[PATCH\ v4\]\ SCSI\:\ fix\ queue\ cleanup\ race\ before\ scsi_requeue_run_queue\ is\ done.eml
> Applying: SCSI: fix queue cleanup race before scsi_requeue_run_queue is done
> error: patch failed: drivers/scsi/scsi_lib.c:531
> error: drivers/scsi/scsi_lib.c: patch does not apply
> Patch failed at 0001 SCSI: fix queue cleanup race before scsi_requeue_run_queue is done
>
> $ patch -p1 < ~/\[PATCH\ v4\]\ SCSI\:\ fix\ queue\ cleanup\ race\ before\ scsi_requeue_run_queue\ is\ done.eml
> (Stripping trailing CRs from patch; use --binary to disable.)
> patching file drivers/scsi/scsi_lib.c
> Hunk #1 succeeded at 548 with fuzz 1 (offset 17 lines).
> Hunk #2 FAILED at 618.
> 1 out of 2 hunks FAILED -- saving rejects to file drivers/scsi/scsi_lib.c.rej
> (Stripping trailing CRs from patch; use --binary to disable.)
> patching file drivers/scsi/scsi_sysfs.c
> Hunk #1 succeeded at 1392 (offset -18 lines).

This patch is for master, not for 4.19-stable. In SCSI, master has only blk-mq, while 4.19-stable has blk-sq(single queue) & mq.

I will send a patch for 4.19-stable later.

>
> Bart.
>
> .
>

