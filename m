Return-Path: <linux-scsi+bounces-836-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BC280D420
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Dec 2023 18:39:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE68A1F219F4
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Dec 2023 17:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8BF4E615;
	Mon, 11 Dec 2023 17:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="b7rkc9iV"
X-Original-To: linux-scsi@vger.kernel.org
Received: from alln-iport-8.cisco.com (alln-iport-8.cisco.com [173.37.142.95])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401B29B;
	Mon, 11 Dec 2023 09:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3263; q=dns/txt; s=iport;
  t=1702316334; x=1703525934;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q0xWd2ThYF+V4l8oL+rdzstG0URCVrdCbQqXz/xjPCs=;
  b=b7rkc9iVzhnrYw0Zp3EHf79x8GjmI5cUKYSlviNTUXsLrtmNGhxua/5q
   fhVExWTzJDOePvOg7utIxxZzsWRl5m1A40VWBPxdrB8FIoPsjzdgwBGP3
   ZKV0wdIkJwiLEgC3vYtSoznE/BOWI+s4vt6Y2IzmQdo/MFiwbhm2HQI3b
   k=;
X-CSE-ConnectionGUID: meCwM58qSiuwxEoMoyUcOg==
X-CSE-MsgGUID: RDp+kURuSIOMJ2ZSI8CWFQ==
X-IronPort-AV: E=Sophos;i="6.04,268,1695686400"; 
   d="scan'208";a="193670948"
Received: from rcdn-core-1.cisco.com ([173.37.93.152])
  by alln-iport-8.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 17:38:53 +0000
Received: from localhost.cisco.com ([10.193.101.253])
	(authenticated bits=0)
	by rcdn-core-1.cisco.com (8.15.2/8.15.2) with ESMTPSA id 3BBHaKr0009547
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 11 Dec 2023 17:38:52 GMT
From: Karan Tilak Kumar <kartilak@cisco.com>
To: sebaddel@cisco.com
Cc: arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com, mkai2@cisco.com,
        satishkh@cisco.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Karan Tilak Kumar <kartilak@cisco.com>
Subject: [PATCH v6 06/13] scsi: fnic: Refactor and redefine fnic.h for multiqueue
Date: Mon, 11 Dec 2023 09:36:10 -0800
Message-Id: <20231211173617.932990-7-kartilak@cisco.com>
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

Refactor and re-define values in fnic.h to implement
multiqueue(MQ) functionality.

VIC firmware allows fnic to create up to 64 copy
workqueues. Update the copy workqueue max to 64.
Modify the interrupt index to be in sync with the firmware
to support MQ.
Add irq number to the MSIX entry.
Define a software workqueue table to track the status of
io_reqs. Define a base for the copy workqueue.

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
---
Changes between v4 and v5:
    Incorporate review comments from Martin:
	Modify patch commits to include a "---" separator.

Changes between v2 and v3:
    Replace cpy_wq_base with copy_wq_base.
---
 drivers/scsi/fnic/fnic.h | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index 2e68209181a8..47173f1eec1e 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -167,12 +167,21 @@ do {								\
 #define FNIC_MAIN_NOTE(kern_level, host, fmt, args...)          \
 	shost_printk(kern_level, host, fmt, ##args)
 
+#define FNIC_WQ_COPY_MAX 64
+#define FNIC_WQ_MAX 1
+#define FNIC_RQ_MAX 1
+#define FNIC_CQ_MAX (FNIC_WQ_COPY_MAX + FNIC_WQ_MAX + FNIC_RQ_MAX)
+#define FNIC_DFLT_IO_COMPLETIONS 256
+
+#define FNIC_MQ_CQ_INDEX        2
+
 extern const char *fnic_state_str[];
 
 enum fnic_intx_intr_index {
 	FNIC_INTX_WQ_RQ_COPYWQ,
-	FNIC_INTX_ERR,
+	FNIC_INTX_DUMMY,
 	FNIC_INTX_NOTIFY,
+	FNIC_INTX_ERR,
 	FNIC_INTX_INTR_MAX,
 };
 
@@ -180,7 +189,7 @@ enum fnic_msix_intr_index {
 	FNIC_MSIX_RQ,
 	FNIC_MSIX_WQ,
 	FNIC_MSIX_WQ_COPY,
-	FNIC_MSIX_ERR_NOTIFY,
+	FNIC_MSIX_ERR_NOTIFY = FNIC_MSIX_WQ_COPY + FNIC_WQ_COPY_MAX,
 	FNIC_MSIX_INTR_MAX,
 };
 
@@ -189,6 +198,7 @@ struct fnic_msix_entry {
 	char devname[IFNAMSIZ + 11];
 	irqreturn_t (*isr)(int, void *);
 	void *devid;
+	int irq_num;
 };
 
 enum fnic_state {
@@ -198,12 +208,6 @@ enum fnic_state {
 	FNIC_IN_ETH_TRANS_FC_MODE,
 };
 
-#define FNIC_WQ_COPY_MAX 1
-#define FNIC_WQ_MAX 1
-#define FNIC_RQ_MAX 1
-#define FNIC_CQ_MAX (FNIC_WQ_COPY_MAX + FNIC_WQ_MAX + FNIC_RQ_MAX)
-#define FNIC_DFLT_IO_COMPLETIONS 256
-
 struct mempool;
 
 enum fnic_evt {
@@ -218,6 +222,13 @@ struct fnic_event {
 	enum fnic_evt event;
 };
 
+struct fnic_cpy_wq {
+	unsigned long hw_lock_flags;
+	u16 active_ioreq_count;
+	u16 ioreq_table_size;
+	____cacheline_aligned struct fnic_io_req **io_req_table;
+};
+
 /* Per-instance private data structure */
 struct fnic {
 	int fnic_num;
@@ -289,6 +300,7 @@ struct fnic {
 	mempool_t *io_sgl_pool[FNIC_SGL_NUM_CACHES];
 	spinlock_t io_req_lock[FNIC_IO_LOCKS];	/* locks for scsi cmnds */
 
+	unsigned int copy_wq_base;
 	struct work_struct link_work;
 	struct work_struct frame_work;
 	struct sk_buff_head frame_queue;
@@ -308,6 +320,8 @@ struct fnic {
 
 	/* copy work queue cache line section */
 	____cacheline_aligned struct vnic_wq_copy hw_copy_wq[FNIC_WQ_COPY_MAX];
+	____cacheline_aligned struct fnic_cpy_wq sw_copy_wq[FNIC_WQ_COPY_MAX];
+
 	/* completion queue cache line section */
 	____cacheline_aligned struct vnic_cq cq[FNIC_CQ_MAX];
 
-- 
2.31.1


