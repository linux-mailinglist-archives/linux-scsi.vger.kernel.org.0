Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6034150FB6
	for <lists+linux-scsi@lfdr.de>; Mon, 24 Jun 2019 17:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbfFXPIJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 Jun 2019 11:08:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45139 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbfFXPII (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 24 Jun 2019 11:08:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id z19so4318860pgl.12
        for <linux-scsi@vger.kernel.org>; Mon, 24 Jun 2019 08:08:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=//+yb1s+2WCzorVKt4krr3UA/67QO+7fwRSikEv9loA=;
        b=Mu9VZCXySXtdfCGlcT64c8Wqk8Ns9kGbQgiC8JHqjp1PoF4VDK+RYQwuKGUhFAPK2t
         f/WYzg0F7p/xSSVZDr+in0bC6lVuuZZl5R/MH8Z2+YvwjmCcTVzBV/egyZHvYvhJsxfM
         nmj0GER3PSo8smStULjHlmMJeBO7Mx9WAqhvqyzNgD3T/7j5ZCC93v/TV7jIN9PylCiQ
         RxyGgs8C0+dKIKFwAwyMwurtaQAMeO/lMznAbAWwzui1edXzZSobjiBpFgyNebPqYzN4
         nUUSj+6Iq93b/gz/pccj3QiL9U+fopkzaooIlftxuTAZ2k399nIq7D/rJ2h7iN8+c8eY
         Zqmw==
X-Gm-Message-State: APjAAAWmTHNo7Dtee3JrtDtWC7EBkjzjpo5JZ/9+Jpy6abHqltO/zzQ1
        pLGIUegat7iDEsEfO1ifvKtvgVCL
X-Google-Smtp-Source: APXvYqzgY/9jV738A6n7/KIvlmhbTwtoKitUOF8Oj/m4//RrMibRciye4zJ/SmD0MuWqKOqyo9n8Ug==
X-Received: by 2002:a17:90a:9b8a:: with SMTP id g10mr24937297pjp.66.1561388887912;
        Mon, 24 Jun 2019 08:08:07 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id h12sm25430176pje.12.2019.06.24.08.08.06
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 08:08:07 -0700 (PDT)
Subject: Re: [PATCH] sd_zbc: Fix report zones buffer allocation
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>
References: <20190620034812.3254-1-damien.lemoal@wdc.com>
 <b6f250ad-0473-4643-8611-e395295e0379@acm.org>
 <BN8PR04MB58120578F3032EC46017CBF6E7E60@BN8PR04MB5812.namprd04.prod.outlook.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <5a37d32e-0699-0e7f-836c-d58734f21816@acm.org>
Date:   Mon, 24 Jun 2019 08:08:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <BN8PR04MB58120578F3032EC46017CBF6E7E60@BN8PR04MB5812.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/22/19 12:44 AM, Damien Le Moal wrote:
> I have a fix along the lines you suggested, but since it modifies
> bio_rq_map_kern(), I would rather not push that as a bug fix this late in RC.
> Would you agree to accept the fix patch as is for now and I will send the more
> complete fix for 5.3 ? Note that this more complete fix also reworks the similar
> memory allocation for the struct blk_zone array used for zone revalidation. Put
> all together, the use of report zones uses only vmalloc-ed buffers and data
> structures, reduces pressure on the memory system and reducing chances of failures.

Hi Damien,

I think it's up to Martin to decide how to proceed.

Bart.
