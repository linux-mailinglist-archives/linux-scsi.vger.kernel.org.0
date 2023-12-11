Return-Path: <linux-scsi+bounces-835-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4761580D41C
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Dec 2023 18:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD703B2153E
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Dec 2023 17:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111524E611;
	Mon, 11 Dec 2023 17:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="G7ndvmcz"
X-Original-To: linux-scsi@vger.kernel.org
Received: from alln-iport-8.cisco.com (alln-iport-8.cisco.com [173.37.142.95])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6D89B;
	Mon, 11 Dec 2023 09:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=4061; q=dns/txt; s=iport;
  t=1702316289; x=1703525889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VmKqnLuXvBVfcU7fBTIOzUtTXlToFMlHmA8d8+htoQo=;
  b=G7ndvmczXAjWLepK256xJTts8jL+0kYICbr813wvXDYG8q7K9bEpKiHQ
   CLl/buH79D89Dg6BnW/Vkbv8qMDq77NNUSMmqmiNPFmvZkaoUoJMTreaO
   FUUEYoihuBBrZIvXTYV7oT5yEr07qWjhxzai7xFtH30y1NT9fn+b/cILq
   8=;
X-CSE-ConnectionGUID: labXckUeTNuurrSbT/gY8w==
X-CSE-MsgGUID: /ksFOumlTHW/M6DEZmTOng==
X-IronPort-AV: E=Sophos;i="6.04,268,1695686400"; 
   d="scan'208";a="193670508"
Received: from rcdn-core-1.cisco.com ([173.37.93.152])
  by alln-iport-8.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 17:38:08 +0000
Received: from localhost.cisco.com ([10.193.101.253])
	(authenticated bits=0)
	by rcdn-core-1.cisco.com (8.15.2/8.15.2) with ESMTPSA id 3BBHaKqx009547
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 11 Dec 2023 17:38:08 GMT
From: Karan Tilak Kumar <kartilak@cisco.com>
To: sebaddel@cisco.com
Cc: arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com, mkai2@cisco.com,
        satishkh@cisco.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Karan Tilak Kumar <kartilak@cisco.com>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH v6 05/13] scsi: fnic: Get copy workqueue count and interrupt mode from config
Date: Mon, 11 Dec 2023 09:36:09 -0800
Message-Id: <20231211173617.932990-6-kartilak@cisco.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231211173617.932990-1-kartilak@cisco.com>
References: <20231211173617.932990-1-kartilak@cisco.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kartilak@cisco.com
X-Outbound-SMTP-Client: 10.193.101.253, [10.193.101.253]
X-Outbound-Node: rcdn-core-1.cisco.com

Get the copy workqueue count and interrupt mode from
the configuration. The config can be changed via UCSM.
Add logs to print the interrupt mode and copy workqueue count.
Add logs to print the vNIC resources.

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
---
 drivers/scsi/fnic/fnic_res.c | 42 ++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_res.c b/drivers/scsi/fnic/fnic_res.c
index 109316cc4ad9..33dd27f6f24e 100644
--- a/drivers/scsi/fnic/fnic_res.c
+++ b/drivers/scsi/fnic/fnic_res.c
@@ -57,6 +57,8 @@ int fnic_get_vnic_config(struct fnic *fnic)
 	GET_CONFIG(port_down_timeout);
 	GET_CONFIG(port_down_io_retries);
 	GET_CONFIG(luns_per_tgt);
+	GET_CONFIG(intr_mode);
+	GET_CONFIG(wq_copy_count);
 
 	c->wq_enet_desc_count =
 		min_t(u32, VNIC_FNIC_WQ_DESCS_MAX,
@@ -131,6 +133,12 @@ int fnic_get_vnic_config(struct fnic *fnic)
 	c->intr_timer = min_t(u16, VNIC_INTR_TIMER_MAX, c->intr_timer);
 	c->intr_timer_type = c->intr_timer_type;
 
+	/* for older firmware, GET_CONFIG will not return anything */
+	if (c->wq_copy_count == 0)
+		c->wq_copy_count = 1;
+
+	c->wq_copy_count = min_t(u16, FNIC_WQ_COPY_MAX, c->wq_copy_count);
+
 	shost_printk(KERN_INFO, fnic->lport->host,
 		     "vNIC MAC addr %pM "
 		     "wq/wq_copy/rq %d/%d/%d\n",
@@ -161,6 +169,10 @@ int fnic_get_vnic_config(struct fnic *fnic)
 	shost_printk(KERN_INFO, fnic->lport->host,
 		     "vNIC port dn io retries %d port dn timeout %d\n",
 		     c->port_down_io_retries, c->port_down_timeout);
+	shost_printk(KERN_INFO, fnic->lport->host,
+			"vNIC wq_copy_count: %d\n", c->wq_copy_count);
+	shost_printk(KERN_INFO, fnic->lport->host,
+			"vNIC intr mode: %d\n", c->intr_mode);
 
 	return 0;
 }
@@ -187,12 +199,25 @@ int fnic_set_nic_config(struct fnic *fnic, u8 rss_default_cpu,
 void fnic_get_res_counts(struct fnic *fnic)
 {
 	fnic->wq_count = vnic_dev_get_res_count(fnic->vdev, RES_TYPE_WQ);
-	fnic->raw_wq_count = fnic->wq_count - 1;
-	fnic->wq_copy_count = fnic->wq_count - fnic->raw_wq_count;
+	fnic->raw_wq_count = 1;
+	fnic->wq_copy_count = fnic->config.wq_copy_count;
 	fnic->rq_count = vnic_dev_get_res_count(fnic->vdev, RES_TYPE_RQ);
 	fnic->cq_count = vnic_dev_get_res_count(fnic->vdev, RES_TYPE_CQ);
 	fnic->intr_count = vnic_dev_get_res_count(fnic->vdev,
 		RES_TYPE_INTR_CTRL);
+
+	shost_printk(KERN_INFO, fnic->lport->host,
+		"vNIC fw resources wq_count: %d\n", fnic->wq_count);
+	shost_printk(KERN_INFO, fnic->lport->host,
+		"vNIC fw resources raw_wq_count: %d\n", fnic->raw_wq_count);
+	shost_printk(KERN_INFO, fnic->lport->host,
+		"vNIC fw resources wq_copy_count: %d\n", fnic->wq_copy_count);
+	shost_printk(KERN_INFO, fnic->lport->host,
+		"vNIC fw resources rq_count: %d\n", fnic->rq_count);
+	shost_printk(KERN_INFO, fnic->lport->host,
+		"vNIC fw resources cq_count: %d\n", fnic->cq_count);
+	shost_printk(KERN_INFO, fnic->lport->host,
+		"vNIC fw resources intr_count: %d\n", fnic->intr_count);
 }
 
 void fnic_free_vnic_resources(struct fnic *fnic)
@@ -234,10 +259,15 @@ int fnic_alloc_vnic_resources(struct fnic *fnic)
 		     intr_mode == VNIC_DEV_INTR_MODE_MSIX ?
 		     "MSI-X" : "unknown");
 
-	shost_printk(KERN_INFO, fnic->lport->host, "vNIC resources avail: "
-		     "wq %d cp_wq %d raw_wq %d rq %d cq %d intr %d\n",
-		     fnic->wq_count, fnic->wq_copy_count, fnic->raw_wq_count,
-		     fnic->rq_count, fnic->cq_count, fnic->intr_count);
+	shost_printk(KERN_INFO, fnic->lport->host,
+			"vNIC resources avail: wq %d cp_wq %d raw_wq %d rq %d",
+			fnic->wq_count, fnic->wq_copy_count,
+			fnic->raw_wq_count, fnic->rq_count);
+
+	shost_printk(KERN_INFO, fnic->lport->host,
+			"vNIC resources avail: cq %d intr %d cpy-wq desc count %d\n",
+			fnic->cq_count, fnic->intr_count,
+			fnic->config.wq_copy_desc_count);
 
 	/* Allocate Raw WQ used for FCS frames */
 	for (i = 0; i < fnic->raw_wq_count; i++) {
-- 
2.31.1


