Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD75D35265
	for <lists+linux-scsi@lfdr.de>; Tue,  4 Jun 2019 23:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfFDV6i (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Jun 2019 17:58:38 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37706 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfFDV6i (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 4 Jun 2019 17:58:38 -0400
Received: by mail-pf1-f195.google.com with SMTP id a23so13524805pff.4
        for <linux-scsi@vger.kernel.org>; Tue, 04 Jun 2019 14:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nc9pqLCeMEwy7/OPrqQGE5/SosiUnhOAX1cE88jmoYw=;
        b=N02XrVUi14JW/bY8Vx1jcEnkU55Ddd6ggmd5b7BVy0JQUVdsSZreFs8epsaHN9PCOJ
         jfHSJVog7CitZ9ODDwWlak2oyu1AfXAvpjtjmA+RRw9g8S1/NKXjD8FSnJdQI4eeK7R2
         VN9u2eGgFavVv0cb1qTqISe7Y+7AHQp/v7rYahql4WrUiemnI66Vm+vcY/8Qj62DrF47
         F7ufDlha90SQOcglfT9v+fbCIe+r3OUdWSyABwNwKLq4stG0PrZuV5tBryt1C95oMuDv
         XV1yu9a5/ICba4xftCoJVWwVcXNTnlDf3UJcL1I/PY2r2TYWI6kmj2/ktXeGN5d+9Gtj
         BMiQ==
X-Gm-Message-State: APjAAAUxJCbJH+owQhSTYKY+mwuSTff+U4tiMMWwTAXPr2zoNkvaZy7V
        RMrOyE0MV0DQB+Cv5Oyxv46zCyGw
X-Google-Smtp-Source: APXvYqxmWxZJYTkylARsVbUNIZg3RqFjgt28/O/W4tNj+7NeA2XEp05OG39zasHPxRCQsj5OwLVxjw==
X-Received: by 2002:a63:ec42:: with SMTP id r2mr79676pgj.262.1559685517359;
        Tue, 04 Jun 2019 14:58:37 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id a12sm21370088pje.3.2019.06.04.14.58.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 14:58:36 -0700 (PDT)
Subject: Re: [PATCH 00/19] sg: v4 interface, rq sharing + multiple rqs
To:     dgilbert@interlog.com, linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        bart.vanassche@wdc.com
References: <20190524184809.25121-1-dgilbert@interlog.com>
 <038d4781-1762-d7f6-199d-2f4702e746f6@acm.org>
 <4bebc171-55b9-5c41-0a7e-51db22473a03@interlog.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <39942bf0-7b17-0aa4-57b6-1def358e2cd0@acm.org>
Date:   Tue, 4 Jun 2019 14:58:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4bebc171-55b9-5c41-0a7e-51db22473a03@interlog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/4/19 2:31 PM, Douglas Gilbert wrote:
> Then there is the case of a driver maintainer
> who wants to clean up code that has "rusted" over time, including
> being weakened by hundreds of well-meaning but silly janitor type
> patches. Should a maintainer be discouraged from doing that?

I think in this case the answer to that question is "yes, definitely".
Multiple companies, including my employer, use the SG I/O interface as 
the primary interface for controlling SMR drives. Any regression in the 
SG I/O code will have severe consequences for users of SMR drives. As 
you know a rewrite can introduce regressions. Since the current 
implementation works fine I think it is up to you to find a way to 
motivate existing SG I/O users to adopt your new implementation. The 
cloud companies I know employ kernel developers and test new kernel 
versions before deploying these internally. How are you going to 
motivate these companies to adopt your rewrite instead of combining e.g. 
the Linux kernel v5.1 SG I/O implementation with the latest version of 
the Linux kernel?

> To date I have had no feedback about design document describing this
> patchset:
>      http://sg.danny.cz/sg/sg_v40.html
> even though I refer to sections of it in about half of the patches
> in this patchset. Plus I have written extensive test code and made
> it available; again no feedback on that.

It is great that you took the time to write a design document. I can't 
speak for other kernel developers. But if I see a URL myself in a cover 
letter of a patch series or in a commit message I ignore it. If you want 
feedback on that design document please convert it into a documentation 
patch and include it in this patch series.

Thanks,

Bart.
