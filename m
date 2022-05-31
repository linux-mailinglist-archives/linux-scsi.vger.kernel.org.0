Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B16C25393EC
	for <lists+linux-scsi@lfdr.de>; Tue, 31 May 2022 17:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345648AbiEaP0d (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 31 May 2022 11:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbiEaP0b (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 31 May 2022 11:26:31 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9C13617B
        for <linux-scsi@vger.kernel.org>; Tue, 31 May 2022 08:26:30 -0700 (PDT)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LCGLp0rcjz67mqV;
        Tue, 31 May 2022 23:25:38 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 31 May 2022 17:26:27 +0200
Received: from [10.47.88.115] (10.47.88.115) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 31 May
 2022 16:26:27 +0100
Message-ID: <0ebd951e-f047-1930-4ace-f5199921bf9a@huawei.com>
Date:   Tue, 31 May 2022 16:26:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 01/10] scsi/mvsas: Kill CONFIG_SCSI_MVSAS_TASKLET
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     Davidlohr Bueso <dave@stgolabs.net>, <linux-scsi@vger.kernel.org>,
        <martin.petersen@oracle.com>, <ejb@linux.ibm.com>,
        <tglx@linutronix.de>
References: <20220530231512.9729-1-dave@stgolabs.net>
 <20220530231512.9729-2-dave@stgolabs.net>
 <17747966-ea44-ebe5-3d79-df7c33b6a16e@huawei.com>
 <20220531145231.opypdzrlrg23ihil@offworld>
 <5d28e848-0b9d-2aaa-e00e-7888342d25a7@huawei.com>
 <YpYxfSYDbCJEh9PG@linutronix.de>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <YpYxfSYDbCJEh9PG@linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.88.115]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 31/05/2022 16:17, Sebastian Andrzej Siewior wrote:
>> Sorry, maybe I was not clear, but I was just asking if there was a good
>> reason to disable interrupts at source while handling the interrupt, and not
>> the change to stop using a tasklet.
> Without reading the patch first: You need to disable the interrupt
> source while the tasklet/ threaded interrupt is handled. Otherwise the
> interrupt will keep coming and the tasklet/ threaded interrupt will have
> no chance to make progress. So the box will lock up. This is often
> overseen on fast machines because the interrupt needs a few usecs to
> trigger and so the CPU is able to make a little bit of progress between
> each trigger.
> 

ah, so we would need IRQF_ONESHOT flag set to keep the interrupt line 
disabled until the threaded part completes, right?

Thanks,
John
