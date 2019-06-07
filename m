Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65F483971D
	for <lists+linux-scsi@lfdr.de>; Fri,  7 Jun 2019 22:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbfFGU4S (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 7 Jun 2019 16:56:18 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38988 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729891AbfFGU4S (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 7 Jun 2019 16:56:18 -0400
Received: by mail-lf1-f67.google.com with SMTP id p24so2603493lfo.6
        for <linux-scsi@vger.kernel.org>; Fri, 07 Jun 2019 13:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8YUpWDac11IVMJIEQjB9andWH6Qkg045nj0WucovtTw=;
        b=ZVAaBpbhtKkZzQN7swySTxihpcaXqQHMXI/gjmdzrbYX0rfhsWFmJVyFBycQxvcr2+
         6SS2z+fH2NXZcLkwUUbG2oj6RZQQcUJvB2hkk7vbb61cydbLxD9VQYCjwIPQfUQjX0mC
         LICqKgMOkaLPFMglPSVMiOKtX2ulkdjstxZ8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8YUpWDac11IVMJIEQjB9andWH6Qkg045nj0WucovtTw=;
        b=MQGlDohPnQEGcFRtESkSsyzC3I3V1miD2ljxzXrlJvS5DlhTH+SdbRNjpQQM5J3rjZ
         LBF9dyioTA2oAY0xQhYs1t3U5TuI7MzpwiBnbvK0+bCfcmowyqotT8iBmytLN47RDBQw
         5fQ5vmwqEWaOUn0CYq+USpNaGiIjHm7EpcY/JR1rJHtJtTx0tY9DX8kivi10QhZi34w6
         onTjYuRTyr2XSVDHVf8mCYYmBD8qpHdv0jvahmP3ltLeaOWVywArIEl2iUkuIC5TDZqH
         VvddUp4ubclLuQGmXCiCrFLokbEwCN5mbhKs+pEHGZQ2hTqdnzWCPQ6XmAUqMq8+n6Av
         nREg==
X-Gm-Message-State: APjAAAVe44Wn3t4mc69mNFwlc3q/xp4ip50jHG6NoqnfGBEwFSPeYzs1
        4pmUDIvgyGFTf41ASrSCnHPa6U6vVsA=
X-Google-Smtp-Source: APXvYqyWw9TaR+XIYgCdoZTsXIaGhdwJKwADGLwdGJrU4Mj897YTC6K/C0RERYmP94VjpgY16f0BCw==
X-Received: by 2002:ac2:48a5:: with SMTP id u5mr21758816lfg.62.1559940976262;
        Fri, 07 Jun 2019 13:56:16 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id a29sm582085lfi.23.2019.06.07.13.56.15
        for <linux-scsi@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 13:56:15 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 136so2591675lfa.8
        for <linux-scsi@vger.kernel.org>; Fri, 07 Jun 2019 13:56:15 -0700 (PDT)
X-Received: by 2002:ac2:59c9:: with SMTP id x9mr27523797lfn.52.1559940974137;
 Fri, 07 Jun 2019 13:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190604093028.79673-1-hare@suse.de>
In-Reply-To: <20190604093028.79673-1-hare@suse.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Jun 2019 13:55:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg85nK-9JwOsx4RqbPpVoNsV3f9fnm9s=3nVoC34o7ePw@mail.gmail.com>
Message-ID: <CAHk-=wg85nK-9JwOsx4RqbPpVoNsV3f9fnm9s=3nVoC34o7ePw@mail.gmail.com>
Subject: Re: [PATCH] fcoe: avoid memset across pointer boundaries
To:     Hannes Reinecke <hare@suse.de>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, Jun 4, 2019 at 2:30 AM Hannes Reinecke <hare@suse.de> wrote:
>
> Gcc-9 complains for a memset across pointer boundaries, which happens
> as the code tries to allocate a flexible array on the stack.
> Turns out we cannot do this without relying on gcc-isms, so
> this patch converts the stack allocation in proper kzalloc() calls.

Getting back to this - maybe you already fixed this in your bigger
patch series, but I noted a problem with this:

>  static inline struct fcoe_rport *fcoe_ctlr_rport(struct fc_rport_priv *rdata)
>  {
> -       return (struct fcoe_rport *)(rdata + 1);
> +       return (struct fcoe_rport *)(&rdata->rpriv);
>  }
...
> @@ -212,6 +212,7 @@ struct fc_rport_priv {
>         struct rcu_head             rcu;
>         u16                         sp_features;
>         u8                          spp_type;
> +       char                        rpriv[];
>  };

The above does not work at all on machines that have alignment
constraints, because now your fcoe_rport pointer will be very much
mis-aligned.

The old "(rdata + 1)" thing was also potentially mis-aligned: the size
of "struct fc_rport_priv" is aligned, but it's aligned to the
alignment of fc_rport_priv, not to the alignment of struct fcoe_rport.

But in practice the old alignment was probably "good enough".

But the "char rpriv[]" model definitely has horrendous explicit
mix-alignment, with that previous single-byte spp_type member. It's
almost certainly at a 3-byte offset.

On x86, you won't notice. It won't even perform all that badly. But on
other architectures it might not work at all, or perform horribly
badly.

Using at least "u64 rpriv[]" might be better.  I didn't look at your
other patch version.

                 Linus
