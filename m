Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 625FA48531
	for <lists+linux-scsi@lfdr.de>; Mon, 17 Jun 2019 16:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfFQOU7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 Jun 2019 10:20:59 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:55955 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfFQOU6 (ORCPT
        <rfc822;groupwise-linux-scsi@vger.kernel.org:0:0>);
        Mon, 17 Jun 2019 10:20:58 -0400
Received: from [10.160.4.48] (charybdis.suse.de [149.44.162.66])
        by smtp.nue.novell.com with ESMTP (TLS encrypted); Mon, 17 Jun 2019 16:20:57 +0200
Subject: Re: [PATCH] fcoe: avoid memset across pointer boundaries
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi <linux-scsi@vger.kernel.org>
References: <20190604093028.79673-1-hare@suse.de>
 <CAHk-=wg85nK-9JwOsx4RqbPpVoNsV3f9fnm9s=3nVoC34o7ePw@mail.gmail.com>
From:   Hannes Reinecke <hare@suse.com>
Message-ID: <992bdcda-14d2-e5f3-5783-cf1a3022f40b@suse.com>
Date:   Mon, 17 Jun 2019 16:20:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wg85nK-9JwOsx4RqbPpVoNsV3f9fnm9s=3nVoC34o7ePw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/7/19 10:55 PM, Linus Torvalds wrote:
> On Tue, Jun 4, 2019 at 2:30 AM Hannes Reinecke <hare@suse.de> wrote:
>>
>> Gcc-9 complains for a memset across pointer boundaries, which happens
>> as the code tries to allocate a flexible array on the stack.
>> Turns out we cannot do this without relying on gcc-isms, so
>> this patch converts the stack allocation in proper kzalloc() calls.
> 
> Getting back to this - maybe you already fixed this in your bigger
> patch series, but I noted a problem with this:
> 
>>  static inline struct fcoe_rport *fcoe_ctlr_rport(struct fc_rport_priv *rdata)
>>  {
>> -       return (struct fcoe_rport *)(rdata + 1);
>> +       return (struct fcoe_rport *)(&rdata->rpriv);
>>  }
> ...
>> @@ -212,6 +212,7 @@ struct fc_rport_priv {
>>         struct rcu_head             rcu;
>>         u16                         sp_features;
>>         u8                          spp_type;
>> +       char                        rpriv[];
>>  };
> 
> The above does not work at all on machines that have alignment
> constraints, because now your fcoe_rport pointer will be very much
> mis-aligned.
> 
> The old "(rdata + 1)" thing was also potentially mis-aligned: the size
> of "struct fc_rport_priv" is aligned, but it's aligned to the
> alignment of fc_rport_priv, not to the alignment of struct fcoe_rport.
> 
> But in practice the old alignment was probably "good enough".
> 
> But the "char rpriv[]" model definitely has horrendous explicit
> mix-alignment, with that previous single-byte spp_type member. It's
> almost certainly at a 3-byte offset.
> 
> On x86, you won't notice. It won't even perform all that badly. But on
> other architectures it might not work at all, or perform horribly
> badly.
> 
> Using at least "u64 rpriv[]" might be better.  I didn't look at your
> other patch version.
> 
Thanks for the heads-up.
I actually had discussed the alignment problematic with our gcc folks,
and they claimed that the only portable way for specifying an abstract
array at the end of the structure was indeed to use 'char n[]'; they
claimed 'u64' would have different alignment issues etc and would only
work reliably on gcc.

So I might as well going back to the original style, as the offending
calls have been fixed with a different patch quite independently of this
issue.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare@suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
