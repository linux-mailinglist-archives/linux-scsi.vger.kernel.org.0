Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4D93A1DDD
	for <lists+linux-scsi@lfdr.de>; Wed,  9 Jun 2021 21:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhFIT51 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 9 Jun 2021 15:57:27 -0400
Received: from mail-pg1-f173.google.com ([209.85.215.173]:37416 "EHLO
        mail-pg1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhFIT50 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 9 Jun 2021 15:57:26 -0400
Received: by mail-pg1-f173.google.com with SMTP id t9so20526293pgn.4
        for <linux-scsi@vger.kernel.org>; Wed, 09 Jun 2021 12:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uAFfxbLfxm60bFinc05zQINNY0mDCnQVImHzBkp3Vvw=;
        b=Kzi9rtG0fGDd18LrnA1FnJUxdreQByeVEGjrf0EUheZvtwwehEQB0vuteccokn4rvl
         9lQx8lMn1d0efahNKeWG/3v/irjCuXNrEJqelZQF9s70RRj+2L+osVfNwMpAEUf6lsjN
         5yB/RZEstfbC+ml5uhv7hcnWUu3F+cEFpswGzBYaTsnN67I54C9G8RKJu45CEKTIReog
         U01X+fIXRd+pFgm1ELQ1U1+H3m7bk/OfLNh3gjF0Kj5EC6f4WjI6Y+iCPuNMESmdPAmL
         oSnlZ/I4qU3X8x9G3omccSZcu1CVDs8xgPn6nOv8TOY3y2Sc7jjaT1vkXaVQYTvWVBCD
         xcCg==
X-Gm-Message-State: AOAM531G1gIQFRa/3yAKX6wHcPTcPcR7qE5B5frVoeKQYvYQvc0nlbsH
        dUPx1SOR6Vsy1kv4Zy3CnV48I0iwV1M=
X-Google-Smtp-Source: ABdhPJxqFhcKOXf09xege8440wx1F1fddUh8XhhGWdsk2JBYWifN47rfEJN3MAAa987KcDYV0CLmew==
X-Received: by 2002:a63:145a:: with SMTP id 26mr1303388pgu.324.1623268531095;
        Wed, 09 Jun 2021 12:55:31 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id x28sm317743pff.201.2021.06.09.12.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 12:55:30 -0700 (PDT)
Subject: Re: [PATCH 08/15] scsi: scsi_debug: Remove dump_sector()
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
References: <20210609033929.3815-1-martin.petersen@oracle.com>
 <20210609033929.3815-9-martin.petersen@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a873d05e-7aa6-c1fe-abd8-af0e0c7bdf3c@acm.org>
Date:   Wed, 9 Jun 2021 12:55:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210609033929.3815-9-martin.petersen@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/8/21 8:39 PM, Martin K. Petersen wrote:
> The function used to dump sectors containing protection information
> errors was useful during initial development over a decade ago.
> However, dump_sector() substantially slows down the system during
> testing due to writing an entire sector's worth of data to syslog on
> every error.
> 
> We now log plenty of information about the nature of detected
> protection information errors throughout the stack. Dumping the entire
> contents of an offending sector is no longer needed.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
