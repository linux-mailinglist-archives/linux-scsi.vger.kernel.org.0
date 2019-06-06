Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 166FA37EEA
	for <lists+linux-scsi@lfdr.de>; Thu,  6 Jun 2019 22:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfFFUkr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 6 Jun 2019 16:40:47 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40561 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfFFUkr (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 6 Jun 2019 16:40:47 -0400
Received: by mail-pl1-f195.google.com with SMTP id a93so1378352pla.7
        for <linux-scsi@vger.kernel.org>; Thu, 06 Jun 2019 13:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GGcsaXwPpfBaw7F/tRMr/qeRuWI/bjpwIrse5ZxiGjU=;
        b=d4Pd+1P/VsWU6Bt7B0C71Nou4Mlluy3Ehy0JxDtdb+63uZNYLM1p5uvniuLTPE6ZIX
         lXg+csMcdtUUbr7HkjbbOUQaEpbFvH8cZUxx58aDjcFwracV6VKV5flTGuwuBciI+6VP
         udaf7pGZBf2hBKdxB2Cqi7qVVDhrZ/1/AREbtU6320d6iqFor381cd3nHMYrwbLawMm3
         XnmA3LHQvxg1hFZZfNtpOvgxK/b8KYLPMigCXZNvFdqWOsA7W+KG6gwB6F4upALmo8I/
         lSTDxnvoSFUotZlBgpj+aXFaNvqeepEFnQFXeONERg2ETSM3eP7c9BZow7rs6jVSBIwz
         5Ruw==
X-Gm-Message-State: APjAAAV6LQaUCwKn3RLkzw6osyHHuZloPbMfYXfocgsa/HP+6tgJGPtC
        tdtSnNnlTXmur/crUKiyavo=
X-Google-Smtp-Source: APXvYqxswPGMjYIWnCJzGaO59h+aNMALkiv+v4fwVQ+RWTyhK+0/P3OudHxbOCrb8BHV184+al1RcA==
X-Received: by 2002:a17:902:2926:: with SMTP id g35mr6477757plb.269.1559853646607;
        Thu, 06 Jun 2019 13:40:46 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id n70sm2498145pjb.4.2019.06.06.13.40.44
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 13:40:45 -0700 (PDT)
Subject: Re: [PATCH 2/3] scsi: Avoid that .queuecommand() gets called for a
 quiesced SCSI device
To:     Hannes Reinecke <hare@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20190605201435.233701-1-bvanassche@acm.org>
 <20190605201435.233701-3-bvanassche@acm.org>
 <c58b16b0-84ae-f82c-9beb-5afb8dbfb663@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <92eed484-bdd7-401a-5bf4-640984ae960a@acm.org>
Date:   Thu, 6 Jun 2019 13:40:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c58b16b0-84ae-f82c-9beb-5afb8dbfb663@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/5/19 10:50 PM, Hannes Reinecke wrote:
> On 6/5/19 10:14 PM, Bart Van Assche wrote:
>> Several SCSI transport and LLD drivers surround code that does not
>> tolerate concurrent calls of .queuecommand() with scsi_target_block() /
>> scsi_target_unblock(). These last two functions use
>> blk_mq_quiesce_queue() / blk_mq_unquiesce_queue() for scsi-mq request
>> queues to prevent concurrent .queuecommand() calls. However, that is
>> not sufficient to prevent .queuecommand() calls from scsi_send_eh_cmnd().
>> Hence surround the .queuecommand() call from the SCSI error handler with
>> code that avoids that .queuecommand() gets called in the quiesced state.
>>
>> Note: converting the .queuecommand() call in scsi_send_eh_cmnd() into
>> code that calls blk_get_request() + blk_execute_rq() is not an option
>> since scsi_send_eh_cmnd() must be able to make forward progress even
>> if all requests have been allocated.
>>
> Hmm. Have you actually observed this?
> Typically, scsi_target_block()/scsi_target_unblock() is called prior to
> invoking EH, to allow the system to settle and to guarantee that it's
> fully quiesced. Only then EH is started.
> Consequently, scsi_target_block()/scsi_target_unblock() really shouldn't
> be called during EH; we're essentially single-threaded at this point, so
> nothing else will be submitting command.
> Can you explain why you need this?

Hi Hannes,

As one can see in the commit message of patch 3/3, I have observed a 
.queuecommand() call by the SCSI EH causing a crash.

The SCSI EH and blocking of SCSI devices have different triggers:
- As one can see in scsi_times_out(), if a SCSI command times out and an 
abort has already been scheduled for that command then that command is 
handed over to the SCSI error handler. After all commands that are in 
progress have failed the error handler thread is woken up.
- The iSCSI and SRP transport drivers call scsi_target_block() if a 
transport layer error has been observed. This can happen from another 
thread than the SCSI error handler thread and these functions can be 
called either before or after the SCSI error handler thread has been 
woken up.

Bart.
