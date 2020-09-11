Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793BA265EE7
	for <lists+linux-scsi@lfdr.de>; Fri, 11 Sep 2020 13:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725770AbgIKLke (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 11 Sep 2020 07:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbgIKLjT (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 11 Sep 2020 07:39:19 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F92C061757
        for <linux-scsi@vger.kernel.org>; Fri, 11 Sep 2020 04:39:13 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id o6so8078265ota.2
        for <linux-scsi@vger.kernel.org>; Fri, 11 Sep 2020 04:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rxn/rHXMuJKpAmwAoX0UMhVmMks7/+TlP/YTbCHZI9Q=;
        b=NXFBy/iBibYuDhvWIuy1AYlz57uUxKxsAXeKkaMhZQCDoJBsuKAih4pEd9AFd4e73X
         xw0YSXrX1ERw8FM0SdtskzwONjd4QDXeVH5ZcMWZ9exqdgXyNBfJ0hrgX0iB5pxYbRpM
         zMrqQG98+dO2eDBtkZRzDHvHZ+KydlMAbcRcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rxn/rHXMuJKpAmwAoX0UMhVmMks7/+TlP/YTbCHZI9Q=;
        b=V3J1SSxzs6h8OKPHb+rNZip/paZ0suLs+qUZwF+reQQ5pTCDcAzkQIdxrxq8A7PTLh
         6KuHRUfLF1sP7WFMwjhWHa4hVCMUjib9A7bIfUctaDNSnl1c3Y6Fq1tAhNIiCIky+JZx
         h5nSi/a3TYySIpC/3ha5VBiPWOSiKTe9i4FwhfltsojrR0GGXbmV1EHZqk16ytlhoucN
         AgFXCUxzWmJ2A5dhOIBq7qHD6vgQtUCb3NcVyhv6HfJeu5lGqNZzTqJW50SOQuQSnQJ4
         o2sbSta5SWQh64diTOYy4W2l0S7//24FgwvyTxyR/sMYAYQKt1aFjW/h+2rXpKGvrp1/
         hKJw==
X-Gm-Message-State: AOAM533UqP7xFCa6AGMTtTU7S49X9hJdNg0n4t+f9zrf3+BFfgHaXTwk
        HRT1FCyDuzBwaqNJbR39OO0YQp6+9Uj32HFTIY/yQw==
X-Google-Smtp-Source: ABdhPJzrmDH440Cv1FzvL1QfAj6PUMek/yHY7sUzL9DpdcE9y8oI3a2w7+UWkioXVElthl6MbS8XQlAjz6A9NPt3P9E=
X-Received: by 2002:a05:6830:1312:: with SMTP id p18mr980786otq.316.1599824352922;
 Fri, 11 Sep 2020 04:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200814130426.2741171-1-sreekanth.reddy@broadcom.com>
 <yq1a6yoviti.fsf@ca-mkp.ca.oracle.com> <CAK=zhgq-5CNQObiwDutLPGG3CbmpAbj+RbDGX-xGu6mVP_WZYw@mail.gmail.com>
 <yq1r1rvqxqe.fsf@ca-mkp.ca.oracle.com> <CAK=zhgpg754D6J6k3s+xmyxH+2MGWjuNb44Tfccq2z+gFuLPRA@mail.gmail.com>
 <yq1d02v4pxt.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1d02v4pxt.fsf@ca-mkp.ca.oracle.com>
From:   Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Date:   Fri, 11 Sep 2020 17:09:01 +0530
Message-ID: <CAK=zhgqXMLL1YJ0-0CAv0dSCyczgp34sac986-oORwUU5r-pZg@mail.gmail.com>
Subject: Re: [PATCH v1] mpt3sas: Add support for Non-secure Aero and Sea PCI IDs
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, Sep 9, 2020 at 8:32 AM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Sreekanth,
>
> > Broadcom adapters participate in a Secure Boot process, where every
> > piece of FW is digitally signed by Broadcom and is checked for a valid
> > signature.  If any piece of our adapter FW fails this signature check,
> > it is possible the FW has been tampered with and the adapter should
> > not be used.  Our driver should not make any additional access to the
> > =E2=80=9Cinvalid/tampered=E2=80=9D adapter because the FW is not valid =
(could be
> > malicious FW). This type of detection is added into latest Aero and
> > Sea family adapters h/w.
>
> While I appreciate the intent, I would still like there to be an option
> to permit using the adapter. I am concerned about users being unable to
> boot their system due to this if, for whatever reason, these validation
> checks fail. Maybe there is limited risk of that happening since this is
> restricted to Aero and Sea adapters. But I am still concerned about
> enforcing policy decisions like this in the kernel.

These non-secure PCI Ids are very unlikely to happen as they are not
actual IDs instead they get exposed when something wrong happens in
the controller and it is good to prevent boot instead of giving an
ability for an user to run malicious code.

Also, This is an extremely unlikely event, and is evidence of physical
tampering at the ASIC level.

- If the executing firmware is authentic, signed Broadcom firmware, it
will halt due to the evidence of physical tampering and you won't have
a working controller anyway.

- If the executing firmware continues to run, then that means that the
physical attack has somehow succeeded and allowed the firmware to
bypass some part of the signature check, since authentic firmware
would have halted. In this case, the driver should reject the
controller/firmware combination

Thanks,
Sreekanth

>
> --
> Martin K. Petersen      Oracle Linux Engineering
