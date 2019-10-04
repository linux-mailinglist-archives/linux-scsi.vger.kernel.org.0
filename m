Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A487DCC0D0
	for <lists+linux-scsi@lfdr.de>; Fri,  4 Oct 2019 18:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387616AbfJDQaG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 4 Oct 2019 12:30:06 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42147 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730392AbfJDQaF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 4 Oct 2019 12:30:05 -0400
Received: by mail-pf1-f194.google.com with SMTP id q12so4190770pff.9
        for <linux-scsi@vger.kernel.org>; Fri, 04 Oct 2019 09:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=equZ0BrOIUN4/eqWrHIomUAA5l9+Bnx/xULEvTcUBNw=;
        b=fZ3OzQphi0I39jA6cypQ/PnDKxsaJLs1yOJ5v7PXKGJGYcC8kPvgXyqq278yqnEDSA
         aX9MB6R2slIix1emD3HoxllJYig61fg9wBKpTy+Z02GMerKZyrbLY+p/0O+Ub50t07ne
         VZRdXSSLSOnq3WdFor2rnaCktQtycLY22vKEbY29KArQr5uYc4P2Pq9bQJyGxPKRzetE
         IJ4OMzC6BOFyFMJPzgLVC+KF4FCQ4HgMYSNtYN24USUCrjWtO56/AK22TDopcVR/oBdq
         qNagD0DIXz/tQnDo97XUrTPuUojONNCSxI7wFfoCpEajPq62c5pqeZbSYwvH45SVM0Hh
         CACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=equZ0BrOIUN4/eqWrHIomUAA5l9+Bnx/xULEvTcUBNw=;
        b=TIA4Zf0MQwpI7CRLiXzpDcByRLgq758g00dERXI3nqAnnQPb2mOO2Q671uiHYDtD+K
         dMbG8PYrH4C0iDqzZ8LuU0llqJF72ecpBUTQW/NzEiF7JzQ2PmeI5LLyOvoQhpBqNWuI
         1pLmnPh47N9wDxv7xXD90/t4kFs1XPmDWG333wMR332lFCQwENP8ACs0FSfVAgfkB15R
         Yz9oXGx7NVZJN5IeD8qy0UEb47NuETDqhXa5eFLVWTbDRJcY/dvSTbQcAhWFqOxoFL//
         m0JOgPjhMN4sd8/ceJbrAxzyt5KkdHLgEkgh+yWSGvJHob4OmHy7wdgxEy6QT36ux6dh
         LCWQ==
X-Gm-Message-State: APjAAAWfSdDbtrCZiKM7N3U0byrrtPde9v/JX1GKA47JdvcbyK4fkIv5
        WcPPRVkiU30u5Uv/+xuOri2FNojN
X-Google-Smtp-Source: APXvYqwS7VBgOI5ybttLLJE7b1rbSCCkIiEHEbMs3rxoh59mjlYVL133HL+KXSEx0xZQo9ttRfTpfg==
X-Received: by 2002:a65:638a:: with SMTP id h10mr6814632pgv.106.1570206604418;
        Fri, 04 Oct 2019 09:30:04 -0700 (PDT)
Received: from [10.69.45.46] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id i7sm5295038pjs.1.2019.10.04.09.30.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 09:30:03 -0700 (PDT)
Subject: Re: [PATCH] scsi: lpfc: Make function lpfc_defer_pt2pt_acc static
To:     Dick Kennedy <dick.kennedy@broadcom.com>,
        zhengbin <zhengbin13@huawei.com>
Cc:     James Smart <james.smart@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>
References: <1570183477-137273-1-git-send-email-zhengbin13@huawei.com>
 <CAGx+d6fcFnwN_zVshk6ua7o2a02V6L9ZZTXpggDj51Y3LGG50A@mail.gmail.com>
From:   James Smart <jsmart2021@gmail.com>
Message-ID: <804c55b8-a082-08ec-eaff-30bee610641d@gmail.com>
Date:   Fri, 4 Oct 2019 09:30:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAGx+d6fcFnwN_zVshk6ua7o2a02V6L9ZZTXpggDj51Y3LGG50A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 10/4/2019 5:46 AM, Dick Kennedy wrote:
> Looks Good.
> ACK
> 
> On Fri, Oct 4, 2019 at 5:58 AM zhengbin <zhengbin13@huawei.com 
> <mailto:zhengbin13@huawei.com>> wrote:
> 
>     Fix sparse warnings:
> 
>     drivers/scsi/lpfc/lpfc_nportdisc.c:290:1: warning: symbol
>     'lpfc_defer_pt2pt_acc' was not declared. Should it be static?
> 
>     Reported-by: Hulk Robot <hulkci@huawei.com <mailto:hulkci@huawei.com>>
>     Signed-off-by: zhengbin <zhengbin13@huawei.com
>     <mailto:zhengbin13@huawei.com>>
>     ---
>       drivers/scsi/lpfc/lpfc_nportdisc.c | 2 +-
>       1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by:  Dick Kennedy <dick.kennedy@broadcom.com>
Reviewed-by:  James Smart <james.smart@broadcom.com>

Thanks!

-- james
