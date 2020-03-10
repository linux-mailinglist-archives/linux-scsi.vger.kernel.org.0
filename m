Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDFBD180C0D
	for <lists+linux-scsi@lfdr.de>; Wed, 11 Mar 2020 00:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgCJXKH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 10 Mar 2020 19:10:07 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36583 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgCJXKH (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 10 Mar 2020 19:10:07 -0400
Received: by mail-ed1-f68.google.com with SMTP id a13so517628edh.3
        for <linux-scsi@vger.kernel.org>; Tue, 10 Mar 2020 16:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZjzfLVKcrEVYs6WhxkjJMrt4JgyDW89UP2lOPu52OFg=;
        b=AFnM8/qVZ5INpBhagP0TzCOiNgkxgenab2JvoMJ9TochGwwsyROWvjIewmaXHDUmar
         l+T11XTf3Z5/Ln3tLw8rQzmHYyAEoebfFfwlJsw4tdw5dINkokIRH6NS2P54C8D6wCSe
         ws5FELqRVVqhVPNU17Zok/L7q8FpBv0xeV2Yx/a7IwZ+YYOXOhMa8eTAabzdA20EG7IY
         J84WyBNSEyA/7FhPiNt9Zcn8JPOOzmRwoHz4R7hn1NRoq0KTMVjRHrmh0e6pxHuZgivu
         ZZqYfgk18R1hF/eFxnc6c5j6COc0wlMKtMCm0st1cu2neOcTZro4+BlqXr2NtmU9v/Vs
         2n4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZjzfLVKcrEVYs6WhxkjJMrt4JgyDW89UP2lOPu52OFg=;
        b=h27jdqe2T8WKQ0eprvUd7c55B3RFYQObTr3wh2ccQjkYWezmVdObX490fN8LxGslBX
         wKyiPhCSxhjaNboXO6KfjR1ZqcQVmvkSSAjdeOxx+gWsyC5MO1gOB0WkhEuJcJ+UBuYw
         7BX0G36EAXOYqUbMjcIqU3TcbVlMZMWLKAbhNHb6Az5OU8wCv+JgH83WGWnumhhWcWQ1
         z8tzKdAgKDOFYsP+hqVDoVrZuiS8sMM2EMJcYXHGFmGRIi08bRsPieSxOCVHxYi7/jQf
         +hoI6fPR8BcJC4JmhPjI9UOvkTcHFeZ/N/9He7dp97HS9crQhqQkB8cdVbvR5JCSbPZK
         pe6w==
X-Gm-Message-State: ANhLgQ3UqgL9z1VRFh21WbnTNwKGav8lcz5lT4MFM/9/2spNx8qzRsPk
        vM7CCCQNYbZ+yIz6vTchOFWQsw==
X-Google-Smtp-Source: ADFU+vuw/QrLgknOBSnLL6UEPd5ZmG0mMBAvF0lDukG/ngJ9XGt+BMvhR1Vfo0DVxEJ2jx46GiOIfQ==
X-Received: by 2002:a05:6402:549:: with SMTP id i9mr174325edx.323.1583881805877;
        Tue, 10 Mar 2020 16:10:05 -0700 (PDT)
Received: from ?IPv6:2001:16b8:4849:2c00:55b0:6e1e:26ab:27a5? ([2001:16b8:4849:2c00:55b0:6e1e:26ab:27a5])
        by smtp.gmail.com with ESMTPSA id h22sm3715651eds.88.2020.03.10.16.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 16:10:05 -0700 (PDT)
Subject: Re: [PATCH v2] block: refactor duplicated macros
To:     Matteo Croce <mcroce@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-bcache@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-mmc@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-scsi@vger.kernel.org, linux-nfs@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Song Liu <song@kernel.org>
References: <20200310223516.102758-1-mcroce@redhat.com>
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Message-ID: <d473061b-688f-f4a6-c0e8-61c22b8a2b10@cloud.ionos.com>
Date:   Wed, 11 Mar 2020 00:10:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200310223516.102758-1-mcroce@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



On 3/10/20 11:35 PM, Matteo Croce wrote:
> +++ b/drivers/md/raid1.c
> @@ -2129,7 +2129,7 @@ static void process_checks(struct r1bio *r1_bio)
>   	int vcnt;
>   
>   	/* Fix variable parts of all bios */
> -	vcnt = (r1_bio->sectors + PAGE_SIZE / 512 - 1) >> (PAGE_SHIFT - 9);
> +	vcnt = (r1_bio->sectors + PAGE_SECTORS - 1) >> (PAGE_SHIFT - 9);

Maybe replace "PAGE_SHIFT - 9" with "PAGE_SECTORS_SHIFT" too.

Thanks,
Guoqing
