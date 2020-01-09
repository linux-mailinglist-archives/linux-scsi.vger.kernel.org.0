Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFEA21350C3
	for <lists+linux-scsi@lfdr.de>; Thu,  9 Jan 2020 02:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbgAIBAq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 8 Jan 2020 20:00:46 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45237 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbgAIBAq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 8 Jan 2020 20:00:46 -0500
Received: by mail-pg1-f196.google.com with SMTP id b9so2352429pgk.12
        for <linux-scsi@vger.kernel.org>; Wed, 08 Jan 2020 17:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QY2NYmXUFId5SsRG9cb6th6bxlBJQRphgvwk8nVeBM8=;
        b=nq8prrDkbn5m+zt8QXqGy1QQ2XVfMu6EoWwOsSNRJVd1HnmmqWk941nPvMsKRn8K/2
         0P7dsO79URKm7BXIj2krudNVfdnF0Tm/2I/Rw3CxWEjM8u0nlVOez4gQsS9Nc8bfkcsd
         qJNmXHQgcI+XS2i8+PA1jN3NL9hOA+Cm4+p84S/6DyjRdBk5HwRMjSwHm/j8vPRfSCqP
         7inFyiRHG2wLrKII2HeLgtlZWyzP5IlOUP5ryArdrERn3HQE8+5c1CSPvnaJ6BxH9CRP
         jcXxNTRDqFUyd9evH1Nw8JJNnD/gSL2VXxZRF0Bx+ceya8K/7u0888cCdQWyGQMoocdR
         QhJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QY2NYmXUFId5SsRG9cb6th6bxlBJQRphgvwk8nVeBM8=;
        b=ArE4vBJyMTQxbI7LzxNM8YQwgKZDN3jHx81HBsMeWvBWa/ewrZcJn3LxKs5txLXvdD
         +VW3bci6g6tphRe092Vku/5knkPXnTEur4oG13RG0G+KX16ADBE8ApUblv6fRSyVtyD9
         9q/ZzcZ+9Q19KtmXvXkI89H+mfqAEP1I2RK3Zoi6bnZbJOkClJuClFC2G+YzChg8hykk
         S3BIMbPCA9xu+stF1HffZRVhKq35vzb9c3nbhhGlH1PHKhu4DFA67bmeo3TGwlXnB3S+
         ARMlQ4O2N6JjMhJeLwHErxcB7ok+Vp0T23NkIsNH2fsop1y5IeQLSA2Umd/ryxdyP3qZ
         yE3A==
X-Gm-Message-State: APjAAAV61ZPquBVXEcqhiyQhnLrCXQbGkvK/mib+/d+JTAJXWxOuVCp7
        Cdlcoaj2pAGzr3hDhKDNpsg=
X-Google-Smtp-Source: APXvYqyyKiTE5Kcf31JBLChf9SiHCwJNFidm5OhW78pFeSv+LK+lz57ZMxL/ZNMyWswcs6KMmYlCwQ==
X-Received: by 2002:a65:6088:: with SMTP id t8mr8338302pgu.329.1578531645491;
        Wed, 08 Jan 2020 17:00:45 -0800 (PST)
Received: from [10.69.45.46] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a19sm486832pju.11.2020.01.08.17.00.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 17:00:45 -0800 (PST)
Subject: Re: [PATCH v2 02/32] elx: libefc_sli: SLI Descriptors and Queue
 entries
To:     Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org
Cc:     maier@linux.ibm.com, dwagner@suse.de, bvanassche@acm.org,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        James Smart <jsmart2021@gmail.com>
References: <20191220223723.26563-1-jsmart2021@gmail.com>
 <20191220223723.26563-3-jsmart2021@gmail.com>
 <af4ccd39-dab9-b2bf-f77c-954b1fe3725d@suse.de>
From:   James Smart <jsmart2021@gmail.com>
Message-ID: <52021d23-a65d-0c6a-8ea2-bb95c005ac45@gmail.com>
Date:   Wed, 8 Jan 2020 17:00:43 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <af4ccd39-dab9-b2bf-f77c-954b1fe3725d@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 1/7/2020 11:24 PM, Hannes Reinecke wrote:
> I am really not a big fan of anonymous enums, especially not if they are
> scoped for specific structures.
> Can you please avoid the use of anonymous enums, and name them according
> to the structure where they are indended to be used?
> Ideally the structure should reference named enums directly, but I do
> agree that this it not always possible or desired.
> But we should at least name them accordingly to give the developer a
> hint where these values are expected to occur.
> 
> Eg in the above case
> 
> enum sli4_sge_flags {
> 
> or similar would make the intended usage clearer.
> 

We will add names to the enums as suggested.

Thanks

-- james


