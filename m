Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5CA62855B
	for <lists+linux-scsi@lfdr.de>; Thu, 23 May 2019 19:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731309AbfEWRyW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 23 May 2019 13:54:22 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41694 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730899AbfEWRyV (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 23 May 2019 13:54:21 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 68A1EBC86A3233106C86;
        Fri, 24 May 2019 01:54:17 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Fri, 24 May 2019
 01:54:09 +0800
Subject: Re: [PATCH RFT plinth/v4.15 11/12] blk-mq: Allow PCI vector offset
 for mapping queues
To:     <chenxiang66@hisilicon.com>
References: <1558633822-186079-1-git-send-email-john.garry@huawei.com>
 <1558633822-186079-12-git-send-email-john.garry@huawei.com>
CC:     <linuxarm@huawei.com>, Keith Busch <keith.busch@intel.com>,
        Don Brace <don.brace@microsemi.com>,
        <qla2xxx-upstream@qlogic.com>, <linux-scsi@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
From:   John Garry <john.garry@huawei.com>
Message-ID: <052e2acf-fcfe-60c1-5ad3-d94ba9b9f58a@huawei.com>
Date:   Thu, 23 May 2019 18:54:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1558633822-186079-12-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On 23/05/2019 18:50, John Garry wrote:
> From: Keith Busch <keith.busch@intel.com>
>

Please ignore these. I was supposed to only send internally, git then I 
forgot to suppress the recipients.

> The PCI interrupt vectors intended to be associated with a queue may
> not start at 0; a driver may allocate pre_vectors for special use. This
> patch adds an offset parameter so blk-mq may find the intended affinity
> mask and updates all drivers using this API accordingly.
>
> Cc: Don Brace <don.brace@microsemi.com>
> Cc: <qla2xxx-upstream@qlogic.com>
> Cc: <linux-scsi@vger.kernel.org>
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/blk-mq-pci.c                    | 6 ++++--
>  drivers/nvme/host/pci.c               | 2 +-
>  drivers/scsi/qla2xxx/qla_os.c         | 7 ++++++-
>  drivers/scsi/smartpqi/smartpqi_init.c | 2 +-
>  include/linux/blk-mq-pci.h            | 3 ++-
>  5 files changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/block/blk-mq-pci.c b/block/blk-mq-pci.c
> index 76944e3271bf..e233996bb76f 100644
> --- a/block/blk-mq-pci.c
> +++ b/block/blk-mq-pci.c
> @@ -21,6 +21,7 @@
>   * blk_mq_pci_map_queues - provide a default queue mapping for PCI device
>   * @set:	tagset to provide the mapping for
>   * @pdev:	PCI device associated with @set.
> + * @offset:	Offset to use for the pci irq vector
>   *
>   * This function assumes the PCI device @pdev has at least as many available
>   * interrupt vectors as @set has queues.  It will then query the vector
> @@ -28,13 +29,14 @@
>   * that maps a queue to the CPUs that have irq affinity for the corresponding
>   * vector.
>   */
> -int blk_mq_pci_map_queues(struct blk_mq_tag_set *set, struct pci_dev *pdev)
> +int blk_mq_pci_map_queues(struct blk_mq_tag_set *set, struct pci_dev *pdev,
> +			    int offset)
>  {
>  	const struct cpumask *mask;
>  	unsigned int queue, cpu;
>
>  	for (queue = 0; queue < set->nr_hw_queues; queue++) {
> -		mask = pci_irq_get_affinity(pdev, queue);
> +		mask = pci_irq_get_affinity(pdev, queue + offset);
>  		if (!mask)
>  			goto fallback;
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 4276ebfff22b..74de03782b93 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -414,7 +414,7 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
>  {
>  	struct nvme_dev *dev = set->driver_data;
>
> -	return blk_mq_pci_map_queues(set, to_pci_dev(dev->dev));
> +	return blk_mq_pci_map_queues(set, to_pci_dev(dev->dev), 0);
>  }
>
>  /**
> diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
> index 46f2d0cf7c0d..9f01fc56e40a 100644
> --- a/drivers/scsi/qla2xxx/qla_os.c
> +++ b/drivers/scsi/qla2xxx/qla_os.c
> @@ -6609,8 +6609,13 @@ qla83xx_disable_laser(scsi_qla_host_t *vha)
>  static int qla2xxx_map_queues(struct Scsi_Host *shost)
>  {
>  	scsi_qla_host_t *vha = (scsi_qla_host_t *)shost->hostdata;
> +	int rc;
>
> -	return blk_mq_pci_map_queues(&shost->tag_set, vha->hw->pdev);
> +	if (USER_CTRL_IRQ(vha->hw))
> +		rc = blk_mq_map_queues(&shost->tag_set);
> +	else
> +		rc = blk_mq_pci_map_queues(&shost->tag_set, vha->hw->pdev, 0);
> +	return rc;
>  }
>
>  static const struct pci_error_handlers qla2xxx_err_handler = {
> diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
> index b2880c7709e6..10c94011c8a8 100644
> --- a/drivers/scsi/smartpqi/smartpqi_init.c
> +++ b/drivers/scsi/smartpqi/smartpqi_init.c
> @@ -5348,7 +5348,7 @@ static int pqi_map_queues(struct Scsi_Host *shost)
>  {
>  	struct pqi_ctrl_info *ctrl_info = shost_to_hba(shost);
>
> -	return blk_mq_pci_map_queues(&shost->tag_set, ctrl_info->pci_dev);
> +	return blk_mq_pci_map_queues(&shost->tag_set, ctrl_info->pci_dev, 0);
>  }
>
>  static int pqi_getpciinfo_ioctl(struct pqi_ctrl_info *ctrl_info,
> diff --git a/include/linux/blk-mq-pci.h b/include/linux/blk-mq-pci.h
> index 6338551e0fb9..9f4c17f0d2d8 100644
> --- a/include/linux/blk-mq-pci.h
> +++ b/include/linux/blk-mq-pci.h
> @@ -5,6 +5,7 @@
>  struct blk_mq_tag_set;
>  struct pci_dev;
>
> -int blk_mq_pci_map_queues(struct blk_mq_tag_set *set, struct pci_dev *pdev);
> +int blk_mq_pci_map_queues(struct blk_mq_tag_set *set, struct pci_dev *pdev,
> +			  int offset);
>
>  #endif /* _LINUX_BLK_MQ_PCI_H */
>


