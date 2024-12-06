Return-Path: <linux-scsi+bounces-10600-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FB79E7A60
	for <lists+linux-scsi@lfdr.de>; Fri,  6 Dec 2024 22:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2155F1887893
	for <lists+linux-scsi@lfdr.de>; Fri,  6 Dec 2024 21:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1398212F83;
	Fri,  6 Dec 2024 21:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="PS98yWOq"
X-Original-To: linux-scsi@vger.kernel.org
Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0224D212F87;
	Fri,  6 Dec 2024 21:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733519462; cv=none; b=gNjMiVbJ21JgKYfpGkBlOjZzEzu4nIN2vgOq7DZYWkU2bUbUadyHLUut/jS0E9ETxSb1RoCcaoHLk4LLDkDQ0PQjx5p6vAl/ni79cXpWAS++oU94TKhChwLijtdUPENBzj9mHDscQIZT0QQXB6g34DsCHnu212WG2CE35qRhVr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733519462; c=relaxed/simple;
	bh=NNg/QCcD3UNjKOTpZq54fPgMQ6ZEs+qMxcds8xBKYzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFop/arWTEuhEUlmmjuA1Z8df0kT5FfM32MRHfNGoViDs1yIzxGcFdBRK3OzxOD7wfr51hwQ2zxJc10AUW9NcwSr+gbLMNf/v5mGBHD2IG2dBWzXkslW/w+0jWk9btPVc/exoDbCUcz2CjUj1xdbBjpZd81ac39y51Nf/svvhNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=PS98yWOq; arc=none smtp.client-ip=173.37.86.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=105614; q=dns/txt;
  s=iport; t=1733519457; x=1734729057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r3YKhWzLnuiLs0aUSNCJeYj/h6XxrkupT/B+O/AteEI=;
  b=PS98yWOqkkZfB7FzdVyrUXk/+bPESRBxAaVjvGcDZ9P7TdfVnIeYtV/2
   iAB9bnASfTuHyhMeM6OxkAgzishsSJknUsEHvjrBDXafA17yCeeziRaQj
   wFULdeTAVzKXTtBGcrVNPlnENnyTmJYQRihcs3JGF46+5p3x2Z/SPmmxv
   I=;
X-CSE-ConnectionGUID: 0LYJWQgxRAmpV8p9+7czlA==
X-CSE-MsgGUID: 6Zox+JUwQauuySqAUXNGHA==
X-IPAS-Result: =?us-ascii?q?A0AEAABwZ1Nn/4//Ja1SCBoBAQEBAQEBAQEBAwEBAQESA?=
 =?us-ascii?q?QEBAQICAQEBAYF/BQEBAQELAYIbL3ZZQxkvjHKJUYEWkDeMThSBEQNWDwEBA?=
 =?us-ascii?q?Q85CwQBAYUHAopoAiY0CQ4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEFAQEBA?=
 =?us-ascii?q?gEHBYEOE4V7DYZbAgEDGgEMCwFGEDkBF0URGYMBAYJkAxGxbIF5M4EBg2gBR?=
 =?us-ascii?q?NoGgWcGgUgBjUlwhHcnFQaBSUSBFYE7gTcHb4EFAUyCNAoLAQ9gAoV6BII8h?=
 =?us-ascii?q?BxYHiWBE4IUgV8ug0yBb4t8HTALgUpZjDdIgSEDWSERAVUTDQoLBwWBdgOCT?=
 =?us-ascii?q?XorgQuBFzqBfoETSoNKgUJGPYJKaUs3Ag0CNoIkfXiBVYUZhGljLwMDAwODH?=
 =?us-ascii?q?CCGJUSBODhAAwsYDUgRLBQjFBsGPm4HoUUBRoJnYAMIBgEBLB0xBg0BExgXC?=
 =?us-ascii?q?TAEeQgUFBYBHQELEyeSQBsCBwMRJ49KgiCBNIl1lViEJIwXjgeHJhozm1uOd?=
 =?us-ascii?q?ph7jgKVVAUBGFCEZoFnPIFZMxoIGxU7gmcTPxkPhFCJXQsLFnYBAgUHh1G5N?=
 =?us-ascii?q?yUyAjoCBwsBAQMJkzwBAQIkB25gAQE?=
IronPort-Data: A9a23:10CD+ar3XeH2WMofVLx9NQCNZoZeBmI+ZBIvgKrLsJaIsI4StFCzt
 garIBmHOPyCYWD1Ld4gadzlp00GuJLVztBrSFRq/CpkEngU9OPIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7zdOCn9T8kiPngqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYQXNNwJcaDpOt/vZ8E0355wehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQRs/ZwGyojxE4
 I4lWapc5useFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpfh660GMa04AWEX0r5TMENxz
 PMIEhkIdi7Tn7P1n7mpTsA506zPLOGzVG8ekmtrwTecCbMtRorOBv2Uo9RZxzw3wMtJGJ4yZ
 eJANmEpN0uGOUASfA5LU/rSn8/w7pX7Wz5Rsk6UoaM0y2PS1wd2lrPqNbI5f/TQFJ8EwxnA9
 zmuE2LRXCMdJJ+99CW8+2+xl9TWtB7Lfq0yPejtnhJtqBjJroAJMzUSVkOToP+lh0r4UNVaQ
 2QW9ygkhawz8lG7CNj3Wluzp3vslhsVQcZRFasi5R2A0LHZ5S6eHGEPSjMHY9sj3OcyRDo3x
 hqKksnvCDhHrrKYUzSe+62SoDf0PjIaRUcGZCkZXU4e6MLiiJ88gwiJTdt5FqOxyNrvFlnNL
 yuitiMygfAXyMUMzaj+pQ6BiDO3rZ+PRQkwjunKYl+YAspCTNbNT+SVBZLztJ6s8K7xooG9g
 UU5
IronPort-HdrOrdr: A9a23:tnEOmKgAf2mtjwSHcmyrGJ7e73BQXvUji2hC6mlwRA09TyVXra
 yTdZMgpHvJYVkqNk3I9errBEDEewK+yXcX2/h1AV7BZmjbUQKTRekI0WKh+UyDJ8SUzIFgPM
 lbHpRWOZnZEUV6gcHm4AOxDtoshOWc/LvAv5a4854Ud2FXg2UK1XYBNu5deXcGIjV7OQ==
X-Talos-CUID: 9a23:/uiXFW7sD5tvG8xZidssrGolOP8cfW3n5XLIHR+gWCU2Q6+RYArF
X-Talos-MUID: 9a23:fatZUgV6nduOT5vq/GHegyEhFvp32q2zFVE2iLw7i++rFQUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,214,1728950400"; 
   d="scan'208";a="292957093"
Received: from rcdn-l-core-06.cisco.com ([173.37.255.143])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 06 Dec 2024 21:10:54 +0000
Received: from fedora.cisco.com (unknown [10.24.83.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kartilak@cisco.com)
	by rcdn-l-core-06.cisco.com (Postfix) with ESMTPSA id 1B4D018000254;
	Fri,  6 Dec 2024 21:10:53 +0000 (GMT)
From: Karan Tilak Kumar <kartilak@cisco.com>
To: sebaddel@cisco.com
Cc: arulponn@cisco.com,
	djhawar@cisco.com,
	gcboffa@cisco.com,
	mkai2@cisco.com,
	satishkh@cisco.com,
	aeasi@cisco.com,
	jejb@linux.ibm.com,
	martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Karan Tilak Kumar <kartilak@cisco.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v6 03/15] scsi: fnic: Add support for fabric based solicited requests and responses
Date: Fri,  6 Dec 2024 13:08:40 -0800
Message-ID: <20241206210852.3251-4-kartilak@cisco.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241206210852.3251-1-kartilak@cisco.com>
References: <20241206210852.3251-1-kartilak@cisco.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: kartilak@cisco.com
X-Outbound-SMTP-Client: 10.24.83.168, [10.24.83.168]
X-Outbound-Node: rcdn-l-core-06.cisco.com

Add fdls_disc.c to support fabric based solicited requests
and responses.
Clean up obsolete code but keep the function template so
as to not break compilation.
Remove duplicate definitions from header files.
Modify definitions of data members.

Reported-by: kernel test robot <lkp@intel.com>
Closes:
https://lore.kernel.org/oe-kbuild-all/202406112309.8GiDUvIM-lkp@
intel.com/
Closes:
https://lore.kernel.org/oe-kbuild-all/202406120201.VakI9Dly-lkp@
intel.com/

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Co-developed-by: Gian Carlo Boffa <gcboffa@cisco.com>
Signed-off-by: Gian Carlo Boffa <gcboffa@cisco.com>
Co-developed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Signed-off-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Co-developed-by: Arun Easi <aeasi@cisco.com>
Signed-off-by: Arun Easi <aeasi@cisco.com>
Co-developed-by: Karan Tilak Kumar <kartilak@cisco.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
---
Changes between v5 and v6:
    Incorporate review comments from Martin:
        Remove GCC 13.3 warnings.
    Incorporate review comments from Hannes:
	Refactor function definitions to top of file.
	Modify OXID allocation and reclaim design.
	Allocate OXID from a pool.
	Modify frame initialization.
	Modify frame send by avoiding memcpy in hot path.

Changes between v4 and v5:
    Incorporate review comments from Martin:
        Modify attribution appropriately.
        Modify fnic_fdls_timer_callback to call flogi.

Changes between v2 and v3:
    Fix issue found by kernel test robot.
    Incorporate review comments from Hannes:
        Replace redundant structure definitions with standard
        definitions.
        Replace static OXIDs with pool-based OXIDs for fabric.

Changes between v1 and v2:
    Incorporate review comments from Hannes:
        Remove double newline.
        Fix indentation in fnic_send_frame.
        Use the correct kernel-doc format.
        Replace htonll() with get_unaligned_be64().
        Add fnic_del_fabric_timer_sync as an inline function.
        Add fnic_del_tport_timer_sync as an inline function.
        Modify fc_abts_s variable name to fc_fabric_abts_s.
        Modify fc_fabric_abts_s to be a global frame.
        Rename pfc_abts to fabric_abts.
        Replace definitions with standard definitions from
        fc_els.h.
    Incorporate review comments from John:
        Replace kmalloc with kzalloc.
        Modify fnic_send_fcoe_frame to not send a return value.
    Replace simultaneous use of pointer and structure with just
    pointer.
    Fix issue found by kernel test robot.
---
 drivers/scsi/fnic/Makefile    |    1 +
 drivers/scsi/fnic/fdls_disc.c | 2180 +++++++++++++++++++++++++++++++++
 drivers/scsi/fnic/fnic.h      |  104 +-
 drivers/scsi/fnic/fnic_fcs.c  |  422 ++++---
 drivers/scsi/fnic/fnic_fdls.h |    1 -
 drivers/scsi/fnic/fnic_io.h   |   11 -
 drivers/scsi/fnic/fnic_main.c |   60 +-
 drivers/scsi/fnic/fnic_scsi.c |    6 +-
 8 files changed, 2593 insertions(+), 192 deletions(-)
 create mode 100644 drivers/scsi/fnic/fdls_disc.c

diff --git a/drivers/scsi/fnic/Makefile b/drivers/scsi/fnic/Makefile
index 6214a6b2e96d..3bd6b1c8b643 100644
--- a/drivers/scsi/fnic/Makefile
+++ b/drivers/scsi/fnic/Makefile
@@ -7,6 +7,7 @@ fnic-y	:= \
 	fnic_main.o \
 	fnic_res.o \
 	fnic_fcs.o \
+	fdls_disc.o \
 	fnic_scsi.o \
 	fnic_trace.o \
 	fnic_debugfs.o \
diff --git a/drivers/scsi/fnic/fdls_disc.c b/drivers/scsi/fnic/fdls_disc.c
new file mode 100644
index 000000000000..a21f103bc9df
--- /dev/null
+++ b/drivers/scsi/fnic/fdls_disc.c
@@ -0,0 +1,2180 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2008 Cisco Systems, Inc.  All rights reserved.
+ * Copyright 2007 Nuova Systems, Inc.  All rights reserved.
+ */
+
+#include <linux/workqueue.h>
+#include "fnic.h"
+#include "fdls_fc.h"
+#include "fnic_fdls.h"
+#include <scsi/fc/fc_fcp.h>
+#include <scsi/scsi_transport_fc.h>
+#include <linux/utsname.h>
+
+#define FC_FC4_TYPE_SCSI 0x08
+#define PORT_SPEED_BIT_8 8
+#define PORT_SPEED_BIT_9 9
+#define PORT_SPEED_BIT_14 14
+#define PORT_SPEED_BIT_15 15
+
+#define RETRIES_EXHAUSTED(iport)      \
+	(iport->fabric.retry_counter == FABRIC_LOGO_MAX_RETRY)
+
+#define FNIC_TPORT_MAX_NEXUS_RESTART (8)
+
+#define SCHEDULE_OXID_FREE_RETRY_TIME (300)
+
+/* Private Functions */
+static void fdls_send_rpn_id(struct fnic_iport_s *iport);
+static void fdls_process_flogi_rsp(struct fnic_iport_s *iport,
+				   struct fc_frame_header *fchdr,
+				   void *rx_frame);
+static void fnic_fdls_start_plogi(struct fnic_iport_s *iport);
+static void fnic_fdls_start_flogi(struct fnic_iport_s *iport);
+static void fdls_start_fabric_timer(struct fnic_iport_s *iport,
+			int timeout);
+static void fdls_init_plogi_frame(uint8_t *frame, struct fnic_iport_s *iport);
+static void fdls_init_logo_frame(uint8_t *frame, struct fnic_iport_s *iport);
+static void fdls_init_fabric_abts_frame(uint8_t *frame,
+						struct fnic_iport_s *iport);
+
+uint8_t *fdls_alloc_frame(struct fnic_iport_s *iport)
+{
+	struct fnic *fnic = iport->fnic;
+	uint8_t *frame = NULL;
+
+	frame = mempool_alloc(fnic->frame_pool, GFP_ATOMIC);
+	if (frame == NULL) {
+		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+				"Failed to allocate frame");
+		return NULL;
+	}
+
+	memset(frame, 0, FNIC_FCOE_FRAME_MAXSZ);
+	return frame;
+}
+
+/**
+ * fdls_alloc_oxid - Allocate an oxid from the bitmap based oxid pool
+ * @iport: Handle to iport instance
+ * @oxid_frame_type: Type of frame to allocate
+ * @active_oxid: the oxid which is in use
+ *
+ * Called with fnic lock held
+ */
+uint16_t fdls_alloc_oxid(struct fnic_iport_s *iport, int oxid_frame_type,
+	uint16_t *active_oxid)
+{
+	struct fnic *fnic = iport->fnic;
+	struct fnic_oxid_pool_s *oxid_pool = &iport->oxid_pool;
+	int idx;
+	uint16_t oxid;
+
+	lockdep_assert_held(&fnic->fnic_lock);
+
+	/*
+	 * Allocate next available oxid from bitmap
+	 */
+	idx = find_next_zero_bit(oxid_pool->bitmap, FNIC_OXID_POOL_SZ, oxid_pool->next_idx);
+	if (idx == FNIC_OXID_POOL_SZ) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			"Alloc oxid: all oxid slots are busy iport state:%d\n",
+			iport->state);
+		return FNIC_UNASSIGNED_OXID;
+	}
+
+	WARN_ON(test_and_set_bit(idx, oxid_pool->bitmap));
+	oxid_pool->next_idx = (idx + 1) % FNIC_OXID_POOL_SZ;	/* cycle through the bitmap */
+
+	oxid = FNIC_OXID_ENCODE(idx, oxid_frame_type);
+	*active_oxid = oxid;
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	   "alloc oxid: 0x%x, iport state: %d\n",
+	   oxid, iport->state);
+	return oxid;
+}
+
+/**
+ * fdls_free_oxid_idx - Free the oxid using the idx
+ * @iport: Handle to iport instance
+ * @oxid_idx: The index to free
+ *
+ * Free the oxid immediately and make it available for new requests
+ * Called with fnic lock held
+ */
+static void fdls_free_oxid_idx(struct fnic_iport_s *iport, uint16_t oxid_idx)
+{
+	struct fnic *fnic = iport->fnic;
+	struct fnic_oxid_pool_s *oxid_pool = &iport->oxid_pool;
+
+	lockdep_assert_held(&fnic->fnic_lock);
+
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		"free oxid idx: 0x%x\n", oxid_idx);
+
+	WARN_ON(!test_and_clear_bit(oxid_idx, oxid_pool->bitmap));
+}
+
+/**
+ * fdls_reclaim_oxid_handler - Callback handler for delayed_oxid_work
+ * @work: Handle to work_struct
+ *
+ * Scheduled when an oxid is to be freed later
+ * After freeing expired oxid(s), the handler schedules
+ * another callback with the remaining time
+ * of next unexpired entry in the reclaim list.
+ */
+void fdls_reclaim_oxid_handler(struct work_struct *work)
+{
+	struct fnic_oxid_pool_s *oxid_pool = container_of(work,
+		struct fnic_oxid_pool_s, oxid_reclaim_work.work);
+	struct fnic_iport_s *iport = container_of(oxid_pool,
+		struct fnic_iport_s, oxid_pool);
+	struct fnic *fnic = iport->fnic;
+	struct reclaim_entry_s *reclaim_entry, *next;
+	unsigned long delay_j, cur_jiffies;
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		"Reclaim oxid callback\n");
+
+	spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
+
+	/* Though the work was scheduled for one entry,
+	 * walk through and free the expired entries which might have been scheduled
+	 * at around the same time as the first entry
+	 */
+	list_for_each_entry_safe(reclaim_entry, next,
+		&(oxid_pool->oxid_reclaim_list), links) {
+
+		/* The list is always maintained in the order of expiry time */
+		cur_jiffies = jiffies;
+		if (time_before(cur_jiffies, reclaim_entry->expires))
+			break;
+
+		list_del(&reclaim_entry->links);
+		fdls_free_oxid_idx(iport, reclaim_entry->oxid_idx);
+		kfree(reclaim_entry);
+	}
+
+	/* schedule to free up the next entry */
+	if (!list_empty(&oxid_pool->oxid_reclaim_list)) {
+		reclaim_entry = list_first_entry(&oxid_pool->oxid_reclaim_list,
+			struct reclaim_entry_s, links);
+
+		delay_j = reclaim_entry->expires - cur_jiffies;
+		schedule_delayed_work(&oxid_pool->oxid_reclaim_work, delay_j);
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			"Scheduling next callback at:%ld jiffies\n", delay_j);
+	}
+
+	spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
+}
+
+/**
+ * fdls_free_oxid - Helper function to free the oxid
+ * @iport: Handle to iport instance
+ * @oxid: oxid to free
+ * @active_oxid: the oxid which is in use
+ *
+ * Called with fnic lock held
+ */
+void fdls_free_oxid(struct fnic_iport_s *iport,
+		uint16_t oxid, uint16_t *active_oxid)
+{
+	fdls_free_oxid_idx(iport, FNIC_OXID_IDX(oxid));
+	*active_oxid = FNIC_UNASSIGNED_OXID;
+}
+
+/**
+ * fdls_schedule_oxid_free - Schedule oxid to be freed later
+ * @iport: Handle to iport instance
+ * @active_oxid: the oxid which is in use
+ *
+ * Gets called in a rare case scenario when both a command
+ * (fdls or target discovery) timed out and the following ABTS
+ * timed out as well, without a link change.
+ *
+ * Called with fnic lock held
+ */
+void fdls_schedule_oxid_free(struct fnic_iport_s *iport, uint16_t *active_oxid)
+{
+	struct fnic *fnic = iport->fnic;
+	struct fnic_oxid_pool_s *oxid_pool = &iport->oxid_pool;
+	struct reclaim_entry_s *reclaim_entry;
+	unsigned long delay_j = msecs_to_jiffies(OXID_RECLAIM_TOV(iport));
+	int oxid_idx = FNIC_OXID_IDX(*active_oxid);
+
+	lockdep_assert_held(&fnic->fnic_lock);
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		"Schedule oxid free. oxid: 0x%x\n", *active_oxid);
+
+	*active_oxid = FNIC_UNASSIGNED_OXID;
+
+	reclaim_entry = (struct reclaim_entry_s *)
+		kzalloc(sizeof(struct reclaim_entry_s), GFP_ATOMIC);
+
+	if (!reclaim_entry) {
+		FNIC_FCS_DBG(KERN_WARNING, fnic->lport->host, fnic->fnic_num,
+			"Failed to allocate memory for reclaim struct for oxid idx: %d\n",
+			oxid_idx);
+
+		/* Retry the scheduling  */
+		WARN_ON(test_and_set_bit(oxid_idx, oxid_pool->pending_schedule_free));
+		schedule_delayed_work(&oxid_pool->schedule_oxid_free_retry, 0);
+		return;
+	}
+
+	reclaim_entry->oxid_idx = oxid_idx;
+	reclaim_entry->expires = round_jiffies(jiffies + delay_j);
+
+	list_add_tail(&reclaim_entry->links, &oxid_pool->oxid_reclaim_list);
+
+	schedule_delayed_work(&oxid_pool->oxid_reclaim_work, delay_j);
+}
+
+/**
+ * fdls_schedule_oxid_free_retry_work - Thread to schedule the
+ * oxid to be freed later
+ *
+ * @work: Handle to the work struct
+ */
+void fdls_schedule_oxid_free_retry_work(struct work_struct *work)
+{
+	struct fnic_oxid_pool_s *oxid_pool = container_of(work,
+		struct fnic_oxid_pool_s, schedule_oxid_free_retry.work);
+	struct fnic_iport_s *iport = container_of(oxid_pool,
+		struct fnic_iport_s, oxid_pool);
+	struct fnic *fnic = iport->fnic;
+	struct reclaim_entry_s *reclaim_entry;
+	unsigned long delay_j = msecs_to_jiffies(OXID_RECLAIM_TOV(iport));
+	int idx;
+
+	spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
+
+	for_each_set_bit(idx, oxid_pool->pending_schedule_free, FNIC_OXID_POOL_SZ) {
+
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			"Schedule oxid free. oxid idx: %d\n", idx);
+
+		spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
+	reclaim_entry = (struct reclaim_entry_s *)
+	kzalloc(sizeof(struct reclaim_entry_s), GFP_KERNEL);
+		spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
+
+		if (!reclaim_entry) {
+			FNIC_FCS_DBG(KERN_WARNING, fnic->lport->host, fnic->fnic_num,
+				"Failed to allocate memory for reclaim struct for oxid idx: 0x%x\n",
+				idx);
+
+			schedule_delayed_work(&oxid_pool->schedule_oxid_free_retry,
+				msecs_to_jiffies(SCHEDULE_OXID_FREE_RETRY_TIME));
+			spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
+			return;
+		}
+
+		if (test_and_clear_bit(idx, oxid_pool->pending_schedule_free)) {
+			reclaim_entry->oxid_idx = idx;
+			reclaim_entry->expires = round_jiffies(jiffies + delay_j);
+			list_add_tail(&reclaim_entry->links, &oxid_pool->oxid_reclaim_list);
+			schedule_delayed_work(&oxid_pool->oxid_reclaim_work, delay_j);
+		} else {
+			/* unlikely scenario, free the allocated memory and continue */
+			kfree(reclaim_entry);
+		}
+}
+
+	spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
+}
+
+static bool fdls_is_oxid_fabric_req(uint16_t oxid)
+{
+	int oxid_frame_type = FNIC_FRAME_TYPE(oxid);
+
+	switch (oxid_frame_type) {
+	case FNIC_FRAME_TYPE_FABRIC_FLOGI:
+	case FNIC_FRAME_TYPE_FABRIC_PLOGI:
+	case FNIC_FRAME_TYPE_FABRIC_RPN:
+	case FNIC_FRAME_TYPE_FABRIC_RFT:
+	case FNIC_FRAME_TYPE_FABRIC_RFF:
+	case FNIC_FRAME_TYPE_FABRIC_GPN_FT:
+	case FNIC_FRAME_TYPE_FABRIC_LOGO:
+		break;
+	default:
+		return false;
+	}
+	return true;
+}
+
+static bool fdls_is_oxid_fdmi_req(uint16_t oxid)
+{
+	int oxid_frame_type = FNIC_FRAME_TYPE(oxid);
+
+	switch (oxid_frame_type) {
+	case FNIC_FRAME_TYPE_FDMI_PLOGI:
+	case FNIC_FRAME_TYPE_FDMI_RHBA:
+	case FNIC_FRAME_TYPE_FDMI_RPA:
+		break;
+	default:
+		return false;
+	}
+	return true;
+}
+
+static bool fdls_is_oxid_tgt_req(uint16_t oxid)
+{
+	int oxid_frame_type = FNIC_FRAME_TYPE(oxid);
+
+	switch (oxid_frame_type) {
+	case FNIC_FRAME_TYPE_TGT_PLOGI:
+	case FNIC_FRAME_TYPE_TGT_PRLI:
+	case FNIC_FRAME_TYPE_TGT_ADISC:
+	case FNIC_FRAME_TYPE_TGT_LOGO:
+		break;
+	default:
+		return false;
+	}
+	return true;
+}
+
+void fnic_del_fabric_timer_sync(struct fnic *fnic)
+{
+	fnic->iport.fabric.del_timer_inprogress = 1;
+	spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
+	del_timer_sync(&fnic->iport.fabric.retry_timer);
+	spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
+	fnic->iport.fabric.del_timer_inprogress = 0;
+}
+
+void fnic_del_tport_timer_sync(struct fnic *fnic,
+						struct fnic_tport_s *tport)
+{
+	tport->del_timer_inprogress = 1;
+	spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
+	del_timer_sync(&tport->retry_timer);
+	spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
+	tport->del_timer_inprogress = 0;
+}
+
+static void
+fdls_start_fabric_timer(struct fnic_iport_s *iport, int timeout)
+{
+	u64 fabric_tov;
+	struct fnic *fnic = iport->fnic;
+
+	if (iport->fabric.timer_pending) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "iport fcid: 0x%x: Canceling fabric disc timer\n",
+					 iport->fcid);
+		fnic_del_fabric_timer_sync(fnic);
+		iport->fabric.timer_pending = 0;
+	}
+
+	if (!(iport->fabric.flags & FNIC_FDLS_FABRIC_ABORT_ISSUED))
+		iport->fabric.retry_counter++;
+
+	fabric_tov = jiffies + msecs_to_jiffies(timeout);
+	mod_timer(&iport->fabric.retry_timer, round_jiffies(fabric_tov));
+	iport->fabric.timer_pending = 1;
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "fabric timer is %d ", timeout);
+}
+
+void fdls_init_plogi_frame(uint8_t *frame,
+		struct fnic_iport_s *iport)
+{
+	struct fc_std_flogi *pplogi;
+	uint8_t s_id[3];
+
+	pplogi = (struct fc_std_flogi *) (frame + FNIC_ETH_FCOE_HDRS_OFFSET);
+	*pplogi = (struct fc_std_flogi) {
+		.fchdr = {.fh_r_ctl = FC_RCTL_ELS_REQ, .fh_d_id = {0xFF, 0xFF, 0xFC},
+		      .fh_type = FC_TYPE_ELS, .fh_f_ctl = {FNIC_ELS_REQ_FCTL, 0, 0},
+		      .fh_rx_id = cpu_to_be16(FNIC_UNASSIGNED_RXID)},
+		.els = {
+		    .fl_cmd = ELS_PLOGI,
+		    .fl_csp = {.sp_hi_ver = FNIC_FC_PH_VER_HI,
+			       .sp_lo_ver = FNIC_FC_PH_VER_LO,
+			       .sp_bb_cred = cpu_to_be16(FNIC_FC_B2B_CREDIT),
+			       .sp_features = cpu_to_be16(FC_SP_FT_CIRO),
+			       .sp_bb_data = cpu_to_be16(FNIC_FC_B2B_RDF_SZ),
+			       .sp_tot_seq = cpu_to_be16(FNIC_FC_CONCUR_SEQS),
+			       .sp_rel_off = cpu_to_be16(FNIC_FC_RO_INFO),
+			       .sp_e_d_tov = cpu_to_be32(FC_DEF_E_D_TOV)},
+		    .fl_cssp[2].cp_class = cpu_to_be16(FC_CPC_VALID | FC_CPC_SEQ),
+		    .fl_cssp[2].cp_rdfs = cpu_to_be16(0x800),
+		    .fl_cssp[2].cp_con_seq = cpu_to_be16(0xFF),
+		    .fl_cssp[2].cp_open_seq = 1}
+	};
+
+	FNIC_STD_SET_NPORT_NAME(&pplogi->els.fl_wwpn, iport->wwpn);
+	FNIC_STD_SET_NODE_NAME(&pplogi->els.fl_wwnn, iport->wwnn);
+	FNIC_LOGI_SET_RDF_SIZE(pplogi->els, iport->max_payload_size);
+
+	hton24(s_id, iport->fcid);
+	FNIC_STD_SET_S_ID(pplogi->fchdr, s_id);
+}
+
+static void fdls_init_logo_frame(uint8_t *frame,
+		struct fnic_iport_s *iport)
+{
+	struct fc_std_logo *plogo;
+	uint8_t s_id[3];
+
+	plogo = (struct fc_std_logo *) (frame + FNIC_ETH_FCOE_HDRS_OFFSET);
+	*plogo = (struct fc_std_logo) {
+		.fchdr = {.fh_r_ctl = FC_RCTL_ELS_REQ, .fh_type = FC_TYPE_ELS,
+		      .fh_f_ctl = {FNIC_ELS_REQ_FCTL, 0, 0}},
+		.els.fl_cmd = ELS_LOGO,
+	};
+
+	hton24(s_id, iport->fcid);
+	FNIC_STD_SET_S_ID(plogo->fchdr, s_id);
+	memcpy(plogo->els.fl_n_port_id, s_id, 3);
+
+	FNIC_STD_SET_NPORT_NAME(&plogo->els.fl_n_port_wwn,
+			    iport->wwpn);
+}
+
+static void fdls_init_fabric_abts_frame(uint8_t *frame,
+		struct fnic_iport_s *iport)
+{
+	struct fc_frame_header *pfabric_abts;
+
+	pfabric_abts = (struct fc_frame_header *) (frame + FNIC_ETH_FCOE_HDRS_OFFSET);
+	*pfabric_abts = (struct fc_frame_header) {
+		.fh_r_ctl = FC_RCTL_BA_ABTS,	/* ABTS */
+		.fh_s_id = {0x00, 0x00, 0x00},
+		.fh_cs_ctl = 0x00, .fh_type = FC_TYPE_BLS,
+		.fh_f_ctl = {FNIC_REQ_ABTS_FCTL, 0, 0}, .fh_seq_id = 0x00,
+		.fh_df_ctl = 0x00, .fh_seq_cnt = 0x0000,
+		.fh_rx_id = cpu_to_be16(FNIC_UNASSIGNED_RXID),
+		.fh_parm_offset = 0x00000000,	/* bit:0 = 0 Abort a exchange */
+	};
+}
+static void fdls_send_fabric_abts(struct fnic_iport_s *iport)
+{
+	uint8_t *frame;
+	uint8_t s_id[3];
+	uint8_t d_id[3];
+	struct fnic *fnic = iport->fnic;
+	struct fc_frame_header *pfabric_abts;
+	uint16_t oxid;
+	uint16_t frame_size = FNIC_ETH_FCOE_HDRS_OFFSET +
+			sizeof(struct fc_frame_header);
+
+	frame = fdls_alloc_frame(iport);
+	if (frame == NULL) {
+		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+				"Failed to allocate frame to send fabric ABTS");
+		return;
+	}
+
+	pfabric_abts = (struct fc_frame_header *) (frame + FNIC_ETH_FCOE_HDRS_OFFSET);
+	fdls_init_fabric_abts_frame(frame, iport);
+
+	hton24(s_id, iport->fcid);
+
+	switch (iport->fabric.state) {
+	case FDLS_STATE_FABRIC_LOGO:
+		hton24(d_id, FC_FID_FLOGI);
+		FNIC_STD_SET_D_ID(*pfabric_abts, d_id);
+		break;
+
+	case FDLS_STATE_FABRIC_FLOGI:
+		hton24(d_id, FC_FID_FLOGI);
+		FNIC_STD_SET_D_ID(*pfabric_abts, d_id);
+		break;
+
+	case FDLS_STATE_FABRIC_PLOGI:
+		FNIC_STD_SET_S_ID(*pfabric_abts, s_id);
+		hton24(d_id, FC_FID_DIR_SERV);
+		FNIC_STD_SET_D_ID(*pfabric_abts, d_id);
+		break;
+
+	case FDLS_STATE_RPN_ID:
+		FNIC_STD_SET_S_ID(*pfabric_abts, s_id);
+		hton24(d_id, FC_FID_DIR_SERV);
+		FNIC_STD_SET_D_ID(*pfabric_abts, d_id);
+		break;
+
+	case FDLS_STATE_SCR:
+		FNIC_STD_SET_S_ID(*pfabric_abts, s_id);
+		hton24(d_id, FC_FID_FCTRL);
+		FNIC_STD_SET_D_ID(*pfabric_abts, d_id);
+		break;
+
+	case FDLS_STATE_REGISTER_FC4_TYPES:
+		FNIC_STD_SET_S_ID(*pfabric_abts, s_id);
+		hton24(d_id, FC_FID_DIR_SERV);
+		FNIC_STD_SET_D_ID(*pfabric_abts, d_id);
+		break;
+
+	case FDLS_STATE_REGISTER_FC4_FEATURES:
+		FNIC_STD_SET_S_ID(*pfabric_abts, s_id);
+		hton24(d_id, FC_FID_DIR_SERV);
+		FNIC_STD_SET_D_ID(*pfabric_abts, d_id);
+		break;
+
+	case FDLS_STATE_GPN_FT:
+		FNIC_STD_SET_S_ID(*pfabric_abts, s_id);
+		hton24(d_id, FC_FID_DIR_SERV);
+		FNIC_STD_SET_D_ID(*pfabric_abts, d_id);
+		break;
+	default:
+		return;
+	}
+
+	oxid = iport->active_oxid_fabric_req;
+	FNIC_STD_SET_OX_ID(*pfabric_abts, oxid);
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		 "0x%x: FDLS send fabric abts. iport->fabric.state: %d oxid: 0x%x",
+		 iport->fcid, iport->fabric.state, oxid);
+
+	iport->fabric.flags |= FNIC_FDLS_FABRIC_ABORT_ISSUED;
+
+	fnic_send_fcoe_frame(iport, frame, frame_size);
+
+	/* Even if fnic_send_fcoe_frame() fails we want to retry after timeout */
+	fdls_start_fabric_timer(iport, 2 * iport->e_d_tov);
+	iport->fabric.timer_pending = 1;
+}
+
+static void fdls_send_fabric_flogi(struct fnic_iport_s *iport)
+{
+	uint8_t *frame;
+	struct fc_std_flogi *pflogi;
+	struct fnic *fnic = iport->fnic;
+	uint16_t oxid;
+	uint16_t frame_size = FNIC_ETH_FCOE_HDRS_OFFSET +
+			sizeof(struct fc_std_flogi);
+
+	frame = fdls_alloc_frame(iport);
+	if (frame == NULL) {
+		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		     "Failed to allocate frame to send FLOGI");
+		iport->fabric.flags |= FNIC_FDLS_RETRY_FRAME;
+		goto err_out;
+	}
+
+	pflogi = (struct fc_std_flogi *) (frame + FNIC_ETH_FCOE_HDRS_OFFSET);
+	*pflogi = (struct fc_std_flogi) {
+		.fchdr = {.fh_r_ctl = FC_RCTL_ELS_REQ, .fh_d_id = {0xFF, 0xFF, 0xFE},
+		      .fh_type = FC_TYPE_ELS, .fh_f_ctl = {FNIC_ELS_REQ_FCTL, 0, 0},
+		      .fh_rx_id = cpu_to_be16(FNIC_UNASSIGNED_RXID)},
+		.els.fl_cmd = ELS_FLOGI,
+		.els.fl_csp = {.sp_hi_ver = FNIC_FC_PH_VER_HI,
+			   .sp_lo_ver = FNIC_FC_PH_VER_LO,
+			   .sp_bb_cred = cpu_to_be16(FNIC_FC_B2B_CREDIT),
+			   .sp_bb_data = cpu_to_be16(FNIC_FC_B2B_RDF_SZ)},
+		.els.fl_cssp[2].cp_class = cpu_to_be16(FC_CPC_VALID | FC_CPC_SEQ)
+	};
+
+	FNIC_STD_SET_NPORT_NAME(&pflogi->els.fl_wwpn, iport->wwpn);
+	FNIC_STD_SET_NODE_NAME(&pflogi->els.fl_wwnn, iport->wwnn);
+	FNIC_LOGI_SET_RDF_SIZE(pflogi->els, iport->max_payload_size);
+	FNIC_LOGI_SET_R_A_TOV(pflogi->els, iport->r_a_tov);
+	FNIC_LOGI_SET_E_D_TOV(pflogi->els, iport->e_d_tov);
+
+	oxid = fdls_alloc_oxid(iport, FNIC_FRAME_TYPE_FABRIC_FLOGI,
+		&iport->active_oxid_fabric_req);
+
+	if (oxid == FNIC_UNASSIGNED_OXID) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		     "0x%x: Failed to allocate OXID to send FLOGI",
+			 iport->fcid);
+		mempool_free(frame, fnic->frame_pool);
+		iport->fabric.flags |= FNIC_FDLS_RETRY_FRAME;
+		goto err_out;
+	}
+	FNIC_STD_SET_OX_ID(pflogi->fchdr, oxid);
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		 "0x%x: FDLS send fabric FLOGI with oxid: 0x%x", iport->fcid,
+		 oxid);
+
+	fnic_send_fcoe_frame(iport, frame, frame_size);
+err_out:
+	/* Even if fnic_send_fcoe_frame() fails we want to retry after timeout */
+	fdls_start_fabric_timer(iport, 2 * iport->e_d_tov);
+}
+
+static void fdls_send_fabric_plogi(struct fnic_iport_s *iport)
+{
+	uint8_t *frame;
+	struct fc_std_flogi *pplogi;
+	struct fnic *fnic = iport->fnic;
+	uint16_t oxid;
+	uint16_t frame_size = FNIC_ETH_FCOE_HDRS_OFFSET +
+			sizeof(struct fc_std_flogi);
+
+	frame = fdls_alloc_frame(iport);
+	if (frame == NULL) {
+		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		     "Failed to allocate frame to send PLOGI");
+		iport->fabric.flags |= FNIC_FDLS_RETRY_FRAME;
+		goto err_out;
+	}
+
+	pplogi = (struct fc_std_flogi *) (frame + FNIC_ETH_FCOE_HDRS_OFFSET);
+	fdls_init_plogi_frame(frame, iport);
+
+	oxid = fdls_alloc_oxid(iport, FNIC_FRAME_TYPE_FABRIC_PLOGI,
+		&iport->active_oxid_fabric_req);
+	if (oxid == FNIC_UNASSIGNED_OXID) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		     "0x%x: Failed to allocate OXID to send fabric PLOGI",
+			 iport->fcid);
+		mempool_free(frame, fnic->frame_pool);
+		iport->fabric.flags |= FNIC_FDLS_RETRY_FRAME;
+		goto err_out;
+	}
+	FNIC_STD_SET_OX_ID(pplogi->fchdr, oxid);
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		 "0x%x: FDLS send fabric PLOGI with oxid: 0x%x", iport->fcid,
+		 oxid);
+
+	fnic_send_fcoe_frame(iport, frame, frame_size);
+
+err_out:
+	/* Even if fnic_send_fcoe_frame() fails we want to retry after timeout */
+	fdls_start_fabric_timer(iport, 2 * iport->e_d_tov);
+}
+
+static void fdls_send_rpn_id(struct fnic_iport_s *iport)
+{
+	uint8_t *frame;
+	struct fc_std_rpn_id *prpn_id;
+	struct fnic *fnic = iport->fnic;
+	uint16_t oxid;
+	uint16_t frame_size = FNIC_ETH_FCOE_HDRS_OFFSET +
+			sizeof(struct fc_std_rpn_id);
+	uint8_t fcid[3];
+
+	frame = fdls_alloc_frame(iport);
+	if (frame == NULL) {
+		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		     "Failed to allocate frame to send RPN_ID");
+		iport->fabric.flags |= FNIC_FDLS_RETRY_FRAME;
+		goto err_out;
+	}
+
+	prpn_id = (struct fc_std_rpn_id *) (frame + FNIC_ETH_FCOE_HDRS_OFFSET);
+	*prpn_id = (struct fc_std_rpn_id) {
+		.fchdr = {.fh_r_ctl = FC_RCTL_DD_UNSOL_CTL,
+		      .fh_d_id = {0xFF, 0xFF, 0xFC}, .fh_type = FC_TYPE_CT,
+		      .fh_f_ctl = {FNIC_ELS_REQ_FCTL, 0, 0},
+		      .fh_rx_id = cpu_to_be16(FNIC_UNASSIGNED_RXID)},
+		.fc_std_ct_hdr = {.ct_rev = FC_CT_REV, .ct_fs_type = FC_FST_DIR,
+			      .ct_fs_subtype = FC_NS_SUBTYPE,
+			      .ct_cmd = cpu_to_be16(FC_NS_RPN_ID)}
+	};
+
+	hton24(fcid, iport->fcid);
+	FNIC_STD_SET_S_ID(prpn_id->fchdr, fcid);
+
+	FNIC_STD_SET_PORT_ID(prpn_id->rpn_id, fcid);
+	FNIC_STD_SET_PORT_NAME(prpn_id->rpn_id, iport->wwpn);
+
+	oxid = fdls_alloc_oxid(iport, FNIC_FRAME_TYPE_FABRIC_RPN,
+		&iport->active_oxid_fabric_req);
+
+	if (oxid == FNIC_UNASSIGNED_OXID) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		     "0x%x: Failed to allocate OXID to send RPN_ID",
+			 iport->fcid);
+		mempool_free(frame, fnic->frame_pool);
+		iport->fabric.flags |= FNIC_FDLS_RETRY_FRAME;
+		goto err_out;
+	}
+	FNIC_STD_SET_OX_ID(prpn_id->fchdr, oxid);
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		 "0x%x: FDLS send RPN ID with oxid: 0x%x", iport->fcid,
+		 oxid);
+
+	fnic_send_fcoe_frame(iport, frame, frame_size);
+
+err_out:
+	/* Even if fnic_send_fcoe_frame() fails we want to retry after timeout */
+	fdls_start_fabric_timer(iport, 2 * iport->e_d_tov);
+}
+
+static void fdls_send_scr(struct fnic_iport_s *iport)
+{
+	uint8_t *frame;
+	struct fc_std_scr *pscr;
+	struct fnic *fnic = iport->fnic;
+	uint16_t oxid;
+	uint16_t frame_size = FNIC_ETH_FCOE_HDRS_OFFSET +
+			sizeof(struct fc_std_scr);
+	uint8_t fcid[3];
+
+	frame = fdls_alloc_frame(iport);
+	if (frame == NULL) {
+		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		     "Failed to allocate frame to send SCR");
+		iport->fabric.flags |= FNIC_FDLS_RETRY_FRAME;
+		goto err_out;
+	}
+
+	pscr = (struct fc_std_scr *) (frame + FNIC_ETH_FCOE_HDRS_OFFSET);
+	*pscr = (struct fc_std_scr) {
+		.fchdr = {.fh_r_ctl = FC_RCTL_ELS_REQ,
+		      .fh_d_id = {0xFF, 0xFF, 0xFD}, .fh_type = FC_TYPE_ELS,
+		      .fh_f_ctl = {FNIC_ELS_REQ_FCTL, 0, 0},
+		      .fh_rx_id = cpu_to_be16(FNIC_UNASSIGNED_RXID)},
+		.scr = {.scr_cmd = ELS_SCR,
+		    .scr_reg_func = ELS_SCRF_FULL}
+	};
+
+	hton24(fcid, iport->fcid);
+	FNIC_STD_SET_S_ID(pscr->fchdr, fcid);
+
+	oxid = fdls_alloc_oxid(iport, FNIC_FRAME_TYPE_FABRIC_SCR,
+		&iport->active_oxid_fabric_req);
+	if (oxid == FNIC_UNASSIGNED_OXID) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		     "0x%x: Failed to allocate OXID to send SCR",
+			 iport->fcid);
+		mempool_free(frame, fnic->frame_pool);
+		iport->fabric.flags |= FNIC_FDLS_RETRY_FRAME;
+		goto err_out;
+	}
+	FNIC_STD_SET_OX_ID(pscr->fchdr, oxid);
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		 "0x%x: FDLS send SCR with oxid: 0x%x", iport->fcid,
+		 oxid);
+
+	fnic_send_fcoe_frame(iport, frame, frame_size);
+
+err_out:
+	/* Even if fnic_send_fcoe_frame() fails we want to retry after timeout */
+	fdls_start_fabric_timer(iport, 2 * iport->e_d_tov);
+}
+
+static void fdls_send_gpn_ft(struct fnic_iport_s *iport, int fdls_state)
+{
+	uint8_t *frame;
+	struct fc_std_gpn_ft *pgpn_ft;
+	struct fnic *fnic = iport->fnic;
+	uint16_t oxid;
+	uint16_t frame_size = FNIC_ETH_FCOE_HDRS_OFFSET +
+			sizeof(struct fc_std_gpn_ft);
+	uint8_t fcid[3];
+
+	frame = fdls_alloc_frame(iport);
+	if (frame == NULL) {
+		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		     "Failed to allocate frame to send GPN FT");
+		iport->fabric.flags |= FNIC_FDLS_RETRY_FRAME;
+		goto err_out;
+	}
+
+	pgpn_ft = (struct fc_std_gpn_ft *) (frame + FNIC_ETH_FCOE_HDRS_OFFSET);
+	*pgpn_ft = (struct fc_std_gpn_ft) {
+		.fchdr = {.fh_r_ctl = FC_RCTL_DD_UNSOL_CTL,
+		      .fh_d_id = {0xFF, 0xFF, 0xFC}, .fh_type = FC_TYPE_CT,
+		      .fh_f_ctl = {FNIC_ELS_REQ_FCTL, 0, 0},
+		      .fh_rx_id = cpu_to_be16(FNIC_UNASSIGNED_RXID)},
+		.fc_std_ct_hdr = {.ct_rev = FC_CT_REV, .ct_fs_type = FC_FST_DIR,
+			      .ct_fs_subtype = FC_NS_SUBTYPE,
+			      .ct_cmd = cpu_to_be16(FC_NS_GPN_FT)},
+		.gpn_ft.fn_fc4_type = 0x08
+	};
+
+	hton24(fcid, iport->fcid);
+	FNIC_STD_SET_S_ID(pgpn_ft->fchdr, fcid);
+
+	oxid = fdls_alloc_oxid(iport, FNIC_FRAME_TYPE_FABRIC_GPN_FT,
+		&iport->active_oxid_fabric_req);
+
+	if (oxid == FNIC_UNASSIGNED_OXID) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		     "0x%x: Failed to allocate OXID to send GPN FT",
+			 iport->fcid);
+		mempool_free(frame, fnic->frame_pool);
+		iport->fabric.flags |= FNIC_FDLS_RETRY_FRAME;
+		goto err_out;
+	}
+	FNIC_STD_SET_OX_ID(pgpn_ft->fchdr, oxid);
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		 "0x%x: FDLS send GPN FT with oxid: 0x%x", iport->fcid,
+		 oxid);
+
+	fnic_send_fcoe_frame(iport, frame, frame_size);
+
+err_out:
+	/* Even if fnic_send_fcoe_frame() fails we want to retry after timeout */
+	fdls_start_fabric_timer(iport, 2 * iport->e_d_tov);
+	fdls_set_state((&iport->fabric), fdls_state);
+}
+
+static void fdls_send_register_fc4_types(struct fnic_iport_s *iport)
+{
+	uint8_t *frame;
+	struct fc_std_rft_id *prft_id;
+	struct fnic *fnic = iport->fnic;
+	uint16_t oxid;
+	uint16_t frame_size = FNIC_ETH_FCOE_HDRS_OFFSET +
+			sizeof(struct fc_std_rft_id);
+	uint8_t fcid[3];
+
+	frame = fdls_alloc_frame(iport);
+	if (frame == NULL) {
+		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		     "Failed to allocate frame to send RFT");
+		return;
+	}
+
+	prft_id = (struct fc_std_rft_id *) (frame + FNIC_ETH_FCOE_HDRS_OFFSET);
+	*prft_id = (struct fc_std_rft_id) {
+		.fchdr = {.fh_r_ctl = FC_RCTL_DD_UNSOL_CTL,
+		      .fh_d_id = {0xFF, 0xFF, 0xFC}, .fh_type = FC_TYPE_CT,
+		      .fh_f_ctl = {FNIC_ELS_REQ_FCTL, 0, 0},
+		      .fh_rx_id = cpu_to_be16(FNIC_UNASSIGNED_RXID)},
+		.fc_std_ct_hdr = {.ct_rev = FC_CT_REV, .ct_fs_type = FC_FST_DIR,
+			      .ct_fs_subtype = FC_NS_SUBTYPE,
+			      .ct_cmd = cpu_to_be16(FC_NS_RFT_ID)}
+	};
+
+	hton24(fcid, iport->fcid);
+	FNIC_STD_SET_S_ID(prft_id->fchdr, fcid);
+	FNIC_STD_SET_PORT_ID(prft_id->rft_id, fcid);
+
+	oxid = fdls_alloc_oxid(iport, FNIC_FRAME_TYPE_FABRIC_RFT,
+		&iport->active_oxid_fabric_req);
+
+	if (oxid == FNIC_UNASSIGNED_OXID) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		     "0x%x: Failed to allocate OXID to send RFT",
+			 iport->fcid);
+		mempool_free(frame, fnic->frame_pool);
+		return;
+	}
+	FNIC_STD_SET_OX_ID(prft_id->fchdr, oxid);
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		 "0x%x: FDLS send RFT with oxid: 0x%x", iport->fcid,
+		 oxid);
+
+	if (IS_FNIC_FCP_INITIATOR(fnic))
+		prft_id->rft_id.fr_fts.ff_type_map[0] =
+	    cpu_to_be32(1 << FC_TYPE_FCP);
+
+	prft_id->rft_id.fr_fts.ff_type_map[1] =
+	cpu_to_be32(1 << (FC_TYPE_CT % FC_NS_BPW));
+
+	fnic_send_fcoe_frame(iport, frame, frame_size);
+
+	/* Even if fnic_send_fcoe_frame() fails we want to retry after timeout */
+	fdls_start_fabric_timer(iport, 2 * iport->e_d_tov);
+}
+
+static void fdls_send_register_fc4_features(struct fnic_iport_s *iport)
+{
+	uint8_t *frame;
+	struct fc_std_rff_id *prff_id;
+	struct fnic *fnic = iport->fnic;
+	uint16_t oxid;
+	uint16_t frame_size = FNIC_ETH_FCOE_HDRS_OFFSET +
+			sizeof(struct fc_std_rff_id);
+	uint8_t fcid[3];
+
+	frame = fdls_alloc_frame(iport);
+	if (frame == NULL) {
+		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		     "Failed to allocate frame to send RFF");
+		return;
+	}
+
+	prff_id = (struct fc_std_rff_id *) (frame + FNIC_ETH_FCOE_HDRS_OFFSET);
+	*prff_id = (struct fc_std_rff_id) {
+		.fchdr = {.fh_r_ctl = FC_RCTL_DD_UNSOL_CTL,
+		      .fh_d_id = {0xFF, 0xFF, 0xFC}, .fh_type = FC_TYPE_CT,
+		      .fh_f_ctl = {FNIC_ELS_REQ_FCTL, 0, 0},
+		      .fh_rx_id = cpu_to_be16(FNIC_UNASSIGNED_RXID)},
+		.fc_std_ct_hdr = {.ct_rev = FC_CT_REV, .ct_fs_type = FC_FST_DIR,
+			      .ct_fs_subtype = FC_NS_SUBTYPE,
+			      .ct_cmd = cpu_to_be16(FC_NS_RFF_ID)},
+		.rff_id.fr_feat = 0x2,
+		.rff_id.fr_type = FC_TYPE_FCP
+	};
+
+	hton24(fcid, iport->fcid);
+	FNIC_STD_SET_S_ID(prff_id->fchdr, fcid);
+	FNIC_STD_SET_PORT_ID(prff_id->rff_id, fcid);
+
+	oxid = fdls_alloc_oxid(iport, FNIC_FRAME_TYPE_FABRIC_RFF,
+		&iport->active_oxid_fabric_req);
+
+	if (oxid == FNIC_UNASSIGNED_OXID) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			     "0x%x: Failed to allocate OXID to send RFF",
+				 iport->fcid);
+		mempool_free(frame, fnic->frame_pool);
+		return;
+	}
+	FNIC_STD_SET_OX_ID(prff_id->fchdr, oxid);
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		 "0x%x: FDLS send RFF with oxid: 0x%x", iport->fcid,
+		 oxid);
+
+	if (IS_FNIC_FCP_INITIATOR(fnic)) {
+		prff_id->rff_id.fr_type = FC_TYPE_FCP;
+	} else {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "0x%x: Unknown type", iport->fcid);
+	}
+
+	fnic_send_fcoe_frame(iport, frame, frame_size);
+
+	/* Even if fnic_send_fcoe_frame() fails we want to retry after timeout */
+	fdls_start_fabric_timer(iport, 2 * iport->e_d_tov);
+}
+
+/**
+ * fdls_send_fabric_logo - Send flogo to the fcf
+ * @iport: Handle to fnic iport
+ *
+ * This function does not change or check the fabric state.
+ * It the caller's responsibility to set the appropriate iport fabric
+ * state when this is called. Normally it is FDLS_STATE_FABRIC_LOGO.
+ * Currently this assumes to be called with fnic lock held.
+ */
+void fdls_send_fabric_logo(struct fnic_iport_s *iport)
+{
+	uint8_t *frame;
+	struct fc_std_logo *plogo;
+	struct fnic *fnic = iport->fnic;
+	uint8_t d_id[3];
+	uint16_t oxid;
+	uint16_t frame_size = FNIC_ETH_FCOE_HDRS_OFFSET +
+			sizeof(struct fc_std_logo);
+
+	frame = fdls_alloc_frame(iport);
+	if (frame == NULL) {
+		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		     "Failed to allocate frame to send fabric LOGO");
+		return;
+	}
+
+	plogo = (struct fc_std_logo *) (frame + FNIC_ETH_FCOE_HDRS_OFFSET);
+	fdls_init_logo_frame(frame, iport);
+
+	oxid = fdls_alloc_oxid(iport, FNIC_FRAME_TYPE_FABRIC_LOGO,
+		&iport->active_oxid_fabric_req);
+
+	if (oxid == FNIC_UNASSIGNED_OXID) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		     "0x%x: Failed to allocate OXID to send fabric LOGO",
+			 iport->fcid);
+		mempool_free(frame, fnic->frame_pool);
+		return;
+	}
+	FNIC_STD_SET_OX_ID(plogo->fchdr, oxid);
+
+	hton24(d_id, FC_FID_FLOGI);
+	FNIC_STD_SET_D_ID(plogo->fchdr, d_id);
+
+	iport->fabric.flags &= ~FNIC_FDLS_FABRIC_ABORT_ISSUED;
+
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		 "0x%x: FDLS send fabric LOGO with oxid: 0x%x",
+		 iport->fcid, oxid);
+
+	fnic_send_fcoe_frame(iport, frame, frame_size);
+
+	fdls_start_fabric_timer(iport, 2 * iport->e_d_tov);
+}
+
+void fdls_fabric_timer_callback(struct timer_list *t)
+{
+	struct fnic_fdls_fabric_s *fabric = from_timer(fabric, t, retry_timer);
+	struct fnic_iport_s *iport =
+		container_of(fabric, struct fnic_iport_s, fabric);
+	struct fnic *fnic = iport->fnic;
+	unsigned long flags;
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		 "tp: %d fab state: %d fab retry counter: %d max_flogi_retries: %d",
+		 iport->fabric.timer_pending, iport->fabric.state,
+		 iport->fabric.retry_counter, iport->max_flogi_retries);
+
+	spin_lock_irqsave(&fnic->fnic_lock, flags);
+
+	if (!iport->fabric.timer_pending) {
+		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+		return;
+	}
+
+	if (iport->fabric.del_timer_inprogress) {
+		iport->fabric.del_timer_inprogress = 0;
+		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "fabric_del_timer inprogress(%d). Skip timer cb",
+					 iport->fabric.del_timer_inprogress);
+		return;
+	}
+
+	iport->fabric.timer_pending = 0;
+
+	/* The fabric state indicates which frames have time out, and we retry */
+	switch (iport->fabric.state) {
+	case FDLS_STATE_FABRIC_FLOGI:
+		/* Flogi received a LS_RJT with busy we retry from here */
+		if ((iport->fabric.flags & FNIC_FDLS_RETRY_FRAME)
+			&& (iport->fabric.retry_counter < iport->max_flogi_retries)) {
+			iport->fabric.flags &= ~FNIC_FDLS_RETRY_FRAME;
+			fdls_send_fabric_flogi(iport);
+		} else if (!(iport->fabric.flags & FNIC_FDLS_FABRIC_ABORT_ISSUED)) {
+			/* Flogi has time out 2*ed_tov send abts */
+			fdls_send_fabric_abts(iport);
+		} else {
+			/* ABTS has timed out
+			 * Mark the OXID to be freed after 2 * r_a_tov and retry the req
+			 */
+			fdls_schedule_oxid_free(iport, &iport->active_oxid_fabric_req);
+			if (iport->fabric.retry_counter < iport->max_flogi_retries) {
+				iport->fabric.flags &= ~FNIC_FDLS_FABRIC_ABORT_ISSUED;
+				fdls_send_fabric_flogi(iport);
+			} else
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+							 "Exceeded max FLOGI retries");
+		}
+		break;
+	case FDLS_STATE_FABRIC_PLOGI:
+		/* Plogi received a LS_RJT with busy we retry from here */
+		if ((iport->fabric.flags & FNIC_FDLS_RETRY_FRAME)
+			&& (iport->fabric.retry_counter < iport->max_plogi_retries)) {
+			iport->fabric.flags &= ~FNIC_FDLS_RETRY_FRAME;
+			fdls_send_fabric_plogi(iport);
+		} else if (!(iport->fabric.flags & FNIC_FDLS_FABRIC_ABORT_ISSUED)) {
+		/* Plogi has timed out 2*ed_tov send abts */
+			fdls_send_fabric_abts(iport);
+		} else {
+			/* ABTS has timed out
+			 * Mark the OXID to be freed after 2 * r_a_tov and retry the req
+			 */
+			fdls_schedule_oxid_free(iport, &iport->active_oxid_fabric_req);
+			if (iport->fabric.retry_counter < iport->max_plogi_retries) {
+				iport->fabric.flags &= ~FNIC_FDLS_FABRIC_ABORT_ISSUED;
+				fdls_send_fabric_plogi(iport);
+			} else
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+							 "Exceeded max PLOGI retries");
+		}
+		break;
+	case FDLS_STATE_RPN_ID:
+		/* Rpn_id received a LS_RJT with busy we retry from here */
+		if ((iport->fabric.flags & FNIC_FDLS_RETRY_FRAME)
+			&& (iport->fabric.retry_counter < FDLS_RETRY_COUNT)) {
+			iport->fabric.flags &= ~FNIC_FDLS_RETRY_FRAME;
+			fdls_send_rpn_id(iport);
+		} else if (!(iport->fabric.flags & FNIC_FDLS_FABRIC_ABORT_ISSUED))
+			/* RPN has timed out. Send abts */
+			fdls_send_fabric_abts(iport);
+		else {
+			/* ABTS has timed out */
+			fdls_schedule_oxid_free(iport, &iport->active_oxid_fabric_req);
+			fnic_fdls_start_plogi(iport);	/* go back to fabric Plogi */
+		}
+		break;
+	case FDLS_STATE_SCR:
+		/* scr received a LS_RJT with busy we retry from here */
+		if ((iport->fabric.flags & FNIC_FDLS_RETRY_FRAME)
+			&& (iport->fabric.retry_counter < FDLS_RETRY_COUNT)) {
+			iport->fabric.flags &= ~FNIC_FDLS_RETRY_FRAME;
+			fdls_send_scr(iport);
+		} else if (!(iport->fabric.flags & FNIC_FDLS_FABRIC_ABORT_ISSUED))
+		    /* scr has timed out. Send abts */
+			fdls_send_fabric_abts(iport);
+		else {
+			/* ABTS has timed out */
+			fdls_schedule_oxid_free(iport, &iport->active_oxid_fabric_req);
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "ABTS timed out. Starting PLOGI: %p", iport);
+			fnic_fdls_start_plogi(iport);
+		}
+		break;
+	case FDLS_STATE_REGISTER_FC4_TYPES:
+		/* scr received a LS_RJT with busy we retry from here */
+		if ((iport->fabric.flags & FNIC_FDLS_RETRY_FRAME)
+			&& (iport->fabric.retry_counter < FDLS_RETRY_COUNT)) {
+			iport->fabric.flags &= ~FNIC_FDLS_RETRY_FRAME;
+			fdls_send_register_fc4_types(iport);
+		} else if (!(iport->fabric.flags & FNIC_FDLS_FABRIC_ABORT_ISSUED)) {
+			/* RFT_ID timed out send abts */
+			fdls_send_fabric_abts(iport);
+		} else {
+			/* ABTS has timed out */
+			fdls_schedule_oxid_free(iport, &iport->active_oxid_fabric_req);
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "ABTS timed out. Starting PLOGI: %p", iport);
+			fnic_fdls_start_plogi(iport);	/* go back to fabric Plogi */
+		}
+		break;
+	case FDLS_STATE_REGISTER_FC4_FEATURES:
+		/* scr received a LS_RJT with busy we retry from here */
+		if ((iport->fabric.flags & FNIC_FDLS_RETRY_FRAME)
+			&& (iport->fabric.retry_counter < FDLS_RETRY_COUNT)) {
+			iport->fabric.flags &= ~FNIC_FDLS_RETRY_FRAME;
+			fdls_send_register_fc4_features(iport);
+		} else if (!(iport->fabric.flags & FNIC_FDLS_FABRIC_ABORT_ISSUED))
+			/* SCR has timed out. Send abts */
+			fdls_send_fabric_abts(iport);
+		else {
+			/* ABTS has timed out */
+			fdls_schedule_oxid_free(iport, &iport->active_oxid_fabric_req);
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "ABTS timed out. Starting PLOGI %p", iport);
+			fnic_fdls_start_plogi(iport);	/* go back to fabric Plogi */
+		}
+		break;
+	case FDLS_STATE_RSCN_GPN_FT:
+	case FDLS_STATE_SEND_GPNFT:
+	case FDLS_STATE_GPN_FT:
+		/* GPN_FT received a LS_RJT with busy we retry from here */
+		if ((iport->fabric.flags & FNIC_FDLS_RETRY_FRAME)
+			&& (iport->fabric.retry_counter < FDLS_RETRY_COUNT)) {
+			iport->fabric.flags &= ~FNIC_FDLS_RETRY_FRAME;
+			fdls_send_gpn_ft(iport, iport->fabric.state);
+		} else if (!(iport->fabric.flags & FNIC_FDLS_FABRIC_ABORT_ISSUED)) {
+			/* gpn_ft has timed out. Send abts */
+			fdls_send_fabric_abts(iport);
+		} else {
+			/* ABTS has timed out */
+			fdls_schedule_oxid_free(iport, &iport->active_oxid_fabric_req);
+			if (iport->fabric.retry_counter < FDLS_RETRY_COUNT) {
+				fdls_send_gpn_ft(iport, iport->fabric.state);
+			} else {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "ABTS timeout for fabric GPN_FT. Check name server: %p",
+					 iport);
+			}
+		}
+		break;
+	default:
+		fnic_fdls_start_flogi(iport);	/* Placeholder call */
+		break;
+	}
+	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+}
+
+
+static void fnic_fdls_start_flogi(struct fnic_iport_s *iport)
+{
+	iport->fabric.retry_counter = 0;
+	fdls_send_fabric_flogi(iport);
+	fdls_set_state((&iport->fabric), FDLS_STATE_FABRIC_FLOGI);
+	iport->fabric.flags = 0;
+}
+
+static void fnic_fdls_start_plogi(struct fnic_iport_s *iport)
+{
+	iport->fabric.retry_counter = 0;
+	fdls_send_fabric_plogi(iport);
+	fdls_set_state((&iport->fabric), FDLS_STATE_FABRIC_PLOGI);
+	iport->fabric.flags &= ~FNIC_FDLS_FABRIC_ABORT_ISSUED;
+}
+
+
+static void
+fdls_process_rff_id_rsp(struct fnic_iport_s *iport,
+			struct fc_frame_header *fchdr)
+{
+	struct fnic *fnic = iport->fnic;
+	struct fnic_fdls_fabric_s *fdls = &iport->fabric;
+	struct fc_std_rff_id *rff_rsp = (struct fc_std_rff_id *) fchdr;
+	uint16_t rsp;
+	uint8_t reason_code;
+	uint16_t oxid = FNIC_STD_GET_OX_ID(fchdr);
+
+	if (fdls_get_state(fdls) != FDLS_STATE_REGISTER_FC4_FEATURES) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "RFF_ID resp recvd in state(%d). Dropping.",
+					 fdls_get_state(fdls));
+		return;
+	}
+
+	if (iport->active_oxid_fabric_req != oxid) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			"Incorrect OXID in response. state: %d, oxid recvd: 0x%x, active oxid: 0x%x\n",
+			fdls_get_state(fdls), oxid, iport->active_oxid_fabric_req);
+		return;
+	}
+
+	rsp = FNIC_STD_GET_FC_CT_CMD((&rff_rsp->fc_std_ct_hdr));
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "0x%x: FDLS process RFF ID response: 0x%04x", iport->fcid,
+				 (uint32_t) rsp);
+
+	fdls_free_oxid(iport, oxid, &iport->active_oxid_fabric_req);
+
+	switch (rsp) {
+	case FC_FS_ACC:
+		if (iport->fabric.timer_pending) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "Canceling fabric disc timer %p\n", iport);
+			fnic_del_fabric_timer_sync(fnic);
+		}
+		iport->fabric.timer_pending = 0;
+		fdls->retry_counter = 0;
+		fdls_set_state((&iport->fabric), FDLS_STATE_SCR);
+		fdls_send_scr(iport);
+		break;
+	case FC_FS_RJT:
+		reason_code = rff_rsp->fc_std_ct_hdr.ct_reason;
+		if (((reason_code == FC_FS_RJT_BSY)
+			|| (reason_code == FC_FS_RJT_UNABL))
+			&& (fdls->retry_counter < FDLS_RETRY_COUNT)) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "RFF_ID ret ELS_LS_RJT BUSY. Retry from timer routine %p",
+					 iport);
+
+			/* Retry again from the timer routine */
+			fdls->flags |= FNIC_FDLS_RETRY_FRAME;
+		} else {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "RFF_ID returned ELS_LS_RJT. Halting discovery %p",
+			 iport);
+			if (iport->fabric.timer_pending) {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+							 "Canceling fabric disc timer %p\n", iport);
+				fnic_del_fabric_timer_sync(fnic);
+			}
+			fdls->timer_pending = 0;
+			fdls->retry_counter = 0;
+		}
+		break;
+	default:
+		break;
+	}
+}
+
+static void
+fdls_process_rft_id_rsp(struct fnic_iport_s *iport,
+			struct fc_frame_header *fchdr)
+{
+	struct fnic_fdls_fabric_s *fdls = &iport->fabric;
+	struct fc_std_rft_id *rft_rsp = (struct fc_std_rft_id *) fchdr;
+	uint16_t rsp;
+	uint8_t reason_code;
+	struct fnic *fnic = iport->fnic;
+	uint16_t oxid = FNIC_STD_GET_OX_ID(fchdr);
+
+	if (fdls_get_state(fdls) != FDLS_STATE_REGISTER_FC4_TYPES) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "RFT_ID resp recvd in state(%d). Dropping.",
+					 fdls_get_state(fdls));
+		return;
+	}
+
+	if (iport->active_oxid_fabric_req != oxid) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			"Incorrect OXID in response. state: %d, oxid recvd: 0x%x, active oxid: 0x%x\n",
+			fdls_get_state(fdls), oxid, iport->active_oxid_fabric_req);
+		return;
+	}
+
+
+	rsp = FNIC_STD_GET_FC_CT_CMD((&rft_rsp->fc_std_ct_hdr));
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "0x%x: FDLS process RFT ID response: 0x%04x", iport->fcid,
+				 (uint32_t) rsp);
+
+	fdls_free_oxid(iport, oxid, &iport->active_oxid_fabric_req);
+
+	switch (rsp) {
+	case FC_FS_ACC:
+		if (iport->fabric.timer_pending) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "Canceling fabric disc timer %p\n", iport);
+			fnic_del_fabric_timer_sync(fnic);
+		}
+		iport->fabric.timer_pending = 0;
+		fdls->retry_counter = 0;
+		fdls_send_register_fc4_features(iport);
+		fdls_set_state((&iport->fabric), FDLS_STATE_REGISTER_FC4_FEATURES);
+		break;
+	case FC_FS_RJT:
+		reason_code = rft_rsp->fc_std_ct_hdr.ct_reason;
+		if (((reason_code == FC_FS_RJT_BSY)
+			|| (reason_code == FC_FS_RJT_UNABL))
+			&& (fdls->retry_counter < FDLS_RETRY_COUNT)) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "0x%x: RFT_ID ret ELS_LS_RJT BUSY. Retry from timer routine",
+				 iport->fcid);
+
+			/* Retry again from the timer routine */
+			fdls->flags |= FNIC_FDLS_RETRY_FRAME;
+		} else {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "0x%x: RFT_ID REJ. Halting discovery reason %d expl %d",
+				 iport->fcid, reason_code,
+			 rft_rsp->fc_std_ct_hdr.ct_explan);
+			if (iport->fabric.timer_pending) {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+							 "Canceling fabric disc timer %p\n", iport);
+				fnic_del_fabric_timer_sync(fnic);
+			}
+			fdls->timer_pending = 0;
+			fdls->retry_counter = 0;
+		}
+		break;
+	default:
+		break;
+	}
+}
+
+static void
+fdls_process_rpn_id_rsp(struct fnic_iport_s *iport,
+			struct fc_frame_header *fchdr)
+{
+	struct fnic_fdls_fabric_s *fdls = &iport->fabric;
+	struct fc_std_rpn_id *rpn_rsp = (struct fc_std_rpn_id *) fchdr;
+	uint16_t rsp;
+	uint8_t reason_code;
+	struct fnic *fnic = iport->fnic;
+	uint16_t oxid = FNIC_STD_GET_OX_ID(fchdr);
+
+	if (fdls_get_state(fdls) != FDLS_STATE_RPN_ID) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "RPN_ID resp recvd in state(%d). Dropping.",
+					 fdls_get_state(fdls));
+		return;
+	}
+	if (iport->active_oxid_fabric_req != oxid) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			"Incorrect OXID in response. state: %d, oxid recvd: 0x%x, active oxid: 0x%x\n",
+			fdls_get_state(fdls), oxid, iport->active_oxid_fabric_req);
+		return;
+	}
+
+	rsp = FNIC_STD_GET_FC_CT_CMD((&rpn_rsp->fc_std_ct_hdr));
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "0x%x: FDLS process RPN ID response: 0x%04x", iport->fcid,
+				 (uint32_t) rsp);
+	fdls_free_oxid(iport, oxid, &iport->active_oxid_fabric_req);
+
+	switch (rsp) {
+	case FC_FS_ACC:
+		if (iport->fabric.timer_pending) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "Canceling fabric disc timer %p\n", iport);
+			fnic_del_fabric_timer_sync(fnic);
+		}
+		iport->fabric.timer_pending = 0;
+		fdls->retry_counter = 0;
+		fdls_send_register_fc4_types(iport);
+		fdls_set_state((&iport->fabric), FDLS_STATE_REGISTER_FC4_TYPES);
+		break;
+	case FC_FS_RJT:
+		reason_code = rpn_rsp->fc_std_ct_hdr.ct_reason;
+		if (((reason_code == FC_FS_RJT_BSY)
+			|| (reason_code == FC_FS_RJT_UNABL))
+			&& (fdls->retry_counter < FDLS_RETRY_COUNT)) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "RPN_ID returned REJ BUSY. Retry from timer routine %p",
+					 iport);
+
+			/* Retry again from the timer routine */
+			fdls->flags |= FNIC_FDLS_RETRY_FRAME;
+		} else {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "RPN_ID ELS_LS_RJT. Halting discovery %p", iport);
+			if (iport->fabric.timer_pending) {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+							 "Canceling fabric disc timer %p\n", iport);
+				fnic_del_fabric_timer_sync(fnic);
+			}
+			fdls->timer_pending = 0;
+			fdls->retry_counter = 0;
+		}
+		break;
+	default:
+		break;
+	}
+}
+
+static void
+fdls_process_scr_rsp(struct fnic_iport_s *iport,
+		     struct fc_frame_header *fchdr)
+{
+	struct fnic_fdls_fabric_s *fdls = &iport->fabric;
+	struct fc_std_scr *scr_rsp = (struct fc_std_scr *) fchdr;
+	struct fc_std_els_rjt_rsp *els_rjt = (struct fc_std_els_rjt_rsp *) fchdr;
+	struct fnic *fnic = iport->fnic;
+	uint16_t oxid = FNIC_STD_GET_OX_ID(fchdr);
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "FDLS process SCR response: 0x%04x",
+		 (uint32_t) scr_rsp->scr.scr_cmd);
+
+	if (fdls_get_state(fdls) != FDLS_STATE_SCR) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "SCR resp recvd in state(%d). Dropping.",
+					 fdls_get_state(fdls));
+		return;
+	}
+	if (iport->active_oxid_fabric_req != oxid) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			"Incorrect OXID in response. state: %d, oxid recvd: 0x%x, active oxid: 0x%x\n",
+			fdls_get_state(fdls), oxid, iport->active_oxid_fabric_req);
+	}
+
+	fdls_free_oxid(iport, oxid, &iport->active_oxid_fabric_req);
+
+	switch (scr_rsp->scr.scr_cmd) {
+	case ELS_LS_ACC:
+		if (iport->fabric.timer_pending) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "Canceling fabric disc timer %p\n", iport);
+			fnic_del_fabric_timer_sync(fnic);
+		}
+		iport->fabric.timer_pending = 0;
+		iport->fabric.retry_counter = 0;
+		fdls_send_gpn_ft(iport, FDLS_STATE_GPN_FT);
+		break;
+
+	case ELS_LS_RJT:
+
+		if (((els_rjt->rej.er_reason == ELS_RJT_BUSY)
+	     || (els_rjt->rej.er_reason == ELS_RJT_UNAB))
+			&& (fdls->retry_counter < FDLS_RETRY_COUNT)) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "SCR ELS_LS_RJT BUSY. Retry from timer routine %p",
+						 iport);
+			/* Retry again from the timer routine */
+			fdls->flags |= FNIC_FDLS_RETRY_FRAME;
+		} else {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "SCR returned ELS_LS_RJT. Halting discovery %p",
+						 iport);
+			if (iport->fabric.timer_pending) {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+							 "Canceling fabric disc timer %p\n", iport);
+				fnic_del_fabric_timer_sync(fnic);
+			}
+			fdls->timer_pending = 0;
+			fdls->retry_counter = 0;
+		}
+		break;
+
+	default:
+		break;
+	}
+}
+
+
+
+static void
+fdls_process_gpn_ft_rsp(struct fnic_iport_s *iport,
+			struct fc_frame_header *fchdr, int len)
+{
+	struct fnic_fdls_fabric_s *fdls = &iport->fabric;
+	struct fc_std_gpn_ft *gpn_ft_rsp = (struct fc_std_gpn_ft *) fchdr;
+	uint16_t rsp;
+	uint8_t reason_code;
+	struct fnic *fnic = iport->fnic;
+	uint16_t oxid = FNIC_STD_GET_OX_ID(fchdr);
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "FDLS process GPN_FT response: iport state: %d len: %d",
+				 iport->state, len);
+
+	/*
+	 * GPNFT response :-
+	 *  FDLS_STATE_GPN_FT      : GPNFT send after SCR state
+	 *  during fabric discovery(FNIC_IPORT_STATE_FABRIC_DISC)
+	 *  FDLS_STATE_RSCN_GPN_FT : GPNFT send in response to RSCN
+	 *  FDLS_STATE_SEND_GPNFT  : GPNFT send after deleting a Target,
+	 *  e.g. after receiving Target LOGO
+	 *  FDLS_STATE_TGT_DISCOVERY :Target discovery is currently in progress
+	 *  from previous GPNFT response,a new GPNFT response has come.
+	 */
+	if (!(((iport->state == FNIC_IPORT_STATE_FABRIC_DISC)
+		   && (fdls_get_state(fdls) == FDLS_STATE_GPN_FT))
+		  || ((iport->state == FNIC_IPORT_STATE_READY)
+			  && ((fdls_get_state(fdls) == FDLS_STATE_RSCN_GPN_FT)
+				  || (fdls_get_state(fdls) == FDLS_STATE_SEND_GPNFT)
+				  || (fdls_get_state(fdls) == FDLS_STATE_TGT_DISCOVERY))))) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "GPNFT resp recvd in fab state(%d) iport_state(%d). Dropping.",
+			 fdls_get_state(fdls), iport->state);
+		return;
+	}
+
+	if (iport->active_oxid_fabric_req != oxid) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			"Incorrect OXID in response. state: %d, oxid recvd: 0x%x, active oxid: 0x%x\n",
+			fdls_get_state(fdls), oxid, iport->active_oxid_fabric_req);
+	}
+
+	fdls_free_oxid(iport, oxid, &iport->active_oxid_fabric_req);
+
+	iport->state = FNIC_IPORT_STATE_READY;
+	rsp = FNIC_STD_GET_FC_CT_CMD((&gpn_ft_rsp->fc_std_ct_hdr));
+
+	switch (rsp) {
+
+	case FC_FS_ACC:
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "0x%x: GPNFT_RSP accept", iport->fcid);
+		break;
+
+	case FC_FS_RJT:
+		reason_code = gpn_ft_rsp->fc_std_ct_hdr.ct_reason;
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "0x%x: GPNFT_RSP Reject reason: %d", iport->fcid, reason_code);
+		break;
+
+	default:
+		break;
+	}
+}
+
+/**
+ * fdls_process_fabric_logo_rsp - Handle an flogo response from the fcf
+ * @iport: Handle to fnic iport
+ * @fchdr: Incoming frame
+ */
+static void
+fdls_process_fabric_logo_rsp(struct fnic_iport_s *iport,
+			     struct fc_frame_header *fchdr)
+{
+	struct fc_std_flogi *flogo_rsp = (struct fc_std_flogi *) fchdr;
+	struct fnic_fdls_fabric_s *fdls = &iport->fabric;
+	struct fnic *fnic = iport->fnic;
+	uint16_t oxid = FNIC_STD_GET_OX_ID(fchdr);
+
+	if (iport->active_oxid_fabric_req != oxid) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			"Incorrect OXID in response. state: %d, oxid recvd: 0x%x, active oxid: 0x%x\n",
+			fdls_get_state(fdls), oxid, iport->active_oxid_fabric_req);
+	}
+	fdls_free_oxid(iport, oxid, &iport->active_oxid_fabric_req);
+
+	switch (flogo_rsp->els.fl_cmd) {
+	case ELS_LS_ACC:
+		if (iport->fabric.state != FDLS_STATE_FABRIC_LOGO) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "Flogo response. Fabric not in LOGO state. Dropping! %p",
+				 iport);
+			return;
+		}
+
+		iport->fabric.state = FDLS_STATE_FLOGO_DONE;
+		iport->state = FNIC_IPORT_STATE_LINK_WAIT;
+
+		if (iport->fabric.timer_pending) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "iport 0x%p Canceling fabric disc timer\n",
+						 iport);
+			fnic_del_fabric_timer_sync(fnic);
+		}
+		iport->fabric.timer_pending = 0;
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Flogo response from Fabric for did: 0x%x",
+		     ntoh24(fchdr->fh_d_id));
+		return;
+
+	case ELS_LS_RJT:
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "Flogo response from Fabric for did: 0x%x returned ELS_LS_RJT",
+		     ntoh24(fchdr->fh_d_id));
+		return;
+
+	default:
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "FLOGO response not accepted or rejected: 0x%x",
+		     flogo_rsp->els.fl_cmd);
+	}
+}
+
+static void
+fdls_process_flogi_rsp(struct fnic_iport_s *iport,
+		       struct fc_frame_header *fchdr, void *rx_frame)
+{
+	struct fnic_fdls_fabric_s *fabric = &iport->fabric;
+	struct fc_std_flogi *flogi_rsp = (struct fc_std_flogi *) fchdr;
+	uint8_t *fcid;
+	uint16_t rdf_size;
+	uint8_t fcmac[6] = { 0x0E, 0XFC, 0x00, 0x00, 0x00, 0x00 };
+	struct fnic *fnic = iport->fnic;
+	uint16_t oxid = FNIC_STD_GET_OX_ID(fchdr);
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "0x%x: FDLS processing FLOGI response", iport->fcid);
+
+	if (fdls_get_state(fabric) != FDLS_STATE_FABRIC_FLOGI) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "FLOGI response received in state (%d). Dropping frame",
+					 fdls_get_state(fabric));
+		return;
+	}
+	if (iport->active_oxid_fabric_req != oxid) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			"Incorrect OXID in response. state: %d, oxid recvd: 0x%x, active oxid: 0x%x\n",
+			fdls_get_state(fabric), oxid, iport->active_oxid_fabric_req);
+		return;
+	}
+
+	fdls_free_oxid(iport, oxid, &iport->active_oxid_fabric_req);
+
+	switch (flogi_rsp->els.fl_cmd) {
+	case ELS_LS_ACC:
+		if (iport->fabric.timer_pending) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "iport fcid: 0x%x Canceling fabric disc timer\n",
+						 iport->fcid);
+			fnic_del_fabric_timer_sync(fnic);
+		}
+
+		iport->fabric.timer_pending = 0;
+		iport->fabric.retry_counter = 0;
+		fcid = FNIC_STD_GET_D_ID(fchdr);
+		iport->fcid = ntoh24(fcid);
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "0x%x: FLOGI response accepted", iport->fcid);
+
+		/* Learn the Service Params */
+		rdf_size = be16_to_cpu(FNIC_LOGI_RDF_SIZE(flogi_rsp->els));
+		if ((rdf_size >= FNIC_MIN_DATA_FIELD_SIZE)
+			&& (rdf_size < FNIC_FC_MAX_PAYLOAD_LEN))
+			iport->max_payload_size = min(rdf_size,
+								  iport->max_payload_size);
+
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "max_payload_size from fabric: %u set: %d", rdf_size,
+					 iport->max_payload_size);
+
+		iport->r_a_tov = be32_to_cpu(FNIC_LOGI_R_A_TOV(flogi_rsp->els));
+		iport->e_d_tov = be32_to_cpu(FNIC_LOGI_E_D_TOV(flogi_rsp->els));
+
+		if (FNIC_LOGI_FEATURES(flogi_rsp->els) & FNIC_FC_EDTOV_NSEC)
+			iport->e_d_tov = iport->e_d_tov / FNIC_NSEC_TO_MSEC;
+
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "From fabric: R_A_TOV: %d E_D_TOV: %d",
+					 iport->r_a_tov, iport->e_d_tov);
+
+		if (IS_FNIC_FCP_INITIATOR(fnic)) {
+			fc_host_fabric_name(iport->fnic->lport->host) =
+			get_unaligned_be64(&FNIC_LOGI_NODE_NAME(flogi_rsp->els));
+			fc_host_port_id(iport->fnic->lport->host) = iport->fcid;
+		}
+
+		fnic_fdls_learn_fcoe_macs(iport, rx_frame, fcid);
+
+		memcpy(&fcmac[3], fcid, 3);
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "Adding vNIC device MAC addr: %02x:%02x:%02x:%02x:%02x:%02x",
+			 fcmac[0], fcmac[1], fcmac[2], fcmac[3], fcmac[4],
+			 fcmac[5]);
+		vnic_dev_add_addr(iport->fnic->vdev, fcmac);
+
+		if (fdls_get_state(fabric) == FDLS_STATE_FABRIC_FLOGI) {
+			fnic_fdls_start_plogi(iport);
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "FLOGI response received. Starting PLOGI");
+		} else {
+			/* From FDLS_STATE_FABRIC_FLOGI state fabric can only go to
+			 * FDLS_STATE_LINKDOWN
+			 * state, hence we don't have to worry about undoing:
+			 * the fnic_fdls_register_portid and vnic_dev_add_addr
+			 */
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "FLOGI response received in state (%d). Dropping frame",
+				 fdls_get_state(fabric));
+		}
+		break;
+
+	case ELS_LS_RJT:
+		if (fabric->retry_counter < iport->max_flogi_retries) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "FLOGI returned ELS_LS_RJT BUSY. Retry from timer routine %p",
+				 iport);
+
+			/* Retry Flogi again from the timer routine. */
+			fabric->flags |= FNIC_FDLS_RETRY_FRAME;
+
+		} else {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "FLOGI returned ELS_LS_RJT. Halting discovery %p",
+			 iport);
+			if (iport->fabric.timer_pending) {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+							 "iport 0x%p Canceling fabric disc timer\n",
+							 iport);
+				fnic_del_fabric_timer_sync(fnic);
+			}
+			fabric->timer_pending = 0;
+			fabric->retry_counter = 0;
+		}
+		break;
+
+	default:
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "FLOGI response not accepted: 0x%x",
+		     flogi_rsp->els.fl_cmd);
+		break;
+	}
+}
+
+static void
+fdls_process_fabric_plogi_rsp(struct fnic_iport_s *iport,
+			      struct fc_frame_header *fchdr)
+{
+	struct fc_std_flogi *plogi_rsp = (struct fc_std_flogi *) fchdr;
+	struct fc_std_els_rjt_rsp *els_rjt = (struct fc_std_els_rjt_rsp *) fchdr;
+	struct fnic_fdls_fabric_s *fdls = &iport->fabric;
+	struct fnic *fnic = iport->fnic;
+	uint16_t oxid = FNIC_STD_GET_OX_ID(fchdr);
+
+	if (fdls_get_state((&iport->fabric)) != FDLS_STATE_FABRIC_PLOGI) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "Fabric PLOGI response received in state (%d). Dropping frame",
+			 fdls_get_state(&iport->fabric));
+		return;
+	}
+	if (iport->active_oxid_fabric_req != oxid) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			"Incorrect OXID in response. state: %d, oxid recvd: 0x%x, active oxid: 0x%x\n",
+			fdls_get_state(fdls), oxid, iport->active_oxid_fabric_req);
+		return;
+	}
+	fdls_free_oxid(iport, oxid, &iport->active_oxid_fabric_req);
+
+	switch (plogi_rsp->els.fl_cmd) {
+	case ELS_LS_ACC:
+		if (iport->fabric.timer_pending) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "iport fcid: 0x%x fabric PLOGI response: Accepted\n",
+				 iport->fcid);
+			fnic_del_fabric_timer_sync(fnic);
+		}
+		iport->fabric.timer_pending = 0;
+		iport->fabric.retry_counter = 0;
+		fdls_set_state(&iport->fabric, FDLS_STATE_RPN_ID);
+		fdls_send_rpn_id(iport);
+		break;
+	case ELS_LS_RJT:
+
+		if (((els_rjt->rej.er_reason == ELS_RJT_BUSY)
+	     || (els_rjt->rej.er_reason == ELS_RJT_UNAB))
+			&& (iport->fabric.retry_counter < iport->max_plogi_retries)) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "0x%x: Fabric PLOGI ELS_LS_RJT BUSY. Retry from timer routine",
+				 iport->fcid);
+		} else {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "0x%x: Fabric PLOGI ELS_LS_RJT. Halting discovery",
+				 iport->fcid);
+			if (iport->fabric.timer_pending) {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+							 "iport fcid: 0x%x Canceling fabric disc timer\n",
+							 iport->fcid);
+				fnic_del_fabric_timer_sync(fnic);
+			}
+			iport->fabric.timer_pending = 0;
+			iport->fabric.retry_counter = 0;
+			return;
+		}
+		break;
+	default:
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "PLOGI response not accepted: 0x%x",
+		     plogi_rsp->els.fl_cmd);
+		break;
+	}
+}
+
+static void
+fdls_process_fabric_abts_rsp(struct fnic_iport_s *iport,
+			     struct fc_frame_header *fchdr)
+{
+	uint32_t s_id;
+	struct fc_std_abts_ba_acc *ba_acc = (struct fc_std_abts_ba_acc *)fchdr;
+	struct fc_std_abts_ba_rjt *ba_rjt;
+	uint32_t fabric_state = iport->fabric.state;
+	struct fnic *fnic = iport->fnic;
+	int frame_type;
+	uint16_t oxid;
+
+	s_id = ntoh24(fchdr->fh_s_id);
+	ba_rjt = (struct fc_std_abts_ba_rjt *) fchdr;
+
+	if (!((s_id == FC_FID_DIR_SERV) || (s_id == FC_FID_FLOGI)
+		  || (s_id == FC_FID_FCTRL))) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "Received abts rsp with invalid SID: 0x%x. Dropping frame",
+			 s_id);
+		return;
+	}
+
+	oxid = FNIC_STD_GET_OX_ID(fchdr);
+	if (iport->active_oxid_fabric_req != oxid) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			"Received abts rsp with invalid oxid: 0x%x. Dropping frame",
+			oxid);
+		return;
+	}
+
+	if (iport->fabric.timer_pending) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Canceling fabric disc timer %p\n", iport);
+		fnic_del_fabric_timer_sync(fnic);
+	}
+	iport->fabric.timer_pending = 0;
+	iport->fabric.flags &= ~FNIC_FDLS_FABRIC_ABORT_ISSUED;
+
+	if (fchdr->fh_r_ctl == FC_RCTL_BA_ACC) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "Received abts rsp BA_ACC for fabric_state: %d OX_ID: 0x%x",
+		     fabric_state, be16_to_cpu(ba_acc->acc.ba_ox_id));
+	} else if (fchdr->fh_r_ctl == FC_RCTL_BA_RJT) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "BA_RJT fs: %d OX_ID: 0x%x rc: 0x%x rce: 0x%x",
+		     fabric_state, FNIC_STD_GET_OX_ID(&ba_rjt->fchdr),
+		     ba_rjt->rjt.br_reason, ba_rjt->rjt.br_explan);
+	}
+
+	frame_type = FNIC_FRAME_TYPE(oxid);
+	fdls_free_oxid(iport, oxid, &iport->active_oxid_fabric_req);
+
+	/* currently error handling/retry logic is same for ABTS BA_ACC & BA_RJT */
+	switch (frame_type) {
+	case FNIC_FRAME_TYPE_FABRIC_FLOGI:
+		if (iport->fabric.retry_counter < iport->max_flogi_retries)
+			fdls_send_fabric_flogi(iport);
+		else
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "Exceeded max FLOGI retries");
+		break;
+	case FNIC_FRAME_TYPE_FABRIC_LOGO:
+		if (iport->fabric.retry_counter < FABRIC_LOGO_MAX_RETRY)
+			fdls_send_fabric_logo(iport);
+		break;
+	case FNIC_FRAME_TYPE_FABRIC_PLOGI:
+		if (iport->fabric.retry_counter < iport->max_plogi_retries)
+			fdls_send_fabric_plogi(iport);
+		else
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "Exceeded max PLOGI retries");
+		break;
+	case FNIC_FRAME_TYPE_FABRIC_RPN:
+		if (iport->fabric.retry_counter < FDLS_RETRY_COUNT)
+			fdls_send_rpn_id(iport);
+		else
+			/* go back to fabric Plogi */
+			fnic_fdls_start_plogi(iport);
+		break;
+	case FNIC_FRAME_TYPE_FABRIC_SCR:
+		if (iport->fabric.retry_counter < FDLS_RETRY_COUNT)
+			fdls_send_scr(iport);
+		else {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				"SCR exhausted retries. Start fabric PLOGI %p",
+				 iport);
+			fnic_fdls_start_plogi(iport);	/* go back to fabric Plogi */
+		}
+		break;
+	case FNIC_FRAME_TYPE_FABRIC_RFT:
+		if (iport->fabric.retry_counter < FDLS_RETRY_COUNT)
+			fdls_send_register_fc4_types(iport);
+		else {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				"RFT exhausted retries. Start fabric PLOGI %p",
+				 iport);
+			fnic_fdls_start_plogi(iport);	/* go back to fabric Plogi */
+		}
+		break;
+	case FNIC_FRAME_TYPE_FABRIC_RFF:
+		if (iport->fabric.retry_counter < FDLS_RETRY_COUNT)
+			fdls_send_register_fc4_features(iport);
+		else {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				"RFF exhausted retries. Start fabric PLOGI %p",
+				 iport);
+			fnic_fdls_start_plogi(iport);	/* go back to fabric Plogi */
+		}
+		break;
+	case FNIC_FRAME_TYPE_FABRIC_GPN_FT:
+		if (iport->fabric.retry_counter <= FDLS_RETRY_COUNT)
+			fdls_send_gpn_ft(iport, fabric_state);
+		else
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				"GPN FT exhausted retries. Start fabric PLOGI %p",
+				iport);
+		break;
+	default:
+		/*
+		 * We should not be here since we already validated rx oxid with
+		 * our active_oxid_fabric_req
+		 */
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			"Invalid OXID/active oxid 0x%x\n", oxid);
+		WARN_ON(true);
+		return;
+	}
+}
+
+/*
+ * Performs a validation for all FCOE frames and return the frame type
+ */
+int
+fnic_fdls_validate_and_get_frame_type(struct fnic_iport_s *iport,
+	struct fc_frame_header *fchdr)
+{
+	uint8_t type;
+	uint8_t *fc_payload;
+	uint16_t oxid;
+	uint32_t s_id;
+	uint32_t d_id;
+	struct fnic *fnic = iport->fnic;
+	struct fnic_fdls_fabric_s *fabric = &iport->fabric;
+	int oxid_frame_type;
+
+	oxid = FNIC_STD_GET_OX_ID(fchdr);
+	fc_payload = (uint8_t *) fchdr + sizeof(struct fc_frame_header);
+	type = *fc_payload;
+	s_id = ntoh24(fchdr->fh_s_id);
+	d_id = ntoh24(fchdr->fh_d_id);
+
+	/* some common validation */
+		if (fdls_get_state(fabric) > FDLS_STATE_FABRIC_FLOGI) {
+			if ((iport->fcid != d_id) || (!FNIC_FC_FRAME_CS_CTL(fchdr))) {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+							 "invalid frame received. Dropping frame");
+				return -1;
+			}
+		}
+
+	/*  BLS ABTS response */
+	if ((fchdr->fh_r_ctl == FC_RCTL_BA_ACC)
+	|| (fchdr->fh_r_ctl == FC_RCTL_BA_RJT)) {
+		if (!(FNIC_FC_FRAME_TYPE_BLS(fchdr))) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "Received ABTS invalid frame. Dropping frame");
+			return -1;
+
+		}
+		if (fdls_is_oxid_fabric_req(oxid)) {
+			if (!(iport->fabric.flags & FNIC_FDLS_FABRIC_ABORT_ISSUED)) {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					"Received unexpected ABTS RSP(oxid:0x%x) from 0x%x. Dropping frame",
+					oxid, s_id);
+				return -1;
+	}
+			return FNIC_FABRIC_BLS_ABTS_RSP;
+		} else if (fdls_is_oxid_fdmi_req(oxid)) {
+			return FNIC_FDMI_BLS_ABTS_RSP;
+		} else if (fdls_is_oxid_tgt_req(oxid)) {
+			return FNIC_TPORT_BLS_ABTS_RSP;
+		}
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			"Received ABTS rsp with unknown oxid(0x%x) from 0x%x. Dropping frame",
+			oxid, s_id);
+		return -1;
+	}
+
+	/* BLS ABTS Req */
+	if ((fchdr->fh_r_ctl == FC_RCTL_BA_ABTS)
+	&& (FNIC_FC_FRAME_TYPE_BLS(fchdr))) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Receiving Abort Request from s_id: 0x%x", s_id);
+		return FNIC_BLS_ABTS_REQ;
+	}
+
+	/* unsolicited requests frames */
+	if (FNIC_FC_FRAME_UNSOLICITED(fchdr)) {
+		switch (type) {
+		case ELS_LOGO:
+			if ((!FNIC_FC_FRAME_FCTL_FIRST_LAST_SEQINIT(fchdr))
+				|| (!FNIC_FC_FRAME_UNSOLICITED(fchdr))
+				|| (!FNIC_FC_FRAME_TYPE_ELS(fchdr))) {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+							 "Received LOGO invalid frame. Dropping frame");
+				return -1;
+			}
+			return FNIC_ELS_LOGO_REQ;
+		case ELS_RSCN:
+			if ((!FNIC_FC_FRAME_FCTL_FIRST_LAST_SEQINIT(fchdr))
+				|| (!FNIC_FC_FRAME_TYPE_ELS(fchdr))
+				|| (!FNIC_FC_FRAME_UNSOLICITED(fchdr))) {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "Received RSCN invalid FCTL. Dropping frame");
+				return -1;
+			}
+			if (s_id != FC_FID_FCTRL)
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				     "Received RSCN from target FCTL: 0x%x type: 0x%x s_id: 0x%x.",
+				     fchdr->fh_f_ctl[0], fchdr->fh_type, s_id);
+			return FNIC_ELS_RSCN_REQ;
+		case ELS_PLOGI:
+			return FNIC_ELS_PLOGI_REQ;
+		case ELS_ECHO:
+			return FNIC_ELS_ECHO_REQ;
+		case ELS_ADISC:
+			return FNIC_ELS_ADISC;
+		case ELS_RLS:
+			return FNIC_ELS_RLS;
+		case ELS_RRQ:
+			return FNIC_ELS_RRQ;
+		default:
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "Unsupported frame (type:0x%02x) from fcid: 0x%x",
+				 type, s_id);
+			return FNIC_ELS_UNSUPPORTED_REQ;
+		}
+	}
+
+	/* solicited response from fabric or target */
+	oxid_frame_type = FNIC_FRAME_TYPE(oxid);
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			"oxid frame code: 0x%x, oxid: 0x%x\n", oxid_frame_type, oxid);
+	switch (oxid_frame_type) {
+	case FNIC_FRAME_TYPE_FABRIC_FLOGI:
+		if (type == ELS_LS_ACC) {
+			if ((s_id != FC_FID_FLOGI)
+				|| (!FNIC_FC_FRAME_TYPE_ELS(fchdr))) {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Received unknown frame. Dropping frame");
+				return -1;
+			}
+		}
+		return FNIC_FABRIC_FLOGI_RSP;
+
+	case FNIC_FRAME_TYPE_FABRIC_PLOGI:
+		if (type == ELS_LS_ACC) {
+			if ((s_id != FC_FID_DIR_SERV)
+				|| (!FNIC_FC_FRAME_TYPE_ELS(fchdr))) {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Received unknown frame. Dropping frame");
+				return -1;
+			}
+		}
+		return FNIC_FABRIC_PLOGI_RSP;
+
+	case FNIC_FRAME_TYPE_FABRIC_SCR:
+		if (type == ELS_LS_ACC) {
+			if ((s_id != FC_FID_FCTRL)
+				|| (!FNIC_FC_FRAME_TYPE_ELS(fchdr))) {
+				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Received unknown frame. Dropping frame");
+				return -1;
+			}
+		}
+		return FNIC_FABRIC_SCR_RSP;
+
+	case FNIC_FRAME_TYPE_FABRIC_RPN:
+		if ((s_id != FC_FID_DIR_SERV) || (!FNIC_FC_FRAME_TYPE_FC_GS(fchdr))) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Received unknown frame. Dropping frame");
+			return -1;
+		}
+		return FNIC_FABRIC_RPN_RSP;
+
+	case FNIC_FRAME_TYPE_FABRIC_RFT:
+		if ((s_id != FC_FID_DIR_SERV) || (!FNIC_FC_FRAME_TYPE_FC_GS(fchdr))) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Received unknown frame. Dropping frame");
+			return -1;
+		}
+		return FNIC_FABRIC_RFT_RSP;
+
+	case FNIC_FRAME_TYPE_FABRIC_RFF:
+		if ((s_id != FC_FID_DIR_SERV) || (!FNIC_FC_FRAME_TYPE_FC_GS(fchdr))) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Received unknown frame. Dropping frame");
+			return -1;
+		}
+		return FNIC_FABRIC_RFF_RSP;
+
+	case FNIC_FRAME_TYPE_FABRIC_GPN_FT:
+		if ((s_id != FC_FID_DIR_SERV) || (!FNIC_FC_FRAME_TYPE_FC_GS(fchdr))) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Received unknown frame. Dropping frame");
+			return -1;
+		}
+		return FNIC_FABRIC_GPN_FT_RSP;
+
+	case FNIC_FRAME_TYPE_FABRIC_LOGO:
+		return FNIC_FABRIC_LOGO_RSP;
+	default:
+		/* Drop the Rx frame and log/stats it */
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Solicited response: unknown OXID: 0x%x", oxid);
+		return -1;
+	}
+
+	return -1;
+}
+
+void fnic_fdls_recv_frame(struct fnic_iport_s *iport, void *rx_frame,
+						  int len, int fchdr_offset)
+{
+	struct fc_frame_header *fchdr;
+	uint32_t s_id = 0;
+	uint32_t d_id = 0;
+	struct fnic *fnic = iport->fnic;
+	int frame_type;
+
+	fchdr = (struct fc_frame_header *) ((uint8_t *) rx_frame + fchdr_offset);
+	s_id = ntoh24(fchdr->fh_s_id);
+	d_id = ntoh24(fchdr->fh_d_id);
+
+	fnic_debug_dump_fc_frame(fnic, fchdr, len, "Incoming");
+
+	frame_type =
+		fnic_fdls_validate_and_get_frame_type(iport, fchdr);
+
+	/*if we are in flogo drop everything else */
+	if (iport->fabric.state == FDLS_STATE_FABRIC_LOGO &&
+		frame_type != FNIC_FABRIC_LOGO_RSP)
+		return;
+
+	switch (frame_type) {
+	case FNIC_FABRIC_FLOGI_RSP:
+		fdls_process_flogi_rsp(iport, fchdr, rx_frame);
+		break;
+	case FNIC_FABRIC_PLOGI_RSP:
+		fdls_process_fabric_plogi_rsp(iport, fchdr);
+		break;
+	case FNIC_FABRIC_RPN_RSP:
+		fdls_process_rpn_id_rsp(iport, fchdr);
+		break;
+	case FNIC_FABRIC_RFT_RSP:
+		fdls_process_rft_id_rsp(iport, fchdr);
+		break;
+	case FNIC_FABRIC_RFF_RSP:
+		fdls_process_rff_id_rsp(iport, fchdr);
+		break;
+	case FNIC_FABRIC_SCR_RSP:
+		fdls_process_scr_rsp(iport, fchdr);
+		break;
+	case FNIC_FABRIC_GPN_FT_RSP:
+		fdls_process_gpn_ft_rsp(iport, fchdr, len);
+		break;
+	case FNIC_FABRIC_LOGO_RSP:
+		fdls_process_fabric_logo_rsp(iport, fchdr);
+		break;
+	case FNIC_FABRIC_BLS_ABTS_RSP:
+			fdls_process_fabric_abts_rsp(iport, fchdr);
+		break;
+	default:
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "s_id: 0x%x d_did: 0x%x", s_id, d_id);
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "Received unknown FCoE frame of len: %d. Dropping frame", len);
+		break;
+	}
+}
diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index ce73f08ee889..5e042138dcf1 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -12,6 +12,10 @@
 #include <linux/bitops.h>
 #include <scsi/libfc.h>
 #include <scsi/libfcoe.h>
+#include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_transport.h>
+#include <scsi/scsi_transport_fc.h>
+#include <scsi/fc_frame.h>
 #include "fnic_io.h"
 #include "fnic_res.h"
 #include "fnic_trace.h"
@@ -24,6 +28,7 @@
 #include "vnic_intr.h"
 #include "vnic_stats.h"
 #include "vnic_scsi.h"
+#include "fnic_fdls.h"
 
 #define DRV_NAME		"fnic"
 #define DRV_DESCRIPTION		"Cisco FCoE HBA Driver"
@@ -31,6 +36,7 @@
 #define PFX			DRV_NAME ": "
 #define DFX                     DRV_NAME "%d: "
 
+#define FABRIC_LOGO_MAX_RETRY 3
 #define DESC_CLEAN_LOW_WATERMARK 8
 #define FNIC_UCSM_DFLT_THROTTLE_CNT_BLD	16 /* UCSM default throttle count */
 #define FNIC_MIN_IO_REQ			256 /* Min IO throttle count */
@@ -38,6 +44,7 @@
 #define FNIC_DFLT_IO_REQ        256 /* Default scsi_cmnd tag map entries */
 #define FNIC_DFLT_QUEUE_DEPTH	256
 #define	FNIC_STATS_RATE_LIMIT	4 /* limit rate at which stats are pulled up */
+#define LUN0_DELAY_TIME			9
 
 /*
  * Tag bits used for special requests.
@@ -75,6 +82,8 @@
 #define FNIC_DEV_RST_TERM_DONE          BIT(20)
 #define FNIC_DEV_RST_ABTS_PENDING       BIT(21)
 
+#define IS_FNIC_FCP_INITIATOR(fnic) (fnic->role == FNIC_ROLE_FCP_INITIATOR)
+
 /*
  * fnic private data per SCSI command.
  * These fields are locked by the hashed io_req_lock.
@@ -213,12 +222,26 @@ enum fnic_state {
 
 struct mempool;
 
+enum fnic_role_e {
+	FNIC_ROLE_FCP_INITIATOR = 0,
+};
+
 enum fnic_evt {
 	FNIC_EVT_START_VLAN_DISC = 1,
 	FNIC_EVT_START_FCF_DISC = 2,
 	FNIC_EVT_MAX,
 };
 
+struct fnic_frame_list {
+	/*
+	 * Link to frame lists
+	 */
+	struct list_head links;
+	void *fp;
+	int frame_len;
+	int rx_ethhdr_stripped;
+};
+
 struct fnic_event {
 	struct list_head list;
 	struct fnic *fnic;
@@ -235,6 +258,8 @@ struct fnic_cpy_wq {
 /* Per-instance private data structure */
 struct fnic {
 	int fnic_num;
+	enum fnic_role_e role;
+	struct fnic_iport_s iport;
 	struct fc_lport *lport;
 	struct fcoe_ctlr ctlr;		/* FIP FCoE controller structure */
 	struct vnic_dev_bar bar0;
@@ -278,6 +303,7 @@ struct fnic {
 	unsigned long state_flags;	/* protected by host lock */
 	enum fnic_state state;
 	spinlock_t fnic_lock;
+	unsigned long lock_flags;
 
 	u16 vlan_id;	                /* VLAN tag including priority */
 	u8 data_src_addr[ETH_ALEN];
@@ -307,7 +333,9 @@ struct fnic {
 	struct work_struct frame_work;
 	struct work_struct flush_work;
 	struct sk_buff_head frame_queue;
-	struct sk_buff_head tx_queue;
+	struct list_head tx_queue;
+	mempool_t *frame_pool;
+	mempool_t *frame_elem_pool;
 
 	/*** FIP related data members  -- start ***/
 	void (*set_vlan)(struct fnic *, u16 vlan);
@@ -361,6 +389,9 @@ void fnic_free_wq_buf(struct vnic_wq *wq, struct vnic_wq_buf *buf);
 void fnic_handle_frame(struct work_struct *work);
 void fnic_handle_link(struct work_struct *work);
 void fnic_handle_event(struct work_struct *work);
+void fdls_reclaim_oxid_handler(struct work_struct *work);
+void fdls_schedule_oxid_free(struct fnic_iport_s *iport, uint16_t *active_oxid);
+void fdls_schedule_oxid_free_retry_work(struct work_struct *work);
 int fnic_rq_cmpl_handler(struct fnic *fnic, int);
 int fnic_alloc_rq_frame(struct vnic_rq *rq);
 void fnic_free_rq_buf(struct vnic_rq *rq, struct vnic_rq_buf *buf);
@@ -397,7 +428,6 @@ void fnic_handle_fip_frame(struct work_struct *work);
 void fnic_handle_fip_event(struct fnic *fnic);
 void fnic_fcoe_reset_vlans(struct fnic *fnic);
 void fnic_fcoe_evlist_free(struct fnic *fnic);
-extern void fnic_handle_fip_timer(struct fnic *fnic);
 
 static inline int
 fnic_chk_state_flags_locked(struct fnic *fnic, unsigned long st_flags)
@@ -406,4 +436,74 @@ fnic_chk_state_flags_locked(struct fnic *fnic, unsigned long st_flags)
 }
 void __fnic_set_state_flags(struct fnic *, unsigned long, unsigned long);
 void fnic_dump_fchost_stats(struct Scsi_Host *, struct fc_host_statistics *);
+void fnic_free_txq(struct list_head *head);
+
+struct fnic_scsi_iter_data {
+	struct fnic *fnic;
+	void *data1;
+	void *data2;
+	bool (*fn)(struct fnic *fnic, struct scsi_cmnd *sc,
+			void *data1, void *data2);
+};
+
+static inline bool
+fnic_io_iter_handler(struct scsi_cmnd *sc, void *iter_data)
+{
+	struct fnic_scsi_iter_data *iter = iter_data;
+
+	return iter->fn(iter->fnic, sc, iter->data1, iter->data2);
+}
+
+static inline void
+fnic_scsi_io_iter(struct fnic *fnic,
+		bool (*fn)(struct fnic *fnic, struct scsi_cmnd *sc,
+				void *data1, void *data2),
+		void *data1, void *data2)
+{
+	struct fnic_scsi_iter_data iter_data = {
+		.fn = fn,
+		.fnic = fnic,
+		.data1 = data1,
+		.data2 = data2,
+	};
+	scsi_host_busy_iter(fnic->lport->host, fnic_io_iter_handler, &iter_data);
+}
+
+#ifdef FNIC_DEBUG
+static inline void
+fnic_debug_dump(struct fnic *fnic, uint8_t *u8arr, int len)
+{
+	int i;
+
+	for (i = 0; i < len; i = i+8) {
+		FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+		    "%d: %02x %02x %02x %02x %02x %02x %02x %02x", i / 8,
+		    u8arr[i + 0], u8arr[i + 1], u8arr[i + 2], u8arr[i + 3],
+		    u8arr[i + 4], u8arr[i + 5], u8arr[i + 6], u8arr[i + 7]);
+	}
+}
+
+static inline void
+fnic_debug_dump_fc_frame(struct fnic *fnic, struct fc_frame_header *fchdr,
+				int len, char *pfx)
+{
+	uint32_t s_id, d_id;
+
+	s_id = ntoh24(fchdr->fh_s_id);
+	d_id = ntoh24(fchdr->fh_d_id);
+	FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+		"%s packet contents: sid/did/type/oxid = 0x%x/0x%x/0x%x/0x%x (len = %d)\n",
+		pfx, s_id, d_id, fchdr->fh_type,
+		FNIC_STD_GET_OX_ID(fchdr), len);
+
+	fnic_debug_dump(fnic, (uint8_t *)fchdr, len);
+
+}
+#else /* FNIC_DEBUG */
+static inline void
+fnic_debug_dump(struct fnic *fnic, uint8_t *u8arr, int len) {}
+static inline void
+fnic_debug_dump_fc_frame(struct fnic *fnic, struct fc_frame_header *fchdr,
+				uint32_t len, char *pfx) {}
+#endif /* FNIC_DEBUG */
 #endif /* _FNIC_H_ */
diff --git a/drivers/scsi/fnic/fnic_fcs.c b/drivers/scsi/fnic/fnic_fcs.c
index a08293b2ad9f..6428e3e879cb 100644
--- a/drivers/scsi/fnic/fnic_fcs.c
+++ b/drivers/scsi/fnic/fnic_fcs.c
@@ -17,9 +17,12 @@
 #include <scsi/fc/fc_fcoe.h>
 #include <scsi/fc_frame.h>
 #include <scsi/libfc.h>
+#include <scsi/scsi_transport_fc.h>
 #include "fnic_io.h"
 #include "fnic.h"
 #include "fnic_fip.h"
+#include "fnic_fdls.h"
+#include "fdls_fc.h"
 #include "cq_enet_desc.h"
 #include "cq_exch_desc.h"
 
@@ -28,12 +31,91 @@ struct workqueue_struct *fnic_fip_queue;
 struct workqueue_struct *fnic_event_queue;
 
 static void fnic_set_eth_mode(struct fnic *);
-static void fnic_fcoe_send_vlan_req(struct fnic *fnic);
 static void fnic_fcoe_start_fcf_disc(struct fnic *fnic);
 static void fnic_fcoe_process_vlan_resp(struct fnic *fnic, struct sk_buff *);
 static int fnic_fcoe_vlan_check(struct fnic *fnic, u16 flag);
 static int fnic_fcoe_handle_fip_frame(struct fnic *fnic, struct sk_buff *skb);
 
+static uint8_t FCOE_ALL_FCF_MAC[6] = FC_FCOE_FLOGI_MAC;
+
+/*
+ * Internal Functions
+ * This function will initialize the src_mac address to be
+ * used in outgoing frames
+ */
+static inline void fnic_fdls_set_fcoe_srcmac(struct fnic *fnic,
+							 uint8_t *src_mac)
+{
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "Setting src mac: %02x:%02x:%02x:%02x:%02x:%02x",
+				 src_mac[0], src_mac[1], src_mac[2], src_mac[3],
+				 src_mac[4], src_mac[5]);
+
+	memcpy(fnic->iport.fpma, src_mac, 6);
+}
+
+/*
+ * This function will initialize the dst_mac address to be
+ * used in outgoing frames
+ */
+static inline  void fnic_fdls_set_fcoe_dstmac(struct fnic *fnic,
+							 uint8_t *dst_mac)
+{
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "Setting dst mac: %02x:%02x:%02x:%02x:%02x:%02x",
+				 dst_mac[0], dst_mac[1], dst_mac[2], dst_mac[3],
+				 dst_mac[4], dst_mac[5]);
+
+	memcpy(fnic->iport.fcfmac, dst_mac, 6);
+}
+
+/*
+ * FPMA can be either taken from ethhdr(dst_mac) or flogi resp
+ * or derive from FC_MAP and FCID combination. While it should be
+ * same, revisit this if there is any possibility of not-correct.
+ */
+void fnic_fdls_learn_fcoe_macs(struct fnic_iport_s *iport, void *rx_frame,
+							   uint8_t *fcid)
+{
+	struct fnic *fnic = iport->fnic;
+	struct ethhdr *ethhdr = (struct ethhdr *) rx_frame;
+	uint8_t fcmac[6] = { 0x0E, 0xFC, 0x00, 0x00, 0x00, 0x00 };
+
+	memcpy(&fcmac[3], fcid, 3);
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "learn fcoe: dst_mac: %02x:%02x:%02x:%02x:%02x:%02x",
+				 ethhdr->h_dest[0], ethhdr->h_dest[1],
+				 ethhdr->h_dest[2], ethhdr->h_dest[3],
+				 ethhdr->h_dest[4], ethhdr->h_dest[5]);
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "learn fcoe: fc_mac: %02x:%02x:%02x:%02x:%02x:%02x",
+				 fcmac[0], fcmac[1], fcmac[2], fcmac[3], fcmac[4],
+				 fcmac[5]);
+
+	fnic_fdls_set_fcoe_srcmac(fnic, fcmac);
+	fnic_fdls_set_fcoe_dstmac(fnic, ethhdr->h_source);
+}
+
+void fnic_fdls_init(struct fnic *fnic, int usefip)
+{
+	struct fnic_iport_s *iport = &fnic->iport;
+
+	/* Initialize iPort structure */
+	iport->state = FNIC_IPORT_STATE_INIT;
+	iport->fnic = fnic;
+	iport->usefip = usefip;
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "iportsrcmac: %02x:%02x:%02x:%02x:%02x:%02x",
+				 iport->hwmac[0], iport->hwmac[1], iport->hwmac[2],
+				 iport->hwmac[3], iport->hwmac[4], iport->hwmac[5]);
+
+	INIT_LIST_HEAD(&iport->tport_list);
+	INIT_LIST_HEAD(&iport->tport_list_pending_del);
+}
+
 void fnic_handle_link(struct work_struct *work)
 {
 	struct fnic *fnic = container_of(work, struct fnic, link_work);
@@ -363,7 +445,7 @@ static inline int is_fnic_fip_flogi_reject(struct fcoe_ctlr *fip,
 	return 0;
 }
 
-static void fnic_fcoe_send_vlan_req(struct fnic *fnic)
+void fnic_fcoe_send_vlan_req(struct fnic *fnic)
 {
 	struct fcoe_ctlr *fip = &fnic->ctlr;
 	struct fnic_stats *fnic_stats = &fnic->fnic_stats;
@@ -1068,116 +1150,138 @@ void fnic_eth_send(struct fcoe_ctlr *fip, struct sk_buff *skb)
 /*
  * Send FC frame.
  */
-static int fnic_send_frame(struct fnic *fnic, struct fc_frame *fp)
+static int fnic_send_frame(struct fnic *fnic, void *frame, int frame_len)
 {
 	struct vnic_wq *wq = &fnic->wq[0];
-	struct sk_buff *skb;
 	dma_addr_t pa;
-	struct ethhdr *eth_hdr;
-	struct vlan_ethhdr *vlan_hdr;
-	struct fcoe_hdr *fcoe_hdr;
-	struct fc_frame_header *fh;
-	u32 tot_len, eth_hdr_len;
 	int ret = 0;
 	unsigned long flags;
 
-	fh = fc_frame_header_get(fp);
-	skb = fp_skb(fp);
-
-	if (unlikely(fh->fh_r_ctl == FC_RCTL_ELS_REQ) &&
-	    fcoe_ctlr_els_send(&fnic->ctlr, fnic->lport, skb))
-		return 0;
-
-	if (!fnic->vlan_hw_insert) {
-		eth_hdr_len = sizeof(*vlan_hdr) + sizeof(*fcoe_hdr);
-		vlan_hdr = skb_push(skb, eth_hdr_len);
-		eth_hdr = (struct ethhdr *)vlan_hdr;
-		vlan_hdr->h_vlan_proto = htons(ETH_P_8021Q);
-		vlan_hdr->h_vlan_encapsulated_proto = htons(ETH_P_FCOE);
-		vlan_hdr->h_vlan_TCI = htons(fnic->vlan_id);
-		fcoe_hdr = (struct fcoe_hdr *)(vlan_hdr + 1);
-	} else {
-		eth_hdr_len = sizeof(*eth_hdr) + sizeof(*fcoe_hdr);
-		eth_hdr = skb_push(skb, eth_hdr_len);
-		eth_hdr->h_proto = htons(ETH_P_FCOE);
-		fcoe_hdr = (struct fcoe_hdr *)(eth_hdr + 1);
-	}
-
-	if (fnic->ctlr.map_dest)
-		fc_fcoe_set_mac(eth_hdr->h_dest, fh->fh_d_id);
-	else
-		memcpy(eth_hdr->h_dest, fnic->ctlr.dest_addr, ETH_ALEN);
-	memcpy(eth_hdr->h_source, fnic->data_src_addr, ETH_ALEN);
-
-	tot_len = skb->len;
-	BUG_ON(tot_len % 4);
-
-	memset(fcoe_hdr, 0, sizeof(*fcoe_hdr));
-	fcoe_hdr->fcoe_sof = fr_sof(fp);
-	if (FC_FCOE_VER)
-		FC_FCOE_ENCAPS_VER(fcoe_hdr, FC_FCOE_VER);
-
-	pa = dma_map_single(&fnic->pdev->dev, eth_hdr, tot_len, DMA_TO_DEVICE);
-	if (dma_mapping_error(&fnic->pdev->dev, pa)) {
-		ret = -ENOMEM;
-		printk(KERN_ERR "DMA map failed with error %d\n", ret);
-		goto free_skb_on_err;
-	}
+	pa = dma_map_single(&fnic->pdev->dev, frame, frame_len, DMA_TO_DEVICE);
 
-	if ((fnic_fc_trace_set_data(fnic->lport->host->host_no, FNIC_FC_SEND,
-				(char *)eth_hdr, tot_len)) != 0) {
-		printk(KERN_ERR "fnic ctlr frame trace error!!!");
+	if ((fnic_fc_trace_set_data(fnic->fnic_num,
+				FNIC_FC_SEND | 0x80, (char *) frame,
+				frame_len)) != 0) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "fnic ctlr frame trace error");
 	}
 
 	spin_lock_irqsave(&fnic->wq_lock[0], flags);
 
 	if (!vnic_wq_desc_avail(wq)) {
-		dma_unmap_single(&fnic->pdev->dev, pa, tot_len, DMA_TO_DEVICE);
+		dma_unmap_single(&fnic->pdev->dev, pa, frame_len, DMA_TO_DEVICE);
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "vnic work queue descriptor is not available");
 		ret = -1;
-		goto irq_restore;
+		goto fnic_send_frame_end;
 	}
 
-	fnic_queue_wq_desc(wq, skb, pa, tot_len, fr_eof(fp),
-			   0 /* hw inserts cos value */,
-			   fnic->vlan_id, 1, 1, 1);
+	/* hw inserts cos value */
+	fnic_queue_wq_desc(wq, frame, pa, frame_len, FC_EOF_T,
+					   0, fnic->vlan_id, 1, 1, 1);
 
-irq_restore:
+fnic_send_frame_end:
 	spin_unlock_irqrestore(&fnic->wq_lock[0], flags);
-
-free_skb_on_err:
-	if (ret)
-		dev_kfree_skb_any(fp_skb(fp));
-
 	return ret;
 }
 
-/*
- * fnic_send
- * Routine to send a raw frame
+/**
+ * fdls_send_fcoe_frame - send a filled-in FC frame, filling in eth and FCoE
+ *	info. This interface is used only in the non fast path. (login, fabric
+ *	registrations etc.)
+ *
+ * @fnic:	fnic instance
+ * @frame:	frame structure with FC payload filled in
+ * @frame_size:	length of the frame to be sent
+ * @srcmac:	source mac address
+ * @dstmac:	destination mac address
+ *
+ * Called with the fnic lock held.
  */
-int fnic_send(struct fc_lport *lp, struct fc_frame *fp)
+static int
+fdls_send_fcoe_frame(struct fnic *fnic, void *frame, int frame_size,
+					 uint8_t *srcmac, uint8_t *dstmac)
 {
-	struct fnic *fnic = lport_priv(lp);
-	unsigned long flags;
+	struct ethhdr *pethhdr;
+	struct fcoe_hdr *pfcoe_hdr;
+	struct fnic_frame_list *frame_elem;
+	int len = frame_size;
+	int ret;
+	struct fc_frame_header *fchdr = (struct fc_frame_header *) (frame +
+			FNIC_ETH_FCOE_HDRS_OFFSET);
 
-	if (fnic->in_remove) {
-		dev_kfree_skb(fp_skb(fp));
-		return -1;
-	}
+	pethhdr = (struct ethhdr *) frame;
+	pethhdr->h_proto = cpu_to_be16(ETH_P_FCOE);
+
+	memcpy(pethhdr->h_source, srcmac, ETH_ALEN);
+	memcpy(pethhdr->h_dest, dstmac, ETH_ALEN);
+
+	pfcoe_hdr = (struct fcoe_hdr *) (frame + sizeof(struct ethhdr));
+	pfcoe_hdr->fcoe_sof = FC_SOF_I3;
 
 	/*
 	 * Queue frame if in a transitional state.
 	 * This occurs while registering the Port_ID / MAC address after FLOGI.
 	 */
-	spin_lock_irqsave(&fnic->fnic_lock, flags);
-	if (fnic->state != FNIC_IN_FC_MODE && fnic->state != FNIC_IN_ETH_MODE) {
-		skb_queue_tail(&fnic->tx_queue, fp_skb(fp));
-		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+	if ((fnic->state != FNIC_IN_FC_MODE)
+		&& (fnic->state != FNIC_IN_ETH_MODE)) {
+		frame_elem = mempool_alloc(fnic->frame_elem_pool,
+						GFP_ATOMIC | __GFP_ZERO);
+		if (!frame_elem) {
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "Failed to allocate memory for fnic_frame_list: %lu\n",
+						 sizeof(struct fnic_frame_list));
+			return -ENOMEM;
+		}
+
+		FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+			"Queueing FC frame: sid/did/type/oxid = 0x%x/0x%x/0x%x/0x%x\n",
+			ntoh24(fchdr->fh_s_id), ntoh24(fchdr->fh_d_id),
+			fchdr->fh_type, FNIC_STD_GET_OX_ID(fchdr));
+
+		frame_elem->fp = frame;
+		frame_elem->frame_len = len;
+		list_add_tail(&frame_elem->links, &fnic->tx_queue);
 		return 0;
 	}
-	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 
-	return fnic_send_frame(fnic, fp);
+	fnic_debug_dump_fc_frame(fnic, fchdr, frame_size, "Outgoing");
+
+	ret = fnic_send_frame(fnic, frame, len);
+	return ret;
+}
+
+void fnic_send_fcoe_frame(struct fnic_iport_s *iport, void *frame,
+						 int frame_size)
+{
+	struct fnic *fnic = iport->fnic;
+	uint8_t *dstmac, *srcmac;
+
+	/* If module unload is in-progress, don't send */
+	if (fnic->in_remove)
+		return;
+
+	if (iport->fabric.flags & FNIC_FDLS_FPMA_LEARNT) {
+		srcmac = iport->fpma;
+		dstmac = iport->fcfmac;
+	} else {
+		srcmac = iport->hwmac;
+		dstmac = FCOE_ALL_FCF_MAC;
+	}
+
+	fdls_send_fcoe_frame(fnic, frame, frame_size, srcmac, dstmac);
+}
+
+int
+fnic_send_fip_frame(struct fnic_iport_s *iport, void *frame,
+					int frame_size)
+{
+	struct fnic *fnic = iport->fnic;
+
+	if (fnic->in_remove)
+		return -1;
+
+	return fnic_send_frame(fnic, frame, frame_size);
 }
 
 /**
@@ -1193,15 +1297,67 @@ int fnic_send(struct fc_lport *lp, struct fc_frame *fp)
 void fnic_flush_tx(struct work_struct *work)
 {
 	struct fnic *fnic = container_of(work, struct fnic, flush_work);
-	struct sk_buff *skb;
 	struct fc_frame *fp;
+	struct fnic_frame_list *cur_frame, *next;
 
-	while ((skb = skb_dequeue(&fnic->tx_queue))) {
-		fp = (struct fc_frame *)skb;
-		fnic_send_frame(fnic, fp);
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "Flush queued frames");
+
+	list_for_each_entry_safe(cur_frame, next, &fnic->tx_queue, links) {
+		fp = cur_frame->fp;
+		list_del(&cur_frame->links);
+		fnic_send_frame(fnic, fp, cur_frame->frame_len);
+		mempool_free(cur_frame, fnic->frame_elem_pool);
 	}
 }
 
+int
+fnic_fdls_register_portid(struct fnic_iport_s *iport, u32 port_id,
+						  void *fp)
+{
+	struct fnic *fnic = iport->fnic;
+	struct ethhdr *ethhdr;
+	int ret;
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "Setting port id: 0x%x fp: 0x%p fnic state: %d", port_id,
+				 fp, fnic->state);
+
+	if (fp) {
+		ethhdr = (struct ethhdr *) fp;
+		vnic_dev_add_addr(fnic->vdev, ethhdr->h_dest);
+	}
+
+	/* Change state to reflect transition to FC mode */
+	if (fnic->state == FNIC_IN_ETH_MODE || fnic->state == FNIC_IN_FC_MODE)
+		fnic->state = FNIC_IN_ETH_TRANS_FC_MODE;
+	else {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "Unexpected fnic state while processing FLOGI response\n");
+		return -1;
+	}
+
+	/*
+	 * Send FLOGI registration to firmware to set up FC mode.
+	 * The new address will be set up when registration completes.
+	 */
+	ret = fnic_flogi_reg_handler(fnic, port_id);
+	if (ret < 0) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "FLOGI registration error ret: %d fnic state: %d\n",
+					 ret, fnic->state);
+		if (fnic->state == FNIC_IN_ETH_TRANS_FC_MODE)
+			fnic->state = FNIC_IN_ETH_MODE;
+
+		return -1;
+	}
+	iport->fabric.flags |= FNIC_FDLS_FPMA_LEARNT;
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "FLOGI registration success\n");
+	return 0;
+}
+
 /**
  * fnic_set_eth_mode() - put fnic into ethernet mode.
  * @fnic: fnic device
@@ -1240,6 +1396,17 @@ static void fnic_set_eth_mode(struct fnic *fnic)
 	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 }
 
+void fnic_free_txq(struct list_head *head)
+{
+	struct fnic_frame_list *cur_frame, *next;
+
+	list_for_each_entry_safe(cur_frame, next, head, links) {
+		list_del(&cur_frame->links);
+		kfree(cur_frame->fp);
+		kfree(cur_frame);
+	}
+}
+
 static void fnic_wq_complete_frame_send(struct vnic_wq *wq,
 					struct cq_desc *cq_desc,
 					struct vnic_wq_buf *buf, void *opaque)
@@ -1319,88 +1486,3 @@ void fnic_fcoe_reset_vlans(struct fnic *fnic)
 	spin_unlock_irqrestore(&fnic->vlans_lock, flags);
 }
 
-void fnic_handle_fip_timer(struct fnic *fnic)
-{
-	unsigned long flags;
-	struct fcoe_vlan *vlan;
-	struct fnic_stats *fnic_stats = &fnic->fnic_stats;
-	u64 sol_time;
-
-	spin_lock_irqsave(&fnic->fnic_lock, flags);
-	if (fnic->stop_rx_link_events) {
-		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-		return;
-	}
-	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-
-	if (fnic->ctlr.mode == FIP_MODE_NON_FIP)
-		return;
-
-	spin_lock_irqsave(&fnic->vlans_lock, flags);
-	if (list_empty(&fnic->vlans)) {
-		spin_unlock_irqrestore(&fnic->vlans_lock, flags);
-		/* no vlans available, try again */
-		if (unlikely(fnic_log_level & FNIC_FCS_LOGGING))
-			if (printk_ratelimit())
-				shost_printk(KERN_DEBUG, fnic->lport->host,
-						"Start VLAN Discovery\n");
-		fnic_event_enq(fnic, FNIC_EVT_START_VLAN_DISC);
-		return;
-	}
-
-	vlan = list_first_entry(&fnic->vlans, struct fcoe_vlan, list);
-	FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
-		  "fip_timer: vlan %d state %d sol_count %d\n",
-		  vlan->vid, vlan->state, vlan->sol_count);
-	switch (vlan->state) {
-	case FIP_VLAN_USED:
-		FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
-			  "FIP VLAN is selected for FC transaction\n");
-		spin_unlock_irqrestore(&fnic->vlans_lock, flags);
-		break;
-	case FIP_VLAN_FAILED:
-		spin_unlock_irqrestore(&fnic->vlans_lock, flags);
-		/* if all vlans are in failed state, restart vlan disc */
-		if (unlikely(fnic_log_level & FNIC_FCS_LOGGING))
-			if (printk_ratelimit())
-				shost_printk(KERN_DEBUG, fnic->lport->host,
-					  "Start VLAN Discovery\n");
-		fnic_event_enq(fnic, FNIC_EVT_START_VLAN_DISC);
-		break;
-	case FIP_VLAN_SENT:
-		if (vlan->sol_count >= FCOE_CTLR_MAX_SOL) {
-			/*
-			 * no response on this vlan, remove  from the list.
-			 * Try the next vlan
-			 */
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
-				  "Dequeue this VLAN ID %d from list\n",
-				  vlan->vid);
-			list_del(&vlan->list);
-			kfree(vlan);
-			vlan = NULL;
-			if (list_empty(&fnic->vlans)) {
-				/* we exhausted all vlans, restart vlan disc */
-				spin_unlock_irqrestore(&fnic->vlans_lock,
-							flags);
-				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
-					  "fip_timer: vlan list empty, "
-					  "trigger vlan disc\n");
-				fnic_event_enq(fnic, FNIC_EVT_START_VLAN_DISC);
-				return;
-			}
-			/* check the next vlan */
-			vlan = list_first_entry(&fnic->vlans, struct fcoe_vlan,
-							list);
-			fnic->set_vlan(fnic, vlan->vid);
-			vlan->state = FIP_VLAN_SENT; /* sent now */
-		}
-		spin_unlock_irqrestore(&fnic->vlans_lock, flags);
-		atomic64_inc(&fnic_stats->vlan_stats.sol_expiry_count);
-		vlan->sol_count++;
-		sol_time = jiffies + msecs_to_jiffies
-					(FCOE_CTLR_START_DELAY);
-		mod_timer(&fnic->fip_timer, round_jiffies(sol_time));
-		break;
-	}
-}
diff --git a/drivers/scsi/fnic/fnic_fdls.h b/drivers/scsi/fnic/fnic_fdls.h
index 5d78eea20873..14630b051487 100644
--- a/drivers/scsi/fnic/fnic_fdls.h
+++ b/drivers/scsi/fnic/fnic_fdls.h
@@ -402,7 +402,6 @@ int fnic_send_fip_frame(struct fnic_iport_s *iport,
 	void *frame, int frame_size);
 void fnic_fdls_learn_fcoe_macs(struct fnic_iport_s *iport, void *rx_frame,
 	uint8_t *fcid);
-
 void fnic_fdls_add_tport(struct fnic_iport_s *iport,
 		struct fnic_tport_s *tport, unsigned long flags);
 void fnic_fdls_remove_tport(struct fnic_iport_s *iport,
diff --git a/drivers/scsi/fnic/fnic_io.h b/drivers/scsi/fnic/fnic_io.h
index 5895ead20e14..6fe642cb387b 100644
--- a/drivers/scsi/fnic/fnic_io.h
+++ b/drivers/scsi/fnic/fnic_io.h
@@ -55,15 +55,4 @@ struct fnic_io_req {
 	unsigned int tag;
 	struct scsi_cmnd *sc; /* midlayer's cmd pointer */
 };
-
-enum fnic_port_speeds {
-	DCEM_PORTSPEED_NONE = 0,
-	DCEM_PORTSPEED_1G    = 1000,
-	DCEM_PORTSPEED_10G   = 10000,
-	DCEM_PORTSPEED_20G   = 20000,
-	DCEM_PORTSPEED_25G   = 25000,
-	DCEM_PORTSPEED_40G   = 40000,
-	DCEM_PORTSPEED_4x10G = 41000,
-	DCEM_PORTSPEED_100G  = 100000,
-};
 #endif /* _FNIC_IO_H_ */
diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
index 471a156b074e..f6940ae350cf 100644
--- a/drivers/scsi/fnic/fnic_main.c
+++ b/drivers/scsi/fnic/fnic_main.c
@@ -31,6 +31,8 @@
 #include "fnic_io.h"
 #include "fnic_fip.h"
 #include "fnic.h"
+#include "fnic_fdls.h"
+#include "fdls_fc.h"
 
 #define PCI_DEVICE_ID_CISCO_FNIC	0x0045
 
@@ -39,6 +41,8 @@
 
 static struct kmem_cache *fnic_sgl_cache[FNIC_SGL_NUM_CACHES];
 static struct kmem_cache *fnic_io_req_cache;
+static struct kmem_cache *fdls_frame_cache;
+static struct kmem_cache *fdls_frame_elem_cache;
 static LIST_HEAD(fnic_list);
 static DEFINE_SPINLOCK(fnic_list_lock);
 static DEFINE_IDA(fnic_ida);
@@ -80,7 +84,6 @@ module_param(fnic_max_qdepth, uint, S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(fnic_max_qdepth, "Queue depth to report for each LUN");
 
 static struct libfc_function_template fnic_transport_template = {
-	.frame_send = fnic_send,
 	.lport_set_port_id = fnic_set_port_id,
 	.fcp_abort_io = fnic_empty_scsi_cleanup,
 	.fcp_cleanup = fnic_empty_scsi_cleanup,
@@ -413,7 +416,7 @@ static void fnic_fip_notify_timer(struct timer_list *t)
 {
 	struct fnic *fnic = from_timer(fnic, t, fip_timer);
 
-	fnic_handle_fip_timer(fnic);
+	/* Placeholder function */
 }
 
 static void fnic_notify_timer_start(struct fnic *fnic)
@@ -515,6 +518,8 @@ static int fnic_cleanup(struct fnic *fnic)
 		vnic_intr_clean(&fnic->intr[i]);
 
 	mempool_destroy(fnic->io_req_pool);
+	mempool_destroy(fnic->frame_pool);
+	mempool_destroy(fnic->frame_elem_pool);
 	for (i = 0; i < FNIC_SGL_NUM_CACHES; i++)
 		mempool_destroy(fnic->io_sgl_pool[i]);
 
@@ -787,6 +792,17 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto err_out_free_dflt_pool;
 	fnic->io_sgl_pool[FNIC_SGL_CACHE_MAX] = pool;
 
+	pool = mempool_create_slab_pool(FDLS_MIN_FRAMES, fdls_frame_cache);
+	if (!pool)
+		goto err_out_fdls_frame_pool;
+	fnic->frame_pool = pool;
+
+	pool = mempool_create_slab_pool(FDLS_MIN_FRAME_ELEM,
+						fdls_frame_elem_cache);
+	if (!pool)
+		goto err_out_fdls_frame_elem_pool;
+	fnic->frame_elem_pool = pool;
+
 	/* setup vlan config, hw inserts vlan header */
 	fnic->vlan_hw_insert = 1;
 	fnic->vlan_id = 0;
@@ -921,7 +937,7 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	INIT_WORK(&fnic->frame_work, fnic_handle_frame);
 	INIT_WORK(&fnic->flush_work, fnic_flush_tx);
 	skb_queue_head_init(&fnic->frame_queue);
-	skb_queue_head_init(&fnic->tx_queue);
+	INIT_LIST_HEAD(&fnic->tx_queue);
 
 	fc_fabric_login(lp);
 
@@ -946,6 +962,10 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		vnic_rq_clean(&fnic->rq[i], fnic_free_rq_buf);
 err_out_rq_buf:
 	vnic_dev_notify_unset(fnic->vdev);
+	mempool_destroy(fnic->frame_elem_pool);
+err_out_fdls_frame_elem_pool:
+	mempool_destroy(fnic->frame_pool);
+err_out_fdls_frame_pool:
 err_out_free_max_pool:
 	mempool_destroy(fnic->io_sgl_pool[FNIC_SGL_CACHE_MAX]);
 err_out_free_dflt_pool:
@@ -985,6 +1005,14 @@ static void fnic_remove(struct pci_dev *pdev)
 	unsigned long flags;
 	int hwq;
 
+	/*
+	 * Sometimes when probe() fails and do not exit with an error code,
+	 * remove() gets called with 'drvdata' not set. Avoid a crash by
+	 * adding a defensive check.
+	 */
+	if (!fnic)
+		return;
+
 	/*
 	 * Mark state so that the workqueue thread stops forwarding
 	 * received frames and link events to the local port. ISR and
@@ -1004,7 +1032,7 @@ static void fnic_remove(struct pci_dev *pdev)
 	 */
 	flush_workqueue(fnic_event_queue);
 	skb_queue_purge(&fnic->frame_queue);
-	skb_queue_purge(&fnic->tx_queue);
+	fnic_free_txq(&fnic->tx_queue);
 
 	if (fnic->config.flags & VFCF_FIP_CAPABLE) {
 		del_timer_sync(&fnic->fip_timer);
@@ -1036,7 +1064,6 @@ static void fnic_remove(struct pci_dev *pdev)
 	fnic_cleanup(fnic);
 
 	BUG_ON(!skb_queue_empty(&fnic->frame_queue));
-	BUG_ON(!skb_queue_empty(&fnic->tx_queue));
 
 	spin_lock_irqsave(&fnic_list_lock, flags);
 	list_del(&fnic->list);
@@ -1133,6 +1160,24 @@ static int __init fnic_init_module(void)
 		goto err_create_fnic_ioreq_slab;
 	}
 
+	fdls_frame_cache = kmem_cache_create("fdls_frames",
+					FNIC_FCOE_FRAME_MAXSZ,
+					0, SLAB_HWCACHE_ALIGN, NULL);
+	if (!fdls_frame_cache) {
+		pr_err("fnic fdls frame cache create failed\n");
+		err = -ENOMEM;
+		goto err_create_fdls_frame_cache;
+	}
+
+	fdls_frame_elem_cache = kmem_cache_create("fdls_frame_elem",
+					sizeof(struct fnic_frame_list),
+					0, SLAB_HWCACHE_ALIGN, NULL);
+	if (!fdls_frame_elem_cache) {
+		pr_err("fnic fdls frame elem cache create failed\n");
+		err = -ENOMEM;
+		goto err_create_fdls_frame_cache_elem;
+	}
+
 	fnic_event_queue =
 		alloc_ordered_workqueue("%s", WQ_MEM_RECLAIM, "fnic_event_wq");
 	if (!fnic_event_queue) {
@@ -1171,6 +1216,10 @@ static int __init fnic_init_module(void)
 err_create_fip_workq:
 	destroy_workqueue(fnic_event_queue);
 err_create_fnic_workq:
+	kmem_cache_destroy(fdls_frame_elem_cache);
+err_create_fdls_frame_cache_elem:
+	kmem_cache_destroy(fdls_frame_cache);
+err_create_fdls_frame_cache:
 	kmem_cache_destroy(fnic_io_req_cache);
 err_create_fnic_ioreq_slab:
 	kmem_cache_destroy(fnic_sgl_cache[FNIC_SGL_CACHE_MAX]);
@@ -1192,6 +1241,7 @@ static void __exit fnic_cleanup_module(void)
 	kmem_cache_destroy(fnic_sgl_cache[FNIC_SGL_CACHE_MAX]);
 	kmem_cache_destroy(fnic_sgl_cache[FNIC_SGL_CACHE_DFLT]);
 	kmem_cache_destroy(fnic_io_req_cache);
+	kmem_cache_destroy(fdls_frame_cache);
 	fc_release_transport(fnic_fc_transport);
 	fnic_trace_free();
 	fnic_fc_trace_free();
diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index 2ba61dba4569..295dcda4ec16 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -184,7 +184,7 @@ int fnic_fw_reset_handler(struct fnic *fnic)
 	fnic_set_state_flags(fnic, FNIC_FLAGS_FWRESET);
 
 	skb_queue_purge(&fnic->frame_queue);
-	skb_queue_purge(&fnic->tx_queue);
+	fnic_free_txq(&fnic->tx_queue);
 
 	/* wait for io cmpl */
 	while (atomic_read(&fnic->in_flight))
@@ -674,7 +674,7 @@ static int fnic_fcpio_fw_reset_cmpl_handler(struct fnic *fnic,
 	 */
 	if (fnic->remove_wait || ret) {
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-		skb_queue_purge(&fnic->tx_queue);
+		fnic_free_txq(&fnic->tx_queue);
 		goto reset_cmpl_handler_end;
 	}
 
@@ -1717,7 +1717,7 @@ static bool fnic_rport_abort_io_iter(struct scsi_cmnd *sc, void *data)
 	return true;
 }
 
-static void fnic_rport_exch_reset(struct fnic *fnic, u32 port_id)
+void fnic_rport_exch_reset(struct fnic *fnic, u32 port_id)
 {
 	struct terminate_stats *term_stats = &fnic->fnic_stats.term_stats;
 	struct fnic_rport_abort_io_iter_data iter_data = {
-- 
2.47.0


