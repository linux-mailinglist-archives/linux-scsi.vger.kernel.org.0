Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7252C1B36AD
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Apr 2020 07:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbgDVFI5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 22 Apr 2020 01:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgDVFI4 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 22 Apr 2020 01:08:56 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C637C061BD3
        for <linux-scsi@vger.kernel.org>; Tue, 21 Apr 2020 22:08:56 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x18so800775wrq.2
        for <linux-scsi@vger.kernel.org>; Tue, 21 Apr 2020 22:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wMiI4Qf4hspdBsWLhhvueVyrrGl6L2aPo7y8kETWUm4=;
        b=ra3i6trdtJMck2tmO7OFK8NpZU6uDBvEiH+FYsT9kDHFx5iDLLtesGkkXYFk6pwDo4
         bNud1QTPUqgyn45z12zz5zeXb/DaP1NpV/nzKoUyjkZMEeSsjf1AGpH6BVQkyUrCuhUo
         e3WM7JkYXZZrmzJ25Iio3smeXmc9BFGJXIQhccya87wR3kSS5+XBib4Y5XCj+vJUNRiA
         eOMmabrUz1LIGJDd6MP0NG74aNy2utPDPfP+kiWkqE1dhHdkDXijI4CBUBEEzf0gRNtT
         5kzEdgSwep08gFbMRizE/CFmm8zXcTM/j3GrE7fjFz1WVYKL1LJTBadKMnho3D44L9G0
         qbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wMiI4Qf4hspdBsWLhhvueVyrrGl6L2aPo7y8kETWUm4=;
        b=Rv41cGHXHVQIME5rr/LZVWSEgfbmTBwfXLKDWIxyrj2DcpX1pwzSdyyvxLsUgqMM1m
         /FMEZr6/XAXsyFkPycprCKhwKPLb07Rh/2/6uDsDuT0HCFNAvbP1hgs7tq7sU25c8EPE
         x0oow2KTxLJHsHMe+aF3V1+MJ5z7FLsnTFPz66ypHxnTAjQ6f+cQCNtwSwohm1spCOet
         59FCInrucbaadwnSPs2DSUXNYCMBVlU2baULD6pNSPEPmZUKo4HcF8Ma7H0Wd9BO+wSX
         13TKPvwJ/vGapV/BE5laHffB4/ggT0Fkd7dy4PM5vFiyq4OJD/BoaBZ8DO98XEc3fxjd
         /Ivw==
X-Gm-Message-State: AGi0Pua0L8un4e/MlOJ/elMrodhj2Hr9f+TtpgtT38j3XcREopJA+YvJ
        JiviXVZkrRhY/78uADN/lko=
X-Google-Smtp-Source: APiQypJULwfXrIRT2BkUojZTgKtzoY58c1DIqhzfkt0QkSj8UXJf8OVAqyo7qBwpjJMfgdBZenU+gQ==
X-Received: by 2002:a5d:6851:: with SMTP id o17mr26919370wrw.267.1587532134976;
        Tue, 21 Apr 2020 22:08:54 -0700 (PDT)
Received: from [10.230.185.141] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j3sm6438589wrw.28.2020.04.21.22.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 22:08:54 -0700 (PDT)
Subject: Re: [PATCH v3 05/31] elx: libefc_sli: Populate and post different
 WQEs
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-scsi@vger.kernel.org, maier@linux.ibm.com,
        bvanassche@acm.org, herbszt@gmx.de, natechancellor@gmail.com,
        rdunlap@infradead.org, hare@suse.de,
        Ram Vegesna <ram.vegesna@broadcom.com>
References: <20200412033303.29574-1-jsmart2021@gmail.com>
 <20200412033303.29574-6-jsmart2021@gmail.com>
 <20200415143420.wus5dfqhjuxxbpqn@carbon>
From:   James Smart <jsmart2021@gmail.com>
Message-ID: <5c9ffa81-b048-bb52-cbdc-899498bd2ec5@gmail.com>
Date:   Tue, 21 Apr 2020 22:08:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200415143420.wus5dfqhjuxxbpqn@carbon>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 4/15/2020 7:34 AM, Daniel Wagner wrote:
...
>> +/* Write an ABORT_WQE work queue entry */
>> +int
>> +sli_abort_wqe(struct sli4 *sli4, void *buf, size_t size,
>> +	      enum sli4_abort_type type, bool send_abts, u32 ids,
>> +	      u32 mask, u16 tag, u16 cq_id)
>> +{
>> +	struct sli4_abort_wqe	*abort = buf;
>> +
>> +	memset(buf, 0, size);
> 
> Is 'size' expected to be equal to the size of 'struct sli4_abort_wqe'?
> Or could it be bigger? In case 'size' can be bigger than 'abort', do
> you need to clear the complete buffer, or would it be enough to clear
> only the size of 'abort'?

'buf' represents the abort WQE. Size will be the WQE size. Yeah, this is 
unclear. Will fix up the coding to make the actions explicit and clear.

Agree with other comments and will address them.

-- james

