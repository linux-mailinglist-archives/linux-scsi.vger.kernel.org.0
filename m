Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5AA253702
	for <lists+linux-scsi@lfdr.de>; Wed, 26 Aug 2020 20:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgHZS0s (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 26 Aug 2020 14:26:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57846 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727903AbgHZS0q (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 26 Aug 2020 14:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598466404;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jUC82NZTGG1NBiJnCc9uSJd7Fyro45VVAe7zgg+zWvA=;
        b=Isbip/4FNOhAowUg5dP7ai2QmeT0tAiuaXVPwRzYtJP525IwUcvJymI/1InbuBl5kPTw9t
        aUsAxiMYQlLVxrn0KbQ4hyujZHdvPl6tWnUqn+UhMwcA0NIA1+yM5lCBGNWTsDi1Vfvc0D
        MQfHj9Uls6fl39wJN71e4qf2vjbBdi0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-hKTNfgUyNBqTB2DSoUH00Q-1; Wed, 26 Aug 2020 14:26:42 -0400
X-MC-Unique: hKTNfgUyNBqTB2DSoUH00Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E83C6189E60D;
        Wed, 26 Aug 2020 18:26:39 +0000 (UTC)
Received: from [10.10.110.13] (unknown [10.10.110.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 87162776E8;
        Wed, 26 Aug 2020 18:26:38 +0000 (UTC)
Reply-To: tasleson@redhat.com
Subject: Re: [v4 03/11] dev_vprintk_emit: Increase hdr size
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20200724171706.1550403-1-tasleson@redhat.com>
 <20200724171706.1550403-4-tasleson@redhat.com>
 <CAHp75VcwDhHmLbOO2WKkShNYAdLawLx6A5O-4newkCe4XEb3LQ@mail.gmail.com>
From:   Tony Asleson <tasleson@redhat.com>
Organization: Red Hat
Message-ID: <20dad8a0-9a6d-20b4-b5a1-06648c00008e@redhat.com>
Date:   Wed, 26 Aug 2020 13:26:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcwDhHmLbOO2WKkShNYAdLawLx6A5O-4newkCe4XEb3LQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 7/25/20 5:05 AM, Andy Shevchenko wrote:
> On Fri, Jul 24, 2020 at 8:19 PM Tony Asleson <tasleson@redhat.com> wrote:
> 
>> -       char hdr[128];
>> +       char hdr[288];
> 
> This is quite a drastic change for the stack.
> Can you refactor to avoid this?

The only thing I can think of is using a hash of the identifier instead
of the value itself.  This could drastically reduce the stack usage and
data stored in journal, but it makes it kind of clumsy for using.

Would placing this on the heap be acceptable?

