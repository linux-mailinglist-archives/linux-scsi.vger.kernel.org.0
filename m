Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A07E2E0B4
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 17:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfE2PMk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 11:12:40 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:42449 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfE2PMk (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 11:12:40 -0400
Received: by mail-pl1-f181.google.com with SMTP id go2so1182038plb.9
        for <linux-scsi@vger.kernel.org>; Wed, 29 May 2019 08:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FTZkP4NPFb+rNPjXmLJzKGd+kvdmjBRThG14xlVA8ng=;
        b=rRF9qXZShSJ7hRN7sZ+brbJcWCqkzJY2WGt1ymRMRO2+5G1PLY8dsNbpW3ZmmwyYPU
         m1b1YFhy9gGl2274cI1Z7dWAU963f0l6LyXbExSZ2vs9rCibx/OuBurrz9lYlEMCm+A3
         A7qDF+aQRYd/PWJK72nEqe4L5xacfS9yiaTff2/E6BxZ0L/cce+M0GFFPoBSeKHWzLLW
         20aNW1qm9HQJH55MZ//lfDg4dlWqzh/kzNUgH3FJwhUhsVTr/F8aSCKufNeB7BEgPTz6
         aAN6i9UxG7eItLB89uwEfI9498D7p/R2kOerh7PVrfOXidnMYtXX0e8WeWb2MLgOVj+N
         SOtA==
X-Gm-Message-State: APjAAAXdbb9R/qFeY+01cTlGOkzs1LPghw+es/OsVZNHCcgus6x9aN33
        2RkHWSXpjCYNxM/l6b95Omo=
X-Google-Smtp-Source: APXvYqxHZzPCzEFBdfaxifS/d0xuMqMruoRH8WhYzedYRqj1568SJLnCPbIxzrIIRAT+V4aF8Xt21w==
X-Received: by 2002:a17:902:a60e:: with SMTP id u14mr135728747plq.94.1559142759807;
        Wed, 29 May 2019 08:12:39 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id f10sm16231907pgo.14.2019.05.29.08.12.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 08:12:38 -0700 (PDT)
Subject: Re: [PATCH 02/24] scsi: add scsi_{get,put}_reserved_cmd()
To:     Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
References: <20190529132901.27645-1-hare@suse.de>
 <20190529132901.27645-3-hare@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <09f930f8-f152-095d-a428-8dba3722f7de@acm.org>
Date:   Wed, 29 May 2019 08:12:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190529132901.27645-3-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/29/19 6:28 AM, Hannes Reinecke wrote:
> +	rq = blk_mq_alloc_request(sdev->request_queue,
> +				  REQ_OP_SCSI_OUT | REQ_NOWAIT,
> +				  BLK_MQ_REQ_RESERVED);

This looks wrong to me. To avoid that blk_mq_alloc_request() waits I 
think it should be called as follows:

	rq = blk_mq_alloc_request(sdev->request_queue,
			REQ_OP_SCSI_OUT,
			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);

Bart.
