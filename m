Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4C875A4A4
	for <lists+linux-scsi@lfdr.de>; Fri, 28 Jun 2019 20:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfF1S51 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 28 Jun 2019 14:57:27 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36683 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfF1S50 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 28 Jun 2019 14:57:26 -0400
Received: by mail-pl1-f194.google.com with SMTP id k8so3736098plt.3
        for <linux-scsi@vger.kernel.org>; Fri, 28 Jun 2019 11:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=GEJr3AqvHre2EqiUp9wkeTIrlXFQndtx5Gxgp/CLC/Y=;
        b=XoArU2Aw8uy6yHzMzOQ8pchviB6L+RP4fgA/8H3T5PNGYyVaXqKQqTIwc7a4oy+fnV
         F1iR3tXMQ34FbQ+fE8PXhJfHqbNf+Sn8tcEf7KYCanV+dVUAQA5PC6ql/3/lkLjzI4Cv
         BT9bbsuFZ5wsJLWle1D+GKJmmk4aHobb+e2eY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GEJr3AqvHre2EqiUp9wkeTIrlXFQndtx5Gxgp/CLC/Y=;
        b=GsWZ9ZUMLKz/Q9iUuT4Q2Bn85KF10QAF8MsctKOM8izmPQH1tYC2N/7G2twfOD20zk
         YxahvY6PqL79wvSq2jd0sj3um61cyToBaoywK1ARQ/kaGk4S7O91sgq6bf1AaWR3vBVk
         GKQit7kKe31qeCRHTcgWfoCge4rozXZCEeMuR0CYEo9xv7dUnrBlQEEvSJaSD4Irr6NR
         HF2TdoJHoKEbVZcKvNjtKR4efslSNLBkxs+Kd5PTBS2FlK2DGn2io8p3gCoAUshKmH6R
         QQnWBjZebA1BTsy0iktprS9Ay1CFwlqhCQ4JqVtcRUHBqInOsMrYW3uB9RHpiH7WJPs3
         7SrQ==
X-Gm-Message-State: APjAAAUj1wdt2JfRrEA2kp35qbHB1+IZ3w7E6U+keKXjFDeid3VGlzTe
        N9BF0bleDIAeELiqHMRnU9qe8Q==
X-Google-Smtp-Source: APXvYqxFoDW9J1n1b7IoCWK5H6zYvA3wRtWclaCyF1V0DeG5Vz04P8IhMaf+FOo/j1jTbYYohqE2hQ==
X-Received: by 2002:a17:902:aa03:: with SMTP id be3mr13363364plb.240.1561748246107;
        Fri, 28 Jun 2019 11:57:26 -0700 (PDT)
Received: from [10.230.29.90] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id b15sm3008737pfi.141.2019.06.28.11.57.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 11:57:25 -0700 (PDT)
Subject: Re: [PATCH 2/4] lpfc: reduce stack size with
 CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE
To:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Wensong Zhang <wensong@linux-vs.org>,
        Simon Horman <horms@verge.net.au>,
        Julian Anastasov <ja@ssi.bg>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        James Morris <jmorris@namei.org>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        netdev@vger.kernel.org, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Hannes Reinecke <hare@suse.com>, Willy Tarreau <w@1wt.eu>,
        Silvio Cesare <silvio.cesare@gmail.com>
References: <20190628123819.2785504-1-arnd@arndb.de>
 <20190628123819.2785504-2-arnd@arndb.de>
From:   James Smart <james.smart@broadcom.com>
Message-ID: <3027eebb-e49f-6db6-ae0a-39a61c0e34e1@broadcom.com>
Date:   Fri, 28 Jun 2019 11:57:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190628123819.2785504-2-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



On 6/28/2019 5:37 AM, Arnd Bergmann wrote:
> The lpfc_debug_dump_all_queues() function repeatedly calls into
> lpfc_debug_dump_qe(), which has a temporary 128 byte buffer.
> This was fine before the introduction of CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE
> because each instance could occupy the same stack slot. However,
> now they each get their own copy, which leads to a huge increase
> in stack usage as seen from the compiler warning:
>
> drivers/scsi/lpfc/lpfc_debugfs.c: In function 'lpfc_debug_dump_all_queues':
> drivers/scsi/lpfc/lpfc_debugfs.c:6474:1: error: the frame size of 1712 bytes is larger than 100 bytes [-Werror=frame-larger-than=]
>
> Avoid this by not marking lpfc_debug_dump_qe() as inline so the
> compiler can choose to emit a static version of this function
> when it's needed or otherwise silently drop it. As an added benefit,
> not inlining multiple copies of this function means we save several
> kilobytes of .text section, reducing the file size from 47kb to 43.
>
> It is somewhat unusual to have a function that is static but not
> inline in a header file, but this does not cause problems here
> because it is only used by other inline functions. It would
> however seem reasonable to move all the lpfc_debug_dump_* functions
> into lpfc_debugfs.c and not mark them inline as a later cleanup.

I agree with this cleanup.

>
> Fixes: 81a56f6dcd20 ("gcc-plugins: structleak: Generalize to all variable types")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/scsi/lpfc/lpfc_debugfs.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
>

Reviewed-by: James Smart <james.smart@broadcom.com>

-- james

