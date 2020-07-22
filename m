Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80EB229471
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Jul 2020 11:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731088AbgGVJGH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 22 Jul 2020 05:06:07 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51994 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726821AbgGVJGD (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 22 Jul 2020 05:06:03 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DFF3E3682621332C239E;
        Wed, 22 Jul 2020 17:05:59 +0800 (CST)
Received: from huawei.com (10.69.192.56) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Wed, 22 Jul 2020
 17:05:52 +0800
From:   Luo Jiaxing <luojiaxing@huawei.com>
To:     <martin.petersen@oracle.com>, <jejb@linux.ibm.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <john.garry@huawei.com>, <yanaijie@huawei.com>,
        <chenxiang66@hisilicon.com>, <luojiaxing@huawei.com>,
        <linuxarm@huawei.com>
Subject: [PATCH v1 2/2] {topost} scsi: libsas: check link status at ATA prereset() ops
Date:   Wed, 22 Jul 2020 17:04:03 +0800
Message-ID: <1595408643-63011-3-git-send-email-luojiaxing@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595408643-63011-1-git-send-email-luojiaxing@huawei.com>
References: <1595408643-63011-1-git-send-email-luojiaxing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

We found out that libata will retry reset even if SATA disk is unpluged. We
should report offline to libata to avoid meaningless reset on the disk.
Libata provide an ops of prereset() for this purpose, it was called by
ata_eh_reset() only and used to decide whether to skip reset base on the
return value of it.

We check status of phy and disk at prereset(). If disk is already offline
or phy is disabled, we return -ENOENT to libata to skip disk reset.

As prereset() should be best-effort, we should continue to try disk reset
beyond the situation we mentioned before.

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
Reviewed-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/libsas/sas_ata.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index a7d16d2..1b93332 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -507,8 +507,22 @@ void sas_ata_end_eh(struct ata_port *ap)
 	spin_unlock_irqrestore(&ha->lock, flags);
 }
 
+static int sas_ata_prereset(struct ata_link *link, unsigned long deadline)
+{
+	struct ata_port *ap = link->ap;
+	struct domain_device *dev = ap->private_data;
+	struct sas_phy *local_phy = sas_get_local_phy(dev);
+	int res = 0;
+
+	if (!local_phy->enabled || test_bit(SAS_DEV_GONE, &dev->state))
+		res = -ENOENT;
+	sas_put_local_phy(local_phy);
+
+	return res;
+}
+
 static struct ata_port_operations sas_sata_ops = {
-	.prereset		= ata_std_prereset,
+	.prereset		= sas_ata_prereset,
 	.hardreset		= sas_ata_hard_reset,
 	.error_handler		= ata_std_error_handler,
 	.post_internal_cmd	= sas_ata_post_internal,
-- 
2.7.4

