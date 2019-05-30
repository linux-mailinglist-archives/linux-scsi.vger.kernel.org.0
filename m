Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92AE92FB9F
	for <lists+linux-scsi@lfdr.de>; Thu, 30 May 2019 14:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfE3Mfa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 30 May 2019 08:35:30 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17629 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726079AbfE3Mfa (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 30 May 2019 08:35:30 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 965A17F928D3E9B56562;
        Thu, 30 May 2019 20:35:28 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Thu, 30 May 2019
 20:35:26 +0800
Subject: Re: [PATCH 06/24] virtio_scsi: use reserved commands for TMF
To:     Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20190529132901.27645-1-hare@suse.de>
 <20190529132901.27645-7-hare@suse.de>
CC:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        <linux-scsi@vger.kernel.org>, "Hannes Reinecke" <hare@suse.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <411d86bf-abba-90c2-1021-f03c30f1b3d0@huawei.com>
Date:   Thu, 30 May 2019 13:35:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190529132901.27645-7-hare@suse.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 29/05/2019 14:28, Hannes Reinecke wrote:
>
>  static int virtscsi_map_queues(struct Scsi_Host *shost)
> @@ -827,6 +830,8 @@ static int virtscsi_probe(struct virtio_device *vdev)
>  	shost->max_channel = 0;
>  	shost->max_cmd_len = VIRTIO_SCSI_CDB_SIZE;
>  	shost->nr_hw_queues = num_queues;
> +	shost->can_queue -= VIRTIO_SCSI_RESERVED_CMDS;

shost->can_queue is already referenced after it is set earlier in 
virtscsi_probe(), so I wonder if this is ok to later revise it? See:

shost->cmd_per_lun = min_t(u32, cmd_per_lun, shost->can_queue);

thanks,
John

> +	shost->nr_reserved_cmds = VIRTIO_SCSI_RESERVED_CMDS;
>
>  #ifdef CONFIG_BLK_DEV_INTEGRITY
>  	if (virtio_has_feature(vdev, VIRTIO_SCSI_F_T10_PI)) {
> @@ -928,45 +933,12 @@ static struct virtio_driver virtio_scsi_driver = {


