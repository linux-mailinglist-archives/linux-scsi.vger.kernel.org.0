Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178EC2A9267
	for <lists+linux-scsi@lfdr.de>; Fri,  6 Nov 2020 10:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgKFJW6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 6 Nov 2020 04:22:58 -0500
Received: from mxout04.lancloud.ru ([89.108.124.63]:39996 "EHLO
        mxout04.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFJW6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 6 Nov 2020 04:22:58 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru 4D97920700CD
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH] scsi: fdomain_isa: merge branches in fdomain_isa_match()
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>
References: <df68e341-5113-4cf2-b64c-dc1ad0b686ac@omprussia.ru>
 <159961731708.5787.1524744143353594403.b4-ty@oracle.com>
 <8213375a-6472-69cd-8c86-2c8df31b26e5@omprussia.ru>
Organization: Open Mobile Platform
Message-ID: <c4c92a5a-fe5f-a0c6-01d8-c86324d65ca9@omprussia.ru>
Date:   Fri, 6 Nov 2020 12:22:42 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <8213375a-6472-69cd-8c86-2c8df31b26e5@omprussia.ru>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [213.87.145.179]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1908.lancloud.ru (fd00:f066::208)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 06.11.2020 12:17, Sergey Shtylyov wrote:

>>> The *else* branch of the *if* (base) statement in fdomain_isa_match() is
>>> immediately followed by the *if* (!base) statement. Simplify the code by
>>> removing the unneeded *if*...
>>
>> Applied to 5.10/scsi-queue, thanks!
>>
>> [1/1] scsi: fdomain_isa: Merge branches in fdomain_isa_match()
>>        https://git.kernel.org/mkp/scsi/c/255937d77390
> 
>     It was already merged to Linus' tree... but now I'm not seeing it there, 
> the patch has just disappeared! How come?

    Has just reappeared again! :-/

MBR, Sergei
