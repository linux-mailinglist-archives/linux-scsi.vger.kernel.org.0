Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B50729E083
	for <lists+linux-scsi@lfdr.de>; Thu, 29 Oct 2020 02:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgJ1WEy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 28 Oct 2020 18:04:54 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7078 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729497AbgJ1WCN (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 28 Oct 2020 18:02:13 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CLp3v4wslzLqT4;
        Wed, 28 Oct 2020 20:36:59 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Wed, 28 Oct 2020 20:36:47 +0800
From:   John Garry <john.garry@huawei.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <martin.petersen@oracle.com>, <jejb@linux.ibm.com>,
        <tglx@linutronix.de>
CC:     <linuxarm@huawei.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <maz@kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 0/3] Support managed interrupts for platform devices
Date:   Wed, 28 Oct 2020 20:33:04 +0800
Message-ID: <1603888387-52499-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

So far, managed interrupts are only used for PCI MSIs. This series add
platform device support for managed interrupts. Initially this topic was
discussed at [0].

The method to enable managed interrupts is to allocate all the IRQs for
the device, and then switch the interrupts to managed - this is done
through new function irq_update_affinity_desc().

API platform_get_irqs_affinity() is added as a helper to manage this work,
such that we don't need to export irq_update_affinity_desc() or
irq_create_affinity_masks().

For now, the HiSilicon SAS v2 hw driver is switched over. This is used
in the D05 dev board.

Performance gain observed for 6x SAS SSDs is ~357K -> 420K IOPs for fio read.

[0] https://lore.kernel.org/lkml/84a9411b-4ae3-1928-3d35-1666f2687ec8@huawei.com/

Changes since v1:
- Update authorship on genirq change

John Garry (3):
  genirq/affinity: Add irq_update_affinity_desc()
  Driver core: platform: Add platform_get_irqs_affinity()
  scsi: hisi_sas: Expose HW queues for v2 hw

 drivers/base/platform.c                | 58 +++++++++++++++++++++
 drivers/scsi/hisi_sas/hisi_sas.h       |  4 ++
 drivers/scsi/hisi_sas/hisi_sas_main.c  | 11 ++++
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 71 ++++++++++++++++++++++----
 include/linux/interrupt.h              |  8 +++
 include/linux/platform_device.h        |  5 ++
 kernel/irq/manage.c                    | 19 +++++++
 7 files changed, 165 insertions(+), 11 deletions(-)

-- 
2.26.2

