Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90DE730AAA
	for <lists+linux-scsi@lfdr.de>; Fri, 31 May 2019 10:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfEaIwd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 31 May 2019 04:52:33 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:43755 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfEaIwd (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 31 May 2019 04:52:33 -0400
Received: by mail-ed1-f44.google.com with SMTP id w33so13407842edb.10
        for <linux-scsi@vger.kernel.org>; Fri, 31 May 2019 01:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmd.nu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=woBzKbNns4vsAtLqUGxB28zM9TLa0UZboHvo2BIrQE8=;
        b=Jce5D+deQf6jxKOL0kYBWKPMASmiyWfbK0CkmWhfdr74nZaVBFwlGzzLFmZ9qoR49a
         ZmQTAB2sbFJUgVWnUjcaiA07Ji43SFpp2ljMY1hCFsTGr0AyJvfo7ANFX951EtDT+WTC
         f+fc39ujJHE5lIpN8BUOdjglYWGiSdvztE5Yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=woBzKbNns4vsAtLqUGxB28zM9TLa0UZboHvo2BIrQE8=;
        b=AXMsJ5cmFS9UZJ+7F6dC7z4XVWGU2sYjxPLD3Wo8C1eqoJIB4vrqpsgJeWVxd0+bmE
         kdiAvLgXCiiMoOdnE+2dWkZYhgzV1JyCDCza6vyY0luJIAHRJlUw5Z1Q+y1QwnnQOB1g
         92YRuciNZZiKkuY83stEaHeHZXwoxqgq7bM+ol/Bj5Kxp2jgtsUTYw0HwRJvV4LFu6d+
         vUWJuzJib+W6DvSu0v0Cid4LcvvmlzlIggYAi11nN1nBoNcz7MwvYYqXMIPx4+dIcXl4
         Ro1WVofKLA3mbwFgtlhim33H5US8VmVuO0r95i36SykKDVSOOpnFl6Iw7NgzkgQBMLgk
         8Fyw==
X-Gm-Message-State: APjAAAUDaeE9IiR2pqlofRk9ulDj0cSvZ/qlKRF9bbpf49IVFSKHc9EP
        JwCFtons9TTHw4JRYi/ay8Q2/2rDiLMcmCKlHK+PVg==
X-Google-Smtp-Source: APXvYqw6pd4yjfdwQRggompEMocfN8boHx/r12rCFwETnJWYtleJkvd+lh0eWE5bG9zHsQ8X/ScjzEo9GOm21DSkoKY=
X-Received: by 2002:a17:906:ecf0:: with SMTP id qt16mr8064275ejb.166.1559292751688;
 Fri, 31 May 2019 01:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <CADiuDASOCJbnwLs-LEp0aCX+T4dMvFfKQv_zsypHW-iSF8wW=Q@mail.gmail.com>
 <5c5609d8-e4b4-3561-ece9-93746fd46206@acm.org> <69308786-81d8-a9df-2d7b-df37c3f93026@suse.de>
 <CADiuDATRN_85Tu3uw1WBtY=m8KrqKV5zpYrsggYdAOH23dwU=Q@mail.gmail.com> <9612602b-29c0-04d7-b76e-5593d0936eba@suse.de>
In-Reply-To: <9612602b-29c0-04d7-b76e-5593d0936eba@suse.de>
From:   Christian Svensson <christian@cmd.nu>
Date:   Fri, 31 May 2019 10:52:17 +0200
Message-ID: <CADiuDARPit+kKtQe-UGktUuxEXRMvoq7PGVPKo9DrLRkSTwNAA@mail.gmail.com>
Subject: Re: [Open-FCoE] FICON target support
To:     Hannes Reinecke <hare@suse.de>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-scsi@vger.kernel.org,
        fcoe-devel@open-fcoe.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi,

On Fri, May 31, 2019 at 10:08 AM Hannes Reinecke <hare@suse.de> wrote:
> There are easier ways for this ... I'd start with virtio-ccw and
> implement a virtual PUNCHER there ...

The larger project scope is making FICON accessories more available
for people as crazy as I, that is wanting to run a mainframe as a
hobbyist, but maybe not want to buy a metric ton worth of disks or
tape robots (a 700 kg mainframe is hard enough by itself to house).

I will take a look, but from the name of it it sounds like it will not
help me much getting FICON targets supported.
Maybe it will help if I ever want FICON initiator.

> Still, an uphill struggle; IBM is notorious for not giving out details
> about the internals, and simulating a puncher is one of these things.
> (And slightly pointless, but who am I to judge ...)

It's a low-speed peripheral that has been emulated successfully in
Hercules, and there
are some petty detailed documents around the CCWs for 3505 around. I
figured it would
be a good start getting a FICON user-space thing implemented, before I
try to tackle e.g. ECKDs or tapes.

> However, I do wonder how you came by an FC analyser ... any chance of me
> borrowing it occasionally?

If you search for Cisco DS-PAA-2 you will find an old accessory used to debug
Cisco SAN switches for FC. It only supports 1 and 2 Gigabit, but the
nice thing is
that it encapsulates the packets as Ethernet frames so you can use
e.g. Wireshark
to debug what is going on. They cost around $50 on eBay. I have an
extra that I probably
will not use if you want it. It arrived yesterday so I have not had
time to verify the function
yet but it should be dead simple that it should work for anything
using FC-1 coding I guess.

Regards,
Chris
