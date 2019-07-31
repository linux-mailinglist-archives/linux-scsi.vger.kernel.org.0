Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 474F77D1E1
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Aug 2019 01:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbfGaX2R (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 31 Jul 2019 19:28:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36346 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbfGaX2R (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 31 Jul 2019 19:28:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id g67so57282805wme.1
        for <linux-scsi@vger.kernel.org>; Wed, 31 Jul 2019 16:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eDDvAm3l2VlyBqtVyOr5QF7FxvwCUV3NxVzPhFcqF1g=;
        b=cWt+X/IhzJ2CjaXh9NMI87K4I+XRIr06MpGYlIVXmONTLjRwBKYYQJS3Fksxc0WVDY
         P5MbulAo9VoEzjzkT0zNAl7nPb7cnD0+2wKH3YSA6oe2BdKyUHaXJ1AS5hsHk5CfpYMU
         33o0NjVguTZcP7lihm6ozy2z8js3g3x+4ITcQMHEk4nL7UVhks71uYTwPAEKZWK+tsAc
         279u7AAsp+4gDM/xREQywzgNBzKmUWYuTLmhi0BP5JkegjM3vzLOAWZUtJ3wE7iygfbY
         T8gUvWjQmMMq/yX4EWnb/Mm1fTtbIlqE/uEnTf3+YjlnfLdquL6bdMqsc9qyPhsPB6hu
         6jDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eDDvAm3l2VlyBqtVyOr5QF7FxvwCUV3NxVzPhFcqF1g=;
        b=g3vlC//7JcT1GBqKnC2uGWLYM8cbdQ+3DgW/JS2MiHD0rU7CwAajA0QB4tKyJ2se9F
         z5hauY/zQORQ2FQCYPyuQtsm/67rxFlFITxcM51/uzk+HDNbEhSnc4vvxyAcg1ydVanb
         YvRPhdUadXqdpqSz4t0vV90sUePT4cuATTxYoOMGtV468Xfo2Z05ovYLaQvhE2rYNV8B
         H36+Jevyuv3m5fjaqofvlm/x6VTs8eCyww4r6g+c04EC43YiFUmRaBp+6IQyv5rHGeNY
         iXHHRCammdrMuuKFxgrgP9BDGNE1Z2GS6HmscYIHB7LyPPSFLDd9Q/Wq4IWHdmvj+ap9
         JPqA==
X-Gm-Message-State: APjAAAXN/ULbCHmCWxaRt08QTf9qW4e25N+iUNBoiWN4BtHBaBtYmTwr
        Nz0BWUOJ7Q56lJOGDmaydwTIwTk3HPg+AI7o6mA=
X-Google-Smtp-Source: APXvYqyf/pU7p5dArME5Cts9nlbuxqcd6EnQaL5EeU3yBXX0Cu08EUTyNS+ph1T/7jDyemxyvf0g2Iecz0uBRHxP5uE=
X-Received: by 2002:a1c:2015:: with SMTP id g21mr110412271wmg.33.1564615695044;
 Wed, 31 Jul 2019 16:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190731000759.6272-1-jsmart2021@gmail.com> <CACVXFVOSWQDvaeSJ_UFxB7pS=6QvTVhL0-MdTTcd1yWNWFAomA@mail.gmail.com>
 <5c562288-2da1-ea54-28fe-f5976f2087eb@gmail.com>
In-Reply-To: <5c562288-2da1-ea54-28fe-f5976f2087eb@gmail.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Thu, 1 Aug 2019 07:28:03 +0800
Message-ID: <CACVXFVOBOymx0Hh550Q=eCpS3qC8mHamiDP45WueJGiESNww3Q@mail.gmail.com>
Subject: Re: [PATCH] lpfc: Mitigate high memory pre-allocation by SCSI-MQ
To:     James Smart <jsmart2021@gmail.com>
Cc:     Linux SCSI List <linux-scsi@vger.kernel.org>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, Aug 1, 2019 at 1:01 AM James Smart <jsmart2021@gmail.com> wrote:
>
> On 7/30/2019 7:31 PM, Ming Lei wrote:
> > Hi James,
> >
> > Could the default hw queue count be set as numa node number? This way
> > should work
> > fine most of times.
> >
> > Thanks,
> > Ming Lei
> >
>
> Well... I could. But I have 2 reservations:
> - I assume most systems will be 2 sockets thus 2 numa nodes - there's
> something appealing to have at least 2 per socket in this case.

I remembered 4 or more might be often seen on AMD platform,
and it won't be bigger than 8 usually. If there is more numa nodes,
the total memory should be bigger for more hw queues.

> - I do like having a fixed value as it means there is a fixed
> expectation for what the max is and doesn't vary by platform.

You can cap it to one max number, such as 8.

Thanks,
Ming Lei
