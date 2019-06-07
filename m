Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35D2A38ED8
	for <lists+linux-scsi@lfdr.de>; Fri,  7 Jun 2019 17:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbfFGPVt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 7 Jun 2019 11:21:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38744 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728665AbfFGPVt (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 7 Jun 2019 11:21:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id v11so1341596pgl.5
        for <linux-scsi@vger.kernel.org>; Fri, 07 Jun 2019 08:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vcqjrIlKG3WpJrwi3J5yBTkwovO7P2uVk3vciSUdH6w=;
        b=U3j52tAkYaEavkSuyyUGPQszoJvlOqP9M7tDaJZ0vA9PVO80NQzA9XsCfzJtrrfaS8
         8hyZlbx3hE/4EVl6iLDl7LeMdB50KiXDQgggo3jpNXi4j5hgs2mv1XzWhoiNC0/nt/sA
         uQ8OiiL7HKWv29Vr2FRcUZt0vXK5Fz8gko8dc4YMVtHyNW+Q/WDhZtfkHZiZCsSGdqBk
         gGCTfbANTqWkT3+aYiTmJH31mMtkJpjaMHuvnIALon5yzBkZ7LkX+3J1YZXwOzljK5F5
         4zdUGG3+lCkEwHuafFlzU1Lykv2kJ9U68t7of1QK4u++coI41LSFYkrcDHfskby1qUtV
         xOjw==
X-Gm-Message-State: APjAAAUTVqyM9Y3dSW0cd+TIi3JN2/S68zDHBe4+F+bO0kvslb/UUk4y
        miWrZ9vqoy71Y9cZutqs0sY=
X-Google-Smtp-Source: APXvYqxxvp7OHZmz1nP5lcYXkbeII8Svz3GpDWdQDQ2DsbS0UgWRgR2ktyGUYjs7Llvys3dZfNzpDg==
X-Received: by 2002:a62:648d:: with SMTP id y135mr50390524pfb.98.1559920908549;
        Fri, 07 Jun 2019 08:21:48 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id d35sm192447pgm.31.2019.06.07.08.21.47
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 08:21:47 -0700 (PDT)
Subject: Re: [PATCH 2/3] scsi: Avoid that .queuecommand() gets called for a
 quiesced SCSI device
To:     Hannes Reinecke <hare@suse.com>, Hannes Reinecke <hare@suse.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20190605201435.233701-1-bvanassche@acm.org>
 <20190605201435.233701-3-bvanassche@acm.org>
 <c58b16b0-84ae-f82c-9beb-5afb8dbfb663@suse.de>
 <92eed484-bdd7-401a-5bf4-640984ae960a@acm.org>
 <e0d70594-270b-5fcf-759e-1c0a2a6b8a13@suse.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <6a6fc958-d534-a50c-59e8-b95ba415a76e@acm.org>
Date:   Fri, 7 Jun 2019 08:21:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e0d70594-270b-5fcf-759e-1c0a2a6b8a13@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/7/19 5:49 AM, Hannes Reinecke wrote:
> On 6/6/19 10:40 PM, Bart Van Assche wrote:
>> As one can see in the commit message of patch 3/3, I have observed a
>> .queuecommand() call by the SCSI EH causing a crash.
>>
>> The SCSI EH and blocking of SCSI devices have different triggers:
>> - As one can see in scsi_times_out(), if a SCSI command times out and an
>> abort has already been scheduled for that command then that command is
>> handed over to the SCSI error handler. After all commands that are in
>> progress have failed the error handler thread is woken up.
>> - The iSCSI and SRP transport drivers call scsi_target_block() if a
>> transport layer error has been observed. This can happen from another
>> thread than the SCSI error handler thread and these functions can be
>> called either before or after the SCSI error handler thread has been
>> woken up.
>>
> But then I'd rather not quiesce the queue in these circumstances, like
> in this (untested) patch:
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index 34eaef631064..e0bdde025d1a 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -2641,8 +2641,17 @@ static int scsi_internal_device_block(struct
> scsi_device *sdev)
> 
>          mutex_lock(&sdev->state_mutex);
>          err = scsi_internal_device_block_nowait(sdev);
> -       if (err == 0)
> -               blk_mq_quiesce_queue(q);
> +       if (err == 0) {
> +               unsigned long flags;
> +
> +               spin_lock_irqsave(sdev->host->host_lock, flags);
> +               if (sdev->host->shost_state != SHOST_RECOVERY &&
> +                   sdev->host->shost_state != SHOST_CANCEL_RECOVERY) {
> +                       spin_unlock_irqrestore(sdev->host->host_lock,
> flags);
> +                       blk_mq_quiesce_queue(q);
> +               } else
> +                       spin_unlock_irqrestore(sdev->host->host_lock,
> flags);
> +       }
>          mutex_unlock(&sdev->state_mutex);
> 
>          return err;
  A significant disadvantage of the above patch is that it makes it less 
likely that error handling will succeed. If the error handler is 
activated before the transport recovery code is activated, I think that 
transport recovery should really happen. The above patch makes it less 
likely that the SCSI error handler will succeed.

Additionally, scsi_target_block() ignores the value returned by 
scsi_internal_device_block() and it is nontrivial to make some of the 
scsi_target_block() callers handle scsi_target_block() failures.

Bart.
