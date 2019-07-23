Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92B7170F37
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jul 2019 04:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfGWCmf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 22 Jul 2019 22:42:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43788 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfGWCmf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 22 Jul 2019 22:42:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id i189so18319115pfg.10;
        Mon, 22 Jul 2019 19:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/C1r3eKgaVIKsSTSOnjY5crTChbBDWWCH5X7Og9SXiQ=;
        b=TreuxiXtTeOA5w4C7NLL3s+BIo6NvoAddk2TSeU1aKDuXfmSubg1WQJz38t0iboow5
         WjZ3tdGBR+bggC/p1zr0boriMuCqQiPSWruJKh6W4jyAyKJcaIrB3OHmC78wQKAufyZW
         Slsv+Xa8p49WqdYyvKxCXG1VV4v2OEoF2zSSG91kBdp8Mti1kxS8gPec58M3A1O6nSpY
         ecs05bpPMNrB6/iJByi6PkGMV6oNMYfeOjJo1mzWpZzyO/Uy4ORNxRMhAY4HFe7z1vHd
         iLY4awyS9FRCRdMxfy0Own2OviKaHkV0ictonGJMITP1R6Ew026wRJyvUtg28iXfeCYz
         ZO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/C1r3eKgaVIKsSTSOnjY5crTChbBDWWCH5X7Og9SXiQ=;
        b=RKIyI3LmaMlG6Rlw5R5lP6QnxWRKjE99NE1oAAwMFCalg3RFQa+F4l5hFP8nnKq+R1
         N93KVkSNuZ0B1uI1uSDta6bt9VTFWl3cIoGeJP+eLEtciLnuPa6t3cOe2D5DNTIMgogD
         fVzaUMey94mfMtc47xhj4TeOq4q1PC/DQJ1t726jNvVEa1XkMQqXkgFb2FAS4lVQ/eO6
         /vtRMV0+FpKDuqf1AgBctsEomREs4/zSMtk/jveWQhx5r9Zb5qF8MsEw7TPBnLnYTrGg
         CXKVmr8pomxefj7KBz/NGfiYGpaoAv8323Zun5zoE2x7Aa8btjohMZpyOHNfZ7KZYtZ8
         W9qA==
X-Gm-Message-State: APjAAAWYpNofshIeVjtq6EH7uOLavA+1F+bjgC6MfLzz6V7zPHIARGGx
        zN8kuhndUe1vsjQfXR0L9/ahNq7H
X-Google-Smtp-Source: APXvYqzlP18HJR0Q+4TP0c1buKH4Z3ueMFimE5d2YxEFvp4ewpvyHGDuq1tUAxqu4Fwt4ciVbb6npw==
X-Received: by 2002:a65:6259:: with SMTP id q25mr34537645pgv.145.1563849750589;
        Mon, 22 Jul 2019 19:42:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w16sm48954203pfj.85.2019.07.22.19.42.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 19:42:29 -0700 (PDT)
Subject: Re: Linux 5.3-rc1
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-scsi <linux-scsi@vger.kernel.org>
References: <CAHk-=wiVjkTqzP6OppBuLQZ+t1mpRQC4T+Ho4Wg2sBAapKd--Q@mail.gmail.com>
 <20190722222126.GA27291@roeck-us.net>
 <1563839144.2504.5.camel@HansenPartnership.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <4dc6ef77-afce-1c6d-add3-8df76332e672@roeck-us.net>
Date:   Mon, 22 Jul 2019 19:42:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1563839144.2504.5.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 7/22/19 4:45 PM, James Bottomley wrote:
> [linux-scsi added to cc]
> On Mon, 2019-07-22 at 15:21 -0700, Guenter Roeck wrote:
>> On Sun, Jul 21, 2019 at 02:33:38PM -0700, Linus Torvalds wrote:
>>
>> [ ... ]
>>>
>>> Go test,
>>>
>>
>> Things looked pretty good until a few days ago. Unfortunately,
>> the last few days brought in a couple of issues.
>>
>> riscv:virt:defconfig:scsi[virtio]
>> riscv:virt:defconfig:scsi[virtio-pci]
>>
>> Boot tests crash with no useful backtrace. Bisect points to
>> merge ac60602a6d8f ("Merge tag 'dma-mapping-5.3-1'"). Log is at
>> https://kerneltests.org/builders/qemu-riscv64-master/builds/238/steps
>> /qemubuildcommand_1/logs/stdio
>>
>> ppc:mpc8544ds:mpc85xx_defconfig:sata-sii3112
>> ppc64:pseries:pseries_defconfig:sata-sii3112
>> ppc64:pseries:pseries_defconfig:little:sata-sii3112
>> ppc64:ppce500:corenet64_smp_defconfig:e5500:sata-sii3112
>>
>> ata1: lost interrupt (Status 0x50)
>> ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
>> ata1.00: failed command: READ DMA
>>
>> and many similar errors. Boot ultimately times out. Bisect points to
>> merge
>> f65420df914a ("Merge tag 'scsi-fixes'").
>>
>> Logs:
>> https://kerneltests.org/builders/qemu-ppc64-master/builds/1212/steps/
>> qemubuildcommand/logs/stdio
>> https://kerneltests.org/builders/qemu-ppc-master/builds/1255/steps/qe
>> mubuildcommand/logs/stdio
>>
>> Guenter
>>
>> ---
>> riscv bisect log
>>
>> # bad: [5f9e832c137075045d15cd6899ab0505cfb2ca4b] Linus 5.3-rc1
>> # good: [bdd17bdef7d8da4d8eee254abb4c92d8a566bdc1] scsi: core: take
>> the DMA max mapping size into account
>> git bisect start 'HEAD' 'bdd17bdef7d8'
>> # good: [237f83dfbe668443b5e31c3c7576125871cca674] Merge
>> git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next
>> git bisect good 237f83dfbe668443b5e31c3c7576125871cca674
>> # good: [be8454afc50f43016ca8b6130d9673bdd0bd56ec] Merge tag 'drm-
>> next-2019-07-16' of git://anongit.freedesktop.org/drm/drm
>> git bisect good be8454afc50f43016ca8b6130d9673bdd0bd56ec
>> # good: [d4df33b0e9925c158b313a586fb1557cf29cfdf4] Merge branch 'for-
>> linus-5.2' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb
>> git bisect good d4df33b0e9925c158b313a586fb1557cf29cfdf4
>> # good: [f90b8fda3a9d72a9422ea80ae95843697f94ea4a] ARM: dts: gemini:
>> Set DIR-685 SPI CS as active low
>> git bisect good f90b8fda3a9d72a9422ea80ae95843697f94ea4a
>> # good: [31cc088a4f5d83481c6f5041bd6eb06115b974af] Merge tag 'drm-
>> next-2019-07-19' of git://anongit.freedesktop.org/drm/drm
>> git bisect good 31cc088a4f5d83481c6f5041bd6eb06115b974af
>> # good: [ad21a4ce040cc41b4a085417169b558e86af56b7] dt-bindings:
>> pinctrl: aspeed: Fix 'compatible' schema errors
>> git bisect good ad21a4ce040cc41b4a085417169b558e86af56b7
>> # good: [e6023adc5c6af79ac8ac5b17939f58091fa0d870] Merge branch
>> 'core-urgent-for-linus' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>> git bisect good e6023adc5c6af79ac8ac5b17939f58091fa0d870
>> # bad: [ac60602a6d8f6830dee89f4b87ee005f62eb7171] Merge tag 'dma-
>> mapping-5.3-1' of git://git.infradead.org/users/hch/dma-mapping
>> git bisect bad ac60602a6d8f6830dee89f4b87ee005f62eb7171
>> # good: [6e67d77d673d785631b0c52314b60d3c68ebe809] perf vendor events
>> s390: Add JSON files for machine type 8561
>> git bisect good 6e67d77d673d785631b0c52314b60d3c68ebe809
>> # good: [a0d14b8909de55139b8702fe0c7e80b69763dcfb] x86/mm, tracing:
>> Fix CR2 corruption
>> git bisect good a0d14b8909de55139b8702fe0c7e80b69763dcfb
>> # good: [6879298bd0673840cadd1fb36d7225485504ceb4] x86/entry/64:
>> Prevent clobbering of saved CR2 value
>> git bisect good 6879298bd0673840cadd1fb36d7225485504ceb4
>> # good: [449fa54d6815be8c2c1f68fa9dbbae9384a7c03e] dma-direct:
>> correct the physical addr in dma_direct_sync_sg_for_cpu/device
>> git bisect good 449fa54d6815be8c2c1f68fa9dbbae9384a7c03e
>> # good: [e0c5c5e308ee9b3548844f0d88da937782b895ef] Merge tag 'perf-
>> core-for-mingo-5.3-20190715' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into
>> perf/urgent
>> git bisect good e0c5c5e308ee9b3548844f0d88da937782b895ef
>> # good: [c6dd78fcb8eefa15dd861889e0f59d301cb5230c] Merge branch 'x86-
>> urgent-for-linus' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>> git bisect good c6dd78fcb8eefa15dd861889e0f59d301cb5230c
>> # first bad commit: [ac60602a6d8f6830dee89f4b87ee005f62eb7171] Merge
>> tag 'dma-mapping-5.3-1' of git://git.infradead.org/users/hch/dma-
>> mapping
>>
>> ---------
>> ppc/ppc64 bisect log
>>
>> # bad: [5f9e832c137075045d15cd6899ab0505cfb2ca4b] Linus 5.3-rc1
>> # good: [abdfd52a295fb5731ab07b5c9013e2e39f4d1cbe] Merge tag 'armsoc-
>> defconfig' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc
>> git bisect start 'HEAD' 'abdfd52a295f'
>> # bad: [e6023adc5c6af79ac8ac5b17939f58091fa0d870] Merge branch 'core-
>> urgent-for-linus' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
>> git bisect bad e6023adc5c6af79ac8ac5b17939f58091fa0d870
>> # bad: [f65420df914a85e33b2c8b1cab310858b2abb7c0] Merge tag 'scsi-
>> fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
>> git bisect bad f65420df914a85e33b2c8b1cab310858b2abb7c0
>> # good: [168c79971b4a7be7011e73bf488b740a8e1135c8] Merge tag 'kbuild-
>> v5.3-2' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
>> git bisect good 168c79971b4a7be7011e73bf488b740a8e1135c8
>> # good: [106d45f350c7cac876844dc685845cba4ffdb70b] scsi: zfcp: fix
>> request object use-after-free in send path causing wrong traces
>> git bisect good 106d45f350c7cac876844dc685845cba4ffdb70b
>> # good: [bdd17bdef7d8da4d8eee254abb4c92d8a566bdc1] scsi: core: take
>> the DMA max mapping size into account
>> git bisect good bdd17bdef7d8da4d8eee254abb4c92d8a566bdc1
>> # good: [09a4460ba4434ef0327cd26bf25f2d7afb973251] scsi: IB/iser: set
>> virt_boundary_mask in the scsi host
>> git bisect good 09a4460ba4434ef0327cd26bf25f2d7afb973251
>> # good: [ce0ad853109733d772d26224297fda0de313bf13] scsi: mpt3sas: set
>> an unlimited max_segment_size for SAS 3.0 HBAs
>> git bisect good ce0ad853109733d772d26224297fda0de313bf13
>> # good: [07d9aa14346489d6facae5777ceb267a1dcadbc5] scsi:
>> megaraid_sas: set an unlimited max_segment_size
>> git bisect good 07d9aa14346489d6facae5777ceb267a1dcadbc5
>> # first bad commit: [f65420df914a85e33b2c8b1cab310858b2abb7c0] Merge
>> tag 'scsi-fixes' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
> 
> When a bisect lands on a merge commit it usually indicates bad
> interaction between two trees.  The way to find it is to do a bisect,
> but merge up to the other side of the scsi-fixes pull before running
> tests so the interaction is exposed in the bisect.
> 

Can you provide instructions for dummies ?

> However my money is on:
> 
> 
> commit bdd17bdef7d8da4d8eee254abb4c92d8a566bdc1
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Mon Jun 17 14:19:54 2019 +0200
> 
>      scsi: core: take the DMA max mapping size into account
>   
> Now that I look at the code again:
> 
> 
> +       shost->max_sectors = min_t(unsigned int, shost->max_sectors,
> +                       dma_max_mapping_size(dev) << SECTOR_SHIFT);
> 
> That shift looks to be the wrong way around (should be >>).  I bet
> something is giving a very large number which becomes zero on left
> shift, meaning max_sectors gets set to zero.
> 

That does indeed look bad, but changing it doesn't make a difference.

Thanks,
Guenter
