Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1D537334E
	for <lists+linux-scsi@lfdr.de>; Wed,  5 May 2021 02:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbhEEAsk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 May 2021 20:48:40 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:43846 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhEEAsj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 4 May 2021 20:48:39 -0400
Received: by mail-pg1-f169.google.com with SMTP id p12so548769pgj.10
        for <linux-scsi@vger.kernel.org>; Tue, 04 May 2021 17:47:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5cWPEC9o+CQdiW8wgmhHGIAiHRVpa6FtW/IRIbYs8CE=;
        b=NzwFEDK5a8daGfCanpxPZYtbEVTXkAa56w5m0t8y9niewd/+kL/uVuMkkbdgt5PxEQ
         Yq7iXntv6tfyRmHIdCir5zI5CyxEPD9QAcDuqeCqJTBODrD+IxgPCfzlyF1ebC4OJny1
         ny4q8dJx5G2+UELWZxLYeKu0BBffPR5tb0jVeWtmzMQWULa0B7TBUmACA6Trq/g1HvRE
         UIZroucuTPdTt5jJN53NwjM7uLyL/UBbysNDoJHlsLXhZuGgt8WnLVPhcUXSQCfPP13x
         /6X+OQaQiB7b1zk0dTqOxTh74pV7Ddlt9y3l6dWXQfhPjCK8HHi99u1imCPSGyZ+nPQy
         Kvow==
X-Gm-Message-State: AOAM532kHj/KR/Yz/isGh7c3G0KclMs7+HTR6xouxODrIoZ7YUj9Z+fi
        zKsGSnKiYIbKg/waQOGFs/psTM+5r1E=
X-Google-Smtp-Source: ABdhPJyFDT0ddyrqns4Cx5YzJC2DKYsqN0UuJwoweDbMcRxtC4J6RVm157mPr7XLzgJmAOGEHeuJgA==
X-Received: by 2002:a63:1111:: with SMTP id g17mr25641162pgl.267.1620175663466;
        Tue, 04 May 2021 17:47:43 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id o140sm13653858pfd.65.2021.05.04.17.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 17:47:42 -0700 (PDT)
Subject: Re: [PATCH 10/18] scsi: implement reserved command handling
To:     Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        John Garry <john.garry@huawei.com>, linux-scsi@vger.kernel.org
References: <20210503150333.130310-1-hare@suse.de>
 <20210503150333.130310-11-hare@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <583ea6ee-f8ce-7063-ca2a-409fee83a2b6@acm.org>
Date:   Tue, 4 May 2021 17:45:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210503150333.130310-11-hare@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/3/21 8:03 AM, Hannes Reinecke wrote:
>  struct scsi_cmnd *scsi_get_internal_cmd(struct scsi_device *sdev,
>  	unsigned int op, blk_mq_req_flags_t flags)
> @@ -2005,6 +2009,10 @@ struct scsi_cmnd *scsi_get_internal_cmd(struct scsi_device *sdev,
>  
>  	WARN_ON_ONCE(((op & REQ_OP_MASK) != REQ_OP_SCSI_IN) &&
>  		     ((op & REQ_OP_MASK) != REQ_OP_SCSI_OUT));
> +
> +	if (sdev->host->nr_reserved_cmds)
> +		flags |= BLK_MQ_REQ_RESERVED;
> +
>  	rq = blk_mq_alloc_request(sdev->request_queue, op, flags);
>  	if (IS_ERR(rq))
>  		return NULL;

Can the if-statement be removed such that scsi_get_internal_cmd() fails
if sdev->host->nr_reserved_cmds == 0? I'm concerned that otherwise it
will be very hard to determine which requests are internal and which
ones not from inside a blk_mq_tagset_busy_iter() callback.

Thanks,

Bart.
