Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30C534EF02
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Mar 2021 19:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhC3RJe (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 30 Mar 2021 13:09:34 -0400
Received: from mxout03.lancloud.ru ([45.84.86.113]:38382 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbhC3RJH (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 30 Mar 2021 13:09:07 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru E680620532CC
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
Subject: Re: [PATCH v2 0/3] Stop calling request_irq() with invalid IRQs
From:   Sergey Shtylyov <s.shtylyov@omprussia.ru>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
References: <ef3823c1-ee4a-5e9a-0a56-85f401ffa9dd@omprussia.ru>
Organization: Open Mobile Platform, LLC
Message-ID: <ceef607f-ae47-6d11-3732-5d35c3e9e94d@omprussia.ru>
Date:   Tue, 30 Mar 2021 20:07:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <ef3823c1-ee4a-5e9a-0a56-85f401ffa9dd@omprussia.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1908.lancloud.ru (fd00:f066::208)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 3/29/21 11:15 PM, Sergey Shtylyov wrote:

> Here are 3 patches against the 'fixes' branch of Martin Petersen's 'scsi.git' repo,
> 2 of them were previously posted separately, the 3rd is a new addition.
> 
> The affected drivers call platform_get_irq() but ignore its result -- they blithely
> pass the negative error codes to request_irq() which expects *unsinged* IRQ #s. Stop
> doing that by checking what platfrom_get_irq() returns.
> 
> [1/3: scsi: jazz_esp: add IRQ check
> [2/3] scsi: sun3x_esp: fix IRQ check
> [3/3] scsi: sni_53c710: fix IRQ check
 
   Oops, the above 2 patches got misnamed. I'll recast and repost...

MBR, Sergey
