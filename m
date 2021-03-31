Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E503234EA82
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Mar 2021 16:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbhC3Ohl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 30 Mar 2021 10:37:41 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:60297 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231783AbhC3Ohj (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 30 Mar 2021 10:37:39 -0400
Received: from [192.168.0.5] (ip5f5aed0a.dynamic.kabel-deutschland.de [95.90.237.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: buczek)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8F7FC206473C1;
        Tue, 30 Mar 2021 16:37:33 +0200 (CEST)
Subject: Re: [PATCH V3 15/25] smartpqi: fix host qdepth limit
To:     Paul Menzel <pmenzel@molgen.mpg.de>, Don.Brace@microchip.com,
        john.garry@huawei.com, mwilck@suse.com,
        Kevin.Barnett@microchip.com, Scott.Teel@microchip.com,
        Justin.Lindley@microchip.com, Scott.Benesh@microchip.com,
        Gerry.Morong@microchip.com, Mahesh.Rajashekhara@microchip.com,
        hch@infradead.org, joseph.szczypek@hpe.com, POSWALD@suse.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, it+linux-scsi@molgen.mpg.de,
        gregkh@linuxfoundation.org, ming.lei@redhat.com
References: <160763241302.26927.17487238067261230799.stgit@brunhilda>
 <160763254769.26927.9249430312259308888.stgit@brunhilda>
 <ddd8bca4-2ae7-a2dc-cca6-0a2ff85a7d35@molgen.mpg.de>
 <SN6PR11MB28487527276CEBC75D36A732E1C60@SN6PR11MB2848.namprd11.prod.outlook.com>
 <85c6e1705c55fb930ac13bc939279f0d1faa526f.camel@suse.com>
 <SN6PR11MB2848C1195C65F87C910E979BE1A70@SN6PR11MB2848.namprd11.prod.outlook.com>
 <b3e4e597-779b-7c1e-0d3c-07bc3dab1bb5@huawei.com>
 <SN6PR11MB2848ECDD666F0BF867AE04DFE18D9@SN6PR11MB2848.namprd11.prod.outlook.com>
 <6fea70bb-1718-ad02-789b-8e908f57951e@huawei.com>
 <SN6PR11MB2848D1442DE98A85A7B8B89EE18D9@SN6PR11MB2848.namprd11.prod.outlook.com>
 <c0d94b4d-b8d8-0b1a-a096-81eac68b4af4@molgen.mpg.de>
 <00a52885-62d8-7bfd-cc78-3321a717b5ca@molgen.mpg.de>
From:   Donald Buczek <buczek@molgen.mpg.de>
Message-ID: <8072d5a6-dee9-e8e4-68be-8cf554b48b55@molgen.mpg.de>
Date:   Tue, 30 Mar 2021 16:37:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <00a52885-62d8-7bfd-cc78-3321a717b5ca@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Dear Paul,

On 29.03.21 23:16, Paul Menzel wrote:
> [Resent from correct address.]
> 
> Am 29.03.21 um 23:15 schrieb Paul Menzel:
>> Dear Linüx folks,
>>
>>
>> Am 10.02.21 um 17:29 schrieb Don.Brace@microchip.com:
>>> -----Original Message-----
>>> From: John Garry [mailto:john.garry@huawei.com]
>>> Subject: Re: [PATCH V3 15/25] smartpqi: fix host qdepth limit
>>>
>>>> I think that this can alternatively be solved by setting .host_tagset flag.
>>>>
>>>> Thanks,
>>>> John
>>>>
>>>> Don: John, can I add a Suggested-by tag for you for my new patch smartpqi-use-host-wide-tagspace?
>>>
>>> I don't mind. And I think that Ming had the same idea.
>>
>>> Don: Thanks for reminding me. Ming, can I add your Suggested-by tag?
>>
>> It looks like, iterations 4 and 5 of the patch series have been posted in the meantime. Unfortunately without the reporters and discussion participants in Cc. Linux upstream is still broken since version 5.5.

When "smartpqi: use host wide tagspace" [1] goes into mainline, we can submit it to stable, if nobody else does. This fixes the original problem and we got a patch with the same code change running in our 5.10 kernels.

Best
   Donald

[1]: https://lore.kernel.org/linux-scsi/161549369787.25025.8975999483518581619.stgit@brunhilda/

>>
>>
>> Kind regards,
>>
>> Paul
>>
>>
>> [1]: https://lore.kernel.org/linux-scsi/161540568064.19430.11157730901022265360.stgit@brunhilda/
>> [2]: https://lore.kernel.org/linux-scsi/161549045434.25025.17473629602756431540.stgit@brunhilda/
