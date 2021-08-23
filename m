Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266AD3F4E43
	for <lists+linux-scsi@lfdr.de>; Mon, 23 Aug 2021 18:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhHWQUd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 23 Aug 2021 12:20:33 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:46847 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhHWQUa (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 23 Aug 2021 12:20:30 -0400
Received: by mail-pg1-f181.google.com with SMTP id k14so17123939pga.13;
        Mon, 23 Aug 2021 09:19:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ff0NJeK+y2XgryMHnZr9ZhdDapgrsJ9pyZMfkH0leUI=;
        b=LOLnRHGRkX56dSu0fH5xdIssvKJyOlj6MzbGE19dmXWUskj2PV6dBA3FKPxUVXiuH+
         oSsvog8oN4Zhj/WHHCyuLv9ZPelEPZnT/JMYZa83Z36D2VxeLL3z7eMQFoXRqCeuBMbx
         BlYPhfssXKr45Xzfc0iu3DGjirIQFqnLEy2hUZ9F+6kWj/yK/zH9mbss0NGY3aYNwpyP
         hka19ta+n8N96lUr5axT/rOFF13bVLyA8g3YcOAXVFM5kjTiV1mHO8gzGbdr8CS58UMI
         9I1+FRULMxkQ6cRUpRfpt0kSsWSKaiCmk3E2iSxUo45iyATuRlgJvQHCz9oCbz4qXH2o
         6F6g==
X-Gm-Message-State: AOAM532ikO+SfvPb4xr6N5Hh3PGjnvYulfyUNe8AbaokjFXWLWootpMf
        ygOIgEbITsrVr38uWRH7M4QvC5uy+qQ=
X-Google-Smtp-Source: ABdhPJwSNP5qocvrIKIrLQ9dD5JPxPYYEpfDnK1kq9BfCtNXVdnjzgU1jxmiUZoTIEDs3nyInn9IYA==
X-Received: by 2002:a05:6a00:1311:b029:3b2:87fe:a598 with SMTP id j17-20020a056a001311b02903b287fea598mr34914280pfu.74.1629735587160;
        Mon, 23 Aug 2021 09:19:47 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:e98a:ca44:7012:ad8e])
        by smtp.gmail.com with ESMTPSA id t20sm19148312pgb.16.2021.08.23.09.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 09:19:46 -0700 (PDT)
Subject: Re: [PATCH v2] scsi: ufs: ufshpb: Fix possible memory leak
To:     keosung.park@samsung.com, ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        Daejun Park <daejun7.park@samsung.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CGME20210823090714epcms2p1e414fdd91582bdbf8170b4cefb8a0f74@epcms2p1>
 <1891546521.01629711601304.JavaMail.epsvc@epcpadp3>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <94a1a03e-7cb8-8815-60de-9c579cac7e8d@acm.org>
Date:   Mon, 23 Aug 2021 09:19:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1891546521.01629711601304.JavaMail.epsvc@epcpadp3>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 8/23/21 2:07 AM, Keoseong Park wrote:
> When HPB pinned region exists and mctx allocation for this region fails,
> memory leak is possible because memory is not released for the subregion
> table of the current region.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
