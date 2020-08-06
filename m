Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23DDB23D70D
	for <lists+linux-scsi@lfdr.de>; Thu,  6 Aug 2020 08:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbgHFGyA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 6 Aug 2020 02:54:00 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57122 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728064AbgHFGx7 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 6 Aug 2020 02:53:59 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0C51E3CCD050DB735DEF;
        Thu,  6 Aug 2020 14:53:57 +0800 (CST)
Received: from [10.174.179.105] (10.174.179.105) by smtp.huawei.com
 (10.3.19.213) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 6 Aug 2020
 14:53:54 +0800
Subject: Re: [PATCH] scsi: ufs: ti-j721e-ufs: Fix error return in
 ti_j721e_ufs_probe()
To:     <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <vigneshr@ti.com>
References: <20200806064416.64462-1-jingxiangfeng@huawei.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Jing Xiangfeng <jingxiangfeng@huawei.com>
Message-ID: <5F2BA901.3060206@huawei.com>
Date:   Thu, 6 Aug 2020 14:53:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20200806064416.64462-1-jingxiangfeng@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.105]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Please ignore this patch.
	Thanks

On 2020/8/6 14:44, Jing Xiangfeng wrote:
> Fix to return error code IS_ERR() from the error handling case instead
> of 0.
>
> Fixes: 22617e216331 ("scsi: ufs: ti-j721e-ufs: Fix unwinding of pm_runtime changes")
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> ---
>   drivers/scsi/ufs/ti-j721e-ufs.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/scsi/ufs/ti-j721e-ufs.c b/drivers/scsi/ufs/ti-j721e-ufs.c
> index 46bb905b4d6a..eafe7c08b0c8 100644
> --- a/drivers/scsi/ufs/ti-j721e-ufs.c
> +++ b/drivers/scsi/ufs/ti-j721e-ufs.c
> @@ -38,6 +38,7 @@ static int ti_j721e_ufs_probe(struct platform_device *pdev)
>   	/* Select MPHY refclk frequency */
>   	clk = devm_clk_get(dev, NULL);
>   	if (IS_ERR(clk)) {
> +		ret = IS_ERR(clk);
>   		dev_err(dev, "Cannot claim MPHY clock.\n");
>   		goto clk_err;
>   	}
>
