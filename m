Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13F51F4FE5
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Jun 2020 10:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgFJIEz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 10 Jun 2020 04:04:55 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2296 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726081AbgFJIEz (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 10 Jun 2020 04:04:55 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 1DFD2EF70D61A189973C;
        Wed, 10 Jun 2020 09:04:54 +0100 (IST)
Received: from [127.0.0.1] (10.210.170.95) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 10 Jun
 2020 09:04:52 +0100
Subject: Re: [PATCH] scsi: wire up ata_scsi_dma_need_drain for SAS HBA drivers
To:     Christoph Hellwig <hch@lst.de>, <martin.petersen@oracle.com>
CC:     <brking@us.ibm.com>, <jinpu.wang@cloud.ionos.com>,
        <linux-scsi@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <20200610064540.269738-1-hch@lst.de>
From:   John Garry <john.garry@huawei.com>
Message-ID: <22e958c7-2afb-5d1f-5e7b-3b789440375e@huawei.com>
Date:   Wed, 10 Jun 2020 09:03:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200610064540.269738-1-hch@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.170.95]
X-ClientProxiedBy: lhreml719-chm.china.huawei.com (10.201.108.70) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 10/06/2020 07:45, Christoph Hellwig wrote:
> We need ata_scsi_dma_need_drain for all drivers wired up to drive ATAPI
> devices through libata.  That also includes the SAS HBA drivers in
> addition to native libata HBA drivers.
> 
> Fixes: cc97923a5bcc ("block: move dma drain handling to scsi")
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: John Garry <john.garry@huawei.com> #hisi_sas
