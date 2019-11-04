Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98D52EE638
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Nov 2019 18:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbfKDRjN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 Nov 2019 12:39:13 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45987 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728957AbfKDRjN (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 4 Nov 2019 12:39:13 -0500
Received: by mail-pg1-f194.google.com with SMTP id w11so1436854pga.12
        for <linux-scsi@vger.kernel.org>; Mon, 04 Nov 2019 09:39:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+dph0Raqdsf//+GDu2MAr+c+IolWVXOaz7N10yfWb6g=;
        b=luxx0lNvoWDegNTYKrGvKhtNjWO39xYznX28dBHgv25x/MRUWHrYuku3G7FletJoHB
         l7N/z0sm2nQvtWLFD0Vq9modnkx7qJaXvujhaj5d890NOd7pKGpCpIdEuBOU6eLNuK+P
         wvqEpkFbEmKQadenXV6y720rGc8nqrYqz1BpiMSo7vlVEPpCZuY+1qSRzDhxkAyfqFGj
         KcIFqFA8ew0fOHJwE2Almssi8z2B62RmfHPU7e7VuChd8nv0E4+b9QnhQUiWOR+CrcaI
         vHJjgdZk555VOsGk8f3gCCVJNlgZhsfWLhwI5RJOKBs+7b+6NFQzhZE1xjKjmaODnjsM
         gvXg==
X-Gm-Message-State: APjAAAXQhSafd47ClRcGm4XZ+NYgiZqoTQSmCMV2eYv6UNZx/1eWbIWN
        nabK7WZ4IFWeD514yrb797eXDdpg
X-Google-Smtp-Source: APXvYqzczaVJjEPDb1WqtnJGvvTfX3lwSIJmhtGeX2AALbtt9Lcb4McRtXO/TWAgFm7v9+33oiY7BA==
X-Received: by 2002:a63:cf0b:: with SMTP id j11mr31076756pgg.240.1572889152194;
        Mon, 04 Nov 2019 09:39:12 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id w2sm8375735pfj.22.2019.11.04.09.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2019 09:39:11 -0800 (PST)
Subject: Re: [PATCH 10/52] megaraid: use standard SAM status codes
To:     Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
References: <20191104090151.129140-1-hare@suse.de>
 <20191104090151.129140-11-hare@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <9eed9ef5-7a0f-82a5-88e7-49c880d12ddf@acm.org>
Date:   Mon, 4 Nov 2019 09:39:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191104090151.129140-11-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 11/4/19 1:01 AM, Hannes Reinecke wrote:
> Use standard SAM status codes and omit the explicit shift to convert
> from linux-specific ones.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
