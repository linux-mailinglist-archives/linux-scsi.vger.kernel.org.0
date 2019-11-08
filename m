Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 458BCF5B32
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Nov 2019 23:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKHWns (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 8 Nov 2019 17:43:48 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41181 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfKHWnr (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 8 Nov 2019 17:43:47 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so8736710wrm.8
        for <linux-scsi@vger.kernel.org>; Fri, 08 Nov 2019 14:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kFWZak/WLt5ENj5bOirqHId8/n0LSlnbVdCowbkmHUU=;
        b=QeA1RA9dG2h+YhKzjLmLE0x91jF5joGuWbv3zB+O4iauu8+DFMEw7SwawJ3jMv17F/
         oo2GXHEnIdx3qd+JfxdbAcJa1oT+Q+9bICejPVOpkFOhIk3sroaMElBWqxfCyoC2L7bD
         EZnKqEsUyOloRIZSJvrjViSz0xkYXJlvbtDcfs1YNPXMnvD68PDFhO5VjizklM8aaKzD
         LVp0oSO1WCGQzhqXP6nZjsP2h2EMr/7ROp3eAT7NOofx0Wna/C4f8dEL9BPlxHzQ1q65
         Rn6xXGkFk+dF9Cl58b8rPk5XNUUQlfuvC8KyGgau474EredLdPAPj6/UJWt9gWYFqhN+
         ukNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kFWZak/WLt5ENj5bOirqHId8/n0LSlnbVdCowbkmHUU=;
        b=PjePGLQMNbIiQcLmkM5jxBrnrEON/GbawAkgYzAcIeoR7ChwkVNpj9mVAicDxPAvmb
         BLwv799XKBL2av40Pk1imB/ctdoSqpenG2unA3tSxab7Sb2rbQZndSyMRuyWD1mTd/D/
         oRLcG0ijIlGng4DABJPHqKFdbi+3CsOvyIcazcvkrJDAl/n3gFibHc4b8rlKjxNwz2cc
         IpMjK8AIIiaIEF4Uel63Vtw/XiAM1baI4MUAPUc3HdLIEeWbP08MSPh4OP+Qq0ucPcwX
         Xt1LdIJ3FLIXUqLBlGh7J8DaQwkzZCUAV8rPLljd/bsKuxXuMhC2B5iFKBX85XG47K3Q
         HsJw==
X-Gm-Message-State: APjAAAWqp6Mwo7BCmq0ZGTHqpA/QtcsMG26vFnJLIcStdilhkftSrLP3
        qnQtGySulDSuYzfD1kKT19MVVAzI
X-Google-Smtp-Source: APXvYqxOy3lp7SEmk8JbVrjF2Egs1w6DPcEorDe3vSb3J45lNQcAbDPb9mX1Wgi5zrF0WHeMQB4BKg==
X-Received: by 2002:adf:e8ca:: with SMTP id k10mr9845067wrn.377.1573253025467;
        Fri, 08 Nov 2019 14:43:45 -0800 (PST)
Received: from [10.230.29.90] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g184sm11735157wma.8.2019.11.08.14.43.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2019 14:43:45 -0800 (PST)
Subject: Re: [PATCH 3/3] lpfc: Fix lpfc_cpumask_of_node_init()
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org
References: <20191107052158.25788-1-bvanassche@acm.org>
 <20191107052158.25788-6-bvanassche@acm.org>
From:   James Smart <jsmart2021@gmail.com>
Message-ID: <333c4e3a-ab41-64ca-940b-09ba8a9bec0e@gmail.com>
Date:   Fri, 8 Nov 2019 14:43:42 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191107052158.25788-6-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 11/6/2019 9:21 PM, Bart Van Assche wrote:
> Fix the following kernel warning:
> 
> cpumask_of_node(-1): (unsigned)node >= nr_node_ids(1)
> 
> Fixes: dcaa21367938 ("scsi: lpfc: Change default IRQ model on AMD architectures")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   drivers/scsi/lpfc/lpfc_init.c | 15 ++++-----------
>   1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
> index 37e57fd9ba5d..f2051e2f5f56 100644
> --- a/drivers/scsi/lpfc/lpfc_init.c
> +++ b/drivers/scsi/lpfc/lpfc_init.c
> @@ -6005,21 +6005,14 @@ static void
>   lpfc_cpumask_of_node_init(struct lpfc_hba *phba)
>   {
>   	unsigned int cpu, numa_node;
> -	struct cpumask *numa_mask = NULL;
> +	struct cpumask *numa_mask = &phba->sli4_hba.numa_mask;
>   
> -#ifdef CONFIG_NUMA
> -	numa_node = phba->pcidev->dev.numa_node;
> -#else
> -	numa_node = NUMA_NO_NODE;
> -#endif
> -	numa_mask = &phba->sli4_hba.numa_mask;
> +	numa_node = dev_to_node(&phba->pcidev->dev);
> +	if (numa_node == NUMA_NO_NODE)
> +		return;
>   
>   	cpumask_clear(numa_mask);

This patch is good - except that the cpumask_clear needs to be done 
before the return if not numa.

I'll repost with the mod

-- james


>   
> -	/* Check if we're a NUMA architecture */
> -	if (!cpumask_of_node(numa_node))
> -		return;
> -
>   	for_each_possible_cpu(cpu)
>   		if (cpu_to_node(cpu) == numa_node)
>   			cpumask_set_cpu(cpu, numa_mask);
> 

