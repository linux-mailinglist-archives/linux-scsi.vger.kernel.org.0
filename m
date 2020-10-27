Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFB029B640
	for <lists+linux-scsi@lfdr.de>; Tue, 27 Oct 2020 16:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1797192AbgJ0PWI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 27 Oct 2020 11:22:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47546 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1797180AbgJ0PWG (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 27 Oct 2020 11:22:06 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603812124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZpUA5T6GnqkL1oqvAwNtwEv/lxjhPPmZ7O6sI+tfvDs=;
        b=hU3438/GeulhC9U+rgBa3ne3IR8cwYgHVtt2xgj/3xw2gcU7K4hAW9oSqCCYHRzD2MxkAS
        uimd452kFnZN1CUwPDy4lCcm8ifmX5RLu9kU/dRMAzGZp2a7kTIEs4KWTEAvEKjVX8V7kE
        OtUilBoYiURaWY68Oxf4CqALxC1Dvg03zb5U6W8qWYAHn4cFUML1nn9gJOd+Zxd2Vr82KE
        0Jc2107h2FUzhxVnY7vC9yUh5CjhJhWXtA+EQHu6KZkfwOnHs5rRBBbJA7eAl3IdDvdsKw
        vceNhfjfoS0QJrPSDhFO3fw0GnMuEtxFdX8p2MRASdaoGdsCp36Eoo0e44Si4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603812124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZpUA5T6GnqkL1oqvAwNtwEv/lxjhPPmZ7O6sI+tfvDs=;
        b=edxYOTDdAdOBYBCllantSJcHX9nVuXGxgiGlV1ORSUid3sz6uG5u5fR6RfdvSFbxpbSjZz
        idH1FJgq7zjdXfBA==
To:     John Garry <john.garry@huawei.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     linuxarm@huawei.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH 1/3] genirq/affinity: Add irq_update_affinity_desc()
In-Reply-To: <1603800624-180488-2-git-send-email-john.garry@huawei.com>
References: <1603800624-180488-1-git-send-email-john.garry@huawei.com> <1603800624-180488-2-git-send-email-john.garry@huawei.com>
Date:   Tue, 27 Oct 2020 16:22:03 +0100
Message-ID: <87h7qf1yp0.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

John,

On Tue, Oct 27 2020 at 20:10, John Garry wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
>
> Add a function to allow the affinity of an interrupt be switched to
> managed, such that interrupts allocated for platform devices may be
> managed.
>
> <Insert author sob>
>
> [jpg: Add commit message and add prototypes]
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
> Thomas, I just made you author since you provided the original code, hope
> it's ok.

I already forgot about this. And in fact I only gave you a broken
example. So just make yourself the author and add Suggested-by: tglx.

Vs. merging. I'd like to pick that up myself as I might have other
changes in that area coming up.

I'll do it as a single commit on top of rc1 and tag it so the scsi
people can just pull it in.

Thanks,

        tglx
