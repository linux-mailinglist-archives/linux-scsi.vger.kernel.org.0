Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB132E04C3
	for <lists+linux-scsi@lfdr.de>; Tue, 22 Dec 2020 04:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgLVDfE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 21 Dec 2020 22:35:04 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:62011 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgLVDfD (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 21 Dec 2020 22:35:03 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608608081; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=2zXWpzZReMQc0eDicRW8wNaf31tlKlJsSyaqg1/T/Bw=;
 b=bDt7Tl4i0KQX40J8PCrFrEnXLry1OGDC8ngPSNyde35Dl1quWmJDXpjeGLIUIFW9qF6QiAB3
 6f0yGdUtaaAjC+jhSWeJn9ZZDzVCutZ4HyKWQDj0mfsp91UNCGDWPgjoZG7wlli27Oj1eoLR
 nq0FmAGPJw7lVEjEGAbm6/xHExY=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyJlNmU5NiIsICJsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5fe16932da47198188874f3d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Dec 2020 03:34:10
 GMT
Sender: cang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3AE8BC43461; Tue, 22 Dec 2020 03:34:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: cang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3742EC433CA;
        Tue, 22 Dec 2020 03:34:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 22 Dec 2020 11:34:07 +0800
From:   Can Guo <cang@codeaurora.org>
To:     Kiwoong Kim <kwmad.kim@samsung.com>
Cc:     linux-scsi@vger.kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com,
        asutoshd@codeaurora.org, bvanassche@acm.org,
        grant.jung@samsung.com, sc.suh@samsung.com, hy50.seo@samsung.com,
        sh425.lee@samsung.com, bhoon95.kim@samsung.com
Subject: Re: [PATCH v3 2/2] ufs: ufs-exynos: set dma_alignment to 4095
In-Reply-To: <000101d6d811$052b0f40$0f812dc0$@samsung.com>
References: <cover.1608603608.git.kwmad.kim@samsung.com>
 <CGME20201222023244epcas2p2cb8f4f0b0b41a0eeb0207cd1b12ddd8c@epcas2p2.samsung.com>
 <f79683fc5df0341047269fc73907e81109862abf.1608603608.git.kwmad.kim@samsung.com>
 <0cc3dc22424d2052c0cdde8b80aa237b@codeaurora.org>
 <000101d6d811$052b0f40$0f812dc0$@samsung.com>
Message-ID: <dc8f95bd2aafc5f9e0ee58c58f075d29@codeaurora.org>
X-Sender: cang@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2020-12-22 11:17, Kiwoong Kim wrote:
>> On 2020-12-22 10:21, Kiwoong Kim wrote:
>> > Exynos requires one scatterlist entry for smaller than page size, i.e.
>> > 4KB. For the cases of dispatching commands with more than one
>> > scatterlist entry and under 4KB size, Exynos behaves as follows:
>> >
>> > Given that a command to read something from device is dispatched with
>> > two scatterlist entries that are named AAA and BBB. After dispatching,
>> > host builds two PRDT entries and during transmission, device sends
>> > just one DATA IN because device doesn't care on host dma.
>> 
>> If my understanding is correct, above is same to all hosts, only below
>> part is Exynos's behavior. Please correct me if I am wrong.
> You're correct.
> 
>> 
>> > The host then tranfers
>> > the whole data from start address of the area named AAA.
>> > In consequebnce, the area that follows AAA would be corrupted.
>> 
>> In consequence
>> 
>> >
>> >     |<------------->|
>> >     +-------+------------         +-------+
>> >     +  AAA  + (corrupted)   ...   +  BBB  +
>> >     +-------+------------         +-------+
>> >
>> 
>> AFAIK, queue->dma_alignment is only used in the case of direct-io, 
>> i.e. in
>> blk_rq_map_user/kern(), which are mainly used in IOCTL.
>> If a request's buffer len and/or buffer start addr is not aligned with
>> queue->dma_alignment, bio.c will make a bounce bio such that the 
>> request
>> get a new buffer which starts on a new page. After the bounce bio is
> ended,
>> the data in the bound bio will be copied to the initial buffer.
>> 
>> So in this fix, you are making sure the AAA and BBB are all mapped to 
>> one
>> bounce bio and stay in one bi_vec, so when we do map_sg they come in 
>> one
>> sglist, please correct me if I am wrong.
>> 
>> If my understanding is correct, what is the real use case here - 
>> why/how
>> user starts a request which can generate more than one sglists whose 
>> sizes
>> are all under 4KB? I am just curious.
>> 
>> Thanks,
>> 
>> Can Guo.
> 
> You nearly exactly got what I’m thinking.
> And I think there could be various cases making those situations,
> which are definitely up to user programs. That is the case using
> different memory areas to contain something.
> 

If you want to make AAA and BBB stay in one bi_vec, they should be
continuous in memory (DDR), otherwise they will be put into two
bi_vecs and eventually become two sglist entries. My doubt is that
if user uses different memory areas to contain something as you
said, how can this fix make AAA and BBB stay in one sglist entry?

Thanks,

Can Guo.

> Thanks.
> Kiwoong Kim
>> 
>> > Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
>> > ---
>> >  drivers/scsi/ufs/ufs-exynos.c | 9 +++++++++
>> >  1 file changed, 9 insertions(+)
>> >
>> > diff --git a/drivers/scsi/ufs/ufs-exynos.c
>> > b/drivers/scsi/ufs/ufs-exynos.c index a8770ff..8635d9d 100644
>> > --- a/drivers/scsi/ufs/ufs-exynos.c
>> > +++ b/drivers/scsi/ufs/ufs-exynos.c
>> > @@ -14,6 +14,7 @@
>> >  #include <linux/of_address.h>
>> >  #include <linux/phy/phy.h>
>> >  #include <linux/platform_device.h>
>> > +#include <linux/blkdev.h>
>> >
>> >  #include "ufshcd.h"
>> >  #include "ufshcd-pltfrm.h"
>> > @@ -1193,6 +1194,13 @@ static int exynos_ufs_resume(struct ufs_hba
>> > *hba, enum ufs_pm_op pm_op)
>> >  	return 0;
>> >  }
>> >
>> > +static void exynos_ufs_slave_configure(struct scsi_device *sdev) {
>> > +	struct request_queue *q = sdev->request_queue;
>> > +
>> > +	blk_queue_update_dma_alignment(q, PAGE_SIZE - 1); }
>> > +
>> >  static struct ufs_hba_variant_ops ufs_hba_exynos_ops = {
>> >  	.name				= "exynos_ufs",
>> >  	.init				= exynos_ufs_init,
>> > @@ -1204,6 +1212,7 @@ static struct ufs_hba_variant_ops
>> > ufs_hba_exynos_ops = {
>> >  	.hibern8_notify			= exynos_ufs_hibern8_notify,
>> >  	.suspend			= exynos_ufs_suspend,
>> >  	.resume				= exynos_ufs_resume,
>> > +	.slave_configure		= exynos_ufs_slave_configure,
>> >  };
>> >
>> >  static int exynos_ufs_probe(struct platform_device *pdev)
