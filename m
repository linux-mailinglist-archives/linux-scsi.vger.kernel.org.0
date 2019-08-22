Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51925996DF
	for <lists+linux-scsi@lfdr.de>; Thu, 22 Aug 2019 16:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731611AbfHVOhL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 22 Aug 2019 10:37:11 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38770 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729731AbfHVOhK (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 22 Aug 2019 10:37:10 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D696CA1D402D4DDE0E6B;
        Thu, 22 Aug 2019 22:36:25 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 22 Aug 2019
 22:36:15 +0800
Subject: Re: [PATCH] scsi: hisi_sas: remove set but not used variable
 'irq_value'
To:     zhengbin <zhengbin13@huawei.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
References: <1566483647-121127-1-git-send-email-zhengbin13@huawei.com>
CC:     <yi.zhang@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b2269743-fd2a-fc57-dd8d-e4e645d6eb7b@huawei.com>
Date:   Thu, 22 Aug 2019 15:36:11 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1566483647-121127-1-git-send-email-zhengbin13@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 22/08/2019 15:20, zhengbin wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
>
> drivers/scsi/hisi_sas/hisi_sas_v1_hw.c: In function cq_interrupt_v1_hw:
> drivers/scsi/hisi_sas/hisi_sas_v1_hw.c:1542:6: warning: variable irq_value set but not used [-Wunused-but-set-variable]
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>
> ---

Acked-by: John Garry <john.garry@huawei.com>

