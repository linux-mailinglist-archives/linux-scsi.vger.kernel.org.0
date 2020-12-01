Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1DB2CA91C
	for <lists+linux-scsi@lfdr.de>; Tue,  1 Dec 2020 18:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388082AbgLAQ4z (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 1 Dec 2020 11:56:55 -0500
Received: from mail-1.ca.inter.net ([208.85.220.69]:40558 "EHLO
        mail-1.ca.inter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728142AbgLAQ4y (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 1 Dec 2020 11:56:54 -0500
Received: from localhost (offload-3.ca.inter.net [208.85.220.70])
        by mail-1.ca.inter.net (Postfix) with ESMTP id C0F822EAB4E;
        Tue,  1 Dec 2020 11:56:13 -0500 (EST)
Received: from mail-1.ca.inter.net ([208.85.220.69])
        by localhost (offload-3.ca.inter.net [208.85.220.70]) (amavisd-new, port 10024)
        with ESMTP id 8ZON+BcPGFbh; Tue,  1 Dec 2020 11:45:51 -0500 (EST)
Received: from [192.168.48.23] (host-104-157-204-209.dyn.295.ca [104.157.204.209])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail-1.ca.inter.net (Postfix) with ESMTPSA id 645B72EAC83;
        Tue,  1 Dec 2020 11:56:13 -0500 (EST)
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v1 3/3] scsi_debug: iouring iopoll support
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        linux-scsi@vger.kernel.org
Cc:     linux-block@vger.kernel.org
References: <20201015133721.63476-1-kashyap.desai@broadcom.com>
 <56c55fed-3034-9fbf-b089-a07e74d9b05b@interlog.com>
 <1d8b5c319efd67aadd411632ee519295@mail.gmail.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
Message-ID: <8a009fa6-8604-3516-fc30-2f0fdbc8519d@interlog.com>
Date:   Tue, 1 Dec 2020 11:56:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1d8b5c319efd67aadd411632ee519295@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 2020-11-30 4:06 a.m., Kashyap Desai wrote:
>>
>> On 2020-10-15 9:37 a.m., Kashyap Desai wrote:
>>> Add support of iouring iopoll interface in scsi_debug.
>>> This feature requires shared hosttag support in kernel and driver.
>>
>> I am continuing to test this patch. There is one fix shown inline below
>> plus a
>> question near the end.
> 
> Hi Doug,  I have created add-on patch which includes all your comment. I am
> also able to see the issue you reported and below patch fix it.
> I will hold V2 revision of the series and I will wait for your Review-by and
> Tested-by Tag.

Thanks, that is a good explanation of why poll_queues must be less than
submit_queues.

Acked-by: Douglas Gilbert <dgilbert@interlog.com>
Tested-by: Douglas Gilbert <dgilbert@interlog.com>
