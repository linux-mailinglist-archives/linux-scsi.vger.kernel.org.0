Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0231529AB8D
	for <lists+linux-scsi@lfdr.de>; Tue, 27 Oct 2020 13:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750756AbgJ0MOQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 27 Oct 2020 08:14:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:6404 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbgJ0MOP (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 27 Oct 2020 08:14:15 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CL9cB04t6z6yB1;
        Tue, 27 Oct 2020 20:14:18 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Tue, 27 Oct 2020 20:14:05 +0800
From:   John Garry <john.garry@huawei.com>
To:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <martin.petersen@oracle.com>, <jejb@linux.ibm.com>,
        <tglx@linutronix.de>
CC:     <linuxarm@huawei.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <maz@kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 2/3] Driver core: platform: Add platform_get_irqs_affinity()
Date:   Tue, 27 Oct 2020 20:10:23 +0800
Message-ID: <1603800624-180488-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1603800624-180488-1-git-send-email-john.garry@huawei.com>
References: <1603800624-180488-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Drivers for multi-queue platform devices may also want managed interrupts
for handling HW queue completion interrupts, so add support.

The function accepts an affinity descriptor pointer, which covers all IRQs
expected for the device.

The platform device driver is expected to hold all the IRQ numbers, as
there is no point in holding these in the common platform_device structure.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/base/platform.c         | 58 +++++++++++++++++++++++++++++++++
 include/linux/platform_device.h |  5 +++
 2 files changed, 63 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 88aef93eb4dd..c110b35469d6 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -269,6 +269,64 @@ int platform_get_irq(struct platform_device *dev, unsigned int num)
 }
 EXPORT_SYMBOL_GPL(platform_get_irq);
 
+/**
+ * platform_get_irqs_affinity - get all IRQs for a device using an affinity
+ *				descriptor
+ * @dev: platform device pointer
+ * @affd: affinity descriptor, must be set
+ * @count: pointer to count of IRQS
+ * @irqs: pointer holder for IRQ numbers
+ *
+ * Gets a full set of IRQs for a platform device, and updates IRQ afffinty
+ * according to the passed affinity descriptor
+ *
+ * Return: 0 on success, negative error number on failure.
+ */
+int platform_get_irqs_affinity(struct platform_device *dev,
+			       struct irq_affinity *affd,
+			       unsigned int *count,
+			       int **irqs)
+{
+	struct irq_affinity_desc *desc;
+	int i, *pirqs;
+
+	if (!affd)
+		return -EPERM;
+
+	*count = platform_irq_count(dev);
+
+	if (*count <= affd->pre_vectors + affd->post_vectors)
+		return -EIO;
+
+	pirqs = kcalloc(*count, sizeof(int), GFP_KERNEL);
+	if (!pirqs)
+		return -ENOMEM;
+
+	for (i = 0; i < *count; i++) {
+		int irq = platform_get_irq(dev, i);
+		if (irq < 0) {
+			kfree(pirqs);
+			return irq;
+		}
+		pirqs[i] = irq;
+	}
+
+	desc = irq_create_affinity_masks(*count, affd);
+	if (!desc) {
+		kfree(pirqs);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < *count; i++)
+		irq_update_affinity_desc(pirqs[i], &desc[i]);
+
+	kfree(desc);
+	*irqs = pirqs;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(platform_get_irqs_affinity);
+
 /**
  * platform_irq_count - Count the number of IRQs a platform device uses
  * @dev: platform device
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 77a2aada106d..c3f4fc5a76b9 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -11,6 +11,7 @@
 #define _PLATFORM_DEVICE_H_
 
 #include <linux/device.h>
+#include <linux/interrupt.h>
 
 #define PLATFORM_DEVID_NONE	(-1)
 #define PLATFORM_DEVID_AUTO	(-2)
@@ -70,6 +71,10 @@ devm_platform_ioremap_resource_byname(struct platform_device *pdev,
 extern int platform_get_irq(struct platform_device *, unsigned int);
 extern int platform_get_irq_optional(struct platform_device *, unsigned int);
 extern int platform_irq_count(struct platform_device *);
+extern int platform_get_irqs_affinity(struct platform_device *dev,
+				      struct irq_affinity *affd,
+				      unsigned int *count,
+				      int **irqs);
 extern struct resource *platform_get_resource_byname(struct platform_device *,
 						     unsigned int,
 						     const char *);
-- 
2.26.2

