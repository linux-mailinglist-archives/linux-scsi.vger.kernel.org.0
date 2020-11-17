Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D8F2B70EB
	for <lists+linux-scsi@lfdr.de>; Tue, 17 Nov 2020 22:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgKQV2T (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 17 Nov 2020 16:28:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:50860 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgKQV2T (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 17 Nov 2020 16:28:19 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605648496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=qkpMN7o/19/TZxkV4lw2vAMrUA7+5hdnxe5TUzFyyb8=;
        b=qu51eMYPBefnGJbWsrcUcTwT5yTa1zD8V6qXEE/EeKTvCPOtPRzKAS4/uZRVwoxnr2vkcT
        EE3B1SfTfBLA0akZk7sLWoXOjZne4lQbiievwzVD2rJEvfEdBPiF77jzwvv9TSS8NvnzEV
        HLQ/AORbpYPWYTSz9bzMx2MoV0aJMXR8Q+9oEcRVD0c+fvlBgbhfPAjiQGHRuIAXFdPEKg
        /XsYs2ChWS/VhzGpyEpxeMF6lj4rDyvExkj0Ie5lMj1WqZiuJIom7vyM+5Ac+RowGJCmMx
        69hsJvIRp++CCs7x7A45UhaPmQETM0KeXX7cQiqls5Ds4l0E1hI/IBjvQzePHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605648496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=qkpMN7o/19/TZxkV4lw2vAMrUA7+5hdnxe5TUzFyyb8=;
        b=ErqIsePB4BVn7uut1ECV49PBgvo7Cm9LAgghMnPa3Keccx2xyNlj1xh80Lw/MwSroHAoV7
        h1PGHeWej5RxcjDA==
To:     John Garry <john.garry@huawei.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, martin.petersen@oracle.com, jejb@linux.ibm.com
Cc:     linuxarm@huawei.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
Subject: Re: [PATCH v2 1/3] genirq/affinity: Add irq_update_affinity_desc()
In-Reply-To: <87blgf8pkk.fsf@nanos.tec.linutronix.de>
Date:   Tue, 17 Nov 2020 22:28:16 +0100
Message-ID: <87ft57r7v3.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, Nov 02 2020 at 21:35, Thomas Gleixner wrote:
> On Mon, Nov 02 2020 at 17:32, John Garry wrote:
> Correct. I have a halfways working solution for that, but I need to fix
> some other thing first.

Sorry for the delay. Supporting this truly on x86 needs some more
thought and surgery, but for ARM it should not matter. I made a few
tweaks to your original code. See below.

Thanks,

        tglx
---
From: John Garry <john.garry@huawei.com>
Subject: genirq/affinity: Add irq_update_affinity_desc()
Date: Wed, 28 Oct 2020 20:33:05 +0800

From: John Garry <john.garry@huawei.com>

Add a function to allow the affinity of an interrupt be switched to
managed, such that interrupts allocated for platform devices may be
managed.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 include/linux/interrupt.h |    8 ++++++
 kernel/irq/manage.c       |   56 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -352,6 +352,8 @@ extern int irq_can_set_affinity(unsigned
 extern int irq_select_affinity(unsigned int irq);
 
 extern int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m);
+extern int irq_update_affinity_desc(unsigned int irq,
+				    struct irq_affinity_desc *affinity);
 
 extern int
 irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify);
@@ -386,6 +388,12 @@ static inline int irq_set_affinity_hint(
 {
 	return -EINVAL;
 }
+
+static inline int irq_update_affinity_desc(unsigned int irq,
+					   struct irq_affinity_desc *affinity)
+{
+	return -EINVAL;
+}
 
 static inline int
 irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -371,6 +371,62 @@ int irq_set_affinity_locked(struct irq_d
 	return ret;
 }
 
+/**
+ * irq_update_affinity_desc - Update affinity management for an interrupt
+ * @irq:	The interrupt number to update
+ * @affinity:	Pointer to the affinity descriptor
+ *
+ * This interface can be used to configure the affinity management of
+ * interrupts which have been allocated already.
+ */
+int irq_update_affinity_desc(unsigned int irq,
+			     struct irq_affinity_desc *affinity)
+{
+	struct irq_desc *desc;
+	unsigned long flags;
+	bool activated;
+
+	/*
+	 * Supporting this with the reservation scheme used by x86 needs
+	 * some more thought. Fail it for now.
+	 */
+	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
+		return -EOPNOTSUPP;
+
+	desc = irq_get_desc_buslock(irq, &flags, 0);
+	if (!desc)
+		return -EINVAL;
+
+	/* Requires the interrupt to be shut down */
+	if (irqd_is_started(&desc->irq_data))
+		return -EBUSY;
+
+	/* Interrupts which are already managed cannot be modified */
+	if (irqd_is_managed(&desc->irq_data))
+		return -EBUSY;
+
+	/*
+	 * Deactivate the interrupt. That's required to undo
+	 * anything an earlier activation has established.
+	 */
+	activated = irqd_is_activated(&desc->irq_data);
+	if (activated)
+		irq_domain_deactivate_irq(&desc->irq_data);
+
+	if (affinity->is_managed) {
+		irqd_set(&desc->irq_data, IRQD_AFFINITY_MANAGED);
+		irqd_set(&desc->irq_data, IRQD_MANAGED_SHUTDOWN);
+	}
+
+	cpumask_copy(desc->irq_common_data.affinity, &affinity->mask);
+
+	/* Restore the activation state */
+	if (activated)
+		irq_domain_deactivate_irq(&desc->irq_data);
+	irq_put_desc_busunlock(desc, flags);
+	return 0;
+}
+
 int __irq_set_affinity(unsigned int irq, const struct cpumask *mask, bool force)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
