Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F41424A5F9
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Jun 2019 17:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbfFRP5P (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Jun 2019 11:57:15 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37115 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbfFRP5P (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 18 Jun 2019 11:57:15 -0400
Received: by mail-pf1-f196.google.com with SMTP id 19so7916007pfa.4
        for <linux-scsi@vger.kernel.org>; Tue, 18 Jun 2019 08:57:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6jqG/mFBF3OknEmHRZdSVoDvMEJugzoximI0yfOwT8w=;
        b=Jf8L1TXunep2pXI6Olw7E1ErlQLGsltZRNpIlQf5OvFYjDzTxU41SxKRDZJaUv4dxk
         9YNqUpIui1gqurghpA7xv6dlMwLEJP+326cSNXufszGX8EcKh6EXOVRf87rtzNCoRE9U
         BCNBh3Y1ZKrCtuOebinRcEdFCUgzJ6xAIZVgoOAczeYh+2djMfUa21s+qWRvp4nX2RN2
         UFWOwG3SlkkM1uDRcM/1hqsnGq/ecdQCA1DR7ZvL4RSoDQ3oGAGdBJ5ToEMzVgURiB4l
         MYkH7mUTyUcHmhWPVlm7oN7Wsw3H2roZBn1nG7twHqbsucCrCi9Lz6xATUXAGYM+tUFz
         FO3Q==
X-Gm-Message-State: APjAAAUWCAiLqJK7keDYsiY4jG3m/RgLMeUjOhjfWMa4nF3cHO/rl9w/
        0RZUhTVnwhsCFbYpnfRltwvsJDYQpbI=
X-Google-Smtp-Source: APXvYqwk8KO7BjmMx11XXhQWR0QY3kh7MdbeEXnhnlD3oz1ZBPpnzkYGgajeVZsYzMydSYf1ooH3yA==
X-Received: by 2002:a63:d07:: with SMTP id c7mr3279093pgl.394.1560873434044;
        Tue, 18 Jun 2019 08:57:14 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id g92sm3597278pje.11.2019.06.18.08.57.12
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 08:57:13 -0700 (PDT)
Subject: Re: [EXT] Re: [PATCH 3/3] qla2xxx: Fix NVME cmd and LS cmd timeout
 race condition
To:     Quinn Tran <qutran@marvell.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
References: <20190614221020.19173-1-hmadhani@marvell.com>
 <20190614221020.19173-4-hmadhani@marvell.com>
 <dc2bad07-0ba0-06e7-b52a-57f774bc3ff2@acm.org>
 <CDBC6094-EA99-45BE-A420-404ED6A3BE0F@marvell.com>
 <e5b17e5a-49d1-7496-a395-9a09bb791a7f@acm.org>
 <52D4CB41-2BD6-4CD6-B779-DC4C5F0CE94E@marvell.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <2d582a54-024a-186a-fa52-6bc8123247e9@acm.org>
Date:   Tue, 18 Jun 2019 08:57:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <52D4CB41-2BD6-4CD6-B779-DC4C5F0CE94E@marvell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/17/19 5:01 PM, Quinn Tran wrote:
> Attached is the clean-up patch that we held back from the series. > We felt it wasn't ready for wider audience because it needed additional
> soak time with our test group.
> 
> We want to ahead and share it with you to let you know that we intent
> to cleanup the duplicate atomic [ref_count|kref].  Once it has some
> soak time in our test group, we'll submit it in the next RC window.

Hi Quinn,

Thank you for having shared that patch early. My comments about that 
patch are as follows:
- The patch description is not correct. Today freeing of an SRB does not 
happen when ref_count reaches zero but it happens when the firmware 
reports a completion. That is why today the abort code can trigger a 
use-after-free. ref_count is only useful today for the abort code to 
detect atomically whether or not the firmware already reported that a 
request completed.
- Only calling cmd->scsi-done(cmd) when the reference count reaches zero 
involves a behavior change. If a command completion and a request to 
abort a command race, this patch will report the command as aborted to 
the SCSI mid-layer instead of as completed. This change has not been 
mentioned in the patch description. Is this change perhaps unintentional?
- I think that this patch does not address the memory leak that can be 
triggered by aborting a command. If a command is aborted it will be 
freed by qla_release_fcp_cmd_kref() calling qla2xxx_rel_qpair_sp() and 
by qla2xxx_rel_qpair_sp() calling sp->free(sp). However, the 
implementation of the free function for multiple SRB types is incomplete.
- The approach for avoiding that qla2xxx_eh_abort() triggers a 
use-after-free (the new srb_private structure) is interesting. However, 
that approach does not look correct to me. The patch attached to the 
previous e-mail inserts the following code in qla2xxx_eh_abort():
   'sp = CMD_SP(cmd); if (!sp || !sp->qpair || ...) return SUCCESS'
As one can see the sp pointer is dereferenced although the memory it 
points at could already have been freed and could have been reallocated 
by another driver or another process. So I don't think the new code for 
avoiding a use-after-free is correct.

Thanks,

Bart.
