Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF27146C96
	for <lists+linux-scsi@lfdr.de>; Sat, 15 Jun 2019 01:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfFNXCn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 14 Jun 2019 19:02:43 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:36729 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfFNXCn (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 14 Jun 2019 19:02:43 -0400
Received: by mail-pf1-f176.google.com with SMTP id r7so2260764pfl.3
        for <linux-scsi@vger.kernel.org>; Fri, 14 Jun 2019 16:02:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SRfIomQ8FqzHQ6r0bDaI9QKrjNRkF+zqDMO6pDnZEYM=;
        b=tvpVOfFtcigCvJNoMyDq9zu/UxB1bA1LDKq8fx0YG9tYQvShWLyj7PCNYnIqSNe0gD
         +Eon/Ydc73DBLAt/QcfWHB8XlbwgRmjtiT5KN+WBy9db83jgaglZe+L2SA81qNI51QLu
         q2hvl+tUprOwGUUPdVdtyLERzQCn49PCC9ZPF1k4zcQVQF4vhEHYnxLgYLvqPMH0zBoz
         8lomA/bFVr3xOvOq+ShWmbhOhsTzxhDdqa5eZNB0J2Ps++J+AiCy1khUdZmRDVqxTq8L
         htI9HLlmSlAc2PHnkn+vFUSCwIgqKBrAER1ICL0C/rPiV0HOMES/ubtmS1kTAG7rkxaT
         Fzfg==
X-Gm-Message-State: APjAAAUu0dUhZcWvKpPstASHszKo05N621NvkeHoaJ792mPCJw2Db0av
        PmUVrlLJXIE09UDIFnLjLgUk1BPy
X-Google-Smtp-Source: APXvYqyNV3AhMajxYaX2J9N1EnV9zP/sSqQLHbEWTAjtDSSt10mHGkTVc7EdbNwz0f4Bkd3jlk1M0Q==
X-Received: by 2002:a62:e815:: with SMTP id c21mr60179409pfi.244.1560553361873;
        Fri, 14 Jun 2019 16:02:41 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id u20sm3462928pgm.56.2019.06.14.16.02.40
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 16:02:40 -0700 (PDT)
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
Message-ID: <e9a42c30-a09c-03d1-c6b6-5c9130981a7c@acm.org>
Date:   Fri, 14 Jun 2019 16:02:39 -0700
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
> Would you consider allowing us to add this patch and we'll provide
> larger patch fixing all code path in next series.

Hi Himanshu,

I think this is something Martin should decide.

Thanks,

Bart.
