Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E409383934
	for <lists+linux-scsi@lfdr.de>; Mon, 17 May 2021 18:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbhEQQLM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 May 2021 12:11:12 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:33719 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245293AbhEQQIq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 17 May 2021 12:08:46 -0400
Received: by mail-pl1-f181.google.com with SMTP id b21so3435756plz.0
        for <linux-scsi@vger.kernel.org>; Mon, 17 May 2021 09:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g1ZvuMjUfMEQOcAAcRQP2Doih0Z8MXGUdt++BpldidA=;
        b=XTkAQbLn9X24Echi+E7Urr7HHlztMflFPDu/43291yu24xDA+3uiYNjgA2DbYipjou
         uhoUe6ncfHz7ki45VMIFCN+C4opIr2bg15Qby0KUcWvKjqRu42aDJXNyK2m/UmfCbfg1
         Gk30+t+DqmuYy7bVd7bMHUUgDpNVQHgkjrB75n3x5BezoUHBX78vd7WXbGYCt1mOtw4T
         jtTPe0Vcs6lxIQVdh6gJbmTjeKZZqPx3C3JPiwD9rzV/TfiZjwmLI7c72N+wQbTjdct+
         pBSYhbU7InW4Ky3MXiVi0xOhyWvk2TJLqvHI8uMWM+TUQxeLcZxG/KyaxN4sazrReThg
         mi/w==
X-Gm-Message-State: AOAM530hDuK49Hv2BO42N0S2cpSzWzTN+sBdxTrtTJ9cTcGfboSjEqZS
        wecygfaHOCXmuqN+pt+2JWG/YBUdQDU=
X-Google-Smtp-Source: ABdhPJwE7p0Jg15zP41/5EmyT+6ljWebEC4FF/+AzbWMrwyZzhIhj6YPk9HzhNbfp2qvmsmSshe0fQ==
X-Received: by 2002:a17:902:d204:b029:f0:b65d:a14d with SMTP id t4-20020a170902d204b02900f0b65da14dmr751116ply.25.1621267648315;
        Mon, 17 May 2021 09:07:28 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:8224:c0d6:d9dd:57b3? ([2601:647:4000:d7:8224:c0d6:d9dd:57b3])
        by smtp.gmail.com with ESMTPSA id w1sm9238858pjk.10.2021.05.17.09.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 May 2021 09:07:27 -0700 (PDT)
Subject: Re: [PATCH 01/50] core: Introduce the blk_req() function
To:     Christoph Hellwig <hch@lst.de>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Ming Lei <ming.lei@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
References: <20210514213356.5264-1-bvanassche@acm.org>
 <20210514213356.5264-2-bvanassche@acm.org> <20210515064727.GA26723@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <e445b408-1ee3-fbb1-d03b-3b86c1f4096a@acm.org>
Date:   Mon, 17 May 2021 09:07:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210515064727.GA26723@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 5/14/21 11:47 PM, Christoph Hellwig wrote:
>> +/* Variant of blk_mq_rq_from_pdu() that verifies the type of its argument. */
>> +static inline struct request *blk_req(struct scsi_cmnd *scmd)
> 
> Please don't use a blk_ prefix for a SCSI funtion.  Why not scsi_scmd_to_rq
> or something like that?

Hi Christoph,

Thanks for having taken a look. I will rename that function into
scsi_cmd_to_rq().

Bart.


