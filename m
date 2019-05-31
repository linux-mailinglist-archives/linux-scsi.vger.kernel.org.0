Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D006B3092A
	for <lists+linux-scsi@lfdr.de>; Fri, 31 May 2019 09:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbfEaHNQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 31 May 2019 03:13:16 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:34094 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaHNQ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 31 May 2019 03:13:16 -0400
Received: by mail-ed1-f44.google.com with SMTP id c26so2882100edt.1
        for <linux-scsi@vger.kernel.org>; Fri, 31 May 2019 00:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmd.nu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T9mcBC/LWirCOUrGRb51qVW8gDqatGzXRM2tWeIBBRk=;
        b=iKg74icOwCDfKDNOB4ZKOber5vX2dTBFpPfhFa3czyJTOQ2wWqmgwizd3qLi3p6Viv
         EUwlLQus+s+ZdKILV4lZRH1pnXPeCLnV5iaXTgiZpF3sIkyxKjm0nE2RRSmaecajkg8N
         PEJekwrtyfiYqQgxR5eUJU1WWlGWdTJ/XI18g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T9mcBC/LWirCOUrGRb51qVW8gDqatGzXRM2tWeIBBRk=;
        b=enPkBQvoM2h8qt3gbwHpkYMqedpWXq3SpV4UkK1SoOjiNAeurhWvZBQ2lok3iq38xc
         5C9p4L45rCI9g9qATUAC3EY2+Xkw3bGQKBMgFWO1Bqm+LFL6c4zPp5ior4bnDK168fsl
         y4IkSU1IeUlJoG7Dx9j8aP+C8vJLyTo4lGo62ZhYaujoO5bdBQKqKCuc53bnxQzRdQbx
         lcJBbgFUAhs8laOCjl7l5E4HCfckXAhFVz5THlQA4d27sIb/TP5OQlMcQT7JCk5pVrSi
         3pm+xtp+cxvIfccI71mS79+CnzTlvgZe9TqmjVuE58qvX8uUlWYfulbyMfwFT1RzukiU
         hgAw==
X-Gm-Message-State: APjAAAVgPQPrhH6Q3nHvMnrYYCB/Un8rTez3Dwe/UJeJclZdtCxUygnv
        iREc2Xv2Gysjjc5WCL+yXWgogByROdM9nZmSiFWwyQ==
X-Google-Smtp-Source: APXvYqwendjlbHakL9rROXuTQk8aNFUO5bK5mltFxwijmGfvALR5yCN9naQa0wug3CefB5jEM1dK5/O1cE9KPXLtt+w=
X-Received: by 2002:a17:906:ecf0:: with SMTP id qt16mr7681104ejb.166.1559286794566;
 Fri, 31 May 2019 00:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <CADiuDASOCJbnwLs-LEp0aCX+T4dMvFfKQv_zsypHW-iSF8wW=Q@mail.gmail.com>
 <5c5609d8-e4b4-3561-ece9-93746fd46206@acm.org> <69308786-81d8-a9df-2d7b-df37c3f93026@suse.de>
In-Reply-To: <69308786-81d8-a9df-2d7b-df37c3f93026@suse.de>
From:   Christian Svensson <christian@cmd.nu>
Date:   Fri, 31 May 2019 09:13:00 +0200
Message-ID: <CADiuDATRN_85Tu3uw1WBtY=m8KrqKV5zpYrsggYdAOH23dwU=Q@mail.gmail.com>
Subject: Re: [Open-FCoE] FICON target support
To:     Hannes Reinecke <hare@suse.de>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-scsi@vger.kernel.org,
        fcoe-devel@open-fcoe.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi Hannes,

On Fri, May 31, 2019 at 8:06 AM Hannes Reinecke <hare@suse.de> wrote:
> Hmm. I wonder: do you _know_ what you are asking?
> Have you ever worked with a mainframe?

I can assure you I have no idea what I am doing :-). I am doing this as a
learning project where my aim is to implement a virtual card reader in
user space.

>  unless you're having access to a fibrechannel analyser hooked up to a mainframe.

Funnily enough, I happen to own both.

Regards,
Chris
