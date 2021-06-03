Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DD0399805
	for <lists+linux-scsi@lfdr.de>; Thu,  3 Jun 2021 04:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbhFCC16 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 2 Jun 2021 22:27:58 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:44986 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhFCC15 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 2 Jun 2021 22:27:57 -0400
Received: by mail-pl1-f170.google.com with SMTP id h12so2094970plf.11
        for <linux-scsi@vger.kernel.org>; Wed, 02 Jun 2021 19:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QFewWq+fJISCttp1e3owCWtVm9JUgU7MkSVxFfhEtpI=;
        b=SznRablQrwE+xloJNmU0Qe7mTYDcBSu7dfUxiYL8sz/L73J8Pwc1mm09V/GAl8Qi2A
         ZMWfDFfDp8KgkXpIvVuY0Fr423C5vCCjA5jTrgS4wa+IBG3HpJlhSZm8FfuYautu18lR
         g4czTXuFY2XXaYk09Yw16oOblttsXP5tNU7Cy7Tzbb886CkNlzXVJIQom9pOo87pJHWx
         lriMIIHylfH3rqaCiTpJcpzWSLEzc9GosFt+T8gsXKkBxYozXl+FAGHOenNNOrpq/+Rt
         +ikjB6ajh8jv7iBlHGU3f5Q9lAHj+PC6R+ZhT6noix1OUV5yJJF2QsxyMBbURghUKU3c
         5koQ==
X-Gm-Message-State: AOAM533dDi7RLQwm00zNegFFF829stXmNKy35cp62i2wpi9u7NTRPVS+
        c/of6H4vAQjJKlhYlK2iBN4=
X-Google-Smtp-Source: ABdhPJxC5HnK4s7uHQRWwScJQ/LdNvbNUXbe71HbTfNjY1k5v0IcK89cl2V5lMTg1J6HPeeJq4p2Aw==
X-Received: by 2002:a17:90b:f07:: with SMTP id br7mr27457529pjb.141.1622687173532;
        Wed, 02 Jun 2021 19:26:13 -0700 (PDT)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id o14sm720072pfu.89.2021.06.02.19.26.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 19:26:12 -0700 (PDT)
Subject: Re: [PATCH 1/4] scsi: core: fix error handling of scsi_host_alloc
To:     Ming Lei <ming.lei@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     John Garry <john.garry@huawei.com>, Hannes Reinecke <hare@suse.de>
References: <20210602133029.2864069-1-ming.lei@redhat.com>
 <20210602133029.2864069-2-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <48011672-bb3f-3586-f701-e1dd5b8d398c@acm.org>
Date:   Wed, 2 Jun 2021 19:26:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210602133029.2864069-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/2/21 6:30 AM, Ming Lei wrote:
> After device is initialized via device_initialize(), or its name is
> set via dev_set_name(), the device has to be freed via put_device(),
> otherwise device name will be leaked because it is allocated
> dynamically in dev_set_name().

dev_set_name() must be called after device_initialize() so I think the
reference to dev_set_name() can be left out from the above sentence.

>  	return shost;
> + fail:

Please leave a blank line above labels. Otherwise this patch looks good
to me hence:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
