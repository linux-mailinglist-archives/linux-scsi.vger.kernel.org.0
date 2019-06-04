Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17FBC33E8F
	for <lists+linux-scsi@lfdr.de>; Tue,  4 Jun 2019 07:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfFDFs2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Jun 2019 01:48:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:37186 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726606AbfFDFs2 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 4 Jun 2019 01:48:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5E71AAF6A;
        Tue,  4 Jun 2019 05:48:25 +0000 (UTC)
Subject: Re: Compiler warnings in FCoE code
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-scsi <linux-scsi@vger.kernel.org>
References: <CAHk-=whpO2zRWsoYMOQregiqnNGq11Ntog+oygcoU46cXb+mbQ@mail.gmail.com>
From:   Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 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
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <fff16805-6ad6-677c-8b45-b4a6ed67da58@suse.de>
Date:   Tue, 4 Jun 2019 07:48:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=whpO2zRWsoYMOQregiqnNGq11Ntog+oygcoU46cXb+mbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/3/19 11:20 PM, Linus Torvalds wrote:
> So gcc-9 has a new warning about doing memset() across pointer boundaries.
> 
> We didn't have a lot of these things, and most of them got fixed
> pretty quickly. The main remaining ones are oin FCoE, and look like
> this:
> 
> In function ‘memset’,
>     inlined from ‘fcoe_ctlr_vlan_parse’ at drivers/scsi/fcoe/fcoe_ctlr.c:2830:2,
>     inlined from ‘fcoe_ctlr_vlan_recv’ at drivers/scsi/fcoe/fcoe_ctlr.c:3005:7:
> ./include/linux/string.h:344:9: warning: ‘__builtin_memset’ offset
> [569, 600] from the object at ‘buf’ is out of the bounds of referenced
> subobject ‘rdata’ with type ‘struct fc_rport_priv’ at offset 0
> [-Warray-bounds]
>   344 |  return __builtin_memset(p, c, size);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In function ‘memset’,
>     inlined from ‘fcoe_ctlr_vn_parse’ at drivers/scsi/fcoe/fcoe_ctlr.c:2299:2,
>     inlined from ‘fcoe_ctlr_vn_recv’ at drivers/scsi/fcoe/fcoe_ctlr.c:2772:7:
> ./include/linux/string.h:344:9: warning: ‘__builtin_memset’ offset
> [569, 600] from the object at ‘buf’ is out of the bounds of referenced
> subobject ‘rdata’ with type ‘struct fc_rport_priv’ at offset 0
> [-Warray-bounds]
>   344 |  return __builtin_memset(p, c, size);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> and honestly, when I look at the code, I cannot help but agree with
> the new warning in this case (we had a few other cases where the
> warning was understandable but annoying, but in the FCoE case it's
> really "yeah, that code is wrong").
> 
> In particular, in fcoe_ctlr_vlan_parse(), the function is passed a
> "struct fc_rport_priv *rdata" pointer, and then it does
> 
>         memset(rdata, 0, sizeof(*rdata) + sizeof(*frport));
> 
> and honestly, that should make people go "WTF?". You got passed a
> pointer to one type, and then you clear not just that type, but
> another entirely unrelated type after it. That's just completely bogus
> and wrong.
> 
> In fact, what people *are* passing that thing is this:
> 
>         struct {
>                 struct fc_rport_priv rdata;
>                 struct fcoe_rport frport;
>         } buf;
> 
> but that doesn't actually make that "memset()" any more correct. It's
> still entirely wrong, because it's possible that "struct fcoe_rport"
> could have different alignment requirements etc, so maybe there's a
> gap between the two structures, and the memset() with just adding the
> sizes may be entirely bogus.
> 
> Now, in practice I think the code works, but I have to say that in
> this case the compiler warning is really quite correct. The code is
> wrong, even if it might happen to work.
> 
> That "combined struct of two types" needs to be made into a type of
> its own, and people need to use that.
> 
> I started doing that, but it turns out this mis-feature is deeply
> embedded in that file, and also exposed indirectly in the whole
> "struct fc_rport_operations", which uses a "event_callback" function
> pointer that has the bogus type.
> 
> End result: I don't know how to fix it, but the compiler is right.
> This code is wrong, and it needs to be fixed. Maybe "struct
> fc_rport_priv" could just be made to include that "struct fcoe_rport"
> as part of it? Maybe the event_callback() can be typed differently.
> But passing around a "struct fc_rport_priv" pointer that is actually
> *not* a pointer to just that thing, but must be a pointer to the
> combined data, is wrong. Something like
> 
>  struct fc_rport_combined_data {
>         struct fc_rport_priv rdata;
>         struct fcoe_rport frport;
>  };
> 
> may be needed, and then you pass a pointer to that. But it expands
> quite quickly because this seems to be common.
> 
> Related to this thing, the whole
> 
>    static inline struct fcoe_rport *fcoe_ctlr_rport(struct fc_rport_priv *rdata)
> 
> is part of the disease, and needs to go away. Passing the right
> "combined data" pointer around would have made that thing useless to
> begin with (ie "fcoe_ctlr_rport(rdata)" should become just
> "&buf->frport" instead if the types were done correctly).
> 
> Hmm? Please can some FCoE person look at this, because right now it
> causes tens of lines of warnings that make me go "yeah, the compiler
> is right".
> 
To hear is to obey :-)

I'll have a look.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
