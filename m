Return-Path: <linux-scsi+bounces-5512-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B48B902B14
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Jun 2024 23:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E2E81C211D5
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Jun 2024 21:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55E9143886;
	Mon, 10 Jun 2024 21:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="ZWjw3X7T"
X-Original-To: linux-scsi@vger.kernel.org
Received: from alln-iport-8.cisco.com (alln-iport-8.cisco.com [173.37.142.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B18558A5;
	Mon, 10 Jun 2024 21:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718056728; cv=none; b=Xrg0Z61OZevEsgYWHd98S8xdJ7Wnq/5cxhB9mAF80S5C2pHOw9DQro7tjjGsnMDK3Ul2/RKXKUKBRVx6fFY12Ij+x1t6+sdVXSsIPsNjsxCW5JXq671Tqh6edxi8v6Bq21UIPFGeeHVc+58ijogY7W67FTtsvKpDOP21QgfDgBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718056728; c=relaxed/simple;
	bh=1VjAtns5rfusMDWeWRVKOfJ29BRNeGS7/lJ53b78jJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mnSYOoyMPfbvFk/GqpUVUkMdeLOuZKpF1zhfRFFfK0SZ7pp2RCeiAG63XXJ5Inrmub5SlVeZtcURiC51HtqeEfP++Zuq0iQ008e12+LR28hLE9FM9Z6SzvYp8Fxs9R1O6zC2eI7i7W4os6IECsrQCVDor8XQVeErkJ/bCeMuT6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=ZWjw3X7T; arc=none smtp.client-ip=173.37.142.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=10649; q=dns/txt;
  s=iport; t=1718056726; x=1719266326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D5oYcHeqoOdUGfvU1/U2aqRh9/MMe1HLCehaZD32Ec0=;
  b=ZWjw3X7TOmiAtrpq/jfQst1p4hnJWVjU8Er7RxeaKMU3I5oNLOV3UYcY
   KErOI/1rAAJVQTFFm0MpCuhHoLfieTYZCXn/avX9UftU1xjZfBQ+lYiQu
   C/xWbYm52npx+nhnT0inIdY0Or7alVhw/ElJAEs5IkC+AaUGqkBMYzLIs
   4=;
X-CSE-ConnectionGUID: XZABuaelRje5jTRd/4MK1w==
X-CSE-MsgGUID: 96rnMYLDQ7enclNn4Xix9w==
X-IronPort-AV: E=Sophos;i="6.08,227,1712620800"; 
   d="scan'208";a="294328733"
Received: from alln-core-4.cisco.com ([173.36.13.137])
  by alln-iport-8.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 21:58:45 +0000
Received: from localhost.cisco.com ([10.193.101.253])
	(authenticated bits=0)
	by alln-core-4.cisco.com (8.15.2/8.15.2) with ESMTPSA id 45ALpBCb012699
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 10 Jun 2024 21:58:45 GMT
From: Karan Tilak Kumar <kartilak@cisco.com>
To: sebaddel@cisco.com
Cc: arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com, mkai2@cisco.com,
        satishkh@cisco.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Karan Tilak Kumar <kartilak@cisco.com>
Subject: [PATCH 13/14] scsi: fnic: Add support to handle port channel RSCN
Date: Mon, 10 Jun 2024 14:50:59 -0700
Message-Id: <20240610215100.673158-14-kartilak@cisco.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240610215100.673158-1-kartilak@cisco.com>
References: <20240610215100.673158-1-kartilak@cisco.com>
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

Add support to handle port channel RSCN.

Port channel RSCN is a Cisco vendor specific RSCN
event. It is applicable only to Cisco UCS fabrics.
If there's a change in the port channel configuration,
an RCSN is sent to fnic. This is used to serially
reset the scsi initiator fnics so that there's no
all paths down scenario. The affected fnics are added
to a list that are reset with a small time gap
between them.

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Reviewed-by: Gian Carlo Boffa <gcboffa@cisco.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
---
 drivers/scsi/fnic/fdls_disc.c | 63 +++++++++++++++++++++++++++--------
 drivers/scsi/fnic/fnic.h      | 25 ++++++++++++++
 drivers/scsi/fnic/fnic_fcs.c  | 35 +++++++++++++++++++
 drivers/scsi/fnic/fnic_main.c | 30 +++++++++++++++++
 4 files changed, 140 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/fnic/fdls_disc.c b/drivers/scsi/fnic/fdls_disc.c
index 55c4e1c7c130..a823061d15fb 100644
--- a/drivers/scsi/fnic/fdls_disc.c
+++ b/drivers/scsi/fnic/fdls_disc.c
@@ -3358,6 +3358,9 @@ fdls_process_rscn(struct fnic_iport_s *iport, struct fc_hdr_s *fchdr)
 	int newports = 0;
 	struct fnic_fdls_fabric_s *fdls = &iport->fabric;
 	struct fnic *fnic = iport->fnic;
+	int rscn_type = NOT_PC_RSCN;
+	uint32_t sid = ntoh24(fchdr->sid);
+	unsigned long reset_fnic_list_lock_flags = 0;
 
 	atomic64_inc(&iport->iport_stats.num_rscns);
 
@@ -3376,16 +3379,23 @@ fdls_process_rscn(struct fnic_iport_s *iport, struct fc_hdr_s *fchdr)
 	if ((rscn->payload_len % 4 != 0) || (rscn->payload_len < 8)
 		|| (rscn->payload_len > 1024) || (rscn->page_len != 4)) {
 		num_ports = 0;
-		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
-					 "RSCN payload_len: 0x%x page_len: 0x%x",
-					 rscn->payload_len, rscn->page_len);
-		/* if this happens then we need to send ADISC to all the tports. */
-		list_for_each_entry_safe(tport, next, &iport->tport_list, links) {
-			if (tport->state == FDLS_TGT_STATE_READY)
-				tport->flags |= FNIC_FDLS_TPORT_SEND_ADISC;
+		if ((rscn->payload_len == 0xFFFF) && (sid == FC_FABRIC_CONTROLLER)) {
+			rscn_type = PC_RSCN;
 			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
-						 "RSCN for port id: 0x%x", tport->fcid);
-		}
+				 "pcrscn: PCRSCN received. sid: 0x%x payload len: 0x%x", sid,
+				 rscn->payload_len);
+		} else {
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
+						 "RSCN payload_len: 0x%x page_len: 0x%x",
+						 rscn->payload_len, rscn->page_len);
+			/* if this happens then we need to send ADISC to all the tports. */
+			list_for_each_entry_safe(tport, next, &iport->tport_list, links) {
+				if (tport->state == FDLS_TGT_STATE_READY)
+					tport->flags |= FNIC_FDLS_TPORT_SEND_ADISC;
+				FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
+							 "RSCN for port id: 0x%x", tport->fcid);
+			}
+		} /* end else */
 	} else {
 		num_ports = (rscn->payload_len - 4) / rscn->page_len;
 		rscn_port = (struct fc_rscn_port_s *) (rscn + 1);
@@ -3435,10 +3445,37 @@ fdls_process_rscn(struct fnic_iport_s *iport, struct fc_hdr_s *fchdr)
 			tport->flags |= FNIC_FDLS_TPORT_SEND_ADISC;
 	}
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
-				 "FDLS process RSCN sending GPN_FT %p", iport);
-	fdls_send_gpn_ft(iport, FDLS_STATE_RSCN_GPN_FT);
-	fdls_send_rscn_resp(iport, fchdr);
+	if (pc_rscn_handling_feature_flag == PC_RSCN_HANDLING_FEATURE_ON &&
+		rscn_type == PC_RSCN && fnic->role == FNIC_ROLE_FCP_INITIATOR) {
+
+		if (fnic->pc_rscn_handling_status == PC_RSCN_HANDLING_IN_PROGRESS) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
+				 "PCRSCN handling already in progress. Skip host reset: %d",
+				 iport->fnic->fnic_num);
+			return;
+		}
+
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
+			 "Processing PCRSCN. Queuing fnic for host reset: %d",
+			 iport->fnic->fnic_num);
+		fnic->pc_rscn_handling_status = PC_RSCN_HANDLING_IN_PROGRESS;
+
+		spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
+
+		spin_lock_irqsave(&reset_fnic_list_lock,
+						  reset_fnic_list_lock_flags);
+		list_add_tail(&fnic->links, &reset_fnic_list);
+		spin_unlock_irqrestore(&reset_fnic_list_lock,
+							   reset_fnic_list_lock_flags);
+
+		queue_work(reset_fnic_work_queue, &reset_fnic_work);
+		spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
+	} else {
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
+					 "FDLS process RSCN sending GPN_FT %p", iport);
+		fdls_send_gpn_ft(iport, FDLS_STATE_RSCN_GPN_FT);
+		fdls_send_rscn_resp(iport, fchdr);
+	}
 }
 
 void fnic_fdls_disc_start(struct fnic_iport_s *iport)
diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index 1c3d794ecd65..bcf2aaed0b1f 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -211,11 +211,33 @@ enum reset_states {
 	RESET_ERROR
 };
 
+enum rscn_type {
+	NOT_PC_RSCN = 0,
+	PC_RSCN
+};
+
+enum pc_rscn_handling_status {
+	PC_RSCN_HANDLING_NOT_IN_PROGRESS = 0,
+	PC_RSCN_HANDLING_IN_PROGRESS
+};
+
+enum pc_rscn_handling_feature {
+	PC_RSCN_HANDLING_FEATURE_OFF = 0,
+	PC_RSCN_HANDLING_FEATURE_ON
+};
+
 extern unsigned int fnic_fdmi_support;
 extern unsigned int fnic_log_level;
 extern unsigned int io_completions;
 extern struct workqueue_struct *fnic_event_queue;
 
+extern unsigned int pc_rscn_handling_feature_flag;
+extern spinlock_t reset_fnic_list_lock;
+extern struct list_head reset_fnic_list;
+extern struct workqueue_struct *reset_fnic_work_queue;
+extern struct work_struct reset_fnic_work;
+
+
 #define FNIC_MAIN_LOGGING 0x01
 #define FNIC_FCS_LOGGING 0x02
 #define FNIC_SCSI_LOGGING 0x04
@@ -396,6 +418,7 @@ struct fnic {
 	int link_status;
 
 	struct list_head list;
+	struct list_head links;
 	struct pci_dev *pdev;
 	struct vnic_fc_config config;
 	struct vnic_dev *vdev;
@@ -455,6 +478,7 @@ struct fnic {
 
 	char subsys_desc[14];
 	int subsys_desc_len;
+	int pc_rscn_handling_status;
 };
 
 extern struct workqueue_struct *fnic_event_queue;
@@ -503,6 +527,7 @@ void fnic_stats_debugfs_remove(struct fnic *fnic);
 int fnic_is_abts_pending(struct fnic *, struct scsi_cmnd *);
 
 void fnic_handle_fip_frame(struct work_struct *work);
+void fnic_reset_work_handler(struct work_struct *work);
 void fnic_handle_fip_event(struct fnic *fnic);
 void fnic_fcoe_reset_vlans(struct fnic *fnic);
 extern void fnic_handle_fip_timer(struct timer_list *t);
diff --git a/drivers/scsi/fnic/fnic_fcs.c b/drivers/scsi/fnic/fnic_fcs.c
index 2e4147b11d9f..c1a1b125ccb3 100644
--- a/drivers/scsi/fnic/fnic_fcs.c
+++ b/drivers/scsi/fnic/fnic_fcs.c
@@ -1121,4 +1121,39 @@ void fnic_flush_tport_event_list(struct fnic *fnic)
 	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 }
 
+void fnic_reset_work_handler(struct work_struct *work)
+{
+	struct fnic *cur_fnic, *next_fnic;
+	unsigned long reset_fnic_list_lock_flags;
+	int host_reset_ret_code;
+
+	/*
+	 * This is a single thread. It is per fnic module, not per fnic
+	 * All the fnics that need to be reset
+	 * have been serialized via the reset fnic list.
+	 */
+	spin_lock_irqsave(&reset_fnic_list_lock, reset_fnic_list_lock_flags);
+	list_for_each_entry_safe(cur_fnic, next_fnic, &reset_fnic_list, links) {
+		list_del(&cur_fnic->links);
+		spin_unlock_irqrestore(&reset_fnic_list_lock,
+							   reset_fnic_list_lock_flags);
+
+		pr_err("fnic: <%d>: pcrscn: issuing a host reset\n",
+			   cur_fnic->fnic_num);
+		host_reset_ret_code = fnic_host_reset(cur_fnic->host);
+		pr_err(
+		   "fnic: <%d>: pcrscn: returned from host reset with status: %d\n",
+		   cur_fnic->fnic_num, host_reset_ret_code);
+
+		spin_lock_irqsave(&cur_fnic->fnic_lock, cur_fnic->lock_flags);
+		cur_fnic->pc_rscn_handling_status =
+			PC_RSCN_HANDLING_NOT_IN_PROGRESS;
+		spin_unlock_irqrestore(&cur_fnic->fnic_lock, cur_fnic->lock_flags);
+
+		spin_lock_irqsave(&reset_fnic_list_lock,
+						  reset_fnic_list_lock_flags);
+	}
+	spin_unlock_irqrestore(&reset_fnic_list_lock,
+						   reset_fnic_list_lock_flags);
+}
 
diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
index 477b09b5dde2..ec8728cb12a6 100644
--- a/drivers/scsi/fnic/fnic_main.c
+++ b/drivers/scsi/fnic/fnic_main.c
@@ -44,6 +44,10 @@ static LIST_HEAD(fnic_list);
 static DEFINE_SPINLOCK(fnic_list_lock);
 static DEFINE_IDA(fnic_ida);
 
+struct work_struct reset_fnic_work;
+LIST_HEAD(reset_fnic_list);
+DEFINE_SPINLOCK(reset_fnic_list_lock);
+
 /* Supported devices by fnic module */
 static struct pci_device_id fnic_id_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_CISCO, PCI_DEVICE_ID_CISCO_FNIC) },
@@ -88,6 +92,12 @@ static unsigned int fnic_max_qdepth = FNIC_DFLT_QUEUE_DEPTH;
 module_param(fnic_max_qdepth, uint, S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(fnic_max_qdepth, "Queue depth to report for each LUN");
 
+unsigned int pc_rscn_handling_feature_flag = PC_RSCN_HANDLING_FEATURE_ON;
+module_param(pc_rscn_handling_feature_flag, uint, 0644);
+MODULE_PARM_DESC(pc_rscn_handling_feature_flag,
+		 "PCRSCN handling (0 for none. 1 to handle PCRSCN (default))");
+
+struct workqueue_struct *reset_fnic_work_queue;
 struct workqueue_struct *fnic_fip_queue;
 
 static int fnic_slave_alloc(struct scsi_device *sdev)
@@ -1216,6 +1226,19 @@ static int __init fnic_init_module(void)
 		goto err_create_fip_workq;
 	}
 
+	if (pc_rscn_handling_feature_flag == PC_RSCN_HANDLING_FEATURE_ON) {
+		reset_fnic_work_queue =
+			create_singlethread_workqueue("reset_fnic_work_queue");
+		if (!reset_fnic_work_queue) {
+			pr_err("reset fnic work queue create failed\n");
+			err = -ENOMEM;
+			goto err_create_reset_fnic_workq;
+		}
+		spin_lock_init(&reset_fnic_list_lock);
+		INIT_LIST_HEAD(&reset_fnic_list);
+		INIT_WORK(&reset_fnic_work, fnic_reset_work_handler);
+	}
+
 	fnic_fc_transport = fc_attach_transport(&fnic_fc_functions);
 	if (!fnic_fc_transport) {
 		printk(KERN_ERR PFX "fc_attach_transport error\n");
@@ -1236,6 +1259,9 @@ static int __init fnic_init_module(void)
 err_fc_transport:
 	destroy_workqueue(fnic_fip_queue);
 err_create_fip_workq:
+	if (pc_rscn_handling_feature_flag == PC_RSCN_HANDLING_FEATURE_ON)
+		destroy_workqueue(reset_fnic_work_queue);
+err_create_reset_fnic_workq:
 	destroy_workqueue(fnic_event_queue);
 err_create_fnic_workq:
 	kmem_cache_destroy(fnic_io_req_cache);
@@ -1254,6 +1280,10 @@ static void __exit fnic_cleanup_module(void)
 {
 	pci_unregister_driver(&fnic_driver);
 	destroy_workqueue(fnic_event_queue);
+
+	if (pc_rscn_handling_feature_flag == PC_RSCN_HANDLING_FEATURE_ON)
+		destroy_workqueue(reset_fnic_work_queue);
+
 	if (fnic_fip_queue) {
 		flush_workqueue(fnic_fip_queue);
 		destroy_workqueue(fnic_fip_queue);
-- 
2.31.1


