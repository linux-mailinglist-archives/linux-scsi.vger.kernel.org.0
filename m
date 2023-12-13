Return-Path: <linux-scsi+bounces-832-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F14880D40F
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Dec 2023 18:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49EB52820A2
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Dec 2023 17:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF364E601;
	Mon, 11 Dec 2023 17:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="h+UuXWUc"
X-Original-To: linux-scsi@vger.kernel.org
Received: from alln-iport-6.cisco.com (alln-iport-6.cisco.com [173.37.142.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A1EF5;
	Mon, 11 Dec 2023 09:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=3417; q=dns/txt; s=iport;
  t=1702316230; x=1703525830;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6SK31m/xgzin/ld6/lGXf2IyXG9SZiePNHpiDRsZ/fI=;
  b=h+UuXWUcuBY8BLrQjBGfQga3EqFA3iPYUJP+58XBHx8qAr2lERQSkQFc
   HQ+L125V6pg4vB8K+ffY9O60QgCB6ksyBoMKgjQkK458a0odvfJHMyP8q
   ylELZyZAq8KCK8YMAh385YCW6kTR2lv+srr3M9s8qskfWFBvm+nl4OCHi
   U=;
X-CSE-ConnectionGUID: frN6eqE3Q9aXZYLtXLYzLw==
X-CSE-MsgGUID: wuAWw6OpQsaT3JlWtZytGQ==
X-IronPort-AV: E=Sophos;i="6.04,268,1695686400"; 
   d="scan'208";a="193289207"
Received: from rcdn-core-1.cisco.com ([173.37.93.152])
  by alln-iport-6.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 17:37:07 +0000
Received: from localhost.cisco.com ([10.193.101.253])
	(authenticated bits=0)
	by rcdn-core-1.cisco.com (8.15.2/8.15.2) with ESMTPSA id 3BBHaKqu009547
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 11 Dec 2023 17:37:07 GMT
From: Karan Tilak Kumar <kartilak@cisco.com>
To: sebaddel@cisco.com
Cc: arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com, mkai2@cisco.com,
        satishkh@cisco.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Karan Tilak Kumar <kartilak@cisco.com>
Subject: [PATCH v6 02/13] scsi: fnic: Add and use fnic number
Date: Mon, 11 Dec 2023 09:36:06 -0800
Message-Id: <20231211173617.932990-3-kartilak@cisco.com>
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

Add fnic_num in fnic.h to identify fnic in a multi-fnic environment.
Increment and set the fnic number during driver load in fnic_probe.
Replace the host number with fnic number in debugfs.

Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
---
Changes between v4 and v5:
    Incorporate review comments from Martin:
	Modify patch commits to include a "---" separator.

Changes between v3 and v4:
    Incorporate review comments from Martin and Hannes:
	Undo the change to replace host number with fnic
	number in debugfs since kernel stack uses host number.
	Use ida_alloc to allocate ID for fnic number.
---
 drivers/scsi/fnic/fnic.h      |  1 +
 drivers/scsi/fnic/fnic_main.c | 18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index 22cef283b2b9..721a31a03628 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -216,6 +216,7 @@ struct fnic_event {
 
 /* Per-instance private data structure */
 struct fnic {
+	int fnic_num;
 	struct fc_lport *lport;
 	struct fcoe_ctlr ctlr;		/* FIP FCoE controller structure */
 	struct vnic_dev_bar bar0;
diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
index f27f9319e0b2..3044723e125e 100644
--- a/drivers/scsi/fnic/fnic_main.c
+++ b/drivers/scsi/fnic/fnic_main.c
@@ -39,6 +39,7 @@ static struct kmem_cache *fnic_sgl_cache[FNIC_SGL_NUM_CACHES];
 static struct kmem_cache *fnic_io_req_cache;
 static LIST_HEAD(fnic_list);
 static DEFINE_SPINLOCK(fnic_list_lock);
+static DEFINE_IDA(fnic_ida);
 
 /* Supported devices by fnic module */
 static struct pci_device_id fnic_id_table[] = {
@@ -583,7 +584,8 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct fc_lport *lp;
 	struct fnic *fnic;
 	mempool_t *pool;
-	int err;
+	int err = 0;
+	int fnic_id = 0;
 	int i;
 	unsigned long flags;
 
@@ -597,8 +599,16 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		err = -ENOMEM;
 		goto err_out;
 	}
+
 	host = lp->host;
 	fnic = lport_priv(lp);
+
+	fnic_id = ida_alloc(&fnic_ida, GFP_KERNEL);
+	if (fnic_id < 0) {
+		pr_err("Unable to alloc fnic ID\n");
+		err = fnic_id;
+		goto err_out_ida_alloc;
+	}
 	fnic->lport = lp;
 	fnic->ctlr.lp = lp;
 
@@ -608,7 +618,7 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		 host->host_no);
 
 	host->transportt = fnic_fc_transport;
-
+	fnic->fnic_num = fnic_id;
 	fnic_stats_debugfs_init(fnic);
 
 	/* Setup PCI resources */
@@ -951,6 +961,8 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	pci_disable_device(pdev);
 err_out_free_hba:
 	fnic_stats_debugfs_remove(fnic);
+	ida_free(&fnic_ida, fnic->fnic_num);
+err_out_ida_alloc:
 	scsi_host_put(lp->host);
 err_out:
 	return err;
@@ -1031,6 +1043,7 @@ static void fnic_remove(struct pci_dev *pdev)
 	fnic_iounmap(fnic);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
+	ida_free(&fnic_ida, fnic->fnic_num);
 	scsi_host_put(lp->host);
 }
 
@@ -1168,6 +1181,7 @@ static void __exit fnic_cleanup_module(void)
 	fnic_trace_free();
 	fnic_fc_trace_free();
 	fnic_debugfs_terminate();
+	ida_destroy(&fnic_ida);
 }
 
 module_init(fnic_init_module);
-- 
2.31.1


