Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6308939A4EF
	for <lists+linux-scsi@lfdr.de>; Thu,  3 Jun 2021 17:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhFCPnX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 3 Jun 2021 11:43:23 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3149 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhFCPnX (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 3 Jun 2021 11:43:23 -0400
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Fwqdp3G5fz6S1S3;
        Thu,  3 Jun 2021 23:32:30 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 17:41:37 +0200
Received: from [10.47.80.115] (10.47.80.115) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Thu, 3 Jun 2021
 16:41:36 +0100
Subject: Re: [PATCH 3/4] scsi: core: put .shost_dev in failure path if host
 state becomes running
To:     Ming Lei <ming.lei@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
References: <20210602133029.2864069-1-ming.lei@redhat.com>
 <20210602133029.2864069-4-ming.lei@redhat.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <69d431c8-1f4b-2e66-a765-554c86b48016@huawei.com>
Date:   Thu, 3 Jun 2021 16:41:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210602133029.2864069-4-ming.lei@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.80.115]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 02/06/2021 14:30, Ming Lei wrote:
> scsi_host_dev_release() only works around for us by freeing
> dev_name(&shost->shost_dev) when host state is SHOST_CREATED. After host
> state is changed to SHOST_RUNNING, scsi_host_dev_release() doesn't do
> that any more.
> 
> So fix the issue by put .shost_dev in failure path if host state becomes
> running, meantime move get_device(&shost->shost_gendev) before
> device_add(&shost->shost_dev), so that scsi_host_cls_release() can put
> this reference.
> 
> Reported-by: John Garry<john.garry@huawei.com>
> Cc: Bart Van Assche<bvanassche@acm.org>
> Cc: Hannes Reinecke<hare@suse.de>
> Signed-off-by: Ming Lei<ming.lei@redhat.com>

Reviewed-by: John Garry <john.garry@huawei.com>
