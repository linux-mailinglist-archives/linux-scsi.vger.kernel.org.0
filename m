Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFDDD5A572
	for <lists+linux-scsi@lfdr.de>; Fri, 28 Jun 2019 21:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbfF1Tvi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 28 Jun 2019 15:51:38 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37794 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbfF1Tvi (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 28 Jun 2019 15:51:38 -0400
Received: by mail-yw1-f65.google.com with SMTP id u141so2076184ywe.4
        for <linux-scsi@vger.kernel.org>; Fri, 28 Jun 2019 12:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JnkachwQP0cyQ9JdMbTUnW5qndJ/fTXRxpRomw9WY6k=;
        b=vVLyvukrpuQtbZdzKfeFDmHdS8rq0f9WdO6YO1eZI6sLIUF996To1rdL8/7+axITIy
         85yp8tjhuqeC8aQG5v6WRyAA6OCt/OvXJzXuB3erg1B1/6I/VhC97S1snroCo/cGfDMP
         uVp7k4O91vtcWDPfd0EgxARsjrcpaEz0vxiRw/U3zJGyqOMaKnEbJrlYwP0YHPX11owd
         ydc6SDTxO8stFGHPET1XRyuFJtUOZ/g0botEElyakKaPs0TwZwUnhxua9Brg/C7XrXzK
         Tzz95CL2xg4AohWS6sDOA/H16jSdpmsb38czV9xkwcdD72qnaCznSjjlKboOu3AVh9Qv
         0LPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JnkachwQP0cyQ9JdMbTUnW5qndJ/fTXRxpRomw9WY6k=;
        b=B+iD8RvZYZZ/TjWj87nqUU4bmOqsfWQvyif7KYdemeLWEHD+hIM50iTl+7Cp5aaoBH
         Wy5TombDtwXkraweb+s4eDUmrQKhajmgfS93bT7j8dBU9iqQbB5fSKGjoeZ6XMlCjDw4
         pZZ0kNggl8z0BdmrtZKRMObM+FI2UTx192t2e3p8A2TURUMakBjYh0LTdbDSfsF5Vywz
         wbJkyVSHV/CnsPwR7dOT2ctZZu6gzJ0AQSHGkrkbhnYP6bNuq6qMZH9l8C1gP44U5gHv
         Qzhkg8mhNG7zIITHKmPGlEQQUt47ieqZg6FedhiTpVoJUwAUSSJI9sNvYjJaQQHGVoWT
         YX6w==
X-Gm-Message-State: APjAAAUM8wfh4f9+J+BXlADjPF+uZlKUgw73ArQLRkAw28x7iWUJ0mY1
        N19DSVDYrNpz4LVvI3zSs9ZlFNcqwMI=
X-Google-Smtp-Source: APXvYqwldcfdyDdPl9Gjdkd6jFSMj3SpsF5wpLgGIfwBFAFlRIInO++P7x9qLE/YFYFausvmaYzsNg==
X-Received: by 2002:a81:a95:: with SMTP id 143mr7470844ywk.279.1561751496285;
        Fri, 28 Jun 2019 12:51:36 -0700 (PDT)
Received: from mail-yw1-f54.google.com (mail-yw1-f54.google.com. [209.85.161.54])
        by smtp.gmail.com with ESMTPSA id x195sm789006ywx.57.2019.06.28.12.51.34
        for <linux-scsi@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 12:51:35 -0700 (PDT)
Received: by mail-yw1-f54.google.com with SMTP id j190so3793083ywb.0
        for <linux-scsi@vger.kernel.org>; Fri, 28 Jun 2019 12:51:34 -0700 (PDT)
X-Received: by 2002:a81:4807:: with SMTP id v7mr6063772ywa.494.1561751494211;
 Fri, 28 Jun 2019 12:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190628123819.2785504-1-arnd@arndb.de> <20190628123819.2785504-4-arnd@arndb.de>
In-Reply-To: <20190628123819.2785504-4-arnd@arndb.de>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 28 Jun 2019 15:50:57 -0400
X-Gmail-Original-Message-ID: <CA+FuTSexLuu8e1XHaY0ObGi46CgZnBpELecBr+kMgCU29Fa_gw@mail.gmail.com>
Message-ID: <CA+FuTSexLuu8e1XHaY0ObGi46CgZnBpELecBr+kMgCU29Fa_gw@mail.gmail.com>
Subject: Re: [PATCH 4/4] ipvs: reduce kernel stack usage
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Wensong Zhang <wensong@linux-vs.org>,
        Simon Horman <horms@verge.net.au>,
        Julian Anastasov <ja@ssi.bg>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        James Morris <jmorris@namei.org>, linux-scsi@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devel@driverdev.osuosl.org,
        Network Development <netdev@vger.kernel.org>,
        lvs-devel@vger.kernel.org,
        netfilter-devel <netfilter-devel@vger.kernel.org>,
        coreteam@netfilter.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, Jun 28, 2019 at 8:40 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> With the new CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL option, the stack
> usage in the ipvs debug output grows because each instance of
> IP_VS_DBG_BUF() now has its own buffer of 160 bytes that add up
> rather than reusing the stack slots:
>
> net/netfilter/ipvs/ip_vs_core.c: In function 'ip_vs_sched_persist':
> net/netfilter/ipvs/ip_vs_core.c:427:1: error: the frame size of 1052 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> net/netfilter/ipvs/ip_vs_core.c: In function 'ip_vs_new_conn_out':
> net/netfilter/ipvs/ip_vs_core.c:1231:1: error: the frame size of 1048 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> net/netfilter/ipvs/ip_vs_ftp.c: In function 'ip_vs_ftp_out':
> net/netfilter/ipvs/ip_vs_ftp.c:397:1: error: the frame size of 1104 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> net/netfilter/ipvs/ip_vs_ftp.c: In function 'ip_vs_ftp_in':
> net/netfilter/ipvs/ip_vs_ftp.c:555:1: error: the frame size of 1200 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
>
> Since printk() already has a way to print IPv4/IPv6 addresses using
> the %pIS format string, use that instead,

since these are sockaddr_in and sockaddr_in6, should that have the 'n'
specifier to denote network byteorder?

> combined with a macro that
> creates a local sockaddr structure on the stack. These will still
> add up, but the stack frames are now under 200 bytes.

would it make sense to just define a helper function that takes const
char * level and msg strings and up to three struct nf_inet_addr* and
do the conversion in there? No need for macros and no state on the
stack outside error paths at all.

>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I'm not sure this actually does what I think it does. Someone
> needs to verify that we correctly print the addresses here.
> I've also only added three files that caused the warning messages
> to be reported. There are still a lot of other instances of
> IP_VS_DBG_BUF() that could be converted the same way after the
> basic idea is confirmed.
> ---
>  include/net/ip_vs.h             | 71 +++++++++++++++++++--------------
>  net/netfilter/ipvs/ip_vs_core.c | 44 ++++++++++----------
>  net/netfilter/ipvs/ip_vs_ftp.c  | 20 +++++-----
>  3 files changed, 72 insertions(+), 63 deletions(-)
>
> diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
> index 3759167f91f5..3dfbeef67be6 100644
> --- a/include/net/ip_vs.h
> +++ b/include/net/ip_vs.h
> @@ -227,6 +227,16 @@ static inline const char *ip_vs_dbg_addr(int af, char *buf, size_t buf_len,
>                        sizeof(ip_vs_dbg_buf), addr,                     \
>                        &ip_vs_dbg_idx)
>
> +#define IP_VS_DBG_SOCKADDR4(fam, addr, port)                           \
> +       (struct sockaddr*)&(struct sockaddr_in)                         \
> +       { .sin_family = (fam), .sin_addr = (addr)->in, .sin_port = (port) }

might as well set .sin_family = AF_INET here and AF_INET6 below?

> +#define IP_VS_DBG_SOCKADDR6(fam, addr, port)                           \
> +       (struct sockaddr*)&(struct sockaddr_in6) \
> +       { .sin6_family = (fam), .sin6_addr = (addr)->in6, .sin6_port = (port) }
