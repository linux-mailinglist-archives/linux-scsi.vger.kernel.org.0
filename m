Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453FB453EA2
	for <lists+linux-scsi@lfdr.de>; Wed, 17 Nov 2021 03:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbhKQCxT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 16 Nov 2021 21:53:19 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:14946 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbhKQCxK (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 16 Nov 2021 21:53:10 -0500
Received: from dggeme756-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Hv6mN5GMZzZd0q;
        Wed, 17 Nov 2021 10:47:48 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 dggeme756-chm.china.huawei.com (10.3.19.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Wed, 17 Nov 2021 10:50:11 +0800
From:   chenxiang <chenxiang66@hisilicon.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
        <john.garry@huawei.com>, Xiang Chen <chenxiang66@hisilicon.com>
Subject: [PATCH 12/15] scsi: libsas: Defer works of new phys during suspend
Date:   Wed, 17 Nov 2021 10:45:05 +0800
Message-ID: <1637117108-230103-13-git-send-email-chenxiang66@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1637117108-230103-1-git-send-email-chenxiang66@hisilicon.com>
References: <1637117108-230103-1-git-send-email-chenxiang66@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme756-chm.china.huawei.com (10.3.19.102)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

During the process of event PORT_BYTES_DMAED, it queues work
DISCE_DISCOVER_DOMAIN and then flush workqueue ha->disco_q.
If new phyup occurs during resming SAS controller, the work
PORTE_BYTES_DMAED of new phys occurs before suspended phys', then work
DISCE_DISCOVER_DOMAIN of new phy requires the active of SAS controller
(It requires to resume SAS controller by function scsi_sysfs_add_sdev()
and some other functions such as fucntion add_device_link()).
But the active of SAS controller requires the complete of work
PORTE_BYTES_DMAED of suspended phys while it is blocked by new phy's work
on ha->event_q. So there is a deadlock and it is released only after
resume timeout.

To solve the issue, defer works of new phys during suspend and queue those
defer works after SAS controller becomes active.

Signed-off-by: Xiang Chen <chenxiang66@hisilicon.com>
Reviewed-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/libsas/sas_event.c | 24 ++++++++++++++++++++++++
 drivers/scsi/libsas/sas_init.c  |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/scsi/libsas/sas_event.c b/drivers/scsi/libsas/sas_event.c
index 01e544ca518a..626ef96b9348 100644
--- a/drivers/scsi/libsas/sas_event.c
+++ b/drivers/scsi/libsas/sas_event.c
@@ -139,6 +139,24 @@ static void sas_phy_event_worker(struct work_struct *work)
 	sas_free_event(ev);
 }
 
+/* defer works of new phys during suspend */
+static bool sas_defer_event(struct asd_sas_phy *phy, struct asd_sas_event *ev)
+{
+	struct sas_ha_struct *ha = phy->ha;
+	unsigned long flags;
+	bool deferred = false;
+
+	spin_lock_irqsave(&ha->lock, flags);
+	if (test_bit(SAS_HA_RESUMING, &ha->state) && !phy->suspended) {
+		struct sas_work *sw = &ev->work;
+
+		list_add_tail(&sw->drain_node, &ha->defer_q);
+		deferred = true;
+	}
+	spin_unlock_irqrestore(&ha->lock, flags);
+	return deferred;
+}
+
 int sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
 			  gfp_t gfp_flags)
 {
@@ -154,6 +172,9 @@ int sas_notify_port_event(struct asd_sas_phy *phy, enum port_event event,
 
 	INIT_SAS_EVENT(ev, sas_port_event_worker, phy, event);
 
+	if (sas_defer_event(phy, ev))
+		return 0;
+
 	ret = sas_queue_event(event, &ev->work, ha);
 	if (ret != 1)
 		sas_free_event(ev);
@@ -177,6 +198,9 @@ int sas_notify_phy_event(struct asd_sas_phy *phy, enum phy_event event,
 
 	INIT_SAS_EVENT(ev, sas_phy_event_worker, phy, event);
 
+	if (sas_defer_event(phy, ev))
+		return 0;
+
 	ret = sas_queue_event(event, &ev->work, ha);
 	if (ret != 1)
 		sas_free_event(ev);
diff --git a/drivers/scsi/libsas/sas_init.c b/drivers/scsi/libsas/sas_init.c
index 069e40fc8411..dc35f0f8eae3 100644
--- a/drivers/scsi/libsas/sas_init.c
+++ b/drivers/scsi/libsas/sas_init.c
@@ -446,6 +446,7 @@ static void _sas_resume_ha(struct sas_ha_struct *ha, bool drain)
 		sas_drain_work(ha);
 	clear_bit(SAS_HA_RESUMING, &ha->state);
 
+	sas_queue_deferred_work(ha);
 	/* send event PORTE_BROADCAST_RCVD to identify some new inserted
 	 * disks for expander
 	 */
-- 
2.33.0

