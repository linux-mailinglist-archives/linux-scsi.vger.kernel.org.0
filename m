Return-Path: <linux-scsi+bounces-7577-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3BE95BF4A
	for <lists+linux-scsi@lfdr.de>; Thu, 22 Aug 2024 22:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3130D1F26E85
	for <lists+linux-scsi@lfdr.de>; Thu, 22 Aug 2024 20:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEA715098A;
	Thu, 22 Aug 2024 20:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="YkcDobKf"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592BE37700
	for <linux-scsi@vger.kernel.org>; Thu, 22 Aug 2024 20:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724356818; cv=none; b=cN4SzOgk9JMawkOmnceNxV0wZRcilUGN8jYimYyJTOoao9v8oW33Ibu1OJ6Q6JFArEovF2cB64Hou36zVMqLF7MjzQTXIj+9C09eUyIT7vXB+8zIWfQyuLZG3WCs1OcPH3TT8w4mHGXjGNoX4Umnje/2vBZvonDN/B81U8vFOe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724356818; c=relaxed/simple;
	bh=o10ljLmONycsnD5xQJZYaGnLPjqhRC6/yapUKzQ4TAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHgpcQgV+I/uW18rzd6JiiijPWFCfN6Q7IVGV2edrf0xFCHRmAu/XjjYZF4HFvLIC8Gl9jPB/Q6sWj8txyaCnSukpb25o3DskOPzbv/XDYMPzOXjPGdGrzw8ElxtNL6RLSQNiRgaIm9O65IwTBG28pV3SQyYr4oe1g0skNdz5ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=YkcDobKf; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4WqYw05wg7z6ClY9S;
	Thu, 22 Aug 2024 20:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=mr01; t=1724356812; x=1726948813; bh=NOhjZ
	YZgYhNzxOBwIteWrZ1e+yhklFzUfYuAEEbHfWY=; b=YkcDobKf0RGhSBstPM/dq
	EsKgaBt7zLMZBQZogm8vCPFlzLouYmOumfhLuPBIlVj5xsEH0fOH1M/gzVFGiG0n
	OVhIkJsV6YgkmS82ApGUEx2C7zexcTamEF9SHwg2kmxaJ6MRHHZb4RxOQqT0e16D
	UxJ0fZn7IrjR/MxIN9kTXIS/sWuBdjjBJlNBYd+qL8eCLsfXSHBIDb8oEsO8r19/
	6tXnRfqluFVWARjQzCB/IAvKeQvN/oS5UwQPVPhaJ9xxiHKVQdyLxvN4BBho2u9V
	KHy4TSlDQ7A90Unb9eP9MfCRcAnvJFoXhzS1BrivAX70sI7nmw3kqZOhooqRp9iM
	A==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id t5Xv6Qu1WpWg; Thu, 22 Aug 2024 20:00:12 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4WqYvv3yPDz6ClY9L;
	Thu, 22 Aug 2024 20:00:11 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Sathya Prakash <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH v3 02/18] scsi: mptfusion: Simplify the alloc*_workqueue() invocations
Date: Thu, 22 Aug 2024 12:59:06 -0700
Message-ID: <20240822195944.654691-3-bvanassche@acm.org>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
In-Reply-To: <20240822195944.654691-1-bvanassche@acm.org>
References: <20240822195944.654691-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Let alloc*_workqueue() format the workqueue names instead of calling
snprintf() explicitly.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/message/fusion/mptbase.c | 10 +++-------
 drivers/message/fusion/mptbase.h |  3 ---
 drivers/message/fusion/mptfc.c   |  7 ++-----
 3 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mp=
tbase.c
index 4bf669c55649..738bc4e60a18 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -1856,10 +1856,8 @@ mpt_attach(struct pci_dev *pdev, const struct pci_=
device_id *id)
 	/* Initialize workqueue */
 	INIT_DELAYED_WORK(&ioc->fault_reset_work, mpt_fault_reset_work);
=20
-	snprintf(ioc->reset_work_q_name, MPT_KOBJ_NAME_LEN,
-		 "mpt_poll_%d", ioc->id);
-	ioc->reset_work_q =3D alloc_workqueue(ioc->reset_work_q_name,
-					    WQ_MEM_RECLAIM, 0);
+	ioc->reset_work_q =3D
+		alloc_workqueue("mpt_poll_%d", WQ_MEM_RECLAIM, 0, ioc->id);
 	if (!ioc->reset_work_q) {
 		printk(MYIOC_s_ERR_FMT "Insufficient memory to add adapter!\n",
 		    ioc->name);
@@ -1986,9 +1984,7 @@ mpt_attach(struct pci_dev *pdev, const struct pci_d=
evice_id *id)
=20
 	INIT_LIST_HEAD(&ioc->fw_event_list);
 	spin_lock_init(&ioc->fw_event_lock);
-	snprintf(ioc->fw_event_q_name, MPT_KOBJ_NAME_LEN, "mpt/%d", ioc->id);
-	ioc->fw_event_q =3D alloc_workqueue(ioc->fw_event_q_name,
-					  WQ_MEM_RECLAIM, 0);
+	ioc->fw_event_q =3D alloc_workqueue("mpt/%d", WQ_MEM_RECLAIM, 0, ioc->i=
d);
 	if (!ioc->fw_event_q) {
 		printk(MYIOC_s_ERR_FMT "Insufficient memory to add adapter!\n",
 		    ioc->name);
diff --git a/drivers/message/fusion/mptbase.h b/drivers/message/fusion/mp=
tbase.h
index 8031173c3655..b406fd676da0 100644
--- a/drivers/message/fusion/mptbase.h
+++ b/drivers/message/fusion/mptbase.h
@@ -729,7 +729,6 @@ typedef struct _MPT_ADAPTER
 	struct list_head	 fw_event_list;
 	spinlock_t		 fw_event_lock;
 	u8			 fw_events_off; /* if '1', then ignore events */
-	char 			 fw_event_q_name[MPT_KOBJ_NAME_LEN];
=20
 	struct mutex		 sas_discovery_mutex;
 	u8			 sas_discovery_runtime;
@@ -764,7 +763,6 @@ typedef struct _MPT_ADAPTER
 	u8			 fc_link_speed[2];
 	spinlock_t		 fc_rescan_work_lock;
 	struct work_struct	 fc_rescan_work;
-	char			 fc_rescan_work_q_name[MPT_KOBJ_NAME_LEN];
 	struct workqueue_struct *fc_rescan_work_q;
=20
 	/* driver forced bus resets count */
@@ -778,7 +776,6 @@ typedef struct _MPT_ADAPTER
 	spinlock_t		  scsi_lookup_lock;
 	u64			dma_mask;
 	u32			  broadcast_aen_busy;
-	char			 reset_work_q_name[MPT_KOBJ_NAME_LEN];
 	struct workqueue_struct *reset_work_q;
 	struct delayed_work	 fault_reset_work;
=20
diff --git a/drivers/message/fusion/mptfc.c b/drivers/message/fusion/mptf=
c.c
index a3c17c4fe69c..91242f26defb 100644
--- a/drivers/message/fusion/mptfc.c
+++ b/drivers/message/fusion/mptfc.c
@@ -1349,11 +1349,8 @@ mptfc_probe(struct pci_dev *pdev, const struct pci=
_device_id *id)
=20
 	/* initialize workqueue */
=20
-	snprintf(ioc->fc_rescan_work_q_name, sizeof(ioc->fc_rescan_work_q_name)=
,
-		 "mptfc_wq_%d", sh->host_no);
-	ioc->fc_rescan_work_q =3D
-		alloc_ordered_workqueue(ioc->fc_rescan_work_q_name,
-					WQ_MEM_RECLAIM);
+	ioc->fc_rescan_work_q =3D alloc_ordered_workqueue(
+		"mptfc_wq_%d", WQ_MEM_RECLAIM, sh->host_no);
 	if (!ioc->fc_rescan_work_q) {
 		error =3D -ENOMEM;
 		goto out_mptfc_host;

