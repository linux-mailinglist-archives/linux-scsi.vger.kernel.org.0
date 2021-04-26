Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544D436AB3F
	for <lists+linux-scsi@lfdr.de>; Mon, 26 Apr 2021 05:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbhDZDtj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 25 Apr 2021 23:49:39 -0400
Received: from mail-pj1-f44.google.com ([209.85.216.44]:56279 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbhDZDti (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 25 Apr 2021 23:49:38 -0400
Received: by mail-pj1-f44.google.com with SMTP id s14so21341733pjl.5
        for <linux-scsi@vger.kernel.org>; Sun, 25 Apr 2021 20:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ms72d9MVOeAEJQAK/BrVUmi2vCOzvZMJr92vJ5NTjnU=;
        b=buBqnU1hcdc7BfRm5zKW4WLDkmjuxMiLVmGblKDL+YuIhzWUycvxkudpBUCovxY6yk
         DtxelkU72sRtJIDosCzWbMIhSPeDyDs4qAlbhSpDz2PUFvvY9/qbdRyd9sk5rWzJqzIY
         PLJE5I//g1OMw3gbzrrq3+y2Z/Gb8mnAO2OEIm4O0Ewkorg+deZxSLRfKsbtSFgKUZRQ
         iRZ6cl78AtWh997RsIRrdSI9XV45mapSc4d19Gmnqnj9kLF1TVBHZYPQ3gpBVDYuJ4YA
         lHtF8DcDiEqwfTuwpb8Nu5l+DQId9Hhbi2vuQXhv+sPv8CJqOZUlr8yidMjM0SQ1nea4
         8x6A==
X-Gm-Message-State: AOAM5301OXTpW/1k7Mqn71aLta4LfI9EkGMiljoam3/tpeS/Q9UN6m5C
        /wDcqOfT9w0zfW9+u7sIJIj0Y7womFq8Gg==
X-Google-Smtp-Source: ABdhPJzMtEzssSnMd3ZpI9HkQKJKwjf+1zWLLA6GBcduAjNN0lgSEsT7ysC3aBNHUxQSwDrRVAWYIQ==
X-Received: by 2002:a17:90a:ea92:: with SMTP id h18mr8943108pjz.105.1619408937522;
        Sun, 25 Apr 2021 20:48:57 -0700 (PDT)
Received: from [192.168.3.219] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id p126sm10035838pga.86.2021.04.25.20.48.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Apr 2021 20:48:56 -0700 (PDT)
Subject: Re: [PATCH 36/39] scsi: drop message byte helper
To:     Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
References: <20210423113944.42672-1-hare@suse.de>
 <20210423113944.42672-37-hare@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <4303e45c-4dae-e11f-2f84-2e0c6a61eb56@acm.org>
Date:   Sun, 25 Apr 2021 20:48:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210423113944.42672-37-hare@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 4/23/21 4:39 AM, Hannes Reinecke wrote:
> The message byte is now unused, so we can drop the helper to set
> the message byte and the check for message bytes during error recovery.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
