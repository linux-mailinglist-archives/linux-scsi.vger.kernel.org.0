Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24E3B38F4D
	for <lists+linux-scsi@lfdr.de>; Fri,  7 Jun 2019 17:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbfFGPkR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 7 Jun 2019 11:40:17 -0400
Received: from mail-it1-f180.google.com ([209.85.166.180]:51730 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728783AbfFGPkR (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 7 Jun 2019 11:40:17 -0400
Received: by mail-it1-f180.google.com with SMTP id m3so3394662itl.1
        for <linux-scsi@vger.kernel.org>; Fri, 07 Jun 2019 08:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=sCANWS/o3w/t5Kzls63SiJuAjIJO7YhzcxFP85ToMiU=;
        b=IZ9bTkaniqig1Mr6rfH9TjINtcOYMmUbUjEYdG+RJUBE7unRMLwAPg9mS9AEn7vp1h
         1iMLEUWOcLf+VoeNW9oJP8bk8fTHAbF082JDtva33h9XC6vlof+FP14/Tv20hhO9IMTv
         TY9zoTHgciNRoytKTHbxiKnESH1Dw9elRlGaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=sCANWS/o3w/t5Kzls63SiJuAjIJO7YhzcxFP85ToMiU=;
        b=XgMWkktQLvVKocsnTFPbSORMYVqyYY8ik+Jog37k2Qj6hChkJnAdJ9+XqMw7SLgfcQ
         cSP4XXQKDRnhBYt+1PixwTA54SUpZmNGkI0RMgVvHhQwmMfz+8eaZ9ieCfTT1ZqQONhK
         TDKwUgxudIQtiVc/9PrUTNqZfIuZGJ+Gi3tFvx1RexSuj4A/m10JRxN2o98nuhEaNXRN
         XakFY4FDUBxcBPuh3QXDYZ5DLzSTdQgZNOMrmAcVK845t8pnhsLmSVIglncoFvEoEGm5
         RuF9nXIYBSxzO78iuCitXcvcRJJmSIU5q0T+Tn5XFEp2DTXIDE8ej+KthlVAoUb/WwYa
         nE7A==
X-Gm-Message-State: APjAAAVSDD+rZ4Q0WHxsTItAaok7zz3uHLy+DPxrJlb9A4R7ADPy895Y
        3VFJxYn9han+EitQ5+xkK4OtpYm92Uv3BP9dRqz3bw==
X-Google-Smtp-Source: APXvYqyboAHh1HhwvZe9jpMiYGR8qZvf3lFzrFOHxjVao6M3tF/Cjpp4iVYvMrHuuOiRgPikyqm6NAqi/rUeVAQeAt4=
X-Received: by 2002:a24:2792:: with SMTP id g140mr5009666ita.81.1559922016285;
 Fri, 07 Jun 2019 08:40:16 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <20190531121443.30694-1-suganath-prabu.subramani@broadcom.com> <yq1r285jwmg.fsf@oracle.com>
In-Reply-To: <yq1r285jwmg.fsf@oracle.com>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJHMVLl3xGW6KDulVZknB8uq36ppAHWKlfQpZ1vD6A=
Date:   Fri, 7 Jun 2019 21:10:14 +0530
Message-ID: <3bbff3d0ec462217333a34a2f416ec51@mail.gmail.com>
Subject: RE: [V3 00/10] mpt3sas: Aero/Sea HBA feature addition
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>
Cc:     linux-scsi@vger.kernel.org,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

>
> Suganath,
>
> I applied this series to 5.3/scsi-queue.
>
> However, I remain unconvinced of the merits of the config page putback.
Why
> even bother if a controller reset causes the defaults to be loaded from
> NVRAM?
>
> Also, triggering on X86 for selecting performance mode seems
questionable. I
> would like to see a follow-on patch that comes up with a better
heuristic.

Martin -

AMD EPYC is not efficient w.r.t QPI transaction.  I tested performance on
AMD EPYC 7601 Chipset. It has totally 128 logical CPU.
Aero/Sea controller support at max 128 MSIx vector. In good case scenario,
we will have 1:1 CPU to MSIX mapping.  I can get 2.4 M IOPS in this case.

Just to simulate performance issue, I reduce controller msix vector to 64.
It means cpu to msix mapping is 2:1. Indirectly, I am trying to generate
completion which requires completion on remote cpu (via
call_function_single_interrupt).
In this case, I can get 1.7M IOPS.

Same test on Intel architecture provides better result (Negligible
performance impact).  This patch set maps high iops queues (queues with
interrupt coalescing turned on) to local numa node.
High iops queue count is limited and it depends upon QPI for io
completion.  We have enable this feature only for intel arch where we have
seen improvement.  Not having this feature is not bad, but if we enable
this feature we may get negative impact if QPI overhead (like AMD) is
high.

Kashyap

>
> --
> Martin K. Petersen	Oracle Linux Engineering
