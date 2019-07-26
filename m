Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B127C7736C
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jul 2019 23:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbfGZV0L (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Jul 2019 17:26:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40441 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfGZV0L (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 26 Jul 2019 17:26:11 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so25348324pgj.7
        for <linux-scsi@vger.kernel.org>; Fri, 26 Jul 2019 14:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/BioJDF/rIjl+CtJqnboEQmXMiHa9an0qkjuH2k+UAo=;
        b=Sv+79lDbrIDKMxMgo+/iS+pM2lfIwZHfDZqPAdaCwlBxV7mB5VFv7yoiifj3mxmyy9
         gxFEo+RWN+DsQ7Xxe2YBCyVlGkvzRiUvNigzbW9QkKCuS9JmmfDulweLeuRQvDfyzacB
         WZarv8GOuyRsPysoEa9T53odByZXLVirW/ZAQtSXIvy8u1V3jBjOOTO47PfRKP30Yl1P
         ejThy7GFtW6lwcv4j8sKsFDMKWuvUrpeYXTGb/i3oxKLpg40CEqZ1PnsGHT3NtXT6mNK
         kubJcIyRaW2wyP2Dv+5yy5NUJkNoi0vPpoDNiK0bnODIk5H8uv3O5+I3D1oZnj4KTv+x
         4ShA==
X-Gm-Message-State: APjAAAWzRnhsPYhCqrF6MUwWL89hSIwXmTpnR8a3GoHPLNvsS7yAJoQE
        nUJRZYYgnWeba94Ezxwr9G//GNHR
X-Google-Smtp-Source: APXvYqxNiZWsKAnhNo2i3bfQB8RAlnpdYy8sZ24gUHz/NTnlYHybx4wtOx/Kytt/Qx0f9BZd2QZ6Fg==
X-Received: by 2002:a65:6259:: with SMTP id q25mr53692834pgv.145.1564176369911;
        Fri, 26 Jul 2019 14:26:09 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id p19sm62035381pfn.99.2019.07.26.14.26.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jul 2019 14:26:09 -0700 (PDT)
Subject: Re: [PATCH 03/15] qla2xxx: Fix abort timeout race condition.
To:     Himanshu Madhani <hmadhani@marvell.com>,
        James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org
References: <20190726160740.25687-1-hmadhani@marvell.com>
 <20190726160740.25687-4-hmadhani@marvell.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <32d19825-b571-314e-f605-76e05e17925f@acm.org>
Date:   Fri, 26 Jul 2019 14:26:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190726160740.25687-4-hmadhani@marvell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 7/26/19 9:07 AM, Himanshu Madhani wrote:
>   static void qla24xx_abort_sp_done(void *ptr, int res)
> @@ -109,7 +122,8 @@ static void qla24xx_abort_sp_done(void *ptr, int res)
>   	srb_t *sp = ptr;
>   	struct srb_iocb *abt = &sp->u.iocb_cmd;
>   
> -	if (del_timer(&sp->u.iocb_cmd.timer)) {
> +	if ((res == QLA_OS_TIMER_EXPIRED) ||
> +	    del_timer(&sp->u.iocb_cmd.timer)) {
>   		if (sp->flags & SRB_WAKEUP_ON_COMP)
>   			complete(&abt->u.abt.comp);
>   		else

A better fix is probably to ignore the return value of del_timer() - see 
also "[PATCH 20/20] qla2xxx: Fix qla24xx_abort_sp_done()" 
(https://www.spinics.net/lists/linux-scsi/msg130664.html).

Anyway, I'm fine with this and the other 14 patches going upstream. I 
can rebase my patches on top of this patch series.

Bart.


