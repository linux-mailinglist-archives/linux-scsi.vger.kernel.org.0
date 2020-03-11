Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98CEB1818EC
	for <lists+linux-scsi@lfdr.de>; Wed, 11 Mar 2020 13:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgCKM6q (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 11 Mar 2020 08:58:46 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33325 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729473AbgCKM6o (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 11 Mar 2020 08:58:44 -0400
Received: by mail-io1-f65.google.com with SMTP id r15so1801724iog.0
        for <linux-scsi@vger.kernel.org>; Wed, 11 Mar 2020 05:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pXMGtTgQX/vG6YdfwMEutnSxHcYYkuMTZjUufEEkwrs=;
        b=0RdqNJ64RPB/YwilvK1FgfDcZgni+Z2YUWUBcLwScASQbGBbB9Dz+LE4Mm35IFt6vr
         4cSxKXzulAxx/FMhBjxo7H6LFUFR8GPqsvxXNjSRUPuzvFkJ4jv1PyVkcJG+rzbCC2Np
         QluikAk9mzDbEMQsnqi+vhGhm69SUbxzK8wbFD8zbHl+VIITIdrwzXk7cwoU57h6DYTK
         xP/B6p8lJjmkYSUT2EEde9KDBifsOxQlJzU6xNbSL1nZM0pl98Obd5V+EG9SnWmey6tz
         SPlj8XfxaXHr4JqefQegQiSZa1hJYMurvTPgBuMJ9xU7xwGx1tFUNwEPiNDvzHAuPBK6
         0h/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pXMGtTgQX/vG6YdfwMEutnSxHcYYkuMTZjUufEEkwrs=;
        b=tBijf7GQkeSwcdr9XcwW42Ftg9yGBNnVruAOutbHKk1BD5TwvIkjCGRH2uAemEYxPN
         s4lwpnpTGN8NHJjCjzfBGHsled5cclTlDyvykgPx1UfqrlXloBqYhhd/zCdirt8q3tSx
         PopiPO/vgAVMuCamqgdbZicJhO3r5cnSLe63X6eRb7dQUCpL5NlQYdfueum1W29gekZg
         qHt8JmYnddBzOIglPl4qQmTx1xVytjMqU/TkIbFZIC/VT3AF8gkAvNB4FLqqvt0c8o3c
         YhbG1Y4XW56gdiwkSnMjVH+yLSMeUQ7qWCG2jskLCpuDljVw3FH5ryQWYy1/fLwId0+Y
         hzAw==
X-Gm-Message-State: ANhLgQ1uxaNoNoEL396C9xwL4NFX0tZSACuqw8hJn835X1EkOtsyA0/p
        BHVbJrSPRE4tZG4BTf3RX5nEQQ==
X-Google-Smtp-Source: ADFU+vvQvrqamJpOiZ/PrfYXGY85lIbp+WER5L+9cjMJPMlJO1Ap5yHyqeha4+2wZHF6gubxcVHRhQ==
X-Received: by 2002:a02:6658:: with SMTP id l24mr1450719jaf.33.1583931522194;
        Wed, 11 Mar 2020 05:58:42 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id p79sm17821112ill.66.2020.03.11.05.58.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 05:58:41 -0700 (PDT)
Subject: Re: [PATCH v3] block: refactor duplicated macros
To:     Matteo Croce <mcroce@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mmc@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-scsi@vger.kernel.org, linux-nfs@vger.kernel.org
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Song Liu <song@kernel.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
References: <20200311002254.121365-1-mcroce@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7e03d359-f199-29d8-a75f-20c4b7ff3031@kernel.dk>
Date:   Wed, 11 Mar 2020 06:58:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200311002254.121365-1-mcroce@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 3/10/20 6:22 PM, Matteo Croce wrote:
> The macros PAGE_SECTORS, PAGE_SECTORS_SHIFT and SECTOR_MASK are defined
> several times in different flavours across the whole tree.
> Define them just once in a common header.
> 
> While at it, replace replace "PAGE_SHIFT - 9" with "PAGE_SECTORS_SHIFT" too
> and rename SECTOR_MASK to PAGE_SECTORS_MASK.

Applied, thanks.

-- 
Jens Axboe

