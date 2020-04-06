Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9D3319EF08
	for <lists+linux-scsi@lfdr.de>; Mon,  6 Apr 2020 03:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgDFBOo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 5 Apr 2020 21:14:44 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:41637 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgDFBOn (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 5 Apr 2020 21:14:43 -0400
Received: by mail-il1-f196.google.com with SMTP id t6so13096501ilj.8;
        Sun, 05 Apr 2020 18:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YwCOIl6rg+llGZKcQOSC7VcoDmT0lOYkJHour7MlvaM=;
        b=G2nMMa+I1IjhF8SmsMgqfF0rS+tfh09srGUsjcuZB0bdex0yF9/ofZ3h2KCYEG9Txw
         tC87qqVAbqXPwXgqgxQ0mqtaVVs5SovPKrJ/6G00gPglDwop3n2CqA10y/Xmnltf0FFX
         6cSPk3Z6yKqa8eOAQV7Lb5dfUxYEAbtyPECT5mwu1tjYCObrSWQf8O8BgsoFdyz5x/Uk
         9y79+ULN+hwvvgejTaAxr3/YsqLV9cnoESZZOkggXQTcBZL2Bzhj3jZqK5LGv6VZk8aw
         DCNH9Gc9B/BnAYqusUP+M+e4C+yCPSsF+cbwfTNS1mpyrDoIFIutQ0YVcDkAfJpVTsNy
         X3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YwCOIl6rg+llGZKcQOSC7VcoDmT0lOYkJHour7MlvaM=;
        b=NKNgj2pDFh5qsyjDRoznr18h6izC6LLJA7YccXs9CdD9AzDwEXUjmTzoVbVbFslnq0
         vgzIis6Es0+Aj2pGnpWgvslhYv3L+wUceXrJfeC4EoLYlS/W2ZDSYUfUFUyBuSt3nwWw
         NUAkian4G5auBELJcJDG7VLh81tjCLeIj5VTyjZ+d5M+8GMnV9i+7fW+smMKizbZ3LMr
         kG0e9EB1IGF16zlYrw0Ek0pXJOd7YAkQ318b9XFhVB4TOs7EAwYCWldWcWdnNT/WKWgq
         3DRvUnL7dsXZU/tBl4FvjK0ufiOgp/9YSCav52QvMGZ0cCJev/O8UoAIeoxukn1q2qtp
         sGng==
X-Gm-Message-State: AGi0Puae36papi9xEAClFU+yImlnIZsQN52LzsvEG6f5yoh9tIDL6HP4
        uBkLdPqIGHiczBvXA+FC1J7CvZS8uuMociW6406scAlm
X-Google-Smtp-Source: APiQypJAXKSDf3vMmm7PT7mvcGb0DoQBoXEZeZlhVWL4s6AoLunr+WnTx9OZQuzVhAUAOg6emDiQ1KxAH9kVccgCL8k=
X-Received: by 2002:a92:77c2:: with SMTP id s185mr18577266ilc.297.1586135682656;
 Sun, 05 Apr 2020 18:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <72bc89d5-cf50-3f3a-41e0-b46b134e754d@web.de>
In-Reply-To: <72bc89d5-cf50-3f3a-41e0-b46b134e754d@web.de>
From:   Qiujun Huang <hqjagain@gmail.com>
Date:   Mon, 6 Apr 2020 09:14:29 +0800
Message-ID: <CAJRQjocPmP0bEX5s-gkPh8w_=ndksxMF-Gx-rov1sJDO3r+TfA@mail.gmail.com>
Subject: Re: [PATCH] scsi: aic7xxx: Remove null pointer checks before kfree()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Alex Dewar <alex.dewar@gmx.co.uk>,
        Hannes Reinecke <hare@suse.com>,
        "James E. J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Sorry about nnnnoise, please just ignore it.

On Mon, Apr 6, 2020 at 4:02 AM Markus Elfring <Markus.Elfring@web.de> wrote=
:
>
> > NULL check before kfree is unnecessary so remove it.
>
> I hope that you would like to take another update suggestion into account
> (besides a typo correction for your commit message).
> https://lore.kernel.org/patchwork/patch/1220189/
> https://lore.kernel.org/linux-scsi/20200403164712.49579-1-alex.dewar@gmx.=
co.uk/
>
> Do you find a previous update suggestion like =E2=80=9CSCSI-aic7...: Dele=
te unnecessary
> checks before the function call "kfree"=E2=80=9D also interesting?
> https://lore.kernel.org/linux-scsi/54D3E057.9030600@users.sourceforge.net=
/
> https://lore.kernel.org/patchwork/patch/540593/
> https://lkml.org/lkml/2015/2/5/650
>
> Regards,
> Markus
