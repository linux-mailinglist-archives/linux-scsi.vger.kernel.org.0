Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7DC4A74A
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 18:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbfFRQpO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Jun 2019 12:45:14 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36987 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729319AbfFRQpN (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 18 Jun 2019 12:45:13 -0400
Received: by mail-io1-f68.google.com with SMTP id e5so31463029iok.4
        for <linux-scsi@vger.kernel.org>; Tue, 18 Jun 2019 09:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M4pkVFTS5H3fEaRKyRr0r0IcbB3tIkT7K9Ev0bH3fSo=;
        b=GijalqFG2AXRml91WhdEX1F9kss61I8xQ+AJd2pBjPu8G8Ht4q0otO0d1OouMU32yh
         +gNAfhWXSkegARxdLIGr8djyg8xyIEWYqNFXgXiUDOfDGcBH/sWdwB7CoLDDXr5nV4Zm
         yq+NeqPN5b6/kqtWdg76IokcaqW34+gkWbwbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M4pkVFTS5H3fEaRKyRr0r0IcbB3tIkT7K9Ev0bH3fSo=;
        b=GUF2VnfZrIy2opVZxEDtOnyyWyP4ON/Bgj0VMZywBqoOfDaPzAlxqcna6tzxEASXwe
         TNXJ4+ZXL6tMWChXAca7efcJVrnKzPbSBZYKRHhfo5Dzpwtn5vKQon0+4MiCWQJF27cX
         u7648H0TuUm7WaKh5SeRiwIv2i8ANCNr30i1a7REA1KjKdziYggH4n8LYJCyZRcWdqps
         u/+0cGRBHiHXR61+4gLaZROrcCeUjnRMHAL9XI4hFs1XzN7wxt2mW+sS5VyIKuw3P3Ox
         1eZBGCkldj+JZ3XoJ0g1lnkd/59nEwiac6QUO84x3z2lzUPfK1SrznrbUDOVCRDOnxQr
         Jg+w==
X-Gm-Message-State: APjAAAXlUhqlukB1C6DEzNXVTRxS6fe1tvoZdFTGZ8M5z4zBTNUDlXiC
        tdjITFKfbym9P6L3RQL85/iSN7UTcOmKJ+4dYqnRKbxfLhCFjGFr
X-Google-Smtp-Source: APXvYqzBds9GyFTBw8Gk5cSBciyBaPCWw8g345lU2atMgoYJ7PwKPVuULr6FAoamhEI0J4tgXv07S2abynn5JW4zOck=
X-Received: by 2002:a5d:8252:: with SMTP id n18mr2110621ioo.230.1560876312621;
 Tue, 18 Jun 2019 09:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190531121443.30694-1-suganath-prabu.subramani@broadcom.com>
 <yq1r285jwmg.fsf@oracle.com> <3bbff3d0ec462217333a34a2f416ec51@mail.gmail.com>
 <yq11s05jq74.fsf@oracle.com>
In-Reply-To: <yq11s05jq74.fsf@oracle.com>
From:   Kashyap Desai <kashyap.desai@broadcom.com>
Date:   Tue, 18 Jun 2019 22:15:00 +0530
Message-ID: <CAHsXFKERL+ZcGMnBbvQQoH5aejmf=-v+p_ahbzP-2-J7d3GcnQ@mail.gmail.com>
Subject: Re: [V3 00/10] mpt3sas: Aero/Sea HBA feature addition
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, Jun 7, 2019 at 10:19 PM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Kashyap,
>
> > AMD EPYC is not efficient w.r.t QPI transaction.
> [...]
> > Same test on Intel architecture provides better result
>
> Heuristics are always hard.
>
> However, you are making assumptions based on observed performance of
> current Intel offerings vs. current AMD offerings. This results in what
> is inevitably going to be a short-lived heuristic in the kernel. Things
> could easily be reversed in next generation platforms from these
> vendors.
>
> So while I appreciate that the logic works given the machines you are
> currently testing, I think CPU manufacturer is a horrible heuristic. You
> are stating "This will be the right choice for all future processors
> manufactured by Intel". That's a bit of a leap of faith.
>
> Instead of predicting the future I prefer to make decisions based on
> things we know. Measured negative impact on current EPYC family, for
> instance. That's a fairly well-defined and narrow scope.
>
> That said, I am still not a big fan of platform-specific tweaks in
> drivers. While I prefer the kernel to do the right thing out of the box,
> I think the module parameter is probably the better choice in this case.

Martin,
If we decide to remove cpu arch check later, things will be
unnecessary complex to explain default driver behavior as we may have
two driver behaviors.
We are going to remove cpu architecture detection logic. It is good to
have module parameter based dependency from day one.
We will be sending relevant patch soon.

Kashyap


>
> --
> Martin K. Petersen      Oracle Linux Engineering
