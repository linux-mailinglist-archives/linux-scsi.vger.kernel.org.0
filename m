Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96CE01389BA
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jan 2020 04:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733124AbgAMDa1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 12 Jan 2020 22:30:27 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:42840 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732961AbgAMDa1 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 12 Jan 2020 22:30:27 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2566941A5205CB78BBAE;
        Mon, 13 Jan 2020 11:30:25 +0800 (CST)
Received: from [127.0.0.1] (10.74.219.194) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Mon, 13 Jan 2020
 11:30:16 +0800
Subject: Re: Failed to disable WCE for a SATA disk
To:     "axboe@kernel.dk" <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
References: <a3624979-0917-4b66-ca18-89e0e2dd3bf2@hisilicon.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>,
        John Garry <john.garry@huawei.com>
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Message-ID: <d6e8987b-e44e-661e-7338-321583e9fb75@hisilicon.com>
Date:   Mon, 13 Jan 2020 11:30:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <a3624979-0917-4b66-ca18-89e0e2dd3bf2@hisilicon.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.219.194]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi,

在 2019/12/11 11:21, chenxiang (M) 写道:
> Hi,
>
> I encounter a issue related to libata and libsas. For hisi_sas driver, 
> it uses libsas. When disable WCE with tool sdparm (sdparm --clear=WCE 
> /dev/sda) for a SATA disk,
> it fails with error info from hardware (the error info indicates that 
> the length of transfer data is conflicted with the direction of data, 
> the length is 0 but
> the data of direction is from host to device).
>
> I check the process: When disable WCE, it sends pasthrough IO with 
> sg_io , req->__data_len is not 0, and scsi_cmd->sc_data_direction = 
> DMA_TO_DEVICE.
> But for the command (MODE_SELECT), qc->tf.protocol is set 0 (not 
> ATA_PROT_DMA) in ->queuecommand() 
> ->ata_sas_queuecmd()->ata_scsi_translate()->ata_scsi_mod_select_xlat()->ata_mselect_caching(),
> so it doesn't dma map ata sg in function ata_qc_issue(). While in 
> function sas_ata_qc_issue()，it calcutes the length with the total sum 
> of sg_dma_len(sg), as for the
> command it doesn't dma map ata sg, so the length is 0.
>
> Do we need to dma map ata sg for the command? Or is it really we need 
> the data for the command MODE_SELECT?

Does anyone have idea about it ?

>
> Thanks,
> Shawn
>
>
>
>
> .
>


