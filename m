Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5740780674
	for <lists+linux-scsi@lfdr.de>; Sat,  3 Aug 2019 16:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391081AbfHCOAd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 3 Aug 2019 10:00:33 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37000 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391048AbfHCOAc (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 3 Aug 2019 10:00:32 -0400
Received: by mail-pf1-f196.google.com with SMTP id 19so37421466pfa.4
        for <linux-scsi@vger.kernel.org>; Sat, 03 Aug 2019 07:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ztnyeuKuc6TSo/zopSbLn72WwyKQgh3z/qIXNzpetHk=;
        b=RV9mXcB9xVKrMlDz0aX6Gsi06U+UtQoJAmvNmbuIQuKkbLJEM4n/QWOLS3qSt2bk+3
         jA1rvUtHv6m0bl12sn2PkV+/HR0PVDyFGtJHEzHbCa7jB29FTbR+eNqCeR6/DHDgMh2d
         eQuGstUQPaqk+4Ie8DsD1nZ/aPbPNNXAw1eSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ztnyeuKuc6TSo/zopSbLn72WwyKQgh3z/qIXNzpetHk=;
        b=QfMxqp2Xic34mXj5Q3060M4y5+R8xXByYZ4bmu8Z8sVzUlkqaZT1ItZsNh7R72m+Za
         4+jyR1IyNJkCOOmML5FRsTfGjEuCDI6lLSohq9lH5s380U5hD5GBfs5KyHa6K7Rlarht
         ILPIvunOnV/insYi+GI26KxoUJinyg4VAU3NmRxBWcm+ypY2nj+fvOa0zqdAlGCuhSSz
         Zgt8GHCgWkfMtBiKLXqygL7FXrXnY0I+l6EwKfTMDy6nz2vSK1Knd303aQgm8hIeP3hP
         bmkaSELK4Q3DhitzCMalAVnbhzPtxe0HScTVZxyQL/anK6TpTuuGyqp4INPSQHhVvLaZ
         JJZw==
X-Gm-Message-State: APjAAAX2FhM0UfKrMxvjD3t0Jwegi+S1l8vYDBbqtZK/iD3uf6R+cYNI
        iYYBJ7hbTTJBqESaXPc+VOuKrZa9NugYDU3paoo80lLVxsiBbsbAycllHU68n6O3JyXaPAVc5Qa
        u8pmsAcWaBEcRDC/UTVw/xmCjcuIogdkc+W5D5Ie7T0lcXLLtW8+fV2xzyoFehAGcktVRuh7RcO
        xXVyh2d+mobj7sj44Gow==
X-Google-Smtp-Source: APXvYqxJ03jndSQjleplxTb4Q3ViSCRQp2lbOpiFDArJUNkczqITS4v0+9WK2RVzs5nJUYVL1wEATA==
X-Received: by 2002:a65:6817:: with SMTP id l23mr88170898pgt.46.1564840831305;
        Sat, 03 Aug 2019 07:00:31 -0700 (PDT)
Received: from dhcp-10-123-20-15.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id c69sm11711615pje.6.2019.08.03.07.00.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 07:00:30 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     Sathya.Prakash@broadcom.com, kashyap.desai@broadcom.com,
        sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH 09/12] mpt3sas: Handle fault during HBA initialization
Date:   Sat,  3 Aug 2019 09:59:54 -0400
Message-Id: <1564840797-5876-10-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1564840797-5876-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1564840797-5876-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

During HBA initialization time, if handshake operation fails
due to some firmware fault then currently driver is terminating
the HBA initialization. It is possible that HBA may come up properly
if diag reset is issued.

So improvement is made in driver in such a way that
before terminating the HBA initialization driver checks the IOC
state and if IOC state is in fault state then issue diag reset
for once. if diag reset is success then continue with
HBA initialization else terminate the HBA initialization.

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 75 ++++++++++++++++++++++++++++++-------
 1 file changed, 62 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 03d15f5..f913b18 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -3183,6 +3183,37 @@ mpt3sas_base_unmap_resources(struct MPT3SAS_ADAPTER *ioc)
 	}
 }
 
+static int
+_base_diag_reset(struct MPT3SAS_ADAPTER *ioc);
+
+/**
+ * _base_check_for_fault_and_issue_reset - check if IOC is in fault state
+ *     and if it is in fault state then issue diag reset.
+ * @ioc: per adapter object
+ *
+ * Returns: 0 for success, non-zero for failure.
+ */
+static int
+_base_check_for_fault_and_issue_reset(struct MPT3SAS_ADAPTER *ioc)
+{
+	u32 ioc_state;
+	int rc = -EFAULT;
+
+	dinitprintk(ioc, pr_info("%s\n", __func__));
+	if (ioc->pci_error_recovery)
+		return 0;
+	ioc_state = mpt3sas_base_get_iocstate(ioc, 0);
+	dhsprintk(ioc, pr_info("%s: ioc_state(0x%08x)\n", __func__, ioc_state));
+
+	if ((ioc_state & MPI2_IOC_STATE_MASK) == MPI2_IOC_STATE_FAULT) {
+		mpt3sas_base_fault_info(ioc, ioc_state &
+		    MPI2_DOORBELL_DATA_MASK);
+		rc = _base_diag_reset(ioc);
+	}
+
+	return rc;
+}
+
 /**
  * mpt3sas_base_map_resources - map in controller resources (io/irq/memap)
  * @ioc: per adapter object
@@ -3195,7 +3226,7 @@ mpt3sas_base_map_resources(struct MPT3SAS_ADAPTER *ioc)
 	struct pci_dev *pdev = ioc->pdev;
 	u32 memap_sz;
 	u32 pio_sz;
-	int i, r = 0;
+	int i, r = 0, rc;
 	u64 pio_chip = 0;
 	phys_addr_t chip_phys = 0;
 	struct adapter_reply_queue *reply_q;
@@ -3256,8 +3287,11 @@ mpt3sas_base_map_resources(struct MPT3SAS_ADAPTER *ioc)
 	_base_mask_interrupts(ioc);
 
 	r = _base_get_ioc_facts(ioc);
-	if (r)
-		goto out_fail;
+	if (r) {
+		rc = _base_check_for_fault_and_issue_reset(ioc);
+		if (rc || (_base_get_ioc_facts(ioc)))
+			goto out_fail;
+	}
 
 	if (!ioc->rdpq_array_enable_assigned) {
 		ioc->rdpq_array_enable = ioc->rdpq_array_capable;
@@ -5416,8 +5450,6 @@ _base_wait_on_iocstate(struct MPT3SAS_ADAPTER *ioc, u32 ioc_state, int timeout)
  *
  * Notes: MPI2_HIS_IOC2SYS_DB_STATUS - set to one when IOC writes to doorbell.
  */
-static int
-_base_diag_reset(struct MPT3SAS_ADAPTER *ioc);
 
 static int
 _base_wait_for_doorbell_int(struct MPT3SAS_ADAPTER *ioc, int timeout)
@@ -6693,7 +6725,7 @@ _base_make_ioc_ready(struct MPT3SAS_ADAPTER *ioc, enum reset_type type)
 static int
 _base_make_ioc_operational(struct MPT3SAS_ADAPTER *ioc)
 {
-	int r, i, index;
+	int r, i, index, rc;
 	unsigned long	flags;
 	u32 reply_address;
 	u16 smid;
@@ -6796,8 +6828,19 @@ _base_make_ioc_operational(struct MPT3SAS_ADAPTER *ioc)
  skip_init_reply_post_free_queue:
 
 	r = _base_send_ioc_init(ioc);
-	if (r)
-		return r;
+	if (r) {
+		/*
+		 * No need to check IOC state for fault state & issue
+		 * diag reset during host reset. This check is need
+		 * only during driver load time.
+		 */
+		if (!ioc->is_driver_loading)
+			return r;
+
+		rc = _base_check_for_fault_and_issue_reset(ioc);
+		if (rc || (_base_send_ioc_init(ioc)))
+			return r;
+	}
 
 	/* initialize reply free host index */
 	ioc->reply_free_host_index = ioc->reply_free_queue_depth - 1;
@@ -6889,7 +6932,7 @@ mpt3sas_base_free_resources(struct MPT3SAS_ADAPTER *ioc)
 int
 mpt3sas_base_attach(struct MPT3SAS_ADAPTER *ioc)
 {
-	int r, i;
+	int r, i, rc;
 	int cpu_id, last_cpu_id = 0;
 
 	dinitprintk(ioc, ioc_info(ioc, "%s\n", __func__));
@@ -6933,8 +6976,11 @@ mpt3sas_base_attach(struct MPT3SAS_ADAPTER *ioc)
 
 	pci_set_drvdata(ioc->pdev, ioc->shost);
 	r = _base_get_ioc_facts(ioc);
-	if (r)
-		goto out_free_resources;
+	if (r) {
+		rc = _base_check_for_fault_and_issue_reset(ioc);
+		if (rc || (_base_get_ioc_facts(ioc)))
+			goto out_free_resources;
+	}
 
 	switch (ioc->hba_mpi_version_belonged) {
 	case MPI2_VERSION:
@@ -7002,8 +7048,11 @@ mpt3sas_base_attach(struct MPT3SAS_ADAPTER *ioc)
 
 	for (i = 0 ; i < ioc->facts.NumberOfPorts; i++) {
 		r = _base_get_port_facts(ioc, i);
-		if (r)
-			goto out_free_resources;
+		if (r) {
+			rc = _base_check_for_fault_and_issue_reset(ioc);
+			if (rc || (_base_get_port_facts(ioc, i)))
+				goto out_free_resources;
+		}
 	}
 
 	r = _base_allocate_memory_pools(ioc);
-- 
1.8.3.1

