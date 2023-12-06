Return-Path: <linux-scsi+bounces-654-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BB1807808
	for <lists+linux-scsi@lfdr.de>; Wed,  6 Dec 2023 19:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F401F21001
	for <lists+linux-scsi@lfdr.de>; Wed,  6 Dec 2023 18:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181926EB69
	for <lists+linux-scsi@lfdr.de>; Wed,  6 Dec 2023 18:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="k76YNNSv"
X-Original-To: linux-scsi@vger.kernel.org
Received: from rcdn-iport-9.cisco.com (rcdn-iport-9.cisco.com [173.37.86.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB97810C7;
	Wed,  6 Dec 2023 10:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=4170; q=dns/txt; s=iport;
  t=1701888403; x=1703098003;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OcJECNe81v7ZCEUoq8/ceKd1781hnWAO3rR3PDQ7g5E=;
  b=k76YNNSv31+PK1r4xa4RdsocrSvobr4TACa5RepqJ0io9TYBdhz6Wi+P
   4kKKMg0OfSdaNECYz8WsherZntZ3Z1yM8+iatC3+bZSXznd66byGOyOGI
   jb0bcmAZLzycyJJeKl2ZNp7YXjwVDISY8j9YSC7bqyv04lr8LI3wqRie/
   A=;
X-CSE-ConnectionGUID: 63OZT/WVSuSeF4g1WZ/R0g==
X-CSE-MsgGUID: NbfXQPDWRJ+o9rs8ABIgqA==
X-IronPort-AV: E=Sophos;i="6.04,256,1695686400"; 
   d="scan'208";a="154981894"
Received: from alln-core-4.cisco.com ([173.36.13.137])
  by rcdn-iport-9.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 18:46:42 +0000
Received: from localhost.cisco.com ([10.193.101.253])
	(authenticated bits=0)
	by alln-core-4.cisco.com (8.15.2/8.15.2) with ESMTPSA id 3B6IkHD1010013
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 6 Dec 2023 18:46:42 GMT
From: Karan Tilak Kumar <kartilak@cisco.com>
To: sebaddel@cisco.com
Cc: arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com, mkai2@cisco.com,
        satishkh@cisco.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Karan Tilak Kumar <kartilak@cisco.com>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH v5 05/13] scsi: fnic: Get copy workqueue count and interrupt mode from config
Date: Wed,  6 Dec 2023 10:46:07 -0800
Message-Id: <20231206184615.878755-6-kartilak@cisco.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231206184615.878755-1-kartilak@cisco.com>
References: <20231206184615.878755-1-kartilak@cisco.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kartilak@cisco.com
X-Outbound-SMTP-Client: 10.193.101.253, [10.193.101.253]
X-Outbound-Node: alln-core-4.cisco.com

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


