Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F67434E55
	for <lists+linux-scsi@lfdr.de>; Wed, 20 Oct 2021 16:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbhJTO4d (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 20 Oct 2021 10:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhJTO4c (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 20 Oct 2021 10:56:32 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 330C5C061749
        for <linux-scsi@vger.kernel.org>; Wed, 20 Oct 2021 07:54:18 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id s18-20020a0568301e1200b0054e77a16651so8540316otr.7
        for <linux-scsi@vger.kernel.org>; Wed, 20 Oct 2021 07:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TZZSEfWCStHUfXhWoXkg5KMgJocnV57u5o2CEcJ7HCc=;
        b=m6t8lcoqFlEuO2YtgUGyJOgTFG9r3gegg328r7yqi7ahbS8ubR2dD0/Pj2EWCTAUuA
         M02ojT0kPrzHZYYG+nzIM/amlc0aviTrC5h073WmzUsDG5kSpMZnjhuK+i8EoLI8XtFV
         tAOJI6Dq6RqsaFkY7XaLCF+jWOo8HC09LBuWXmFGMukDr003XnwiD9sz7/I/c5Gdrkja
         EgQndCGLKNGRW6KF4GgsUvpBI9e/r1wrQDvkfxN5dmsQcuosbJ5bD+47WPJHDtMVt1ox
         UNh+E6Iq9tCpN0OMN/AP4Ti0h/SP/2gadP9EfeelfLwNwKFK/cs3CzBNoPypeMhUfQ1Q
         8tNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TZZSEfWCStHUfXhWoXkg5KMgJocnV57u5o2CEcJ7HCc=;
        b=TACTcJwUlife21pfjBR5lJSzAKYByxGRZCCHAqJKGjVN0kUDbCueGq5zPzrNsFhz2E
         PUy4I1n7DHZ2+k5tJcz8toF6pD521+Vaa4TiPxVt15cpzqg2wBLSCwcMZbkKcMo73fmi
         rEjYBf42HOO+GPpnL/ir4/rpvYNdZR15Ty3C7WlXaz9mfmuhEeG95Ssz2/uCxEgq+IWk
         lfSf+cp+KEXA4tNnBLKqZtIXHslT4cNWFHZPRtLf2p4KG/y0QlAyvOLGmGtfrVaU3hIL
         Mf6YxZeZrsnwybo41hXHwPj6hJ7wUnrb7S5H1SMwv8Oqu7KsfzFJc0oG3FcYgC3c6Ddw
         gIyw==
X-Gm-Message-State: AOAM533kxFAB17SpaTvxsIHYHkzZnxzePSU1/pewFFdOWvZ+F31JKGgL
        ajy6nNRlKNT7N4Ybtu5o1AIPI183eOCZLQ==
X-Google-Smtp-Source: ABdhPJyA70p8IeSf47juIEqV0A0ohyswwqnHS0r02Wg4m/IZ8h7PlFDckmkiOFfwNwbTNzml/h726Q==
X-Received: by 2002:a9d:4c99:: with SMTP id m25mr294329otf.204.1634741657447;
        Wed, 20 Oct 2021 07:54:17 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id bc41sm476898oob.2.2021.10.20.07.54.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 07:54:17 -0700 (PDT)
Subject: Re: remove QUEUE_FLAG_SCSI_PASSTHROUGH v2
To:     Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20211019075418.2332481-1-hch@lst.de>
 <yq15ytsbawr.fsf@ca-mkp.ca.oracle.com> <20211020053341.GA25529@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0a70e163-d6cb-9733-a91f-d0bee2c23c69@kernel.dk>
Date:   Wed, 20 Oct 2021 08:54:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211020053341.GA25529@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 10/19/21 11:33 PM, Christoph Hellwig wrote:
> On Wed, Oct 20, 2021 at 12:05:24AM -0400, Martin K. Petersen wrote:
>>
>> Christoph,
>>
>>> The changes to support pktcdvd are a bit ugly, but I can't think of
>>> anything better (except for removing the driver entirely).  If we'd
>>> want to support packet writing today it would probably live entirely
>>> inside the sr driver.
>>
>> Yeah, I agree.
>>
>> Anyway. No major objections from me. Not sure whether it makes most
>> sense for this to go through block or scsi?
> 
> I'm not sure either, but either tree is fine with me.

Looks fine to me, outside of the spelling error in patch 1. I can set
up a topic branch for this one.

Christoph, can you do a resend with the enum naming fixed?

-- 
Jens Axboe

