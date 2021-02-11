Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC99731880A
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Feb 2021 11:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbhBKKW4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 11 Feb 2021 05:22:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:42184 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230094AbhBKKUg (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 11 Feb 2021 05:20:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613038661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GuZoq58aOVo3oObGxElFNA6Kt6uHHJGIx8cU5W0ZP10=;
        b=pkhP3Lm6mYei0SahyUSTm/T2kQz6sZJb4OOfYj17bDA4br/IXuvFtdkIqsVKGzyShv5OAu
        d2jT8J1SIJXORUUW+PIgw04KHUOaCD+hJsA+vIGj4gqWcvMkTnOKQA1VjrHXTh++V8bUVG
        uSR2A9MHYHVSyHQrz3LZL1TxHbdjHfI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 15E18AF10;
        Thu, 11 Feb 2021 10:17:41 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-scsi@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>, Wei Liu <wei.liu@kernel.org>,
        Paul Durrant <paul@xen.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: [PATCH v2 5/8] xen/events: link interdomain events to associated xenbus device
Date:   Thu, 11 Feb 2021 11:16:13 +0100
Message-Id: <20210211101616.13788-6-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210211101616.13788-1-jgross@suse.com>
References: <20210211101616.13788-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

In order to support the possibility of per-device event channel
settings (e.g. lateeoi spurious event thresholds) add a xenbus device
pointer to struct irq_info() and modify the related event channel
binding interfaces to take the pointer to the xenbus device as a
parameter instead of the domain id of the other side.

While at it remove the stale prototype of bind_evtchn_to_irq_lateeoi().

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Reviewed-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/block/xen-blkback/xenbus.c  |  2 +-
 drivers/net/xen-netback/interface.c | 16 +++++------
 drivers/xen/events/events_base.c    | 41 +++++++++++++++++------------
 drivers/xen/pvcalls-back.c          |  4 +--
 drivers/xen/xen-pciback/xenbus.c    |  2 +-
 drivers/xen/xen-scsiback.c          |  2 +-
 include/xen/events.h                |  7 ++---
 7 files changed, 41 insertions(+), 33 deletions(-)

diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index 9860d4842f36..c2aaf690352c 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -245,7 +245,7 @@ static int xen_blkif_map(struct xen_blkif_ring *ring, grant_ref_t *gref,
 	if (req_prod - rsp_prod > size)
 		goto fail;
 
-	err = bind_interdomain_evtchn_to_irqhandler_lateeoi(blkif->domid,
+	err = bind_interdomain_evtchn_to_irqhandler_lateeoi(blkif->be->dev,
 			evtchn, xen_blkif_be_int, 0, "blkif-backend", ring);
 	if (err < 0)
 		goto fail;
diff --git a/drivers/net/xen-netback/interface.c b/drivers/net/xen-netback/interface.c
index e02a4fbb74de..50a94e58c150 100644
--- a/drivers/net/xen-netback/interface.c
+++ b/drivers/net/xen-netback/interface.c
@@ -630,13 +630,13 @@ int xenvif_connect_ctrl(struct xenvif *vif, grant_ref_t ring_ref,
 			unsigned int evtchn)
 {
 	struct net_device *dev = vif->dev;
+	struct xenbus_device *xendev = xenvif_to_xenbus_device(vif);
 	void *addr;
 	struct xen_netif_ctrl_sring *shared;
 	RING_IDX rsp_prod, req_prod;
 	int err;
 
-	err = xenbus_map_ring_valloc(xenvif_to_xenbus_device(vif),
-				     &ring_ref, 1, &addr);
+	err = xenbus_map_ring_valloc(xendev, &ring_ref, 1, &addr);
 	if (err)
 		goto err;
 
@@ -650,7 +650,7 @@ int xenvif_connect_ctrl(struct xenvif *vif, grant_ref_t ring_ref,
 	if (req_prod - rsp_prod > RING_SIZE(&vif->ctrl))
 		goto err_unmap;
 
-	err = bind_interdomain_evtchn_to_irq_lateeoi(vif->domid, evtchn);
+	err = bind_interdomain_evtchn_to_irq_lateeoi(xendev, evtchn);
 	if (err < 0)
 		goto err_unmap;
 
@@ -673,8 +673,7 @@ int xenvif_connect_ctrl(struct xenvif *vif, grant_ref_t ring_ref,
 	vif->ctrl_irq = 0;
 
 err_unmap:
-	xenbus_unmap_ring_vfree(xenvif_to_xenbus_device(vif),
-				vif->ctrl.sring);
+	xenbus_unmap_ring_vfree(xendev, vif->ctrl.sring);
 	vif->ctrl.sring = NULL;
 
 err:
@@ -719,6 +718,7 @@ int xenvif_connect_data(struct xenvif_queue *queue,
 			unsigned int tx_evtchn,
 			unsigned int rx_evtchn)
 {
+	struct xenbus_device *dev = xenvif_to_xenbus_device(queue->vif);
 	struct task_struct *task;
 	int err;
 
@@ -755,7 +755,7 @@ int xenvif_connect_data(struct xenvif_queue *queue,
 	if (tx_evtchn == rx_evtchn) {
 		/* feature-split-event-channels == 0 */
 		err = bind_interdomain_evtchn_to_irqhandler_lateeoi(
-			queue->vif->domid, tx_evtchn, xenvif_interrupt, 0,
+			dev, tx_evtchn, xenvif_interrupt, 0,
 			queue->name, queue);
 		if (err < 0)
 			goto err;
@@ -766,7 +766,7 @@ int xenvif_connect_data(struct xenvif_queue *queue,
 		snprintf(queue->tx_irq_name, sizeof(queue->tx_irq_name),
 			 "%s-tx", queue->name);
 		err = bind_interdomain_evtchn_to_irqhandler_lateeoi(
-			queue->vif->domid, tx_evtchn, xenvif_tx_interrupt, 0,
+			dev, tx_evtchn, xenvif_tx_interrupt, 0,
 			queue->tx_irq_name, queue);
 		if (err < 0)
 			goto err;
@@ -776,7 +776,7 @@ int xenvif_connect_data(struct xenvif_queue *queue,
 		snprintf(queue->rx_irq_name, sizeof(queue->rx_irq_name),
 			 "%s-rx", queue->name);
 		err = bind_interdomain_evtchn_to_irqhandler_lateeoi(
-			queue->vif->domid, rx_evtchn, xenvif_rx_interrupt, 0,
+			dev, rx_evtchn, xenvif_rx_interrupt, 0,
 			queue->rx_irq_name, queue);
 		if (err < 0)
 			goto err;
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index f7e22330dcef..a5cce4c626c2 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -63,6 +63,7 @@
 #include <xen/interface/physdev.h>
 #include <xen/interface/sched.h>
 #include <xen/interface/vcpu.h>
+#include <xen/xenbus.h>
 #include <asm/hw_irq.h>
 
 #include "events_internal.h"
@@ -121,6 +122,7 @@ struct irq_info {
 			unsigned char flags;
 			uint16_t domid;
 		} pirq;
+		struct xenbus_device *interdomain;
 	} u;
 };
 
@@ -322,11 +324,16 @@ static int xen_irq_info_common_setup(struct irq_info *info,
 }
 
 static int xen_irq_info_evtchn_setup(unsigned irq,
-				     evtchn_port_t evtchn)
+				     evtchn_port_t evtchn,
+				     struct xenbus_device *dev)
 {
 	struct irq_info *info = info_for_irq(irq);
+	int ret;
 
-	return xen_irq_info_common_setup(info, irq, IRQT_EVTCHN, evtchn, 0);
+	ret = xen_irq_info_common_setup(info, irq, IRQT_EVTCHN, evtchn, 0);
+	info->u.interdomain = dev;
+
+	return ret;
 }
 
 static int xen_irq_info_ipi_setup(unsigned cpu,
@@ -1158,7 +1165,8 @@ int xen_pirq_from_irq(unsigned irq)
 }
 EXPORT_SYMBOL_GPL(xen_pirq_from_irq);
 
-static int bind_evtchn_to_irq_chip(evtchn_port_t evtchn, struct irq_chip *chip)
+static int bind_evtchn_to_irq_chip(evtchn_port_t evtchn, struct irq_chip *chip,
+				   struct xenbus_device *dev)
 {
 	int irq;
 	int ret;
@@ -1178,7 +1186,7 @@ static int bind_evtchn_to_irq_chip(evtchn_port_t evtchn, struct irq_chip *chip)
 		irq_set_chip_and_handler_name(irq, chip,
 					      handle_edge_irq, "event");
 
-		ret = xen_irq_info_evtchn_setup(irq, evtchn);
+		ret = xen_irq_info_evtchn_setup(irq, evtchn, dev);
 		if (ret < 0) {
 			__unbind_from_irq(irq);
 			irq = ret;
@@ -1205,7 +1213,7 @@ static int bind_evtchn_to_irq_chip(evtchn_port_t evtchn, struct irq_chip *chip)
 
 int bind_evtchn_to_irq(evtchn_port_t evtchn)
 {
-	return bind_evtchn_to_irq_chip(evtchn, &xen_dynamic_chip);
+	return bind_evtchn_to_irq_chip(evtchn, &xen_dynamic_chip, NULL);
 }
 EXPORT_SYMBOL_GPL(bind_evtchn_to_irq);
 
@@ -1254,27 +1262,27 @@ static int bind_ipi_to_irq(unsigned int ipi, unsigned int cpu)
 	return irq;
 }
 
-static int bind_interdomain_evtchn_to_irq_chip(unsigned int remote_domain,
+static int bind_interdomain_evtchn_to_irq_chip(struct xenbus_device *dev,
 					       evtchn_port_t remote_port,
 					       struct irq_chip *chip)
 {
 	struct evtchn_bind_interdomain bind_interdomain;
 	int err;
 
-	bind_interdomain.remote_dom  = remote_domain;
+	bind_interdomain.remote_dom  = dev->otherend_id;
 	bind_interdomain.remote_port = remote_port;
 
 	err = HYPERVISOR_event_channel_op(EVTCHNOP_bind_interdomain,
 					  &bind_interdomain);
 
 	return err ? : bind_evtchn_to_irq_chip(bind_interdomain.local_port,
-					       chip);
+					       chip, dev);
 }
 
-int bind_interdomain_evtchn_to_irq_lateeoi(unsigned int remote_domain,
+int bind_interdomain_evtchn_to_irq_lateeoi(struct xenbus_device *dev,
 					   evtchn_port_t remote_port)
 {
-	return bind_interdomain_evtchn_to_irq_chip(remote_domain, remote_port,
+	return bind_interdomain_evtchn_to_irq_chip(dev, remote_port,
 						   &xen_lateeoi_chip);
 }
 EXPORT_SYMBOL_GPL(bind_interdomain_evtchn_to_irq_lateeoi);
@@ -1387,7 +1395,7 @@ static int bind_evtchn_to_irqhandler_chip(evtchn_port_t evtchn,
 {
 	int irq, retval;
 
-	irq = bind_evtchn_to_irq_chip(evtchn, chip);
+	irq = bind_evtchn_to_irq_chip(evtchn, chip, NULL);
 	if (irq < 0)
 		return irq;
 	retval = request_irq(irq, handler, irqflags, devname, dev_id);
@@ -1422,14 +1430,13 @@ int bind_evtchn_to_irqhandler_lateeoi(evtchn_port_t evtchn,
 EXPORT_SYMBOL_GPL(bind_evtchn_to_irqhandler_lateeoi);
 
 static int bind_interdomain_evtchn_to_irqhandler_chip(
-		unsigned int remote_domain, evtchn_port_t remote_port,
+		struct xenbus_device *dev, evtchn_port_t remote_port,
 		irq_handler_t handler, unsigned long irqflags,
 		const char *devname, void *dev_id, struct irq_chip *chip)
 {
 	int irq, retval;
 
-	irq = bind_interdomain_evtchn_to_irq_chip(remote_domain, remote_port,
-						  chip);
+	irq = bind_interdomain_evtchn_to_irq_chip(dev, remote_port, chip);
 	if (irq < 0)
 		return irq;
 
@@ -1442,14 +1449,14 @@ static int bind_interdomain_evtchn_to_irqhandler_chip(
 	return irq;
 }
 
-int bind_interdomain_evtchn_to_irqhandler_lateeoi(unsigned int remote_domain,
+int bind_interdomain_evtchn_to_irqhandler_lateeoi(struct xenbus_device *dev,
 						  evtchn_port_t remote_port,
 						  irq_handler_t handler,
 						  unsigned long irqflags,
 						  const char *devname,
 						  void *dev_id)
 {
-	return bind_interdomain_evtchn_to_irqhandler_chip(remote_domain,
+	return bind_interdomain_evtchn_to_irqhandler_chip(dev,
 				remote_port, handler, irqflags, devname,
 				dev_id, &xen_lateeoi_chip);
 }
@@ -1723,7 +1730,7 @@ void rebind_evtchn_irq(evtchn_port_t evtchn, int irq)
 	   so there should be a proper type */
 	BUG_ON(info->type == IRQT_UNBOUND);
 
-	(void)xen_irq_info_evtchn_setup(irq, evtchn);
+	(void)xen_irq_info_evtchn_setup(irq, evtchn, NULL);
 
 	mutex_unlock(&irq_mapping_update_lock);
 
diff --git a/drivers/xen/pvcalls-back.c b/drivers/xen/pvcalls-back.c
index a7d293fa8d14..b47fd8435061 100644
--- a/drivers/xen/pvcalls-back.c
+++ b/drivers/xen/pvcalls-back.c
@@ -348,7 +348,7 @@ static struct sock_mapping *pvcalls_new_active_socket(
 	map->bytes = page;
 
 	ret = bind_interdomain_evtchn_to_irqhandler_lateeoi(
-			fedata->dev->otherend_id, evtchn,
+			fedata->dev, evtchn,
 			pvcalls_back_conn_event, 0, "pvcalls-backend", map);
 	if (ret < 0)
 		goto out;
@@ -948,7 +948,7 @@ static int backend_connect(struct xenbus_device *dev)
 		goto error;
 	}
 
-	err = bind_interdomain_evtchn_to_irq_lateeoi(dev->otherend_id, evtchn);
+	err = bind_interdomain_evtchn_to_irq_lateeoi(dev, evtchn);
 	if (err < 0)
 		goto error;
 	fedata->irq = err;
diff --git a/drivers/xen/xen-pciback/xenbus.c b/drivers/xen/xen-pciback/xenbus.c
index e7c692cfb2cf..5188f02e75fb 100644
--- a/drivers/xen/xen-pciback/xenbus.c
+++ b/drivers/xen/xen-pciback/xenbus.c
@@ -124,7 +124,7 @@ static int xen_pcibk_do_attach(struct xen_pcibk_device *pdev, int gnt_ref,
 	pdev->sh_info = vaddr;
 
 	err = bind_interdomain_evtchn_to_irqhandler_lateeoi(
-		pdev->xdev->otherend_id, remote_evtchn, xen_pcibk_handle_event,
+		pdev->xdev, remote_evtchn, xen_pcibk_handle_event,
 		0, DRV_NAME, pdev);
 	if (err < 0) {
 		xenbus_dev_fatal(pdev->xdev, err,
diff --git a/drivers/xen/xen-scsiback.c b/drivers/xen/xen-scsiback.c
index 862162dca33c..8b59897b2df9 100644
--- a/drivers/xen/xen-scsiback.c
+++ b/drivers/xen/xen-scsiback.c
@@ -799,7 +799,7 @@ static int scsiback_init_sring(struct vscsibk_info *info, grant_ref_t ring_ref,
 	sring = (struct vscsiif_sring *)area;
 	BACK_RING_INIT(&info->ring, sring, PAGE_SIZE);
 
-	err = bind_interdomain_evtchn_to_irq_lateeoi(info->domid, evtchn);
+	err = bind_interdomain_evtchn_to_irq_lateeoi(info->dev, evtchn);
 	if (err < 0)
 		goto unmap_page;
 
diff --git a/include/xen/events.h b/include/xen/events.h
index 8ec418e30c7f..c204262d9fc2 100644
--- a/include/xen/events.h
+++ b/include/xen/events.h
@@ -12,10 +12,11 @@
 #include <asm/xen/hypercall.h>
 #include <asm/xen/events.h>
 
+struct xenbus_device;
+
 unsigned xen_evtchn_nr_channels(void);
 
 int bind_evtchn_to_irq(evtchn_port_t evtchn);
-int bind_evtchn_to_irq_lateeoi(evtchn_port_t evtchn);
 int bind_evtchn_to_irqhandler(evtchn_port_t evtchn,
 			      irq_handler_t handler,
 			      unsigned long irqflags, const char *devname,
@@ -35,9 +36,9 @@ int bind_ipi_to_irqhandler(enum ipi_vector ipi,
 			   unsigned long irqflags,
 			   const char *devname,
 			   void *dev_id);
-int bind_interdomain_evtchn_to_irq_lateeoi(unsigned int remote_domain,
+int bind_interdomain_evtchn_to_irq_lateeoi(struct xenbus_device *dev,
 					   evtchn_port_t remote_port);
-int bind_interdomain_evtchn_to_irqhandler_lateeoi(unsigned int remote_domain,
+int bind_interdomain_evtchn_to_irqhandler_lateeoi(struct xenbus_device *dev,
 						  evtchn_port_t remote_port,
 						  irq_handler_t handler,
 						  unsigned long irqflags,
-- 
2.26.2

