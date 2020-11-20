Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50E82B9FD1
	for <lists+linux-scsi@lfdr.de>; Fri, 20 Nov 2020 02:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgKTBhH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 19 Nov 2020 20:37:07 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40580 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgKTBhH (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 19 Nov 2020 20:37:07 -0500
Received: by mail-pf1-f195.google.com with SMTP id w14so6307037pfd.7;
        Thu, 19 Nov 2020 17:37:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3k4Ege4hPbwtePFpIl8JBb2aUYC75ms6Y4XCyy0eV3k=;
        b=UzeB8+dtXgvtkgMBtSTfqxA+/ttyWvaT+aU0c4SBaulYYr801xhAoOnSLy5u9tFvpl
         RWVaUzAwUNBC09Sc2wM2E2N4DqWhLR9+eMbC33WwTIX/mHXRgD5wtkJXTJasNfC28jZ8
         WijvWaBDTRxrV++1lXOUWBcLw+34OjyDe0sscU3zikDaN3s02Bx/DwwYEgLR/jxBjLU0
         FD2YXVsv4nbG+6UrIrExKqfH5l1NjjumoKfBsV9K2G/wwHQRF9Ezf2nyUcZrc3IcTuxi
         DL2JU8+gn/3Yv0mm56WRayL7GoJDL9eUQPGmfphloEeXqKSlEgRnJ3Ge0bgmgPKG7QrC
         lOMw==
X-Gm-Message-State: AOAM5318iGM52gGr2kR1OK4mjouIQJmXlC5n8llf//Dblgfok/88i6g/
        BGmAbpHmq2QLdZQInn7piLg=
X-Google-Smtp-Source: ABdhPJw+zWeacVq6Zt0791qTiDwhg8NzKrYuwR4LlRUBs2yuWUe0Jmk+VbMSmQn5m1aZ1GTBP1bP2g==
X-Received: by 2002:a63:d547:: with SMTP id v7mr14718445pgi.375.1605836226485;
        Thu, 19 Nov 2020 17:37:06 -0800 (PST)
Received: from [192.168.3.218] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id ie21sm1150185pjb.14.2020.11.19.17.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 17:37:05 -0800 (PST)
Subject: Re: [PATCH v2 4/9] scsi: Rework scsi_mq_alloc_queue()
From:   Bart Van Assche <bvanassche@acm.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Can Guo <cang@codeaurora.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Ming Lei <ming.lei@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20201116030459.13963-1-bvanassche@acm.org>
 <20201116030459.13963-5-bvanassche@acm.org> <20201116171755.GD22007@lst.de>
 <cf82c6f3-698c-4dad-b123-fda710e0741e@acm.org>
Message-ID: <c2b8607a-c3e3-3e75-0727-41947a52caeb@acm.org>
Date:   Thu, 19 Nov 2020 17:36:59 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <cf82c6f3-698c-4dad-b123-fda710e0741e@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 11/16/20 10:01 AM, Bart Van Assche wrote:
> On 11/16/20 9:17 AM, Christoph Hellwig wrote:
>> On Sun, Nov 15, 2020 at 07:04:54PM -0800, Bart Van Assche wrote:
>>> Do not modify sdev->request_queue. Remove the sdev->request_queue
>>> assignment. That assignment is superfluous because scsi_mq_alloc_queue()
>>> only has one caller and that caller calls scsi_mq_alloc_queue() as
>>> follows:
>>>
>>>     sdev->request_queue = scsi_mq_alloc_queue(sdev);
>>
>> This looks ok to me.  But is there any good to keep scsi_mq_alloc_queue
>> around at all?  It is so trivial that it can be open coded in the
>> currently only caller, as well as a new one if added.
> 
> Hi Christoph,
> 
> A later patch in this series introduces a second call to
> scsi_mq_alloc_queue(). Do we really want to have multiple functions that
> set QUEUE_FLAG_SCSI_PASSTHROUGH? I'm concerned that if the logic for
> creating a SCSI queue would ever be changed that only the copy in the
> SCSI core would be updated but not the copy in the SPI code.

(replying to my own email)

Hi Christoph,

Is this something that you feel strongly about? I can make this change
but that would require reaching out again to someone who owns an SPI
setup for testing this patch series since I do not own an SPI setup
myself ...

Thanks,

Bart.
