Return-Path: <linux-scsi+bounces-386-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CB180029C
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Dec 2023 05:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E4F328148A
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Dec 2023 04:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D38C8493
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Dec 2023 04:34:38 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2121711;
	Thu, 30 Nov 2023 18:59:59 -0800 (PST)
Received: from dggpemd100001.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ShHp650blzWj2q;
	Fri,  1 Dec 2023 10:59:10 +0800 (CST)
Received: from [10.67.120.108] (10.67.120.108) by
 dggpemd100001.china.huawei.com (7.185.36.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Fri, 1 Dec 2023 10:59:57 +0800
Message-ID: <2bc81cf1-5d94-c108-a107-a746daadb64d@huawei.com>
Date: Fri, 1 Dec 2023 10:59:56 +0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] scsi: libsas: Put the disk offline if all recovery
 actions fail
Content-Language: en-CA
From: yangxingui <yangxingui@huawei.com>
To: <john.g.garry@oracle.com>, <yanaijie@huawei.com>,
	<damien.lemoal@opensource.wdc.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<wubo40@huawei.com>, <kangfenglong@huawei.com>
References: <20231130130118.14367-1-yangxingui@huawei.com>
In-Reply-To: <20231130130118.14367-1-yangxingui@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggpemm100004.china.huawei.com (7.185.36.189) To
 dggpemd100001.china.huawei.com (7.185.36.94)
X-CFilter-Loop: Reflected

Sorry, please ignore this email, I need to update a new version, Thanks.

On 2023/11/30 21:01, Xingui Yang wrote:
> Currently, after all recovery actions in sas_eh_handle_sas_errors() fail
> for sas disk, we just clear all IO, but the disk is still online. Perhaps
> we should continue the subsequent recovery process for IO that cannot be
> processed. If it still fails, the disk will be offline in
> scsi_eh_ready_devs().
> 
> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
> Signed-off-by: Bo Wu <wubo40@huawei.com>
> ---
>   drivers/scsi/libsas/sas_scsi_host.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
> index 9047cfcd1072..3f9b99fa1769 100644
> --- a/drivers/scsi/libsas/sas_scsi_host.c
> +++ b/drivers/scsi/libsas/sas_scsi_host.c
> @@ -637,8 +637,8 @@ static void sas_eh_handle_sas_errors(struct Scsi_Host *shost, struct list_head *
>   			       SAS_ADDR(task->dev->sas_addr),
>   			       cmd->device->lun);
>   
> -			sas_eh_finish_cmd(cmd);
> -			goto clear_q;
> +			list_move_tail(&cmd->eh_entry, work_q);
> +			goto out;
>   		}
>   	}
>    out:
> 

