Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE1E77C9A7
	for <lists+linux-scsi@lfdr.de>; Wed, 31 Jul 2019 19:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfGaRBB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 31 Jul 2019 13:01:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44394 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbfGaRBA (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 31 Jul 2019 13:01:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id i18so32338063pgl.11
        for <linux-scsi@vger.kernel.org>; Wed, 31 Jul 2019 10:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wvTs5xEozfiExi7xEoYt+bLRPEBzmr9OsBv38+eAAKE=;
        b=TKJgfjsS5IYwy+P3DPQfhSAOJsZMHiwnaO8gTStjT5xv7uTjtMX4UpmjV1e1H7VaEF
         ErRH9zxhqlqRjp7oK4F2ZCBOBRzuDrXyS6EdTjxuWqkxV6Mnog2hBptwU3c8FkkfaAeO
         cOkngSA0JQzgNcbb9KQmx+e2yi+bHlY7tlYyQSZFGB2h1+OHpRr4j5m6rXf7tA8hzxMw
         Tf73wAN03x37asqMfpaq8C2nX/d9dVJpPbCgO+a8scBa2Xp5Aw1G3yI9TUI4ciAroQpE
         F/w7NMq/jGSIUx3iDc/7FqG9jVLts9l8H8NACyC38CgLIZ8wuJZDY89hoHrXMe9sGrrs
         1sdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wvTs5xEozfiExi7xEoYt+bLRPEBzmr9OsBv38+eAAKE=;
        b=STNgOJQAWcWNIoKqNoZoXb2mpANbQmOVBXV9BPLrf4LZhC/jkpzs1JL7NTa55gwgSr
         ZX9j5haIhY4cr0l5o9cJdjfk33gGmn6eSAgVNGKMjvYqUyW7oeJOUCWXiEA2pRvFzjWo
         RUAJoKdjQI+NW7Fj43nftZj6rN0n8VRw+66OpK3G5wMeLhr/7JiC5KZXGwT/cG6aG11Y
         +qNp3UUOQsSBgi0uJhwvVsyf0c2T+3oNejBpgx0vKpGmGm2DwbbR0jTRiziYGKH3YqCu
         vY2UZC58QHHmnTown/xSGYsUjMfx+i4WPccYQLwiLx+/me/vfio+Bh5E/SeRGg8XkiFX
         qoSQ==
X-Gm-Message-State: APjAAAWWxUqX3Rt7VuQes2JK5vFEgVfrsD3q8GTjAxI6rt8zlZlxBgVY
        iUqpaVE3eE9FNS3eozp4KPKxGDUF
X-Google-Smtp-Source: APXvYqz0np4cyiQx4CehVSfPQn+X2UKfbg3OjteHaqYfPy0pT1f5K8idIHgFIMAcelwqTWOxA7l5bQ==
X-Received: by 2002:aa7:81d4:: with SMTP id c20mr48760865pfn.235.1564592460170;
        Wed, 31 Jul 2019 10:01:00 -0700 (PDT)
Received: from [10.230.29.90] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id h26sm72077724pfq.64.2019.07.31.10.00.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 10:00:59 -0700 (PDT)
Subject: Re: [PATCH] lpfc: Mitigate high memory pre-allocation by SCSI-MQ
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Linux SCSI List <linux-scsi@vger.kernel.org>,
        Dick Kennedy <dick.kennedy@broadcom.com>
References: <20190731000759.6272-1-jsmart2021@gmail.com>
 <CACVXFVOSWQDvaeSJ_UFxB7pS=6QvTVhL0-MdTTcd1yWNWFAomA@mail.gmail.com>
From:   James Smart <jsmart2021@gmail.com>
Message-ID: <5c562288-2da1-ea54-28fe-f5976f2087eb@gmail.com>
Date:   Wed, 31 Jul 2019 10:00:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CACVXFVOSWQDvaeSJ_UFxB7pS=6QvTVhL0-MdTTcd1yWNWFAomA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 7/30/2019 7:31 PM, Ming Lei wrote:
> Hi James,
> 
> Could the default hw queue count be set as numa node number? This way
> should work
> fine most of times.
> 
> Thanks,
> Ming Lei
> 

Well... I could. But I have 2 reservations:
- I assume most systems will be 2 sockets thus 2 numa nodes - there's 
something appealing to have at least 2 per socket in this case.
- I do like having a fixed value as it means there is a fixed 
expectation for what the max is and doesn't vary by platform.

Thoughts ?

-- james
