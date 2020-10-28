Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E47529DFDB
	for <lists+linux-scsi@lfdr.de>; Thu, 29 Oct 2020 02:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730865AbgJ2BFM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 28 Oct 2020 21:05:12 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:6982 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730036AbgJ1WFo (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 28 Oct 2020 18:05:44 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CLp3x39q2zhbW6;
        Wed, 28 Oct 2020 20:37:01 +0800 (CST)
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
Subject: [PATCH v2 1/3] genirq/affinity: Add irq_update_affinity_desc()
Date:   Wed, 28 Oct 2020 20:33:05 +0800
Message-ID: <1603888387-52499-2-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1603888387-52499-1-git-send-email-john.garry@huawei.com>
References: <1603888387-52499-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add a function to allow the affinity of an interrupt be switched to
managed, such that interrupts allocated for platform devices may be
managed.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 include/linux/interrupt.h |  8 ++++++++
 kernel/irq/manage.c       | 19 +++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index ee8299eb1f52..870b3251e174 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -352,6 +352,8 @@ extern int irq_can_set_affinity(unsigned int irq);
 extern int irq_select_affinity(unsigned int irq);
 
 extern int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m);
+extern int irq_update_affinity_desc(unsigned int irq,
+				    struct irq_affinity_desc *affinity);
 
 extern int
 irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify);
@@ -387,6 +389,12 @@ static inline int irq_set_affinity_hint(unsigned int irq,
 	return -EINVAL;
 }
 
+static inline int irq_update_affinity_desc(unsigned int irq,
+					   struct irq_affinity_desc *affinity)
+{
+	return -EINVAL;
+}
+
 static inline int
 irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
 {
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c460e0496006..b96af4cde4bc 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -371,6 +371,25 @@ int irq_set_affinity_locked(struct irq_data *data, const struct cpumask *mask,
 	return ret;
 }
 
+int irq_update_affinity_desc(unsigned int irq,
+			     struct irq_affinity_desc *affinity)
+{
+	unsigned long flags;
+	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, 0);
+
+	if (!desc)
+		return -EINVAL;
+
+	if (affinity->is_managed) {
+		irqd_set(&desc->irq_data, IRQD_AFFINITY_MANAGED);
+		irqd_set(&desc->irq_data, IRQD_MANAGED_SHUTDOWN);
+	}
+
+	cpumask_copy(desc->irq_common_data.affinity, &affinity->mask);
+	irq_put_desc_unlock(desc, flags);
+	return 0;
+}
+
 int __irq_set_affinity(unsigned int irq, const struct cpumask *mask, bool force)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
-- 
2.26.2

