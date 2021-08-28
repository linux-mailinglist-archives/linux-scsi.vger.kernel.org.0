Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676F43FA29D
	for <lists+linux-scsi@lfdr.de>; Sat, 28 Aug 2021 02:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhH1A5W (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 27 Aug 2021 20:57:22 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8791 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbhH1A5W (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 27 Aug 2021 20:57:22 -0400
Received: from dggeme754-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GxJ6f1QBKzYv88;
        Sat, 28 Aug 2021 08:55:54 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 dggeme754-chm.china.huawei.com (10.3.19.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Sat, 28 Aug 2021 08:56:30 +0800
Subject: Re: [PATCH -next 0/2] Fix out-of-bound in resp_readcap16 and
 resp_report_tgtpgs
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20210818021428.3720233-1-yebin10@huawei.com>
From:   yebin <yebin10@huawei.com>
Message-ID: <612989BE.5080600@huawei.com>
Date:   Sat, 28 Aug 2021 08:56:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20210818021428.3720233-1-yebin10@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme754-chm.china.huawei.com (10.3.19.100)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

ping......

On 2021/8/18 10:14, Ye Bin wrote:
> Ye Bin (2):
>    scsi:scsi_debug: Fix out-of-bound in resp_readcap16
>    scsi:scsi_debug: Fix potential OOB in resp_report_tgtpgs
>
>   drivers/scsi/scsi_debug.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
>

