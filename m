Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E116429D555
	for <lists+linux-scsi@lfdr.de>; Wed, 28 Oct 2020 23:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbgJ1V71 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 28 Oct 2020 17:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729296AbgJ1V70 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 28 Oct 2020 17:59:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BBEC0613D1;
        Wed, 28 Oct 2020 14:59:26 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603909350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hHSo5mLm2YdFaQeHlvR8xcV3UAJmfAc+vvkhBluX8qo=;
        b=G2SRgpwNjPS2PH7DHQA38BGfmVOfajAY2isL1Sq1OCS+XXjtEyTCt+SlM57rdjf3f+6n+g
        m99IZb/Jfe3WefkKHGyD4pVPkCTs+byjYWrm9re7Bmnqmg1w+gWb64Zhy4SFCzqnBY2TWM
        4xO6vBXlYhhZhkX9m8t4GC3RpkdUEiTfTcI+qHAowj7S3BdlVvr6Shded/G4HztZ3nHU1C
        Dq+fde2zgojwG0K+oabyxY3WkE3FutsDA3o/+Lm4fuTFNwFBpXmcjtVsOMUKnXYL5j/zWQ
        XS4+Feii3CoyBWBe/cm0H0JJGGDwMfs0zUcvpHmDB5N+jftG6g5PbFoSEKpJ/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603909350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hHSo5mLm2YdFaQeHlvR8xcV3UAJmfAc+vvkhBluX8qo=;
        b=JEwHkmPJCpzQmpW+KFKsSIdIi/I+53aSg4+W8esXHBbp57OL4ZDRhuIQIt3/H/G0qisUa9
        urgekIPvbeQQIXDw==
To:     John Garry <john.garry@huawei.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     linuxarm@huawei.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v2 1/3] genirq/affinity: Add irq_update_affinity_desc()
In-Reply-To: <1603888387-52499-2-git-send-email-john.garry@huawei.com>
References: <1603888387-52499-1-git-send-email-john.garry@huawei.com> <1603888387-52499-2-git-send-email-john.garry@huawei.com>
Date:   Wed, 28 Oct 2020 19:22:29 +0100
Message-ID: <87eelifbx6.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Oct 28 2020 at 20:33, John Garry wrote:
>  
> +int irq_update_affinity_desc(unsigned int irq,
> +			     struct irq_affinity_desc *affinity)
> +{
> +	unsigned long flags;
> +	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, 0);
> +
> +	if (!desc)
> +		return -EINVAL;

Just looking at it some more. This needs a check whether the interrupt
is actually shut down. Otherwise the update will corrupt
state. Something like this:

        if (irqd_is_started(&desc->irq_data))
        	return -EBUSY;

But all of this can't work on x86 due to the way how vector allocation
works. Let me think about that.

Thanks,

        tglx

