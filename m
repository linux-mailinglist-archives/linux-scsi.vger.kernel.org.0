Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7BD23149
	for <lists+linux-scsi@lfdr.de>; Mon, 20 May 2019 12:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731080AbfETK0c (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 May 2019 06:26:32 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37271 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfETK0c (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 20 May 2019 06:26:32 -0400
Received: by mail-pf1-f194.google.com with SMTP id g3so7013924pfi.4
        for <linux-scsi@vger.kernel.org>; Mon, 20 May 2019 03:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XrmnHBi5fUMKGfPJs/5hT1IwXwWa50y3nYUChpav4Zw=;
        b=abW9auCJYGTrazBlWcusvP5zPMkycAD9AXeZhUubmkOcUohMSF28odkRO9vKMlgb4R
         ANuCzYFkx9lhy41BGjjTYWR6AAW9Wd/tAAuvfEo7Mi6xtXa4ISYsrulq2x43irJERd25
         K2jteArthC/asQJs/vRb0QzWuvodJwgULLkGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XrmnHBi5fUMKGfPJs/5hT1IwXwWa50y3nYUChpav4Zw=;
        b=bcZULivfcTXWo0B/p98xJY5nl+AyL/atWToPv9njvM6F+Rj5mXVShyx3+nd4xVGqTp
         qzcP0C1+lujdArZKydI4PwyD7t+HacbydAbP2me+0u/pTxSbzkLrBmFvLTsogWlZcemM
         1XB8uOz80mje1erL7QLXO90DNYGOT0MLl1sjlT070PDP9zd+L7Auf9Zy+dtvUWuNMhXz
         OaVBUCH0cndYkBLrZaTavbKFIVLPZZ9hAxzRanoO5T8nji80M+3kDzAXcGF8F+K58ILy
         T+Oe5cPh4pUAcequO4TC+jMs8nxokQw+FKoc4r0BvNh7wxVl7B4UY4Ge1KCSARDkMb0S
         onzg==
X-Gm-Message-State: APjAAAUdVytkOgJ1toJAE0/o4mhx7bD1rEtV4QJhaYW0daF0b2Rtpc0/
        xTHuWdrchjrfOUEMMM807RCKinfpB9Wlt15eymZ8vDx13H2RXFykwnUN1wjcvFL5CJM+g+pxi4V
        7yoOYTwlbkNYS+4FtXzYW11XwGsigvCGMeaZrPYpa0b57f+1qG/TniZgcVAMtfwuyo1vNNz532u
        Zp3N+s9uId08trea2wiw==
X-Google-Smtp-Source: APXvYqwg5RYoxQZ3RFYZpVXzgpO7fO3KJ0uvQm+dRNaLgw1ewtHX4B1BX715eYqpmM8k2BP8T5rjVg==
X-Received: by 2002:a63:1212:: with SMTP id h18mr24826305pgl.266.1558347990988;
        Mon, 20 May 2019 03:26:30 -0700 (PDT)
Received: from dhcp-10-123-20-26.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id j2sm15757309pfb.157.2019.05.20.03.26.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 03:26:30 -0700 (PDT)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     suganath-prabu.subramani@broadcom.com, Sathya.Prakash@broadcom.com,
        sreekanth.reddy@broadcom.com
Subject: [PATCH v2 04/10] mpt3sas: change _base_get_msix_index prototype
Date:   Mon, 20 May 2019 06:25:58 -0400
Message-Id: <20190520102604.3466-5-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190520102604.3466-1-suganath-prabu.subramani@broadcom.com>
References: <20190520102604.3466-1-suganath-prabu.subramani@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Suganath Prabu <suganath-prabu.subramani@broadcom.com>

Code refactoring.

In function _base_get_msix_index add scmd as second
argument. This change is required for creating function
pointer in next patch, where we introduce new function to
get the msix index for high iops queues

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 6e7c5e4..a0d5161 100644
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
@@ -3535,7 +3545,7 @@ _base_put_smid_mpi_ep_scsi_io(struct MPT3SAS_ADAPTER *ioc,
 	_base_clone_mpi_to_sys_mem(mpi_req_iomem, (void *)mfp,
 					ioc->request_sz);
 	descriptor.SCSIIO.RequestFlags = MPI2_REQ_DESCRIPT_FLAGS_SCSI_IO;
-	descriptor.SCSIIO.MSIxIndex =  _base_get_msix_index(ioc);
+	descriptor.SCSIIO.MSIxIndex =  _base_get_msix_index(ioc, NULL);
 	descriptor.SCSIIO.SMID = cpu_to_le16(smid);
 	descriptor.SCSIIO.DevHandle = cpu_to_le16(handle);
 	descriptor.SCSIIO.LMID = 0;
@@ -3557,7 +3567,7 @@ _base_put_smid_scsi_io(struct MPT3SAS_ADAPTER *ioc, u16 smid, u16 handle)
 
 
 	descriptor.SCSIIO.RequestFlags = MPI2_REQ_DESCRIPT_FLAGS_SCSI_IO;
-	descriptor.SCSIIO.MSIxIndex =  _base_get_msix_index(ioc);
+	descriptor.SCSIIO.MSIxIndex =  _base_get_msix_index(ioc, NULL);
 	descriptor.SCSIIO.SMID = cpu_to_le16(smid);
 	descriptor.SCSIIO.DevHandle = cpu_to_le16(handle);
 	descriptor.SCSIIO.LMID = 0;
@@ -3580,7 +3590,7 @@ _base_put_smid_fast_path(struct MPT3SAS_ADAPTER *ioc, u16 smid,
 
 	descriptor.SCSIIO.RequestFlags =
 	    MPI25_REQ_DESCRIPT_FLAGS_FAST_PATH_SCSI_IO;
-	descriptor.SCSIIO.MSIxIndex = _base_get_msix_index(ioc);
+	descriptor.SCSIIO.MSIxIndex = _base_get_msix_index(ioc, NULL);
 	descriptor.SCSIIO.SMID = cpu_to_le16(smid);
 	descriptor.SCSIIO.DevHandle = cpu_to_le16(handle);
 	descriptor.SCSIIO.LMID = 0;
@@ -3644,7 +3654,7 @@ mpt3sas_base_put_smid_nvme_encap(struct MPT3SAS_ADAPTER *ioc, u16 smid)
 
 	descriptor.Default.RequestFlags =
 		MPI26_REQ_DESCRIPT_FLAGS_PCIE_ENCAPSULATED;
-	descriptor.Default.MSIxIndex =  _base_get_msix_index(ioc);
+	descriptor.Default.MSIxIndex =  _base_get_msix_index(ioc, NULL);
 	descriptor.Default.SMID = cpu_to_le16(smid);
 	descriptor.Default.LMID = 0;
 	descriptor.Default.DescriptorTypeDependent = 0;
@@ -3676,7 +3686,7 @@ _base_put_smid_default(struct MPT3SAS_ADAPTER *ioc, u16 smid)
 	}
 	request = (u64 *)&descriptor;
 	descriptor.Default.RequestFlags = MPI2_REQ_DESCRIPT_FLAGS_DEFAULT_TYPE;
-	descriptor.Default.MSIxIndex =  _base_get_msix_index(ioc);
+	descriptor.Default.MSIxIndex =  _base_get_msix_index(ioc, NULL);
 	descriptor.Default.SMID = cpu_to_le16(smid);
 	descriptor.Default.LMID = 0;
 	descriptor.Default.DescriptorTypeDependent = 0;
@@ -3706,7 +3716,7 @@ _base_put_smid_scsi_io_atomic(struct MPT3SAS_ADAPTER *ioc, u16 smid,
 	u32 *request = (u32 *)&descriptor;
 
 	descriptor.RequestFlags = MPI2_REQ_DESCRIPT_FLAGS_SCSI_IO;
-	descriptor.MSIxIndex = _base_get_msix_index(ioc);
+	descriptor.MSIxIndex = _base_get_msix_index(ioc, NULL);
 	descriptor.SMID = cpu_to_le16(smid);
 
 	writel(cpu_to_le32(*request), &ioc->chip->AtomicRequestDescriptorPost);
@@ -3728,7 +3738,7 @@ _base_put_smid_fast_path_atomic(struct MPT3SAS_ADAPTER *ioc, u16 smid,
 	u32 *request = (u32 *)&descriptor;
 
 	descriptor.RequestFlags = MPI25_REQ_DESCRIPT_FLAGS_FAST_PATH_SCSI_IO;
-	descriptor.MSIxIndex = _base_get_msix_index(ioc);
+	descriptor.MSIxIndex = _base_get_msix_index(ioc, NULL);
 	descriptor.SMID = cpu_to_le16(smid);
 
 	writel(cpu_to_le32(*request), &ioc->chip->AtomicRequestDescriptorPost);
@@ -3772,7 +3782,7 @@ _base_put_smid_default_atomic(struct MPT3SAS_ADAPTER *ioc, u16 smid)
 	u32 *request = (u32 *)&descriptor;
 
 	descriptor.RequestFlags = MPI2_REQ_DESCRIPT_FLAGS_DEFAULT_TYPE;
-	descriptor.MSIxIndex = _base_get_msix_index(ioc);
+	descriptor.MSIxIndex = _base_get_msix_index(ioc, NULL);
 	descriptor.SMID = cpu_to_le16(smid);
 
 	writel(cpu_to_le32(*request), &ioc->chip->AtomicRequestDescriptorPost);
-- 
1.8.3.1

