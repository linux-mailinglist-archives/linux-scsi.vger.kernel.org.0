Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80F8C7FC46
	for <lists+linux-scsi@lfdr.de>; Fri,  2 Aug 2019 16:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394953AbfHBOch (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 2 Aug 2019 10:32:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43298 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394950AbfHBOcg (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 2 Aug 2019 10:32:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id r26so211228pgl.10
        for <linux-scsi@vger.kernel.org>; Fri, 02 Aug 2019 07:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A27eyn7fv8+87QCGwvjGeuh58DzMZREuqk7dBBhRC7M=;
        b=k6b4D+oAskRKA2IOhSIr4jtOxHHPieA4fsfMXbUnhPbSeiIya5KycFpVIXPlm4yRM3
         2vXqNEv6x7AHEZRhkK0u7jqibHROFQ537Z8xwo0obqs9uLv5mWVXCmIAUFfxGD45IKDs
         C8/HhWky+gos9UjoGJLY2E78qMasSIXew/dwFeK2f++LqWZ/G5bjoOwPy0EtVt9OenSl
         ME6WU5E8NUui98Xbx+IsIYaoPGpbJWalf1R1MYfrtslWaM8qdRMnrp3aTSaN5c5tpbkX
         kCXIf6j9oyR64ldOISFeBUl8qlg4QaAUgeZG68GJ9F8eVjNUlO0pg2yBHNt97Fj7DBw6
         P4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A27eyn7fv8+87QCGwvjGeuh58DzMZREuqk7dBBhRC7M=;
        b=nM4kcOo/fKLQeLDUAqOLGTsjzVz8tsI/Z//sjA6jUXXwEP9xn0P9pmfhxgxueghZgj
         TSjB5mWxqpUjsPPWwecw6k/HyH6UtJQmfl92BctPp9ukGRDUSm5IZt9TKFtF0xjo4pnR
         Xd905IY7S2dg64HdJLb49UQhXxbYCBQqLQ/u4PnBrPvUBnMtJRFSO7Fmi5KHiNf72ZjB
         FuVo5PHrdeJHpDhW7dJ9bYprMdLWoOBFgH1uw5oNf/wjRtlCjzT3oLcOl1kQ5xebrznV
         +M6SytlDV0mdvwU1WFuGkPS9ORO10XGZvk9qMlI97vLA21hJTZ9DSSFh8pIQshP88vFz
         rqhA==
X-Gm-Message-State: APjAAAW3BoRsyEb7wzALbTMrlDzjBtsSjoG06JiW0a/vgE42rnn5J9qf
        yt7nlul0sphnMXE1ykZiw9Y=
X-Google-Smtp-Source: APXvYqz/GeqeGCtVNZutn4ZyH/Uwt3zoVVgkPPZcSDyGdG47OrHBP/uyvRRqJ0ygnyfCyfMeKDHdEQ==
X-Received: by 2002:aa7:9197:: with SMTP id x23mr59494402pfa.95.1564756356024;
        Fri, 02 Aug 2019 07:32:36 -0700 (PDT)
Received: from [192.168.200.229] (rrcs-76-80-14-36.west.biz.rr.com. [76.80.14.36])
        by smtp.gmail.com with ESMTPSA id m6sm75804562pfb.151.2019.08.02.07.32.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 07:32:35 -0700 (PDT)
Subject: Re: [PATCH V2 0/4] block: introduce REQ_OP_ZONE_RESET_ALL
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        jejb@linux.ibm.com, dennis@kernel.org, hare@suse.com,
        damien.lemoal@wdc.com, sagi@grimberg.me, dennisszhou@gmail.com,
        jthumshirn@suse.de, osandov@fb.com, ming.lei@redhat.com,
        tj@kernel.org, bvanassche@acm.org
References: <20190801172638.4060-1-chaitanya.kulkarni@wdc.com>
 <0c30519f-2829-ec2c-8fb4-ccddd2580321@kernel.dk> <yq1r263irfa.fsf@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a471e444-0cdc-b1a9-2870-bf12d8e39da1@kernel.dk>
Date:   Fri, 2 Aug 2019 08:32:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <yq1r263irfa.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 8/2/19 8:16 AM, Martin K. Petersen wrote:
> 
> Jens,
> 
>> Martin, I'd like someone to vet/review the SCSI side of it before I
>> apply it.
> 
> Looks good to me.

Great thanks, applied with your acked-by.

-- 
Jens Axboe

