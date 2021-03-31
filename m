Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 000CF34D97C
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Mar 2021 23:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhC2VQh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 29 Mar 2021 17:16:37 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:50039 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229555AbhC2VQA (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 29 Mar 2021 17:16:00 -0400
Received: from [192.168.0.2] (ip5f5aef67.dynamic.kabel-deutschland.de [95.90.239.103])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: it)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 722A22064792E;
        Mon, 29 Mar 2021 23:15:53 +0200 (CEST)
Subject: Re: [PATCH V3 15/25] smartpqi: fix host qdepth limit
To:     Don.Brace@microchip.com, john.garry@huawei.com, mwilck@suse.com,
        pmenzel@molgen.mpg.de, Kevin.Barnett@microchip.com,
        Scott.Teel@microchip.com, Justin.Lindley@microchip.com,
        Scott.Benesh@microchip.com, Gerry.Morong@microchip.com,
        Mahesh.Rajashekhara@microchip.com, hch@infradead.org,
        joseph.szczypek@hpe.com, POSWALD@suse.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, it+linux-scsi@molgen.mpg.de,
        buczek@molgen.mpg.de, gregkh@linuxfoundation.org,
        ming.lei@redhat.com
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
From:   Paul Menzel <it@molgen.mpg.de>
Message-ID: <c0d94b4d-b8d8-0b1a-a096-81eac68b4af4@molgen.mpg.de>
Date:   Mon, 29 Mar 2021 23:15:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <SN6PR11MB2848D1442DE98A85A7B8B89EE18D9@SN6PR11MB2848.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Dear Linüx folks,


Am 10.02.21 um 17:29 schrieb Don.Brace@microchip.com:
> -----Original Message-----
> From: John Garry [mailto:john.garry@huawei.com]
> Subject: Re: [PATCH V3 15/25] smartpqi: fix host qdepth limit
> 
>> I think that this can alternatively be solved by setting .host_tagset flag.
>>
>> Thanks,
>> John
>>
>> Don: John, can I add a Suggested-by tag for you for my new patch smartpqi-use-host-wide-tagspace?
> 
> I don't mind. And I think that Ming had the same idea.

> Don: Thanks for reminding me. Ming, can I add your Suggested-by tag?

It looks like, iterations 4 and 5 of the patch series have been posted 
in the meantime. Unfortunately without the reporters and discussion 
participants in Cc. Linux upstream is still broken since version 5.5.


Kind regards,

Paul


[1]: 
https://lore.kernel.org/linux-scsi/161540568064.19430.11157730901022265360.stgit@brunhilda/
[2]: 
https://lore.kernel.org/linux-scsi/161549045434.25025.17473629602756431540.stgit@brunhilda/
