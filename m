Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E535102AA8
	for <lists+linux-scsi@lfdr.de>; Tue, 19 Nov 2019 18:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbfKSRSE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 19 Nov 2019 12:18:04 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33368 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbfKSRSD (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 19 Nov 2019 12:18:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id a17so3006640wmb.0
        for <linux-scsi@vger.kernel.org>; Tue, 19 Nov 2019 09:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=XYALBRN2xT/OnssU4CohYTjC4Y/A8hShxPEpeDMU34M=;
        b=K3dHfhQ3c3fRpnW5Xo37+nGAgeqlKr7YGkBgLIwRLeW+H9vH5HHfwHutIf10CcHvnT
         Dda/OsF4fBYHrjK/i2YQ8jDdDG0YoEDnlw5oymFahAjWRokNVnhJP9GBW+PtOjiHcnCc
         ZL1aNyg6NQMY8yJDa+pF8gkMnjTV06jspDaRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=XYALBRN2xT/OnssU4CohYTjC4Y/A8hShxPEpeDMU34M=;
        b=kP9f3954cy3gtlfgeVlIRY9wyQQoXbW8fARw8+0++9NVx97zQIX9osC0gZrvdeH2IR
         kwlr3vkPIRoXfpaM+6z2H7mvMpGHfPF9smkbkgEvxXcyZFNFDkRsCSe6gnh7LTijYwzY
         kW+D704XxT07rGKLSvuZkEn2cHQp0ioKWu1CpT1QQ/zfnYo1cP07vEsMRX44qAF5fx6k
         ct7fn9EaAmWFePd3iyYb1aB3pkCXOCX+Ajd+k9B4m3YyS94QSVYSmyloBlnZbWFG7M3f
         oMjBNPprI/J1ZBVAT587p+sb8oxgq2+mimAWWNhmkspf/dptWdz0jVvI64Xvu0w2yjqg
         ArSQ==
X-Gm-Message-State: APjAAAUBaO/fqOTDtfbNlk6HIxMnyAbjsqaN6pyOOcLrWdeBbIyTE6H6
        ChOPXjAAgK5NJczJD2+1RKGlIw==
X-Google-Smtp-Source: APXvYqypum5UVQi1w+/w9g4QPnfPgdYVAUb/iN+oT/xLeToy0NAw9dg+9abypdtOw6+gwkYg2QSVAg==
X-Received: by 2002:a1c:49d5:: with SMTP id w204mr7232541wma.111.1574183881656;
        Tue, 19 Nov 2019 09:18:01 -0800 (PST)
Received: from [10.69.45.46] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id m9sm27513007wro.66.2019.11.19.09.17.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 09:18:00 -0800 (PST)
Subject: Re: [PATCH] lpfc: fixup out-of-bounds access during CPU hotplug
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        Daniel Wagner <daniel.wagner@suse.com>,
        linux-scsi@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        James Smart <james.smart@broadcom.com>
References: <20191118123012.99664-1-hare@suse.de>
 <5c61c1ce-d4fc-23b8-621a-897febb89b67@broadcom.com>
 <1713444f-2788-ca07-3452-efc9457215d9@suse.de>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <1dca4247-5d02-5232-cd73-a5519f1bbb94@broadcom.com>
Date:   Tue, 19 Nov 2019 09:17:57 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <1713444f-2788-ca07-3452-efc9457215d9@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



On 11/18/2019 12:21 PM, Hannes Reinecke wrote:
> On 11/18/19 8:28 PM, James Smart wrote:
>> On 11/18/2019 4:30 AM, Hannes Reinecke wrote:
>>> The lpfc driver allocates a cpu_map based on the number of possible
>>> cpus during startup. If a CPU hotplug occurs the number of CPUs
>>> might change, causing an out-of-bounds access when trying to lookup
>>> the hardware index for a given CPU.
>>>
>>> Suggested-by: Daniel Wagner <daniel.wagner@suse.com>
>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>> ---
>>>   drivers/scsi/lpfc/lpfc_scsi.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/scsi/lpfc/lpfc_scsi.c 
>>> b/drivers/scsi/lpfc/lpfc_scsi.c
>>> index ba26df90a36a..2380452a8efd 100644
>>> --- a/drivers/scsi/lpfc/lpfc_scsi.c
>>> +++ b/drivers/scsi/lpfc/lpfc_scsi.c
>>> @@ -642,7 +642,8 @@ lpfc_get_scsi_buf_s4(struct lpfc_hba *phba, 
>>> struct lpfc_nodelist *ndlp,
>>>       int tag;
>>>       struct fcp_cmd_rsp_buf *tmp = NULL;
>>> -    cpu = raw_smp_processor_id();
>>> +    cpu = min_t(u32, raw_smp_processor_id(),
>>> +            phba->sli4_hba.num_possible_cpu);
>>>       if (cmnd && phba->cfg_fcp_io_sched == LPFC_FCP_SCHED_BY_HDWQ) {
>>>           tag = blk_mq_unique_tag(cmnd->request);
>>>           idx = blk_mq_unique_tag_to_hwq(tag);
>>
>> This should be unnecessary with the lpfc 12.6.0.1 and 12.6.0.2 
>> patches that tie into cpu onling/offlining and cpu hot add.
>>
>> I am curious, how if a cpu is hot removed - how num_possible 
>> dynamically changes (to a lower value ?) such that a thread can be 
>> running on a cpu that returns a higher cpu number than num_possible ?
>>
> Actually, the behaviour of num_possible_cpus() under cpu hotplug seems 
> to be implementation-specific.
> One might want to set it to the max value at all times, which has the 
> drawback that you'd need to scale per-cpu values with that number, 
> leading to a massive memory overhead as only very few installation 
> will ever reach that number.
> Others might want to set to the max value at the current 
> configuration, implying that it might change under CPU hotplug.
> Which seems to be the case for PowerPC, which was the case which 
> triggered the issue at hand.
> But maybe it was a plain bug in the CPU hotplug implementation; one 
> should be asking BenH for details here.
>
> Cheers,
>
> Hannes

That sure seems to be at odds with this comment from 
include/linux/cpumask.h:

  *  The cpu_possible_mask is fixed at boot time, as the set of CPU id's
  *  that it is possible might ever be plugged in at anytime during the
  *  life of that system boot.  The cpu_present_mask is dynamic(*),
  *  representing which CPUs are currently plugged in.  And
  *  cpu_online_mask is the dynamic subset of cpu_present_mask,
  *  indicating those CPUs available for scheduling.

and
#define num_possible_cpus()     cpumask_weight(cpu_possible_mask)


-- james

