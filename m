Return-Path: <linux-scsi+bounces-10612-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DF39E7AD9
	for <lists+linux-scsi@lfdr.de>; Fri,  6 Dec 2024 22:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84CA728285B
	for <lists+linux-scsi@lfdr.de>; Fri,  6 Dec 2024 21:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBA020458C;
	Fri,  6 Dec 2024 21:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="anLZV4UW"
X-Original-To: linux-scsi@vger.kernel.org
Received: from rcdn-iport-2.cisco.com (rcdn-iport-2.cisco.com [173.37.86.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2365F204576;
	Fri,  6 Dec 2024 21:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733519988; cv=none; b=sfKbPD5yXJjdnqH1CAJzr+wHZgOw7awYI0dIbhzSjAxdWNrNiPJeQobLn6sumPNeF1DHglqYkiwjyWbPAnyA7tPI5z+I230ALwWzZ0ZGl+SIyzGRGZ9fF+XRNivEyB5HpHNHTxlf4GSLZqn8rQrwktv3/ARMq/gW4ScsQ9FivxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733519988; c=relaxed/simple;
	bh=x12RXrvf0AQNxqWUSddurqf9kaI9Ep9IwhShRkDwXX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mKAkH8kuLCB6+YahN4N73/gUXm1kgSLY6uQBzcVPknTCUmLGTyxDC7lGaLFSUjjyu2E1qwgNIMWpkyosB7abZI8iiXRUi+lT8zu/KiU02NyJWdwP71rKRfLdKSPCfFNqXk6Ql0ehcyUFfbax06fhR/KWULXhzBs05zM1vQWJJTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=anLZV4UW; arc=none smtp.client-ip=173.37.86.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=206600; q=dns/txt;
  s=iport; t=1733519979; x=1734729579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eth6OSjDsumTp0llrNF0LVJZseXtVVc9m/koOO7w+KQ=;
  b=anLZV4UWwEnD4ZpmPNq65ZJJjtHHUgM3Sac5Ca5wsJooVf0mTwqCrfga
   94m5YHkOD8K6TFSjo94kPDpLD1gnMlPWoXHIKRJ5XSm3dljbXguZtl+94
   EB+0MZZX1QyUmbDcxO42feZzTBNWH2yxFkyVhWRd+xJ9MJmkpG8oKvDs8
   Y=;
X-CSE-ConnectionGUID: kgPjaIbuQ8SupYyExw6sWw==
X-CSE-MsgGUID: 6qwQ9kXJQBWBZ2eaD7YKvw==
X-IPAS-Result: =?us-ascii?q?A0BFAADjaFNn/4//Ja1aGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQGCE4IcL4FPQxkvlkOBFpA3jGKBEQNWDwEBAQ9ABAQBA?=
 =?us-ascii?q?YUHAopoAiY4EwECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4Th?=
 =?us-ascii?q?giGWwIBAxoBDAsBRhBRRREZgilYgmUDsXeBeTOBAd4zgW2BSAGNSXCEdycVB?=
 =?us-ascii?q?oFJRIEUAYE7gTd2gVKCPhkBAYZcBIM1PYJmdiWBE4IUgg2DTIFvhVWDK4J8H?=
 =?us-ascii?q?TALO4EPWYw3SIEhA1khEQFVEw0KCwcFgXYDgk16K4ELgRc6gX6BE0qFDEY9g?=
 =?us-ascii?q?kppSzcCDQI2giR9gk2FGYRpYy8DAwMDgzyGJYI0QAMLGA1IESw3FBsGPm4Ho?=
 =?us-ascii?q?UZGgmZkCAYBARUbDA0xBgMLEy8JAQEuNT4KFwUUARUBHgEKEyeSOgYdBwIBB?=
 =?us-ascii?q?wonj0qCIIE0n02EJI5vklUaM4QEpk2Ye4JXoGkbEAlQhGaBfiWBWTMaCBsVO?=
 =?us-ascii?q?4JnUhkPji0WwiUlMjwCBwsBAQMJhkuMcQEBAgMhB25gAQE?=
IronPort-Data: A9a23:CelKwqOtZp4yTbXvrR20lsFynXyQoLVcMsEvi/4bfWQNrUpwgmcBy
 GMeDG2EbPvcZWPwKt11O9y0oBsDvcDRy9AyGXM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeaphyFjmE+0/F3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WlnlV
 e/a+ZWFZAb/g2AsaQr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj6/ZhNEM/HIcFw7ZMHHl/5
 NEIN24WUQ/W0opawJrjIgVtrt4oIM+uOMYUvWttiGmHS/0nWpvEBa7N4Le03h9p2ZsIRqmYP
 ZdEL2MzN3wsYDUXUrsTIJE3hvupgnD8WzZZs1mS46Ew5gA/ySQrj+m1YIuKII3iqcN9wF+Hn
 zPFz0bAKC4wBoaSwBbaw1Gymbqa9c/8cMdIfFGizdZojV+Z7mgSDgAGE1qxpL+yjUvWc9dWM
 VAV/Gw2oLQ/7lemSPH6RRSzpHPCtRkZM/JUEusn+ESOx7DS7gKxGGcJVHhCZcYguctwQiYlv
 neNntX0FXl0u6aUYWyS+63Srj6oPyURa2gYakc5oRAt+dLvpsQ3yxnIVNsmSPDzhdzuEja2y
 DePxMQju4guYQcw//3T1Tj6b/iE/PAlkiZdCt3rY1+Y
IronPort-HdrOrdr: A9a23:64ES6qNqMb3+VMBcTu6jsMiBIKoaSvp037Dk7SxMoHtuA6ilfq
 +V8sjzuSWftN9VYgBCpTniAtjkfZq/z/9ICOAqVN/IYOClghrLEGgI1+TfKlPbdhHWx6p0yb
 pgf69iCNf5EFR2yfrh7BLQKadG/DD+ysCVbSO09QYVcemsAJsQiTtENg==
X-Talos-CUID: 9a23:JWWSgm9c+umQsvR+BN+Vv00bIsIsU3fA9SfrPleJGEt5V+OOdkDFrQ==
X-Talos-MUID: 9a23:HuvkxgVooGoPNNXq/GH1mwgzN/dK2o6RInJXnJwq5PinKzMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,214,1728950400"; 
   d="scan'208";a="279089729"
Received: from rcdn-l-core-06.cisco.com ([173.37.255.143])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 06 Dec 2024 21:18:28 +0000
Received: from fedora.cisco.com (unknown [10.24.83.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kartilak@cisco.com)
	by rcdn-l-core-06.cisco.com (Postfix) with ESMTPSA id 471EC18000269;
	Fri,  6 Dec 2024 21:18:27 +0000 (GMT)
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
	Karan Tilak Kumar <kartilak@cisco.com>
Subject: [PATCH v6 13/15] scsi: fnic: Code cleanup
Date: Fri,  6 Dec 2024 13:08:50 -0800
Message-ID: <20241206210852.3251-14-kartilak@cisco.com>
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

Replace existing host structure with fnic host.
Add headers from scsi to support new functionality.
Remove unused code and declarations.

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Reviewed-by: Gian Carlo Boffa <gcboffa@cisco.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
---
Changes between v5 and v6:
    Replace additional fnic->lport->host with fnic->host to prevent
    compilation errors.
    Incorporate review comments from Hannes:
	Refactor fnic_transport_template into another patch.

Changes between v2 and v3:
    Replace additional fnic->lport->host with fnic->host to prevent
    compilation errors.
---
 drivers/scsi/fnic/fdls_disc.c    | 664 +++++++++++++++----------------
 drivers/scsi/fnic/fip.c          |  92 ++---
 drivers/scsi/fnic/fip.h          |   2 +-
 drivers/scsi/fnic/fnic.h         |  13 +-
 drivers/scsi/fnic/fnic_debugfs.c |   2 +-
 drivers/scsi/fnic/fnic_fcs.c     | 125 +++---
 drivers/scsi/fnic/fnic_isr.c     |  28 +-
 drivers/scsi/fnic/fnic_main.c    |  67 ++--
 drivers/scsi/fnic/fnic_scsi.c    | 241 +++++------
 9 files changed, 611 insertions(+), 623 deletions(-)

diff --git a/drivers/scsi/fnic/fdls_disc.c b/drivers/scsi/fnic/fdls_disc.c
index 3c77e975aa70..c2fd1bcff132 100644
--- a/drivers/scsi/fnic/fdls_disc.c
+++ b/drivers/scsi/fnic/fdls_disc.c
@@ -104,7 +104,7 @@ uint8_t *fdls_alloc_frame(struct fnic_iport_s *iport)
 
 	frame = mempool_alloc(fnic->frame_pool, GFP_ATOMIC);
 	if (frame == NULL) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 				"Failed to allocate frame");
 		return NULL;
 	}
@@ -136,7 +136,7 @@ uint16_t fdls_alloc_oxid(struct fnic_iport_s *iport, int oxid_frame_type,
 	 */
 	idx = find_next_zero_bit(oxid_pool->bitmap, FNIC_OXID_POOL_SZ, oxid_pool->next_idx);
 	if (idx == FNIC_OXID_POOL_SZ) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			"Alloc oxid: all oxid slots are busy iport state:%d\n",
 			iport->state);
 		return FNIC_UNASSIGNED_OXID;
@@ -148,7 +148,7 @@ uint16_t fdls_alloc_oxid(struct fnic_iport_s *iport, int oxid_frame_type,
 	oxid = FNIC_OXID_ENCODE(idx, oxid_frame_type);
 	*active_oxid = oxid;
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 	   "alloc oxid: 0x%x, iport state: %d\n",
 	   oxid, iport->state);
 	return oxid;
@@ -169,7 +169,7 @@ static void fdls_free_oxid_idx(struct fnic_iport_s *iport, uint16_t oxid_idx)
 
 	lockdep_assert_held(&fnic->fnic_lock);
 
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		"free oxid idx: 0x%x\n", oxid_idx);
 
 	WARN_ON(!test_and_clear_bit(oxid_idx, oxid_pool->bitmap));
@@ -194,7 +194,7 @@ void fdls_reclaim_oxid_handler(struct work_struct *work)
 	struct reclaim_entry_s *reclaim_entry, *next;
 	unsigned long delay_j, cur_jiffies;
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		"Reclaim oxid callback\n");
 
 	spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
@@ -223,7 +223,7 @@ void fdls_reclaim_oxid_handler(struct work_struct *work)
 
 		delay_j = reclaim_entry->expires - cur_jiffies;
 		schedule_delayed_work(&oxid_pool->oxid_reclaim_work, delay_j);
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			"Scheduling next callback at:%ld jiffies\n", delay_j);
 	}
 
@@ -266,7 +266,7 @@ void fdls_schedule_oxid_free(struct fnic_iport_s *iport, uint16_t *active_oxid)
 
 	lockdep_assert_held(&fnic->fnic_lock);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		"Schedule oxid free. oxid: 0x%x\n", *active_oxid);
 
 	*active_oxid = FNIC_UNASSIGNED_OXID;
@@ -275,7 +275,7 @@ void fdls_schedule_oxid_free(struct fnic_iport_s *iport, uint16_t *active_oxid)
 		kzalloc(sizeof(struct reclaim_entry_s), GFP_ATOMIC);
 
 	if (!reclaim_entry) {
-		FNIC_FCS_DBG(KERN_WARNING, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_WARNING, fnic->host, fnic->fnic_num,
 			"Failed to allocate memory for reclaim struct for oxid idx: %d\n",
 			oxid_idx);
 
@@ -314,7 +314,7 @@ void fdls_schedule_oxid_free_retry_work(struct work_struct *work)
 
 	for_each_set_bit(idx, oxid_pool->pending_schedule_free, FNIC_OXID_POOL_SZ) {
 
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			"Schedule oxid free. oxid idx: %d\n", idx);
 
 		spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
@@ -323,7 +323,7 @@ void fdls_schedule_oxid_free_retry_work(struct work_struct *work)
 		spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
 
 		if (!reclaim_entry) {
-			FNIC_FCS_DBG(KERN_WARNING, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_WARNING, fnic->host, fnic->fnic_num,
 				"Failed to allocate memory for reclaim struct for oxid idx: 0x%x\n",
 				idx);
 
@@ -430,7 +430,7 @@ fdls_start_fabric_timer(struct fnic_iport_s *iport, int timeout)
 	struct fnic *fnic = iport->fnic;
 
 	if (iport->fabric.timer_pending) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "iport fcid: 0x%x: Canceling fabric disc timer\n",
 					 iport->fcid);
 		fnic_del_fabric_timer_sync(fnic);
@@ -443,7 +443,7 @@ fdls_start_fabric_timer(struct fnic_iport_s *iport, int timeout)
 	fabric_tov = jiffies + msecs_to_jiffies(timeout);
 	mod_timer(&iport->fabric.retry_timer, round_jiffies(fabric_tov));
 	iport->fabric.timer_pending = 1;
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "fabric timer is %d ", timeout);
 }
 
@@ -455,7 +455,7 @@ fdls_start_tport_timer(struct fnic_iport_s *iport,
 	struct fnic *fnic = iport->fnic;
 
 	if (tport->timer_pending) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "tport fcid 0x%x: Canceling disc timer\n",
 					 tport->fcid);
 		fnic_del_tport_timer_sync(fnic, tport);
@@ -589,7 +589,7 @@ fdls_send_rscn_resp(struct fnic_iport_s *iport,
 
 	frame = fdls_alloc_frame(iport);
 	if (frame == NULL) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 				"Failed to allocate frame to send RSCN response");
 		return;
 	}
@@ -602,7 +602,7 @@ fdls_send_rscn_resp(struct fnic_iport_s *iport,
 	oxid = FNIC_STD_GET_OX_ID(rscn_fchdr);
 	FNIC_STD_SET_OX_ID(pels_acc->fchdr, oxid);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		 "0x%x: FDLS send RSCN response with oxid: 0x%x",
 		 iport->fcid, oxid);
 
@@ -622,7 +622,7 @@ fdls_send_logo_resp(struct fnic_iport_s *iport,
 
 	frame = fdls_alloc_frame(iport);
 	if (frame == NULL) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 				"Failed to allocate frame to send LOGO response");
 		return;
 	}
@@ -635,7 +635,7 @@ fdls_send_logo_resp(struct fnic_iport_s *iport,
 	oxid = FNIC_STD_GET_OX_ID(req_fchdr);
 	FNIC_STD_SET_OX_ID(plogo_resp->fchdr, oxid);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		 "0x%x: FDLS send LOGO response with oxid: 0x%x",
 		 iport->fcid, oxid);
 
@@ -656,7 +656,7 @@ fdls_send_tport_abts(struct fnic_iport_s *iport,
 
 	frame = fdls_alloc_frame(iport);
 	if (frame == NULL) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 				"Failed to allocate frame to send tport ABTS");
 		return;
 	}
@@ -679,7 +679,7 @@ fdls_send_tport_abts(struct fnic_iport_s *iport,
 
 	FNIC_STD_SET_OX_ID(*ptport_abts, tport->active_oxid);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "0x%x: FDLS send tport abts: tport->state: %d ",
 				 iport->fcid, tport->state);
 
@@ -701,7 +701,7 @@ static void fdls_send_fabric_abts(struct fnic_iport_s *iport)
 
 	frame = fdls_alloc_frame(iport);
 	if (frame == NULL) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 				"Failed to allocate frame to send fabric ABTS");
 		return;
 	}
@@ -764,7 +764,7 @@ static void fdls_send_fabric_abts(struct fnic_iport_s *iport)
 	oxid = iport->active_oxid_fabric_req;
 	FNIC_STD_SET_OX_ID(*pfabric_abts, oxid);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		 "0x%x: FDLS send fabric abts. iport->fabric.state: %d oxid: 0x%x",
 		 iport->fcid, iport->fabric.state, oxid);
 
@@ -790,7 +790,7 @@ static void fdls_send_fdmi_abts(struct fnic_iport_s *iport)
 
 	frame = fdls_alloc_frame(iport);
 	if (frame == NULL) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 				"Failed to allocate frame to send FDMI ABTS");
 		return;
 	}
@@ -834,7 +834,7 @@ static void fdls_send_fabric_flogi(struct fnic_iport_s *iport)
 
 	frame = fdls_alloc_frame(iport);
 	if (frame == NULL) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 		     "Failed to allocate frame to send FLOGI");
 		iport->fabric.flags |= FNIC_FDLS_RETRY_FRAME;
 		goto err_out;
@@ -863,7 +863,7 @@ static void fdls_send_fabric_flogi(struct fnic_iport_s *iport)
 		&iport->active_oxid_fabric_req);
 
 	if (oxid == FNIC_UNASSIGNED_OXID) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		     "0x%x: Failed to allocate OXID to send FLOGI",
 			 iport->fcid);
 		mempool_free(frame, fnic->frame_pool);
@@ -872,7 +872,7 @@ static void fdls_send_fabric_flogi(struct fnic_iport_s *iport)
 	}
 	FNIC_STD_SET_OX_ID(pflogi->fchdr, oxid);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		 "0x%x: FDLS send fabric FLOGI with oxid: 0x%x", iport->fcid,
 		 oxid);
 
@@ -894,7 +894,7 @@ static void fdls_send_fabric_plogi(struct fnic_iport_s *iport)
 
 	frame = fdls_alloc_frame(iport);
 	if (frame == NULL) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 		     "Failed to allocate frame to send PLOGI");
 		iport->fabric.flags |= FNIC_FDLS_RETRY_FRAME;
 		goto err_out;
@@ -906,7 +906,7 @@ static void fdls_send_fabric_plogi(struct fnic_iport_s *iport)
 	oxid = fdls_alloc_oxid(iport, FNIC_FRAME_TYPE_FABRIC_PLOGI,
 		&iport->active_oxid_fabric_req);
 	if (oxid == FNIC_UNASSIGNED_OXID) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		     "0x%x: Failed to allocate OXID to send fabric PLOGI",
 			 iport->fcid);
 		mempool_free(frame, fnic->frame_pool);
@@ -915,7 +915,7 @@ static void fdls_send_fabric_plogi(struct fnic_iport_s *iport)
 	}
 	FNIC_STD_SET_OX_ID(pplogi->fchdr, oxid);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		 "0x%x: FDLS send fabric PLOGI with oxid: 0x%x", iport->fcid,
 		 oxid);
 
@@ -940,7 +940,7 @@ static void fdls_send_fdmi_plogi(struct fnic_iport_s *iport)
 
 	frame = fdls_alloc_frame(iport);
 	if (frame == NULL) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 		     "Failed to allocate frame to send FDMI PLOGI");
 		goto err_out;
 	}
@@ -952,7 +952,7 @@ static void fdls_send_fdmi_plogi(struct fnic_iport_s *iport)
 		&iport->active_oxid_fdmi_plogi);
 
 	if (oxid == FNIC_UNASSIGNED_OXID) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			     "0x%x: Failed to allocate OXID to send FDMI PLOGI",
 			     iport->fcid);
 		mempool_free(frame, fnic->frame_pool);
@@ -963,7 +963,7 @@ static void fdls_send_fdmi_plogi(struct fnic_iport_s *iport)
 	hton24(d_id, FC_FID_MGMT_SERV);
 	FNIC_STD_SET_D_ID(pplogi->fchdr, d_id);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		     "0x%x: FDLS send FDMI PLOGI with oxid: 0x%x",
 		     iport->fcid, oxid);
 
@@ -987,7 +987,7 @@ static void fdls_send_rpn_id(struct fnic_iport_s *iport)
 
 	frame = fdls_alloc_frame(iport);
 	if (frame == NULL) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 		     "Failed to allocate frame to send RPN_ID");
 		iport->fabric.flags |= FNIC_FDLS_RETRY_FRAME;
 		goto err_out;
@@ -1014,7 +1014,7 @@ static void fdls_send_rpn_id(struct fnic_iport_s *iport)
 		&iport->active_oxid_fabric_req);
 
 	if (oxid == FNIC_UNASSIGNED_OXID) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		     "0x%x: Failed to allocate OXID to send RPN_ID",
 			 iport->fcid);
 		mempool_free(frame, fnic->frame_pool);
@@ -1023,7 +1023,7 @@ static void fdls_send_rpn_id(struct fnic_iport_s *iport)
 	}
 	FNIC_STD_SET_OX_ID(prpn_id->fchdr, oxid);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		 "0x%x: FDLS send RPN ID with oxid: 0x%x", iport->fcid,
 		 oxid);
 
@@ -1046,7 +1046,7 @@ static void fdls_send_scr(struct fnic_iport_s *iport)
 
 	frame = fdls_alloc_frame(iport);
 	if (frame == NULL) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 		     "Failed to allocate frame to send SCR");
 		iport->fabric.flags |= FNIC_FDLS_RETRY_FRAME;
 		goto err_out;
@@ -1068,7 +1068,7 @@ static void fdls_send_scr(struct fnic_iport_s *iport)
 	oxid = fdls_alloc_oxid(iport, FNIC_FRAME_TYPE_FABRIC_SCR,
 		&iport->active_oxid_fabric_req);
 	if (oxid == FNIC_UNASSIGNED_OXID) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		     "0x%x: Failed to allocate OXID to send SCR",
 			 iport->fcid);
 		mempool_free(frame, fnic->frame_pool);
@@ -1077,7 +1077,7 @@ static void fdls_send_scr(struct fnic_iport_s *iport)
 	}
 	FNIC_STD_SET_OX_ID(pscr->fchdr, oxid);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		 "0x%x: FDLS send SCR with oxid: 0x%x", iport->fcid,
 		 oxid);
 
@@ -1101,7 +1101,7 @@ static void fdls_send_gpn_ft(struct fnic_iport_s *iport, int fdls_state)
 
 	frame = fdls_alloc_frame(iport);
 	if (frame == NULL) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 		     "Failed to allocate frame to send GPN FT");
 		iport->fabric.flags |= FNIC_FDLS_RETRY_FRAME;
 		goto err_out;
@@ -1126,7 +1126,7 @@ static void fdls_send_gpn_ft(struct fnic_iport_s *iport, int fdls_state)
 		&iport->active_oxid_fabric_req);
 
 	if (oxid == FNIC_UNASSIGNED_OXID) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		     "0x%x: Failed to allocate OXID to send GPN FT",
 			 iport->fcid);
 		mempool_free(frame, fnic->frame_pool);
@@ -1135,7 +1135,7 @@ static void fdls_send_gpn_ft(struct fnic_iport_s *iport, int fdls_state)
 	}
 	FNIC_STD_SET_OX_ID(pgpn_ft->fchdr, oxid);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		 "0x%x: FDLS send GPN FT with oxid: 0x%x", iport->fcid,
 		 oxid);
 
@@ -1161,7 +1161,7 @@ fdls_send_tgt_adisc(struct fnic_iport_s *iport, struct fnic_tport_s *tport)
 
 	frame = fdls_alloc_frame(iport);
 	if (frame == NULL) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 				"Failed to allocate frame to send TGT ADISC");
 		tport->flags |= FNIC_FDLS_RETRY_FRAME;
 		goto err_out;
@@ -1181,7 +1181,7 @@ fdls_send_tgt_adisc(struct fnic_iport_s *iport, struct fnic_tport_s *tport)
 
 	oxid = fdls_alloc_oxid(iport, FNIC_FRAME_TYPE_TGT_ADISC, &tport->active_oxid);
 	if (oxid == FNIC_UNASSIGNED_OXID) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "0x%x: Failed to allocate OXID to send TGT ADISC",
 					 iport->fcid);
 		mempool_free(frame, fnic->frame_pool);
@@ -1200,7 +1200,7 @@ fdls_send_tgt_adisc(struct fnic_iport_s *iport, struct fnic_tport_s *tport)
 
 	padisc->els.adisc_cmd = ELS_ADISC;
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "0x%x: FDLS send ADISC to tgt fcid: 0x%x",
 				 iport->fcid, tport->fcid);
 
@@ -1220,7 +1220,7 @@ bool fdls_delete_tport(struct fnic_iport_s *iport, struct fnic_tport_s *tport)
 
 	if ((tport->state == FDLS_TGT_STATE_OFFLINING)
 	    || (tport->state == FDLS_TGT_STATE_OFFLINE)) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			     "tport fcid 0x%x: tport state is offlining/offline\n",
 			     tport->fcid);
 		return false;
@@ -1235,7 +1235,7 @@ bool fdls_delete_tport(struct fnic_iport_s *iport, struct fnic_tport_s *tport)
 	tport->flags |= FNIC_FDLS_TPORT_TERMINATING;
 
 	if (tport->timer_pending) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "tport fcid 0x%x: Canceling disc timer\n",
 					 tport->fcid);
 		fnic_del_tport_timer_sync(fnic, tport);
@@ -1251,7 +1251,7 @@ bool fdls_delete_tport(struct fnic_iport_s *iport, struct fnic_tport_s *tport)
 			tport_del_evt =
 				kzalloc(sizeof(struct fnic_tport_event_s), GFP_ATOMIC);
 			if (!tport_del_evt) {
-				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "Failed to allocate memory for tport fcid: 0x%0x\n",
 					 tport->fcid);
 				return false;
@@ -1261,7 +1261,7 @@ bool fdls_delete_tport(struct fnic_iport_s *iport, struct fnic_tport_s *tport)
 			list_add_tail(&tport_del_evt->links, &fnic->tport_event_list);
 			queue_work(fnic_event_queue, &fnic->tport_work);
 		} else {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "tport 0x%x not reg with scsi_transport. Freeing locally",
 				 tport->fcid);
 			list_del(&tport->links);
@@ -1285,7 +1285,7 @@ fdls_send_tgt_plogi(struct fnic_iport_s *iport, struct fnic_tport_s *tport)
 
 	frame = fdls_alloc_frame(iport);
 	if (frame == NULL) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 				"Failed to allocate frame to send TGT PLOGI");
 		tport->flags |= FNIC_FDLS_RETRY_FRAME;
 		goto err_out;
@@ -1296,7 +1296,7 @@ fdls_send_tgt_plogi(struct fnic_iport_s *iport, struct fnic_tport_s *tport)
 
 	oxid = fdls_alloc_oxid(iport, FNIC_FRAME_TYPE_TGT_PLOGI, &tport->active_oxid);
 	if (oxid == FNIC_UNASSIGNED_OXID) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "0x%x: Failed to allocate oxid to send PLOGI to fcid: 0x%x",
 				 iport->fcid, tport->fcid);
 		mempool_free(frame, fnic->frame_pool);
@@ -1310,7 +1310,7 @@ fdls_send_tgt_plogi(struct fnic_iport_s *iport, struct fnic_tport_s *tport)
 	hton24(d_id, tport->fcid);
 	FNIC_STD_SET_D_ID(pplogi->fchdr, d_id);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "0x%x: FDLS send tgt PLOGI to tgt: 0x%x with oxid: 0x%x",
 				 iport->fcid, tport->fcid, oxid);
 
@@ -1333,7 +1333,7 @@ fnic_fc_plogi_rsp_rdf(struct fnic_iport_s *iport,
 	    be16_to_cpu(plogi_rsp->els.fl_cssp[2].cp_rdfs) & FNIC_FC_C3_RDF;
 	struct fnic *fnic = iport->fnic;
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "MFS: b2b_rdf_size: 0x%x spc3_rdf_size: 0x%x",
 			 b2b_rdf_size, spc3_rdf_size);
 
@@ -1352,7 +1352,7 @@ static void fdls_send_register_fc4_types(struct fnic_iport_s *iport)
 
 	frame = fdls_alloc_frame(iport);
 	if (frame == NULL) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 		     "Failed to allocate frame to send RFT");
 		return;
 	}
@@ -1376,7 +1376,7 @@ static void fdls_send_register_fc4_types(struct fnic_iport_s *iport)
 		&iport->active_oxid_fabric_req);
 
 	if (oxid == FNIC_UNASSIGNED_OXID) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		     "0x%x: Failed to allocate OXID to send RFT",
 			 iport->fcid);
 		mempool_free(frame, fnic->frame_pool);
@@ -1384,7 +1384,7 @@ static void fdls_send_register_fc4_types(struct fnic_iport_s *iport)
 	}
 	FNIC_STD_SET_OX_ID(prft_id->fchdr, oxid);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		 "0x%x: FDLS send RFT with oxid: 0x%x", iport->fcid,
 		 oxid);
 
@@ -1413,7 +1413,7 @@ static void fdls_send_register_fc4_features(struct fnic_iport_s *iport)
 
 	frame = fdls_alloc_frame(iport);
 	if (frame == NULL) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 		     "Failed to allocate frame to send RFF");
 		return;
 	}
@@ -1439,7 +1439,7 @@ static void fdls_send_register_fc4_features(struct fnic_iport_s *iport)
 		&iport->active_oxid_fabric_req);
 
 	if (oxid == FNIC_UNASSIGNED_OXID) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			     "0x%x: Failed to allocate OXID to send RFF",
 				 iport->fcid);
 		mempool_free(frame, fnic->frame_pool);
@@ -1447,14 +1447,14 @@ static void fdls_send_register_fc4_features(struct fnic_iport_s *iport)
 	}
 	FNIC_STD_SET_OX_ID(prff_id->fchdr, oxid);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		 "0x%x: FDLS send RFF with oxid: 0x%x", iport->fcid,
 		 oxid);
 
 	if (IS_FNIC_FCP_INITIATOR(fnic)) {
 		prff_id->rff_id.fr_type = FC_TYPE_FCP;
 	} else {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "0x%x: Unknown type", iport->fcid);
 	}
 
@@ -1479,7 +1479,7 @@ fdls_send_tgt_prli(struct fnic_iport_s *iport, struct fnic_tport_s *tport)
 
 	frame = fdls_alloc_frame(iport);
 	if (frame == NULL) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 				"Failed to allocate frame to send TGT PRLI");
 		tport->flags |= FNIC_FDLS_RETRY_FRAME;
 		goto err_out;
@@ -1499,7 +1499,7 @@ fdls_send_tgt_prli(struct fnic_iport_s *iport, struct fnic_tport_s *tport)
 
 	oxid = fdls_alloc_oxid(iport, FNIC_FRAME_TYPE_TGT_PRLI, &tport->active_oxid);
 	if (oxid == FNIC_UNASSIGNED_OXID) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 			"0x%x: Failed to allocate OXID to send TGT PRLI to 0x%x",
 			iport->fcid, tport->fcid);
 		mempool_free(frame, fnic->frame_pool);
@@ -1516,7 +1516,7 @@ fdls_send_tgt_prli(struct fnic_iport_s *iport, struct fnic_tport_s *tport)
 	FNIC_STD_SET_S_ID(pprli->fchdr, s_id);
 	FNIC_STD_SET_D_ID(pprli->fchdr, d_id);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			"0x%x: FDLS send PRLI to tgt: 0x%x with oxid: 0x%x",
 			iport->fcid, tport->fcid, oxid);
 
@@ -1550,7 +1550,7 @@ void fdls_send_fabric_logo(struct fnic_iport_s *iport)
 
 	frame = fdls_alloc_frame(iport);
 	if (frame == NULL) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 		     "Failed to allocate frame to send fabric LOGO");
 		return;
 	}
@@ -1562,7 +1562,7 @@ void fdls_send_fabric_logo(struct fnic_iport_s *iport)
 		&iport->active_oxid_fabric_req);
 
 	if (oxid == FNIC_UNASSIGNED_OXID) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		     "0x%x: Failed to allocate OXID to send fabric LOGO",
 			 iport->fcid);
 		mempool_free(frame, fnic->frame_pool);
@@ -1575,7 +1575,7 @@ void fdls_send_fabric_logo(struct fnic_iport_s *iport)
 
 	iport->fabric.flags &= ~FNIC_FDLS_FABRIC_ABORT_ISSUED;
 
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		 "0x%x: FDLS send fabric LOGO with oxid: 0x%x",
 		 iport->fcid, oxid);
 
@@ -1607,7 +1607,7 @@ void fdls_tgt_logout(struct fnic_iport_s *iport, struct fnic_tport_s *tport)
 
 	frame = fdls_alloc_frame(iport);
 	if (frame == NULL) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 		     "Failed to allocate frame to send fabric LOGO");
 		return;
 	}
@@ -1617,7 +1617,7 @@ void fdls_tgt_logout(struct fnic_iport_s *iport, struct fnic_tport_s *tport)
 
 	oxid = fdls_alloc_oxid(iport, FNIC_FRAME_TYPE_TGT_LOGO, &tport->active_oxid);
 	if (oxid == FNIC_UNASSIGNED_OXID) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		     "0x%x: Failed to allocate OXID to send tgt LOGO",
 		     iport->fcid);
 		mempool_free(frame, fnic->frame_pool);
@@ -1628,7 +1628,7 @@ void fdls_tgt_logout(struct fnic_iport_s *iport, struct fnic_tport_s *tport)
 	hton24(d_id, tport->fcid);
 	FNIC_STD_SET_D_ID(plogo->fchdr, d_id);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		 "0x%x: FDLS send tgt LOGO with oxid: 0x%x",
 		 iport->fcid, oxid);
 
@@ -1643,7 +1643,7 @@ static void fdls_tgt_discovery_start(struct fnic_iport_s *iport)
 	u32 old_link_down_cnt = iport->fnic->link_down_cnt;
 	struct fnic *fnic = iport->fnic;
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "0x%x: Starting FDLS target discovery", iport->fcid);
 
 	list_for_each_entry_safe(tport, next, &iport->tport_list, links) {
@@ -1697,7 +1697,7 @@ static void fdls_target_restart_nexus(struct fnic_tport_s *tport)
 	struct fnic *fnic = iport->fnic;
 	bool retval = true;
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "tport fcid: 0x%x state: %d restart_count: %d",
 				 tport->fcid, tport->state, tport->nexus_restart_count);
 
@@ -1707,13 +1707,13 @@ static void fdls_target_restart_nexus(struct fnic_tport_s *tport)
 
 	retval = fdls_delete_tport(iport, tport);
 	if (retval != true) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 			     "Error deleting tport: 0x%x", fcid);
 		return;
 	}
 
 	if (nexus_restart_count >= FNIC_TPORT_MAX_NEXUS_RESTART) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			     "Exceeded nexus restart retries tport: 0x%x",
 			     fcid);
 		return;
@@ -1730,7 +1730,7 @@ static void fdls_target_restart_nexus(struct fnic_tport_s *tport)
 	 */
 	new_tport = fdls_create_tport(iport, fcid, wwpn);
 	if (!new_tport) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "Error creating new tport: 0x%x", fcid);
 		return;
 	}
@@ -1759,12 +1759,12 @@ static struct fnic_tport_s *fdls_create_tport(struct fnic_iport_s *iport,
 	struct fnic_tport_s *tport;
 	struct fnic *fnic = iport->fnic;
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "FDLS create tport: fcid: 0x%x wwpn: 0x%llx", fcid, wwpn);
 
 	tport = kzalloc(sizeof(struct fnic_tport_s), GFP_ATOMIC);
 	if (!tport) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "Memory allocation failure while creating tport: 0x%x\n",
 			 fcid);
 		return NULL;
@@ -1777,12 +1777,12 @@ static struct fnic_tport_s *fdls_create_tport(struct fnic_iport_s *iport,
 	tport->wwpn = wwpn;
 	tport->iport = iport;
 
-	FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 				 "Need to setup tport timer callback");
 
 	timer_setup(&tport->retry_timer, fdls_tport_timer_callback, 0);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "Added tport 0x%x", tport->fcid);
 	fdls_set_tport_state(tport, FDLS_TGT_STATE_INIT);
 	list_add_tail(&tport->links, &iport->tport_list);
@@ -1833,7 +1833,7 @@ static void fdls_fdmi_register_hba(struct fnic_iport_s *iport)
 
 	frame = fdls_alloc_frame(iport);
 	if (frame == NULL) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 		     "Failed to allocate frame to send FDMI RHBA");
 		return;
 	}
@@ -1861,7 +1861,7 @@ static void fdls_fdmi_register_hba(struct fnic_iport_s *iport)
 		&iport->active_oxid_fdmi_rhba);
 
 	if (oxid == FNIC_UNASSIGNED_OXID) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			     "0x%x: Failed to allocate OXID to send FDMI RHBA",
 		     iport->fcid);
 		mempool_free(frame, fnic->frame_pool);
@@ -1882,14 +1882,14 @@ static void fdls_fdmi_register_hba(struct fnic_iport_s *iport)
 	fnic_fdmi_attr_set(fdmi_attr, FNIC_FDMI_TYPE_NODE_NAME,
 		FNIC_FDMI_NN_LEN, data, &attr_off_bytes);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			"NN set, off=%d", attr_off_bytes);
 
 	strscpy_pad(data, FNIC_FDMI_MANUFACTURER, FNIC_FDMI_MANU_LEN);
 	fnic_fdmi_attr_set(fdmi_attr, FNIC_FDMI_TYPE_MANUFACTURER,
 		FNIC_FDMI_MANU_LEN, data, &attr_off_bytes);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			"MFG set <%s>, off=%d", data, attr_off_bytes);
 
 	err = vnic_dev_fw_info(fnic->vdev, &fw_info);
@@ -1898,7 +1898,7 @@ static void fdls_fdmi_register_hba(struct fnic_iport_s *iport)
 				FNIC_FDMI_SERIAL_LEN);
 		fnic_fdmi_attr_set(fdmi_attr, FNIC_FDMI_TYPE_SERIAL_NUMBER,
 			FNIC_FDMI_SERIAL_LEN, data, &attr_off_bytes);
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				"SERIAL set <%s>, off=%d", data, attr_off_bytes);
 
 	}
@@ -1910,21 +1910,21 @@ static void fdls_fdmi_register_hba(struct fnic_iport_s *iport)
 	fnic_fdmi_attr_set(fdmi_attr, FNIC_FDMI_TYPE_MODEL, FNIC_FDMI_MODEL_LEN,
 		data, &attr_off_bytes);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			"MODEL set <%s>, off=%d", data, attr_off_bytes);
 
 	strscpy_pad(data, FNIC_FDMI_MODEL_DESCRIPTION, FNIC_FDMI_MODEL_DES_LEN);
 	fnic_fdmi_attr_set(fdmi_attr, FNIC_FDMI_TYPE_MODEL_DES,
 		FNIC_FDMI_MODEL_DES_LEN, data, &attr_off_bytes);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			"MODEL_DESC set <%s>, off=%d", data, attr_off_bytes);
 
 	if (!err) {
 		strscpy_pad(data, fw_info->hw_version, FNIC_FDMI_HW_VER_LEN);
 		fnic_fdmi_attr_set(fdmi_attr, FNIC_FDMI_TYPE_HARDWARE_VERSION,
 			FNIC_FDMI_HW_VER_LEN, data, &attr_off_bytes);
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				"HW_VER set <%s>, off=%d", data, attr_off_bytes);
 
 	}
@@ -1933,14 +1933,14 @@ static void fdls_fdmi_register_hba(struct fnic_iport_s *iport)
 	fnic_fdmi_attr_set(fdmi_attr, FNIC_FDMI_TYPE_DRIVER_VERSION,
 		FNIC_FDMI_DR_VER_LEN, data, &attr_off_bytes);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			"DRV_VER set <%s>, off=%d", data, attr_off_bytes);
 
 	strscpy_pad(data, "N/A", FNIC_FDMI_ROM_VER_LEN);
 	fnic_fdmi_attr_set(fdmi_attr, FNIC_FDMI_TYPE_ROM_VERSION,
 		FNIC_FDMI_ROM_VER_LEN, data, &attr_off_bytes);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			"ROM_VER set <%s>, off=%d", data, attr_off_bytes);
 
 	if (!err) {
@@ -1948,14 +1948,14 @@ static void fdls_fdmi_register_hba(struct fnic_iport_s *iport)
 		fnic_fdmi_attr_set(fdmi_attr, FNIC_FDMI_TYPE_FIRMWARE_VERSION,
 			FNIC_FDMI_FW_VER_LEN, data, &attr_off_bytes);
 
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				"FW_VER set <%s>, off=%d", data, attr_off_bytes);
 	}
 
 	len = sizeof(struct fc_std_fdmi_rhba) + attr_off_bytes;
 	frame_size += len;
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		 "0x%x: FDLS send FDMI RHBA with oxid: 0x%x fs: %d", iport->fcid,
 		 oxid, frame_size);
 
@@ -1979,7 +1979,7 @@ static void fdls_fdmi_register_pa(struct fnic_iport_s *iport)
 
 	frame = fdls_alloc_frame(iport);
 	if (frame == NULL) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 		     "Failed to allocate frame to send FDMI RPA");
 		return;
 	}
@@ -2007,7 +2007,7 @@ static void fdls_fdmi_register_pa(struct fnic_iport_s *iport)
 		&iport->active_oxid_fdmi_rpa);
 
 	if (oxid == FNIC_UNASSIGNED_OXID) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			     "0x%x: Failed to allocate OXID to send FDMI RPA",
 			     iport->fcid);
 		mempool_free(frame, fnic->frame_pool);
@@ -2067,29 +2067,29 @@ static void fdls_fdmi_register_pa(struct fnic_iport_s *iport)
 		FNIC_FDMI_MFS_LEN, data, &attr_off_bytes);
 
 	snprintf(tmp_data, FNIC_FDMI_OS_NAME_LEN - 1, "host%d",
-		 fnic->lport->host->host_no);
+		 fnic->host->host_no);
 	strscpy_pad(data, tmp_data, FNIC_FDMI_OS_NAME_LEN);
 	data[FNIC_FDMI_OS_NAME_LEN - 1] = 0;
 	fnic_fdmi_attr_set(fdmi_attr, FNIC_FDMI_TYPE_OS_NAME,
 		FNIC_FDMI_OS_NAME_LEN, data, &attr_off_bytes);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			"OS name set <%s>, off=%d", data, attr_off_bytes);
 
-	sprintf(fc_host_system_hostname(fnic->lport->host), "%s", utsname()->nodename);
-	strscpy_pad(data, fc_host_system_hostname(fnic->lport->host),
+	sprintf(fc_host_system_hostname(fnic->host), "%s", utsname()->nodename);
+	strscpy_pad(data, fc_host_system_hostname(fnic->host),
 					FNIC_FDMI_HN_LEN);
 	data[FNIC_FDMI_HN_LEN - 1] = 0;
 	fnic_fdmi_attr_set(fdmi_attr, FNIC_FDMI_TYPE_HOST_NAME,
 		FNIC_FDMI_HN_LEN, data, &attr_off_bytes);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			"Host name set <%s>, off=%d", data, attr_off_bytes);
 
 	len = sizeof(struct fc_std_fdmi_rpa) + attr_off_bytes;
 	frame_size += len;
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		 "0x%x: FDLS send FDMI RPA with oxid: 0x%x fs: %d", iport->fcid,
 		 oxid, frame_size);
 
@@ -2105,7 +2105,7 @@ void fdls_fabric_timer_callback(struct timer_list *t)
 	struct fnic *fnic = iport->fnic;
 	unsigned long flags;
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		 "tp: %d fab state: %d fab retry counter: %d max_flogi_retries: %d",
 		 iport->fabric.timer_pending, iport->fabric.state,
 		 iport->fabric.retry_counter, iport->max_flogi_retries);
@@ -2120,7 +2120,7 @@ void fdls_fabric_timer_callback(struct timer_list *t)
 	if (iport->fabric.del_timer_inprogress) {
 		iport->fabric.del_timer_inprogress = 0;
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "fabric_del_timer inprogress(%d). Skip timer cb",
 					 iport->fabric.del_timer_inprogress);
 		return;
@@ -2148,7 +2148,7 @@ void fdls_fabric_timer_callback(struct timer_list *t)
 				iport->fabric.flags &= ~FNIC_FDLS_FABRIC_ABORT_ISSUED;
 				fdls_send_fabric_flogi(iport);
 			} else
-				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 							 "Exceeded max FLOGI retries");
 		}
 		break;
@@ -2170,7 +2170,7 @@ void fdls_fabric_timer_callback(struct timer_list *t)
 				iport->fabric.flags &= ~FNIC_FDLS_FABRIC_ABORT_ISSUED;
 				fdls_send_fabric_plogi(iport);
 			} else
-				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 							 "Exceeded max PLOGI retries");
 		}
 		break;
@@ -2201,7 +2201,7 @@ void fdls_fabric_timer_callback(struct timer_list *t)
 		else {
 			/* ABTS has timed out */
 			fdls_schedule_oxid_free(iport, &iport->active_oxid_fabric_req);
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 						 "ABTS timed out. Starting PLOGI: %p", iport);
 			fnic_fdls_start_plogi(iport);
 		}
@@ -2218,7 +2218,7 @@ void fdls_fabric_timer_callback(struct timer_list *t)
 		} else {
 			/* ABTS has timed out */
 			fdls_schedule_oxid_free(iport, &iport->active_oxid_fabric_req);
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 						 "ABTS timed out. Starting PLOGI: %p", iport);
 			fnic_fdls_start_plogi(iport);	/* go back to fabric Plogi */
 		}
@@ -2235,7 +2235,7 @@ void fdls_fabric_timer_callback(struct timer_list *t)
 		else {
 			/* ABTS has timed out */
 			fdls_schedule_oxid_free(iport, &iport->active_oxid_fabric_req);
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 						 "ABTS timed out. Starting PLOGI %p", iport);
 			fnic_fdls_start_plogi(iport);	/* go back to fabric Plogi */
 		}
@@ -2257,7 +2257,7 @@ void fdls_fabric_timer_callback(struct timer_list *t)
 			if (iport->fabric.retry_counter < FDLS_RETRY_COUNT) {
 				fdls_send_gpn_ft(iport, iport->fabric.state);
 			} else {
-				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "ABTS timeout for fabric GPN_FT. Check name server: %p",
 					 iport);
 			}
@@ -2279,7 +2279,7 @@ void fdls_fdmi_timer_callback(struct timer_list *t)
 
 	spin_lock_irqsave(&fnic->fnic_lock, flags);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		"fdmi timer callback : 0x%x\n", iport->fabric.fdmi_pending);
 
 	if (!iport->fabric.fdmi_pending) {
@@ -2287,7 +2287,7 @@ void fdls_fdmi_timer_callback(struct timer_list *t)
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 		return;
 	}
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		"fdmi timer callback : 0x%x\n", iport->fabric.fdmi_pending);
 
 	/* if not abort pending, send an abort */
@@ -2296,7 +2296,7 @@ void fdls_fdmi_timer_callback(struct timer_list *t)
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 		return;
 	}
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		"fdmi timer callback : 0x%x\n", iport->fabric.fdmi_pending);
 
 	/* ABTS pending for an active fdmi request that is pending.
@@ -2311,18 +2311,18 @@ void fdls_fdmi_timer_callback(struct timer_list *t)
 		if (iport->fabric.fdmi_pending & FDLS_FDMI_RPA_PENDING)
 			fdls_schedule_oxid_free(iport, &iport->active_oxid_fdmi_rpa);
 	}
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		"fdmi timer callback : 0x%x\n", iport->fabric.fdmi_pending);
 
 	iport->fabric.fdmi_pending = 0;
 	/* If max retries not exhaused, start over from fdmi plogi */
 	if (iport->fabric.fdmi_retry < FDLS_FDMI_MAX_RETRY) {
 		iport->fabric.fdmi_retry++;
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "retry fdmi timer %d", iport->fabric.fdmi_retry);
 		fdls_send_fdmi_plogi(iport);
 	}
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		"fdmi timer callback : 0x%x\n", iport->fabric.fdmi_pending);
 	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 }
@@ -2338,7 +2338,7 @@ static void fdls_send_delete_tport_msg(struct fnic_tport_s *tport)
 
 	tport_del_evt = kzalloc(sizeof(struct fnic_tport_event_s), GFP_ATOMIC);
 	if (!tport_del_evt) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "Failed to allocate memory for tport event fcid: 0x%x",
 			 tport->fcid);
 		return;
@@ -2371,13 +2371,13 @@ static void fdls_tport_timer_callback(struct timer_list *t)
 	if (tport->del_timer_inprogress) {
 		tport->del_timer_inprogress = 0;
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "tport_del_timer inprogress. Skip timer cb tport fcid: 0x%x\n",
 			 tport->fcid);
 		return;
 	}
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		 "tport fcid: 0x%x timer pending: %d state: %d retry counter: %d",
 		 tport->fcid, tport->timer_pending, tport->state,
 		 tport->retry_counter);
@@ -2438,14 +2438,14 @@ static void fdls_tport_timer_callback(struct timer_list *t)
 		} else {
 			/* exceeded retry count */
 			fdls_schedule_oxid_free(iport, &tport->active_oxid);
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "ADISC not responding. Deleting target port: 0x%x",
 					 tport->fcid);
 			fdls_send_delete_tport_msg(tport);
 		}
 		break;
 	default:
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "Unknown tport state: 0x%x", tport->state);
 		break;
 	}
@@ -2495,26 +2495,26 @@ fdls_process_tgt_adisc_rsp(struct fnic_iport_s *iport,
 	tport = fnic_find_tport_by_fcid(iport, tgt_fcid);
 
 	if (!tport) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "Tgt ADISC response tport not found: 0x%x", tgt_fcid);
 		return;
 	}
 	if ((iport->state != FNIC_IPORT_STATE_READY)
 		|| (tport->state != FDLS_TGT_STATE_ADISC)
 		|| (tport->flags & FNIC_FDLS_TGT_ABORT_ISSUED)) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "Dropping this ADISC response");
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "iport state: %d tport state: %d Is abort issued on PRLI? %d",
 			 iport->state, tport->state,
 			 (tport->flags & FNIC_FDLS_TGT_ABORT_ISSUED));
 		return;
 	}
 	if (FNIC_STD_GET_OX_ID(fchdr) != tport->active_oxid) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "Dropping frame from target: 0x%x",
 			 tgt_fcid);
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "Reason: Stale ADISC/Aborted ADISC/OOO frame delivery");
 		return;
 	}
@@ -2526,7 +2526,7 @@ fdls_process_tgt_adisc_rsp(struct fnic_iport_s *iport,
 	case ELS_LS_ACC:
 		atomic64_inc(&iport->iport_stats.tport_adisc_ls_accepts);
 		if (tport->timer_pending) {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 						 "tport 0x%p Canceling fabric disc timer\n",
 						 tport);
 			fnic_del_tport_timer_sync(fnic, tport);
@@ -2536,12 +2536,12 @@ fdls_process_tgt_adisc_rsp(struct fnic_iport_s *iport,
 		frame_wwnn = get_unaligned_be64(&adisc_rsp->els.adisc_wwnn);
 		frame_wwpn = get_unaligned_be64(&adisc_rsp->els.adisc_wwpn);
 		if ((frame_wwnn == tport->wwnn) && (frame_wwpn == tport->wwpn)) {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "ADISC accepted from target: 0x%x. Target logged in",
 				 tgt_fcid);
 			fdls_set_tport_state(tport, FDLS_TGT_STATE_READY);
 		} else {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 						 "Error mismatch frame: ADISC");
 		}
 		break;
@@ -2551,14 +2551,14 @@ fdls_process_tgt_adisc_rsp(struct fnic_iport_s *iport,
 		if (((els_rjt->rej.er_reason == ELS_RJT_BUSY)
 		     || (els_rjt->rej.er_reason == ELS_RJT_UNAB))
 			&& (tport->retry_counter < FDLS_RETRY_COUNT)) {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "ADISC ret ELS_LS_RJT BUSY. Retry from timer routine: 0x%x",
 				 tgt_fcid);
 
 			/* Retry ADISC again from the timer routine. */
 			tport->flags |= FNIC_FDLS_RETRY_FRAME;
 		} else {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 						 "ADISC returned ELS_LS_RJT from target: 0x%x",
 						 tgt_fcid);
 			fdls_delete_tport(iport, tport);
@@ -2582,33 +2582,33 @@ fdls_process_tgt_plogi_rsp(struct fnic_iport_s *iport,
 	fcid = FNIC_STD_GET_S_ID(fchdr);
 	tgt_fcid = ntoh24(fcid);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "FDLS processing target PLOGI response: tgt_fcid: 0x%x",
 				 tgt_fcid);
 
 	tport = fnic_find_tport_by_fcid(iport, tgt_fcid);
 	if (!tport) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "tport not found: 0x%x", tgt_fcid);
 		return;
 	}
 	if ((iport->state != FNIC_IPORT_STATE_READY)
 		|| (tport->flags & FNIC_FDLS_TGT_ABORT_ISSUED)) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "Dropping frame! iport state: %d tport state: %d",
 					 iport->state, tport->state);
 		return;
 	}
 
 	if (tport->state != FDLS_TGT_STATE_PLOGI) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			     "PLOGI rsp recvd in wrong state. Drop the frame and restart nexus");
 		fdls_target_restart_nexus(tport);
 		return;
 	}
 
 	if (FNIC_STD_GET_OX_ID(fchdr) != tport->active_oxid) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "PLOGI response from target: 0x%x. Dropping frame",
 			 tgt_fcid);
 		return;
@@ -2620,7 +2620,7 @@ fdls_process_tgt_plogi_rsp(struct fnic_iport_s *iport,
 	switch (plogi_rsp->els.fl_cmd) {
 	case ELS_LS_ACC:
 		atomic64_inc(&iport->iport_stats.tport_plogi_ls_accepts);
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "PLOGI accepted by target: 0x%x", tgt_fcid);
 		break;
 
@@ -2629,14 +2629,14 @@ fdls_process_tgt_plogi_rsp(struct fnic_iport_s *iport,
 		if (((els_rjt->rej.er_reason == ELS_RJT_BUSY)
 		     || (els_rjt->rej.er_reason == ELS_RJT_UNAB))
 			&& (tport->retry_counter < iport->max_plogi_retries)) {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "PLOGI ret ELS_LS_RJT BUSY. Retry from timer routine: 0x%x",
 				 tgt_fcid);
 			/* Retry plogi again from the timer routine. */
 			tport->flags |= FNIC_FDLS_RETRY_FRAME;
 			return;
 		}
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "PLOGI returned ELS_LS_RJT from target: 0x%x",
 					 tgt_fcid);
 		fdls_delete_tport(iport, tport);
@@ -2644,18 +2644,18 @@ fdls_process_tgt_plogi_rsp(struct fnic_iport_s *iport,
 
 	default:
 		atomic64_inc(&iport->iport_stats.tport_plogi_misc_rejects);
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "PLOGI not accepted from target fcid: 0x%x",
 					 tgt_fcid);
 		return;
 	}
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "Found the PLOGI target: 0x%x and state: %d",
 				 (unsigned int) tgt_fcid, tport->state);
 
 	if (tport->timer_pending) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "tport fcid 0x%x: Canceling disc timer\n",
 					 tport->fcid);
 		fnic_del_tport_timer_sync(fnic, tport);
@@ -2673,13 +2673,13 @@ fdls_process_tgt_plogi_rsp(struct fnic_iport_s *iport,
 		min(max_payload_size, iport->max_payload_size);
 
 	if (tport->max_payload_size < FNIC_MIN_DATA_FIELD_SIZE) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "MFS: tport max frame size below spec bounds: %d",
 			 tport->max_payload_size);
 		tport->max_payload_size = FNIC_MIN_DATA_FIELD_SIZE;
 	}
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		 "MAX frame size: %u iport max_payload_size: %d tport mfs: %d",
 		 max_payload_size, iport->max_payload_size,
 		 tport->max_payload_size);
@@ -2707,12 +2707,12 @@ fdls_process_tgt_prli_rsp(struct fnic_iport_s *iport,
 	fcid = FNIC_STD_GET_S_ID(fchdr);
 	tgt_fcid = ntoh24(fcid);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "FDLS process tgt PRLI response: 0x%x", tgt_fcid);
 
 	tport = fnic_find_tport_by_fcid(iport, tgt_fcid);
 	if (!tport) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "tport not found: 0x%x", tgt_fcid);
 		/* Handle or just drop? */
 		return;
@@ -2720,24 +2720,24 @@ fdls_process_tgt_prli_rsp(struct fnic_iport_s *iport,
 
 	if ((iport->state != FNIC_IPORT_STATE_READY)
 		|| (tport->flags & FNIC_FDLS_TGT_ABORT_ISSUED)) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "Dropping frame! iport st: %d tport st: %d tport fcid: 0x%x",
 			 iport->state, tport->state, tport->fcid);
 		return;
 	}
 
 	if (tport->state != FDLS_TGT_STATE_PRLI) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			     "PRLI rsp recvd in wrong state. Drop frame. Restarting nexus");
 		fdls_target_restart_nexus(tport);
 		return;
 	}
 
 	if (FNIC_STD_GET_OX_ID(fchdr) != tport->active_oxid) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "Dropping PRLI response from target: 0x%x ",
 			 tgt_fcid);
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "Reason: Stale PRLI response/Aborted PDISC/OOO frame delivery");
 		return;
 	}
@@ -2748,11 +2748,11 @@ fdls_process_tgt_prli_rsp(struct fnic_iport_s *iport,
 	switch (prli_rsp->els_prli.prli_cmd) {
 	case ELS_LS_ACC:
 		atomic64_inc(&iport->iport_stats.tport_prli_ls_accepts);
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "PRLI accepted from target: 0x%x", tgt_fcid);
 
 		if (prli_rsp->sp.spp_type != FC_FC4_TYPE_SCSI) {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "mismatched target zoned with FC SCSI initiator: 0x%x",
 				 tgt_fcid);
 			mismatched_tgt = true;
@@ -2769,7 +2769,7 @@ fdls_process_tgt_prli_rsp(struct fnic_iport_s *iport,
 		     || (els_rjt->rej.er_reason == ELS_RJT_UNAB))
 			&& (tport->retry_counter < FDLS_RETRY_COUNT)) {
 
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "PRLI ret ELS_LS_RJT BUSY. Retry from timer routine: 0x%x",
 				 tgt_fcid);
 
@@ -2777,7 +2777,7 @@ fdls_process_tgt_prli_rsp(struct fnic_iport_s *iport,
 			tport->flags |= FNIC_FDLS_RETRY_FRAME;
 			return;
 		} else {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 						 "PRLI returned ELS_LS_RJT from target: 0x%x",
 						 tgt_fcid);
 
@@ -2789,18 +2789,18 @@ fdls_process_tgt_prli_rsp(struct fnic_iport_s *iport,
 
 	default:
 		atomic64_inc(&iport->iport_stats.tport_prli_misc_rejects);
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "PRLI not accepted from target: 0x%x", tgt_fcid);
 		return;
 		break;
 	}
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "Found the PRLI target: 0x%x and state: %d",
 				 (unsigned int) tgt_fcid, tport->state);
 
 	if (tport->timer_pending) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "tport fcid 0x%x: Canceling disc timer\n",
 					 tport->fcid);
 		fnic_del_tport_timer_sync(fnic, tport);
@@ -2816,7 +2816,7 @@ fdls_process_tgt_prli_rsp(struct fnic_iport_s *iport,
 
 	/* Check if the device plays Target Mode Function */
 	if (!(tport->fcp_csp & FCP_PRLI_FUNC_TARGET)) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "Remote port(0x%x): no target support. Deleting it\n",
 			 tgt_fcid);
 		fdls_tgt_logout(iport, tport);
@@ -2829,14 +2829,14 @@ fdls_process_tgt_prli_rsp(struct fnic_iport_s *iport,
 	/* Inform the driver about new target added */
 	tport_add_evt = kzalloc(sizeof(struct fnic_tport_event_s), GFP_ATOMIC);
 	if (!tport_add_evt) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "tport event memory allocation failure: 0x%0x\n",
 				 tport->fcid);
 		return;
 	}
 	tport_add_evt->event = TGT_EV_RPORT_ADD;
 	tport_add_evt->arg1 = (void *) tport;
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "iport fcid: 0x%x add tport event fcid: 0x%x\n",
 			 tport->fcid, iport->fcid);
 	list_add_tail(&tport_add_evt->links, &fnic->tport_event_list);
@@ -2856,21 +2856,21 @@ fdls_process_rff_id_rsp(struct fnic_iport_s *iport,
 	uint16_t oxid = FNIC_STD_GET_OX_ID(fchdr);
 
 	if (fdls_get_state(fdls) != FDLS_STATE_REGISTER_FC4_FEATURES) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "RFF_ID resp recvd in state(%d). Dropping.",
 					 fdls_get_state(fdls));
 		return;
 	}
 
 	if (iport->active_oxid_fabric_req != oxid) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			"Incorrect OXID in response. state: %d, oxid recvd: 0x%x, active oxid: 0x%x\n",
 			fdls_get_state(fdls), oxid, iport->active_oxid_fabric_req);
 		return;
 	}
 
 	rsp = FNIC_STD_GET_FC_CT_CMD((&rff_rsp->fc_std_ct_hdr));
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "0x%x: FDLS process RFF ID response: 0x%04x", iport->fcid,
 				 (uint32_t) rsp);
 
@@ -2879,7 +2879,7 @@ fdls_process_rff_id_rsp(struct fnic_iport_s *iport,
 	switch (rsp) {
 	case FC_FS_ACC:
 		if (iport->fabric.timer_pending) {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 						 "Canceling fabric disc timer %p\n", iport);
 			fnic_del_fabric_timer_sync(fnic);
 		}
@@ -2893,18 +2893,18 @@ fdls_process_rff_id_rsp(struct fnic_iport_s *iport,
 		if (((reason_code == FC_FS_RJT_BSY)
 			|| (reason_code == FC_FS_RJT_UNABL))
 			&& (fdls->retry_counter < FDLS_RETRY_COUNT)) {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "RFF_ID ret ELS_LS_RJT BUSY. Retry from timer routine %p",
 					 iport);
 
 			/* Retry again from the timer routine */
 			fdls->flags |= FNIC_FDLS_RETRY_FRAME;
 		} else {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "RFF_ID returned ELS_LS_RJT. Halting discovery %p",
 			 iport);
 			if (iport->fabric.timer_pending) {
-				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 							 "Canceling fabric disc timer %p\n", iport);
 				fnic_del_fabric_timer_sync(fnic);
 			}
@@ -2929,14 +2929,14 @@ fdls_process_rft_id_rsp(struct fnic_iport_s *iport,
 	uint16_t oxid = FNIC_STD_GET_OX_ID(fchdr);
 
 	if (fdls_get_state(fdls) != FDLS_STATE_REGISTER_FC4_TYPES) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "RFT_ID resp recvd in state(%d). Dropping.",
 					 fdls_get_state(fdls));
 		return;
 	}
 
 	if (iport->active_oxid_fabric_req != oxid) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			"Incorrect OXID in response. state: %d, oxid recvd: 0x%x, active oxid: 0x%x\n",
 			fdls_get_state(fdls), oxid, iport->active_oxid_fabric_req);
 		return;
@@ -2944,7 +2944,7 @@ fdls_process_rft_id_rsp(struct fnic_iport_s *iport,
 
 
 	rsp = FNIC_STD_GET_FC_CT_CMD((&rft_rsp->fc_std_ct_hdr));
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "0x%x: FDLS process RFT ID response: 0x%04x", iport->fcid,
 				 (uint32_t) rsp);
 
@@ -2953,7 +2953,7 @@ fdls_process_rft_id_rsp(struct fnic_iport_s *iport,
 	switch (rsp) {
 	case FC_FS_ACC:
 		if (iport->fabric.timer_pending) {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 						 "Canceling fabric disc timer %p\n", iport);
 			fnic_del_fabric_timer_sync(fnic);
 		}
@@ -2967,19 +2967,19 @@ fdls_process_rft_id_rsp(struct fnic_iport_s *iport,
 		if (((reason_code == FC_FS_RJT_BSY)
 			|| (reason_code == FC_FS_RJT_UNABL))
 			&& (fdls->retry_counter < FDLS_RETRY_COUNT)) {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "0x%x: RFT_ID ret ELS_LS_RJT BUSY. Retry from timer routine",
 				 iport->fcid);
 
 			/* Retry again from the timer routine */
 			fdls->flags |= FNIC_FDLS_RETRY_FRAME;
 		} else {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "0x%x: RFT_ID REJ. Halting discovery reason %d expl %d",
 				 iport->fcid, reason_code,
 			 rft_rsp->fc_std_ct_hdr.ct_explan);
 			if (iport->fabric.timer_pending) {
-				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 							 "Canceling fabric disc timer %p\n", iport);
 				fnic_del_fabric_timer_sync(fnic);
 			}
@@ -3004,20 +3004,20 @@ fdls_process_rpn_id_rsp(struct fnic_iport_s *iport,
 	uint16_t oxid = FNIC_STD_GET_OX_ID(fchdr);
 
 	if (fdls_get_state(fdls) != FDLS_STATE_RPN_ID) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "RPN_ID resp recvd in state(%d). Dropping.",
 					 fdls_get_state(fdls));
 		return;
 	}
 	if (iport->active_oxid_fabric_req != oxid) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			"Incorrect OXID in response. state: %d, oxid recvd: 0x%x, active oxid: 0x%x\n",
 			fdls_get_state(fdls), oxid, iport->active_oxid_fabric_req);
 		return;
 	}
 
 	rsp = FNIC_STD_GET_FC_CT_CMD((&rpn_rsp->fc_std_ct_hdr));
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "0x%x: FDLS process RPN ID response: 0x%04x", iport->fcid,
 				 (uint32_t) rsp);
 	fdls_free_oxid(iport, oxid, &iport->active_oxid_fabric_req);
@@ -3025,7 +3025,7 @@ fdls_process_rpn_id_rsp(struct fnic_iport_s *iport,
 	switch (rsp) {
 	case FC_FS_ACC:
 		if (iport->fabric.timer_pending) {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 						 "Canceling fabric disc timer %p\n", iport);
 			fnic_del_fabric_timer_sync(fnic);
 		}
@@ -3039,17 +3039,17 @@ fdls_process_rpn_id_rsp(struct fnic_iport_s *iport,
 		if (((reason_code == FC_FS_RJT_BSY)
 			|| (reason_code == FC_FS_RJT_UNABL))
 			&& (fdls->retry_counter < FDLS_RETRY_COUNT)) {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "RPN_ID returned REJ BUSY. Retry from timer routine %p",
 					 iport);
 
 			/* Retry again from the timer routine */
 			fdls->flags |= FNIC_FDLS_RETRY_FRAME;
 		} else {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 						 "RPN_ID ELS_LS_RJT. Halting discovery %p", iport);
 			if (iport->fabric.timer_pending) {
-				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 							 "Canceling fabric disc timer %p\n", iport);
 				fnic_del_fabric_timer_sync(fnic);
 			}
@@ -3072,18 +3072,18 @@ fdls_process_scr_rsp(struct fnic_iport_s *iport,
 	struct fnic *fnic = iport->fnic;
 	uint16_t oxid = FNIC_STD_GET_OX_ID(fchdr);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "FDLS process SCR response: 0x%04x",
 		 (uint32_t) scr_rsp->scr.scr_cmd);
 
 	if (fdls_get_state(fdls) != FDLS_STATE_SCR) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "SCR resp recvd in state(%d). Dropping.",
 					 fdls_get_state(fdls));
 		return;
 	}
 	if (iport->active_oxid_fabric_req != oxid) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			"Incorrect OXID in response. state: %d, oxid recvd: 0x%x, active oxid: 0x%x\n",
 			fdls_get_state(fdls), oxid, iport->active_oxid_fabric_req);
 	}
@@ -3094,7 +3094,7 @@ fdls_process_scr_rsp(struct fnic_iport_s *iport,
 	case ELS_LS_ACC:
 		atomic64_inc(&iport->iport_stats.fabric_scr_ls_accepts);
 		if (iport->fabric.timer_pending) {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 						 "Canceling fabric disc timer %p\n", iport);
 			fnic_del_fabric_timer_sync(fnic);
 		}
@@ -3108,17 +3108,17 @@ fdls_process_scr_rsp(struct fnic_iport_s *iport,
 		if (((els_rjt->rej.er_reason == ELS_RJT_BUSY)
 	     || (els_rjt->rej.er_reason == ELS_RJT_UNAB))
 			&& (fdls->retry_counter < FDLS_RETRY_COUNT)) {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 						 "SCR ELS_LS_RJT BUSY. Retry from timer routine %p",
 						 iport);
 			/* Retry again from the timer routine */
 			fdls->flags |= FNIC_FDLS_RETRY_FRAME;
 		} else {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 						 "SCR returned ELS_LS_RJT. Halting discovery %p",
 						 iport);
 			if (iport->fabric.timer_pending) {
-				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					     "Canceling fabric disc timer %p\n",
 					     iport);
 				fnic_del_fabric_timer_sync(fnic);
@@ -3146,7 +3146,7 @@ fdls_process_gpn_ft_tgt_list(struct fnic_iport_s *iport,
 	u32 old_link_down_cnt = iport->fnic->link_down_cnt;
 	struct fnic *fnic = iport->fnic;
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "0x%x: FDLS process GPN_FT tgt list", iport->fcid);
 
 	gpn_ft_tgt =
@@ -3160,7 +3160,7 @@ fdls_process_gpn_ft_tgt_list(struct fnic_iport_s *iport,
 		fcid = ntoh24(gpn_ft_tgt->fcid);
 		wwpn = be64_to_cpu(gpn_ft_tgt->wwpn);
 
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "tport: 0x%x: ctrl:0x%x", fcid, gpn_ft_tgt->ctrl);
 
 		if (fcid == iport->fcid) {
@@ -3207,7 +3207,7 @@ fdls_process_gpn_ft_tgt_list(struct fnic_iport_s *iport,
 		rem_len -= sizeof(struct fc_gpn_ft_rsp_iu);
 	}
 	if (rem_len <= 0) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "GPN_FT response: malformed/corrupt frame rxlen: %d remlen: %d",
 			 len, rem_len);
 }
@@ -3217,7 +3217,7 @@ fdls_process_gpn_ft_tgt_list(struct fnic_iport_s *iport,
 		list_for_each_entry_safe(tport, next, &iport->tport_list, links) {
 
 			if (!(tport->flags & FNIC_FDLS_TPORT_IN_GPN_FT_LIST)) {
-				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "Remove port: 0x%x not found in GPN_FT list",
 					 tport->fcid);
 				fdls_delete_tport(iport, tport);
@@ -3246,7 +3246,7 @@ fdls_process_gpn_ft_rsp(struct fnic_iport_s *iport,
 	struct fnic *fnic = iport->fnic;
 	uint16_t oxid = FNIC_STD_GET_OX_ID(fchdr);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "FDLS process GPN_FT response: iport state: %d len: %d",
 				 iport->state, len);
 
@@ -3266,14 +3266,14 @@ fdls_process_gpn_ft_rsp(struct fnic_iport_s *iport,
 			  && ((fdls_get_state(fdls) == FDLS_STATE_RSCN_GPN_FT)
 				  || (fdls_get_state(fdls) == FDLS_STATE_SEND_GPNFT)
 				  || (fdls_get_state(fdls) == FDLS_STATE_TGT_DISCOVERY))))) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "GPNFT resp recvd in fab state(%d) iport_state(%d). Dropping.",
 			 fdls_get_state(fdls), iport->state);
 		return;
 	}
 
 	if (iport->active_oxid_fabric_req != oxid) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			"Incorrect OXID in response. state: %d, oxid recvd: 0x%x, active oxid: 0x%x\n",
 			fdls_get_state(fdls), oxid, iport->active_oxid_fabric_req);
 	}
@@ -3286,10 +3286,10 @@ fdls_process_gpn_ft_rsp(struct fnic_iport_s *iport,
 	switch (rsp) {
 
 	case FC_FS_ACC:
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "0x%x: GPNFT_RSP accept", iport->fcid);
 		if (iport->fabric.timer_pending) {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 						 "0x%x: Canceling fabric disc timer\n",
 						 iport->fcid);
 			fnic_del_fabric_timer_sync(fnic);
@@ -3304,7 +3304,7 @@ fdls_process_gpn_ft_rsp(struct fnic_iport_s *iport,
 		 * that will be taken care in next link up event
 		 */
 		if (iport->state != FNIC_IPORT_STATE_READY) {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "Halting target discovery: fab st: %d iport st: %d ",
 				 fdls_get_state(fdls), iport->state);
 			break;
@@ -3314,22 +3314,22 @@ fdls_process_gpn_ft_rsp(struct fnic_iport_s *iport,
 
 	case FC_FS_RJT:
 		reason_code = gpn_ft_rsp->fc_std_ct_hdr.ct_reason;
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "0x%x: GPNFT_RSP Reject reason: %d", iport->fcid, reason_code);
 
 		if (((reason_code == FC_FS_RJT_BSY)
 		     || (reason_code == FC_FS_RJT_UNABL))
 			&& (fdls->retry_counter < FDLS_RETRY_COUNT)) {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "0x%x: GPNFT_RSP ret REJ/BSY. Retry from timer routine",
 				 iport->fcid);
 			/* Retry again from the timer routine */
 			fdls->flags |= FNIC_FDLS_RETRY_FRAME;
 		} else {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 						 "0x%x: GPNFT_RSP reject", iport->fcid);
 			if (iport->fabric.timer_pending) {
-				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 							 "0x%x: Canceling fabric disc timer\n",
 							 iport->fcid);
 				fnic_del_fabric_timer_sync(fnic);
@@ -3343,7 +3343,7 @@ fdls_process_gpn_ft_rsp(struct fnic_iport_s *iport,
 			count = 0;
 			list_for_each_entry_safe(tport, next, &iport->tport_list,
 									 links) {
-				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 							 "GPN_FT_REJECT: Remove port: 0x%x",
 							 tport->fcid);
 				fdls_delete_tport(iport, tport);
@@ -3353,7 +3353,7 @@ fdls_process_gpn_ft_rsp(struct fnic_iport_s *iport,
 				}
 				count++;
 			}
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 						 "GPN_FT_REJECT: Removed (0x%x) ports", count);
 		}
 		break;
@@ -3378,7 +3378,7 @@ fdls_process_fabric_logo_rsp(struct fnic_iport_s *iport,
 	uint16_t oxid = FNIC_STD_GET_OX_ID(fchdr);
 
 	if (iport->active_oxid_fabric_req != oxid) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			"Incorrect OXID in response. state: %d, oxid recvd: 0x%x, active oxid: 0x%x\n",
 			fdls_get_state(fdls), oxid, iport->active_oxid_fabric_req);
 	}
@@ -3387,7 +3387,7 @@ fdls_process_fabric_logo_rsp(struct fnic_iport_s *iport,
 	switch (flogo_rsp->els.fl_cmd) {
 	case ELS_LS_ACC:
 		if (iport->fabric.state != FDLS_STATE_FABRIC_LOGO) {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "Flogo response. Fabric not in LOGO state. Dropping! %p",
 				 iport);
 			return;
@@ -3397,25 +3397,25 @@ fdls_process_fabric_logo_rsp(struct fnic_iport_s *iport,
 		iport->state = FNIC_IPORT_STATE_LINK_WAIT;
 
 		if (iport->fabric.timer_pending) {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "iport 0x%p Canceling fabric disc timer\n",
 						 iport);
 			fnic_del_fabric_timer_sync(fnic);
 		}
 		iport->fabric.timer_pending = 0;
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "Flogo response from Fabric for did: 0x%x",
 		     ntoh24(fchdr->fh_d_id));
 		return;
 
 	case ELS_LS_RJT:
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "Flogo response from Fabric for did: 0x%x returned ELS_LS_RJT",
 		     ntoh24(fchdr->fh_d_id));
 		return;
 
 	default:
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "FLOGO response not accepted or rejected: 0x%x",
 		     flogo_rsp->els.fl_cmd);
 	}
@@ -3433,17 +3433,17 @@ fdls_process_flogi_rsp(struct fnic_iport_s *iport,
 	struct fnic *fnic = iport->fnic;
 	uint16_t oxid = FNIC_STD_GET_OX_ID(fchdr);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "0x%x: FDLS processing FLOGI response", iport->fcid);
 
 	if (fdls_get_state(fabric) != FDLS_STATE_FABRIC_FLOGI) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "FLOGI response received in state (%d). Dropping frame",
 					 fdls_get_state(fabric));
 		return;
 	}
 	if (iport->active_oxid_fabric_req != oxid) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			"Incorrect OXID in response. state: %d, oxid recvd: 0x%x, active oxid: 0x%x\n",
 			fdls_get_state(fabric), oxid, iport->active_oxid_fabric_req);
 		return;
@@ -3455,7 +3455,7 @@ fdls_process_flogi_rsp(struct fnic_iport_s *iport,
 	case ELS_LS_ACC:
 		atomic64_inc(&iport->iport_stats.fabric_flogi_ls_accepts);
 		if (iport->fabric.timer_pending) {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 						 "iport fcid: 0x%x Canceling fabric disc timer\n",
 						 iport->fcid);
 			fnic_del_fabric_timer_sync(fnic);
@@ -3465,7 +3465,7 @@ fdls_process_flogi_rsp(struct fnic_iport_s *iport,
 		iport->fabric.retry_counter = 0;
 		fcid = FNIC_STD_GET_D_ID(fchdr);
 		iport->fcid = ntoh24(fcid);
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "0x%x: FLOGI response accepted", iport->fcid);
 
 		/* Learn the Service Params */
@@ -3475,7 +3475,7 @@ fdls_process_flogi_rsp(struct fnic_iport_s *iport,
 			iport->max_payload_size = min(rdf_size,
 								  iport->max_payload_size);
 
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "max_payload_size from fabric: %u set: %d", rdf_size,
 					 iport->max_payload_size);
 
@@ -3485,26 +3485,26 @@ fdls_process_flogi_rsp(struct fnic_iport_s *iport,
 		if (FNIC_LOGI_FEATURES(flogi_rsp->els) & FNIC_FC_EDTOV_NSEC)
 			iport->e_d_tov = iport->e_d_tov / FNIC_NSEC_TO_MSEC;
 
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "From fabric: R_A_TOV: %d E_D_TOV: %d",
 					 iport->r_a_tov, iport->e_d_tov);
 
 		if (IS_FNIC_FCP_INITIATOR(fnic)) {
-			fc_host_fabric_name(iport->fnic->lport->host) =
+			fc_host_fabric_name(iport->fnic->host) =
 			get_unaligned_be64(&FNIC_LOGI_NODE_NAME(flogi_rsp->els));
-			fc_host_port_id(iport->fnic->lport->host) = iport->fcid;
+			fc_host_port_id(iport->fnic->host) = iport->fcid;
 		}
 
 		fnic_fdls_learn_fcoe_macs(iport, rx_frame, fcid);
 
 		if (fnic_fdls_register_portid(iport, iport->fcid, rx_frame) != 0) {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 						 "0x%x: FLOGI registration failed", iport->fcid);
 			break;
 		}
 
 		memcpy(&fcmac[3], fcid, 3);
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "Adding vNIC device MAC addr: %02x:%02x:%02x:%02x:%02x:%02x",
 			 fcmac[0], fcmac[1], fcmac[2], fcmac[3], fcmac[4],
 			 fcmac[5]);
@@ -3512,7 +3512,7 @@ fdls_process_flogi_rsp(struct fnic_iport_s *iport,
 
 		if (fdls_get_state(fabric) == FDLS_STATE_FABRIC_FLOGI) {
 			fnic_fdls_start_plogi(iport);
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 						 "FLOGI response received. Starting PLOGI");
 		} else {
 			/* From FDLS_STATE_FABRIC_FLOGI state fabric can only go to
@@ -3520,7 +3520,7 @@ fdls_process_flogi_rsp(struct fnic_iport_s *iport,
 			 * state, hence we don't have to worry about undoing:
 			 * the fnic_fdls_register_portid and vnic_dev_add_addr
 			 */
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "FLOGI response received in state (%d). Dropping frame",
 				 fdls_get_state(fabric));
 		}
@@ -3529,7 +3529,7 @@ fdls_process_flogi_rsp(struct fnic_iport_s *iport,
 	case ELS_LS_RJT:
 		atomic64_inc(&iport->iport_stats.fabric_flogi_ls_rejects);
 		if (fabric->retry_counter < iport->max_flogi_retries) {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "FLOGI returned ELS_LS_RJT BUSY. Retry from timer routine %p",
 				 iport);
 
@@ -3537,11 +3537,11 @@ fdls_process_flogi_rsp(struct fnic_iport_s *iport,
 			fabric->flags |= FNIC_FDLS_RETRY_FRAME;
 
 		} else {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "FLOGI returned ELS_LS_RJT. Halting discovery %p",
 			 iport);
 			if (iport->fabric.timer_pending) {
-				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 							 "iport 0x%p Canceling fabric disc timer\n",
 							 iport);
 				fnic_del_fabric_timer_sync(fnic);
@@ -3552,7 +3552,7 @@ fdls_process_flogi_rsp(struct fnic_iport_s *iport,
 		break;
 
 	default:
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "FLOGI response not accepted: 0x%x",
 		     flogi_rsp->els.fl_cmd);
 		atomic64_inc(&iport->iport_stats.fabric_flogi_misc_rejects);
@@ -3571,13 +3571,13 @@ fdls_process_fabric_plogi_rsp(struct fnic_iport_s *iport,
 	uint16_t oxid = FNIC_STD_GET_OX_ID(fchdr);
 
 	if (fdls_get_state((&iport->fabric)) != FDLS_STATE_FABRIC_PLOGI) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "Fabric PLOGI response received in state (%d). Dropping frame",
 			 fdls_get_state(&iport->fabric));
 		return;
 	}
 	if (iport->active_oxid_fabric_req != oxid) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			"Incorrect OXID in response. state: %d, oxid recvd: 0x%x, active oxid: 0x%x\n",
 			fdls_get_state(fdls), oxid, iport->active_oxid_fabric_req);
 		return;
@@ -3588,7 +3588,7 @@ fdls_process_fabric_plogi_rsp(struct fnic_iport_s *iport,
 	case ELS_LS_ACC:
 		atomic64_inc(&iport->iport_stats.fabric_plogi_ls_accepts);
 		if (iport->fabric.timer_pending) {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "iport fcid: 0x%x fabric PLOGI response: Accepted\n",
 				 iport->fcid);
 			fnic_del_fabric_timer_sync(fnic);
@@ -3603,15 +3603,15 @@ fdls_process_fabric_plogi_rsp(struct fnic_iport_s *iport,
 		if (((els_rjt->rej.er_reason == ELS_RJT_BUSY)
 	     || (els_rjt->rej.er_reason == ELS_RJT_UNAB))
 			&& (iport->fabric.retry_counter < iport->max_plogi_retries)) {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "0x%x: Fabric PLOGI ELS_LS_RJT BUSY. Retry from timer routine",
 				 iport->fcid);
 		} else {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "0x%x: Fabric PLOGI ELS_LS_RJT. Halting discovery",
 				 iport->fcid);
 			if (iport->fabric.timer_pending) {
-				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 							 "iport fcid: 0x%x Canceling fabric disc timer\n",
 							 iport->fcid);
 				fnic_del_fabric_timer_sync(fnic);
@@ -3622,7 +3622,7 @@ fdls_process_fabric_plogi_rsp(struct fnic_iport_s *iport,
 		}
 		break;
 	default:
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "PLOGI response not accepted: 0x%x",
 		     plogi_rsp->els.fl_cmd);
 		atomic64_inc(&iport->iport_stats.fabric_plogi_misc_rejects);
@@ -3641,7 +3641,7 @@ static void fdls_process_fdmi_plogi_rsp(struct fnic_iport_s *iport,
 	uint16_t oxid = FNIC_STD_GET_OX_ID(fchdr);
 
 	if (iport->active_oxid_fdmi_plogi != oxid) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			"Incorrect OXID in response. state: %d, oxid recvd: 0x%x, active oxid: 0x%x\n",
 			fdls_get_state(fdls), oxid, iport->active_oxid_fdmi_plogi);
 		return;
@@ -3655,9 +3655,9 @@ static void fdls_process_fdmi_plogi_rsp(struct fnic_iport_s *iport,
 		iport->fabric.fdmi_pending = 0;
 		switch (plogi_rsp->els.fl_cmd) {
 		case ELS_LS_ACC:
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "FDLS process fdmi PLOGI response status: ELS_LS_ACC\n");
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "Sending fdmi registration for port 0x%x\n",
 				 iport->fcid);
 
@@ -3668,7 +3668,7 @@ static void fdls_process_fdmi_plogi_rsp(struct fnic_iport_s *iport,
 				  round_jiffies(fdmi_tov));
 			break;
 		case ELS_LS_RJT:
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "Fabric FDMI PLOGI returned ELS_LS_RJT reason: 0x%x",
 				     els_rjt->rej.er_reason);
 
@@ -3692,7 +3692,7 @@ static void fdls_process_fdmi_reg_ack(struct fnic_iport_s *iport,
 	uint16_t oxid;
 
 	if (!iport->fabric.fdmi_pending) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 			     "Received FDMI ack while not waiting: 0x%x\n",
 			     FNIC_STD_GET_OX_ID(fchdr));
 		return;
@@ -3702,7 +3702,7 @@ static void fdls_process_fdmi_reg_ack(struct fnic_iport_s *iport,
 
 	if ((iport->active_oxid_fdmi_rhba != oxid) &&
 		(iport->active_oxid_fdmi_rpa != oxid))  {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			"Incorrect OXID in response. oxid recvd: 0x%x, active oxids(rhba,rpa): 0x%x, 0x%x\n",
 			oxid, iport->active_oxid_fdmi_rhba, iport->active_oxid_fdmi_rpa);
 		return;
@@ -3715,13 +3715,13 @@ static void fdls_process_fdmi_reg_ack(struct fnic_iport_s *iport,
 		fdls_free_oxid(iport, oxid, &iport->active_oxid_fdmi_rpa);
 	}
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		"iport fcid: 0x%x: Received FDMI registration ack\n",
 		 iport->fcid);
 
 	if (!iport->fabric.fdmi_pending) {
 		del_timer_sync(&iport->fabric.fdmi_timer);
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "iport fcid: 0x%x: Canceling FDMI timer\n",
 					 iport->fcid);
 	}
@@ -3737,7 +3737,7 @@ static void fdls_process_fdmi_abts_rsp(struct fnic_iport_s *iport,
 	s_id = ntoh24(FNIC_STD_GET_S_ID(fchdr));
 
 	if (!(s_id != FC_FID_MGMT_SERV)) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			     "Received abts rsp with invalid SID: 0x%x. Dropping frame",
 			     s_id);
 		return;
@@ -3756,7 +3756,7 @@ static void fdls_process_fdmi_abts_rsp(struct fnic_iport_s *iport,
 		fdls_free_oxid(iport, oxid, &iport->active_oxid_fdmi_rpa);
 		break;
 	default:
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			"Received abts rsp with invalid oxid: 0x%x. Dropping frame",
 			oxid);
 		break;
@@ -3785,7 +3785,7 @@ fdls_process_fabric_abts_rsp(struct fnic_iport_s *iport,
 
 	if (!((s_id == FC_FID_DIR_SERV) || (s_id == FC_FID_FLOGI)
 		  || (s_id == FC_FID_FCTRL))) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "Received abts rsp with invalid SID: 0x%x. Dropping frame",
 			 s_id);
 		return;
@@ -3793,14 +3793,14 @@ fdls_process_fabric_abts_rsp(struct fnic_iport_s *iport,
 
 	oxid = FNIC_STD_GET_OX_ID(fchdr);
 	if (iport->active_oxid_fabric_req != oxid) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			"Received abts rsp with invalid oxid: 0x%x. Dropping frame",
 			oxid);
 		return;
 	}
 
 	if (iport->fabric.timer_pending) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "Canceling fabric disc timer %p\n", iport);
 		fnic_del_fabric_timer_sync(fnic);
 	}
@@ -3808,11 +3808,11 @@ fdls_process_fabric_abts_rsp(struct fnic_iport_s *iport,
 	iport->fabric.flags &= ~FNIC_FDLS_FABRIC_ABORT_ISSUED;
 
 	if (fchdr->fh_r_ctl == FC_RCTL_BA_ACC) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "Received abts rsp BA_ACC for fabric_state: %d OX_ID: 0x%x",
 		     fabric_state, be16_to_cpu(ba_acc->acc.ba_ox_id));
 	} else if (fchdr->fh_r_ctl == FC_RCTL_BA_RJT) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "BA_RJT fs: %d OX_ID: 0x%x rc: 0x%x rce: 0x%x",
 		     fabric_state, FNIC_STD_GET_OX_ID(&ba_rjt->fchdr),
 		     ba_rjt->rjt.br_reason, ba_rjt->rjt.br_explan);
@@ -3827,7 +3827,7 @@ fdls_process_fabric_abts_rsp(struct fnic_iport_s *iport,
 		if (iport->fabric.retry_counter < iport->max_flogi_retries)
 			fdls_send_fabric_flogi(iport);
 		else
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "Exceeded max FLOGI retries");
 		break;
 	case FNIC_FRAME_TYPE_FABRIC_LOGO:
@@ -3838,7 +3838,7 @@ fdls_process_fabric_abts_rsp(struct fnic_iport_s *iport,
 		if (iport->fabric.retry_counter < iport->max_plogi_retries)
 			fdls_send_fabric_plogi(iport);
 		else
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "Exceeded max PLOGI retries");
 		break;
 	case FNIC_FRAME_TYPE_FABRIC_RPN:
@@ -3852,7 +3852,7 @@ fdls_process_fabric_abts_rsp(struct fnic_iport_s *iport,
 		if (iport->fabric.retry_counter < FDLS_RETRY_COUNT)
 			fdls_send_scr(iport);
 		else {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				"SCR exhausted retries. Start fabric PLOGI %p",
 				 iport);
 			fnic_fdls_start_plogi(iport);	/* go back to fabric Plogi */
@@ -3862,7 +3862,7 @@ fdls_process_fabric_abts_rsp(struct fnic_iport_s *iport,
 		if (iport->fabric.retry_counter < FDLS_RETRY_COUNT)
 			fdls_send_register_fc4_types(iport);
 		else {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				"RFT exhausted retries. Start fabric PLOGI %p",
 				 iport);
 			fnic_fdls_start_plogi(iport);	/* go back to fabric Plogi */
@@ -3872,7 +3872,7 @@ fdls_process_fabric_abts_rsp(struct fnic_iport_s *iport,
 		if (iport->fabric.retry_counter < FDLS_RETRY_COUNT)
 			fdls_send_register_fc4_features(iport);
 		else {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				"RFF exhausted retries. Start fabric PLOGI %p",
 				 iport);
 			fnic_fdls_start_plogi(iport);	/* go back to fabric Plogi */
@@ -3882,7 +3882,7 @@ fdls_process_fabric_abts_rsp(struct fnic_iport_s *iport,
 		if (iport->fabric.retry_counter <= FDLS_RETRY_COUNT)
 			fdls_send_gpn_ft(iport, fabric_state);
 		else
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				"GPN FT exhausted retries. Start fabric PLOGI %p",
 				iport);
 		break;
@@ -3891,7 +3891,7 @@ fdls_process_fabric_abts_rsp(struct fnic_iport_s *iport,
 		 * We should not be here since we already validated rx oxid with
 		 * our active_oxid_fabric_req
 		 */
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			"Invalid OXID/active oxid 0x%x\n", oxid);
 		WARN_ON(true);
 		return;
@@ -3911,7 +3911,7 @@ fdls_process_abts_req(struct fnic_iport_s *iport, struct fc_frame_header *fchdr)
 			sizeof(struct fc_std_abts_ba_acc);
 
 	nport_id = ntoh24(fchdr->fh_s_id);
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "Received abort from SID 0x%8x", nport_id);
 
 	tport = fnic_find_tport_by_fcid(iport, nport_id);
@@ -3925,7 +3925,7 @@ fdls_process_abts_req(struct fnic_iport_s *iport, struct fc_frame_header *fchdr)
 
 	frame = fdls_alloc_frame(iport);
 	if (frame == NULL) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 				"0x%x: Failed to allocate frame to send response for ABTS req",
 				iport->fcid);
 		return;
@@ -3946,7 +3946,7 @@ fdls_process_abts_req(struct fnic_iport_s *iport, struct fc_frame_header *fchdr)
 	pba_acc->acc.ba_rx_id = cpu_to_be16(FNIC_STD_GET_RX_ID(fchdr));
 	pba_acc->acc.ba_ox_id = cpu_to_be16(FNIC_STD_GET_OX_ID(fchdr));
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		 "0x%x: FDLS send BA ACC with oxid: 0x%x",
 		 iport->fcid, oxid);
 
@@ -3966,7 +3966,7 @@ fdls_process_unsupported_els_req(struct fnic_iport_s *iport,
 			sizeof(struct fc_std_els_rjt_rsp);
 
 	if (iport->fcid != d_id) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "Dropping unsupported ELS with illegal frame bits 0x%x\n",
 			 d_id);
 		atomic64_inc(&iport->iport_stats.unsupported_frames_dropped);
@@ -3975,7 +3975,7 @@ fdls_process_unsupported_els_req(struct fnic_iport_s *iport,
 
 	if ((iport->state != FNIC_IPORT_STATE_READY)
 		&& (iport->state != FNIC_IPORT_STATE_FABRIC_DISC)) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "Dropping unsupported ELS request in iport state: %d",
 			 iport->state);
 		atomic64_inc(&iport->iport_stats.unsupported_frames_dropped);
@@ -3984,7 +3984,7 @@ fdls_process_unsupported_els_req(struct fnic_iport_s *iport,
 
 	frame = fdls_alloc_frame(iport);
 	if (frame == NULL) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 			"Failed to allocate frame to send response to unsupported ELS request");
 		return;
 	}
@@ -3992,7 +3992,7 @@ fdls_process_unsupported_els_req(struct fnic_iport_s *iport,
 	pls_rsp = (struct fc_std_els_rjt_rsp *) (frame + FNIC_ETH_FCOE_HDRS_OFFSET);
 	fdls_init_els_rjt_frame(frame, iport);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "0x%x: Process unsupported ELS request from SID: 0x%x",
 		     iport->fcid, ntoh24(fchdr->fh_s_id));
 
@@ -4019,12 +4019,12 @@ fdls_process_rls_req(struct fnic_iport_s *iport, struct fc_frame_header *fchdr)
 	uint16_t frame_size = FNIC_ETH_FCOE_HDRS_OFFSET +
 			sizeof(struct fc_std_rls_acc);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "Process RLS request %d", iport->fnic->fnic_num);
 
 	if ((iport->state != FNIC_IPORT_STATE_READY)
 		&& (iport->state != FNIC_IPORT_STATE_FABRIC_DISC)) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "Received RLS req in iport state: %d. Dropping the frame.",
 			 iport->state);
 		return;
@@ -4032,7 +4032,7 @@ fdls_process_rls_req(struct fnic_iport_s *iport, struct fc_frame_header *fchdr)
 
 	frame = fdls_alloc_frame(iport);
 	if (frame == NULL) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 				"Failed to allocate frame to send RLS accept");
 		return;
 	}
@@ -4073,33 +4073,33 @@ fdls_process_els_req(struct fnic_iport_s *iport, struct fc_frame_header *fchdr,
 
 	if ((iport->state != FNIC_IPORT_STATE_READY)
 		&& (iport->state != FNIC_IPORT_STATE_FABRIC_DISC)) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "Dropping ELS frame type: 0x%x in iport state: %d",
 				 type, iport->state);
 		return;
 	}
 	switch (type) {
 	case ELS_ECHO:
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "sending LS_ACC for ECHO request %d\n",
 					 iport->fnic->fnic_num);
 		break;
 
 	case ELS_RRQ:
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "sending LS_ACC for RRQ request %d\n",
 					 iport->fnic->fnic_num);
 		break;
 
 	default:
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "sending LS_ACC for 0x%x ELS frame\n", type);
 		break;
 	}
 
 	frame = fdls_alloc_frame(iport);
 	if (frame == NULL) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 				"Failed to allocate frame to send ELS response for 0x%x",
 				type);
 		return;
@@ -4145,17 +4145,17 @@ fdls_process_tgt_abts_rsp(struct fnic_iport_s *iport,
 
 	tport = fnic_find_tport_by_fcid(iport, s_id);
 	if (!tport) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 					 "Received tgt abts rsp with invalid SID: 0x%x", s_id);
 		return;
 	}
 	if (tport->timer_pending) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 					 "tport 0x%p Canceling fabric disc timer\n", tport);
 		fnic_del_tport_timer_sync(fnic, tport);
 	}
 	if (iport->state != FNIC_IPORT_STATE_READY) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 					 "Received tgt abts rsp in iport state(%d). Dropping.",
 					 iport->state);
 		return;
@@ -4170,15 +4170,15 @@ fdls_process_tgt_abts_rsp(struct fnic_iport_s *iport,
 	switch (frame_type) {
 	case FNIC_FRAME_TYPE_TGT_ADISC:
 		if (fchdr->fh_r_ctl == FC_RCTL_BA_ACC) {
-			FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 				     "OX_ID: 0x%x tgt_fcid: 0x%x rcvd tgt adisc abts resp BA_ACC",
 				     be16_to_cpu(ba_acc->acc.ba_ox_id),
 				     tport->fcid);
 		} else if (fchdr->fh_r_ctl == FC_RCTL_BA_RJT) {
-			FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 				 "ADISC BA_RJT rcvd tport_fcid: 0x%x tport_state: %d ",
 				 tport->fcid, tport_state);
-			FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 				 "reason code: 0x%x reason code explanation:0x%x ",
 				     ba_rjt->rjt.br_reason,
 				     ba_rjt->rjt.br_explan);
@@ -4190,7 +4190,7 @@ fdls_process_tgt_abts_rsp(struct fnic_iport_s *iport,
 			return;
 		}
 		fdls_free_oxid(iport, oxid, &tport->active_oxid);
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 					 "ADISC not responding. Deleting target port: 0x%x",
 					 tport->fcid);
 		fdls_delete_tport(iport, tport);
@@ -4203,14 +4203,14 @@ fdls_process_tgt_abts_rsp(struct fnic_iport_s *iport,
 		break;
 	case FNIC_FRAME_TYPE_TGT_PLOGI:
 		if (fchdr->fh_r_ctl == FC_RCTL_BA_ACC) {
-			FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 				 "Received tgt PLOGI abts response BA_ACC tgt_fcid: 0x%x",
 				 tport->fcid);
 		} else if (fchdr->fh_r_ctl == FC_RCTL_BA_RJT) {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "PLOGI BA_RJT received for tport_fcid: 0x%x OX_ID: 0x%x",
 				     tport->fcid, FNIC_STD_GET_OX_ID(fchdr));
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "reason code: 0x%x reason code explanation: 0x%x",
 				     ba_rjt->rjt.br_reason,
 				     ba_rjt->rjt.br_explan);
@@ -4233,14 +4233,14 @@ fdls_process_tgt_abts_rsp(struct fnic_iport_s *iport,
 		break;
 	case FNIC_FRAME_TYPE_TGT_PRLI:
 		if (fchdr->fh_r_ctl == FC_RCTL_BA_ACC) {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "0x%x: Received tgt PRLI abts response BA_ACC",
 				 tport->fcid);
 		} else if (fchdr->fh_r_ctl == FC_RCTL_BA_RJT) {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "PRLI BA_RJT received for tport_fcid: 0x%x OX_ID: 0x%x ",
 				     tport->fcid, FNIC_STD_GET_OX_ID(fchdr));
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "reason code: 0x%x reason code explanation: 0x%x",
 				     ba_rjt->rjt.br_reason,
 				     ba_rjt->rjt.br_explan);
@@ -4256,7 +4256,7 @@ fdls_process_tgt_abts_rsp(struct fnic_iport_s *iport,
 		fdls_set_tport_state(tport, FDLS_TGT_STATE_PLOGI);
 		break;
 	default:
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			"Received ABTS response for unknown frame %p", iport);
 		break;
 	}
@@ -4276,14 +4276,14 @@ fdls_process_plogi_req(struct fnic_iport_s *iport,
 			sizeof(struct fc_std_els_rjt_rsp);
 
 	if (iport->fcid != d_id) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "Received PLOGI with illegal frame bits. Dropping frame from 0x%x",
 			 d_id);
 		return;
 	}
 
 	if (iport->state != FNIC_IPORT_STATE_READY) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "Received PLOGI request in iport state: %d Dropping frame",
 			 iport->state);
 		return;
@@ -4291,7 +4291,7 @@ fdls_process_plogi_req(struct fnic_iport_s *iport,
 
 	frame = fdls_alloc_frame(iport);
 	if (frame == NULL) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 			"Failed to allocate frame to send response to PLOGI request");
 		return;
 	}
@@ -4299,7 +4299,7 @@ fdls_process_plogi_req(struct fnic_iport_s *iport,
 	pplogi_rsp = (struct fc_std_els_rjt_rsp *) (frame + FNIC_ETH_FCOE_HDRS_OFFSET);
 	fdls_init_els_rjt_frame(frame, iport);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "0x%x: Process PLOGI request from SID: 0x%x",
 				 iport->fcid, ntoh24(fchdr->fh_s_id));
 
@@ -4329,11 +4329,11 @@ fdls_process_logo_req(struct fnic_iport_s *iport, struct fc_frame_header *fchdr)
 	nport_id = ntoh24(logo->els.fl_n_port_id);
 	nport_name = be64_to_cpu(logo->els.fl_n_port_wwn);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "Process LOGO request from fcid: 0x%x", nport_id);
 
 	if (iport->state != FNIC_IPORT_STATE_READY) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 			 "Dropping LOGO req from 0x%x in iport state: %d",
 			 nport_id, iport->state);
 		return;
@@ -4343,19 +4343,19 @@ fdls_process_logo_req(struct fnic_iport_s *iport, struct fc_frame_header *fchdr)
 
 	if (!tport) {
 		/* We are not logged in with the nport, log and drop... */
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 			 "Received LOGO from an nport not logged in: 0x%x(0x%llx)",
 			 nport_id, nport_name);
 		return;
 	}
 	if (tport->fcid != nport_id) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 		 "Received LOGO with invalid target port fcid: 0x%x(0x%llx)",
 		 nport_id, nport_name);
 		return;
 	}
 	if (tport->timer_pending) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 					 "tport fcid 0x%x: Canceling disc timer\n",
 					 tport->fcid);
 		fnic_del_tport_timer_sync(fnic, tport);
@@ -4372,7 +4372,7 @@ fdls_process_logo_req(struct fnic_iport_s *iport, struct fc_frame_header *fchdr)
 		if ((iport->state == FNIC_IPORT_STATE_READY)
 			&& (fdls_get_state(&iport->fabric) != FDLS_STATE_SEND_GPNFT)
 			&& (fdls_get_state(&iport->fabric) != FDLS_STATE_RSCN_GPN_FT)) {
-			FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 						 "Sending GPNFT in response to LOGO from Target:0x%x",
 						 nport_id);
 			fdls_send_gpn_ft(iport, FDLS_STATE_SEND_GPNFT);
@@ -4385,7 +4385,7 @@ fdls_process_logo_req(struct fnic_iport_s *iport, struct fc_frame_header *fchdr)
 		fdls_send_logo_resp(iport, &logo->fchdr);
 		if ((fdls_get_state(&iport->fabric) != FDLS_STATE_SEND_GPNFT) &&
 			(fdls_get_state(&iport->fabric) != FDLS_STATE_RSCN_GPN_FT)) {
-			FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 						 "Sending GPNFT in response to LOGO from Target:0x%x",
 						 nport_id);
 			fdls_send_gpn_ft(iport, FDLS_STATE_SEND_GPNFT);
@@ -4409,11 +4409,11 @@ fdls_process_rscn(struct fnic_iport_s *iport, struct fc_frame_header *fchdr)
 
 	atomic64_inc(&iport->iport_stats.num_rscns);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "FDLS process RSCN %p", iport);
 
 	if (iport->state != FNIC_IPORT_STATE_READY) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "FDLS RSCN received in state(%d). Dropping",
 					 fdls_get_state(fdls));
 		return;
@@ -4427,21 +4427,21 @@ fdls_process_rscn(struct fnic_iport_s *iport, struct fc_frame_header *fchdr)
 	    || (rscn_payload_len > 1024)
 	    || (rscn->els.rscn_page_len != 4)) {
 		num_ports = 0;
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "RSCN payload_len: 0x%x page_len: 0x%x",
 				     rscn_payload_len, rscn->els.rscn_page_len);
 		/* if this happens then we need to send ADISC to all the tports. */
 		list_for_each_entry_safe(tport, next, &iport->tport_list, links) {
 			if (tport->state == FDLS_TGT_STATE_READY)
 				tport->flags |= FNIC_FDLS_TPORT_SEND_ADISC;
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "RSCN for port id: 0x%x", tport->fcid);
 		}
 	} else {
 		num_ports = (rscn_payload_len - 4) / rscn->els.rscn_page_len;
 		rscn_port = (struct fc_els_rscn_page *)(rscn + 1);
 	}
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "RSCN received for num_ports: %d payload_len: %d page_len: %d ",
 		     num_ports, rscn_payload_len, rscn->els.rscn_page_len);
 
@@ -4465,14 +4465,14 @@ fdls_process_rscn(struct fnic_iport_s *iport, struct fc_frame_header *fchdr)
 				if (tport->state == FDLS_TGT_STATE_READY)
 					tport->flags |= FNIC_FDLS_TPORT_SEND_ADISC;
 
-				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 							 "RSCN for port id: 0x%x", tport->fcid);
 			}
 			break;
 		}
 		tport = fnic_find_tport_by_fcid(iport, nport_id);
 
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "RSCN port id list: 0x%x", nport_id);
 
 		if (!tport) {
@@ -4483,7 +4483,7 @@ fdls_process_rscn(struct fnic_iport_s *iport, struct fc_frame_header *fchdr)
 			tport->flags |= FNIC_FDLS_TPORT_SEND_ADISC;
 	}
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		 "FDLS process RSCN sending GPN_FT: newports: %d", newports);
 		fdls_send_gpn_ft(iport, FDLS_STATE_RSCN_GPN_FT);
 		fdls_send_rscn_resp(iport, fchdr);
@@ -4494,8 +4494,8 @@ void fnic_fdls_disc_start(struct fnic_iport_s *iport)
 	struct fnic *fnic = iport->fnic;
 
 	if (IS_FNIC_FCP_INITIATOR(fnic)) {
-		fc_host_fabric_name(iport->fnic->lport->host) = 0;
-		fc_host_post_event(iport->fnic->lport->host, fc_get_event_number(),
+		fc_host_fabric_name(iport->fnic->host) = 0;
+		fc_host_post_event(iport->fnic->host, fc_get_event_number(),
 						   FCH_EVT_LIPRESET, 0);
 	}
 
@@ -4533,20 +4533,20 @@ fdls_process_adisc_req(struct fnic_iport_s *iport,
 	uint16_t acc_frame_size = FNIC_ETH_FCOE_HDRS_OFFSET +
 			sizeof(struct fc_std_els_adisc);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "Process ADISC request %d", iport->fnic->fnic_num);
 
 	fcid = FNIC_STD_GET_S_ID(fchdr);
 	tgt_fcid = ntoh24(fcid);
 	tport = fnic_find_tport_by_fcid(iport, tgt_fcid);
 	if (!tport) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 					 "tport for fcid: 0x%x not found. Dropping ADISC req.",
 					 tgt_fcid);
 		return;
 	}
 	if (iport->state != FNIC_IPORT_STATE_READY) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 			 "Dropping ADISC req from fcid: 0x%x in iport state: %d",
 			 tgt_fcid, iport->state);
 		return;
@@ -4557,16 +4557,16 @@ fdls_process_adisc_req(struct fnic_iport_s *iport,
 
 	if ((frame_wwnn != tport->wwnn) || (frame_wwpn != tport->wwpn)) {
 		/* send reject */
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 			 "ADISC req from fcid: 0x%x mismatch wwpn: 0x%llx wwnn: 0x%llx",
 			 tgt_fcid, frame_wwpn, frame_wwnn);
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 			 "local tport wwpn: 0x%llx wwnn: 0x%llx. Sending RJT",
 			 tport->wwpn, tport->wwnn);
 
 		rjt_frame = fdls_alloc_frame(iport);
 		if (rjt_frame == NULL) {
-			FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 				"Failed to allocate rjt_frame to send response to ADISC request");
 			return;
 		}
@@ -4589,7 +4589,7 @@ fdls_process_adisc_req(struct fnic_iport_s *iport,
 
 	acc_frame = fdls_alloc_frame(iport);
 	if (acc_frame == NULL) {
-		FNIC_FCS_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 				"Failed to allocate frame to send ADISC accept");
 		return;
 	}
@@ -4643,7 +4643,7 @@ fnic_fdls_validate_and_get_frame_type(struct fnic_iport_s *iport,
 	/* some common validation */
 		if (fdls_get_state(fabric) > FDLS_STATE_FABRIC_FLOGI) {
 			if ((iport->fcid != d_id) || (!FNIC_FC_FRAME_CS_CTL(fchdr))) {
-				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 							 "invalid frame received. Dropping frame");
 				return -1;
 			}
@@ -4653,14 +4653,14 @@ fnic_fdls_validate_and_get_frame_type(struct fnic_iport_s *iport,
 	if ((fchdr->fh_r_ctl == FC_RCTL_BA_ACC)
 	|| (fchdr->fh_r_ctl == FC_RCTL_BA_RJT)) {
 		if (!(FNIC_FC_FRAME_TYPE_BLS(fchdr))) {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 						 "Received ABTS invalid frame. Dropping frame");
 			return -1;
 
 		}
 		if (fdls_is_oxid_fabric_req(oxid)) {
 			if (!(iport->fabric.flags & FNIC_FDLS_FABRIC_ABORT_ISSUED)) {
-				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					"Received unexpected ABTS RSP(oxid:0x%x) from 0x%x. Dropping frame",
 					oxid, s_id);
 				return -1;
@@ -4671,7 +4671,7 @@ fnic_fdls_validate_and_get_frame_type(struct fnic_iport_s *iport,
 		} else if (fdls_is_oxid_tgt_req(oxid)) {
 			return FNIC_TPORT_BLS_ABTS_RSP;
 		}
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			"Received ABTS rsp with unknown oxid(0x%x) from 0x%x. Dropping frame",
 			oxid, s_id);
 		return -1;
@@ -4680,7 +4680,7 @@ fnic_fdls_validate_and_get_frame_type(struct fnic_iport_s *iport,
 	/* BLS ABTS Req */
 	if ((fchdr->fh_r_ctl == FC_RCTL_BA_ABTS)
 	&& (FNIC_FC_FRAME_TYPE_BLS(fchdr))) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "Receiving Abort Request from s_id: 0x%x", s_id);
 		return FNIC_BLS_ABTS_REQ;
 	}
@@ -4692,7 +4692,7 @@ fnic_fdls_validate_and_get_frame_type(struct fnic_iport_s *iport,
 			if ((!FNIC_FC_FRAME_FCTL_FIRST_LAST_SEQINIT(fchdr))
 				|| (!FNIC_FC_FRAME_UNSOLICITED(fchdr))
 				|| (!FNIC_FC_FRAME_TYPE_ELS(fchdr))) {
-				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 							 "Received LOGO invalid frame. Dropping frame");
 				return -1;
 			}
@@ -4701,12 +4701,12 @@ fnic_fdls_validate_and_get_frame_type(struct fnic_iport_s *iport,
 			if ((!FNIC_FC_FRAME_FCTL_FIRST_LAST_SEQINIT(fchdr))
 				|| (!FNIC_FC_FRAME_TYPE_ELS(fchdr))
 				|| (!FNIC_FC_FRAME_UNSOLICITED(fchdr))) {
-				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 						 "Received RSCN invalid FCTL. Dropping frame");
 				return -1;
 			}
 			if (s_id != FC_FID_FCTRL)
-				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				     "Received RSCN from target FCTL: 0x%x type: 0x%x s_id: 0x%x.",
 				     fchdr->fh_f_ctl[0], fchdr->fh_type, s_id);
 			return FNIC_ELS_RSCN_REQ;
@@ -4721,7 +4721,7 @@ fnic_fdls_validate_and_get_frame_type(struct fnic_iport_s *iport,
 		case ELS_RRQ:
 			return FNIC_ELS_RRQ;
 		default:
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "Unsupported frame (type:0x%02x) from fcid: 0x%x",
 				 type, s_id);
 			return FNIC_ELS_UNSUPPORTED_REQ;
@@ -4730,14 +4730,14 @@ fnic_fdls_validate_and_get_frame_type(struct fnic_iport_s *iport,
 
 	/* solicited response from fabric or target */
 	oxid_frame_type = FNIC_FRAME_TYPE(oxid);
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			"oxid frame code: 0x%x, oxid: 0x%x\n", oxid_frame_type, oxid);
 	switch (oxid_frame_type) {
 	case FNIC_FRAME_TYPE_FABRIC_FLOGI:
 		if (type == ELS_LS_ACC) {
 			if ((s_id != FC_FID_FLOGI)
 				|| (!FNIC_FC_FRAME_TYPE_ELS(fchdr))) {
-				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "Received unknown frame. Dropping frame");
 				return -1;
 			}
@@ -4748,7 +4748,7 @@ fnic_fdls_validate_and_get_frame_type(struct fnic_iport_s *iport,
 		if (type == ELS_LS_ACC) {
 			if ((s_id != FC_FID_DIR_SERV)
 				|| (!FNIC_FC_FRAME_TYPE_ELS(fchdr))) {
-				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "Received unknown frame. Dropping frame");
 				return -1;
 			}
@@ -4759,7 +4759,7 @@ fnic_fdls_validate_and_get_frame_type(struct fnic_iport_s *iport,
 		if (type == ELS_LS_ACC) {
 			if ((s_id != FC_FID_FCTRL)
 				|| (!FNIC_FC_FRAME_TYPE_ELS(fchdr))) {
-				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "Received unknown frame. Dropping frame");
 				return -1;
 			}
@@ -4768,7 +4768,7 @@ fnic_fdls_validate_and_get_frame_type(struct fnic_iport_s *iport,
 
 	case FNIC_FRAME_TYPE_FABRIC_RPN:
 		if ((s_id != FC_FID_DIR_SERV) || (!FNIC_FC_FRAME_TYPE_FC_GS(fchdr))) {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "Received unknown frame. Dropping frame");
 			return -1;
 		}
@@ -4776,7 +4776,7 @@ fnic_fdls_validate_and_get_frame_type(struct fnic_iport_s *iport,
 
 	case FNIC_FRAME_TYPE_FABRIC_RFT:
 		if ((s_id != FC_FID_DIR_SERV) || (!FNIC_FC_FRAME_TYPE_FC_GS(fchdr))) {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "Received unknown frame. Dropping frame");
 			return -1;
 		}
@@ -4784,7 +4784,7 @@ fnic_fdls_validate_and_get_frame_type(struct fnic_iport_s *iport,
 
 	case FNIC_FRAME_TYPE_FABRIC_RFF:
 		if ((s_id != FC_FID_DIR_SERV) || (!FNIC_FC_FRAME_TYPE_FC_GS(fchdr))) {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "Received unknown frame. Dropping frame");
 			return -1;
 		}
@@ -4792,7 +4792,7 @@ fnic_fdls_validate_and_get_frame_type(struct fnic_iport_s *iport,
 
 	case FNIC_FRAME_TYPE_FABRIC_GPN_FT:
 		if ((s_id != FC_FID_DIR_SERV) || (!FNIC_FC_FRAME_TYPE_FC_GS(fchdr))) {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "Received unknown frame. Dropping frame");
 			return -1;
 		}
@@ -4814,7 +4814,7 @@ fnic_fdls_validate_and_get_frame_type(struct fnic_iport_s *iport,
 		return FNIC_TPORT_ADISC_RSP;
 	case FNIC_FRAME_TYPE_TGT_LOGO:
 		if (!FNIC_FC_FRAME_TYPE_ELS(fchdr)) {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				"Dropping Unknown frame in tport solicited exchange range type: 0x%x.",
 				     fchdr->fh_type);
 			return -1;
@@ -4822,7 +4822,7 @@ fnic_fdls_validate_and_get_frame_type(struct fnic_iport_s *iport,
 		return FNIC_TPORT_LOGO_RSP;
 	default:
 		/* Drop the Rx frame and log/stats it */
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "Solicited response: unknown OXID: 0x%x", oxid);
 		return -1;
 	}
@@ -4892,7 +4892,7 @@ void fnic_fdls_recv_frame(struct fnic_iport_s *iport, void *rx_frame,
 		break;
 	case FNIC_TPORT_LOGO_RSP:
 		/* Logo response from tgt which we have deleted */
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "Logo response from tgt: 0x%x",
 			     ntoh24(fchdr->fh_s_id));
 		break;
@@ -4935,9 +4935,9 @@ void fnic_fdls_recv_frame(struct fnic_iport_s *iport, void *rx_frame,
 		fdls_process_fdmi_reg_ack(iport, fchdr, frame_type);
 		break;
 	default:
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "s_id: 0x%x d_did: 0x%x", s_id, d_id);
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "Received unknown FCoE frame of len: %d. Dropping frame", len);
 		break;
 	}
@@ -4954,7 +4954,7 @@ void fnic_fdls_link_down(struct fnic_iport_s *iport)
 	struct fnic_tport_s *tport, *next;
 	struct fnic *fnic = iport->fnic;
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "0x%x: FDLS processing link down", iport->fcid);
 
 	fdls_set_state((&iport->fabric), FDLS_STATE_LINKDOWN);
@@ -4965,7 +4965,7 @@ void fnic_fdls_link_down(struct fnic_iport_s *iport)
 		fnic_scsi_fcpio_reset(iport->fnic);
 		spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
 		list_for_each_entry_safe(tport, next, &iport->tport_list, links) {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 						 "removing rport: 0x%x", tport->fcid);
 			fdls_delete_tport(iport, tport);
 		}
@@ -4976,6 +4976,6 @@ void fnic_fdls_link_down(struct fnic_iport_s *iport)
 		iport->fabric.fdmi_pending = 0;
 	}
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "0x%x: FDLS finish processing link down", iport->fcid);
 }
diff --git a/drivers/scsi/fnic/fip.c b/drivers/scsi/fnic/fip.c
index 31b3f3f6d192..161075e3bb95 100644
--- a/drivers/scsi/fnic/fip.c
+++ b/drivers/scsi/fnic/fip.c
@@ -29,7 +29,7 @@ void fnic_fcoe_reset_vlans(struct fnic *fnic)
 	}
 
 	spin_unlock_irqrestore(&fnic->vlans_lock, flags);
-	FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FIP_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		     "Reset vlan complete\n");
 }
 
@@ -48,7 +48,7 @@ void fnic_fcoe_send_vlan_req(struct fnic *fnic)
 
 	frame = fdls_alloc_frame(iport);
 	if (frame == NULL) {
-		FNIC_FIP_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FIP_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 		     "Failed to allocate frame to send VLAN req");
 		return;
 	}
@@ -56,10 +56,10 @@ void fnic_fcoe_send_vlan_req(struct fnic *fnic)
 	fnic_fcoe_reset_vlans(fnic);
 
 	fnic->set_vlan(fnic, 0);
-	FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FIP_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		     "set vlan done\n");
 
-	FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FIP_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		     "got MAC 0x%x:%x:%x:%x:%x:%x\n", iport->hwmac[0],
 		     iport->hwmac[1], iport->hwmac[2], iport->hwmac[3],
 		     iport->hwmac[4], iport->hwmac[5]);
@@ -83,13 +83,13 @@ void fnic_fcoe_send_vlan_req(struct fnic *fnic)
 
 	iport->fip.state = FDLS_FIP_VLAN_DISCOVERY_STARTED;
 
-	FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FIP_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		     "Send VLAN req\n");
 	fnic_send_fip_frame(iport, frame, frame_size);
 
 	vlan_tov = jiffies + msecs_to_jiffies(FCOE_CTLR_FIPVLAN_TOV);
 	mod_timer(&fnic->retry_fip_timer, round_jiffies(vlan_tov));
-	FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FIP_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		     "fip timer set\n");
 }
 
@@ -113,11 +113,11 @@ void fnic_fcoe_process_vlan_resp(struct fnic *fnic, struct fip_header *fiph)
 	struct fip_vlan_desc *vlan_desc;
 	unsigned long flags;
 
-	FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FIP_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		     "fnic 0x%p got vlan resp\n", fnic);
 
 	desc_len = be16_to_cpu(vlan_notif->fip.fip_dl_len);
-	FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FIP_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		     "desc_len %d\n", desc_len);
 
 	spin_lock_irqsave(&fnic->vlans_lock, flags);
@@ -130,7 +130,7 @@ void fnic_fcoe_process_vlan_resp(struct fnic *fnic, struct fip_header *fiph)
 
 		if (vlan_desc->fd_desc.fip_dtype == FIP_DT_VLAN) {
 			if (vlan_desc->fd_desc.fip_dlen != 1) {
-				FNIC_FIP_DBG(KERN_INFO, fnic->lport->host,
+				FNIC_FIP_DBG(KERN_INFO, fnic->host,
 					     fnic->fnic_num,
 					     "Invalid descriptor length(%x) in VLan response\n",
 					     vlan_desc->fd_desc.fip_dlen);
@@ -138,14 +138,14 @@ void fnic_fcoe_process_vlan_resp(struct fnic *fnic, struct fip_header *fiph)
 			}
 			num_vlan++;
 			vid = be16_to_cpu(vlan_desc->fd_vlan);
-			FNIC_FIP_DBG(KERN_INFO, fnic->lport->host,
+			FNIC_FIP_DBG(KERN_INFO, fnic->host,
 				     fnic->fnic_num,
 				     "process_vlan_resp: FIP VLAN %d\n", vid);
 			vlan = kzalloc(sizeof(*vlan), GFP_KERNEL);
 
 			if (!vlan) {
 				/* retry from timer */
-				FNIC_FIP_DBG(KERN_INFO, fnic->lport->host,
+				FNIC_FIP_DBG(KERN_INFO, fnic->host,
 					     fnic->fnic_num,
 					     "Mem Alloc failure\n");
 				spin_unlock_irqrestore(&fnic->vlans_lock,
@@ -157,7 +157,7 @@ void fnic_fcoe_process_vlan_resp(struct fnic *fnic, struct fip_header *fiph)
 			list_add_tail(&vlan->list, &fnic->vlan_list);
 			break;
 		} else {
-			FNIC_FIP_DBG(KERN_INFO, fnic->lport->host,
+			FNIC_FIP_DBG(KERN_INFO, fnic->host,
 				     fnic->fnic_num,
 				     "Invalid descriptor type(%x) in VLan response\n",
 				     vlan_desc->fd_desc.fip_dtype);
@@ -173,7 +173,7 @@ void fnic_fcoe_process_vlan_resp(struct fnic *fnic, struct fip_header *fiph)
 	/* any VLAN descriptors present ? */
 	if (num_vlan == 0) {
 		atomic64_inc(&fnic_stats->vlan_stats.resp_withno_vlanID);
-		FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FIP_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			     "fnic 0x%p No VLAN descriptors in FIP VLAN response\n",
 			     fnic);
 	}
@@ -198,7 +198,7 @@ void fnic_fcoe_start_fcf_discovery(struct fnic *fnic)
 
 	frame = fdls_alloc_frame(iport);
 	if (frame == NULL) {
-		FNIC_FIP_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FIP_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 		     "Failed to allocate frame to start FCF discovery");
 		return;
 	}
@@ -225,7 +225,7 @@ void fnic_fcoe_start_fcf_discovery(struct fnic *fnic)
 
 	FNIC_STD_SET_NODE_NAME(&pdisc_sol->name_desc.fd_wwn, iport->wwnn);
 
-	FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FIP_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		     "Start FCF discovery\n");
 	fnic_send_fip_frame(iport, frame, frame_size);
 
@@ -260,7 +260,7 @@ void fnic_fcoe_fip_discovery_resp(struct fnic *fnic, struct fip_header *fiph)
 	switch (iport->fip.state) {
 	case FDLS_FIP_FCF_DISCOVERY_STARTED:
 		if (be16_to_cpu(disc_adv->fip.fip_flags) & FIP_FL_SOL) {
-			FNIC_FIP_DBG(KERN_INFO, fnic->lport->host,
+			FNIC_FIP_DBG(KERN_INFO, fnic->host,
 				     fnic->fnic_num,
 				     "fnic 0x%p Solicited adv\n", fnic);
 
@@ -268,7 +268,7 @@ void fnic_fcoe_fip_discovery_resp(struct fnic *fnic, struct fip_header *fiph)
 			     iport->selected_fcf.fcf_priority)
 			    && (be16_to_cpu(disc_adv->fip.fip_flags) & FIP_FL_AVAIL)) {
 
-				FNIC_FIP_DBG(KERN_INFO, fnic->lport->host,
+				FNIC_FIP_DBG(KERN_INFO, fnic->host,
 					     fnic->fnic_num,
 					     "fnic 0x%p FCF Available\n", fnic);
 				memcpy(iport->selected_fcf.fcf_mac,
@@ -277,7 +277,7 @@ void fnic_fcoe_fip_discovery_resp(struct fnic *fnic, struct fip_header *fiph)
 				    disc_adv->prio_desc.fd_pri;
 				iport->selected_fcf.fka_adv_period =
 				    be32_to_cpu(disc_adv->fka_adv_desc.fd_fka_period);
-				FNIC_FIP_DBG(KERN_INFO, fnic->lport->host,
+				FNIC_FIP_DBG(KERN_INFO, fnic->host,
 					     fnic->fnic_num, "adv time %d",
 					     iport->selected_fcf.fka_adv_period);
 				iport->selected_fcf.ka_disabled =
@@ -297,7 +297,7 @@ void fnic_fcoe_fip_discovery_resp(struct fnic *fnic, struct fip_header *fiph)
 					iport->selected_fcf.fka_adv_period =
 					    be32_to_cpu(disc_adv->fka_adv_desc.fd_fka_period);
 					FNIC_FIP_DBG(KERN_INFO,
-						     fnic->lport->host,
+						     fnic->host,
 						     fnic->fnic_num,
 						     "change fka to %d",
 						     iport->selected_fcf.fka_adv_period);
@@ -365,7 +365,7 @@ void fnic_fcoe_start_flogi(struct fnic *fnic)
 
 	frame = fdls_alloc_frame(iport);
 	if (frame == NULL) {
-		FNIC_FIP_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FIP_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 		     "Failed to allocate frame to start FIP FLOGI");
 		return;
 	}
@@ -418,7 +418,7 @@ void fnic_fcoe_start_flogi(struct fnic *fnic)
 	oxid = fdls_alloc_oxid(iport, FNIC_FRAME_TYPE_FABRIC_FLOGI,
 		&iport->active_oxid_fabric_req);
 	if (oxid == FNIC_UNASSIGNED_OXID) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		     "Failed to allocate OXID to send FIP FLOGI");
 		mempool_free(frame, fnic->frame_pool);
 		return;
@@ -430,7 +430,7 @@ void fnic_fcoe_start_flogi(struct fnic *fnic)
 	FNIC_STD_SET_NODE_NAME(&pflogi_req->flogi_desc.flogi.els.fl_wwnn,
 			iport->wwnn);
 
-	FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FIP_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		     "FIP start FLOGI\n");
 	fnic_send_fip_frame(iport, frame, frame_size);
 	iport->fip.flogi_retry++;
@@ -460,11 +460,11 @@ void fnic_fcoe_process_flogi_resp(struct fnic *fnic, struct fip_header *fiph)
 	struct fnic_stats *fnic_stats = &fnic->fnic_stats;
 	struct fc_frame_header *fchdr = &flogi_rsp->rsp_desc.flogi.fchdr;
 
-	FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FIP_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		     "fnic 0x%p FIP FLOGI rsp\n", fnic);
 	desc_len = be16_to_cpu(flogi_rsp->fip.fip_dl_len);
 	if (desc_len != 38) {
-		FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FIP_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			     "Invalid Descriptor List len (%x). Dropping frame\n",
 			     desc_len);
 		return;
@@ -474,7 +474,7 @@ void fnic_fcoe_process_flogi_resp(struct fnic *fnic, struct fip_header *fiph)
 	      && (flogi_rsp->rsp_desc.fd_desc.fip_dlen == 36))
 	    || !((flogi_rsp->mac_desc.fd_desc.fip_dtype == 2)
 		 && (flogi_rsp->mac_desc.fd_desc.fip_dlen == 2))) {
-		FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FIP_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			     "Dropping frame invalid type and len mix\n");
 		return;
 	}
@@ -487,7 +487,7 @@ void fnic_fcoe_process_flogi_resp(struct fnic *fnic, struct fip_header *fiph)
 	    || (s_id != FC_FID_FLOGI)
 	    || (frame_type != FNIC_FABRIC_FLOGI_RSP)
 	    || (fchdr->fh_type != 0x01)) {
-		FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FIP_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			     "Dropping invalid frame: s_id %x F %x R %x t %x OX_ID %x\n",
 			     s_id, fchdr->fh_f_ctl[0], fchdr->fh_r_ctl,
 			     fchdr->fh_type, FNIC_STD_GET_OX_ID(fchdr));
@@ -495,7 +495,7 @@ void fnic_fcoe_process_flogi_resp(struct fnic *fnic, struct fip_header *fiph)
 	}
 
 	if (iport->fip.state == FDLS_FIP_FLOGI_STARTED) {
-		FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FIP_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			     "fnic 0x%p rsp for pending FLOGI\n", fnic);
 
 		oxid = FNIC_STD_GET_OX_ID(fchdr);
@@ -505,7 +505,7 @@ void fnic_fcoe_process_flogi_resp(struct fnic *fnic, struct fip_header *fiph)
 		if ((be16_to_cpu(flogi_rsp->fip.fip_dl_len) == FIP_FLOGI_LEN)
 		    && (flogi_rsp->rsp_desc.flogi.els.fl_cmd == ELS_LS_ACC)) {
 
-			FNIC_FIP_DBG(KERN_INFO, fnic->lport->host,
+			FNIC_FIP_DBG(KERN_INFO, fnic->host,
 				     fnic->fnic_num,
 				     "fnic 0x%p FLOGI success\n", fnic);
 			memcpy(iport->fpma, flogi_rsp->mac_desc.fd_mac, ETH_ALEN);
@@ -522,7 +522,7 @@ void fnic_fcoe_process_flogi_resp(struct fnic *fnic, struct fip_header *fiph)
 
 			if (fnic_fdls_register_portid(iport, iport->fcid, NULL)
 			    != 0) {
-				FNIC_FIP_DBG(KERN_INFO, fnic->lport->host,
+				FNIC_FIP_DBG(KERN_INFO, fnic->host,
 					     fnic->fnic_num,
 					     "fnic 0x%p flogi registration failed\n",
 					     fnic);
@@ -531,7 +531,7 @@ void fnic_fcoe_process_flogi_resp(struct fnic *fnic, struct fip_header *fiph)
 
 			iport->fip.state = FDLS_FIP_FLOGI_COMPLETE;
 			iport->state = FNIC_IPORT_STATE_FABRIC_DISC;
-			FNIC_FIP_DBG(KERN_INFO, fnic->lport->host,
+			FNIC_FIP_DBG(KERN_INFO, fnic->host,
 				     fnic->fnic_num, "iport->state:%d\n",
 				     iport->state);
 			fnic_fdls_disc_start(iport);
@@ -578,7 +578,7 @@ void fnic_common_fip_cleanup(struct fnic *fnic)
 
 	if (!iport->usefip)
 		return;
-	FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FIP_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		     "fnic 0x%p fip cleanup\n", fnic);
 
 	iport->fip.state = FDLS_FIP_INIT;
@@ -620,7 +620,7 @@ void fnic_fcoe_process_cvl(struct fnic *fnic, struct fip_header *fiph)
 	int found = false;
 	int max_count = 0;
 
-	FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FIP_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		     "fnic 0x%p clear virtual link handler\n", fnic);
 
 	if (!((cvl_msg->fcf_mac_desc.fd_desc.fip_dtype == 2)
@@ -628,7 +628,7 @@ void fnic_fcoe_process_cvl(struct fnic *fnic, struct fip_header *fiph)
 	    || !((cvl_msg->name_desc.fd_desc.fip_dtype == 4)
 		 && (cvl_msg->name_desc.fd_desc.fip_dlen == 3))) {
 
-		FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FIP_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			     "invalid mix: ft %x fl %x ndt %x ndl %x",
 			     cvl_msg->fcf_mac_desc.fd_desc.fip_dtype,
 			     cvl_msg->fcf_mac_desc.fd_desc.fip_dlen,
@@ -643,7 +643,7 @@ void fnic_fcoe_process_cvl(struct fnic *fnic, struct fip_header *fiph)
 			if (!((cvl_msg->vn_ports_desc[i].fd_desc.fip_dtype == 11)
 			      && (cvl_msg->vn_ports_desc[i].fd_desc.fip_dlen == 5))) {
 
-				FNIC_FIP_DBG(KERN_INFO, fnic->lport->host,
+				FNIC_FIP_DBG(KERN_INFO, fnic->host,
 					     fnic->fnic_num,
 					     "Invalid type and len mix type: %d len: %d\n",
 					     cvl_msg->vn_ports_desc[i].fd_desc.fip_dtype,
@@ -667,12 +667,12 @@ void fnic_fcoe_process_cvl(struct fnic *fnic, struct fip_header *fiph)
 			spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
 			max_count++;
 			if (max_count >= FIP_FNIC_RESET_WAIT_COUNT) {
-				FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				FNIC_FIP_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "Rthr waited too long. Skipping handle link event %p\n",
 					 fnic);
 				return;
 			}
-			FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FIP_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "fnic reset in progress. Link event needs to wait %p",
 				 fnic);
 		}
@@ -717,7 +717,7 @@ int fdls_fip_recv_frame(struct fnic *fnic, void *frame)
 		return true;
 	}
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		"Not a FIP Frame");
 	return false;
 }
@@ -727,7 +727,7 @@ void fnic_work_on_fip_timer(struct work_struct *work)
 	struct fnic *fnic = container_of(work, struct fnic, fip_timer_work);
 	struct fnic_iport_s *iport = &fnic->iport;
 
-	FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FIP_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		     "FIP timeout\n");
 
 	if (iport->fip.state == FDLS_FIP_VLAN_DISCOVERY_STARTED) {
@@ -735,7 +735,7 @@ void fnic_work_on_fip_timer(struct work_struct *work)
 	} else if (iport->fip.state == FDLS_FIP_FCF_DISCOVERY_STARTED) {
 		u8 zmac[ETH_ALEN] = { 0, 0, 0, 0, 0, 0 };
 
-		FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FIP_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			     "FCF Discovery timeout\n");
 		if (memcmp(iport->selected_fcf.fcf_mac, zmac, ETH_ALEN) != 0) {
 
@@ -757,13 +757,13 @@ void fnic_work_on_fip_timer(struct work_struct *work)
 					  round_jiffies(fcf_tov));
 			}
 		} else {
-			FNIC_FIP_DBG(KERN_INFO, fnic->lport->host,
+			FNIC_FIP_DBG(KERN_INFO, fnic->host,
 				     fnic->fnic_num, "FCF Discovery timeout\n");
 			fnic_vlan_discovery_timeout(fnic);
 		}
 	} else if (iport->fip.state == FDLS_FIP_FLOGI_STARTED) {
 		fdls_schedule_oxid_free(iport, &iport->active_oxid_fabric_req);
-		FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FIP_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			     "FLOGI timeout\n");
 		if (iport->fip.flogi_retry < fnic->config.flogi_retries)
 			fnic_fcoe_start_flogi(fnic);
@@ -810,7 +810,7 @@ void fnic_handle_enode_ka_timer(struct timer_list *t)
 
 	frame = fdls_alloc_frame(iport);
 	if (frame == NULL) {
-		FNIC_FIP_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FIP_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 		     "Failed to allocate frame to send enode ka");
 		return;
 	}
@@ -831,7 +831,7 @@ void fnic_handle_enode_ka_timer(struct timer_list *t)
 	memcpy(penode_ka->eth.h_dest, iport->selected_fcf.fcf_mac, ETH_ALEN);
 	memcpy(penode_ka->mac_desc.fd_mac, iport->hwmac, ETH_ALEN);
 
-	FNIC_FIP_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+	FNIC_FIP_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 		     "Handle enode KA timer\n");
 	fnic_send_fip_frame(iport, frame, frame_size);
 	enode_ka_tov = jiffies
@@ -864,7 +864,7 @@ void fnic_handle_vn_ka_timer(struct timer_list *t)
 
 	frame = fdls_alloc_frame(iport);
 	if (frame == NULL) {
-		FNIC_FIP_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_FIP_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 		     "Failed to allocate frame to send vn ka");
 		return;
 	}
@@ -890,7 +890,7 @@ void fnic_handle_vn_ka_timer(struct timer_list *t)
 	memcpy(pvn_port_ka->vn_port_desc.fd_fc_id, fcid, 3);
 	FNIC_STD_SET_NPORT_NAME(&pvn_port_ka->vn_port_desc.fd_wwpn, iport->wwpn);
 
-	FNIC_FIP_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+	FNIC_FIP_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 		     "Handle vnport KA timer\n");
 	fnic_send_fip_frame(iport, frame, frame_size);
 	vn_ka_tov = jiffies + msecs_to_jiffies(FIP_VN_KA_PERIOD);
@@ -980,7 +980,7 @@ void fnic_work_on_fcs_ka_timer(struct work_struct *work)
 	*fnic = container_of(work, struct fnic, fip_timer_work);
 	struct fnic_iport_s *iport = &fnic->iport;
 
-	FNIC_FIP_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FIP_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		     "fnic 0x%p fcs ka timeout\n", fnic);
 
 	fnic_common_fip_cleanup(fnic);
diff --git a/drivers/scsi/fnic/fip.h b/drivers/scsi/fnic/fip.h
index be727ac19af6..c62993c76dc7 100644
--- a/drivers/scsi/fnic/fip.h
+++ b/drivers/scsi/fnic/fip.h
@@ -140,7 +140,7 @@ fnic_debug_dump_fip_frame(struct fnic *fnic, struct ethhdr *eth,
 	u16 op = be16_to_cpu(fiph->fip_op);
 	u8 sub = fiph->fip_subcode;
 
-	FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 		"FIP %s packet contents: op: 0x%x sub: 0x%x (len = %d)",
 		pfx, op, sub, len);
 
diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index 19e8775f1bfc..b02459b6ec2f 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -10,8 +10,6 @@
 #include <linux/netdevice.h>
 #include <linux/workqueue.h>
 #include <linux/bitops.h>
-#include <scsi/libfc.h>
-#include <scsi/libfcoe.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_transport.h>
 #include <scsi/scsi_transport_fc.h>
@@ -346,8 +344,6 @@ struct fnic {
 	enum fnic_role_e role;
 	struct fnic_iport_s iport;
 	struct Scsi_Host *host;
-	struct fc_lport *lport;
-	struct fcoe_ctlr ctlr;		/* FIP FCoE controller structure */
 	struct vnic_dev_bar bar0;
 
 	struct fnic_msix_entry msix[FNIC_MSIX_INTR_MAX];
@@ -380,9 +376,6 @@ struct fnic {
 	u32 vlan_hw_insert:1;	        /* let hw insert the tag */
 	u32 in_remove:1;                /* fnic device in removal */
 	u32 stop_rx_link_events:1;      /* stop proc. rx frames, link events */
-	u32 link_events:1;              /* set when we get any link event*/
-
-	struct completion *remove_wait; /* device remove thread blocks */
 
 	struct completion *fw_reset_done;
 	u32 reset_in_progress;
@@ -572,7 +565,7 @@ fnic_scsi_io_iter(struct fnic *fnic,
 		.data1 = data1,
 		.data2 = data2,
 	};
-	scsi_host_busy_iter(fnic->lport->host, fnic_io_iter_handler, &iter_data);
+	scsi_host_busy_iter(fnic->host, fnic_io_iter_handler, &iter_data);
 }
 
 #ifdef FNIC_DEBUG
@@ -582,7 +575,7 @@ fnic_debug_dump(struct fnic *fnic, uint8_t *u8arr, int len)
 	int i;
 
 	for (i = 0; i < len; i = i+8) {
-		FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 		    "%d: %02x %02x %02x %02x %02x %02x %02x %02x", i / 8,
 		    u8arr[i + 0], u8arr[i + 1], u8arr[i + 2], u8arr[i + 3],
 		    u8arr[i + 4], u8arr[i + 5], u8arr[i + 6], u8arr[i + 7]);
@@ -597,7 +590,7 @@ fnic_debug_dump_fc_frame(struct fnic *fnic, struct fc_frame_header *fchdr,
 
 	s_id = ntoh24(fchdr->fh_s_id);
 	d_id = ntoh24(fchdr->fh_d_id);
-	FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 		"%s packet contents: sid/did/type/oxid = 0x%x/0x%x/0x%x/0x%x (len = %d)\n",
 		pfx, s_id, d_id, fchdr->fh_type,
 		FNIC_STD_GET_OX_ID(fchdr), len);
diff --git a/drivers/scsi/fnic/fnic_debugfs.c b/drivers/scsi/fnic/fnic_debugfs.c
index 3748bbe190f7..caee32bc9190 100644
--- a/drivers/scsi/fnic/fnic_debugfs.c
+++ b/drivers/scsi/fnic/fnic_debugfs.c
@@ -682,7 +682,7 @@ int fnic_stats_debugfs_init(struct fnic *fnic)
 	int rc = -1;
 	char name[16];
 
-	snprintf(name, sizeof(name), "host%d", fnic->lport->host->host_no);
+	snprintf(name, sizeof(name), "host%d", fnic->host->host_no);
 
 	if (!fnic_stats_debugfs_root) {
 		pr_debug("fnic_stats root doesn't exist\n");
diff --git a/drivers/scsi/fnic/fnic_fcs.c b/drivers/scsi/fnic/fnic_fcs.c
index 5fad468ee54c..c90dd11d2e75 100644
--- a/drivers/scsi/fnic/fnic_fcs.c
+++ b/drivers/scsi/fnic/fnic_fcs.c
@@ -15,7 +15,7 @@
 #include <scsi/fc/fc_fip.h>
 #include <scsi/fc/fc_els.h>
 #include <scsi/fc_frame.h>
-#include <scsi/libfc.h>
+#include <linux/etherdevice.h>
 #include <scsi/scsi_transport_fc.h>
 #include "fnic_io.h"
 #include "fnic.h"
@@ -40,7 +40,7 @@ static uint8_t FCOE_ALL_FCF_MAC[6] = FC_FCOE_FLOGI_MAC;
 static inline void fnic_fdls_set_fcoe_srcmac(struct fnic *fnic,
 							 uint8_t *src_mac)
 {
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "Setting src mac: %02x:%02x:%02x:%02x:%02x:%02x",
 				 src_mac[0], src_mac[1], src_mac[2], src_mac[3],
 				 src_mac[4], src_mac[5]);
@@ -55,7 +55,7 @@ static inline void fnic_fdls_set_fcoe_srcmac(struct fnic *fnic,
 static inline  void fnic_fdls_set_fcoe_dstmac(struct fnic *fnic,
 							 uint8_t *dst_mac)
 {
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "Setting dst mac: %02x:%02x:%02x:%02x:%02x:%02x",
 				 dst_mac[0], dst_mac[1], dst_mac[2], dst_mac[3],
 				 dst_mac[4], dst_mac[5]);
@@ -83,7 +83,7 @@ void fnic_fdls_link_status_change(struct fnic *fnic, int linkup)
 {
 	struct fnic_iport_s *iport = &fnic->iport;
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "link up: %d, usefip: %d", linkup, iport->usefip);
 
 	spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
@@ -91,12 +91,12 @@ void fnic_fdls_link_status_change(struct fnic *fnic, int linkup)
 	if (linkup) {
 		if (iport->usefip) {
 			iport->state = FNIC_IPORT_STATE_FIP;
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 						 "link up: %d, usefip: %d", linkup, iport->usefip);
 			fnic_fcoe_send_vlan_req(fnic);
 		} else {
 			iport->state = FNIC_IPORT_STATE_FABRIC_DISC;
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 						 "iport->state: %d", iport->state);
 			fnic_fdls_disc_start(iport);
 		}
@@ -126,13 +126,13 @@ void fnic_fdls_learn_fcoe_macs(struct fnic_iport_s *iport, void *rx_frame,
 
 	memcpy(&fcmac[3], fcid, 3);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "learn fcoe: dst_mac: %02x:%02x:%02x:%02x:%02x:%02x",
 				 ethhdr->h_dest[0], ethhdr->h_dest[1],
 				 ethhdr->h_dest[2], ethhdr->h_dest[3],
 				 ethhdr->h_dest[4], ethhdr->h_dest[5]);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "learn fcoe: fc_mac: %02x:%02x:%02x:%02x:%02x:%02x",
 				 fcmac[0], fcmac[1], fcmac[2], fcmac[3], fcmac[4],
 				 fcmac[5]);
@@ -150,7 +150,7 @@ void fnic_fdls_init(struct fnic *fnic, int usefip)
 	iport->fnic = fnic;
 	iport->usefip = usefip;
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "iportsrcmac: %02x:%02x:%02x:%02x:%02x:%02x",
 				 iport->hwmac[0], iport->hwmac[1], iport->hwmac[2],
 				 iport->hwmac[3], iport->hwmac[4], iport->hwmac[5]);
@@ -169,14 +169,14 @@ void fnic_handle_link(struct work_struct *work)
 	int max_count = 0;
 
 	if (vnic_dev_get_intr_mode(fnic->vdev) != VNIC_DEV_INTR_MODE_MSI)
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "Interrupt mode is not MSI\n");
 
 	spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
 
 	if (fnic->stop_rx_link_events) {
 		spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "Stop link rx events\n");
 		return;
 	}
@@ -185,10 +185,10 @@ void fnic_handle_link(struct work_struct *work)
 	if ((fnic->state != FNIC_IN_ETH_MODE)
 		&& (fnic->state != FNIC_IN_FC_MODE)) {
 		spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "fnic in transitional state: %d. link up: %d ignored",
 			 fnic->state, vnic_dev_link_status(fnic->vdev));
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "Current link status: %d iport state: %d\n",
 			 fnic->link_status, fnic->iport.state);
 		return;
@@ -200,36 +200,36 @@ void fnic_handle_link(struct work_struct *work)
 	fnic->link_down_cnt = vnic_dev_link_down_cnt(fnic->vdev);
 
 	while (fnic->reset_in_progress == IN_PROGRESS) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "fnic reset in progress. Link event needs to wait\n");
 
 		spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "waiting for reset completion\n");
 		wait_for_completion_timeout(&fnic->reset_completion_wait,
 									msecs_to_jiffies(5000));
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "woken up from reset completion wait\n");
 		spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
 
 		max_count++;
 		if (max_count >= MAX_RESET_WAIT_COUNT) {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "Rstth waited for too long. Skipping handle link event\n");
 			spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
 			return;
 		}
 	}
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "Marking fnic reset in progress\n");
 	fnic->reset_in_progress = IN_PROGRESS;
 
 	if ((vnic_dev_get_intr_mode(fnic->vdev) != VNIC_DEV_INTR_MODE_MSI) ||
 		(fnic->link_status != old_link_status)) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "old link status: %d link status: %d\n",
 					 old_link_status, (int) fnic->link_status);
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "old down count %d down count: %d\n",
 					 old_link_down_cnt, (int) fnic->link_down_cnt);
 	}
@@ -238,36 +238,36 @@ void fnic_handle_link(struct work_struct *work)
 		if (!fnic->link_status) {
 			/* DOWN -> DOWN */
 			spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 						 "down->down\n");
 		} else {
 			if (old_link_down_cnt != fnic->link_down_cnt) {
 				/* UP -> DOWN -> UP */
 				spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
-				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 							 "up->down. Link down\n");
 				fnic_fdls_link_status_change(fnic, 0);
 
-				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 							 "down->up. Link up\n");
 				fnic_fdls_link_status_change(fnic, 1);
 			} else {
 				/* UP -> UP */
 				spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
-				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 							 "up->up\n");
 			}
 		}
 	} else if (fnic->link_status) {
 		/* DOWN -> UP */
 		spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "down->up. Link up\n");
 		fnic_fdls_link_status_change(fnic, 1);
 	} else {
 		/* UP -> DOWN */
 		spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "up->down. Link down\n");
 		fnic_fdls_link_status_change(fnic, 0);
 	}
@@ -276,14 +276,11 @@ void fnic_handle_link(struct work_struct *work)
 	fnic->reset_in_progress = NOT_IN_PROGRESS;
 	complete(&fnic->reset_completion_wait);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "Marking fnic reset completion\n");
 	spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
 }
 
-/*
- * This function passes incoming fabric frames to libFC
- */
 void fnic_handle_frame(struct work_struct *work)
 {
 	struct fnic *fnic = container_of(work, struct fnic, frame_work);
@@ -306,7 +303,7 @@ void fnic_handle_frame(struct work_struct *work)
 		 */
 		if (fnic->state != FNIC_IN_FC_MODE &&
 			fnic->state != FNIC_IN_ETH_MODE) {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "Cannot process frame in transitional state\n");
 			spin_unlock_irqrestore(&fnic->fnic_lock, fnic->lock_flags);
 			return;
@@ -332,7 +329,7 @@ void fnic_handle_fip_frame(struct work_struct *work)
 	struct fnic_frame_list *cur_frame, *next;
 	struct fnic *fnic = container_of(work, struct fnic, fip_frame_work);
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "Processing FIP frame\n");
 
 	spin_lock_irqsave(&fnic->fnic_lock, fnic->lock_flags);
@@ -411,7 +408,7 @@ void fnic_update_mac_locked(struct fnic *fnic, u8 *new)
 	if (ether_addr_equal(data, new))
 		return;
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "Update MAC: %u\n", *new);
 
 	if (!is_zero_ether_addr(data) && !ether_addr_equal(data, ctl))
@@ -481,7 +478,7 @@ static void fnic_rq_cmpl_frame_recv(struct vnic_rq *rq, struct cq_desc
 
 		if (!fcs_ok) {
 			atomic64_inc(&fnic_stats->misc_stats.frame_errors);
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 						 "fnic 0x%p fcs error.  Dropping packet.\n", fnic);
 			goto drop;
 		}
@@ -491,21 +488,21 @@ static void fnic_rq_cmpl_frame_recv(struct vnic_rq *rq, struct cq_desc
 			if (fnic_import_rq_eth_pkt(fnic, fp))
 				return;
 
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 							 "Dropping h_proto 0x%x",
 							 be16_to_cpu(eh->h_proto));
 			goto drop;
 		}
 	} else {
 		/* wrong CQ type */
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "fnic rq_cmpl wrong cq type x%x\n", type);
 		goto drop;
 	}
 
 	if (!fcs_ok || packet_error || !fcoe_fnic_crc_ok || fcoe_enc_error) {
 		atomic64_inc(&fnic_stats->misc_stats.frame_errors);
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "fcoe %x fcsok %x pkterr %x ffco %x fee %x\n",
 			 fcoe, fcs_ok, packet_error,
 			 fcoe_fnic_crc_ok, fcoe_enc_error);
@@ -515,7 +512,7 @@ static void fnic_rq_cmpl_frame_recv(struct vnic_rq *rq, struct cq_desc
 	spin_lock_irqsave(&fnic->fnic_lock, flags);
 	if (fnic->stop_rx_link_events) {
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "fnic->stop_rx_link_events: %d\n",
 					 fnic->stop_rx_link_events);
 		goto drop;
@@ -526,7 +523,7 @@ static void fnic_rq_cmpl_frame_recv(struct vnic_rq *rq, struct cq_desc
 	frame_elem = mempool_alloc(fnic->frame_elem_pool,
 					GFP_ATOMIC | __GFP_ZERO);
 	if (!frame_elem) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "Unable to alloc frame element of size: %ld\n",
 					 sizeof(struct fnic_frame_list));
 		goto drop;
@@ -572,7 +569,7 @@ int fnic_rq_cmpl_handler(struct fnic *fnic, int rq_work_to_do)
 		if (cur_work_done && fnic->stop_rx_link_events != 1) {
 			err = vnic_rq_fill(&fnic->rq[i], fnic_alloc_rq_frame);
 			if (err)
-				shost_printk(KERN_ERR, fnic->lport->host,
+				shost_printk(KERN_ERR, fnic->host,
 					     "fnic_alloc_rq_frame can't alloc"
 					     " frame\n");
 		}
@@ -598,7 +595,7 @@ int fnic_alloc_rq_frame(struct vnic_rq *rq)
 	len = FNIC_FRAME_HT_ROOM;
 	buf = kmalloc(len, GFP_ATOMIC);
 	if (!buf) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "Unable to allocate RQ buffer of size: %d\n", len);
 		return -ENOMEM;
 	}
@@ -606,7 +603,7 @@ int fnic_alloc_rq_frame(struct vnic_rq *rq)
 	pa = dma_map_single(&fnic->pdev->dev, buf, len, DMA_FROM_DEVICE);
 	if (dma_mapping_error(&fnic->pdev->dev, pa)) {
 		ret = -ENOMEM;
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "PCI mapping failed with error %d\n", ret);
 		goto free_buf;
 	}
@@ -645,7 +642,7 @@ static int fnic_send_frame(struct fnic *fnic, void *frame, int frame_len)
 	if ((fnic_fc_trace_set_data(fnic->fnic_num,
 				FNIC_FC_SEND | 0x80, (char *) frame,
 				frame_len)) != 0) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "fnic ctlr frame trace error");
 	}
 
@@ -653,7 +650,7 @@ static int fnic_send_frame(struct fnic *fnic, void *frame, int frame_len)
 
 	if (!vnic_wq_desc_avail(wq)) {
 		dma_unmap_single(&fnic->pdev->dev, pa, frame_len, DMA_TO_DEVICE);
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "vnic work queue descriptor is not available");
 		ret = -1;
 		goto fnic_send_frame_end;
@@ -695,7 +692,6 @@ fdls_send_fcoe_frame(struct fnic *fnic, void *frame, int frame_size,
 
 	pethhdr = (struct ethhdr *) frame;
 	pethhdr->h_proto = cpu_to_be16(ETH_P_FCOE);
-
 	memcpy(pethhdr->h_source, srcmac, ETH_ALEN);
 	memcpy(pethhdr->h_dest, dstmac, ETH_ALEN);
 
@@ -711,17 +707,16 @@ fdls_send_fcoe_frame(struct fnic *fnic, void *frame, int frame_size,
 		frame_elem = mempool_alloc(fnic->frame_elem_pool,
 						GFP_ATOMIC | __GFP_ZERO);
 		if (!frame_elem) {
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 						 "Failed to allocate memory for fnic_frame_list: %lu\n",
 						 sizeof(struct fnic_frame_list));
 			return -ENOMEM;
 		}
 
-		FNIC_FCS_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 			"Queueing FC frame: sid/did/type/oxid = 0x%x/0x%x/0x%x/0x%x\n",
 			ntoh24(fchdr->fh_s_id), ntoh24(fchdr->fh_d_id),
 			fchdr->fh_type, FNIC_STD_GET_OX_ID(fchdr));
-
 		frame_elem->fp = frame;
 		frame_elem->frame_len = len;
 		list_add_tail(&frame_elem->links, &fnic->tx_queue);
@@ -784,7 +779,7 @@ void fnic_flush_tx(struct work_struct *work)
 	struct fc_frame *fp;
 	struct fnic_frame_list *cur_frame, *next;
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "Flush queued frames");
 
 	list_for_each_entry_safe(cur_frame, next, &fnic->tx_queue, links) {
@@ -803,7 +798,7 @@ fnic_fdls_register_portid(struct fnic_iport_s *iport, u32 port_id,
 	struct ethhdr *ethhdr;
 	int ret;
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "Setting port id: 0x%x fp: 0x%p fnic state: %d", port_id,
 				 fp, fnic->state);
 
@@ -816,7 +811,7 @@ fnic_fdls_register_portid(struct fnic_iport_s *iport, u32 port_id,
 	if (fnic->state == FNIC_IN_ETH_MODE || fnic->state == FNIC_IN_FC_MODE)
 		fnic->state = FNIC_IN_ETH_TRANS_FC_MODE;
 	else {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			 "Unexpected fnic state while processing FLOGI response\n");
 		return -1;
 	}
@@ -827,7 +822,7 @@ fnic_fdls_register_portid(struct fnic_iport_s *iport, u32 port_id,
 	 */
 	ret = fnic_flogi_reg_handler(fnic, port_id);
 	if (ret < 0) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "FLOGI registration error ret: %d fnic state: %d\n",
 					 ret, fnic->state);
 		if (fnic->state == FNIC_IN_ETH_TRANS_FC_MODE)
@@ -837,7 +832,7 @@ fnic_fdls_register_portid(struct fnic_iport_s *iport, u32 port_id,
 	}
 	iport->fabric.flags |= FNIC_FDLS_FPMA_LEARNT;
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "FLOGI registration success\n");
 	return 0;
 }
@@ -917,7 +912,7 @@ fnic_fdls_add_tport(struct fnic_iport_s *iport, struct fnic_tport_s *tport,
 	struct fc_rport_identifiers ids;
 	struct rport_dd_data_s *rdd_data;
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "Adding rport fcid: 0x%x", tport->fcid);
 
 	ids.node_name = tport->wwnn;
@@ -926,15 +921,15 @@ fnic_fdls_add_tport(struct fnic_iport_s *iport, struct fnic_tport_s *tport,
 	ids.roles = FC_RPORT_ROLE_FCP_TARGET;
 
 	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-	rport = fc_remote_port_add(fnic->lport->host, 0, &ids);
+	rport = fc_remote_port_add(fnic->host, 0, &ids);
 	spin_lock_irqsave(&fnic->fnic_lock, flags);
 	if (!rport) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "Failed to add rport for tport: 0x%x", tport->fcid);
 		return;
 	}
 
-	FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				 "Added rport fcid: 0x%x", tport->fcid);
 
 	/* Mimic these assignments in queuecommand to avoid timing issues */
@@ -973,7 +968,7 @@ fnic_fdls_remove_tport(struct fnic_iport_s *iport,
 		fc_remote_port_delete(rport);
 
 		spin_lock_irqsave(&fnic->fnic_lock, flags);
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		 "Deregistered and freed tport fcid: 0x%x from scsi transport fc",
 		 tport->fcid);
 
@@ -1000,7 +995,7 @@ void fnic_delete_fcp_tports(struct fnic *fnic)
 
 	spin_lock_irqsave(&fnic->fnic_lock, flags);
 	list_for_each_entry_safe(tport, next, &fnic->iport.tport_list, links) {
-		FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "removing fcp rport fcid: 0x%x", tport->fcid);
 		fdls_set_tport_state(tport, FDLS_TGT_STATE_OFFLINING);
 		fnic_del_tport_timer_sync(fnic, tport);
@@ -1027,36 +1022,36 @@ void fnic_tport_event_handler(struct work_struct *work)
 		tport = cur_evt->arg1;
 		switch (cur_evt->event) {
 		case TGT_EV_RPORT_ADD:
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 						 "Add rport event");
 			if (tport->state == FDLS_TGT_STATE_READY) {
 				fnic_fdls_add_tport(&fnic->iport,
 					(struct fnic_tport_s *) cur_evt->arg1, flags);
 			} else {
-				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					 "Target not ready. Add rport event dropped: 0x%x",
 					 tport->fcid);
 			}
 			break;
 		case TGT_EV_RPORT_DEL:
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 						 "Remove rport event");
 			if (tport->state == FDLS_TGT_STATE_OFFLINING) {
 				fnic_fdls_remove_tport(&fnic->iport,
 					   (struct fnic_tport_s *) cur_evt->arg1, flags);
 			} else {
-				FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+				FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 							 "remove rport event dropped tport fcid: 0x%x",
 							 tport->fcid);
 			}
 			break;
 		case TGT_EV_TPORT_DELETE:
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 						 "Delete tport event");
 			fdls_delete_tport(tport->iport, tport);
 			break;
 		default:
-			FNIC_FCS_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_FCS_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 						 "Unknown tport event");
 			break;
 		}
diff --git a/drivers/scsi/fnic/fnic_isr.c b/drivers/scsi/fnic/fnic_isr.c
index ff85441c6cea..7ed50b11afa6 100644
--- a/drivers/scsi/fnic/fnic_isr.c
+++ b/drivers/scsi/fnic/fnic_isr.c
@@ -7,7 +7,7 @@
 #include <linux/errno.h>
 #include <linux/pci.h>
 #include <linux/interrupt.h>
-#include <scsi/libfc.h>
+#include <scsi/scsi_transport_fc.h>
 #include <scsi/fc_frame.h>
 #include "vnic_dev.h"
 #include "vnic_intr.h"
@@ -222,7 +222,7 @@ int fnic_request_intr(struct fnic *fnic)
 							fnic->msix[i].devname,
 							fnic->msix[i].devid);
 			if (err) {
-				FNIC_ISR_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+				FNIC_ISR_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 							"request_irq failed with error: %d\n",
 							err);
 				fnic_free_intr(fnic);
@@ -250,10 +250,10 @@ int fnic_set_intr_mode_msix(struct fnic *fnic)
 	 * We need n RQs, m WQs, o Copy WQs, n+m+o CQs, and n+m+o+1 INTRs
 	 * (last INTR is used for WQ/RQ errors and notification area)
 	 */
-	FNIC_ISR_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_ISR_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		"rq-array size: %d wq-array size: %d copy-wq array size: %d\n",
 		n, m, o);
-	FNIC_ISR_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_ISR_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		"rq_count: %d raw_wq_count: %d wq_copy_count: %d cq_count: %d\n",
 		fnic->rq_count, fnic->raw_wq_count,
 		fnic->wq_copy_count, fnic->cq_count);
@@ -265,17 +265,17 @@ int fnic_set_intr_mode_msix(struct fnic *fnic)
 
 		vec_count = pci_alloc_irq_vectors(fnic->pdev, min_irqs, vecs,
 					PCI_IRQ_MSIX | PCI_IRQ_AFFINITY);
-		FNIC_ISR_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_ISR_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					"allocated %d MSI-X vectors\n",
 					vec_count);
 
 		if (vec_count > 0) {
 			if (vec_count < vecs) {
-				FNIC_ISR_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+				FNIC_ISR_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 				"interrupts number mismatch: vec_count: %d vecs: %d\n",
 				vec_count, vecs);
 				if (vec_count < min_irqs) {
-					FNIC_ISR_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+					FNIC_ISR_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 								"no interrupts for copy wq\n");
 					return 1;
 				}
@@ -287,7 +287,7 @@ int fnic_set_intr_mode_msix(struct fnic *fnic)
 			fnic->wq_copy_count = vec_count - n - m - 1;
 			fnic->wq_count = fnic->raw_wq_count + fnic->wq_copy_count;
 			if (fnic->cq_count != vec_count - 1) {
-				FNIC_ISR_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+				FNIC_ISR_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 				"CQ count: %d does not match MSI-X vector count: %d\n",
 				fnic->cq_count, vec_count);
 				fnic->cq_count = vec_count - 1;
@@ -295,23 +295,23 @@ int fnic_set_intr_mode_msix(struct fnic *fnic)
 			fnic->intr_count = vec_count;
 			fnic->err_intr_offset = fnic->rq_count + fnic->wq_count;
 
-			FNIC_ISR_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_ISR_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				"rq_count: %d raw_wq_count: %d copy_wq_base: %d\n",
 				fnic->rq_count,
 				fnic->raw_wq_count, fnic->copy_wq_base);
 
-			FNIC_ISR_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_ISR_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				"wq_copy_count: %d wq_count: %d cq_count: %d\n",
 				fnic->wq_copy_count,
 				fnic->wq_count, fnic->cq_count);
 
-			FNIC_ISR_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_ISR_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				"intr_count: %d err_intr_offset: %u",
 				fnic->intr_count,
 				fnic->err_intr_offset);
 
 			vnic_dev_set_intr_mode(fnic->vdev, VNIC_DEV_INTR_MODE_MSIX);
-			FNIC_ISR_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_ISR_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					"fnic using MSI-X\n");
 			return 0;
 		}
@@ -351,7 +351,7 @@ int fnic_set_intr_mode(struct fnic *fnic)
 		fnic->intr_count = 1;
 		fnic->err_intr_offset = 0;
 
-		FNIC_ISR_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+		FNIC_ISR_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 			     "Using MSI Interrupts\n");
 		vnic_dev_set_intr_mode(fnic->vdev, VNIC_DEV_INTR_MODE_MSI);
 
@@ -377,7 +377,7 @@ int fnic_set_intr_mode(struct fnic *fnic)
 		fnic->cq_count = 3;
 		fnic->intr_count = 3;
 
-		FNIC_ISR_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+		FNIC_ISR_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 			     "Using Legacy Interrupts\n");
 		vnic_dev_set_intr_mode(fnic->vdev, VNIC_DEV_INTR_MODE_INTX);
 
diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
index 628c9e5902a2..fe8816feb247 100644
--- a/drivers/scsi/fnic/fnic_main.c
+++ b/drivers/scsi/fnic/fnic_main.c
@@ -22,7 +22,6 @@
 #include <scsi/scsi_transport.h>
 #include <scsi/scsi_transport_fc.h>
 #include <scsi/scsi_tcq.h>
-#include <scsi/libfc.h>
 #include <scsi/fc_frame.h>
 
 #include "vnic_dev.h"
@@ -176,7 +175,7 @@ static void fnic_get_host_speed(struct Scsi_Host *shost)
 	u32 port_speed = vnic_dev_port_speed(fnic->vdev);
 	struct fnic_stats *fnic_stats = &fnic->fnic_stats;
 
-	FNIC_MAIN_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_MAIN_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				  "port_speed: %d Mbps", port_speed);
 	atomic64_set(&fnic_stats->misc_stats.port_speed_in_mbps, port_speed);
 
@@ -226,7 +225,7 @@ static void fnic_get_host_speed(struct Scsi_Host *shost)
 		fc_host_speed(shost) = FC_PORTSPEED_128GBIT;
 		break;
 	default:
-		FNIC_MAIN_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_MAIN_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					  "Unknown FC speed: %d Mbps", port_speed);
 		fc_host_speed(shost) = FC_PORTSPEED_UNKNOWN;
 		break;
@@ -252,7 +251,7 @@ static struct fc_host_statistics *fnic_get_stats(struct Scsi_Host *host)
 	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 
 	if (ret) {
-		FNIC_MAIN_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+		FNIC_MAIN_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 					  "fnic: Get vnic stats failed: 0x%x", ret);
 		return stats;
 	}
@@ -361,7 +360,7 @@ static void fnic_reset_host_stats(struct Scsi_Host *host)
 	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 
 	if (ret) {
-		FNIC_MAIN_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+		FNIC_MAIN_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 				"fnic: Reset vnic stats failed"
 				" 0x%x", ret);
 		return;
@@ -565,7 +564,7 @@ static void fnic_set_vlan(struct fnic *fnic, u16 vlan_id)
 
 static void fnic_scsi_init(struct fnic *fnic)
 {
-	struct Scsi_Host *host = fnic->lport->host;
+	struct Scsi_Host *host = fnic->host;
 
 	snprintf(fnic->name, sizeof(fnic->name) - 1, "%s%d", DRV_NAME,
 			 host->host_no);
@@ -575,7 +574,7 @@ static void fnic_scsi_init(struct fnic *fnic)
 
 static int fnic_scsi_drv_init(struct fnic *fnic)
 {
-	struct Scsi_Host *host = fnic->lport->host;
+	struct Scsi_Host *host = fnic->host;
 	int err;
 	struct pci_dev *pdev = fnic->pdev;
 	struct fnic_iport_s *iport = &fnic->iport;
@@ -612,41 +611,41 @@ static int fnic_scsi_drv_init(struct fnic *fnic)
 
 	fnic_scsi_init(fnic);
 
-	err = scsi_add_host(fnic->lport->host, &pdev->dev);
+	err = scsi_add_host(fnic->host, &pdev->dev);
 	if (err) {
 		dev_err(&fnic->pdev->dev, "fnic: scsi add host failed: aborting\n");
 		return -1;
 	}
-	fc_host_maxframe_size(fnic->lport->host) = iport->max_payload_size;
-	fc_host_dev_loss_tmo(fnic->lport->host) =
+	fc_host_maxframe_size(fnic->host) = iport->max_payload_size;
+	fc_host_dev_loss_tmo(fnic->host) =
 		fnic->config.port_down_timeout / 1000;
-	sprintf(fc_host_symbolic_name(fnic->lport->host),
+	sprintf(fc_host_symbolic_name(fnic->host),
 			DRV_NAME " v" DRV_VERSION " over %s", fnic->name);
-	fc_host_port_type(fnic->lport->host) = FC_PORTTYPE_NPORT;
-	fc_host_node_name(fnic->lport->host) = iport->wwnn;
-	fc_host_port_name(fnic->lport->host) = iport->wwpn;
-	fc_host_supported_classes(fnic->lport->host) = FC_COS_CLASS3;
-	memset(fc_host_supported_fc4s(fnic->lport->host), 0,
-		   sizeof(fc_host_supported_fc4s(fnic->lport->host)));
-	fc_host_supported_fc4s(fnic->lport->host)[2] = 1;
-	fc_host_supported_fc4s(fnic->lport->host)[7] = 1;
-	fc_host_supported_speeds(fnic->lport->host) = 0;
-	fc_host_supported_speeds(fnic->lport->host) |= FC_PORTSPEED_8GBIT;
-
-	dev_info(&fnic->pdev->dev, "shost_data: 0x%p\n", fnic->lport->host->shost_data);
-	if (fnic->lport->host->shost_data != NULL) {
+	fc_host_port_type(fnic->host) = FC_PORTTYPE_NPORT;
+	fc_host_node_name(fnic->host) = iport->wwnn;
+	fc_host_port_name(fnic->host) = iport->wwpn;
+	fc_host_supported_classes(fnic->host) = FC_COS_CLASS3;
+	memset(fc_host_supported_fc4s(fnic->host), 0,
+		   sizeof(fc_host_supported_fc4s(fnic->host)));
+	fc_host_supported_fc4s(fnic->host)[2] = 1;
+	fc_host_supported_fc4s(fnic->host)[7] = 1;
+	fc_host_supported_speeds(fnic->host) = 0;
+	fc_host_supported_speeds(fnic->host) |= FC_PORTSPEED_8GBIT;
+
+	dev_info(&fnic->pdev->dev, "shost_data: 0x%p\n", fnic->host->shost_data);
+	if (fnic->host->shost_data != NULL) {
 		if (fnic_tgt_id_binding == 0) {
 			dev_info(&fnic->pdev->dev, "Setting target binding to NONE\n");
-			fc_host_tgtid_bind_type(fnic->lport->host) = FC_TGTID_BIND_NONE;
+			fc_host_tgtid_bind_type(fnic->host) = FC_TGTID_BIND_NONE;
 		} else {
 			dev_info(&fnic->pdev->dev, "Setting target binding to WWPN\n");
-			fc_host_tgtid_bind_type(fnic->lport->host) = FC_TGTID_BIND_BY_WWPN;
+			fc_host_tgtid_bind_type(fnic->host) = FC_TGTID_BIND_BY_WWPN;
 		}
 	}
 
 	fnic->io_req_pool = mempool_create_slab_pool(2, fnic_io_req_cache);
 	if (!fnic->io_req_pool) {
-		scsi_remove_host(fnic->lport->host);
+		scsi_remove_host(fnic->host);
 		return -ENOMEM;
 	}
 
@@ -661,16 +660,16 @@ void fnic_mq_map_queues_cpus(struct Scsi_Host *host)
 	struct blk_mq_queue_map *qmap = &host->tag_set.map[HCTX_TYPE_DEFAULT];
 
 	if (intr_mode == VNIC_DEV_INTR_MODE_MSI || intr_mode == VNIC_DEV_INTR_MODE_INTX) {
-		FNIC_MAIN_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_MAIN_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 			"intr_mode is not msix\n");
 		return;
 	}
 
-	FNIC_MAIN_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_MAIN_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			"qmap->nr_queues: %d\n", qmap->nr_queues);
 
 	if (l_pdev == NULL) {
-		FNIC_MAIN_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_MAIN_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 						"l_pdev is null\n");
 		return;
 	}
@@ -832,7 +831,7 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			}
 			*((struct fnic **) shost_priv(host)) = fnic;
 
-			fnic->lport->host = host;
+			fnic->host = host;
 			fnic->role = FNIC_ROLE_FCP_INITIATOR;
 			dev_info(&fnic->pdev->dev, "fnic: %d is scsi initiator\n",
 					fnic->fnic_num);
@@ -1042,7 +1041,7 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 err_out_free_stats_debugfs:
 	fnic_stats_debugfs_remove(fnic);
-	scsi_remove_host(fnic->lport->host);
+	scsi_remove_host(fnic->host);
 err_out_scsi_drv_init:
 	fnic_free_intr(fnic);
 err_out_fnic_request_intr:
@@ -1067,7 +1066,7 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	fnic_clear_intr_mode(fnic);
 err_out_fnic_set_intr_mode:
 	if (IS_FNIC_FCP_INITIATOR(fnic))
-		scsi_host_put(fnic->lport->host);
+		scsi_host_put(fnic->host);
 err_out_fnic_role:
 err_out_scsi_host_alloc:
 err_out_fnic_get_config:
@@ -1164,7 +1163,7 @@ static void fnic_remove(struct pci_dev *pdev)
 	ida_free(&fnic_ida, fnic->fnic_num);
 	if (IS_FNIC_FCP_INITIATOR(fnic)) {
 		fnic_scsi_unload_cleanup(fnic);
-		scsi_host_put(fnic->lport->host);
+		scsi_host_put(fnic->host);
 	}
 	kfree(fnic);
 }
diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index e464c677e9da..7133b254cbe4 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -23,7 +23,6 @@
 #include <scsi/scsi_tcq.h>
 #include <scsi/fc/fc_els.h>
 #include <scsi/fc/fc_fcoe.h>
-#include <scsi/libfc.h>
 #include <scsi/fc_frame.h>
 #include <scsi/scsi_transport_fc.h>
 #include "fnic_io.h"
@@ -149,7 +148,7 @@ unsigned int fnic_count_ioreqs(struct fnic *fnic, u32 portid)
 	fnic_scsi_io_iter(fnic, fnic_count_portid_ioreqs_iter,
 				&portid, &count);
 
-	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+	FNIC_SCSI_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 		      "portid = 0x%x count = %u\n", portid, count);
 	return count;
 }
@@ -181,7 +180,7 @@ fnic_count_lun_ioreqs(struct fnic *fnic, struct scsi_device *scsi_device)
 	fnic_scsi_io_iter(fnic, fnic_count_lun_ioreqs_iter,
 				scsi_device, &count);
 
-	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+	FNIC_SCSI_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 		      "lun = %p count = %u\n", scsi_device, count);
 	return count;
 }
@@ -269,7 +268,7 @@ int fnic_fw_reset_handler(struct fnic *fnic)
 	if (!vnic_wq_copy_desc_avail(wq))
 		ret = -EAGAIN;
 	else {
-		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			  "ioreq_count: %u\n", ioreq_count);
 		fnic_queue_wq_copy_desc_fw_reset(wq, SCSI_NO_TAG);
 		atomic64_inc(&fnic->fnic_stats.fw_stats.active_fw_reqs);
@@ -284,11 +283,11 @@ int fnic_fw_reset_handler(struct fnic *fnic)
 
 	if (!ret) {
 		atomic64_inc(&fnic->fnic_stats.reset_stats.fw_resets);
-		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				"Issued fw reset\n");
 	} else {
 		fnic_clear_state_flags(fnic, FNIC_FLAGS_FWRESET);
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 				"Failed to issue fw reset\n");
 	}
 
@@ -327,13 +326,13 @@ int fnic_flogi_reg_handler(struct fnic *fnic, u32 fc_id)
 						fc_id, gw_mac,
 						fnic->iport.fpma,
 						iport->r_a_tov, iport->e_d_tov);
-		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			      "FLOGI FIP reg issued fcid: 0x%x src %p dest %p\n",
 				  fc_id, fnic->iport.fpma, gw_mac);
 	} else {
 		fnic_queue_wq_copy_desc_flogi_reg(wq, SCSI_NO_TAG,
 						  format, fc_id, gw_mac);
-		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			"FLOGI reg issued fcid 0x%x dest %p\n",
 			fc_id, gw_mac);
 	}
@@ -414,7 +413,7 @@ static inline int fnic_queue_wq_copy_desc(struct fnic *fnic,
 		free_wq_copy_descs(fnic, wq, hwq);
 
 	if (unlikely(!vnic_wq_copy_desc_avail(wq))) {
-		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			  "fnic_queue_wq_copy_desc failure - no descriptors\n");
 		atomic64_inc(&misc_stats->io_cpwq_alloc_failures);
 		return SCSI_MLQUEUE_HOST_BUSY;
@@ -479,7 +478,7 @@ int fnic_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *sc)
 
 	rport = starget_to_rport(scsi_target(sc->device));
 	if (!rport) {
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 				"returning DID_NO_CONNECT for IO as rport is NULL\n");
 		sc->result = DID_NO_CONNECT << 16;
 		done(sc);
@@ -488,7 +487,7 @@ int fnic_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *sc)
 
 	ret = fc_remote_port_chkready(rport);
 	if (ret) {
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 				"rport is not ready\n");
 		atomic64_inc(&fnic_stats->misc_stats.tport_not_ready);
 		sc->result = ret;
@@ -502,7 +501,7 @@ int fnic_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *sc)
 
 	if (iport->state != FNIC_IPORT_STATE_READY) {
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 					  "returning DID_NO_CONNECT for IO as iport state: %d\n",
 					  iport->state);
 		sc->result = DID_NO_CONNECT << 16;
@@ -516,13 +515,13 @@ int fnic_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *sc)
 	rdd_data = rport->dd_data;
 	tport = rdd_data->tport;
 	if (!tport || (rdd_data->iport != iport)) {
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 					  "dd_data not yet set in SCSI for rport portid: 0x%x\n",
 					  rport->port_id);
 		tport = fnic_find_tport_by_fcid(iport, rport->port_id);
 		if (!tport) {
 			spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-			FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+			FNIC_SCSI_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 						  "returning DID_BUS_BUSY for IO as tport not found for: 0x%x\n",
 						  rport->port_id);
 			sc->result = DID_BUS_BUSY << 16;
@@ -545,7 +544,7 @@ int fnic_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *sc)
 	if ((tport->state != FDLS_TGT_STATE_READY)
 		&& (tport->state != FDLS_TGT_STATE_ADISC)) {
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 					  "returning DID_NO_CONNECT for IO as tport state: %d\n",
 					  tport->state);
 		sc->result = DID_NO_CONNECT << 16;
@@ -565,7 +564,7 @@ int fnic_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *sc)
 
 	if (unlikely(fnic_chk_state_flags_locked(fnic, FNIC_FLAGS_FWRESET))) {
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 		  "fnic flags FW reset: 0x%lx. Returning SCSI_MLQUEUE_HOST_BUSY\n",
 		  fnic->state_flags);
 		return SCSI_MLQUEUE_HOST_BUSY;
@@ -707,7 +706,7 @@ int fnic_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *sc)
 	atomic_dec(&tport->in_flight);
 
 	if (lun0_delay) {
-		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					  "LUN0 delay\n");
 		mdelay(LUN0_DELAY_TIME);
 	}
@@ -747,12 +746,12 @@ static int fnic_fcpio_fw_reset_cmpl_handler(struct fnic *fnic,
 	if (fnic->state == FNIC_IN_FC_TRANS_ETH_MODE) {
 		/* Check status of reset completion */
 		if (!hdr_status) {
-			FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_SCSI_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					"reset cmpl success\n");
 			/* Ready to send flogi out */
 			fnic->state = FNIC_IN_ETH_MODE;
 		} else {
-			FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+			FNIC_SCSI_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 				"reset failed with header status: %s\n",
 				fnic_fcpio_status_to_str(hdr_status));
 
@@ -761,7 +760,7 @@ static int fnic_fcpio_fw_reset_cmpl_handler(struct fnic *fnic,
 			ret = -1;
 		}
 	} else {
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 			"Unexpected state while processing reset completion: %s\n",
 			fnic_state_to_str(fnic->state));
 		atomic64_inc(&reset_stats->fw_reset_failures);
@@ -813,19 +812,19 @@ static int fnic_fcpio_flogi_reg_cmpl_handler(struct fnic *fnic,
 
 		/* Check flogi registration completion status */
 		if (!hdr_status) {
-			FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+			FNIC_SCSI_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 				      "FLOGI reg succeeded\n");
 			fnic->state = FNIC_IN_FC_MODE;
 		} else {
 			FNIC_SCSI_DBG(KERN_DEBUG,
-				      fnic->lport->host, fnic->fnic_num,
+				      fnic->host, fnic->fnic_num,
 				      "fnic flogi reg failed: %s\n",
 				      fnic_fcpio_status_to_str(hdr_status));
 			fnic->state = FNIC_IN_ETH_MODE;
 			ret = -1;
 		}
 	} else {
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 			      "Unexpected fnic state %s while"
 			      " processing flogi reg completion\n",
 			      fnic_state_to_str(fnic->state));
@@ -898,7 +897,7 @@ static inline void fnic_fcpio_ack_handler(struct fnic *fnic,
 
 	spin_unlock_irqrestore(&fnic->wq_copy_lock[wq_index], flags);
 	FNIC_TRACE(fnic_fcpio_ack_handler,
-		  fnic->lport->host->host_no, 0, 0, ox_id_tag[2], ox_id_tag[3],
+		  fnic->host->host_no, 0, 0, ox_id_tag[2], ox_id_tag[3],
 		  ox_id_tag[4], ox_id_tag[5]);
 }
 
@@ -936,36 +935,36 @@ static void fnic_fcpio_icmnd_cmpl_handler(struct fnic *fnic, unsigned int cq_ind
 	hwq = blk_mq_unique_tag_to_hwq(mqtag);
 
 	if (hwq != cq_index) {
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 			"hwq: %d mqtag: 0x%x tag: 0x%x cq index: %d ",
 			hwq, mqtag, tag, cq_index);
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 			"hdr status: %s icmnd completion on the wrong queue\n",
 			fnic_fcpio_status_to_str(hdr_status));
 	}
 
 	if (tag >= fnic->fnic_max_tag_id) {
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 			"hwq: %d mqtag: 0x%x tag: 0x%x cq index: %d ",
 			hwq, mqtag, tag, cq_index);
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 			"hdr status: %s Out of range tag\n",
 			fnic_fcpio_status_to_str(hdr_status));
 		return;
 	}
 	spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
 
-	sc = scsi_host_find_tag(fnic->lport->host, id);
+	sc = scsi_host_find_tag(fnic->host, id);
 	WARN_ON_ONCE(!sc);
 	if (!sc) {
 		atomic64_inc(&fnic_stats->io_stats.sc_null);
 		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
-		shost_printk(KERN_ERR, fnic->lport->host,
+		shost_printk(KERN_ERR, fnic->host,
 			  "icmnd_cmpl sc is null - "
 			  "hdr status = %s tag = 0x%x desc = 0x%p\n",
 			  fnic_fcpio_status_to_str(hdr_status), id, desc);
 		FNIC_TRACE(fnic_fcpio_icmnd_cmpl_handler,
-			  fnic->lport->host->host_no, id,
+			  fnic->host->host_no, id,
 			  ((u64)icmnd_cmpl->_resvd0[1] << 16 |
 			  (u64)icmnd_cmpl->_resvd0[0]),
 			  ((u64)hdr_status << 16 |
@@ -988,7 +987,7 @@ static void fnic_fcpio_icmnd_cmpl_handler(struct fnic *fnic, unsigned int cq_ind
 		atomic64_inc(&fnic_stats->io_stats.ioreq_null);
 		fnic_priv(sc)->flags |= FNIC_IO_REQ_NULL;
 		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
-		shost_printk(KERN_ERR, fnic->lport->host,
+		shost_printk(KERN_ERR, fnic->host,
 			  "icmnd_cmpl io_req is null - "
 			  "hdr status = %s tag = 0x%x sc 0x%p\n",
 			  fnic_fcpio_status_to_str(hdr_status), id, sc);
@@ -1015,7 +1014,7 @@ static void fnic_fcpio_icmnd_cmpl_handler(struct fnic *fnic, unsigned int cq_ind
 		if(FCPIO_ABORTED == hdr_status)
 			fnic_priv(sc)->flags |= FNIC_IO_ABORTED;
 
-		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			"icmnd_cmpl abts pending "
 			  "hdr status = %s tag = 0x%x sc = 0x%p "
 			  "scsi_status = %x residual = %d\n",
@@ -1047,7 +1046,7 @@ static void fnic_fcpio_icmnd_cmpl_handler(struct fnic *fnic, unsigned int cq_ind
 		if (icmnd_cmpl->scsi_status == SAM_STAT_TASK_SET_FULL)
 			atomic64_inc(&fnic_stats->misc_stats.queue_fulls);
 
-		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				"xfer_len: %llu", xfer_len);
 		break;
 
@@ -1110,7 +1109,7 @@ static void fnic_fcpio_icmnd_cmpl_handler(struct fnic *fnic, unsigned int cq_ind
 
 	if (hdr_status != FCPIO_SUCCESS) {
 		atomic64_inc(&fnic_stats->io_stats.io_failures);
-		shost_printk(KERN_ERR, fnic->lport->host, "hdr status = %s\n",
+		shost_printk(KERN_ERR, fnic->host, "hdr status = %s\n",
 			     fnic_fcpio_status_to_str(hdr_status));
 	}
 
@@ -1203,27 +1202,27 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic, unsigned int cq_inde
 	hwq = blk_mq_unique_tag_to_hwq(id & FNIC_TAG_MASK);
 
 	if (hwq != cq_index) {
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 			"hwq: %d mqtag: 0x%x tag: 0x%x cq index: %d ",
 			hwq, mqtag, tag, cq_index);
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 			"hdr status: %s ITMF completion on the wrong queue\n",
 			fnic_fcpio_status_to_str(hdr_status));
 	}
 
 	if (tag > fnic->fnic_max_tag_id) {
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 			"hwq: %d mqtag: 0x%x tag: 0x%x cq index: %d ",
 			hwq, mqtag, tag, cq_index);
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 			"hdr status: %s Tag out of range\n",
 			fnic_fcpio_status_to_str(hdr_status));
 		return;
 	}  else if ((tag == fnic->fnic_max_tag_id) && !(id & FNIC_TAG_DEV_RST)) {
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 			"hwq: %d mqtag: 0x%x tag: 0x%x cq index: %d ",
 			hwq, mqtag, tag, cq_index);
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 			"hdr status: %s Tag out of range\n",
 			fnic_fcpio_status_to_str(hdr_status));
 		return;
@@ -1239,14 +1238,14 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic, unsigned int cq_inde
 		if (io_req)
 			sc = io_req->sc;
 	} else {
-		sc = scsi_host_find_tag(fnic->lport->host, id & FNIC_TAG_MASK);
+		sc = scsi_host_find_tag(fnic->host, id & FNIC_TAG_MASK);
 	}
 
 	WARN_ON_ONCE(!sc);
 	if (!sc) {
 		atomic64_inc(&fnic_stats->io_stats.sc_null);
 		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
-		shost_printk(KERN_ERR, fnic->lport->host,
+		shost_printk(KERN_ERR, fnic->host,
 			  "itmf_cmpl sc is null - hdr status = %s tag = 0x%x\n",
 			  fnic_fcpio_status_to_str(hdr_status), tag);
 		return;
@@ -1258,7 +1257,7 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic, unsigned int cq_inde
 		atomic64_inc(&fnic_stats->io_stats.ioreq_null);
 		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		fnic_priv(sc)->flags |= FNIC_IO_ABT_TERM_REQ_NULL;
-		shost_printk(KERN_ERR, fnic->lport->host,
+		shost_printk(KERN_ERR, fnic->host,
 			  "itmf_cmpl io_req is null - "
 			  "hdr status = %s tag = 0x%x sc 0x%p\n",
 			  fnic_fcpio_status_to_str(hdr_status), tag, sc);
@@ -1269,7 +1268,7 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic, unsigned int cq_inde
 	if ((id & FNIC_TAG_ABORT) && (id & FNIC_TAG_DEV_RST)) {
 		/* Abort and terminate completion of device reset req */
 		/* REVISIT : Add asserts about various flags */
-		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			"hwq: %d mqtag: 0x%x tag: 0x%x hst: %s Abt/term completion received\n",
 			hwq, mqtag, tag,
 			fnic_fcpio_status_to_str(hdr_status));
@@ -1281,7 +1280,7 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic, unsigned int cq_inde
 		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 	} else if (id & FNIC_TAG_ABORT) {
 		/* Completion of abort cmd */
-		shost_printk(KERN_DEBUG, fnic->lport->host,
+		shost_printk(KERN_DEBUG, fnic->host,
 			"hwq: %d mqtag: 0x%x tag: 0x%x Abort header status: %s\n",
 			hwq, mqtag, tag,
 			fnic_fcpio_status_to_str(hdr_status));
@@ -1296,7 +1295,7 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic, unsigned int cq_inde
 					&term_stats->terminate_fw_timeouts);
 			break;
 		case FCPIO_ITMF_REJECTED:
-			FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_SCSI_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				"abort reject recd. id %d\n",
 				(int)(id & FNIC_TAG_MASK));
 			break;
@@ -1331,7 +1330,7 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic, unsigned int cq_inde
 		if (!(fnic_priv(sc)->flags & (FNIC_IO_ABORTED | FNIC_IO_DONE)))
 			atomic64_inc(&misc_stats->no_icmnd_itmf_cmpls);
 
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 			      "abts cmpl recd. id %d status %s\n",
 			      (int)(id & FNIC_TAG_MASK),
 			      fnic_fcpio_status_to_str(hdr_status));
@@ -1344,11 +1343,11 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic, unsigned int cq_inde
 		if (io_req->abts_done) {
 			complete(io_req->abts_done);
 			spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
-			shost_printk(KERN_INFO, fnic->lport->host,
+			shost_printk(KERN_INFO, fnic->host,
 					"hwq: %d mqtag: 0x%x tag: 0x%x Waking up abort thread\n",
 					hwq, mqtag, tag);
 		} else {
-			FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+			FNIC_SCSI_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 				"hwq: %d mqtag: 0x%x tag: 0x%x hst: %s Completing IO\n",
 				hwq, mqtag,
 				tag, fnic_fcpio_status_to_str(hdr_status));
@@ -1379,7 +1378,7 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic, unsigned int cq_inde
 		}
 	} else if (id & FNIC_TAG_DEV_RST) {
 		/* Completion of device reset */
-		shost_printk(KERN_INFO, fnic->lport->host,
+		shost_printk(KERN_INFO, fnic->host,
 			"hwq: %d mqtag: 0x%x tag: 0x%x DR hst: %s\n",
 			hwq, mqtag,
 			tag, fnic_fcpio_status_to_str(hdr_status));
@@ -1391,7 +1390,7 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic, unsigned int cq_inde
 				  sc->device->host->host_no, id, sc,
 				  jiffies_to_msecs(jiffies - start_time),
 				  desc, 0, fnic_flags_and_state(sc));
-			FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+			FNIC_SCSI_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 				"hwq: %d mqtag: 0x%x tag: 0x%x hst: %s Terminate pending\n",
 				hwq, mqtag,
 				tag, fnic_fcpio_status_to_str(hdr_status));
@@ -1404,7 +1403,7 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic, unsigned int cq_inde
 				  sc->device->host->host_no, id, sc,
 				  jiffies_to_msecs(jiffies - start_time),
 				  desc, 0, fnic_flags_and_state(sc));
-			FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+			FNIC_SCSI_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 				"dev reset cmpl recd after time out. "
 				"id %d status %s\n",
 				(int)(id & FNIC_TAG_MASK),
@@ -1413,7 +1412,7 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic, unsigned int cq_inde
 		}
 		fnic_priv(sc)->state = FNIC_IOREQ_CMD_COMPLETE;
 		fnic_priv(sc)->flags |= FNIC_DEV_RST_DONE;
-		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			"hwq: %d mqtag: 0x%x tag: 0x%x hst: %s DR completion received\n",
 			hwq, mqtag,
 			tag, fnic_fcpio_status_to_str(hdr_status));
@@ -1422,7 +1421,7 @@ static void fnic_fcpio_itmf_cmpl_handler(struct fnic *fnic, unsigned int cq_inde
 		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 
 	} else {
-		shost_printk(KERN_ERR, fnic->lport->host,
+		shost_printk(KERN_ERR, fnic->host,
 			"%s: Unexpected itmf io state: hwq: %d tag 0x%x %s\n",
 			__func__, hwq, id, fnic_ioreq_state_to_str(fnic_priv(sc)->state));
 		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
@@ -1477,7 +1476,7 @@ static int fnic_fcpio_cmpl_handler(struct vnic_dev *vdev,
 		break;
 
 	default:
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 			      "firmware completion type %d\n",
 			      desc->hdr.type);
 		break;
@@ -1538,7 +1537,7 @@ static bool fnic_cleanup_io_iter(struct scsi_cmnd *sc, void *data)
 	io_req = fnic_priv(sc)->io_req;
 	if (!io_req) {
 		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 			"hwq: %d mqtag: 0x%x tag: 0x%x flags: 0x%x No ioreq. Returning\n",
 			hwq, mqtag, tag, fnic_priv(sc)->flags);
 		return true;
@@ -1576,7 +1575,7 @@ static bool fnic_cleanup_io_iter(struct scsi_cmnd *sc, void *data)
 	mempool_free(io_req, fnic->io_req_pool);
 
 	sc->result = DID_TRANSPORT_DISRUPTED << 16;
-	FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+	FNIC_SCSI_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 	"mqtag: 0x%x tag: 0x%x sc: 0x%p duration = %lu DID_TRANSPORT_DISRUPTED\n",
 		mqtag, tag, sc, (jiffies - start_time));
 
@@ -1608,12 +1607,12 @@ static void fnic_cleanup_io(struct fnic *fnic, int exclude_id)
 	struct scsi_cmnd *sc = NULL;
 
 	io_count = fnic_count_all_ioreqs(fnic);
-	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+	FNIC_SCSI_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 				  "Outstanding ioreq count: %d active io count: %lld Waiting\n",
 				  io_count,
 				  atomic64_read(&fnic->fnic_stats.io_stats.active_ios));
 
-	scsi_host_busy_iter(fnic->lport->host,
+	scsi_host_busy_iter(fnic->host,
 						fnic_cleanup_io_iter, fnic);
 
 	/* with sg3utils device reset, SC needs to be retrieved from ioreq */
@@ -1633,7 +1632,7 @@ static void fnic_cleanup_io(struct fnic *fnic, int exclude_id)
 	spin_unlock_irqrestore(&fnic->wq_copy_lock[0], flags);
 
 	while ((io_count = fnic_count_all_ioreqs(fnic))) {
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 		  "Outstanding ioreq count: %d active io count: %lld Waiting\n",
 		  io_count,
 		  atomic64_read(&fnic->fnic_stats.io_stats.active_ios));
@@ -1660,7 +1659,7 @@ void fnic_wq_copy_cleanup_handler(struct vnic_wq_copy *wq,
 	if (id >= fnic->fnic_max_tag_id)
 		return;
 
-	sc = scsi_host_find_tag(fnic->lport->host, id);
+	sc = scsi_host_find_tag(fnic->host, id);
 	if (!sc)
 		return;
 
@@ -1689,7 +1688,7 @@ void fnic_wq_copy_cleanup_handler(struct vnic_wq_copy *wq,
 
 wq_copy_cleanup_scsi_cmd:
 	sc->result = DID_NO_CONNECT << 16;
-	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num, "wq_copy_cleanup_handler:"
+	FNIC_SCSI_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num, "wq_copy_cleanup_handler:"
 		      " DID_NO_CONNECT\n");
 
 	FNIC_TRACE(fnic_wq_copy_cleanup_handler,
@@ -1733,7 +1732,7 @@ static inline int fnic_queue_abort_io_req(struct fnic *fnic, int tag,
 		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		atomic_dec(&fnic->in_flight);
 		atomic_dec(&tport->in_flight);
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 			"fnic_queue_abort_io_req: failure: no descriptors\n");
 		atomic64_inc(&misc_stats->abts_cpwq_alloc_failures);
 		return 1;
@@ -1778,7 +1777,7 @@ static bool fnic_rport_abort_io_iter(struct scsi_cmnd *sc, void *data)
 	hwq = blk_mq_unique_tag_to_hwq(abt_tag);
 
 	if (!sc) {
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 					  "sc is NULL abt_tag: 0x%x hwq: %d\n", abt_tag, hwq);
 		return true;
 	}
@@ -1792,7 +1791,7 @@ static bool fnic_rport_abort_io_iter(struct scsi_cmnd *sc, void *data)
 
 	if ((fnic_priv(sc)->flags & FNIC_DEVICE_RESET) &&
 	    !(fnic_priv(sc)->flags & FNIC_DEV_RST_ISSUED)) {
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 			"hwq: %d abt_tag: 0x%x flags: 0x%x Device reset is not pending\n",
 			hwq, abt_tag, fnic_priv(sc)->flags);
 		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
@@ -1809,16 +1808,16 @@ static bool fnic_rport_abort_io_iter(struct scsi_cmnd *sc, void *data)
 	}
 
 	if (io_req->abts_done) {
-		shost_printk(KERN_ERR, fnic->lport->host,
+		shost_printk(KERN_ERR, fnic->host,
 			"fnic_rport_exch_reset: io_req->abts_done is set state is %s\n",
 			fnic_ioreq_state_to_str(fnic_priv(sc)->state));
 	}
 
 	if (!(fnic_priv(sc)->flags & FNIC_IO_ISSUED)) {
-		shost_printk(KERN_ERR, fnic->lport->host,
+		shost_printk(KERN_ERR, fnic->host,
 			"rport_exch_reset IO not yet issued %p abt_tag 0x%x",
 			sc, abt_tag);
-		shost_printk(KERN_ERR, fnic->lport->host,
+		shost_printk(KERN_ERR, fnic->host,
 			"flags %x state %d\n", fnic_priv(sc)->flags,
 			fnic_priv(sc)->state);
 	}
@@ -1829,11 +1828,13 @@ static bool fnic_rport_abort_io_iter(struct scsi_cmnd *sc, void *data)
 	if (fnic_priv(sc)->flags & FNIC_DEVICE_RESET) {
 		atomic64_inc(&reset_stats->device_reset_terminates);
 		abt_tag |= FNIC_TAG_DEV_RST;
+		FNIC_SCSI_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
+					  "dev reset sc 0x%p\n", sc);
 	}
-	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+	FNIC_SCSI_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 		      "fnic_rport_exch_reset: dev rst sc 0x%p\n", sc);
 	WARN_ON_ONCE(io_req->abts_done);
-	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+	FNIC_SCSI_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 		      "fnic_rport_reset_exch: Issuing abts\n");
 
 	spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
@@ -1851,7 +1852,7 @@ static bool fnic_rport_abort_io_iter(struct scsi_cmnd *sc, void *data)
 		 * lun reset
 		 */
 		spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 			"hwq: %d abt_tag: 0x%x flags: 0x%x Queuing abort failed\n",
 			hwq, abt_tag, fnic_priv(sc)->flags);
 		if (fnic_priv(sc)->state == FNIC_IOREQ_ABTS_PENDING)
@@ -1882,7 +1883,7 @@ void fnic_rport_exch_reset(struct fnic *fnic, u32 port_id)
 		.term_cnt = 0,
 	};
 
-	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+	FNIC_SCSI_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 				  "fnic rport exchange reset for tport: 0x%06x\n",
 				  port_id);
 
@@ -1890,7 +1891,7 @@ void fnic_rport_exch_reset(struct fnic *fnic, u32 port_id)
 		return;
 
 	io_count = fnic_count_ioreqs(fnic, port_id);
-	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+	FNIC_SCSI_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 				  "Starting terminates: rport:0x%x  portid-io-count: %d active-io-count: %lld\n",
 				  port_id, io_count,
 				  atomic64_read(&fnic->fnic_stats.io_stats.active_ios));
@@ -1905,7 +1906,7 @@ void fnic_rport_exch_reset(struct fnic *fnic, u32 port_id)
 	}
 	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 
-	scsi_host_busy_iter(fnic->lport->host, fnic_rport_abort_io_iter,
+	scsi_host_busy_iter(fnic->host, fnic_rport_abort_io_iter,
 			    &iter_data);
 
 	if (iter_data.term_cnt > atomic64_read(&term_stats->max_terminates))
@@ -1916,7 +1917,7 @@ void fnic_rport_exch_reset(struct fnic *fnic, u32 port_id)
 	while ((io_count = fnic_count_ioreqs(fnic, port_id)))
 		schedule_timeout(msecs_to_jiffies(1000));
 
-	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+	FNIC_SCSI_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 				  "rport: 0x%x remaining portid-io-count: %d ",
 				  port_id, io_count);
 }
@@ -1987,8 +1988,8 @@ void fnic_scsi_unload_cleanup(struct fnic *fnic)
 {
 	int hwq = 0;
 
-	fc_remove_host(fnic->lport->host);
-	scsi_remove_host(fnic->lport->host);
+	fc_remove_host(fnic->host);
+	scsi_remove_host(fnic->host);
 	for (hwq = 0; hwq < fnic->wq_copy_count; hwq++)
 		kfree(fnic->sw_copy_wq[hwq].io_req_table);
 }
@@ -2045,10 +2046,10 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 	tport = rdd_data->tport;
 
 	if (!tport) {
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 			  "Abort cmd called after tport delete! rport fcid: 0x%x",
 			  rport->port_id);
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 			  "lun: %llu hwq: 0x%x mqtag: 0x%x Op: 0x%x flags: 0x%x\n",
 			  sc->device->lun, hwq, mqtag,
 			  sc->cmnd[0], fnic_priv(sc)->flags);
@@ -2057,18 +2058,18 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 		goto fnic_abort_cmd_end;
 	}
 
-	FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_SCSI_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 	  "Abort cmd called rport fcid: 0x%x lun: %llu hwq: 0x%x mqtag: 0x%x",
 	  rport->port_id, sc->device->lun, hwq, mqtag);
 
-	FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_SCSI_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				  "Op: 0x%x flags: 0x%x\n",
 				  sc->cmnd[0],
 				  fnic_priv(sc)->flags);
 
 	if (iport->state != FNIC_IPORT_STATE_READY) {
 		atomic64_inc(&fnic_stats->misc_stats.iport_not_ready);
-		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					  "iport NOT in READY state");
 		ret = FAILED;
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
@@ -2077,7 +2078,7 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 
 	if ((tport->state != FDLS_TGT_STATE_READY) &&
 		(tport->state != FDLS_TGT_STATE_ADISC)) {
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 					  "tport state: %d\n", tport->state);
 		ret = FAILED;
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
@@ -2128,7 +2129,7 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 	else
 		atomic64_inc(&abts_stats->abort_issued_greater_than_60_sec);
 
-	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+	FNIC_SCSI_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 		"CDB Opcode: 0x%02x Abort issued time: %lu msec\n",
 		sc->cmnd[0], abt_issued_time);
 	/*
@@ -2219,7 +2220,7 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 
 	if (!(fnic_priv(sc)->flags & (FNIC_IO_ABORTED | FNIC_IO_DONE))) {
 		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 			      "Issuing host reset due to out of order IO\n");
 
 		ret = FAILED;
@@ -2267,7 +2268,7 @@ int fnic_abort_cmd(struct scsi_cmnd *sc)
 		  (u64)sc->cmnd[4] << 8 | sc->cmnd[5]),
 		  fnic_flags_and_state(sc));
 
-	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+	FNIC_SCSI_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 		      "Returning from abort cmd type %x %s\n", task_req,
 		      (ret == SUCCESS) ?
 		      "SUCCESS" : "FAILED");
@@ -2308,7 +2309,7 @@ static inline int fnic_queue_dr_io_req(struct fnic *fnic,
 		free_wq_copy_descs(fnic, wq, hwq);
 
 	if (!vnic_wq_copy_desc_avail(wq)) {
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 			  "queue_dr_io_req failure - no descriptors\n");
 		atomic64_inc(&misc_stats->devrst_cpwq_alloc_failures);
 		ret = -EAGAIN;
@@ -2376,7 +2377,7 @@ static bool fnic_pending_aborts_iter(struct scsi_cmnd *sc, void *data)
 	 * Found IO that is still pending with firmware and
 	 * belongs to the LUN that we are resetting
 	 */
-	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+	FNIC_SCSI_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 		      "Found IO in %s on lun\n",
 		      fnic_ioreq_state_to_str(fnic_priv(sc)->state));
 
@@ -2386,14 +2387,14 @@ static bool fnic_pending_aborts_iter(struct scsi_cmnd *sc, void *data)
 	}
 	if ((fnic_priv(sc)->flags & FNIC_DEVICE_RESET) &&
 	    (!(fnic_priv(sc)->flags & FNIC_DEV_RST_ISSUED))) {
-		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			      "dev rst not pending sc 0x%p\n", sc);
 		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		return true;
 	}
 
 	if (io_req->abts_done)
-		shost_printk(KERN_ERR, fnic->lport->host,
+		shost_printk(KERN_ERR, fnic->host,
 			     "%s: io_req->abts_done is set state is %s\n",
 			     __func__, fnic_ioreq_state_to_str(fnic_priv(sc)->state));
 	old_ioreq_state = fnic_priv(sc)->state;
@@ -2409,7 +2410,7 @@ static bool fnic_pending_aborts_iter(struct scsi_cmnd *sc, void *data)
 	BUG_ON(io_req->abts_done);
 
 	if (fnic_priv(sc)->flags & FNIC_DEVICE_RESET) {
-		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			      "dev rst sc 0x%p\n", sc);
 	}
 
@@ -2431,7 +2432,7 @@ static bool fnic_pending_aborts_iter(struct scsi_cmnd *sc, void *data)
 			fnic_priv(sc)->state = old_ioreq_state;
 		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 		iter_data->ret = FAILED;
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 			"hwq: %d abt_tag: 0x%lx Abort could not be queued\n",
 			hwq, abt_tag);
 		return false;
@@ -2510,7 +2511,7 @@ static int fnic_clean_pending_aborts(struct fnic *fnic,
 
 	iter_data.lr_sc = lr_sc;
 
-	scsi_host_busy_iter(fnic->lport->host,
+	scsi_host_busy_iter(fnic->host,
 			    fnic_pending_aborts_iter, &iter_data);
 	if (iter_data.ret == FAILED) {
 		ret = iter_data.ret;
@@ -2523,7 +2524,7 @@ static int fnic_clean_pending_aborts(struct fnic *fnic,
 		ret = 1;
 
 clean_pending_aborts_end:
-	FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_SCSI_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			"exit status: %d\n", ret);
 	return ret;
 }
@@ -2573,7 +2574,7 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 	rport = starget_to_rport(scsi_target(sc->device));
 
 	spin_lock_irqsave(&fnic->fnic_lock, flags);
-	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+	FNIC_SCSI_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 		"fcid: 0x%x lun: %llu hwq: %d mqtag: 0x%x flags: 0x%x Device reset\n",
 		rport->port_id, sc->device->lun, hwq, mqtag,
 		fnic_priv(sc)->flags);
@@ -2581,7 +2582,7 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 	rdd_data = rport->dd_data;
 	tport = rdd_data->tport;
 	if (!tport) {
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 		  "Dev rst called after tport delete! rport fcid: 0x%x lun: %llu\n",
 		  rport->port_id, sc->device->lun);
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
@@ -2590,7 +2591,7 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 
 	if (iport->state != FNIC_IPORT_STATE_READY) {
 		atomic64_inc(&fnic_stats->misc_stats.iport_not_ready);
-		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					  "iport NOT in READY state");
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 		goto fnic_device_reset_end;
@@ -2598,7 +2599,7 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 
 	if ((tport->state != FDLS_TGT_STATE_READY) &&
 		(tport->state != FDLS_TGT_STATE_ADISC)) {
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 					  "tport state: %d\n", tport->state);
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 		goto fnic_device_reset_end;
@@ -2661,7 +2662,7 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 	fnic_priv(sc)->lr_status = FCPIO_INVALID_CODE;
 	spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
 
-	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num, "TAG %x\n", mqtag);
+	FNIC_SCSI_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num, "TAG %x\n", mqtag);
 
 	/*
 	 * issue the device reset, if enqueue failed, clean up the ioreq
@@ -2712,13 +2713,13 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 	io_req = fnic_priv(sc)->io_req;
 	if (!io_req) {
 		spin_unlock_irqrestore(&fnic->wq_copy_lock[hwq], flags);
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 				"io_req is null mqtag 0x%x sc 0x%p\n", mqtag, sc);
 		goto fnic_device_reset_end;
 	}
 
 	if (exit_dr) {
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 					  "Host reset called for fnic. Exit device reset\n");
 		io_req->dr_done = NULL;
 		goto fnic_device_reset_clean;
@@ -2733,7 +2734,7 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 	 */
 	if (status == FCPIO_INVALID_CODE) {
 		atomic64_inc(&reset_stats->device_reset_timeouts);
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 			      "Device reset timed out\n");
 		fnic_priv(sc)->flags |= FNIC_DEV_RST_TIMED_OUT;
 		int_to_scsilun(sc->device->lun, &fc_lun);
@@ -2746,7 +2747,7 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 	if (status != FCPIO_SUCCESS) {
 		spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
 		FNIC_SCSI_DBG(KERN_DEBUG,
-			      fnic->lport->host, fnic->fnic_num,
+			      fnic->host, fnic->fnic_num,
 			      "Device reset completed - failed\n");
 		io_req = fnic_priv(sc)->io_req;
 		goto fnic_device_reset_clean;
@@ -2762,7 +2763,7 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 	if (fnic_clean_pending_aborts(fnic, sc, new_sc)) {
 		spin_lock_irqsave(&fnic->wq_copy_lock[hwq], flags);
 		io_req = fnic_priv(sc)->io_req;
-		FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 					  "Device reset failed: Cannot abort all IOs\n");
 		goto fnic_device_reset_clean;
 	}
@@ -2816,13 +2817,13 @@ int fnic_device_reset(struct scsi_cmnd *sc)
 			ret = FAILED;
 			break;
 		}
-		FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 					  "Cannot clean up all IOs for the LUN\n");
 		schedule_timeout(msecs_to_jiffies(1000));
 		count++;
 	}
 
-	FNIC_SCSI_DBG(KERN_DEBUG, fnic->lport->host, fnic->fnic_num,
+	FNIC_SCSI_DBG(KERN_DEBUG, fnic->host, fnic->fnic_num,
 		      "Returning from device reset %s\n",
 		      (ret == SUCCESS) ?
 		      "SUCCESS" : "FAILED");
@@ -2857,13 +2858,13 @@ void fnic_reset(struct Scsi_Host *shost)
 	fnic = *((struct fnic **) shost_priv(shost));
 	reset_stats = &fnic->fnic_stats.reset_stats;
 
-	FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_SCSI_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				  "Issuing fnic reset\n");
 
 	atomic64_inc(&reset_stats->fnic_resets);
 	fnic_post_flogo_linkflap(fnic);
 
-	FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_SCSI_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				  "Returning from fnic reset");
 
 	atomic64_inc(&reset_stats->fnic_reset_completions);
@@ -2874,7 +2875,7 @@ int fnic_issue_fc_host_lip(struct Scsi_Host *shost)
 	int ret = 0;
 	struct fnic *fnic = *((struct fnic **) shost_priv(shost));
 
-	FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_SCSI_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				  "FC host lip issued");
 
 	ret = fnic_host_reset(shost);
@@ -2900,7 +2901,7 @@ int fnic_host_reset(struct Scsi_Host *shost)
 		spin_lock_irqsave(&fnic->fnic_lock, flags);
 		if (fnic->reset_in_progress == IN_PROGRESS) {
 			spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-			FNIC_SCSI_DBG(KERN_WARNING, fnic->lport->host, fnic->fnic_num,
+			FNIC_SCSI_DBG(KERN_WARNING, fnic->host, fnic->fnic_num,
 			  "Firmware reset in progress. Skipping another host reset\n");
 			return SUCCESS;
 		}
@@ -2938,7 +2939,7 @@ int fnic_host_reset(struct Scsi_Host *shost)
 	}
 	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 
-	FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_SCSI_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				  "host reset return status: %d\n", ret);
 	return ret;
 }
@@ -2978,7 +2979,7 @@ static bool fnic_abts_pending_iter(struct scsi_cmnd *sc, void *data)
 	 * Found IO that is still pending with firmware and
 	 * belongs to the LUN that we are resetting
 	 */
-	FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_SCSI_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 		"hwq: %d tag: 0x%x Found IO in state: %s on lun\n",
 		hwq, tag,
 		fnic_ioreq_state_to_str(fnic_priv(sc)->state));
@@ -3011,7 +3012,7 @@ int fnic_is_abts_pending(struct fnic *fnic, struct scsi_cmnd *lr_sc)
 	}
 
 	/* walk again to check, if IOs are still pending in fw */
-	scsi_host_busy_iter(fnic->lport->host,
+	scsi_host_busy_iter(fnic->host,
 			    fnic_abts_pending_iter, &iter_data);
 
 	return iter_data.ret;
@@ -3032,7 +3033,7 @@ int fnic_eh_host_reset_handler(struct scsi_cmnd *sc)
 	struct Scsi_Host *shost = sc->device->host;
 	struct fnic *fnic = *((struct fnic **) shost_priv(shost));
 
-	FNIC_SCSI_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
+	FNIC_SCSI_DBG(KERN_ERR, fnic->host, fnic->fnic_num,
 				  "SCSI error handling: fnic host reset");
 
 	ret = fnic_host_reset(shost);
@@ -3053,7 +3054,7 @@ void fnic_scsi_fcpio_reset(struct fnic *fnic)
 	if (unlikely(fnic->state == FNIC_IN_FC_TRANS_ETH_MODE)) {
 		/* fw reset is in progress, poll for its completion */
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 			  "fnic is in unexpected state: %d for fw_reset\n",
 			  fnic->state);
 		return;
@@ -3066,7 +3067,7 @@ void fnic_scsi_fcpio_reset(struct fnic *fnic)
 	fnic->fw_reset_done = &fw_reset_done;
 	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 
-	FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+	FNIC_SCSI_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				  "Issuing fw reset\n");
 	if (fnic_fw_reset_handler(fnic)) {
 		spin_lock_irqsave(&fnic->fnic_lock, flags);
@@ -3074,14 +3075,14 @@ void fnic_scsi_fcpio_reset(struct fnic *fnic)
 			fnic->state = old_state;
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 	} else {
-		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					  "Waiting for fw completion\n");
 		time_remain = wait_for_completion_timeout(&fw_reset_done,
 						  msecs_to_jiffies(FNIC_FW_RESET_TIMEOUT));
-		FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+		FNIC_SCSI_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 					  "Woken up after fw completion timeout\n");
 		if (time_remain == 0) {
-			FNIC_SCSI_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
+			FNIC_SCSI_DBG(KERN_INFO, fnic->host, fnic->fnic_num,
 				  "FW reset completion timed out after %d ms)\n",
 				  FNIC_FW_RESET_TIMEOUT);
 		}
-- 
2.47.0


