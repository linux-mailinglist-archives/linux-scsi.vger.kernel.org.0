Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2875E1B94B0
	for <lists+linux-scsi@lfdr.de>; Mon, 27 Apr 2020 02:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgD0AEm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 26 Apr 2020 20:04:42 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:59148 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726196AbgD0AEm (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 26 Apr 2020 20:04:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A80118EE10C;
        Sun, 26 Apr 2020 17:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1587945881;
        bh=I0Ch1ArP/W0js27xMy92sem1tA4MKwqqYdm80hwURoA=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=FvWWxVotJtHLPQHHl6FIWuv21dWUS8EqWT/CBFX9kxqFjavZtYuSlmv4j9bW3jNtS
         PEZOjbvXACi1/RrTT3qbXQDWShsg1kf/xoncjvTGXaFVaDqVAPFnVytP2YUOoBdXxd
         /n6IXoV94Pkk96WUDuQ2rLwdhwi9JH30K1WUaO2U=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iZ4txB2tOdDK; Sun, 26 Apr 2020 17:04:41 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 28D168EE0E3;
        Sun, 26 Apr 2020 17:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1587945881;
        bh=I0Ch1ArP/W0js27xMy92sem1tA4MKwqqYdm80hwURoA=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=FvWWxVotJtHLPQHHl6FIWuv21dWUS8EqWT/CBFX9kxqFjavZtYuSlmv4j9bW3jNtS
         PEZOjbvXACi1/RrTT3qbXQDWShsg1kf/xoncjvTGXaFVaDqVAPFnVytP2YUOoBdXxd
         /n6IXoV94Pkk96WUDuQ2rLwdhwi9JH30K1WUaO2U=
Message-ID: <1587945879.3423.5.camel@HansenPartnership.com>
Subject: Re: Venturing into HBA driver development
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Aijaz Baig <aijazbaig1@gmail.com>, linux-scsi@vger.kernel.org
Date:   Sun, 26 Apr 2020 17:04:39 -0700
In-Reply-To: <CAHB2L+cDZCMAwQhVxU99Dwa7Fj90Wwn7qZ9e=78MCqQdwrEjGQ@mail.gmail.com>
References: <CAHB2L+cDZCMAwQhVxU99Dwa7Fj90Wwn7qZ9e=78MCqQdwrEjGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, 2020-04-27 at 05:24 +0530, Aijaz Baig wrote:
> I'm a mid level developer with acceptable knowledge of OS internals
> and some driver development but up until now, I've worked mostly on
> the networking side of things
> 
> most searches online are leading me to open solaris which seems to be
> the only guide available online for writing HBA drivers
> 
> Is there anything else (Besides reading the source), like a guide or
> something, that I can read to help me get up to speed with it.

This is a pretty good one

https://lwn.net/Kernel/LDD3/

And if you like it, you could buy the book.

> Do I really need to know SAN to become acceptably good. How much SCSI
> (and other protocol(s)) knowledge is needed?

It depends *what* driver you want to write.  Obviously you have to
understand the protocol of both the host bus adapter and usually also
any devices attached to it, but the HBA protocol is usually highly
manufacturer dependent, it's only the device protocol that you'll find
in standards.

James

