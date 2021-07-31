Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5A163DC664
	for <lists+linux-scsi@lfdr.de>; Sat, 31 Jul 2021 16:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbhGaOtQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 31 Jul 2021 10:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbhGaOtP (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 31 Jul 2021 10:49:15 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4F5C06175F
        for <linux-scsi@vger.kernel.org>; Sat, 31 Jul 2021 07:49:05 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l19so19445351pjz.0
        for <linux-scsi@vger.kernel.org>; Sat, 31 Jul 2021 07:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gapp-nthu-edu-tw.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uS/8eZw40GesqzhF7lVX2xV8dW5LTzB5oO2GcYreBAg=;
        b=XUWkY2HdckcIRNL7YSE8fQWXAW+gV8T0plYFze2f32gWcVRnBpesYyeK8bJfZjcsO+
         2/X3pZcby2aauRbTcF03jA6CJkuzPZJ7yvLLu+TJSypUyqnHr96FADRUrDnpx6m5ycyk
         prbaTXxF6otVCEmhkrRK6VlgoVKt9NGGizQrq84xUd3jJrvri0od8kBAS+Ex6Qo5DpGb
         NR6McpJVOkbCqmPZ+xNRjXa2VeoZHYd5P8GbsPds60QEXvBSiHy0odrh86Hh51zQjoo9
         HXAh10zbJMApXrpaK86uDTYj3MtU+uN3lOkGODaQTyxBJkTojdT6ctxvMENmDtasjXL+
         QGsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uS/8eZw40GesqzhF7lVX2xV8dW5LTzB5oO2GcYreBAg=;
        b=iOj5NsPsbtSY+QMJqArc6bMmeDwTnjzgpb55RGj3JkefyxyRhyDGMHZDW185L6ZhOc
         +kak1QnRbz6nsxIb863Yz1zuKsegtvM6zH5wPTt/hnNzDzocCbwJzPXC5LhLD2JawoZN
         iuJ6dHeVlTCSObVUjmo69j/3nlYaWCPa+7zUrBAzqi0qTKGr5cw8qkJf6NepfVG471PB
         h1wcX4IQUSXvy/R80kMJgQKZ95Xfv3+wNSr5O3gX6HQa0LUTARadZJ5whe/+ubw80rO7
         pMQkWM+Cx1oqF8rRGTfo0uyZ+Xb+81SPKcqUp/no1m5XwY0l5WLNZ5W9SpcQorm6pe5m
         2WjA==
X-Gm-Message-State: AOAM532Ty1vSp9VTqBjsasF3dXZVlJDRmpUy96deEN1ZizKBrux1MGT8
        MLMBf0i8KCUkFjOIXTVUsnjcfsRKZLmeljRny+IzLg==
X-Google-Smtp-Source: ABdhPJyhQCZQ7uDajChAsumTsGXSKd/+8YRaIJz8pW6soPRN+ohYJD52YTdAPJBk/Yv49iwU/bltpivn5zcKQZNAzpE=
X-Received: by 2002:a65:6487:: with SMTP id e7mr6953397pgv.27.1627742945068;
 Sat, 31 Jul 2021 07:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210722033439.26550-1-bvanassche@acm.org> <CGME20210722033513epcas2p22e4c2e6ea644992ede2739ebe381d53f@epcms2p8>
 <20210722033439.26550-4-bvanassche@acm.org> <1381713434.61627520283503.JavaMail.epsvc@epcpadp4>
In-Reply-To: <1381713434.61627520283503.JavaMail.epsvc@epcpadp4>
From:   Stanley Chu <chu.stanley@gapp.nthu.edu.tw>
Date:   Sat, 31 Jul 2021 22:48:54 +0800
Message-ID: <CAOBeenbNhUk3t-For7UDAk4OcGC1wgiauYS+Gj6zM9dgwvAYBw@mail.gmail.com>
Subject: Re: [PATCH v3 03/18] scsi: ufs: Only include power management code if necessary
To:     daejun7.park@samsung.com
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Keoseong Park <keosung.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Bart,

>
> >This patch slightly reduces the UFS driver size if built with power
> >management support disabled.
>

Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
