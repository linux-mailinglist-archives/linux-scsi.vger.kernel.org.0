Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4818B3BF563
	for <lists+linux-scsi@lfdr.de>; Thu,  8 Jul 2021 08:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhGHGIf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 8 Jul 2021 02:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhGHGIe (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 8 Jul 2021 02:08:34 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEF5C061574
        for <linux-scsi@vger.kernel.org>; Wed,  7 Jul 2021 23:05:52 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id t9so4858454pgn.4
        for <linux-scsi@vger.kernel.org>; Wed, 07 Jul 2021 23:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=x42eN8t1nMi/Qglwv0rlMAjFJm2O+TOdrEms1zHn4NQ=;
        b=tOGLoDCjJytRKdTKXzCyYio9r+dpnqrIzljrH/SEZ6NBACxwh+dBkb8lum4raL+Byb
         4iYCphC41sEg9DKDi9bmeClMjkuwL7EUtBd5g40XG0ROiz6tOgnq86m907rBIlqeB9R4
         QKXNR7gbJFI6cbQcrsJ5yrTBPKZYckKE9Tb9DaCIrXYbHnKtpFkGJBghidhlDWZ6Xx6x
         IOi6TOJMrz5amgLuUKmMNn4IULO04xxd7xRS82Htl1kTEhBB8pou3xybuzwQhBCxpI95
         1rfNN1IB1xVzz8RvKfz72TOsOn8carJtzyVv+LHG0CXxiAsX4yF/8JPKskgqYUX6n654
         Hikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x42eN8t1nMi/Qglwv0rlMAjFJm2O+TOdrEms1zHn4NQ=;
        b=Q1fbVvZMRphd5e6rFgpantGU7cpAeAW0602sAJzqcpGdyO8nM491UVZITeoTAR2l/y
         QGCe1K8byJ06nNNAJK0KsVtfV+oEkn350hKfCmI0IlD01sK5Sb/bWa0kKNo/mRh/NRub
         4YGbJHQuNsntZxExOzU8HosCvCvB296Z9Lh/ssirayFeL2TumwWhzj9ZeRxuIxy/vQyX
         TLRBD/iS+5El65FIg5ijIGue3hKEvGY0oYDEIi26JP0gIuH3eAe5w8HWHj9M3UkfplF5
         MrWJg/JhIAtyqbPdRq1PiWAwSi5COcJRxeKCxSCkGjPX9i2Sb3ylX6sZlIlB470km1Op
         vGOg==
X-Gm-Message-State: AOAM532bGOSyf2gTULwt3RsrP2d/m1lzA78iqfJN9dixZRhOvGN0RNpB
        J6QK3o/Hji90SWOH1XZgMJoRu2YKnrc=
X-Google-Smtp-Source: ABdhPJxAY/FpP2nc+9GkK5Hnw1a5db47aHRayb7swtKRyTTDHzdoBKcMgmfXzeV/kaJcF3wEmTaaag==
X-Received: by 2002:a05:6a00:168a:b029:2fb:6bb0:aba with SMTP id k10-20020a056a00168ab02902fb6bb00abamr30009557pfc.32.1625724352361;
        Wed, 07 Jul 2021 23:05:52 -0700 (PDT)
Received: from jianchwadeMacBook-Pro.local ([154.48.252.69])
        by smtp.gmail.com with ESMTPSA id 198sm367989pfw.21.2021.07.07.23.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 23:05:52 -0700 (PDT)
Subject: Re: Discard performance regression after "scsi: sd: Remove LBPRZ
 dependency for discards"
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     jejb@linux.ibm.com, linux-scsi@vger.kernel.org
References: <279cb008-4c92-0535-efdd-6e877bea7349@gmail.com>
 <yq1pmvtbiy2.fsf@ca-mkp.ca.oracle.com>
From:   Wang Jianchao <jianchao.wan9@gmail.com>
Message-ID: <f1331877-5221-5aaa-d896-ff487dbdf2d6@gmail.com>
Date:   Thu, 8 Jul 2021 14:05:49 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <yq1pmvtbiy2.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Thanks so much for your comment, Martin ;)
That's really helpful.

Jianchao

On 2021/7/8 11:23 AM, Martin K. Petersen wrote:
> 
> Wang,
> 
>> We have a sata ssd with following parameters,
>>
>>   max_ws_blocks = 0
>>   max_unmap_blocks = 262143
>>   lbprz = 1
>>   lbpu = 1
>>   unmap_limit_for_ws = 0
> 
> The device is explicitly asking for us to use UNMAP so the older kernel
> choosing WRITE SAME(16) was not correct.
> 
> I have been working on an update to the discard/zeroing heuristics that
> I'll post when 5.15 opens next week. But based on what's reported it by
> your device we would still choose UNMAP for discards. LBPRZ only affects
> which command we use for zeroing.
> 
