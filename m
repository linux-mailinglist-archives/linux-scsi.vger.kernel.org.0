Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D05F2E0E3
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 17:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfE2PTd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 11:19:33 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38641 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfE2PTd (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 11:19:33 -0400
Received: by mail-pf1-f194.google.com with SMTP id a186so1145783pfa.5
        for <linux-scsi@vger.kernel.org>; Wed, 29 May 2019 08:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ScNtJ/bNo4csi9qJltk7yXmpocdvaVwg6jgwsccOh6Y=;
        b=Gsyhmm8lCU2ImJGbp2RUxPd12UMq/kxPVf8+mpBPC6lJuPExHvgNordcz1LM7eoFNK
         3SjrxEqcOlCdZ1FHMds6jazsYsRIRPS7rzFH2rqaDdnW0/9OUJWJL85HTbBah4c5WS6n
         GDPDlZuCKLHjHGqz9Hf0sU7bbDoQa3S2kkvSklrM3ZpvfSSxtdu2S1trGzJDuVl9ZGLo
         iJy2DHNQ33T5Rnl4CX4xd29hkZnGXzxMBy7uUu61pfw6pafU8m95YaevuVw98NaC9/RK
         YHSdkY+NtlNKPksHivrbZJqw5tDcoKNjTn9n0OMuVnO/n9aeNopX6L0I/S1hO8EkCK3g
         6I+w==
X-Gm-Message-State: APjAAAXk0fmXw8TidwZHYhmnZXCHXSZmqZlEhNFF7vY7gEw6YTHrsWRc
        s/cKUPNH7/m1yKM/WsQ33vc=
X-Google-Smtp-Source: APXvYqyworugJJLipHX5ZOoX9cLlyu5dVKPIRZ9lb13LWTiM6aMf6vsvgqIx4ktrXlnotFUG2KtZKw==
X-Received: by 2002:a63:e80e:: with SMTP id s14mr31216375pgh.364.1559143172806;
        Wed, 29 May 2019 08:19:32 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id p16sm17916762pff.35.2019.05.29.08.19.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 08:19:30 -0700 (PDT)
Subject: Re: [PATCH 11/24] scsi: add scsi_host_get_reserved_cmd()
To:     Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
References: <20190529132901.27645-1-hare@suse.de>
 <20190529132901.27645-12-hare@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <25a5a8f5-324b-6b7c-71eb-6cb9f9a60ba8@acm.org>
Date:   Wed, 29 May 2019 08:19:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190529132901.27645-12-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/29/19 6:28 AM, Hannes Reinecke wrote:
> +	rq = blk_mq_alloc_request(shost->reserved_cmd_q,
> +				  REQ_OP_DRV_OUT | REQ_NOWAIT,
> +				  BLK_MQ_REQ_RESERVED);

Is your purpose to avoid that blk_mq_alloc_request() waits? If so, why 
do you want to avoid that?

The same comment as for patch 02/24 applies here: if you want to avoid 
that blk_mq_alloc_request() I think you need BLK_MQ_REQ_NOWAIT instead 
of REQ_NOWAIT.

Bart.
