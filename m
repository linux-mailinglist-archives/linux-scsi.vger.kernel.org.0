Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7EF77FB5A
	for <lists+linux-scsi@lfdr.de>; Fri,  2 Aug 2019 15:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389242AbfHBNlu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 2 Aug 2019 09:41:50 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46011 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfHBNlu (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 2 Aug 2019 09:41:50 -0400
Received: by mail-pl1-f193.google.com with SMTP id y8so33685032plr.12
        for <linux-scsi@vger.kernel.org>; Fri, 02 Aug 2019 06:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CLpGKKhV+pAipDrCxvuJR+bgr9MB+ODwBs4ZL25qD44=;
        b=1z+TV3bZ4ThYIA7yqtpRnVp/OMzzyekOKI83TgdS+9FWE4W+ULImDvvmoHFWkN7KaH
         xL7QNXBz7/nzYUqcEkb/qXwrkH5DUYjFWmKFPAcr+i2PHHtLf2YXn2UqO3RyLer7bOlW
         kYB7g+1Mj8a6ah6rb4urnTX1Sgn7koHw/Xkf/a2cURGwhsU4W1X7AMtTpCcc1Nsj/d91
         CPbg1Lry/9bSzzyS/SOhqnlWv92Sr/Zk5+JoWLKMYhcKr/hnUQfNU3wrU3MGx4RSSDtr
         E+GH0lqGEteRSikQ9tlCkIAXm0l+s2kA1lwQgGE6fqyK58+sZX60lG25v+XDgfcHkox3
         P3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CLpGKKhV+pAipDrCxvuJR+bgr9MB+ODwBs4ZL25qD44=;
        b=qSFdWhgEyK+hCL/tL4mEbIQxjGXtC8Wp4IWa35/H/N2PMmkcQRJNt18tn4t0fGOza+
         zKcTtF3ihXt0azAgeOYZ7sipCdsyDAWSpF6KtDYv8ax/w1z2GenQTUUB3JJJCx0QAbSO
         KUqia8dLEOVK0d4EWv8BD6GAHMNVEX/vwDCCpGpW5hnkDsDG+qhfJ67KcGthIkJlX7Ej
         3VO6SaPl6AaR4vJOSQYR1la/SKMBISwBcDt5VRoyHmo8jtFc/sKtClJySE45CeaPn3vH
         EIXCRW0/0y/nyHK9sFTwofk0TBACoFtvvJYJANuwtRWf2dDxLPQPHE0iuBrGYZo4EASy
         5fDg==
X-Gm-Message-State: APjAAAXKoCzNjvVb8SNEyjyiaUavr8gvnvIucDOn8nfS0pIYa77SzH10
        6eiGepW4mbHNt2tRzvSp1QU=
X-Google-Smtp-Source: APXvYqwmWU8zRWeL2GrMJdVmrrds6fgN1KxZDN6HlDXQZ49UE8aCFLQqGvUxsf9hnlMQZyvdvKoM/g==
X-Received: by 2002:a17:902:703:: with SMTP id 3mr7000829pli.77.1564753309889;
        Fri, 02 Aug 2019 06:41:49 -0700 (PDT)
Received: from [192.168.200.229] (rrcs-76-80-14-36.west.biz.rr.com. [76.80.14.36])
        by smtp.gmail.com with ESMTPSA id v185sm85547140pfb.14.2019.08.02.06.41.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 06:41:49 -0700 (PDT)
Subject: Re: [PATCH V2 0/4] block: introduce REQ_OP_ZONE_RESET_ALL
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     jejb@linux.ibm.com, dennis@kernel.org, hare@suse.com,
        damien.lemoal@wdc.com, sagi@grimberg.me, dennisszhou@gmail.com,
        jthumshirn@suse.de, osandov@fb.com, ming.lei@redhat.com,
        tj@kernel.org, bvanassche@acm.org, martin.petersen@oracle.com
References: <20190801172638.4060-1-chaitanya.kulkarni@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0c30519f-2829-ec2c-8fb4-ccddd2580321@kernel.dk>
Date:   Fri, 2 Aug 2019 07:41:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190801172638.4060-1-chaitanya.kulkarni@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 8/1/19 11:26 AM, Chaitanya Kulkarni wrote:
> Hi,
> 
> In current implementation Zoned block device issues one bio at a time
> based on the range of the offset and zones specified from userspace
> tools like blkzone. Worst case scenario it will issue N requests which
> are equal to the number of the zones when the application wants to
> reset the drive, e.g. mkfs.
> 
> Zone Block devices allow issuing zone reset all operation [1]
> which can essentially reset all the available zones with only one
> command.
> 
> This patch series introduces new REQ_OP_ZONE_RESET_ALL operation. Along
> with that, we also introduce QUEUE_FLAG_ZONE_RESETALL (and respective
> helpers) which is needed to be set by the low-level driver in order to
> enable the REQ_OP_ZONE_RESET_ALL.

Series looks fine to me.

Martin, I'd like someone to vet/review the SCSI side of it before I
apply it.

-- 
Jens Axboe

