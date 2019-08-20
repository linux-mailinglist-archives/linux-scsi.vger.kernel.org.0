Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAD3A964D8
	for <lists+linux-scsi@lfdr.de>; Tue, 20 Aug 2019 17:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730179AbfHTPoE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 20 Aug 2019 11:44:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43662 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729918AbfHTPoE (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 20 Aug 2019 11:44:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id v12so3612180pfn.10;
        Tue, 20 Aug 2019 08:44:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4jRGLtVU5r9UcS9Qnr4Iu+vrayhHUr2Qi0LuhCw4B3Q=;
        b=ZEgYH6WpwJ66w2qiG1Hdsowzrhc5EwdcDFKBZ5TeIPu4Zc5gVxx6bnntKJeU6svWfp
         E5ynQeWHpK+LU85r0ZCwBzGpYSVLSys0iJQPcy/IHQWE8HfcZ0ks/QsXmTiS2momWgwA
         K2h2KmwSrecFCBSMLNXJ288dDhjk6n2ItuWhOgcmyr19rBM2YzMHDyZHo/b6G6rCoyMR
         S5+qAxfnTY7AKFI4idzQcMFCcLD+GDN7KhPXIGhSGoP1+FXUoKOzSx6vwLPRuSD/lNUN
         EtjAxyK92EqMv/ng6leEw2hPrf0wo9PVLMyTq0wHmlJ7w8z0VjGAYD+O+MbDQGUe8/AD
         gq9w==
X-Gm-Message-State: APjAAAUU92qeVKcR26vV2ZvPa6J2S4XKdz7f68MftEMkDmL/aM+XRxSD
        Q9chHzH8RiGIqvNMON7T6xA=
X-Google-Smtp-Source: APXvYqx2pobOajqPTHDvlFOo68MYoWh6qh4ybTZ1m5Aqb0Jb1f4gNOlQ4RQ7gtwyPMVrC3K/XmvJEg==
X-Received: by 2002:a63:9249:: with SMTP id s9mr24545774pgn.356.1566315843146;
        Tue, 20 Aug 2019 08:44:03 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id j6sm30761926pfg.158.2019.08.20.08.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2019 08:44:02 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] scsi: target/tcm_loop: ignore already deleted scsi
 device
To:     Mike Christie <mchristi@redhat.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Cc:     Nicholas Bellinger <nab@linux-iscsi.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20190820090429.1961085-1-naohiro.aota@wdc.com>
 <1973f310-ad00-ff88-fe08-a31f81dc5c33@acm.org> <5D5C1159.4030507@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <737dd6be-a8c9-492c-8057-1f16b3d90519@acm.org>
Date:   Tue, 20 Aug 2019 08:43:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5D5C1159.4030507@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 8/20/19 8:27 AM, Mike Christie wrote:
> tcm loop does not take a reference to the scsi_device at creation/link
> time then need to release at removal/unlink time. The above
> scsi_device_put is for the successful scsi_device_lookup call. tcm loop
> works like a scsi host driver that does its own scanning via
> scsi_add_device (maybe similar to scsi drivers that are raid cards).
> Like other host drivers it does not take a reference to the device when
> it is added and relies on scsi-ml to handle all that for it before doing
> operations like queuecommand.
> 
> The leak is if you removed the scsi_device via the scsi ml sysfs
> interface then there is no way to completely unlink the lio port because
> if scsi_device_lookup fails we return from the function and do not do
> not release our refcount on the tl_tpg_port_count.

Hi Mike,

Does this mean that you think that this patch is the right way to 
address the reported issue?

Thanks,

Bart.

