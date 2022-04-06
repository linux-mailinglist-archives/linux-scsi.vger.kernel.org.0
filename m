Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6524F6031
	for <lists+linux-scsi@lfdr.de>; Wed,  6 Apr 2022 15:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbiDFNoG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 6 Apr 2022 09:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiDFNnw (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 6 Apr 2022 09:43:52 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D65512631;
        Wed,  6 Apr 2022 03:51:19 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KYLMP4fygzBs2q;
        Wed,  6 Apr 2022 18:28:33 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 6 Apr 2022 18:32:44 +0800
Received: from [10.174.178.220] (10.174.178.220) by
 dggpemm500017.china.huawei.com (7.185.36.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 6 Apr 2022 18:32:43 +0800
Subject: Re: [REQUEST DISCUSS]: speed up SCSI error handle for host with
 massive devices
To:     Hannes Reinecke <hare@suse.de>,
        Mike Christie <michael.christie@oracle.com>,
        Steffen Maier <maier@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Lee Duncan <lduncan@suse.com>,
        John Garry <john.garry@huawei.com>
CC:     Wu Bo <wubo40@huawei.com>, Feilong Lin <linfeilong@huawei.com>,
        <zhangjian013@huawei.com>
References: <71e09bb4-ff0a-23fe-38b4-fe6425670efa@huawei.com>
 <cd7bda98-2160-9271-9520-e98d1fe00ea5@linux.ibm.com>
 <331aafe1-df9b-cae4-c958-9cf1800e389a@huawei.com>
 <64d5a997-a1bf-7747-072d-711a8248874d@suse.de>
 <c4baacf1-0e86-9660-45f7-50ebc853e6af@huawei.com>
 <1dd69d03-b4f6-ab20-4923-0995b40f045d@suse.de>
 <d2f2c89f-c048-4f04-4d95-27958f0fa46a@huawei.com>
 <78d41ec1-b30c-f6d2-811c-e0e4adbc8f01@oracle.com>
 <84b38f16-2a32-f361-43e5-34bce1012e71@oracle.com>
 <769bcd36-4818-8470-2daa-49ac5c05b33a@suse.de>
From:   Wenchao Hao <haowenchao@huawei.com>
Message-ID: <90e4af07-074c-1f60-e64a-e6dbe9a5c1bb@huawei.com>
Date:   Wed, 6 Apr 2022 18:32:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <769bcd36-4818-8470-2daa-49ac5c05b33a@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.220]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2022/4/4 13:28, Hannes Reinecke wrote:
> On 4/3/22 19:17, Mike Christie wrote:
>> On 4/3/22 12:14 PM, Mike Christie wrote:
>>> We could share code with scsi_ioctl_reset as well. Drivers that support
>>> TMFs via that ioctl already expect queuecommand to be possibly in the
>>> middle of a run and IO not yet timed out. For example, the code to
>>> block a queue and reset the device could be used for the new EH and
>>> SG_SCSI_RESET_DEVICE handling.
>>>
>>
>> Hannes or others,
>>
>> How do parallel SCSI drivers support scsi_ioctl_reset? Is is not fully
>> supported and more only used for controlled testing?
> 
> That's actually a problem in scsi_ioctl_reset(); it really should wait for all I/O to quiesce. Currently it just sets the 'tmf' flag and calls into the various reset functions.
> 
> But really, I'd rather get my EH rework in before we're start discussing modifying EH behaviour.
> Let me repost it ...
> 
> Cheers,
> 
> Hannes

Hi hannes:

According to the statistic, following scenario would cause an abort failed can be handled by LUN reset:
1. The task execute of disk's FW is abnormal;
2. Intermittent bit errors or intermittent disconnection;
3. FW do not response IO;

Following scenario can not be handled by LUN reset:
1. Disk HW issue, LUN reset can not be handled;
2. DDR UNC in disk, can not fix, the only way is to power off then power on
3. FW of disk is out of service, can not fix, the only way is to power off then power on

And the statistic shows most command abort failed can be handled by LUN reset.

So we plan to design a lightweight timeout handle flow as following:

                 if disable lightweight EH(default)
scsi_times_out  ====================================> origin EH flow
   ||                            
   || if enable lightweight EH 
   || 
   \/
do not using current timeout flow, and branch to another flow which perform following steps:

abort command
   ||
   || failed
   || 
   \/
stop single LUN's I/O (need to wait LUN's failed command number equal to busy command  number)
   ||
   || failed  (according to our statistic, 90% reset LUN would succeed)
   ||
   \/
reset single LUN
   ||
   ||           if host with multi LUNs timeout
   || failed =====================================> perform Host reset
   ||                                                   ||
   ||                                                   || failed
   ||                                                   ||
   || <=================================================//
   ||
   \/
offline disk

Since it's a lightweight EH, we prefer offline disk once reset LUN failed.
These changes would not affect origin EH flow. The advantage of this design is it would not affect
other LUNs of same host.
