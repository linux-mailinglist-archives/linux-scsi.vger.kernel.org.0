Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC1EB2E0C3
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 17:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbfE2POI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 11:14:08 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33344 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbfE2POH (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 11:14:07 -0400
Received: by mail-pg1-f194.google.com with SMTP id h17so103829pgv.0
        for <linux-scsi@vger.kernel.org>; Wed, 29 May 2019 08:14:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s/a5MGwzml1RLJ+jflkKvaH//dlNJmi4ablDDXFmdcw=;
        b=bCygQ3T1Sl76HInpXd1agOQqMQmy8UJNm1mI6x8TpT6jzQezB5T1qmwflDz3zDKsHT
         CpJN1DTD1L5xJaxh+82onVbWfowis/zC98thFXKOZ7XQsDug8qkJ+jbE6DG9FQ1sSCMh
         Ts+fEC5+v0z3FuZ1Lyk6VLOzIEddgrla/uCsHjB1lRWCkePjwctpEniIdJsMKcnw8NbI
         xX3EIggdvAyXWFXU6ZGegDWPwEn3MbxVAOW8ALCUNZZSTfZVjW+wWfKMqYDcoBgoGIdv
         fizVN7FJyjiWaelwkay4A9W5PgdorNYhjk/sSisHmwBD22jpsqBbeAP0hxMmdtTktJLQ
         KzFw==
X-Gm-Message-State: APjAAAWqYOqOYYjLvjzWRyljqAVCB9dWzbkic3ndg7M4bMFNV+fxe4O5
        6wmrH55h0SRqflljhbedvmdYsR2G
X-Google-Smtp-Source: APXvYqxFAf8v9A/cyWrszZHMRZ56PRNleIjlWEn952IXyRms7vTY/6VRAJrpWcqtJhFiG2qKis9QQw==
X-Received: by 2002:a63:fa4a:: with SMTP id g10mr138602147pgk.147.1559142847383;
        Wed, 29 May 2019 08:14:07 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id d24sm5396362pjv.24.2019.05.29.08.14.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 May 2019 08:14:06 -0700 (PDT)
Subject: Re: [PATCH 05/24] scsi: add scsi_cmd_from_priv()
To:     Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
References: <20190529132901.27645-1-hare@suse.de>
 <20190529132901.27645-6-hare@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <cf6017bd-fc02-8b61-c703-aec24916ae63@acm.org>
Date:   Wed, 29 May 2019 08:14:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190529132901.27645-6-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/29/19 6:28 AM, Hannes Reinecke wrote:
> Add a command to retrieve the scsi_cmnd structure from the driver
         ^^^^^^^
         function?
> private allocation data.
