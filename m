Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCE134E8C
	for <lists+linux-scsi@lfdr.de>; Tue,  4 Jun 2019 19:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfFDRQy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Jun 2019 13:16:54 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:37431 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbfFDRQy (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 4 Jun 2019 13:16:54 -0400
Received: by mail-lj1-f178.google.com with SMTP id 131so7919191ljf.4
        for <linux-scsi@vger.kernel.org>; Tue, 04 Jun 2019 10:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rL6ZOYcMvMPfXIJ4SmvftWqyOl57W9mSlapXsmnIpYs=;
        b=UcbsFVFvZb3Hv6/z6Rggy3vbTx4s8dZSofaInKLYfJp/pgSD0K+/+taUrsmzoy81Zh
         MydAJEMMMQ4I7RCX1M4mp/AqY2kEOonBQEFoRYX9A+4UHa2bD8+slLTWKoJrdp/IKyYg
         2mCRDOa2hLBW+2LzPkikz1BYL4DGy0fU6c+Ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rL6ZOYcMvMPfXIJ4SmvftWqyOl57W9mSlapXsmnIpYs=;
        b=sd9KUpy9rUzdTA0K7KczuSYjrHCRixHaGLuR8jU+WftuKG/m8esS32Ns0WKsVOHxa+
         dUUW5T96GL/u1EjNyDAgVb1YxcDvcT3VlAbfMBe3jVoYjPgRCRuaqsky6ImpLGK3F0fm
         u8eb/SwRUcj94LUW9d9/z8haHieqd0bt6SXPkn+AUOrtoSvarq6hVrcn1lFFc4rkS5II
         xLql8Wk88DmKQBGIU+/9yGgZD2/T+LynON6dg5nnN1cthGjK/47XyDbW17d9tuYGRNT+
         ga8JL9Z4bXCBYt9Akk8PF43hPtgnWbzD/iW05g83Y1EbmoYg6BTOA74GavNk1v/uCInq
         6vBA==
X-Gm-Message-State: APjAAAW6XagKO05NZ1BkZc3axcaongFj/ar/+vdFPv6TrBrZy7/hy3DY
        rPDmGRZ86QHFbMgul+vufEj5oXuyo74=
X-Google-Smtp-Source: APXvYqxWrGOad0uwlE8F58eDhiq9yiNaf4imIxrLlClslpnnODOiCg+MuNdW8+0f4UvxWorT39wb9A==
X-Received: by 2002:a2e:b0d5:: with SMTP id g21mr563164ljl.152.1559668611507;
        Tue, 04 Jun 2019 10:16:51 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id q13sm3791254lfk.65.2019.06.04.10.16.50
        for <linux-scsi@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 10:16:50 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id p24so10567985lfo.6
        for <linux-scsi@vger.kernel.org>; Tue, 04 Jun 2019 10:16:50 -0700 (PDT)
X-Received: by 2002:ac2:59c9:: with SMTP id x9mr17104890lfn.52.1559668609778;
 Tue, 04 Jun 2019 10:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whpO2zRWsoYMOQregiqnNGq11Ntog+oygcoU46cXb+mbQ@mail.gmail.com>
In-Reply-To: <CAHk-=whpO2zRWsoYMOQregiqnNGq11Ntog+oygcoU46cXb+mbQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Jun 2019 10:16:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjYb1ThJUK76sthxmqfGU_w+_ux5j1Z+ePz1gGWwceNiA@mail.gmail.com>
Message-ID: <CAHk-=wjYb1ThJUK76sthxmqfGU_w+_ux5j1Z+ePz1gGWwceNiA@mail.gmail.com>
Subject: Re: Compiler warnings in FCoE code
To:     Hannes Reinecke <hare@suse.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Jun 3, 2019 at 2:20 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> In fact, what people *are* passing that thing is this:
>
>         struct {
>                 struct fc_rport_priv rdata;
>                 struct fcoe_rport frport;
>         } buf;

It is in fact worse than that.

Yes, _some_ people pass that combined struct.

But a lot of people pass around a fc_rport_priv that has just been
allocated with

        rdata = kzalloc(sizeof(*rdata) + lport->rport_priv_size, GFP_KERNEL);

in fc_rport_create().

They end up being somewhat equivalent as long as the alignments of
those sub-structures match, but it does mean that the type is really a
bit fluid, and it ends up leaking outside of that fcoe_ctlr.c file
into various other helper functions like that allocation function.

It really looks fairly nasty to change/fix. The code really is passing
around a 'struct fc_rport_priv' pointer, but that that 'fc_rport_priv'
type is then associated with the added 'struct fcoe_rport' at the end,
in a way that is *not* visible to the type system.

So no, it doesn't work to create a new type like

 struct fc_rport_combined_data {

because it ends up affecting almost *everything* that works with that
'rdata' thing.

I get the feeling that 'struct fc_rport_priv' should just be extended
to have 'struct fcoe_rport' at the end, but maybe that's not always
true? It looks like that is only used for FIP_MODE_VN2VN, adn then we
have some other mode that doesn't have that allocation at all?

So the code seems to be a mix of dynamic typing ("no fcoe_rport at the
end") and static typing that just assumes that the allocation always
has the fcoe_rport afterwards.

Would it be ok to make 'struct fc_rport_priv' just always contain that
fcoe_rport? Getting rid of the "lport->rport_priv_size" thing
entirely, and just have the type set to the bigger case
unconditionally?

                  Linus
