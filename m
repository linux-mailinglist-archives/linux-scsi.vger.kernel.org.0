Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDF27360578
	for <lists+linux-scsi@lfdr.de>; Thu, 15 Apr 2021 11:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbhDOJS2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 15 Apr 2021 05:18:28 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2859 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhDOJS1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 15 Apr 2021 05:18:27 -0400
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FLYXD44ZBz68BVc;
        Thu, 15 Apr 2021 17:12:44 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 15 Apr 2021 11:18:02 +0200
Received: from [10.47.83.117] (10.47.83.117) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 15 Apr
 2021 10:18:02 +0100
Subject: Re: [PATCH] scsi_debug: fix cmd_per_lun, set to max_queue
To:     Douglas Gilbert <dgilbert@interlog.com>,
        <linux-scsi@vger.kernel.org>
CC:     <martin.petersen@oracle.com>, <jejb@linux.vnet.ibm.com>,
        <kashyap.desai@broadcom.com>, <ming.lei@redhat.com>,
        <axboe@kernel.dk>
References: <20210415015031.607153-1-dgilbert@interlog.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <580349dc-0152-8f39-5f3c-be9115e3bf12@huawei.com>
Date:   Thu, 15 Apr 2021 10:15:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20210415015031.607153-1-dgilbert@interlog.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.83.117]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This looks ok.

Apart from this, I tested linux-next (without this patch) - which 
includes Ming's changes to replace sdev-->device_busy with sbitmap - 
and, as expected, it has the issue.

So I think it is also worth having this to stop this happening elsewhere:

------>8-------

Subject: [PATCH] scsi: core: Cap initial sdev queue depth at Shost.can_queue

Function sdev_store_queue_depth() enforces that the sdev queue depth 
cannot exceed Shost.can_queue.

However, the LLDD may still set cmd_per_lun > can_queue, which would 
lead to an initial sdev queue depth greater than can_queue.

Stop this happened by capping initial sdev queue depth at can_queue.

<insert credits>
Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 9af50e6f94c4..fec6c17ff37c 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -218,6 +218,7 @@ static struct scsi_device *scsi_alloc_sdev(struct 
scsi_target *starget,
  	struct scsi_device *sdev;
  	int display_failure_msg = 1, ret;
  	struct Scsi_Host *shost = dev_to_shost(starget->dev.parent);
+	int depth;

  	sdev = kzalloc(sizeof(*sdev) + shost->transportt->device_size,
  		       GFP_KERNEL);
@@ -276,8 +277,13 @@ static struct scsi_device *scsi_alloc_sdev(struct 
scsi_target *starget,
  	WARN_ON_ONCE(!blk_get_queue(sdev->request_queue));
  	sdev->request_queue->queuedata = sdev;

-	scsi_change_queue_depth(sdev, sdev->host->cmd_per_lun ?
-					sdev->host->cmd_per_lun : 1);
+	if (sdev->host->cmd_per_lun)
+		depth = min_t(int, sdev->host->cmd_per_lun,
+			      sdev->host->can_queue);
+	else
+		depth = 1;
+
+	scsi_change_queue_depth(sdev, depth);

  	scsi_sysfs_device_initialize(sdev);
