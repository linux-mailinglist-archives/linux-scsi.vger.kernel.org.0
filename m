Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4E5A837B5
	for <lists+linux-scsi@lfdr.de>; Tue,  6 Aug 2019 19:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730835AbfHFRNm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 6 Aug 2019 13:13:42 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34348 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbfHFRNl (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 6 Aug 2019 13:13:41 -0400
Received: by mail-pg1-f195.google.com with SMTP id n9so35706048pgc.1
        for <linux-scsi@vger.kernel.org>; Tue, 06 Aug 2019 10:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZvzsK7kR5VOc8vLSUAyhMMvLw7CH4O5SxpWRM2MiZLE=;
        b=EtQSd8ZG8ObzUB9beK6dCbnBEKo2C59OSZjX9NmWQtCNyK0f0EThal/8Y96PMMZyEY
         WEn6z8Op0TOEt9GPafEH37Ysh4PLUoEQyVzpTiw5CNcq1BdSHXbooKoEj14Ap5owlyj/
         pw9WlrEXGHEu4smsK8n+y86XuO1bv3EkTqPCTvYXdiT0Uc1P20QjrqnfGISZ6WTe69gd
         qUn9kDdhRkXkRv3vy9ivNVNRg7DWOYHOt/5j8+QH964rXS6Z43PU83KwkuivJFuXgwyv
         Fr1K/IHL8//IFfVp4IvqfZfW60AcoxXImSd+vMDbqK3yUosyTXaOxHQnrHVz6K/3lkmY
         YPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZvzsK7kR5VOc8vLSUAyhMMvLw7CH4O5SxpWRM2MiZLE=;
        b=h1Y5/YOrvyrsSpeCiaiuZbsbVeKrmtYHFzxYzTUUKqh/ieTQh6drWbIDAH7cVPzriM
         VPgFXrtkLVgybug77Av05Wb848EQyDJmiBRwY6CaQlHECCOqpXbgv3Sk8VAaN8e91OLC
         oHXrA767SXCFbWsd821TWvkaADaZDL+4n6URDd1bj7NdUwIwOuT82goun2A3pdgeS3uK
         /lmVDa1E0Wf+sTstu1W/qtb/oIxRXUABk93P64dLm8lXAOo9OFii+QM2SILAFuy6Wrub
         hLlLLKDpnO2ek1r0lQolgHH55mo069xG5ebe2Sm5dtsz3eYpYaL+ROa18eSQK04iB4dl
         NDFA==
X-Gm-Message-State: APjAAAXY5NjVgCoW/j5gufi0prtp4NH1zihhbTZ7aWENUIBUtgnrFfah
        Bug3xYPjVyiqjT3HyXMo0Ic/euz2
X-Google-Smtp-Source: APXvYqySf7ZdGRNPTeTdXImHTz1rXfhl4p+zAi+c6TLcomtvyKp/OjTrLrGD8MpfDmiMh82Evo4y0Q==
X-Received: by 2002:a65:6096:: with SMTP id t22mr2716010pgu.204.1565111621088;
        Tue, 06 Aug 2019 10:13:41 -0700 (PDT)
Received: from [10.69.45.46] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5sm25199435pgh.93.2019.08.06.10.13.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 10:13:40 -0700 (PDT)
Subject: Re: [PATCH v2] lpfc: Mitigate high memory pre-allocation by SCSI-MQ
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     Linux SCSI List <linux-scsi@vger.kernel.org>,
        Dick Kennedy <dick.kennedy@broadcom.com>
References: <20190801220941.19615-1-jsmart2021@gmail.com>
 <CACVXFVO7vmGJj_N_MT7roZDmWNHbEGR=MsOqkpb7NTptF3=DOw@mail.gmail.com>
From:   James Smart <jsmart2021@gmail.com>
Message-ID: <227b2bc2-9778-6d38-a68b-26a799a0caeb@gmail.com>
Date:   Tue, 6 Aug 2019 10:13:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CACVXFVO7vmGJj_N_MT7roZDmWNHbEGR=MsOqkpb7NTptF3=DOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 8/5/2019 6:09 PM, Ming Lei wrote:
> 
> I am wondering why you use 2 * num_possible_nodes() as the limit instead of
> num_possible_nodes(), could you explain it a bit?

The number comes from most systems being dual socket systems, thus a 
numa node count of 2. Some of these dual socket systems can be high cpu 
counts per socket. We did see a difference, on different architectures 
and where cpu counts were high per socket, that more hwqs per socket did 
help. So if there can be more than 1 hwq per socket then I think that is 
goodness. Additionally, we saw that 4 was a fairly good number memory 
size wise - it was still big (several hundred MBs with can_queue counts 
of 4k or 8k), but doubling it to 8 started to make it approach the high 
100's of MB. So, unless we had higher numa node counts, I didn't want to 
raise it any more than 2x the node count. And as 8 looked so big, even 
with a high numa node count, that seemed a reasonable cap.

-- james


