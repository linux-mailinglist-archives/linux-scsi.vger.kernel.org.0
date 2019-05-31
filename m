Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6E7D30D87
	for <lists+linux-scsi@lfdr.de>; Fri, 31 May 2019 13:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbfEaLvS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 31 May 2019 07:51:18 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40193 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfEaLvS (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 31 May 2019 07:51:18 -0400
Received: by mail-ed1-f67.google.com with SMTP id r18so13123108edo.7
        for <linux-scsi@vger.kernel.org>; Fri, 31 May 2019 04:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmd.nu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iyUDlW1msJP/y+WHBRv5Y/F3Etkkr40xnDUAAmLBbZM=;
        b=Io07Tkbz1INSOPmRg84brJZtNQ+uSPx0luWCmyg+OKOzuRkYG9ZTwX3nB1DPdpxkmZ
         9OB3nqXT7AS7gIFkZzFANcFOwe0PsE0GmenQezdWRBBXKU6162mo2FWgr3/uxRsmKPm2
         2l4C9PGtGsYCLD94B12W9io/9SwUe1poAyg5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iyUDlW1msJP/y+WHBRv5Y/F3Etkkr40xnDUAAmLBbZM=;
        b=Hr/Lhjqomf8V8vFuUUiR2dTFRFba5Qat4qqryKA2D/lfC0aCcGrkpkpHIvUAXgnY+P
         vZZ1Yfe9P1645tZpBDBkYfO496cadsIf13Pz0IlbVyJmhJQL+9UQl1RpZ4EoC8OAR70+
         6cKALU7mRQewq8vBmu9rhjihUmTOy+qC2QaUnqaOPIquhNSmWeNvKxsg9ErGTwxLbAyW
         TB3zGU8l7lLQlTkLZYdpTs4CMAaoNV1ddFXQ/ovm6vC4hLbs5hwx0qOoMBtMK+7gx/62
         TTZ61nc+y76O+09TW1286vAvIWIMwV23itsyTPm9516s+FkQeRDEIRhZzgqQUkY+oFSY
         ErSw==
X-Gm-Message-State: APjAAAVYBqPf7ePMWqOiwhKKX/inW+zto7OPatqbzIqYU0NdErsNrl4m
        jK/ttzS4F+CVrVKahpBb2eZs2Hh3WeWCeLQN3N820g==
X-Google-Smtp-Source: APXvYqwJ+XjhTrxDqg2n8Gzqp2JjbmTeZjnINuoat8K5ZbgK/l83YUl/ih7uyUpWyBrLJdWBCUl2y7l02RfLDAPqsv0=
X-Received: by 2002:a17:906:d185:: with SMTP id c5mr8561779ejz.243.1559303476669;
 Fri, 31 May 2019 04:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <CADiuDASOCJbnwLs-LEp0aCX+T4dMvFfKQv_zsypHW-iSF8wW=Q@mail.gmail.com>
 <5c5609d8-e4b4-3561-ece9-93746fd46206@acm.org> <69308786-81d8-a9df-2d7b-df37c3f93026@suse.de>
 <CADiuDATRN_85Tu3uw1WBtY=m8KrqKV5zpYrsggYdAOH23dwU=Q@mail.gmail.com>
 <9612602b-29c0-04d7-b76e-5593d0936eba@suse.de> <CADiuDARPit+kKtQe-UGktUuxEXRMvoq7PGVPKo9DrLRkSTwNAA@mail.gmail.com>
 <17f0639d-bd44-c193-af29-df539be722fe@suse.de>
In-Reply-To: <17f0639d-bd44-c193-af29-df539be722fe@suse.de>
From:   Christian Svensson <christian@cmd.nu>
Date:   Fri, 31 May 2019 13:51:05 +0200
Message-ID: <CADiuDASfjq=xyuTEF2VZtb+dV78_VdMRkfFrr4ujs0zPXjv7Ew@mail.gmail.com>
Subject: Re: [Open-FCoE] FICON target support
To:     Hannes Reinecke <hare@suse.de>
Cc:     Bart Van Assche <bvanassche@acm.org>, linux-scsi@vger.kernel.org,
        fcoe-devel@open-fcoe.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, May 31, 2019 at 12:17 PM Hannes Reinecke <hare@suse.de> wrote:
> The biggest problem, however, will be to get the documentation from the
> HBAs themselves.
> All FC HBAs will present you with some version of cooked frames, and not
> allow you to access the frames themselves. So in the end you'd have to
> see to get hold of the HBA documentation itself, as you need to figure
> out how to pass FICON frames into the HBA.

Ah, I was hoping that it would cook the frames up to but not including
the FC-4 layer. If you have data or experience to share about that not
being the case I would love to hear about it. If it is just a hunch
there is some value of me going down that path to confirm it is the
case, but if you know for sure I'd prefer to not waste the time and
maybe go the FCoE route instead.

I also have some old FICON HBA cards I have gotten my hands on from
virtual tape servers which I know speaks FICON, but getting some
standard FC HBA to talk an acceptable level of FICON would be the
absolute best if at all possible. The QLogic HBA *controller* says
that it supports FC-SB-3 on the datasheet, although the card does
*not* explicitly say so, but that could be a marketing thing as well I
am thinking.

> Sadly you'd need an FCoE bridge then to hook up the mainframe.
> But as you have gotten hold of an FC analyser, getting an FCoE bridge
> shouldn't be too hard, too :-)

Indeed it would not be a big issue to source an FCoE -> FC SAN switch,
but it would make the whole solution more elaborate that I would
ideally like. However, it is an interesting model for the first
version.

Thanks for all the ideas,
Chris
