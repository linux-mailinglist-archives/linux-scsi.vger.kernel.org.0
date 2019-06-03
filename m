Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1651B33A04
	for <lists+linux-scsi@lfdr.de>; Mon,  3 Jun 2019 23:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfFCVo3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 3 Jun 2019 17:44:29 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:36764 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfFCVo2 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 3 Jun 2019 17:44:28 -0400
Received: by mail-lj1-f177.google.com with SMTP id i21so3140095ljj.3
        for <linux-scsi@vger.kernel.org>; Mon, 03 Jun 2019 14:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=qxSXqqQE6XDV0pJn4ln6Tb/GK9vrKUXeNjK3sXRhBAI=;
        b=S5HcXZ7NEL9l7rq4PA6lYi1ipF1obsb7+YCau1uKxPzM2TyAFJMPtTvoKBjFPSnDPj
         EJCEZO2QA6HgwX4dvcFoSU0lr2l5SJyZToHHYjPkvggieMSNL2g+36vQXPt1OKj3mzI5
         LkF57ZXsijVVmVORxkq7X/w8R1aNigZE6K7aM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=qxSXqqQE6XDV0pJn4ln6Tb/GK9vrKUXeNjK3sXRhBAI=;
        b=Af5+i8fdrgURc4fWfhSEYFgJabRADsgl6hgTeG5TOUWBfL63e01R8CtzhuMyd2B0uY
         RkVgj/iRpEVQcrLRCIGDhuIRr78K6sJMZ2QThC5MKzfLcGvQATsd88pIsZQ1vYqrb7EQ
         jF2aJy9QPutF9kfu2C4tZ/GlYU3a0V+hjNoEBlZdqW19dRazonVkv9aBYxd0CKgxDGlB
         151BZpZ5i9NyeJB9wFZURdhT34VtOqn2eAm8ghgoluwvYqVImVpk79Vx/8qZSYqPSYfd
         yO4cBm2C1IfflMiX4k7n6SHFGG03teUfrVE99yStCi7hL7AIjRungqgyIktmArsMz35s
         yZiA==
X-Gm-Message-State: APjAAAUFhO8YCrVTJjkPG2fwFJwFe2tI1mgZsZ2w3nzcJgUsNWysaRdw
        O+78bMyezKthAOLsVuAYP5vZ76eFlx8=
X-Google-Smtp-Source: APXvYqzWsi+vDRTqkk6+4gwMflanC5lj64xbatSEEQEKgVB20i7yopJSzLWvvGScuZ3r27GEtiJ1TA==
X-Received: by 2002:a2e:9a89:: with SMTP id p9mr387353lji.113.1559596860121;
        Mon, 03 Jun 2019 14:21:00 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 80sm3378273lfz.56.2019.06.03.14.20.58
        for <linux-scsi@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 14:20:59 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id o13so17645457lji.5
        for <linux-scsi@vger.kernel.org>; Mon, 03 Jun 2019 14:20:58 -0700 (PDT)
X-Received: by 2002:a2e:85d1:: with SMTP id h17mr14869316ljj.1.1559596858655;
 Mon, 03 Jun 2019 14:20:58 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Jun 2019 14:20:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=whpO2zRWsoYMOQregiqnNGq11Ntog+oygcoU46cXb+mbQ@mail.gmail.com>
Message-ID: <CAHk-=whpO2zRWsoYMOQregiqnNGq11Ntog+oygcoU46cXb+mbQ@mail.gmail.com>
Subject: Compiler warnings in FCoE code
To:     Hannes Reinecke <hare@suse.de>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-scsi <linux-scsi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

So gcc-9 has a new warning about doing memset() across pointer boundaries.

We didn't have a lot of these things, and most of them got fixed
pretty quickly. The main remaining ones are oin FCoE, and look like
this:

In function =E2=80=98memset=E2=80=99,
    inlined from =E2=80=98fcoe_ctlr_vlan_parse=E2=80=99 at drivers/scsi/fco=
e/fcoe_ctlr.c:2830:2,
    inlined from =E2=80=98fcoe_ctlr_vlan_recv=E2=80=99 at drivers/scsi/fcoe=
/fcoe_ctlr.c:3005:7:
./include/linux/string.h:344:9: warning: =E2=80=98__builtin_memset=E2=80=99=
 offset
[569, 600] from the object at =E2=80=98buf=E2=80=99 is out of the bounds of=
 referenced
subobject =E2=80=98rdata=E2=80=99 with type =E2=80=98struct fc_rport_priv=
=E2=80=99 at offset 0
[-Warray-bounds]
  344 |  return __builtin_memset(p, c, size);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
In function =E2=80=98memset=E2=80=99,
    inlined from =E2=80=98fcoe_ctlr_vn_parse=E2=80=99 at drivers/scsi/fcoe/=
fcoe_ctlr.c:2299:2,
    inlined from =E2=80=98fcoe_ctlr_vn_recv=E2=80=99 at drivers/scsi/fcoe/f=
coe_ctlr.c:2772:7:
./include/linux/string.h:344:9: warning: =E2=80=98__builtin_memset=E2=80=99=
 offset
[569, 600] from the object at =E2=80=98buf=E2=80=99 is out of the bounds of=
 referenced
subobject =E2=80=98rdata=E2=80=99 with type =E2=80=98struct fc_rport_priv=
=E2=80=99 at offset 0
[-Warray-bounds]
  344 |  return __builtin_memset(p, c, size);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~

and honestly, when I look at the code, I cannot help but agree with
the new warning in this case (we had a few other cases where the
warning was understandable but annoying, but in the FCoE case it's
really "yeah, that code is wrong").

In particular, in fcoe_ctlr_vlan_parse(), the function is passed a
"struct fc_rport_priv *rdata" pointer, and then it does

        memset(rdata, 0, sizeof(*rdata) + sizeof(*frport));

and honestly, that should make people go "WTF?". You got passed a
pointer to one type, and then you clear not just that type, but
another entirely unrelated type after it. That's just completely bogus
and wrong.

In fact, what people *are* passing that thing is this:

        struct {
                struct fc_rport_priv rdata;
                struct fcoe_rport frport;
        } buf;

but that doesn't actually make that "memset()" any more correct. It's
still entirely wrong, because it's possible that "struct fcoe_rport"
could have different alignment requirements etc, so maybe there's a
gap between the two structures, and the memset() with just adding the
sizes may be entirely bogus.

Now, in practice I think the code works, but I have to say that in
this case the compiler warning is really quite correct. The code is
wrong, even if it might happen to work.

That "combined struct of two types" needs to be made into a type of
its own, and people need to use that.

I started doing that, but it turns out this mis-feature is deeply
embedded in that file, and also exposed indirectly in the whole
"struct fc_rport_operations", which uses a "event_callback" function
pointer that has the bogus type.

End result: I don't know how to fix it, but the compiler is right.
This code is wrong, and it needs to be fixed. Maybe "struct
fc_rport_priv" could just be made to include that "struct fcoe_rport"
as part of it? Maybe the event_callback() can be typed differently.
But passing around a "struct fc_rport_priv" pointer that is actually
*not* a pointer to just that thing, but must be a pointer to the
combined data, is wrong. Something like

 struct fc_rport_combined_data {
        struct fc_rport_priv rdata;
        struct fcoe_rport frport;
 };

may be needed, and then you pass a pointer to that. But it expands
quite quickly because this seems to be common.

Related to this thing, the whole

   static inline struct fcoe_rport *fcoe_ctlr_rport(struct fc_rport_priv *r=
data)

is part of the disease, and needs to go away. Passing the right
"combined data" pointer around would have made that thing useless to
begin with (ie "fcoe_ctlr_rport(rdata)" should become just
"&buf->frport" instead if the types were done correctly).

Hmm? Please can some FCoE person look at this, because right now it
causes tens of lines of warnings that make me go "yeah, the compiler
is right".

                 Linus
