Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A64152FE9
	for <lists+linux-scsi@lfdr.de>; Tue, 25 Jun 2019 12:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfFYKc2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 25 Jun 2019 06:32:28 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41539 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfFYKc2 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 25 Jun 2019 06:32:28 -0400
Received: by mail-lf1-f67.google.com with SMTP id 136so12252018lfa.8
        for <linux-scsi@vger.kernel.org>; Tue, 25 Jun 2019 03:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A7lYOmGKBkEXMqKZhONBq/XEaw9Zk9p1Ct3xBmeHS1o=;
        b=g4myPHik/VDVtLYpxVZL5RmDDlI748sNxEFtnxOyRqNQdNghngq96pMu24m6LN4TWz
         GonPpoTK5itnyXQQyE83fhudsB690BoHPguK4Lwx5RXl27eKbV+MeR76wLmrRnxb2y4x
         uV1Z52olMUY95shBxscd0ndg3Il8MB9Tm0mU/CY4lBWvA4EQMYZ5cRyiJ7tkY/CekrtW
         AwqyWRnOilwi85lJcX5SQe2EE8h44SvQ+ffNpyt5G1VfPbTco3XQLlOArMc1BU87OYP3
         2bZvaAPuKqcN8V4Ivv5uTZJ1wQyEoniDqYNwbkfkXLpg2IXhOR9Rja/D39MIOKpiLOnr
         ljCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A7lYOmGKBkEXMqKZhONBq/XEaw9Zk9p1Ct3xBmeHS1o=;
        b=dv4DJxzUrbhSYY0/gkIy0Mpq0RbsMLB0/uE0dU8fV8TYg60E9nGS8NTs3ZsoLVWtfq
         gQF1dTJLXbXQ2tdnGeqtAjAoLgq425fvn3tkR90s9BeS44324F5fZVXpTT02Ycq6eDzL
         SI2HWuQIR2Fd1e+PzAs1PBlT1LDTWuY17Wx8DKYeCaLJNkMR7q5ibCSLx9lQgdS7+yJV
         IL1YhAykULj39muLxb64OJEGODMb1P7ZPaVD42uMN2Z0hhQz7GleOmolFuMtzigHbfjK
         pFCTKgY36jO7TaREqJs8gW8LtPzfqBrSvzzJrJHKNDPtex51WYrf26Q7l9aWfKN+/Ell
         i27g==
X-Gm-Message-State: APjAAAVLXrkv4/xdwnJRcuRm9fD0kp9xq2tVdzIkT8L82DrKry+vZCfr
        uokb6mcI5PtOnVeHwHMYPFTDSQ==
X-Google-Smtp-Source: APXvYqzBmDbBn4uaSRgOejv0dCMXCDPGoGCJEE71DIMwwmCQk8qQYYktGIfIGht24KxyuAfH1v5KOw==
X-Received: by 2002:ac2:5609:: with SMTP id v9mr21659830lfd.27.1561458746106;
        Tue, 25 Jun 2019 03:32:26 -0700 (PDT)
Received: from [192.168.0.36] (2-111-91-225-cable.dk.customer.tdc.net. [2.111.91.225])
        by smtp.googlemail.com with ESMTPSA id d15sm1867200lfq.76.2019.06.25.03.32.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 03:32:25 -0700 (PDT)
Subject: Re: [PATCH 3/4] scsi: sd_zbc: add zone open, close, and finish
 support
To:     Bart Van Assche <bvanassche@acm.org>, axboe@fb.com, hch@lst.de,
        damien.lemoal@wdc.com, chaitanya.kulkarni@wdc.com,
        dmitry.fomichev@wdc.com, ajay.joshi@wdc.com,
        aravind.ramesh@wdc.com, martin.petersen@oracle.com,
        James.Bottomley@HansenPartnership.com, agk@redhat.com,
        snitzer@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com
References: <20190621130711.21986-1-mb@lightnvm.io>
 <20190621130711.21986-4-mb@lightnvm.io>
 <db952c97-b5c9-9276-ea51-c14064c5a093@acm.org>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <62457020-b543-e08d-54fe-e8dc92d94e47@lightnvm.io>
Date:   Tue, 25 Jun 2019 12:32:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <db952c97-b5c9-9276-ea51-c14064c5a093@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/24/19 9:46 PM, Bart Van Assche wrote:
> On 6/21/19 6:07 AM, Matias Bjørling wrote:
>> + * @op: Operation to be performed
> 
> This description could be more clear.
> 
> Thanks,
> 
> Bart.

Thanks Bart. I'll update it.
