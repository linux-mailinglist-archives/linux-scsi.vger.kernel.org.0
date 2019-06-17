Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A39C24918E
	for <lists+linux-scsi@lfdr.de>; Mon, 17 Jun 2019 22:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbfFQUl5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 Jun 2019 16:41:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41816 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfFQUl5 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 17 Jun 2019 16:41:57 -0400
Received: by mail-pl1-f194.google.com with SMTP id m7so1034308pls.8
        for <linux-scsi@vger.kernel.org>; Mon, 17 Jun 2019 13:41:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5ytBBoX/F85G/jmB9seMz9XZPL19/UDsDzzKKKsxtdM=;
        b=uXOz+c6hBG1bdXOZvba1thkmbpLjkMdlTadKhL6nPIrg9DWzFSseN4T+C6nkwO8Cv8
         cBreWehCInoPiYnBDK4hwX0uOJ70q8VSrfapVMA6LlWzI12Z+8ZpIpDxiRYasW56Ca6e
         5Rh+ntyJVTpLocK+ve1ZePqFJceRhqilXDETUIx2QDLwdWE0UT5ZDLPCYCsweoDRIqew
         BUiAgcTQkwjLYKxuc8OIxK1evZPDYfpe3ZxjexLo01Mr8zcTD5rqZireY/u5CyzTzRsa
         V7NbfRrveLnwI1tpMT4dyYhp+4UQW8G19ywzZM+GuXiF9mhm4Y65GiOnSggsvIVNd3M1
         zDBA==
X-Gm-Message-State: APjAAAUU8pCzocCWZ2EFaIS9UYNj+H31DIE3Aftnv9Ajv71nBwib2npB
        F0aTMHYDRjU2adN0h+wNU6yGfLMGCrk=
X-Google-Smtp-Source: APXvYqzLkCWce2n5QxaB4LTac+QrKrxDJsbfeetoxYrV/YrMsg+iLCis1e4QRj2kOeSK4wVWTMe0EA==
X-Received: by 2002:a17:902:7687:: with SMTP id m7mr27862876pll.310.1560804116481;
        Mon, 17 Jun 2019 13:41:56 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id u16sm241706pjb.2.2019.06.17.13.41.54
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 13:41:55 -0700 (PDT)
Subject: Re: [EXT] Re: [PATCH 3/3] qla2xxx: Fix NVME cmd and LS cmd timeout
 race condition
To:     Himanshu Madhani <hmadhani@marvell.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <20190614221020.19173-1-hmadhani@marvell.com>
 <20190614221020.19173-4-hmadhani@marvell.com>
 <dc2bad07-0ba0-06e7-b52a-57f774bc3ff2@acm.org>
 <CDBC6094-EA99-45BE-A420-404ED6A3BE0F@marvell.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <e5b17e5a-49d1-7496-a395-9a09bb791a7f@acm.org>
Date:   Mon, 17 Jun 2019 13:41:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CDBC6094-EA99-45BE-A420-404ED6A3BE0F@marvell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/14/19 3:58 PM, Himanshu Madhani wrote:
> Yes. We are in process of doing the larger cleanup. However, this > patch was part of fixes we verified for a crash and want to get this
> in a distro before the wider cleanup is submitted for inclusion.

Hi Himanshu,

It's not that hard to fix this properly. It would be appreciated if you 
could have a look at the series with six patches that I just posted.

Thanks,

Bart.
