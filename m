Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3DB2F03D4
	for <lists+linux-scsi@lfdr.de>; Sat,  9 Jan 2021 22:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbhAIVaI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 9 Jan 2021 16:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbhAIVaH (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 9 Jan 2021 16:30:07 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2012C061786;
        Sat,  9 Jan 2021 13:29:26 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id g185so11412068wmf.3;
        Sat, 09 Jan 2021 13:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qGJGJxCcHriRua+XWavSyBDVkT64GdF8AXVlo22Bpoc=;
        b=HzoLYVKJykBK/r8Nqeb1VA3oF2zL5u7kEBe8f4VAJYrRrADprAOzfJZPdnL7zS5quL
         LJh7Oa72OLdGEkfWHt7X12pBrUYGvzDHy73UpNgaRi1aF17kzFebEWFbYmHe5Uxy3++K
         un9h3t2NUU6j2v7zunEaBiztXfCMx0+PiFF4LQOwqFuPvbNOro4/dANXpx2ZpCALgVbQ
         Ho4yzw0cXaSKKCCfU6jxhJuqC6FamNJJvavVx/XpwYXmAJMeXt+uWl6vNhOM5gYFDflj
         KPuwDUMU676ptv4bgL7yT8/HgXsAQ8iDyHoJ47zv1lQA7MZNumRHnhQeK6vyr7bG5PBE
         ua4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=qGJGJxCcHriRua+XWavSyBDVkT64GdF8AXVlo22Bpoc=;
        b=kqd49liPD112yGV9qQ17SNQ30/Q4uebU+HwS87eN3ajplf+iJF9mS0nlOvDQQBs64b
         xg/ktBxZsJpp6atsLJLnNFdIwr0e2mxhsywAmJGnTInhuJyi3/LPS/ewXlL9CedvIi5B
         qpTqLdTzTTCwKAWcAw/HCF3gxj8xK4hxTtQjHp01tNgnOEKDyUenWhAd1W1eDn/qhJo4
         /ZEBZXiY03tJUJcU6txLgCjEL6+P9lOu/RACiAz9JF5Xo7dYwk4jOcjygujV3S0/RbuI
         3c4NxQeUW/Bl+FzJu4WYvgPAern3LgReWd3NTqAgH6889CIKQ9DrLNzOQqefKI/PPTTQ
         cvtw==
X-Gm-Message-State: AOAM530FgternqcOvnzP6Z697dAymMHs/qn7aH+mtWyGuz4Ai5gFQdzm
        Rtitxr0Vt2t45TkFpfK2WNjdDIXLDC0lk0+a
X-Google-Smtp-Source: ABdhPJwLbLb8fhue53UQ885oIKJSPpazUlX1KOawxhZTzuXO87vhOJt2poDrXdB5/QcggEN9MlFgew==
X-Received: by 2002:a1c:24c4:: with SMTP id k187mr8731041wmk.14.1610227765480;
        Sat, 09 Jan 2021 13:29:25 -0800 (PST)
Received: from [192.168.8.114] ([85.255.237.6])
        by smtp.gmail.com with ESMTPSA id y2sm16252726wma.6.2021.01.09.13.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Jan 2021 13:29:25 -0800 (PST)
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <34cd22d6cec046e3adf402accb1453cc255b9042.1610207523.git.asml.silence@gmail.com>
 <BYAPR04MB4965F4DCF59E5225CF17322D86AD0@BYAPR04MB4965.namprd04.prod.outlook.com>
 <4d063dde-c710-44e3-31b9-8fb6b7e1d952@gmail.com>
 <BYAPR04MB49653C92C7925B8C3EAEF3CE86AD0@BYAPR04MB4965.namprd04.prod.outlook.com>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH] target/file: don't zero iter before iov_iter_bvec
Message-ID: <b9558bf8-a7e3-c2f9-ce00-3fc2b90dcc87@gmail.com>
Date:   Sat, 9 Jan 2021 21:25:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49653C92C7925B8C3EAEF3CE86AD0@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 09/01/2021 20:52, Chaitanya Kulkarni wrote:
> On 1/9/21 12:40, Pavel Begunkov wrote:
>> I expect you won't find any, but such little things can pile up
>> into a not-easy-to-spot overhead over time.
> 
> That is what I suspected with the resulting assembly. The commit log
> needs to document that there is no direct impact on the performance

It's obvious that 3-4 extra mov $0 off(%reg) won't change performance
but still hasn't been formally confirmed ...

> which can be seen with this patch, but this is nice to have

... so if you don't mind, I won't be resending just for that.

-- 
Pavel Begunkov
