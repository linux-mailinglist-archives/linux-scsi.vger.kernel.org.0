Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82A912E57B
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 21:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfE2Tgd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 15:36:33 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39860 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfE2Tgd (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 15:36:33 -0400
Received: by mail-pf1-f194.google.com with SMTP id j2so2284277pfe.6
        for <linux-scsi@vger.kernel.org>; Wed, 29 May 2019 12:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CPPvwfx6v/W8TdfzG5VLVfW5R4GsuBAt3auJKn9Dc30=;
        b=nkQSuhUuBQQq+49Ohd7h+BcLfW49k8JunWpRc7+yXBBrqKYWKR4Ke4x52xWH1Vz9td
         uipVSNO00Z6l1w0cCc4p0dMNKDz5lihlaHy5IJi3ADImWRkZ4g0uv4rtHA2Ft3Dt/GUJ
         3DQY8aYUdgRRFbrzuufRZ5TZWHGvFQN4WUlYNwmwSTTKov3IbYyx/3qPBLPEcMZ0GLJT
         DFRrVzZVX+rxASuqmqkxS4HZvTZoTyp8FQ54e6PduGCTwPFaDbQuFtzdRaf432eT6fgW
         cMHKqDucWydRN18sMSJxGBv2GMmbqefq9GuwoCPZBc7NtLptmA7fgvkNhH3oSYcF3N+F
         SsQA==
X-Gm-Message-State: APjAAAVrXwO7xRlyD4iUOGHcrxNN9p3np8KLWOu/Tjjjynds1Xm1VwXu
        tDnJf5Htdx2J/nHjjoznwlo=
X-Google-Smtp-Source: APXvYqzH7FkC6Trtv4sSCaYVsVhJtjrLkVKYPD5tpDPCQLfpOVhfADpyA3qqvhZnLY0XLzxQ3GZtZw==
X-Received: by 2002:a65:44cb:: with SMTP id g11mr138949651pgs.193.1559158592171;
        Wed, 29 May 2019 12:36:32 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id t11sm204915pgp.1.2019.05.29.12.36.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 12:36:30 -0700 (PDT)
Subject: Re: [PATCH 11/24] scsi: add scsi_host_get_reserved_cmd()
To:     Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
References: <20190529132901.27645-1-hare@suse.de>
 <20190529132901.27645-12-hare@suse.de>
 <25a5a8f5-324b-6b7c-71eb-6cb9f9a60ba8@acm.org>
 <0af75234-7470-acb8-c7ac-10ebaa1e3321@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <0dcf29df-c4c9-0d1c-cd88-972888cd644d@acm.org>
Date:   Wed, 29 May 2019 12:36:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0af75234-7470-acb8-c7ac-10ebaa1e3321@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/29/19 10:38 AM, Hannes Reinecke wrote:
> On 5/29/19 5:19 PM, Bart Van Assche wrote:
>> On 5/29/19 6:28 AM, Hannes Reinecke wrote:
>>> +    rq = blk_mq_alloc_request(shost->reserved_cmd_q,
>>> +                  REQ_OP_DRV_OUT | REQ_NOWAIT,
>>> +                  BLK_MQ_REQ_RESERVED);
>>
>> Is your purpose to avoid that blk_mq_alloc_request() waits? If so, why 
>> do you want to avoid that?
>>
> Typically these commands are intended for internal purposes, so there 
> should always be enough commands free to allow direct allocation.
> If not we're in an error condition, and we need to return so as not to 
> lock up the driver (as it might rely on this command to make forward 
> progress).

That sounds like a risky strategy to me. blk_mq_alloc_request() can 
block for a number of reasons, e.g. because a request queue due to e.g. 
CPU hotplugging. I don't think that you want 
scsi_host_get_reserved_cmd() or scsi_get_reserved_cmd() to fail if a 
request queue is frozen.

Bart.

