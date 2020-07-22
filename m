Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B19A229619
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Jul 2020 12:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731610AbgGVKbk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 22 Jul 2020 06:31:40 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8250 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726161AbgGVKbk (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 22 Jul 2020 06:31:40 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A4DB772ADF9EA56FF471;
        Wed, 22 Jul 2020 18:31:38 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.92) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Wed, 22 Jul 2020
 18:31:30 +0800
Subject: Re: [PATCH v1 2/2] {topost} scsi: libsas: check link status at ATA
 prereset() ops
To:     Luo Jiaxing <luojiaxing@huawei.com>, <martin.petersen@oracle.com>,
        <jejb@linux.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <john.garry@huawei.com>, <chenxiang66@hisilicon.com>,
        <linuxarm@huawei.com>
References: <1595408643-63011-1-git-send-email-luojiaxing@huawei.com>
 <1595408643-63011-3-git-send-email-luojiaxing@huawei.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <1658a661-bf58-85b6-8475-7c29dce63eb3@huawei.com>
Date:   Wed, 22 Jul 2020 18:31:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <1595408643-63011-3-git-send-email-luojiaxing@huawei.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.92]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


�� 2020/7/22 17:04, Luo Jiaxing д��:
> We found out that libata will retry reset even if SATA disk is unpluged. We
> should report offline to libata to avoid meaningless reset on the disk.
> Libata provide an ops of prereset() for this purpose, it was called by
> ata_eh_reset() only and used to decide whether to skip reset base on the
> return value of it.
> 
> We check status of phy and disk at prereset(). If disk is already offline
> or phy is disabled, we return -ENOENT to libata to skip disk reset.
> 
> As prereset() should be best-effort, we should continue to try disk reset
> beyond the situation we mentioned before.
> 
> Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
> Reviewed-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/scsi/libsas/sas_ata.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 

The same as the first one, after fix the  subject:

Reviewed-by: Jason Yan <yanaijie@huawei.com>

