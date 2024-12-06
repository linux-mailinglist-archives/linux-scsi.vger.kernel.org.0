Return-Path: <linux-scsi+bounces-10605-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA2D9E7A78
	for <lists+linux-scsi@lfdr.de>; Fri,  6 Dec 2024 22:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4E1B285817
	for <lists+linux-scsi@lfdr.de>; Fri,  6 Dec 2024 21:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70ECF213E67;
	Fri,  6 Dec 2024 21:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Wq5BEGc/"
X-Original-To: linux-scsi@vger.kernel.org
Received: from rcdn-iport-4.cisco.com (rcdn-iport-4.cisco.com [173.37.86.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BF9213E64;
	Fri,  6 Dec 2024 21:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733519680; cv=none; b=WexYvfPuhwAmMML3Y2IC/iIm8LGSHtYsD14AgKUhba8WwKcTlilc+DU9E1wnEOI2TeKVVLKRdLGib+Gm0c6ER8bPhh326gMISkgFpbISLHvppkjC5dEn1gWq/nsXqxj1OaCjjx+g3mNovxXHOT2asf6ay7YYYp+6zn5PtAoHr6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733519680; c=relaxed/simple;
	bh=NNNAEaPEE+aN0Bjj9so7k6mKq7V3szwqY35k/uiUyzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=myjc/9lZKrPZBgyglTjcFNgVU6R89oeqs24eYo1oVUhJy/lZImTyxHpyOkDcVHcrLadToCUJlJw8rKIar6E8upwam5dZ07T1GmMMnCWO1jnE433cr6+HT0BdAreawcg7BR2hveup7iMVruXP9wp4+AqI5r1Zu4mp/yExr+hAjZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=Wq5BEGc/; arc=none smtp.client-ip=173.37.86.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=74891; q=dns/txt;
  s=iport; t=1733519676; x=1734729276;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tUJ+dfKgYq8dgCsYNXlUY9GWfq+p54T+kDN5x9sZTFQ=;
  b=Wq5BEGc/Wk8/5gHid3KCFvu797qIsRZ2K+Ev01/K7D7XXXcSPMgU31mn
   8RCoBSTrUPDKp+V9PTBpgRaJ6c3UCM0qy1w93SCoiOlH85GizUv3ye3I+
   Bx0XGRYhJBQ3bMk81MItDCV2aUoYBvySd6XC6hIlm9/y/Bnz+T8C/l2yb
   g=;
X-CSE-ConnectionGUID: MczmnZK8Q5anbWh5WQFnFg==
X-CSE-MsgGUID: Ku/DkOCLRNW++eFhZXTd+g==
X-IPAS-Result: =?us-ascii?q?A0AnAADjaFNn/4//Ja1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?wcBAQsBghsvdllDGS+McolRgRaQN4xOFIERA1YPAQEBDzkLBAEBhQcCimgCJ?=
 =?us-ascii?q?jQJDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4ThXsNhlsCA?=
 =?us-ascii?q?QMaAQwLAUYQUUURGYIpWAGCZAMRsWaBeTOBAd4zgWcGgUgBjUlwhHcnFQaBS?=
 =?us-ascii?q?USBFAGBO4E3B2+BUoI0JIZdBIM1gyN2JYETh22Bb4VVVoVRHTBGgQ9ZjDdIg?=
 =?us-ascii?q?SEDWSERAVUTDQoLBwWBdgOCTXorgQuBFzqBfoETSoUMRj2CSmlLNwINAjaCJ?=
 =?us-ascii?q?H2CTYUZhGljLwMDAwODPIYlgjRAAwsYDUgRLDcUGwY+bgehRQFGgmdgCwYBA?=
 =?us-ascii?q?RUXBAwNMQkKARMYBBM5BCclLQQsBw8BHQEBCikPApJdBwIBBzGRaoE0iXWVW?=
 =?us-ascii?q?IQkjBeVLRozhASXV452mHuCV4srlVQGGFCEZoFnPIFZMxoIGxU7gmcTPxkPj?=
 =?us-ascii?q?i0WgQwBB4dYuTklMgI6AgcLAQEDCYZLjg5gAQE?=
IronPort-Data: A9a23:70yRDa/vJlrA8Jv07l2IDrUDpn+TJUtcMsCJ2f8bNWPcYEJGY0x3n
 GQeXGzTPKyPYTCneY92bou39EIGu57cz4VjHQRtqHhEQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEDmE4E/rauW5xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4qoyyHjEAX9gWItaDpKs/nrRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dsamR
 /zOxa2O5WjQ+REgELuNyt4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5nXBYoUnq7vh3S9zxHJ
 HqhgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/wmWeG0YAzcmCA2kTNp8d/NRUUVgT/
 PoSFzBQUSmtgcy5lefTpulE3qzPLeHxN48Z/3UlxjbDALN+H9bIQr7B4plT2zJYasJmRKmFI
 ZFGL2AyMVKZP0Yn1lQ/UPrSmM+rj2PjcjlRq3qepLE85C7YywkZPL3FaouOIILWGJQP9qqej
 kHbuEj6JTo+DvqginmI3HKettPD3iyuDer+E5X9rJaGmma7wm8LIBwQSVa/5/K+jyaWWd9dI
 WQQ+ywzve4z/kntRd74NzW9qWSYvxhaQ9dMHvch5QelzbDd6AKUQGMDS1ZpbN0gqd9zRjEw0
 FKNt83mCCYps7CPT3+ZsLCOoluaPSkTMH9HfiQfTCMb7NT55oI+lBTCSpBkCqHdszHuMSv7z
 zbPqG01gK8eyJZVka665lvAxTmro/AlUzII2+keZUr9hisRWWJvT9fABYTzhRqYELukcw==
IronPort-HdrOrdr: A9a23:5bfi3aHtHiS5bFOUpLqEx8eALOsnbusQ8zAXPo5KJSC9Ffbo8/
 xG88506faZslwssTQb6LO90cq7MBbhHPxOgLX5VI3KNGLbUSmTXeNfBODZrAEIdReSysdtkY
 99bqlzD8DxB1Bmgcu/3BO1CL8bsb66GdiT5ds3CxxWPHhXg2YK1XYeNjqm
X-Talos-CUID: 9a23:uIAaUG1hhD9GMNa0gZD/SLxfP8s3d3vv7yfpfka+A1lpFYKsZ1m+9/Yx
X-Talos-MUID: 9a23:SZCphgnoyzMtwaed8eFIdnpBKYBE4IOFLHorrtZFtueEBxxMN3SS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,214,1728950400"; 
   d="scan'208";a="293264592"
Received: from rcdn-l-core-06.cisco.com ([173.37.255.143])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 06 Dec 2024 21:14:33 +0000
Received: from fedora.cisco.com (unknown [10.24.83.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kartilak@cisco.com)
	by rcdn-l-core-06.cisco.com (Postfix) with ESMTPSA id 3F3FA18000263;
	Fri,  6 Dec 2024 21:14:32 +0000 (GMT)
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
Subject: [PATCH v6 08/15] scsi: fnic: Add and integrate support for FIP
Date: Fri,  6 Dec 2024 13:08:45 -0800
Message-ID: <20241206210852.3251-9-kartilak@cisco.com>
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

Add and integrate support for FCoE Initialization
(protocol) FIP. This protocol will be exercised on
Cisco UCS rack servers.
Add support to specifically print FIP related
debug messages.
Replace existing definitions to handle new
data structures.
Clean up old and obsolete definitions.

Reported-by: kernel test robot <lkp@intel.com>
Closes:
https://lore.kernel.org/oe-kbuild-all/202409291955.FcMZfNSt-lkp@
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
    Rebase to 6.14/scsi-queue.
    Incorporate review comments from Martin:
        Remove GCC 13.3 warnings.
    Incorporate review comments from Hannes:
	Allocate OXID from a pool.
	Modify frame initialization.
	Replace headers with standard headers.

Changes between v4 and v5:
    Incorporate review comments from Martin:
        Modify attribution appropriately.
        Remove unnecessary tabs from the bottom of fip.h.

Changes between v3 and v4:
    Fix kernel test robot warnings.

Changes between v2 and v3:
    Incorporate review comments from Hannes:
        Replace redundant definitions with standard definitions.
    Incorporate review comments from John:
        Replace GFP_ATOMIC with GFP_KERNEL where applicable.

Changes between v1 and v2:
    Incorporate review comments from Hannes from other patches:
        Use the correct kernel-doc format.
        Replace htonll() with get_unaligned_be64().
        Replace definitions with standard definitions from
        fc_els.h.
    Incorporate review comments from John:
        Remove unreferenced variable.
        Use standard definitions of true and false.
        Replace if else clauses with switch statement.
        Use kzalloc instead of kmalloc.
---
 drivers/scsi/fnic/Makefile    |   1 +
 drivers/scsi/fnic/fip.c       | 983 ++++++++++++++++++++++++++++++++++
 drivers/scsi/fnic/fip.h       | 157 ++++++
 drivers/scsi/fnic/fnic.h      |  23 +-
 drivers/scsi/fnic/fnic_fcs.c  | 854 +++++------------------------
 drivers/scsi/fnic/fnic_fip.h  |  48 --
 drivers/scsi/fnic/fnic_main.c |  48 +-
 7 files changed, 1290 insertions(+), 824 deletions(-)
 create mode 100644 drivers/scsi/fnic/fip.c
 create mode 100644 drivers/scsi/fnic/fip.h
 delete mode 100644 drivers/scsi/fnic/fnic_fip.h

diff --git a/drivers/scsi/fnic/Makefile b/drivers/scsi/fnic/Makefile
index af156c69da0c..c025e875009e 100644
--- a/drivers/scsi/fnic/Makefile
+++ b/drivers/scsi/fnic/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_FCOE_FNIC) += fnic.o
 
 fnic-y	:= \
+	fip.o\
 	fnic_attrs.o \
 	fnic_isr.o \
 	fnic_main.o \
diff --git a/drivers/scsi/fnic/fip.c b/drivers/scsi/fnic/fip.c
new file mode 100644
index 000000000000..71b5ceff45db
--- /dev/null
+++ b/drivers/scsi/fnic/fip.c
@@ -0,0 +1,983 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2008 Cisco Systems, Inc.  All rights reserved.
+ * Copyright 2007 Nuova Systems, Inc.  All rights reserved.
+ */
+#include "fnic.h"
+#include "fip.h"
+#include <linux/etherdevice.h>
+
+extern struct workqueue_struct *fnic_fip_queue;
+
+#define FIP_FNIC_RESET_WAIT_COUNT 15
+
+/**
+ * fnic_fcoe_reset_vlans - Free up the list of discovered vlans
+ * @fnic: Handle to fnic driver instance
+ */
+void fnic_fcoe_reset_vlans(struct fnic *fnic)
+{
+	unsigned long flags;
+	struct fcoe_vlan *vlan, *next;
+
+	spin_lock_irqsave(&fnic->vlans_lock, flags);
+	if (!list_empty(&fnic->vlan_list)) {
+		list_for_each_entry_safe(vlan, next, &fnic->vlan_list, list) {
+			list_del(&vlan->list);
+			kfree(vlan);
+		}
+	}
+
+	spin_unlock_irqrestore(&fnic->vlans_lock, flags);
+	FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		     "Reset vlan complete\n");
+}
+
+/**
+ * fnic_fcoe_send_vlan_req - Send FIP vlan request to all FCFs MAC
+ * @fnic: Handle to fnic driver instance
+ */
+void fnic_fcoe_send_vlan_req(struct fnic *fnic)
+{
+	uint8_t *frame;
+	struct fnic_iport_s *iport = &fnic->iport;
+	struct fnic_stats *fnic_stats = &fnic->fnic_stats;
+	u64 vlan_tov;
+	struct fip_vlan_req *pvlan_req;
+	uint16_t frame_size = sizeof(struct fip_vlan_req);
+
+	frame = fdls_alloc_frame(iport);
+	if (frame == NULL) {
+		FNIC_FIP_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		     "Failed to allocate frame to send VLAN req");
+		return;
+	}
+
+	fnic_fcoe_reset_vlans(fnic);
+
+	fnic->set_vlan(fnic, 0);
+	FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		     "set vlan done\n");
+
+	FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		     "got MAC 0x%x:%x:%x:%x:%x:%x\n", iport->hwmac[0],
+		     iport->hwmac[1], iport->hwmac[2], iport->hwmac[3],
+		     iport->hwmac[4], iport->hwmac[5]);
+
+	pvlan_req = (struct fip_vlan_req *) frame;
+	*pvlan_req = (struct fip_vlan_req) {
+		.eth = {.h_dest = FCOE_ALL_FCFS_MAC,
+			.h_proto = cpu_to_be16(ETH_P_FIP)},
+		.fip = {.fip_ver = FIP_VER_ENCAPS(FIP_VER),
+			.fip_op = cpu_to_be16(FIP_OP_VLAN),
+			.fip_subcode = FIP_SC_REQ,
+			.fip_dl_len = cpu_to_be16(FIP_VLAN_REQ_LEN)},
+		.mac_desc = {.fd_desc = {.fip_dtype = FIP_DT_MAC,
+						.fip_dlen = 2}}
+	};
+
+	memcpy(pvlan_req->eth.h_source, iport->hwmac, ETH_ALEN);
+	memcpy(pvlan_req->mac_desc.fd_mac, iport->hwmac, ETH_ALEN);
+
+	atomic64_inc(&fnic_stats->vlan_stats.vlan_disc_reqs);
+
+	iport->fip.state = FDLS_FIP_VLAN_DISCOVERY_STARTED;
+
+	FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		     "Send VLAN req\n");
+	fnic_send_fip_frame(iport, frame, frame_size);
+
+	vlan_tov = jiffies + msecs_to_jiffies(FCOE_CTLR_FIPVLAN_TOV);
+	mod_timer(&fnic->retry_fip_timer, round_jiffies(vlan_tov));
+	FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		     "fip timer set\n");
+}
+
+/**
+ * fnic_fcoe_process_vlan_resp - Processes the vlan response from one FCF and
+ * populates VLAN list.
+ * @fnic: Handle to fnic driver instance
+ * @fiph: Received FIP frame
+ *
+ * Will wait for responses from multiple FCFs until timeout.
+ */
+void fnic_fcoe_process_vlan_resp(struct fnic *fnic, struct fip_header *fiph)
+{
+	struct fip_vlan_notif *vlan_notif = (struct fip_vlan_notif *)fiph;
+
+	struct fnic_stats *fnic_stats = &fnic->fnic_stats;
+	u16 vid;
+	int num_vlan = 0;
+	int cur_desc, desc_len;
+	struct fcoe_vlan *vlan;
+	struct fip_vlan_desc *vlan_desc;
+	unsigned long flags;
+
+	FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		     "fnic 0x%p got vlan resp\n", fnic);
+
+	desc_len = be16_to_cpu(vlan_notif->fip.fip_dl_len);
+	FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		     "desc_len %d\n", desc_len);
+
+	spin_lock_irqsave(&fnic->vlans_lock, flags);
+
+	cur_desc = 0;
+	while (desc_len > 0) {
+		vlan_desc =
+		    (struct fip_vlan_desc *)(((char *)vlan_notif->vlans_desc)
+					       + cur_desc * 4);
+
+		if (vlan_desc->fd_desc.fip_dtype == FIP_DT_VLAN) {
+			if (vlan_desc->fd_desc.fip_dlen != 1) {
+				FNIC_FIP_DBG(KERN_INFO, fnic->lport->host,
+					     fnic->fnic_num,
+					     "Invalid descriptor length(%x) in VLan response\n",
+					     vlan_desc->fd_desc.fip_dlen);
+
+			}
+			num_vlan++;
+			vid = be16_to_cpu(vlan_desc->fd_vlan);
+			FNIC_FIP_DBG(KERN_INFO, fnic->lport->host,
+				     fnic->fnic_num,
+				     "process_vlan_resp: FIP VLAN %d\n", vid);
+			vlan = kzalloc(sizeof(*vlan), GFP_KERNEL);
+
+			if (!vlan) {
+				/* retry from timer */
+				FNIC_FIP_DBG(KERN_INFO, fnic->lport->host,
+					     fnic->fnic_num,
+					     "Mem Alloc failure\n");
+				spin_unlock_irqrestore(&fnic->vlans_lock,
+						       flags);
+				goto out;
+			}
+			vlan->vid = vid & 0x0fff;
+			vlan->state = FIP_VLAN_AVAIL;
+			list_add_tail(&vlan->list, &fnic->vlan_list);
+			break;
+		} else {
+			FNIC_FIP_DBG(KERN_INFO, fnic->lport->host,
+				     fnic->fnic_num,
+				     "Invalid descriptor type(%x) in VLan response\n",
+				     vlan_desc->fd_desc.fip_dtype);
+			/*
+			 * Note : received a type=2 descriptor here i.e. FIP
+			 * MAC Address Descriptor
+			 */
+		}
+		cur_desc += vlan_desc->fd_desc.fip_dlen;
+		desc_len -= vlan_desc->fd_desc.fip_dlen;
+	}
+
+	/* any VLAN descriptors present ? */
+	if (num_vlan == 0) {
+		atomic64_inc(&fnic_stats->vlan_stats.resp_withno_vlanID);
+		FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			     "fnic 0x%p No VLAN descriptors in FIP VLAN response\n",
+			     fnic);
+	}
+
+	spin_unlock_irqrestore(&fnic->vlans_lock, flags);
+
+ out:
+	return;
+}
+
+/**
+ * fnic_fcoe_start_fcf_discovery - Start FIP FCF discovery in a selected vlan
+ * @fnic: Handle to fnic driver instance
+ */
+void fnic_fcoe_start_fcf_discovery(struct fnic *fnic)
+{
+	uint8_t *frame;
+	struct fnic_iport_s *iport = &fnic->iport;
+	u64 fcs_tov;
+	struct fip_discovery *pdisc_sol;
+	uint16_t frame_size = sizeof(struct fip_discovery);
+
+	frame = fdls_alloc_frame(iport);
+	if (frame == NULL) {
+		FNIC_FIP_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		     "Failed to allocate frame to start FCF discovery");
+		return;
+	}
+
+	memset(iport->selected_fcf.fcf_mac, 0, ETH_ALEN);
+
+	pdisc_sol = (struct fip_discovery *) frame;
+	*pdisc_sol = (struct fip_discovery) {
+		.eth = {.h_dest = FCOE_ALL_FCFS_MAC,
+			.h_proto = cpu_to_be16(ETH_P_FIP)},
+		.fip = {
+			.fip_ver = FIP_VER_ENCAPS(FIP_VER), .fip_op = cpu_to_be16(FIP_OP_DISC),
+			.fip_subcode = FIP_SC_REQ, .fip_dl_len = cpu_to_be16(FIP_DISC_SOL_LEN),
+			.fip_flags = cpu_to_be16(FIP_FL_FPMA)},
+		.mac_desc = {.fd_desc = {.fip_dtype = FIP_DT_MAC, .fip_dlen = 2}},
+		.name_desc = {.fd_desc = {.fip_dtype = FIP_DT_NAME, .fip_dlen = 3}},
+		.fcoe_desc = {.fd_desc = {.fip_dtype = FIP_DT_FCOE_SIZE, .fip_dlen = 1},
+			      .fd_size = cpu_to_be16(FCOE_MAX_SIZE)}
+	};
+
+	memcpy(pdisc_sol->eth.h_source, iport->hwmac, ETH_ALEN);
+	memcpy(pdisc_sol->mac_desc.fd_mac, iport->hwmac, ETH_ALEN);
+	iport->selected_fcf.fcf_priority = 0xFF;
+
+	FNIC_STD_SET_NODE_NAME(&pdisc_sol->name_desc.fd_wwn, iport->wwnn);
+
+	FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		     "Start FCF discovery\n");
+	fnic_send_fip_frame(iport, frame, frame_size);
+
+	iport->fip.state = FDLS_FIP_FCF_DISCOVERY_STARTED;
+
+	fcs_tov = jiffies + msecs_to_jiffies(FCOE_CTLR_FCS_TOV);
+	mod_timer(&fnic->retry_fip_timer, round_jiffies(fcs_tov));
+}
+
+/**
+ * fnic_fcoe_fip_discovery_resp - Processes FCF advertisements.
+ * @fnic: Handle to fnic driver instance
+ * @fiph: Received frame
+ *
+ * FCF advertisements can be:
+ * solicited - Sent in response of a discover FCF FIP request
+ * Store the information of the FCF with highest priority.
+ * Wait until timeout in case of multiple FCFs.
+ *
+ * unsolicited - Sent periodically by the FCF for keep alive.
+ * If FLOGI is in progress or completed and the advertisement is
+ * received by our selected FCF, refresh the keep alive timer.
+ */
+void fnic_fcoe_fip_discovery_resp(struct fnic *fnic, struct fip_header *fiph)
+{
+	struct fnic_iport_s *iport = &fnic->iport;
+	struct fip_disc_adv *disc_adv = (struct fip_disc_adv *)fiph;
+	u64 fcs_ka_tov;
+	u64 tov;
+	int fka_has_changed;
+
+	switch (iport->fip.state) {
+	case FDLS_FIP_FCF_DISCOVERY_STARTED:
+		if (be16_to_cpu(disc_adv->fip.fip_flags) & FIP_FL_SOL) {
+			FNIC_FIP_DBG(KERN_INFO, fnic->lport->host,
+				     fnic->fnic_num,
+				     "fnic 0x%p Solicited adv\n", fnic);
+
+			if ((disc_adv->prio_desc.fd_pri <
+			     iport->selected_fcf.fcf_priority)
+			    && (be16_to_cpu(disc_adv->fip.fip_flags) & FIP_FL_AVAIL)) {
+
+				FNIC_FIP_DBG(KERN_INFO, fnic->lport->host,
+					     fnic->fnic_num,
+					     "fnic 0x%p FCF Available\n", fnic);
+				memcpy(iport->selected_fcf.fcf_mac,
+				       disc_adv->mac_desc.fd_mac, ETH_ALEN);
+				iport->selected_fcf.fcf_priority =
+				    disc_adv->prio_desc.fd_pri;
+				iport->selected_fcf.fka_adv_period =
+				    be32_to_cpu(disc_adv->fka_adv_desc.fd_fka_period);
+				FNIC_FIP_DBG(KERN_INFO, fnic->lport->host,
+					     fnic->fnic_num, "adv time %d",
+					     iport->selected_fcf.fka_adv_period);
+				iport->selected_fcf.ka_disabled =
+				    (disc_adv->fka_adv_desc.fd_flags & 1);
+			}
+		}
+		break;
+	case FDLS_FIP_FLOGI_STARTED:
+	case FDLS_FIP_FLOGI_COMPLETE:
+		if (!(be16_to_cpu(disc_adv->fip.fip_flags) & FIP_FL_SOL)) {
+			/* same fcf */
+			if (memcmp
+			    (iport->selected_fcf.fcf_mac,
+			     disc_adv->mac_desc.fd_mac, ETH_ALEN) == 0) {
+				if (iport->selected_fcf.fka_adv_period !=
+				    be32_to_cpu(disc_adv->fka_adv_desc.fd_fka_period)) {
+					iport->selected_fcf.fka_adv_period =
+					    be32_to_cpu(disc_adv->fka_adv_desc.fd_fka_period);
+					FNIC_FIP_DBG(KERN_INFO,
+						     fnic->lport->host,
+						     fnic->fnic_num,
+						     "change fka to %d",
+						     iport->selected_fcf.fka_adv_period);
+				}
+
+				fka_has_changed =
+				    (iport->selected_fcf.ka_disabled == 1)
+				    && ((disc_adv->fka_adv_desc.fd_flags & 1) ==
+					0);
+
+				iport->selected_fcf.ka_disabled =
+				    (disc_adv->fka_adv_desc.fd_flags & 1);
+				if (!((iport->selected_fcf.ka_disabled)
+				      || (iport->selected_fcf.fka_adv_period ==
+					  0))) {
+
+					fcs_ka_tov = jiffies
+					    + 3
+					    *
+					    msecs_to_jiffies(iport->selected_fcf.fka_adv_period);
+					mod_timer(&fnic->fcs_ka_timer,
+						  round_jiffies(fcs_ka_tov));
+				} else {
+					if (timer_pending(&fnic->fcs_ka_timer))
+						del_timer_sync(&fnic->fcs_ka_timer);
+				}
+
+				if (fka_has_changed) {
+					if (iport->selected_fcf.fka_adv_period != 0) {
+						tov =
+						 jiffies +
+						 msecs_to_jiffies(
+							 iport->selected_fcf.fka_adv_period);
+						mod_timer(&fnic->enode_ka_timer,
+							  round_jiffies(tov));
+
+						tov =
+						    jiffies +
+						    msecs_to_jiffies
+						    (FIP_VN_KA_PERIOD);
+						mod_timer(&fnic->vn_ka_timer,
+							  round_jiffies(tov));
+					}
+				}
+			}
+		}
+		break;
+	default:
+		break;
+	}			/* end switch */
+}
+
+/**
+ * fnic_fcoe_start_flogi - Send FIP FLOGI to the selected FCF
+ * @fnic: Handle to fnic driver instance
+ */
+void fnic_fcoe_start_flogi(struct fnic *fnic)
+{
+	uint8_t *frame;
+	struct fnic_iport_s *iport = &fnic->iport;
+	struct fip_flogi *pflogi_req;
+	u64 flogi_tov;
+	uint16_t oxid;
+	uint16_t frame_size = sizeof(struct fip_flogi);
+
+	frame = fdls_alloc_frame(iport);
+	if (frame == NULL) {
+		FNIC_FIP_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		     "Failed to allocate frame to start FIP FLOGI");
+		return;
+	}
+
+	pflogi_req = (struct fip_flogi *) frame;
+	*pflogi_req = (struct fip_flogi) {
+		.eth = {
+			.h_proto = cpu_to_be16(ETH_P_FIP)},
+		.fip = {
+			.fip_ver = FIP_VER_ENCAPS(FIP_VER),
+			.fip_op = cpu_to_be16(FIP_OP_LS),
+			.fip_subcode = FIP_SC_REQ,
+			.fip_dl_len = cpu_to_be16(FIP_FLOGI_LEN),
+			.fip_flags = cpu_to_be16(FIP_FL_FPMA)},
+		.flogi_desc = {
+				.fd_desc = {.fip_dtype = FIP_DT_FLOGI, .fip_dlen = 36},
+			       .flogi = {
+					 .fchdr = {
+						   .fh_r_ctl = FC_RCTL_ELS_REQ,
+						   .fh_d_id = {0xFF, 0xFF, 0xFE},
+						   .fh_type = FC_TYPE_ELS,
+						   .fh_f_ctl = {FNIC_ELS_REQ_FCTL, 0, 0},
+						   .fh_rx_id = cpu_to_be16(FNIC_UNASSIGNED_RXID)},
+					 .els = {
+						 .fl_cmd = ELS_FLOGI,
+						 .fl_csp = {
+							    .sp_hi_ver =
+							    FNIC_FC_PH_VER_HI,
+							    .sp_lo_ver =
+							    FNIC_FC_PH_VER_LO,
+							    .sp_bb_cred =
+							    cpu_to_be16
+							    (FNIC_FC_B2B_CREDIT),
+							    .sp_bb_data =
+							    cpu_to_be16
+							    (FNIC_FC_B2B_RDF_SZ)},
+						 .fl_cssp[2].cp_class =
+						 cpu_to_be16(FC_CPC_VALID | FC_CPC_SEQ)
+						},
+					}
+			},
+		.mac_desc = {.fd_desc = {.fip_dtype = FIP_DT_MAC, .fip_dlen = 2}}
+	};
+
+	memcpy(pflogi_req->eth.h_source, iport->hwmac, ETH_ALEN);
+	if (iport->usefip)
+		memcpy(pflogi_req->eth.h_dest, iport->selected_fcf.fcf_mac,
+		       ETH_ALEN);
+
+	oxid = fdls_alloc_oxid(iport, FNIC_FRAME_TYPE_FABRIC_FLOGI,
+		&iport->active_oxid_fabric_req);
+	if (oxid == FNIC_UNASSIGNED_OXID) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		     "Failed to allocate OXID to send FIP FLOGI");
+		mempool_free(frame, fnic->frame_pool);
+		return;
+	}
+	FNIC_STD_SET_OX_ID(pflogi_req->flogi_desc.flogi.fchdr, oxid);
+
+	FNIC_STD_SET_NPORT_NAME(&pflogi_req->flogi_desc.flogi.els.fl_wwpn,
+			iport->wwpn);
+	FNIC_STD_SET_NODE_NAME(&pflogi_req->flogi_desc.flogi.els.fl_wwnn,
+			iport->wwnn);
+
+	FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		     "FIP start FLOGI\n");
+	fnic_send_fip_frame(iport, frame, frame_size);
+	iport->fip.flogi_retry++;
+
+	iport->fip.state = FDLS_FIP_FLOGI_STARTED;
+	flogi_tov = jiffies + msecs_to_jiffies(fnic->config.flogi_timeout);
+	mod_timer(&fnic->retry_fip_timer, round_jiffies(flogi_tov));
+}
+
+/**
+ * fnic_fcoe_process_flogi_resp - Processes FLOGI response from FCF.
+ * @fnic: Handle to fnic driver instance
+ * @fiph: Received frame
+ *
+ * If successful save assigned fc_id and MAC, program firmware
+ * and start fdls discovery, else restart vlan discovery.
+ */
+void fnic_fcoe_process_flogi_resp(struct fnic *fnic, struct fip_header *fiph)
+{
+	struct fnic_iport_s *iport = &fnic->iport;
+	struct fip_flogi_rsp *flogi_rsp = (struct fip_flogi_rsp *)fiph;
+	int desc_len;
+	uint32_t s_id;
+	int frame_type;
+	uint16_t oxid;
+
+	struct fnic_stats *fnic_stats = &fnic->fnic_stats;
+	struct fc_frame_header *fchdr = &flogi_rsp->rsp_desc.flogi.fchdr;
+
+	FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		     "fnic 0x%p FIP FLOGI rsp\n", fnic);
+	desc_len = be16_to_cpu(flogi_rsp->fip.fip_dl_len);
+	if (desc_len != 38) {
+		FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			     "Invalid Descriptor List len (%x). Dropping frame\n",
+			     desc_len);
+		return;
+	}
+
+	if (!((flogi_rsp->rsp_desc.fd_desc.fip_dtype == 7)
+	      && (flogi_rsp->rsp_desc.fd_desc.fip_dlen == 36))
+	    || !((flogi_rsp->mac_desc.fd_desc.fip_dtype == 2)
+		 && (flogi_rsp->mac_desc.fd_desc.fip_dlen == 2))) {
+		FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			     "Dropping frame invalid type and len mix\n");
+		return;
+	}
+
+	frame_type = fnic_fdls_validate_and_get_frame_type(iport, fchdr);
+
+	s_id = ntoh24(fchdr->fh_s_id);
+	if ((fchdr->fh_f_ctl[0] != 0x98)
+	    || (fchdr->fh_r_ctl != 0x23)
+	    || (s_id != FC_FID_FLOGI)
+	    || (frame_type != FNIC_FABRIC_FLOGI_RSP)
+	    || (fchdr->fh_type != 0x01)) {
+		FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			     "Dropping invalid frame: s_id %x F %x R %x t %x OX_ID %x\n",
+			     s_id, fchdr->fh_f_ctl[0], fchdr->fh_r_ctl,
+			     fchdr->fh_type, FNIC_STD_GET_OX_ID(fchdr));
+		return;
+	}
+
+	if (iport->fip.state == FDLS_FIP_FLOGI_STARTED) {
+		FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			     "fnic 0x%p rsp for pending FLOGI\n", fnic);
+
+		oxid = FNIC_STD_GET_OX_ID(fchdr);
+		fdls_free_oxid(iport, oxid, &iport->active_oxid_fabric_req);
+		del_timer_sync(&fnic->retry_fip_timer);
+
+		if ((be16_to_cpu(flogi_rsp->fip.fip_dl_len) == FIP_FLOGI_LEN)
+		    && (flogi_rsp->rsp_desc.flogi.els.fl_cmd == ELS_LS_ACC)) {
+
+			FNIC_FIP_DBG(KERN_INFO, fnic->lport->host,
+				     fnic->fnic_num,
+				     "fnic 0x%p FLOGI success\n", fnic);
+			memcpy(iport->fpma, flogi_rsp->mac_desc.fd_mac, ETH_ALEN);
+			iport->fcid =
+			    ntoh24(flogi_rsp->rsp_desc.flogi.fchdr.fh_d_id);
+
+			iport->r_a_tov =
+			    be32_to_cpu(flogi_rsp->rsp_desc.flogi.els.fl_csp.sp_r_a_tov);
+			iport->e_d_tov =
+			    be32_to_cpu(flogi_rsp->rsp_desc.flogi.els.fl_csp.sp_e_d_tov);
+			memcpy(fnic->iport.fcfmac, iport->selected_fcf.fcf_mac,
+			       ETH_ALEN);
+			vnic_dev_add_addr(fnic->vdev, flogi_rsp->mac_desc.fd_mac);
+
+			if (fnic_fdls_register_portid(iport, iport->fcid, NULL)
+			    != 0) {
+				FNIC_FIP_DBG(KERN_INFO, fnic->lport->host,
+					     fnic->fnic_num,
+					     "fnic 0x%p flogi registration failed\n",
+					     fnic);
+				return;
+			}
+
+			iport->fip.state = FDLS_FIP_FLOGI_COMPLETE;
+			iport->state = FNIC_IPORT_STATE_FABRIC_DISC;
+			FNIC_FIP_DBG(KERN_INFO, fnic->lport->host,
+				     fnic->fnic_num, "iport->state:%d\n",
+				     iport->state);
+			if (!((iport->selected_fcf.ka_disabled)
+			      || (iport->selected_fcf.fka_adv_period == 0))) {
+				u64 tov;
+
+				tov = jiffies
+				    +
+				    msecs_to_jiffies(iport->selected_fcf.fka_adv_period);
+				mod_timer(&fnic->enode_ka_timer,
+					  round_jiffies(tov));
+
+				tov =
+				    jiffies +
+				    msecs_to_jiffies(FIP_VN_KA_PERIOD);
+				mod_timer(&fnic->vn_ka_timer,
+					  round_jiffies(tov));
+
+			}
+		} else {
+			/*
+			 * If there's FLOGI rejects - clear all
+			 * fcf's & restart from scratch
+			 */
+			atomic64_inc(&fnic_stats->vlan_stats.flogi_rejects);
+			/* start FCoE VLAN discovery */
+			fnic_fcoe_send_vlan_req(fnic);
+
+			iport->fip.state = FDLS_FIP_VLAN_DISCOVERY_STARTED;
+		}
+	}
+}
+
+/**
+ * fnic_common_fip_cleanup - Clean up FCF info and timers in case of
+ * link down/CVL
+ * @fnic: Handle to fnic driver instance
+ */
+void fnic_common_fip_cleanup(struct fnic *fnic)
+{
+
+	struct fnic_iport_s *iport = &fnic->iport;
+
+	if (!iport->usefip)
+		return;
+	FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		     "fnic 0x%p fip cleanup\n", fnic);
+
+	iport->fip.state = FDLS_FIP_INIT;
+
+	del_timer_sync(&fnic->retry_fip_timer);
+	del_timer_sync(&fnic->fcs_ka_timer);
+	del_timer_sync(&fnic->enode_ka_timer);
+	del_timer_sync(&fnic->vn_ka_timer);
+
+	if (!is_zero_ether_addr(iport->fpma))
+		vnic_dev_del_addr(fnic->vdev, iport->fpma);
+
+	memset(iport->fpma, 0, ETH_ALEN);
+	iport->fcid = 0;
+	iport->r_a_tov = 0;
+	iport->e_d_tov = 0;
+	memset(fnic->iport.fcfmac, 0, ETH_ALEN);
+	memset(iport->selected_fcf.fcf_mac, 0, ETH_ALEN);
+	iport->selected_fcf.fcf_priority = 0;
+	iport->selected_fcf.fka_adv_period = 0;
+	iport->selected_fcf.ka_disabled = 0;
+
+	fnic_fcoe_reset_vlans(fnic);
+}
+
+/**
+ * fnic_fcoe_process_cvl - Processes Clear Virtual Link from FCF.
+ * @fnic: Handle to fnic driver instance
+ * @fiph: Received frame
+ *
+ * Verify that cvl is received from our current FCF for our assigned MAC
+ * and clean up and restart the vlan discovery.
+ */
+void fnic_fcoe_process_cvl(struct fnic *fnic, struct fip_header *fiph)
+{
+	struct fnic_iport_s *iport = &fnic->iport;
+	struct fip_cvl *cvl_msg = (struct fip_cvl *)fiph;
+	int i;
+	int found = false;
+
+	FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		     "fnic 0x%p clear virtual link handler\n", fnic);
+
+	if (!((cvl_msg->fcf_mac_desc.fd_desc.fip_dtype == 2)
+	      && (cvl_msg->fcf_mac_desc.fd_desc.fip_dlen == 2))
+	    || !((cvl_msg->name_desc.fd_desc.fip_dtype == 4)
+		 && (cvl_msg->name_desc.fd_desc.fip_dlen == 3))) {
+
+		FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			     "invalid mix: ft %x fl %x ndt %x ndl %x",
+			     cvl_msg->fcf_mac_desc.fd_desc.fip_dtype,
+			     cvl_msg->fcf_mac_desc.fd_desc.fip_dlen,
+				 cvl_msg->name_desc.fd_desc.fip_dtype,
+			     cvl_msg->name_desc.fd_desc.fip_dlen);
+	}
+
+	if (memcmp
+	    (iport->selected_fcf.fcf_mac, cvl_msg->fcf_mac_desc.fd_mac, ETH_ALEN)
+	    == 0) {
+		for (i = 0; i < ((be16_to_cpu(fiph->fip_dl_len) / 5) - 1); i++) {
+			if (!((cvl_msg->vn_ports_desc[i].fd_desc.fip_dtype == 11)
+			      && (cvl_msg->vn_ports_desc[i].fd_desc.fip_dlen == 5))) {
+
+				FNIC_FIP_DBG(KERN_INFO, fnic->lport->host,
+					     fnic->fnic_num,
+					     "Invalid type and len mix type: %d len: %d\n",
+					     cvl_msg->vn_ports_desc[i].fd_desc.fip_dtype,
+					     cvl_msg->vn_ports_desc[i].fd_desc.fip_dlen);
+			}
+			if (memcmp
+			    (iport->fpma, cvl_msg->vn_ports_desc[i].fd_mac,
+			     ETH_ALEN) == 0) {
+				found = true;
+				break;
+			}
+		}
+		if (!found)
+			return;
+		fnic_common_fip_cleanup(fnic);
+
+		fnic_fcoe_send_vlan_req(fnic);
+	}
+}
+
+/**
+ * fdls_fip_recv_frame - Demultiplexer for FIP frames
+ * @fnic: Handle to fnic driver instance
+ * @frame: Received ethernet frame
+ */
+int fdls_fip_recv_frame(struct fnic *fnic, void *frame)
+{
+	struct ethhdr *eth = (struct ethhdr *)frame;
+	struct fip_header *fiph;
+	u16 op;
+	u8 sub;
+	int len = 2048;
+
+	if (be16_to_cpu(eth->h_proto) == ETH_P_FIP) {
+		fiph = (struct fip_header *)(eth + 1);
+		op = be16_to_cpu(fiph->fip_op);
+		sub = fiph->fip_subcode;
+
+		fnic_debug_dump_fip_frame(fnic, eth, len, "Incoming");
+
+		if (op == FIP_OP_DISC && sub == FIP_SC_REP)
+			fnic_fcoe_fip_discovery_resp(fnic, fiph);
+		else if (op == FIP_OP_VLAN && sub == FIP_SC_REP)
+			fnic_fcoe_process_vlan_resp(fnic, fiph);
+		else if (op == FIP_OP_CTRL && sub == FIP_SC_REP)
+			fnic_fcoe_process_cvl(fnic, fiph);
+		else if (op == FIP_OP_LS && sub == FIP_SC_REP)
+			fnic_fcoe_process_flogi_resp(fnic, fiph);
+
+		/* Return true if the frame was a FIP frame */
+		return true;
+	}
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		"Not a FIP Frame");
+	return false;
+}
+
+void fnic_work_on_fip_timer(struct work_struct *work)
+{
+	struct fnic *fnic = container_of(work, struct fnic, fip_timer_work);
+	struct fnic_iport_s *iport = &fnic->iport;
+
+	FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		     "FIP timeout\n");
+
+	if (iport->fip.state == FDLS_FIP_VLAN_DISCOVERY_STARTED) {
+		fnic_vlan_discovery_timeout(fnic);
+	} else if (iport->fip.state == FDLS_FIP_FCF_DISCOVERY_STARTED) {
+		u8 zmac[ETH_ALEN] = { 0, 0, 0, 0, 0, 0 };
+
+		FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			     "FCF Discovery timeout\n");
+		if (memcmp(iport->selected_fcf.fcf_mac, zmac, ETH_ALEN) != 0) {
+
+			if (iport->flags & FNIC_FIRST_LINK_UP)
+				iport->flags &= ~FNIC_FIRST_LINK_UP;
+
+			fnic_fcoe_start_flogi(fnic);
+			if (!((iport->selected_fcf.ka_disabled)
+			      || (iport->selected_fcf.fka_adv_period == 0))) {
+				u64 fcf_tov;
+
+				fcf_tov = jiffies
+				    + 3
+				    *
+				    msecs_to_jiffies(iport->selected_fcf.fka_adv_period);
+				mod_timer(&fnic->fcs_ka_timer,
+					  round_jiffies(fcf_tov));
+			}
+		} else {
+			FNIC_FIP_DBG(KERN_INFO, fnic->lport->host,
+				     fnic->fnic_num, "FCF Discovery timeout\n");
+			fnic_vlan_discovery_timeout(fnic);
+		}
+	} else if (iport->fip.state == FDLS_FIP_FLOGI_STARTED) {
+		fdls_schedule_oxid_free(iport, &iport->active_oxid_fabric_req);
+		FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			     "FLOGI timeout\n");
+		if (iport->fip.flogi_retry < fnic->config.flogi_retries)
+			fnic_fcoe_start_flogi(fnic);
+		else
+			fnic_vlan_discovery_timeout(fnic);
+	}
+}
+
+/**
+ * fnic_handle_fip_timer - Timeout handler for FIP discover phase.
+ * @t: Handle to the timer list
+ *
+ * Based on the current state, start next phase or restart discovery.
+ */
+void fnic_handle_fip_timer(struct timer_list *t)
+{
+	struct fnic *fnic = from_timer(fnic, t, retry_fip_timer);
+
+	INIT_WORK(&fnic->fip_timer_work, fnic_work_on_fip_timer);
+	queue_work(fnic_fip_queue, &fnic->fip_timer_work);
+}
+
+/**
+ * fnic_handle_enode_ka_timer - FIP node keep alive.
+ * @t: Handle to the timer list
+ */
+void fnic_handle_enode_ka_timer(struct timer_list *t)
+{
+	uint8_t *frame;
+	struct fnic *fnic = from_timer(fnic, t, enode_ka_timer);
+
+	struct fnic_iport_s *iport = &fnic->iport;
+	struct fip_enode_ka *penode_ka;
+	u64 enode_ka_tov;
+	uint16_t frame_size = sizeof(struct fip_enode_ka);
+
+	if (iport->fip.state != FDLS_FIP_FLOGI_COMPLETE)
+		return;
+
+	if ((iport->selected_fcf.ka_disabled)
+	    || (iport->selected_fcf.fka_adv_period == 0)) {
+		return;
+	}
+
+	frame = fdls_alloc_frame(iport);
+	if (frame == NULL) {
+		FNIC_FIP_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		     "Failed to allocate frame to send enode ka");
+		return;
+	}
+
+	penode_ka = (struct fip_enode_ka *) frame;
+	*penode_ka = (struct fip_enode_ka) {
+		.eth = {
+			.h_proto = cpu_to_be16(ETH_P_FIP)},
+		.fip = {
+			.fip_ver = FIP_VER_ENCAPS(FIP_VER),
+			.fip_op = cpu_to_be16(FIP_OP_CTRL),
+			.fip_subcode = FIP_SC_REQ,
+			.fip_dl_len = cpu_to_be16(FIP_ENODE_KA_LEN)},
+		.mac_desc = {.fd_desc = {.fip_dtype = FIP_DT_MAC, .fip_dlen = 2}}
+	};
+
+	memcpy(penode_ka->eth.h_source, iport->hwmac, ETH_ALEN);
+	memcpy(penode_ka->eth.h_dest, iport->selected_fcf.fcf_mac, ETH_ALEN);
+	memcpy(penode_ka->mac_desc.fd_mac, iport->hwmac, ETH_ALEN);
+
+	FNIC_FIP_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+		     "Handle enode KA timer\n");
+	fnic_send_fip_frame(iport, frame, frame_size);
+	enode_ka_tov = jiffies
+	    + msecs_to_jiffies(iport->selected_fcf.fka_adv_period);
+	mod_timer(&fnic->enode_ka_timer, round_jiffies(enode_ka_tov));
+}
+
+/**
+ * fnic_handle_vn_ka_timer - FIP virtual port keep alive.
+ * @t: Handle to the timer list
+ */
+void fnic_handle_vn_ka_timer(struct timer_list *t)
+{
+	uint8_t *frame;
+	struct fnic *fnic = from_timer(fnic, t, vn_ka_timer);
+
+	struct fnic_iport_s *iport = &fnic->iport;
+	struct fip_vn_port_ka *pvn_port_ka;
+	u64 vn_ka_tov;
+	uint8_t fcid[3];
+	uint16_t frame_size = sizeof(struct fip_vn_port_ka);
+
+	if (iport->fip.state != FDLS_FIP_FLOGI_COMPLETE)
+		return;
+
+	if ((iport->selected_fcf.ka_disabled)
+	    || (iport->selected_fcf.fka_adv_period == 0)) {
+		return;
+	}
+
+	frame = fdls_alloc_frame(iport);
+	if (frame == NULL) {
+		FNIC_FIP_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		     "Failed to allocate frame to send vn ka");
+		return;
+	}
+
+	pvn_port_ka = (struct fip_vn_port_ka *) frame;
+	*pvn_port_ka = (struct fip_vn_port_ka) {
+		.eth = {
+			.h_proto = cpu_to_be16(ETH_P_FIP)},
+		.fip = {
+			.fip_ver = FIP_VER_ENCAPS(FIP_VER),
+			.fip_op = cpu_to_be16(FIP_OP_CTRL),
+			.fip_subcode = FIP_SC_REQ,
+			.fip_dl_len = cpu_to_be16(FIP_VN_KA_LEN)},
+		.mac_desc = {.fd_desc = {.fip_dtype = FIP_DT_MAC, .fip_dlen = 2}},
+		.vn_port_desc = {.fd_desc = {.fip_dtype = FIP_DT_VN_ID, .fip_dlen = 5}}
+	};
+
+	memcpy(pvn_port_ka->eth.h_source, iport->fpma, ETH_ALEN);
+	memcpy(pvn_port_ka->eth.h_dest, iport->selected_fcf.fcf_mac, ETH_ALEN);
+	memcpy(pvn_port_ka->mac_desc.fd_mac, iport->hwmac, ETH_ALEN);
+	memcpy(pvn_port_ka->vn_port_desc.fd_mac, iport->fpma, ETH_ALEN);
+	hton24(fcid, iport->fcid);
+	memcpy(pvn_port_ka->vn_port_desc.fd_fc_id, fcid, 3);
+	FNIC_STD_SET_NPORT_NAME(&pvn_port_ka->vn_port_desc.fd_wwpn, iport->wwpn);
+
+	FNIC_FIP_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+		     "Handle vnport KA timer\n");
+	fnic_send_fip_frame(iport, frame, frame_size);
+	vn_ka_tov = jiffies + msecs_to_jiffies(FIP_VN_KA_PERIOD);
+	mod_timer(&fnic->vn_ka_timer, round_jiffies(vn_ka_tov));
+}
+
+/**
+ * fnic_vlan_discovery_timeout - Handle vlan discovery timeout
+ * @fnic: Handle to fnic driver instance
+ *
+ * End of VLAN discovery or FCF discovery time window.
+ * Start the FCF discovery if VLAN was never used.
+ */
+void fnic_vlan_discovery_timeout(struct fnic *fnic)
+{
+	struct fcoe_vlan *vlan;
+	struct fnic_iport_s *iport = &fnic->iport;
+	struct fnic_stats *fnic_stats = &fnic->fnic_stats;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fnic->fnic_lock, flags);
+	if (fnic->stop_rx_link_events) {
+		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+		return;
+	}
+	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+
+	if (!iport->usefip)
+		return;
+
+	spin_lock_irqsave(&fnic->vlans_lock, flags);
+	if (list_empty(&fnic->vlan_list)) {
+		/* no vlans available, try again */
+		spin_unlock_irqrestore(&fnic->vlans_lock, flags);
+		fnic_fcoe_send_vlan_req(fnic);
+		return;
+	}
+
+	vlan = list_first_entry(&fnic->vlan_list, struct fcoe_vlan, list);
+
+	if (vlan->state == FIP_VLAN_SENT) {
+		if (vlan->sol_count >= FCOE_CTLR_MAX_SOL) {
+			/*
+			 * no response on this vlan, remove  from the list.
+			 * Try the next vlan
+			 */
+			list_del(&vlan->list);
+			kfree(vlan);
+			vlan = NULL;
+			if (list_empty(&fnic->vlan_list)) {
+				/* we exhausted all vlans, restart vlan disc */
+				spin_unlock_irqrestore(&fnic->vlans_lock,
+						       flags);
+				fnic_fcoe_send_vlan_req(fnic);
+				return;
+			}
+			/* check the next vlan */
+			vlan =
+			    list_first_entry(&fnic->vlan_list, struct fcoe_vlan,
+					     list);
+
+			fnic->set_vlan(fnic, vlan->vid);
+			vlan->state = FIP_VLAN_SENT;	/* sent now */
+
+		}
+		atomic64_inc(&fnic_stats->vlan_stats.sol_expiry_count);
+
+	} else {
+		fnic->set_vlan(fnic, vlan->vid);
+		vlan->state = FIP_VLAN_SENT;	/* sent now */
+	}
+	vlan->sol_count++;
+	spin_unlock_irqrestore(&fnic->vlans_lock, flags);
+	fnic_fcoe_start_fcf_discovery(fnic);
+}
+
+/**
+ * fnic_work_on_fcs_ka_timer - Handle work on FCS keep alive timer.
+ * @work: the work queue to be serviced
+ *
+ * Finish handling fcs_ka_timer in process context.
+ * Clean up, bring the link down, and restart all FIP discovery.
+ */
+void fnic_work_on_fcs_ka_timer(struct work_struct *work)
+{
+	struct fnic
+	*fnic = container_of(work, struct fnic, fip_timer_work);
+	struct fnic_iport_s *iport = &fnic->iport;
+
+	FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		     "fnic 0x%p fcs ka timeout\n", fnic);
+
+	fnic_common_fip_cleanup(fnic);
+	spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
+	iport->state = FNIC_IPORT_STATE_FIP;
+	spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
+
+	fnic_fcoe_send_vlan_req(fnic);
+}
+
+/**
+ * fnic_handle_fcs_ka_timer - Handle FCS keep alive timer.
+ * @t: Handle to the timer list
+ *
+ * No keep alives received from FCF. Clean up, bring the link down
+ * and restart all the FIP discovery.
+ */
+void fnic_handle_fcs_ka_timer(struct timer_list *t)
+{
+	struct fnic *fnic = from_timer(fnic, t, fcs_ka_timer);
+
+	INIT_WORK(&fnic->fip_timer_work, fnic_work_on_fcs_ka_timer);
+	queue_work(fnic_fip_queue, &fnic->fip_timer_work);
+}
diff --git a/drivers/scsi/fnic/fip.h b/drivers/scsi/fnic/fip.h
new file mode 100644
index 000000000000..be727ac19af6
--- /dev/null
+++ b/drivers/scsi/fnic/fip.h
@@ -0,0 +1,157 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2008 Cisco Systems, Inc.  All rights reserved.
+ * Copyright 2007 Nuova Systems, Inc.  All rights reserved.
+ */
+#ifndef _FIP_H_
+#define _FIP_H_
+
+#include "fdls_fc.h"
+#include "fnic_fdls.h"
+#include <scsi/fc/fc_fip.h>
+
+/* Drop the cast from the standard definition */
+#define FCOE_ALL_FCFS_MAC {0x01, 0x10, 0x18, 0x01, 0x00, 0x02}
+#define FCOE_MAX_SIZE 0x082E
+
+#define FCOE_CTLR_FIPVLAN_TOV (3*1000)
+#define FCOE_CTLR_FCS_TOV     (3*1000)
+#define FCOE_CTLR_MAX_SOL      (5*1000)
+
+#define FIP_DISC_SOL_LEN (6)
+#define FIP_VLAN_REQ_LEN (2)
+#define FIP_ENODE_KA_LEN (2)
+#define FIP_VN_KA_LEN (7)
+#define FIP_FLOGI_LEN (38)
+
+enum fdls_vlan_state {
+	FIP_VLAN_AVAIL,
+	FIP_VLAN_SENT
+};
+
+enum fdls_fip_state {
+	FDLS_FIP_INIT,
+	FDLS_FIP_VLAN_DISCOVERY_STARTED,
+	FDLS_FIP_FCF_DISCOVERY_STARTED,
+	FDLS_FIP_FLOGI_STARTED,
+	FDLS_FIP_FLOGI_COMPLETE,
+};
+
+/*
+ * VLAN entry.
+ */
+struct fcoe_vlan {
+	struct list_head list;
+	uint16_t vid;		/* vlan ID */
+	uint16_t sol_count;	/* no. of sols sent */
+	uint16_t state;		/* state */
+};
+
+struct fip_vlan_req {
+	struct ethhdr eth;
+	struct fip_header fip;
+	struct fip_mac_desc mac_desc;
+} __packed;
+
+struct fip_vlan_notif {
+	struct fip_header fip;
+	struct fip_vlan_desc vlans_desc[];
+} __packed;
+
+struct fip_vn_port_ka {
+	struct ethhdr eth;
+	struct fip_header fip;
+	struct fip_mac_desc mac_desc;
+	struct fip_vn_desc vn_port_desc;
+} __packed;
+
+struct fip_enode_ka {
+	struct ethhdr eth;
+	struct fip_header fip;
+	struct fip_mac_desc mac_desc;
+} __packed;
+
+struct fip_cvl {
+	struct fip_header fip;
+	struct fip_mac_desc fcf_mac_desc;
+	struct fip_wwn_desc name_desc;
+	struct fip_vn_desc vn_ports_desc[];
+} __packed;
+
+struct fip_flogi_desc {
+	struct fip_desc fd_desc;
+	uint16_t rsvd;
+	struct fc_std_flogi flogi;
+} __packed;
+
+struct fip_flogi_rsp_desc {
+	struct fip_desc fd_desc;
+	uint16_t rsvd;
+	struct fc_std_flogi flogi;
+} __packed;
+
+struct fip_flogi {
+	struct ethhdr eth;
+	struct fip_header fip;
+	struct fip_flogi_desc flogi_desc;
+	struct fip_mac_desc mac_desc;
+} __packed;
+
+struct fip_flogi_rsp {
+	struct fip_header fip;
+	struct fip_flogi_rsp_desc rsp_desc;
+	struct fip_mac_desc mac_desc;
+} __packed;
+
+struct fip_discovery {
+	struct ethhdr eth;
+	struct fip_header fip;
+	struct fip_mac_desc mac_desc;
+	struct fip_wwn_desc name_desc;
+	struct fip_size_desc fcoe_desc;
+} __packed;
+
+struct fip_disc_adv {
+	struct fip_header fip;
+	struct fip_pri_desc prio_desc;
+	struct fip_mac_desc mac_desc;
+	struct fip_wwn_desc name_desc;
+	struct fip_fab_desc fabric_desc;
+	struct fip_fka_desc fka_adv_desc;
+} __packed;
+
+void fnic_fcoe_process_vlan_resp(struct fnic *fnic, struct fip_header *fiph);
+void fnic_fcoe_fip_discovery_resp(struct fnic *fnic, struct fip_header *fiph);
+void fnic_fcoe_process_flogi_resp(struct fnic *fnic, struct fip_header *fiph);
+void fnic_work_on_fip_timer(struct work_struct *work);
+void fnic_work_on_fcs_ka_timer(struct work_struct *work);
+void fnic_fcoe_send_vlan_req(struct fnic *fnic);
+void fnic_fcoe_start_fcf_discovery(struct fnic *fnic);
+void fnic_fcoe_start_flogi(struct fnic *fnic);
+void fnic_fcoe_process_cvl(struct fnic *fnic, struct fip_header *fiph);
+void fnic_vlan_discovery_timeout(struct fnic *fnic);
+
+#ifdef FNIC_DEBUG
+static inline void
+fnic_debug_dump_fip_frame(struct fnic *fnic, struct ethhdr *eth,
+				int len, char *pfx)
+{
+	struct fip_header *fiph = (struct fip_header *)(eth + 1);
+	u16 op = be16_to_cpu(fiph->fip_op);
+	u8 sub = fiph->fip_subcode;
+
+	FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+		"FIP %s packet contents: op: 0x%x sub: 0x%x (len = %d)",
+		pfx, op, sub, len);
+
+	fnic_debug_dump(fnic, (uint8_t *)eth, len);
+}
+
+#else /* FNIC_DEBUG */
+
+static inline void
+fnic_debug_dump_fip_frame(struct fnic *fnic, struct ethhdr *eth,
+				int len, char *pfx) {}
+#endif /* FNIC_DEBUG */
+
+#endif	/* _FIP_H_ */
diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index c4f4b2fe192a..64606fac14ea 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -235,6 +235,12 @@ do {								\
 				"fnic<%d>: %s: %d: " fmt, fnic_num,\
 				__func__, __LINE__, ##args);)
 
+#define FNIC_FIP_DBG(kern_level, host, fnic_num, fmt, args...)		\
+	FNIC_CHECK_LOGGING(FNIC_FCS_LOGGING,			\
+			 shost_printk(kern_level, host,			\
+				"fnic<%d>: %s: %d: " fmt, fnic_num,\
+				__func__, __LINE__, ##args);)
+
 #define FNIC_SCSI_DBG(kern_level, host, fnic_num, fmt, args...)		\
 	FNIC_CHECK_LOGGING(FNIC_SCSI_LOGGING,			\
 			 shost_printk(kern_level, host,			\
@@ -416,13 +422,15 @@ struct fnic {
 	/*** FIP related data members  -- start ***/
 	void (*set_vlan)(struct fnic *, u16 vlan);
 	struct work_struct      fip_frame_work;
-	struct sk_buff_head     fip_frame_queue;
+	struct work_struct		fip_timer_work;
+	struct list_head		fip_frame_queue;
 	struct timer_list       fip_timer;
-	struct list_head        vlans;
 	spinlock_t              vlans_lock;
-
-	struct work_struct      event_work;
-	struct list_head        evlist;
+	struct timer_list retry_fip_timer;
+	struct timer_list fcs_ka_timer;
+	struct timer_list enode_ka_timer;
+	struct timer_list vn_ka_timer;
+	struct list_head vlan_list;
 	/*** FIP related data members  -- end ***/
 
 	/* copy work queue cache line section */
@@ -472,9 +480,6 @@ int fnic_rq_cmpl_handler(struct fnic *fnic, int);
 int fnic_alloc_rq_frame(struct vnic_rq *rq);
 void fnic_free_rq_buf(struct vnic_rq *rq, struct vnic_rq_buf *buf);
 void fnic_flush_tx(struct work_struct *work);
-void fnic_eth_send(struct fcoe_ctlr *, struct sk_buff *skb);
-void fnic_set_port_id(struct fc_lport *, u32, struct fc_frame *);
-void fnic_update_mac(struct fc_lport *, u8 *new);
 void fnic_update_mac_locked(struct fnic *, u8 *new);
 
 int fnic_queuecommand(struct Scsi_Host *, struct scsi_cmnd *);
@@ -503,7 +508,7 @@ int fnic_is_abts_pending(struct fnic *, struct scsi_cmnd *);
 void fnic_handle_fip_frame(struct work_struct *work);
 void fnic_handle_fip_event(struct fnic *fnic);
 void fnic_fcoe_reset_vlans(struct fnic *fnic);
-void fnic_fcoe_evlist_free(struct fnic *fnic);
+extern void fnic_handle_fip_timer(struct timer_list *t);
 
 static inline int
 fnic_chk_state_flags_locked(struct fnic *fnic, unsigned long st_flags)
diff --git a/drivers/scsi/fnic/fnic_fcs.c b/drivers/scsi/fnic/fnic_fcs.c
index 6428e3e879cb..0194911898d9 100644
--- a/drivers/scsi/fnic/fnic_fcs.c
+++ b/drivers/scsi/fnic/fnic_fcs.c
@@ -14,28 +14,20 @@
 #include <linux/workqueue.h>
 #include <scsi/fc/fc_fip.h>
 #include <scsi/fc/fc_els.h>
-#include <scsi/fc/fc_fcoe.h>
 #include <scsi/fc_frame.h>
 #include <scsi/libfc.h>
 #include <scsi/scsi_transport_fc.h>
 #include "fnic_io.h"
 #include "fnic.h"
-#include "fnic_fip.h"
 #include "fnic_fdls.h"
 #include "fdls_fc.h"
 #include "cq_enet_desc.h"
 #include "cq_exch_desc.h"
+#include "fip.h"
 
-static u8 fcoe_all_fcfs[ETH_ALEN] = FIP_ALL_FCF_MACS;
-struct workqueue_struct *fnic_fip_queue;
+extern struct workqueue_struct *fnic_fip_queue;
 struct workqueue_struct *fnic_event_queue;
 
-static void fnic_set_eth_mode(struct fnic *);
-static void fnic_fcoe_start_fcf_disc(struct fnic *fnic);
-static void fnic_fcoe_process_vlan_resp(struct fnic *fnic, struct sk_buff *);
-static int fnic_fcoe_vlan_check(struct fnic *fnic, u16 flag);
-static int fnic_fcoe_handle_fip_frame(struct fnic *fnic, struct sk_buff *skb);
-
 static uint8_t FCOE_ALL_FCF_MAC[6] = FC_FCOE_FLOGI_MAC;
 
 /*
@@ -254,11 +246,6 @@ void fnic_handle_link(struct work_struct *work)
 			fnic->lport->host->host_no, FNIC_FC_LE,
 			"Link Status: UP_DOWN",
 			strlen("Link Status: UP_DOWN"));
-		if (fnic->config.flags & VFCF_FIP_CAPABLE) {
-			FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
-				"deleting fip-timer during link-down\n");
-			del_timer_sync(&fnic->fip_timer);
-		}
 		fcoe_ctlr_link_down(&fnic->ctlr);
 	}
 
@@ -301,496 +288,70 @@ void fnic_handle_frame(struct work_struct *work)
 	}
 }
 
-void fnic_fcoe_evlist_free(struct fnic *fnic)
-{
-	struct fnic_event *fevt = NULL;
-	struct fnic_event *next = NULL;
-	unsigned long flags;
-
-	spin_lock_irqsave(&fnic->fnic_lock, flags);
-	if (list_empty(&fnic->evlist)) {
-		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-		return;
-	}
-
-	list_for_each_entry_safe(fevt, next, &fnic->evlist, list) {
-		list_del(&fevt->list);
-		kfree(fevt);
-	}
-	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-}
-
-void fnic_handle_event(struct work_struct *work)
+void fnic_handle_fip_frame(struct work_struct *work)
 {
-	struct fnic *fnic = container_of(work, struct fnic, event_work);
-	struct fnic_event *fevt = NULL;
-	struct fnic_event *next = NULL;
-	unsigned long flags;
+	struct fnic_frame_list *cur_frame, *next;
+	struct fnic *fnic = container_of(work, struct fnic, fip_frame_work);
 
-	spin_lock_irqsave(&fnic->fnic_lock, flags);
-	if (list_empty(&fnic->evlist)) {
-		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-		return;
-	}
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "Processing FIP frame\n");
 
-	list_for_each_entry_safe(fevt, next, &fnic->evlist, list) {
+	spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
+	list_for_each_entry_safe(cur_frame, next, &fnic->fip_frame_queue,
+							 links) {
 		if (fnic->stop_rx_link_events) {
-			list_del(&fevt->list);
-			kfree(fevt);
-			spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+			list_del(&cur_frame->links);
+			spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
+			kfree(cur_frame->fp);
+			kfree(cur_frame);
 			return;
 		}
+
 		/*
 		 * If we're in a transitional state, just re-queue and return.
 		 * The queue will be serviced when we get to a stable state.
 		 */
 		if (fnic->state != FNIC_IN_FC_MODE &&
-		    fnic->state != FNIC_IN_ETH_MODE) {
-			spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+			fnic->state != FNIC_IN_ETH_MODE) {
+			spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
 			return;
 		}
 
-		list_del(&fevt->list);
-		switch (fevt->event) {
-		case FNIC_EVT_START_VLAN_DISC:
-			spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-			fnic_fcoe_send_vlan_req(fnic);
-			spin_lock_irqsave(&fnic->fnic_lock, flags);
-			break;
-		case FNIC_EVT_START_FCF_DISC:
-			FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
-				  "Start FCF Discovery\n");
-			fnic_fcoe_start_fcf_disc(fnic);
-			break;
-		default:
-			FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
-				  "Unknown event 0x%x\n", fevt->event);
-			break;
-		}
-		kfree(fevt);
-	}
-	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-}
-
-/**
- * is_fnic_fip_flogi_reject() - Check if the Received FIP FLOGI frame is rejected
- * @fip: The FCoE controller that received the frame
- * @skb: The received FIP frame
- *
- * Returns non-zero if the frame is rejected with unsupported cmd with
- * insufficient resource els explanation.
- */
-static inline int is_fnic_fip_flogi_reject(struct fcoe_ctlr *fip,
-					 struct sk_buff *skb)
-{
-	struct fc_lport *lport = fip->lp;
-	struct fip_header *fiph;
-	struct fc_frame_header *fh = NULL;
-	struct fip_desc *desc;
-	struct fip_encaps *els;
-	u16 op;
-	u8 els_op;
-	u8 sub;
-
-	size_t rlen;
-	size_t dlen = 0;
-
-	if (skb_linearize(skb))
-		return 0;
-
-	if (skb->len < sizeof(*fiph))
-		return 0;
-
-	fiph = (struct fip_header *)skb->data;
-	op = ntohs(fiph->fip_op);
-	sub = fiph->fip_subcode;
-
-	if (op != FIP_OP_LS)
-		return 0;
-
-	if (sub != FIP_SC_REP)
-		return 0;
-
-	rlen = ntohs(fiph->fip_dl_len) * 4;
-	if (rlen + sizeof(*fiph) > skb->len)
-		return 0;
-
-	desc = (struct fip_desc *)(fiph + 1);
-	dlen = desc->fip_dlen * FIP_BPW;
-
-	if (desc->fip_dtype == FIP_DT_FLOGI) {
-
-		if (dlen < sizeof(*els) + sizeof(*fh) + 1)
-			return 0;
-
-		els = (struct fip_encaps *)desc;
-		fh = (struct fc_frame_header *)(els + 1);
-
-		if (!fh)
-			return 0;
-
-		/*
-		 * ELS command code, reason and explanation should be = Reject,
-		 * unsupported command and insufficient resource
-		 */
-		els_op = *(u8 *)(fh + 1);
-		if (els_op == ELS_LS_RJT) {
-			shost_printk(KERN_INFO, lport->host,
-				  "Flogi Request Rejected by Switch\n");
-			return 1;
-		}
-		shost_printk(KERN_INFO, lport->host,
-				"Flogi Request Accepted by Switch\n");
-	}
-	return 0;
-}
-
-void fnic_fcoe_send_vlan_req(struct fnic *fnic)
-{
-	struct fcoe_ctlr *fip = &fnic->ctlr;
-	struct fnic_stats *fnic_stats = &fnic->fnic_stats;
-	struct sk_buff *skb;
-	char *eth_fr;
-	struct fip_vlan *vlan;
-	u64 vlan_tov;
-
-	fnic_fcoe_reset_vlans(fnic);
-	fnic->set_vlan(fnic, 0);
-
-	if (printk_ratelimit())
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
-			  "Sending VLAN request...\n");
-
-	skb = dev_alloc_skb(sizeof(struct fip_vlan));
-	if (!skb)
-		return;
-
-	eth_fr = (char *)skb->data;
-	vlan = (struct fip_vlan *)eth_fr;
-
-	memset(vlan, 0, sizeof(*vlan));
-	memcpy(vlan->eth.h_source, fip->ctl_src_addr, ETH_ALEN);
-	memcpy(vlan->eth.h_dest, fcoe_all_fcfs, ETH_ALEN);
-	vlan->eth.h_proto = htons(ETH_P_FIP);
-
-	vlan->fip.fip_ver = FIP_VER_ENCAPS(FIP_VER);
-	vlan->fip.fip_op = htons(FIP_OP_VLAN);
-	vlan->fip.fip_subcode = FIP_SC_VL_REQ;
-	vlan->fip.fip_dl_len = htons(sizeof(vlan->desc) / FIP_BPW);
-
-	vlan->desc.mac.fd_desc.fip_dtype = FIP_DT_MAC;
-	vlan->desc.mac.fd_desc.fip_dlen = sizeof(vlan->desc.mac) / FIP_BPW;
-	memcpy(&vlan->desc.mac.fd_mac, fip->ctl_src_addr, ETH_ALEN);
-
-	vlan->desc.wwnn.fd_desc.fip_dtype = FIP_DT_NAME;
-	vlan->desc.wwnn.fd_desc.fip_dlen = sizeof(vlan->desc.wwnn) / FIP_BPW;
-	put_unaligned_be64(fip->lp->wwnn, &vlan->desc.wwnn.fd_wwn);
-	atomic64_inc(&fnic_stats->vlan_stats.vlan_disc_reqs);
-
-	skb_put(skb, sizeof(*vlan));
-	skb->protocol = htons(ETH_P_FIP);
-	skb_reset_mac_header(skb);
-	skb_reset_network_header(skb);
-	fip->send(fip, skb);
-
-	/* set a timer so that we can retry if there no response */
-	vlan_tov = jiffies + msecs_to_jiffies(FCOE_CTLR_FIPVLAN_TOV);
-	mod_timer(&fnic->fip_timer, round_jiffies(vlan_tov));
-}
-
-static void fnic_fcoe_process_vlan_resp(struct fnic *fnic, struct sk_buff *skb)
-{
-	struct fcoe_ctlr *fip = &fnic->ctlr;
-	struct fip_header *fiph;
-	struct fip_desc *desc;
-	struct fnic_stats *fnic_stats = &fnic->fnic_stats;
-	u16 vid;
-	size_t rlen;
-	size_t dlen;
-	struct fcoe_vlan *vlan;
-	u64 sol_time;
-	unsigned long flags;
-
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
-		  "Received VLAN response...\n");
-
-	fiph = (struct fip_header *) skb->data;
-
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
-		  "Received VLAN response... OP 0x%x SUB_OP 0x%x\n",
-		  ntohs(fiph->fip_op), fiph->fip_subcode);
-
-	rlen = ntohs(fiph->fip_dl_len) * 4;
-	fnic_fcoe_reset_vlans(fnic);
-	spin_lock_irqsave(&fnic->vlans_lock, flags);
-	desc = (struct fip_desc *)(fiph + 1);
-	while (rlen > 0) {
-		dlen = desc->fip_dlen * FIP_BPW;
-		switch (desc->fip_dtype) {
-		case FIP_DT_VLAN:
-			vid = ntohs(((struct fip_vlan_desc *)desc)->fd_vlan);
-			shost_printk(KERN_INFO, fnic->lport->host,
-				  "process_vlan_resp: FIP VLAN %d\n", vid);
-			vlan = kzalloc(sizeof(*vlan), GFP_ATOMIC);
-			if (!vlan) {
-				/* retry from timer */
-				spin_unlock_irqrestore(&fnic->vlans_lock,
-							flags);
-				goto out;
-			}
-			vlan->vid = vid & 0x0fff;
-			vlan->state = FIP_VLAN_AVAIL;
-			list_add_tail(&vlan->list, &fnic->vlans);
-			break;
-		}
-		desc = (struct fip_desc *)((char *)desc + dlen);
-		rlen -= dlen;
-	}
-
-	/* any VLAN descriptors present ? */
-	if (list_empty(&fnic->vlans)) {
-		/* retry from timer */
-		atomic64_inc(&fnic_stats->vlan_stats.resp_withno_vlanID);
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
-			  "No VLAN descriptors in FIP VLAN response\n");
-		spin_unlock_irqrestore(&fnic->vlans_lock, flags);
-		goto out;
-	}
-
-	vlan = list_first_entry(&fnic->vlans, struct fcoe_vlan, list);
-	fnic->set_vlan(fnic, vlan->vid);
-	vlan->state = FIP_VLAN_SENT; /* sent now */
-	vlan->sol_count++;
-	spin_unlock_irqrestore(&fnic->vlans_lock, flags);
-
-	/* start the solicitation */
-	fcoe_ctlr_link_up(fip);
-
-	sol_time = jiffies + msecs_to_jiffies(FCOE_CTLR_START_DELAY);
-	mod_timer(&fnic->fip_timer, round_jiffies(sol_time));
-out:
-	return;
-}
-
-static void fnic_fcoe_start_fcf_disc(struct fnic *fnic)
-{
-	unsigned long flags;
-	struct fcoe_vlan *vlan;
-	u64 sol_time;
-
-	spin_lock_irqsave(&fnic->vlans_lock, flags);
-	vlan = list_first_entry(&fnic->vlans, struct fcoe_vlan, list);
-	fnic->set_vlan(fnic, vlan->vid);
-	vlan->state = FIP_VLAN_SENT; /* sent now */
-	vlan->sol_count = 1;
-	spin_unlock_irqrestore(&fnic->vlans_lock, flags);
-
-	/* start the solicitation */
-	fcoe_ctlr_link_up(&fnic->ctlr);
-
-	sol_time = jiffies + msecs_to_jiffies(FCOE_CTLR_START_DELAY);
-	mod_timer(&fnic->fip_timer, round_jiffies(sol_time));
-}
-
-static int fnic_fcoe_vlan_check(struct fnic *fnic, u16 flag)
-{
-	unsigned long flags;
-	struct fcoe_vlan *fvlan;
-
-	spin_lock_irqsave(&fnic->vlans_lock, flags);
-	if (list_empty(&fnic->vlans)) {
-		spin_unlock_irqrestore(&fnic->vlans_lock, flags);
-		return -EINVAL;
-	}
-
-	fvlan = list_first_entry(&fnic->vlans, struct fcoe_vlan, list);
-	if (fvlan->state == FIP_VLAN_USED) {
-		spin_unlock_irqrestore(&fnic->vlans_lock, flags);
-		return 0;
-	}
-
-	if (fvlan->state == FIP_VLAN_SENT) {
-		fvlan->state = FIP_VLAN_USED;
-		spin_unlock_irqrestore(&fnic->vlans_lock, flags);
-		return 0;
-	}
-	spin_unlock_irqrestore(&fnic->vlans_lock, flags);
-	return -EINVAL;
-}
-
-static void fnic_event_enq(struct fnic *fnic, enum fnic_evt ev)
-{
-	struct fnic_event *fevt;
-	unsigned long flags;
-
-	fevt = kmalloc(sizeof(*fevt), GFP_ATOMIC);
-	if (!fevt)
-		return;
-
-	fevt->fnic = fnic;
-	fevt->event = ev;
-
-	spin_lock_irqsave(&fnic->fnic_lock, flags);
-	list_add_tail(&fevt->list, &fnic->evlist);
-	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-
-	schedule_work(&fnic->event_work);
-}
-
-static int fnic_fcoe_handle_fip_frame(struct fnic *fnic, struct sk_buff *skb)
-{
-	struct fip_header *fiph;
-	int ret = 1;
-	u16 op;
-	u8 sub;
-
-	if (!skb || !(skb->data))
-		return -1;
-
-	if (skb_linearize(skb))
-		goto drop;
-
-	fiph = (struct fip_header *)skb->data;
-	op = ntohs(fiph->fip_op);
-	sub = fiph->fip_subcode;
-
-	if (FIP_VER_DECAPS(fiph->fip_ver) != FIP_VER)
-		goto drop;
-
-	if (ntohs(fiph->fip_dl_len) * FIP_BPW + sizeof(*fiph) > skb->len)
-		goto drop;
-
-	if (op == FIP_OP_DISC && sub == FIP_SC_ADV) {
-		if (fnic_fcoe_vlan_check(fnic, ntohs(fiph->fip_flags)))
-			goto drop;
-		/* pass it on to fcoe */
-		ret = 1;
-	} else if (op == FIP_OP_VLAN && sub == FIP_SC_VL_NOTE) {
-		/* set the vlan as used */
-		fnic_fcoe_process_vlan_resp(fnic, skb);
-		ret = 0;
-	} else if (op == FIP_OP_CTRL && sub == FIP_SC_CLR_VLINK) {
-		/* received CVL request, restart vlan disc */
-		fnic_event_enq(fnic, FNIC_EVT_START_VLAN_DISC);
-		/* pass it on to fcoe */
-		ret = 1;
-	}
-drop:
-	return ret;
-}
-
-void fnic_handle_fip_frame(struct work_struct *work)
-{
-	struct fnic *fnic = container_of(work, struct fnic, fip_frame_work);
-	struct fnic_stats *fnic_stats = &fnic->fnic_stats;
-	unsigned long flags;
-	struct sk_buff *skb;
-	struct ethhdr *eh;
+		list_del(&cur_frame->links);
 
-	while ((skb = skb_dequeue(&fnic->fip_frame_queue))) {
-		spin_lock_irqsave(&fnic->fnic_lock, flags);
-		if (fnic->stop_rx_link_events) {
-			spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-			dev_kfree_skb(skb);
-			return;
-		}
-		/*
-		 * If we're in a transitional state, just re-queue and return.
-		 * The queue will be serviced when we get to a stable state.
-		 */
-		if (fnic->state != FNIC_IN_FC_MODE &&
-		    fnic->state != FNIC_IN_ETH_MODE) {
-			skb_queue_head(&fnic->fip_frame_queue, skb);
-			spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-			return;
-		}
-		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-		eh = (struct ethhdr *)skb->data;
-		if (eh->h_proto == htons(ETH_P_FIP)) {
-			skb_pull(skb, sizeof(*eh));
-			if (fnic_fcoe_handle_fip_frame(fnic, skb) <= 0) {
-				dev_kfree_skb(skb);
-				continue;
-			}
-			/*
-			 * If there's FLOGI rejects - clear all
-			 * fcf's & restart from scratch
-			 */
-			if (is_fnic_fip_flogi_reject(&fnic->ctlr, skb)) {
-				atomic64_inc(
-					&fnic_stats->vlan_stats.flogi_rejects);
-				shost_printk(KERN_INFO, fnic->lport->host,
-					  "Trigger a Link down - VLAN Disc\n");
-				fcoe_ctlr_link_down(&fnic->ctlr);
-				/* start FCoE VLAN discovery */
-				fnic_fcoe_send_vlan_req(fnic);
-				dev_kfree_skb(skb);
-				continue;
-			}
-			fcoe_ctlr_recv(&fnic->ctlr, skb);
-			continue;
+		if (fdls_fip_recv_frame(fnic, cur_frame->fp)) {
+			kfree(cur_frame->fp);
+			kfree(cur_frame);
 		}
 	}
+	spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
 }
 
 /**
  * fnic_import_rq_eth_pkt() - handle received FCoE or FIP frame.
  * @fnic:	fnic instance.
- * @skb:	Ethernet Frame.
+ * @fp:		Ethernet Frame.
  */
-static inline int fnic_import_rq_eth_pkt(struct fnic *fnic, struct sk_buff *skb)
+static inline int fnic_import_rq_eth_pkt(struct fnic *fnic, void *fp)
 {
-	struct fc_frame *fp;
 	struct ethhdr *eh;
-	struct fcoe_hdr *fcoe_hdr;
-	struct fcoe_crc_eof *ft;
+	struct fnic_frame_list *fip_fr_elem;
+	unsigned long flags;
 
-	/*
-	 * Undo VLAN encapsulation if present.
-	 */
-	eh = (struct ethhdr *)skb->data;
-	if (eh->h_proto == htons(ETH_P_8021Q)) {
-		memmove((u8 *)eh + VLAN_HLEN, eh, ETH_ALEN * 2);
-		eh = skb_pull(skb, VLAN_HLEN);
-		skb_reset_mac_header(skb);
-	}
-	if (eh->h_proto == htons(ETH_P_FIP)) {
-		if (!(fnic->config.flags & VFCF_FIP_CAPABLE)) {
-			printk(KERN_ERR "Dropped FIP frame, as firmware "
-					"uses non-FIP mode, Enable FIP "
-					"using UCSM\n");
-			goto drop;
-		}
-		if ((fnic_fc_trace_set_data(fnic->lport->host->host_no,
-			FNIC_FC_RECV|0x80, (char *)skb->data, skb->len)) != 0) {
-			printk(KERN_ERR "fnic ctlr frame trace error!!!");
-		}
-		skb_queue_tail(&fnic->fip_frame_queue, skb);
+	eh = (struct ethhdr *) fp;
+	if ((eh->h_proto == cpu_to_be16(ETH_P_FIP)) && (fnic->iport.usefip)) {
+		fip_fr_elem = (struct fnic_frame_list *)
+			kzalloc(sizeof(struct fnic_frame_list), GFP_ATOMIC);
+		if (!fip_fr_elem)
+			return 0;
+		fip_fr_elem->fp = fp;
+		spin_lock_irqsave(&fnic->fnic_lock, flags);
+		list_add_tail(&fip_fr_elem->links, &fnic->fip_frame_queue);
+		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 		queue_work(fnic_fip_queue, &fnic->fip_frame_work);
-		return 1;		/* let caller know packet was used */
-	}
-	if (eh->h_proto != htons(ETH_P_FCOE))
-		goto drop;
-	skb_set_network_header(skb, sizeof(*eh));
-	skb_pull(skb, sizeof(*eh));
-
-	fcoe_hdr = (struct fcoe_hdr *)skb->data;
-	if (FC_FCOE_DECAPS_VER(fcoe_hdr) != FC_FCOE_VER)
-		goto drop;
-
-	fp = (struct fc_frame *)skb;
-	fc_frame_init(fp);
-	fr_sof(fp) = fcoe_hdr->fcoe_sof;
-	skb_pull(skb, sizeof(struct fcoe_hdr));
-	skb_reset_transport_header(skb);
-
-	ft = (struct fcoe_crc_eof *)(skb->data + skb->len - sizeof(*ft));
-	fr_eof(fp) = ft->fcoe_eof;
-	skb_trim(skb, skb->len - sizeof(*ft));
-	return 0;
-drop:
-	dev_kfree_skb_irq(skb);
-	return -1;
+		return 1;				/* let caller know packet was used */
+	} else
+		return 0;
 }
 
 /**
@@ -802,206 +363,145 @@ static inline int fnic_import_rq_eth_pkt(struct fnic *fnic, struct sk_buff *skb)
  */
 void fnic_update_mac_locked(struct fnic *fnic, u8 *new)
 {
-	u8 *ctl = fnic->ctlr.ctl_src_addr;
+	struct fnic_iport_s *iport = &fnic->iport;
+	u8 *ctl = iport->hwmac;
 	u8 *data = fnic->data_src_addr;
 
 	if (is_zero_ether_addr(new))
 		new = ctl;
 	if (ether_addr_equal(data, new))
 		return;
-	FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
-			"update_mac %pM\n", new);
+
+	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				 "Update MAC: %u\n", *new);
+
 	if (!is_zero_ether_addr(data) && !ether_addr_equal(data, ctl))
 		vnic_dev_del_addr(fnic->vdev, data);
+
 	memcpy(data, new, ETH_ALEN);
 	if (!ether_addr_equal(new, ctl))
 		vnic_dev_add_addr(fnic->vdev, new);
 }
 
-/**
- * fnic_update_mac() - set data MAC address and filters.
- * @lport:	local port.
- * @new:	newly-assigned FCoE MAC address.
- */
-void fnic_update_mac(struct fc_lport *lport, u8 *new)
-{
-	struct fnic *fnic = lport_priv(lport);
-
-	spin_lock_irq(&fnic->fnic_lock);
-	fnic_update_mac_locked(fnic, new);
-	spin_unlock_irq(&fnic->fnic_lock);
-}
-
-/**
- * fnic_set_port_id() - set the port_ID after successful FLOGI.
- * @lport:	local port.
- * @port_id:	assigned FC_ID.
- * @fp:		received frame containing the FLOGI accept or NULL.
- *
- * This is called from libfc when a new FC_ID has been assigned.
- * This causes us to reset the firmware to FC_MODE and setup the new MAC
- * address and FC_ID.
- *
- * It is also called with FC_ID 0 when we're logged off.
- *
- * If the FC_ID is due to point-to-point, fp may be NULL.
- */
-void fnic_set_port_id(struct fc_lport *lport, u32 port_id, struct fc_frame *fp)
-{
-	struct fnic *fnic = lport_priv(lport);
-	u8 *mac;
-	int ret;
-
-	FNIC_FCS_DBG(KERN_DEBUG, lport->host, fnic->fnic_num,
-			"set port_id 0x%x fp 0x%p\n",
-			port_id, fp);
-
-	/*
-	 * If we're clearing the FC_ID, change to use the ctl_src_addr.
-	 * Set ethernet mode to send FLOGI.
-	 */
-	if (!port_id) {
-		fnic_update_mac(lport, fnic->ctlr.ctl_src_addr);
-		fnic_set_eth_mode(fnic);
-		return;
-	}
-
-	if (fp) {
-		mac = fr_cb(fp)->granted_mac;
-		if (is_zero_ether_addr(mac)) {
-			/* non-FIP - FLOGI already accepted - ignore return */
-			fcoe_ctlr_recv_flogi(&fnic->ctlr, lport, fp);
-		}
-		fnic_update_mac(lport, mac);
-	}
-
-	/* Change state to reflect transition to FC mode */
-	spin_lock_irq(&fnic->fnic_lock);
-	if (fnic->state == FNIC_IN_ETH_MODE || fnic->state == FNIC_IN_FC_MODE)
-		fnic->state = FNIC_IN_ETH_TRANS_FC_MODE;
-	else {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
-			     "Unexpected fnic state: %s processing FLOGI response",
-				 fnic_state_to_str(fnic->state));
-		spin_unlock_irq(&fnic->fnic_lock);
-		return;
-	}
-	spin_unlock_irq(&fnic->fnic_lock);
-
-	/*
-	 * Send FLOGI registration to firmware to set up FC mode.
-	 * The new address will be set up when registration completes.
-	 */
-	ret = fnic_flogi_reg_handler(fnic, port_id);
-
-	if (ret < 0) {
-		spin_lock_irq(&fnic->fnic_lock);
-		if (fnic->state == FNIC_IN_ETH_TRANS_FC_MODE)
-			fnic->state = FNIC_IN_ETH_MODE;
-		spin_unlock_irq(&fnic->fnic_lock);
-	}
-}
-
 static void fnic_rq_cmpl_frame_recv(struct vnic_rq *rq, struct cq_desc
 				    *cq_desc, struct vnic_rq_buf *buf,
 				    int skipped __attribute__((unused)),
 				    void *opaque)
 {
 	struct fnic *fnic = vnic_dev_priv(rq->vdev);
-	struct sk_buff *skb;
-	struct fc_frame *fp;
+	uint8_t *fp;
 	struct fnic_stats *fnic_stats = &fnic->fnic_stats;
+	unsigned int ethhdr_stripped;
 	u8 type, color, eop, sop, ingress_port, vlan_stripped;
-	u8 fcoe = 0, fcoe_sof, fcoe_eof;
-	u8 fcoe_fc_crc_ok = 1, fcoe_enc_error = 0;
-	u8 tcp_udp_csum_ok, udp, tcp, ipv4_csum_ok;
-	u8 ipv6, ipv4, ipv4_fragment, rss_type, csum_not_calc;
+	u8 fcoe_fnic_crc_ok = 1, fcoe_enc_error = 0;
 	u8 fcs_ok = 1, packet_error = 0;
-	u16 q_number, completed_index, bytes_written = 0, vlan, checksum;
+	u16 q_number, completed_index, vlan;
 	u32 rss_hash;
+	u16 checksum;
+	u8 csum_not_calc, rss_type, ipv4, ipv6, ipv4_fragment;
+	u8 tcp_udp_csum_ok, udp, tcp, ipv4_csum_ok;
+	u8 fcoe = 0, fcoe_sof, fcoe_eof;
 	u16 exchange_id, tmpl;
 	u8 sof = 0;
 	u8 eof = 0;
 	u32 fcp_bytes_written = 0;
+	u16 enet_bytes_written = 0;
+	u32 bytes_written = 0;
 	unsigned long flags;
+	struct fnic_frame_list *frame_elem = NULL;
+	struct ethhdr *eh;
 
 	dma_unmap_single(&fnic->pdev->dev, buf->dma_addr, buf->len,
-			 DMA_FROM_DEVICE);
-	skb = buf->os_buf;
-	fp = (struct fc_frame *)skb;
+					 DMA_FROM_DEVICE);
+	fp = (uint8_t *) buf->os_buf;
 	buf->os_buf = NULL;
 
 	cq_desc_dec(cq_desc, &type, &color, &q_number, &completed_index);
 	if (type == CQ_DESC_TYPE_RQ_FCP) {
-		cq_fcp_rq_desc_dec((struct cq_fcp_rq_desc *)cq_desc,
-				   &type, &color, &q_number, &completed_index,
-				   &eop, &sop, &fcoe_fc_crc_ok, &exchange_id,
-				   &tmpl, &fcp_bytes_written, &sof, &eof,
-				   &ingress_port, &packet_error,
-				   &fcoe_enc_error, &fcs_ok, &vlan_stripped,
-				   &vlan);
-		skb_trim(skb, fcp_bytes_written);
-		fr_sof(fp) = sof;
-		fr_eof(fp) = eof;
-
+		cq_fcp_rq_desc_dec((struct cq_fcp_rq_desc *) cq_desc, &type,
+						   &color, &q_number, &completed_index, &eop, &sop,
+						   &fcoe_fnic_crc_ok, &exchange_id, &tmpl,
+						   &fcp_bytes_written, &sof, &eof, &ingress_port,
+						   &packet_error, &fcoe_enc_error, &fcs_ok,
+						   &vlan_stripped, &vlan);
+		ethhdr_stripped = 1;
+		bytes_written = fcp_bytes_written;
 	} else if (type == CQ_DESC_TYPE_RQ_ENET) {
-		cq_enet_rq_desc_dec((struct cq_enet_rq_desc *)cq_desc,
-				    &type, &color, &q_number, &completed_index,
-				    &ingress_port, &fcoe, &eop, &sop,
-				    &rss_type, &csum_not_calc, &rss_hash,
-				    &bytes_written, &packet_error,
-				    &vlan_stripped, &vlan, &checksum,
-				    &fcoe_sof, &fcoe_fc_crc_ok,
-				    &fcoe_enc_error, &fcoe_eof,
-				    &tcp_udp_csum_ok, &udp, &tcp,
-				    &ipv4_csum_ok, &ipv6, &ipv4,
-				    &ipv4_fragment, &fcs_ok);
-		skb_trim(skb, bytes_written);
+		cq_enet_rq_desc_dec((struct cq_enet_rq_desc *) cq_desc, &type,
+					&color, &q_number, &completed_index,
+					&ingress_port, &fcoe, &eop, &sop, &rss_type,
+					&csum_not_calc, &rss_hash, &enet_bytes_written,
+					&packet_error, &vlan_stripped, &vlan,
+					&checksum, &fcoe_sof, &fcoe_fnic_crc_ok,
+					&fcoe_enc_error, &fcoe_eof, &tcp_udp_csum_ok,
+					&udp, &tcp, &ipv4_csum_ok, &ipv6, &ipv4,
+					&ipv4_fragment, &fcs_ok);
+
+		ethhdr_stripped = 0;
+		bytes_written = enet_bytes_written;
+
 		if (!fcs_ok) {
 			atomic64_inc(&fnic_stats->misc_stats.frame_errors);
-			FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
-				     "fcs error.  dropping packet.\n");
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+						 "fnic 0x%p fcs error.  Dropping packet.\n", fnic);
 			goto drop;
 		}
-		if (fnic_import_rq_eth_pkt(fnic, skb))
-			return;
+		eh = (struct ethhdr *) fp;
+		if (eh->h_proto != cpu_to_be16(ETH_P_FCOE)) {
+
+			if (fnic_import_rq_eth_pkt(fnic, fp))
+				return;
 
+			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+							 "Dropping h_proto 0x%x",
+							 be16_to_cpu(eh->h_proto));
+			goto drop;
+		}
 	} else {
-		/* wrong CQ type*/
-		shost_printk(KERN_ERR, fnic->lport->host,
-			     "fnic rq_cmpl wrong cq type x%x\n", type);
+		/* wrong CQ type */
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "fnic rq_cmpl wrong cq type x%x\n", type);
 		goto drop;
 	}
 
-	if (!fcs_ok || packet_error || !fcoe_fc_crc_ok || fcoe_enc_error) {
+	if (!fcs_ok || packet_error || !fcoe_fnic_crc_ok || fcoe_enc_error) {
 		atomic64_inc(&fnic_stats->misc_stats.frame_errors);
-		FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
-			     "fnic rq_cmpl fcoe x%x fcsok x%x"
-			     " pkterr x%x fcoe_fc_crc_ok x%x, fcoe_enc_err"
-			     " x%x\n",
-			     fcoe, fcs_ok, packet_error,
-			     fcoe_fc_crc_ok, fcoe_enc_error);
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			 "fcoe %x fcsok %x pkterr %x ffco %x fee %x\n",
+			 fcoe, fcs_ok, packet_error,
+			 fcoe_fnic_crc_ok, fcoe_enc_error);
 		goto drop;
 	}
 
 	spin_lock_irqsave(&fnic->fnic_lock, flags);
 	if (fnic->stop_rx_link_events) {
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "fnic->stop_rx_link_events: %d\n",
+					 fnic->stop_rx_link_events);
 		goto drop;
 	}
-	fr_dev(fp) = fnic->lport;
+
 	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-	if ((fnic_fc_trace_set_data(fnic->lport->host->host_no, FNIC_FC_RECV,
-					(char *)skb->data, skb->len)) != 0) {
-		printk(KERN_ERR "fnic ctlr frame trace error!!!");
+
+	frame_elem =
+		kzalloc(sizeof(struct fnic_frame_list),
+						   GFP_ATOMIC);
+	if (!frame_elem) {
+		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+					 "Unable to alloc frame element of size: %ld\n",
+					 sizeof(struct fnic_frame_list));
+		goto drop;
 	}
+	frame_elem->fp = fp;
+	frame_elem->rx_ethhdr_stripped = ethhdr_stripped;
+	frame_elem->frame_len = bytes_written;
 
-	skb_queue_tail(&fnic->frame_queue, skb);
 	queue_work(fnic_event_queue, &fnic->frame_work);
-
 	return;
+
 drop:
-	dev_kfree_skb_irq(skb);
+	kfree(fp);
 }
 
 static int fnic_rq_cmpl_handler_cont(struct vnic_dev *vdev,
@@ -1091,62 +591,6 @@ void fnic_free_rq_buf(struct vnic_rq *rq, struct vnic_rq_buf *buf)
 	buf->os_buf = NULL;
 }
 
-/**
- * fnic_eth_send() - Send Ethernet frame.
- * @fip:	fcoe_ctlr instance.
- * @skb:	Ethernet Frame, FIP, without VLAN encapsulation.
- */
-void fnic_eth_send(struct fcoe_ctlr *fip, struct sk_buff *skb)
-{
-	struct fnic *fnic = fnic_from_ctlr(fip);
-	struct vnic_wq *wq = &fnic->wq[0];
-	dma_addr_t pa;
-	struct ethhdr *eth_hdr;
-	struct vlan_ethhdr *vlan_hdr;
-	unsigned long flags;
-
-	if (!fnic->vlan_hw_insert) {
-		eth_hdr = (struct ethhdr *)skb_mac_header(skb);
-		vlan_hdr = skb_push(skb, sizeof(*vlan_hdr) - sizeof(*eth_hdr));
-		memcpy(vlan_hdr, eth_hdr, 2 * ETH_ALEN);
-		vlan_hdr->h_vlan_proto = htons(ETH_P_8021Q);
-		vlan_hdr->h_vlan_encapsulated_proto = eth_hdr->h_proto;
-		vlan_hdr->h_vlan_TCI = htons(fnic->vlan_id);
-		if ((fnic_fc_trace_set_data(fnic->lport->host->host_no,
-			FNIC_FC_SEND|0x80, (char *)eth_hdr, skb->len)) != 0) {
-			printk(KERN_ERR "fnic ctlr frame trace error!!!");
-		}
-	} else {
-		if ((fnic_fc_trace_set_data(fnic->lport->host->host_no,
-			FNIC_FC_SEND|0x80, (char *)skb->data, skb->len)) != 0) {
-			printk(KERN_ERR "fnic ctlr frame trace error!!!");
-		}
-	}
-
-	pa = dma_map_single(&fnic->pdev->dev, skb->data, skb->len,
-			DMA_TO_DEVICE);
-	if (dma_mapping_error(&fnic->pdev->dev, pa)) {
-		printk(KERN_ERR "DMA mapping failed\n");
-		goto free_skb;
-	}
-
-	spin_lock_irqsave(&fnic->wq_lock[0], flags);
-	if (!vnic_wq_desc_avail(wq))
-		goto irq_restore;
-
-	fnic_queue_wq_eth_desc(wq, skb, pa, skb->len,
-			       0 /* hw inserts cos value */,
-			       fnic->vlan_id, 1);
-	spin_unlock_irqrestore(&fnic->wq_lock[0], flags);
-	return;
-
-irq_restore:
-	spin_unlock_irqrestore(&fnic->wq_lock[0], flags);
-	dma_unmap_single(&fnic->pdev->dev, pa, skb->len, DMA_TO_DEVICE);
-free_skb:
-	kfree_skb(skb);
-}
-
 /*
  * Send FC frame.
  */
@@ -1281,6 +725,7 @@ fnic_send_fip_frame(struct fnic_iport_s *iport, void *frame,
 	if (fnic->in_remove)
 		return -1;
 
+	fnic_debug_dump_fip_frame(fnic, frame, frame_size, "Outgoing");
 	return fnic_send_frame(fnic, frame, frame_size);
 }
 
@@ -1358,44 +803,6 @@ fnic_fdls_register_portid(struct fnic_iport_s *iport, u32 port_id,
 	return 0;
 }
 
-/**
- * fnic_set_eth_mode() - put fnic into ethernet mode.
- * @fnic: fnic device
- *
- * Called without fnic lock held.
- */
-static void fnic_set_eth_mode(struct fnic *fnic)
-{
-	unsigned long flags;
-	enum fnic_state old_state;
-	int ret;
-
-	spin_lock_irqsave(&fnic->fnic_lock, flags);
-again:
-	old_state = fnic->state;
-	switch (old_state) {
-	case FNIC_IN_FC_MODE:
-	case FNIC_IN_ETH_TRANS_FC_MODE:
-	default:
-		fnic->state = FNIC_IN_FC_TRANS_ETH_MODE;
-		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-
-		ret = fnic_fw_reset_handler(fnic);
-
-		spin_lock_irqsave(&fnic->fnic_lock, flags);
-		if (fnic->state != FNIC_IN_FC_TRANS_ETH_MODE)
-			goto again;
-		if (ret)
-			fnic->state = old_state;
-		break;
-
-	case FNIC_IN_FC_TRANS_ETH_MODE:
-	case FNIC_IN_ETH_MODE:
-		break;
-	}
-	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-}
-
 void fnic_free_txq(struct list_head *head)
 {
 	struct fnic_frame_list *cur_frame, *next;
@@ -1465,24 +872,3 @@ void fnic_free_wq_buf(struct vnic_wq *wq, struct vnic_wq_buf *buf)
 	buf->os_buf = NULL;
 }
 
-void fnic_fcoe_reset_vlans(struct fnic *fnic)
-{
-	unsigned long flags;
-	struct fcoe_vlan *vlan;
-	struct fcoe_vlan *next;
-
-	/*
-	 * indicate a link down to fcoe so that all fcf's are free'd
-	 * might not be required since we did this before sending vlan
-	 * discovery request
-	 */
-	spin_lock_irqsave(&fnic->vlans_lock, flags);
-	if (!list_empty(&fnic->vlans)) {
-		list_for_each_entry_safe(vlan, next, &fnic->vlans, list) {
-			list_del(&vlan->list);
-			kfree(vlan);
-		}
-	}
-	spin_unlock_irqrestore(&fnic->vlans_lock, flags);
-}
-
diff --git a/drivers/scsi/fnic/fnic_fip.h b/drivers/scsi/fnic/fnic_fip.h
deleted file mode 100644
index 79f53029737b..000000000000
--- a/drivers/scsi/fnic/fnic_fip.h
+++ /dev/null
@@ -1,48 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright 2008 Cisco Systems, Inc.  All rights reserved.
- * Copyright 2007 Nuova Systems, Inc.  All rights reserved.
- */
-
-#ifndef _FNIC_FIP_H_
-#define _FNIC_FIP_H_
-
-
-#define FCOE_CTLR_START_DELAY    2000    /* ms after first adv. to choose FCF */
-#define FCOE_CTLR_FIPVLAN_TOV    2000    /* ms after FIP VLAN disc */
-#define FCOE_CTLR_MAX_SOL        8
-
-#define FINC_MAX_FLOGI_REJECTS   8
-
-struct vlan {
-	__be16 vid;
-	__be16 type;
-};
-
-/*
- * VLAN entry.
- */
-struct fcoe_vlan {
-	struct list_head list;
-	u16 vid;		/* vlan ID */
-	u16 sol_count;		/* no. of sols sent */
-	u16 state;		/* state */
-};
-
-enum fip_vlan_state {
-	FIP_VLAN_AVAIL  = 0,	/* don't do anything */
-	FIP_VLAN_SENT   = 1,	/* sent */
-	FIP_VLAN_USED   = 2,	/* succeed */
-	FIP_VLAN_FAILED = 3,	/* failed to response */
-};
-
-struct fip_vlan {
-	struct ethhdr eth;
-	struct fip_header fip;
-	struct {
-		struct fip_mac_desc mac;
-		struct fip_wwn_desc wwnn;
-	} desc;
-};
-
-#endif  /* __FINC_FIP_H_ */
diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
index c75716856417..b9374ccb4669 100644
--- a/drivers/scsi/fnic/fnic_main.c
+++ b/drivers/scsi/fnic/fnic_main.c
@@ -29,7 +29,6 @@
 #include "vnic_intr.h"
 #include "vnic_stats.h"
 #include "fnic_io.h"
-#include "fnic_fip.h"
 #include "fnic.h"
 #include "fnic_fdls.h"
 #include "fdls_fc.h"
@@ -87,12 +86,13 @@ module_param(fnic_max_qdepth, uint, S_IRUGO|S_IWUSR);
 MODULE_PARM_DESC(fnic_max_qdepth, "Queue depth to report for each LUN");
 
 static struct libfc_function_template fnic_transport_template = {
-	.lport_set_port_id = fnic_set_port_id,
 	.fcp_abort_io = fnic_empty_scsi_cleanup,
 	.fcp_cleanup = fnic_empty_scsi_cleanup,
 	.exch_mgr_reset = fnic_exch_mgr_reset
 };
 
+struct workqueue_struct *fnic_fip_queue;
+
 static int fnic_slave_alloc(struct scsi_device *sdev)
 {
 	struct fc_rport *rport = starget_to_rport(scsi_target(sdev));
@@ -415,13 +415,6 @@ static void fnic_notify_timer(struct timer_list *t)
 		  round_jiffies(jiffies + FNIC_NOTIFY_TIMER_PERIOD));
 }
 
-static void fnic_fip_notify_timer(struct timer_list *t)
-{
-	struct fnic *fnic = from_timer(fnic, t, fip_timer);
-
-	/* Placeholder function */
-}
-
 static void fnic_notify_timer_start(struct fnic *fnic)
 {
 	switch (vnic_dev_get_intr_mode(fnic->vdev)) {
@@ -535,17 +528,6 @@ static void fnic_iounmap(struct fnic *fnic)
 		iounmap(fnic->bar0.vaddr);
 }
 
-/**
- * fnic_get_mac() - get assigned data MAC address for FIP code.
- * @lport: 	local port.
- */
-static u8 *fnic_get_mac(struct fc_lport *lport)
-{
-	struct fnic *fnic = lport_priv(lport);
-
-	return fnic->data_src_addr;
-}
-
 static void fnic_set_vlan(struct fnic *fnic, u16 vlan_id)
 {
 	vnic_dev_set_default_vlan(fnic->vdev, vlan_id);
@@ -829,25 +811,22 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	fnic->vlan_hw_insert = 1;
 	fnic->vlan_id = 0;
 
-	/* Initialize the FIP fcoe_ctrl struct */
-	fnic->ctlr.send = fnic_eth_send;
-	fnic->ctlr.update_mac = fnic_update_mac;
-	fnic->ctlr.get_src_addr = fnic_get_mac;
 	if (fnic->config.flags & VFCF_FIP_CAPABLE) {
 		dev_info(&fnic->pdev->dev, "firmware supports FIP\n");
 		/* enable directed and multicast */
 		vnic_dev_packet_filter(fnic->vdev, 1, 1, 0, 0, 0);
 		vnic_dev_add_addr(fnic->vdev, FIP_ALL_ENODE_MACS);
 		vnic_dev_add_addr(fnic->vdev, fnic->ctlr.ctl_src_addr);
-		fnic->set_vlan = fnic_set_vlan;
 		fcoe_ctlr_init(&fnic->ctlr, FIP_MODE_AUTO);
-		timer_setup(&fnic->fip_timer, fnic_fip_notify_timer, 0);
 		spin_lock_init(&fnic->vlans_lock);
 		INIT_WORK(&fnic->fip_frame_work, fnic_handle_fip_frame);
-		INIT_WORK(&fnic->event_work, fnic_handle_event);
-		skb_queue_head_init(&fnic->fip_frame_queue);
-		INIT_LIST_HEAD(&fnic->evlist);
-		INIT_LIST_HEAD(&fnic->vlans);
+		INIT_LIST_HEAD(&fnic->fip_frame_queue);
+		INIT_LIST_HEAD(&fnic->vlan_list);
+		timer_setup(&fnic->retry_fip_timer, fnic_handle_fip_timer, 0);
+		timer_setup(&fnic->fcs_ka_timer, fnic_handle_fcs_ka_timer, 0);
+		timer_setup(&fnic->enode_ka_timer, fnic_handle_enode_ka_timer, 0);
+		timer_setup(&fnic->vn_ka_timer, fnic_handle_vn_ka_timer, 0);
+		fnic->set_vlan = fnic_set_vlan;
 	} else {
 		dev_info(&fnic->pdev->dev, "firmware uses non-FIP mode\n");
 		fcoe_ctlr_init(&fnic->ctlr, FIP_MODE_NON_FIP);
@@ -1057,10 +1036,13 @@ static void fnic_remove(struct pci_dev *pdev)
 	fnic_free_txq(&fnic->tx_queue);
 
 	if (fnic->config.flags & VFCF_FIP_CAPABLE) {
-		del_timer_sync(&fnic->fip_timer);
-		skb_queue_purge(&fnic->fip_frame_queue);
+		del_timer_sync(&fnic->retry_fip_timer);
+		del_timer_sync(&fnic->fcs_ka_timer);
+		del_timer_sync(&fnic->enode_ka_timer);
+		del_timer_sync(&fnic->vn_ka_timer);
+
+		fnic_free_txq(&fnic->fip_frame_queue);
 		fnic_fcoe_reset_vlans(fnic);
-		fnic_fcoe_evlist_free(fnic);
 	}
 
 	if ((fnic_fdmi_support == 1) && (fnic->iport.fabric.fdmi_pending > 0))
-- 
2.47.0


