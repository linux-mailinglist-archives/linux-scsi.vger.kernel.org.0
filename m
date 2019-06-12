Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFEA043124
	for <lists+linux-scsi@lfdr.de>; Wed, 12 Jun 2019 22:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfFLUyF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 12 Jun 2019 16:54:05 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42058 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727321AbfFLUyF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 12 Jun 2019 16:54:05 -0400
Received: by mail-pg1-f195.google.com with SMTP id l19so6979403pgh.9
        for <linux-scsi@vger.kernel.org>; Wed, 12 Jun 2019 13:54:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2eBjoCi7NUq9NvThzVSsvJcW4d8XjFx87Eu+oB31v8w=;
        b=SUP2G0vfCnZ1Jjicvbpgf1x/1UEb1ILtW8dn8tqdjtJ/lOJCGH0m5ta4tbXiAc9qq6
         8SvpT2DSyLqhp2J1xwHCfjn5i4ypr1dwckHbkGeuHIAflVmOQCMgah43yWuuusXSR+9a
         zQPyEYihknGS5wHuhHSjq5exJcaAAs9A/6MupmYb17D0DVNZleIo2GWJ3tv/ipAylppA
         bOIikOQM/S0wVfaOKoMXpPWvq+aOwscbCj1QnZM32iQM7VvQWDH/8hfmCWP01sfXVnIo
         Y6w+jgPluQpOh61ZOJARwiQABgCxmFHY+WXOQsamwV0Tesp4+AfOm6jx79sX3CO+Tc1p
         fGnw==
X-Gm-Message-State: APjAAAXN8cPXC8yBTSgNy9Tp7O1Ox7/a2oc/qM2y4d2lejeJYKFxWe2c
        jxR+X9QB7GwUDm8tGhfGZLo=
X-Google-Smtp-Source: APXvYqx5R9D+1ErFewj56+Cp51YMvZ0F3B4muyCdmfvNh5rZZ4YDWqb6Hjj0oridoWAu9InzswtHLw==
X-Received: by 2002:a17:90a:c504:: with SMTP id k4mr1119610pjt.104.1560372844926;
        Wed, 12 Jun 2019 13:54:04 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id o2sm122237pgp.74.2019.06.12.13.54.03
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 13:54:04 -0700 (PDT)
Subject: Re: [EXT] [PATCH 00/20] qla2xxx Patches
To:     Himanshu Madhani <hmadhani@marvell.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
References: <20190529202826.204499-1-bvanassche@acm.org>
 <794547A0-2D81-42DD-8777-27B9BE607E21@marvell.com>
 <yq1y32fo4d9.fsf@oracle.com>
 <838DE773-DCD5-40CA-933C-1FF88399AF6C@marvell.com>
 <yq1o93aml62.fsf@oracle.com>
 <BF5C02E6-89E5-493E-953A-A34B196BBD30@marvell.com>
 <c981ce78-e9d6-0d9f-ef17-385de6eb37f6@acm.org>
 <376D0AB1-1849-4211-9ABF-8EDFE632F097@marvell.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <b98e594a-8e34-5f6d-0e7c-c353add2945d@acm.org>
Date:   Wed, 12 Jun 2019 13:54:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <376D0AB1-1849-4211-9ABF-8EDFE632F097@marvell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 6/11/19 11:14 PM, Himanshu Madhani wrote:
> Here’s command that I am running in my script
> 
> # sg_reset -b /dev/mapper/mpathb
> sg_reset: SG_SCSI_RESET failed: Resource temporarily unavailable
> 
> # sg_reset -H /dev/mapper/mpathb
> sg_reset: SG_SCSI_RESET failed: Resource temporarily unavailable
> 
> # sg_reset -b /dev/mapper/mpathb
> sg_reset: SG_SCSI_RESET failed: Resource temporarily unavailable
> 
> Here’s stack trace after applying your patch series
> [ ... ]

Hi Himanshu,

Thank you for having shared your test case and also for having shared 
the call trace. While reviewing my own patches I noticed that patch 
20/20 needs further work. I will retest without that patch and get back 
to you.

Bart.
