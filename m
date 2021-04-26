Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA88636AB0A
	for <lists+linux-scsi@lfdr.de>; Mon, 26 Apr 2021 05:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhDZDUt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 25 Apr 2021 23:20:49 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:41554 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhDZDUs (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 25 Apr 2021 23:20:48 -0400
Received: by mail-pl1-f173.google.com with SMTP id e2so23851728plh.8
        for <linux-scsi@vger.kernel.org>; Sun, 25 Apr 2021 20:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bRhjG3mreqBWyg7woNhG3tcd8ZGzD9YpkDRCCkLuqkM=;
        b=E6tr+ijt58qFW1YNjo9Wy3aZenH3UWrOscnZ2mOgKwGrMDUkVU5+aYGK6t4+gCo/Ez
         Eiv9tEInONXI+nw6ktYFFsqdM6fKkSlanWDvErkvoJrzEVGFK6ryeNuCOtQpLdxPYl2L
         IJiS84JzVbohnklE0QPTkv+h8rywea8FcnIUKYxCJPcNJT6FmHQfFnCnGQ+sB7LfZGWf
         x0dHX2jBs0WelCPwq7R9OYsBYPqErzsa5hDMitA4th8IiDQQ9cmbUOOtQr6LAkxW3KVr
         VvvK1jaOc52c2LMHV7x3bHOjl6ekVuIAkZsLezPHcHkbCI94ezj23YIj++LEBPqAOhKC
         JtzQ==
X-Gm-Message-State: AOAM530BwhJuTcp0fB2Uxn9JSXDNGn28x0NbeJVXGd6fO0WOj+clCfIh
        4UfdIEdF847pUCDUm6EfxVQhtiRBwutMfQ==
X-Google-Smtp-Source: ABdhPJxurC3Xos3gEFhzkd0J2Jm/ftAwdfxNSOtRpgt8X1u9pdBQEWIBrYWGs/AyqhiYK9FYAoJTfw==
X-Received: by 2002:a17:90b:e98:: with SMTP id fv24mr2116252pjb.1.1619407205406;
        Sun, 25 Apr 2021 20:20:05 -0700 (PDT)
Received: from [192.168.3.219] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id x2sm9579192pfu.77.2021.04.25.20.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Apr 2021 20:20:04 -0700 (PDT)
Subject: Re: [PATCH 02/39] scsi_ioctl: return error code when
 blk_rq_map_kern() fails
To:     Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org
References: <20210423113944.42672-1-hare@suse.de>
 <20210423113944.42672-3-hare@suse.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <64baaab9-1e2b-9ffb-a906-0d8120cadf06@acm.org>
Date:   Sun, 25 Apr 2021 20:20:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210423113944.42672-3-hare@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 4/23/21 4:39 AM, Hannes Reinecke wrote:
> The callers of sg_scsi_ioctl() already check for negative
> return values, so we can drop the usage of DRIVER_ERROR
> and return the error from blk_rq_map_kern() instead.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
