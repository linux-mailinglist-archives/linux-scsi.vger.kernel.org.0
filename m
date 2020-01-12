Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCDFD138826
	for <lists+linux-scsi@lfdr.de>; Sun, 12 Jan 2020 21:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387412AbgALUIN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 12 Jan 2020 15:08:13 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:56297 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733294AbgALUIN (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 12 Jan 2020 15:08:13 -0500
Received: by mail-pj1-f65.google.com with SMTP id d5so3243633pjz.5;
        Sun, 12 Jan 2020 12:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IHJMxTJZ/pJoCk7j7QVl6dnURrLsbC4A/8uoxV4CQ9Y=;
        b=rBsBsIyOO/RAqOiBWfo6Oc7tEaRNL1YVgMQMISAnVcakEYOfkDJKC8BoTUgIZLnVDa
         oPoTl4HuFnp0R39rKbivivHXrWgdtKe60N77K+pC7QXSH80R126K6xReO8tuatNvHwnV
         IvTqhJ6Zmt8Pwx2u4D6C3pVg+xGQBwrtIgpmyBfzOYs3Qn0WbxWbDsxj0zvVy/EsWeKi
         zT13sLhdrhdJJqhUBZjvhf3LZ91brHpyoC72Y8t5QfXJO4931lpqf8HCnpG/4OgTL9Ba
         kZlV9aypvXst7frS0ogWacP17X28OS9w0jM0JLN8/yIyyvdhAohOvXXtZt2ktuLepYME
         JogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IHJMxTJZ/pJoCk7j7QVl6dnURrLsbC4A/8uoxV4CQ9Y=;
        b=AUB2ofZwJtL+Yzu20Yxd8u+nsLirYIdEn5VsxHFIzeG6M/U+IJQPXYGY46XkR/mKnI
         tzRZ0TMktisv2D12zbf3mXec80mnmCrcuMY2+cgBoqxkbPWAsg1uCkvwTMNN4wzbQKzS
         E0PBN5dX1VVLMpHSNVosE70rFpqNZq85Y7mip7gV6J2HUCVYpzSyIIZS46vmp+/KzUsr
         slWdmGQ5IeDR9BYClqanRxSCELV7C8Y1Fp79iTU3m1O9lUQbSUp/OPqsDVSfwNnFZyAU
         R+H4ixCE2mHl+4o7ub5VlmZjl3uwlhvhXWO0th9azu1x3bDNWE3JTLSJ+UgIhjjf8v20
         oYQw==
X-Gm-Message-State: APjAAAXLqRu2mjZS1RUfqJyb+8h3cWvcgtEFA35XGp/jEuFDVo9CGdjv
        09h4yLGQjAIxBK5pfqH0BPuZla7W
X-Google-Smtp-Source: APXvYqwHV99/uoMu0rXhLT8zV4PFzDn1rEU9yjIQ/XNAq9/Dhf97bvvEJqtHKHOKlbJba4JHNdm7OQ==
X-Received: by 2002:a17:90a:6587:: with SMTP id k7mr17797687pjj.40.1578859692224;
        Sun, 12 Jan 2020 12:08:12 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p21sm10917969pfn.103.2020.01.12.12.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jan 2020 12:08:11 -0800 (PST)
Subject: Re: [PATCH v2] hwmon: Driver for temperature sensors on SATA drives
To:     Gabriel C <nix.or.die@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>, Chris Healy <cphealy@gmail.com>
References: <20191215174509.1847-1-linux@roeck-us.net>
 <20191215174509.1847-2-linux@roeck-us.net> <yq1r211dvck.fsf@oracle.com>
 <b22a519c-8f26-e731-345f-9deca1b2150e@roeck-us.net>
 <yq1sgkq21ll.fsf@oracle.com> <20200108153341.GB28530@roeck-us.net>
 <38af9fda-9edf-1b54-bd8d-92f712ae4cda@roeck-us.net>
 <CAEJqkgg_piiAWy4r3VD=KyQ7pi69bZNym2Ws=Tr8SY5wf+Sprg@mail.gmail.com>
 <CACRpkdYU7ZDcKp+BbXRCnEFDw1xwDkU_vXsfo-AZNUWGEVknXQ@mail.gmail.com>
 <CAEJqkggo3Mou1SykjisyYn+3SGGgNfnKagr=7ZPyw=Y=1MZ55w@mail.gmail.com>
 <CACRpkdayHFmdz4nAMaXR07Hcy=dLLGnnU8PkFhwQKuDTLnvOSw@mail.gmail.com>
 <e3caa946-b8f2-75c7-4bcb-69ad198de472@roeck-us.net>
 <CAEJqkggBvBus-G=TevSf0OUWLx_63qmZEThi-tNyPmAD2JXW-g@mail.gmail.com>
 <25c57e9d-94db-3a8b-5f68-f8a49e500b45@roeck-us.net>
 <CAEJqkggnQzPw1uyMUZ5F-nqSwKAu5Ur7C_VujhZxZrvv-iUt_g@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <de8861e8-f21b-6a66-4f5b-25acc8ff40e2@roeck-us.net>
Date:   Sun, 12 Jan 2020 12:08:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAEJqkggnQzPw1uyMUZ5F-nqSwKAu5Ur7C_VujhZxZrvv-iUt_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 1/12/20 10:37 AM, Gabriel C wrote:
> Am So., 12. Jan. 2020 um 16:26 Uhr schrieb Guenter Roeck <linux@roeck-us.net>:
>>
>> On 1/12/20 5:45 AM, Gabriel C wrote:
>>> Am So., 12. Jan. 2020 um 14:07 Uhr schrieb Guenter Roeck <linux@roeck-us.net>:
>>>>
>>>> On 1/12/20 4:07 AM, Linus Walleij wrote:
>>>>> On Sun, Jan 12, 2020 at 1:03 PM Gabriel C <nix.or.die@gmail.com> wrote:
>>>>>> Am So., 12. Jan. 2020 um 12:22 Uhr schrieb Linus Walleij
>>>>>> <linus.walleij@linaro.org>:
>>>>>>>
>>>>>>> On Sun, Jan 12, 2020 at 12:18 PM Gabriel C <nix.or.die@gmail.com> wrote:
>>>>>>>
>>>>>>>> What I've noticed however is the nvme temperature low/high values on
>>>>>>>> the Sensors X are strange here.
>>>>>>> (...)
>>>>>>>> Sensor 1:     +27.9°C  (low  = -273.1°C, high = +65261.8°C)
>>>>>>>> Sensor 2:     +29.9°C  (low  = -273.1°C, high = +65261.8°C)
>>>>>>> (...)
>>>>>>>> Sensor 1:     +23.9°C  (low  = -273.1°C, high = +65261.8°C)
>>>>>>>> Sensor 2:     +25.9°C  (low  = -273.1°C, high = +65261.8°C)
>>>>>>>
>>>>>>> That doesn't look strange to me. It seems like reasonable defaults
>>>>>>> from the firmware if either it doesn't really log the min/max temperatures
>>>>>>> or hasn't been through a cycle of updating these yet. Just set both
>>>>>>> to absolute min/max temperatures possible.
>>>>>>
>>>>>> Ok I'll check that.
>>>>>>
>>>>>> Do you mean by setting the temperatures to use a lmsensors config?
>>>>>> Or is there a way to set these with a nvme command?
>>>>>
>>>>> Not that I know of.
>>>>>
>>>>> The min/max are the minumum and maximum temperatures the
>>>>> device has experienced during this power-on cycle.
>>>>>
>>>>
>>>> No, that would be lowest/highest. The above are (or should be) per-sensor
>>>> setpoints. The default for those is typically the absolute minimum /
>>>> maximum of the supported range.
>>>>
>>>> Some SATA drives report the lowest/highest temperatures experienced
>>>> since power cycle, like here.
>>>>
>>>> drivetemp-scsi-5-0
>>>> Adapter: SCSI adapter
>>>> temp1:        +23.0°C  (low  =  +0.0°C, high = +60.0°C)
>>>>                           (crit low = -41.0°C, crit = +85.0°C)
>>>>                           (lowest = +20.0°C, highest = +31.0°C)
>>>>
>>>
>>> The SATA temperatures are fine and reported like this here too, just
>>> the nvme ones are strange.
>>>
>>> drivetemp-scsi-4-0
>>> Adapter: SCSI adapter
>>> temp1:        +28.0°C  (low  =  +1.0°C, high = +61.0°C)
>>>                         (crit low =  +2.0°C, crit = +60.0°C)
>>>                         (lowest = +16.0°C, highest = +31.0°C)
>>>
>>> drivetemp-scsi-12-0
>>> Adapter: SCSI adapter
>>> temp1:        +29.0°C  (low  =  +1.0°C, high = +61.0°C)
>>>                         (crit low =  +2.0°C, crit = +60.0°C)
>>>                         (lowest = +18.0°C, highest = +32.0°C)
>>>
>>> and so on.
>>>
>>> Btw, where I can find the code does these calculations?
>>>
>>
>> Not sure if that is what you are looking for, but the nvme hardware
>> monitoring driver is at drivers/nvme/host/hwmon.c, the SATA hardware
>> monitoring driver is at drivers/hwmon/drivetemp.c.
>>
> 
> I have a look thanks.
> 
> I'm using your v2 patch for the nvme part since you posted it on 5.4 kernels.
> This is probably why I find the way the temperatures are now reported
> very strange.
> 
> The ADATA XPG SX8200 Pro in my laptop seems to work better:
> 
> nvme-pci-0200
> Adapter: PCI adapter
> Composite:    +37.9°C  (low  =  -0.1°C, high = +74.8°C)
>                        (crit = +79.8°C)
> 
> Low is 0° which is what the spec suggests.
> 
>> The limits on nvme drives are configurable.
> 
> Yes, I found this out already.
> 
>> root@server:/sys/class/hwmon# sensors nvme-pci-0100
>> nvme-pci-0100
>> Adapter: PCI adapter
>> Composite:    +40.9°C  (low  = -273.1°C, high = +84.8°C)
>>                          (crit = +84.8°C)
>> Sensor 1:     +40.9°C  (low  = -273.1°C, high = +65261.8°C)
>> Sensor 2:     +43.9°C  (low  = -273.1°C, high = +65261.8°C)
>>
>> root@server:/sys/class/hwmon# echo 0 > hwmon1/temp2_min
>> root@server:/sys/class/hwmon# echo 100000 > hwmon1/temp2_max
> 
> An lm-sensors configuration will work too.
> 
Sure, the above was just an example.

>> root@server:/sys/class/hwmon# sensors nvme-pci-0100
>> nvme-pci-0100
>> Adapter: PCI adapter
>> Composite:    +38.9°C  (low  = -273.1°C, high = +84.8°C)
>>                          (crit = +84.8°C)
>> Sensor 1:     +38.9°C  (low  =  -0.1°C, high = +99.8°C)
>> Sensor 2:     +42.9°C  (low  = -273.1°C, high = +65261.8°C)
>>
>> If you dislike the defaults, just configure whatever you think is
>> appropriate for your system.
> 
> It's not about disliking the values. I want to find out if these Samsung models
> don't support that, or it is a bug somewhere in writing/calculating the values.
> 
No, this is not a bug. It is perfectly valid for individual sensors to have
uninitialized limits. If I recall correctly, the NVME specification
specifically states that the default settings for individual sensors
shall be those values (0 and 65535 Kelvin, specifically).

And, yes, I would agree that is a bit odd that NVME drives report temperatures
in Kelvin, but such is the world.

> In the case, Samsung and others don't support such a thing wouldn't be
> better to just ignore
> the bogus reading altogether?

Again, you can set whatever limits you like. The default limits on many
hardware sensor chips have odd values. Just looking at my system:

nct6797-isa-0a20
Adapter: ISA adapter
in0:                    +0.48 V  (min =  +0.00 V, max =  +1.74 V)
in1:                    +1.02 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in2:                    +3.39 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in3:                    +3.31 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in4:                    +1.00 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in5:                    +0.14 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in6:                    +0.82 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in7:                    +3.38 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in8:                    +3.26 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in9:                    +1.82 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in10:                   +0.00 V  (min =  +0.00 V, max =  +0.00 V)
in11:                   +0.74 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in12:                   +1.20 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in13:                   +0.68 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in14:                   +1.50 V  (min =  +0.00 V, max =  +0.00 V)  ALARM


Are you suggesting that we should not support setting min/max values for
all drivers just because they are often not initialized to reasonable values
by default ?

Guenter
