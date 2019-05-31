Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCD630DF0
	for <lists+linux-scsi@lfdr.de>; Fri, 31 May 2019 14:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfEaMPV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 31 May 2019 08:15:21 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44664 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfEaMPV (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 31 May 2019 08:15:21 -0400
Received: by mail-ed1-f66.google.com with SMTP id b8so14216008edm.11
        for <linux-scsi@vger.kernel.org>; Fri, 31 May 2019 05:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BWwKvJmkhcBWalyPYKCyqi1ingTWSvPXQKTreXyq4uE=;
        b=gd2dDP21uY407dlsuXqYHCCegP5HqRuTO4LwGo8wBh/E7xhMzLsinKfZxIEJjghXiG
         IMtfuGMAcipacvnGRACl11KETO44m5xOSU3i6H4UHSm+5FwOX3XKZ2iyJK/6ejrOOVqC
         3aLPBLUc6NZug//jeIQufMzcNY8MuJqv7qJV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BWwKvJmkhcBWalyPYKCyqi1ingTWSvPXQKTreXyq4uE=;
        b=QBuhhhJnQNRZvLnNPon4VEidy+dIpcZOShjzGWh699UIrtJOMTbClOWyieBR0scdum
         BUC+17NJ7lVh+qlIj4nKefstA+ftBI+TBtUtCMvv+pdZfKpjiPmmMwyDp5N6bvJu9FAo
         iKRaCV4DTYs80LDQA6g+FOCN312ws+6WZ0H7ny/rVT6uczKtXohdk6J7tvJIGhrRt4Yu
         QdIism62xDsZfv4nzYDb6icpFUNyP+PGt73hNi1c7V0TEXPwA3OOV+kock3uLyd5KvLD
         zclXrvJ2MTlqNY1ozpknEubvFsvYvEL08XKb7QgRxvRCWhaSZXZYTZoJ2hcJ7IAbyl2g
         +R/A==
X-Gm-Message-State: APjAAAWjYoJiqP08SryEZmcOm5Ce+usJNKqFIJVPSwzvt5x92cCZ+waT
        YTQ7tF7au5y0lGWGQ8fNsIh4MjSpfSMIPPwwP+FOeeHFLeTBfPYyg82ouDdDNq5SsmaRAcL6srz
        kTCPfWYREXikqctvC7pU6OudTeLOxX9WZnjqlLS0ygobSwrKLiO3BDPWlyBLmx1iOWXIvDZoh7M
        o8T1rGGoj17Yo1tq4VRA==
X-Google-Smtp-Source: APXvYqy5KI8wKe3tB0RVP1L1uk93YtkdtVAdSlh6h0sVrWbTlx6YC2MAS+v84QpBTdcse1v14YM2Og==
X-Received: by 2002:aa7:c999:: with SMTP id c25mr11230926edt.250.1559304918706;
        Fri, 31 May 2019 05:15:18 -0700 (PDT)
Received: from dhcp-10-123-20-26.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id jz15sm822186ejb.75.2019.05.31.05.15.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 05:15:18 -0700 (PDT)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com
Cc:     kashyap.desai@broadcom.com, sreekanth.reddy@broadcom.com,
        Sathya.Prakash@broadcom.com,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Subject: [V3 04/10] mpt3sas: change _base_get_msix_index prototype
Date:   Fri, 31 May 2019 08:14:37 -0400
Message-Id: <20190531121443.30694-5-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190531121443.30694-1-suganath-prabu.subramani@broadcom.com>
References: <20190531121443.30694-1-suganath-prabu.subramani@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Code refactoring.

In function _base_get_msix_index add scmd as second
argument. This change is required for creating function
pointer in next patch, where we introduce new function to
get the msix index for high iops queues

Signed-off-by: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 30 +++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 6d1a648..57d0e7d 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -3300,8 +3300,18 @@ mpt3sas_base_get_reply_virt_addr(struct MPT3SAS_ADAPTER *ioc, u32 phys_addr)
 	return ioc->reply + (phys_addr - (u32)ioc->reply_dma);
 }
 
+/**
+ * _base_get_msix_index - get the msix index
+ * @ioc: per adapter object
+ * @scmd: scsi_cmnd object
+ *
+ * returns msix index of general reply queues,
+ * i.e. reply queue on which IO request's reply
+ * should be posted by the HBA firmware.
+ */
 static inline u8
-_base_get_msix_index(struct MPT3SAS_ADAPTER *ioc)
+_base_get_msix_index(struct MPT3SAS_ADAPTER *ioc,
+	struct scsi_cmnd *scmd)
 {
 	/* Enables reply_queue load balancing */
 	if (ioc->msix_load_balance)
@@ -3360,7 +3370,7 @@ mpt3sas_base_get_smid_scsiio(struct MPT3SAS_ADAPTER *ioc, u8 cb_idx,
 
 	smid = tag + 1;
 	request->cb_idx = cb_idx;
-	request->msix_io = _base_get_msix_index(ioc);
+	request->msix_io = _base_get_msix_index(ioc, NULL);
 	request->smid = smid;
 	INIT_LIST_HEAD(&request->chain_list);
 	return smid;
@@ -3534,7 +3544,7 @@ _base_put_smid_mpi_ep_scsi_io(struct MPT3SAS_ADAPTER *ioc,
 	_base_clone_mpi_to_sys_mem(mpi_req_iomem, (void *)mfp,
 					ioc->request_sz);
 	descriptor.SCSIIO.RequestFlags = MPI2_REQ_DESCRIPT_FLAGS_SCSI_IO;
-	descriptor.SCSIIO.MSIxIndex =  _base_get_msix_index(ioc);
+	descriptor.SCSIIO.MSIxIndex =  _base_get_msix_index(ioc, NULL);
 	descriptor.SCSIIO.SMID = cpu_to_le16(smid);
 	descriptor.SCSIIO.DevHandle = cpu_to_le16(handle);
 	descriptor.SCSIIO.LMID = 0;
@@ -3556,7 +3566,7 @@ _base_put_smid_scsi_io(struct MPT3SAS_ADAPTER *ioc, u16 smid, u16 handle)
 
 
 	descriptor.SCSIIO.RequestFlags = MPI2_REQ_DESCRIPT_FLAGS_SCSI_IO;
-	descriptor.SCSIIO.MSIxIndex =  _base_get_msix_index(ioc);
+	descriptor.SCSIIO.MSIxIndex =  _base_get_msix_index(ioc, NULL);
 	descriptor.SCSIIO.SMID = cpu_to_le16(smid);
 	descriptor.SCSIIO.DevHandle = cpu_to_le16(handle);
 	descriptor.SCSIIO.LMID = 0;
@@ -3579,7 +3589,7 @@ _base_put_smid_fast_path(struct MPT3SAS_ADAPTER *ioc, u16 smid,
 
 	descriptor.SCSIIO.RequestFlags =
 	    MPI25_REQ_DESCRIPT_FLAGS_FAST_PATH_SCSI_IO;
-	descriptor.SCSIIO.MSIxIndex = _base_get_msix_index(ioc);
+	descriptor.SCSIIO.MSIxIndex = _base_get_msix_index(ioc, NULL);
 	descriptor.SCSIIO.SMID = cpu_to_le16(smid);
 	descriptor.SCSIIO.DevHandle = cpu_to_le16(handle);
 	descriptor.SCSIIO.LMID = 0;
@@ -3643,7 +3653,7 @@ mpt3sas_base_put_smid_nvme_encap(struct MPT3SAS_ADAPTER *ioc, u16 smid)
 
 	descriptor.Default.RequestFlags =
 		MPI26_REQ_DESCRIPT_FLAGS_PCIE_ENCAPSULATED;
-	descriptor.Default.MSIxIndex =  _base_get_msix_index(ioc);
+	descriptor.Default.MSIxIndex =  _base_get_msix_index(ioc, NULL);
 	descriptor.Default.SMID = cpu_to_le16(smid);
 	descriptor.Default.LMID = 0;
 	descriptor.Default.DescriptorTypeDependent = 0;
@@ -3675,7 +3685,7 @@ _base_put_smid_default(struct MPT3SAS_ADAPTER *ioc, u16 smid)
 	}
 	request = (u64 *)&descriptor;
 	descriptor.Default.RequestFlags = MPI2_REQ_DESCRIPT_FLAGS_DEFAULT_TYPE;
-	descriptor.Default.MSIxIndex =  _base_get_msix_index(ioc);
+	descriptor.Default.MSIxIndex =  _base_get_msix_index(ioc, NULL);
 	descriptor.Default.SMID = cpu_to_le16(smid);
 	descriptor.Default.LMID = 0;
 	descriptor.Default.DescriptorTypeDependent = 0;
@@ -3705,7 +3715,7 @@ _base_put_smid_scsi_io_atomic(struct MPT3SAS_ADAPTER *ioc, u16 smid,
 	u32 *request = (u32 *)&descriptor;
 
 	descriptor.RequestFlags = MPI2_REQ_DESCRIPT_FLAGS_SCSI_IO;
-	descriptor.MSIxIndex = _base_get_msix_index(ioc);
+	descriptor.MSIxIndex = _base_get_msix_index(ioc, NULL);
 	descriptor.SMID = cpu_to_le16(smid);
 
 	writel(cpu_to_le32(*request), &ioc->chip->AtomicRequestDescriptorPost);
@@ -3727,7 +3737,7 @@ _base_put_smid_fast_path_atomic(struct MPT3SAS_ADAPTER *ioc, u16 smid,
 	u32 *request = (u32 *)&descriptor;
 
 	descriptor.RequestFlags = MPI25_REQ_DESCRIPT_FLAGS_FAST_PATH_SCSI_IO;
-	descriptor.MSIxIndex = _base_get_msix_index(ioc);
+	descriptor.MSIxIndex = _base_get_msix_index(ioc, NULL);
 	descriptor.SMID = cpu_to_le16(smid);
 
 	writel(cpu_to_le32(*request), &ioc->chip->AtomicRequestDescriptorPost);
@@ -3771,7 +3781,7 @@ _base_put_smid_default_atomic(struct MPT3SAS_ADAPTER *ioc, u16 smid)
 	u32 *request = (u32 *)&descriptor;
 
 	descriptor.RequestFlags = MPI2_REQ_DESCRIPT_FLAGS_DEFAULT_TYPE;
-	descriptor.MSIxIndex = _base_get_msix_index(ioc);
+	descriptor.MSIxIndex = _base_get_msix_index(ioc, NULL);
 	descriptor.SMID = cpu_to_le16(smid);
 
 	writel(cpu_to_le32(*request), &ioc->chip->AtomicRequestDescriptorPost);
-- 
2.18.1

