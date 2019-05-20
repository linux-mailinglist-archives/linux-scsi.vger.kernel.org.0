Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCD572314B
	for <lists+linux-scsi@lfdr.de>; Mon, 20 May 2019 12:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731102AbfETK0g (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 May 2019 06:26:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34907 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfETK0g (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 20 May 2019 06:26:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id t87so7014571pfa.2
        for <linux-scsi@vger.kernel.org>; Mon, 20 May 2019 03:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rVwOOFkpme4o7UAKTjExn3Covq7L9x4hJ40AdSK3PE8=;
        b=ZY1OzTlfAFw6I2CbgrMkgW4uyZ/4fWoMZ7FINb5GkeuRgcEV968P6o33pL0D5xBffn
         ls7sEsvJxYwCnJNeRA3h+iIvRnDg55/G8+nbthU3oLzwx3/wT4SJujipvvy8itd+ZuIj
         hujiq2ZRpxTFVeUm3BUbHMnb9xiuAgZG8lwL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rVwOOFkpme4o7UAKTjExn3Covq7L9x4hJ40AdSK3PE8=;
        b=EYXXZUACKSgGZix3kk4ZiIsO6x5mIFF+gGyWdh3NHPlOlETg/S8gmikrreohBQJWeU
         g10qPXTDaT1g5n7oOzvzah//iRYcf9XS7gX8U1KovQ2aHLsEsBEMUR+8U0vlWwLyF8FZ
         xV7k12MKVmLRaVSSht1wrwGiMc/9cBFEDU4HeLiBDmvjR7rm3xh0PeCr8EwHmo3aGyeg
         S32N5vQa2lmuMd5FBMrqSQixkkN9LJfDYisrmIRJXBPYlkB3NwEHLvpZaLiWocoE5Uk6
         kqmR/EFHGs2YA7vjHyUlCKJk3Io5qBfhoPrwtpiabGNX5EjnGgpTt1m7ZnramDhCSq7j
         yETw==
X-Gm-Message-State: APjAAAXEj/+9VfwMBoaRM6mhAa72OtbRkMQ/aqzS2olNFvXNTTAyMbOe
        JwTwTRWDsr4H41Esb5XkU3J4RJ6E61ixdE+lcvNbBzyqmkL/kEe2UB6yGPc7pJMBMotTLRpf+oQ
        Tkjvi38DlUc4pvjt8esfbtvJkUZdv5q+5gaYXmGqJy43jk/fYAB3BHYxRZUr0s6jZs7YKMUwvhw
        tdevFfdxiTxV0qbegLSA==
X-Google-Smtp-Source: APXvYqzhkD93+JGJrGEZ5Y/4m/pD/iJCsYmFrnYfZGTHYeEkxkWrTqQ/dtHbbsOfFKcCS/Id8HzhKQ==
X-Received: by 2002:a62:4d04:: with SMTP id a4mr7550438pfb.177.1558347995190;
        Mon, 20 May 2019 03:26:35 -0700 (PDT)
Received: from dhcp-10-123-20-26.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id j2sm15757309pfb.157.2019.05.20.03.26.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 03:26:34 -0700 (PDT)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     suganath-prabu.subramani@broadcom.com, Sathya.Prakash@broadcom.com,
        sreekanth.reddy@broadcom.com
Subject: [PATCH v2 06/10] mpt3sas:save msix index and use same while posting RD
Date:   Mon, 20 May 2019 06:26:00 -0400
Message-Id: <20190520102604.3466-7-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190520102604.3466-1-suganath-prabu.subramani@broadcom.com>
References: <20190520102604.3466-1-suganath-prabu.subramani@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Suganath Prabu <suganath-prabu.subramani@broadcom.com>

Code refactor:
In the IO submission path _base_get_msix_index is called twice,
one while getting the smid; msix index is saved in msix_io filed
in scsiio tracker and anther while posting the request descriptor(RD).

now code refactor is done to determine msix index only while posting
the request descriptor and save determined msix index in msix_io
field.

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c  | 42 ++++++++++++++++++++++++++++--------
 drivers/scsi/mpt3sas/mpt3sas_base.h  |  1 +
 drivers/scsi/mpt3sas/mpt3sas_scsih.c |  1 +
 3 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index a06b010..a23d257 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -3399,8 +3399,8 @@ mpt3sas_base_get_smid_scsiio(struct MPT3SAS_ADAPTER *ioc, u8 cb_idx,
 
 	smid = tag + 1;
 	request->cb_idx = cb_idx;
-	request->msix_io = _base_get_msix_index(ioc, NULL);
 	request->smid = smid;
+	request->scmd = scmd;
 	INIT_LIST_HEAD(&request->chain_list);
 	return smid;
 }
@@ -3454,6 +3454,7 @@ void mpt3sas_base_clear_st(struct MPT3SAS_ADAPTER *ioc,
 		return;
 	st->cb_idx = 0xFF;
 	st->direct_io = 0;
+	st->scmd = NULL;
 	atomic_set(&ioc->chain_lookup[st->smid - 1].chain_offset, 0);
 	st->smid = 0;
 }
@@ -3554,6 +3555,29 @@ _base_writeq(__u64 b, volatile void __iomem *addr, spinlock_t *writeq_lock)
 #endif
 
 /**
+ * _base_set_and_get_msix_index - get the msix index and assign to msix_io
+ *                                variable of scsi tracker
+ * @ioc: per adapter object
+ * @smid: system request message index
+ *
+ * returns msix index.
+ */
+static u8
+_base_set_and_get_msix_index(struct MPT3SAS_ADAPTER *ioc, u16 smid)
+{
+	struct scsiio_tracker *st;
+
+	st = (smid < ioc->hi_priority_smid) ?
+		(_get_st_from_smid(ioc, smid)) : (NULL);
+
+	if (st == NULL)
+		return  _base_get_msix_index(ioc, NULL);
+
+	st->msix_io = ioc->get_msix_index_for_smlio(ioc, st->scmd);
+	return st->msix_io;
+}
+
+/**
  * _base_put_smid_mpi_ep_scsi_io - send SCSI_IO request to firmware
  * @ioc: per adapter object
  * @smid: system request message index
@@ -3574,7 +3598,7 @@ _base_put_smid_mpi_ep_scsi_io(struct MPT3SAS_ADAPTER *ioc,
 	_base_clone_mpi_to_sys_mem(mpi_req_iomem, (void *)mfp,
 					ioc->request_sz);
 	descriptor.SCSIIO.RequestFlags = MPI2_REQ_DESCRIPT_FLAGS_SCSI_IO;
-	descriptor.SCSIIO.MSIxIndex =  _base_get_msix_index(ioc, NULL);
+	descriptor.SCSIIO.MSIxIndex = _base_set_and_get_msix_index(ioc, smid);
 	descriptor.SCSIIO.SMID = cpu_to_le16(smid);
 	descriptor.SCSIIO.DevHandle = cpu_to_le16(handle);
 	descriptor.SCSIIO.LMID = 0;
@@ -3596,7 +3620,7 @@ _base_put_smid_scsi_io(struct MPT3SAS_ADAPTER *ioc, u16 smid, u16 handle)
 
 
 	descriptor.SCSIIO.RequestFlags = MPI2_REQ_DESCRIPT_FLAGS_SCSI_IO;
-	descriptor.SCSIIO.MSIxIndex =  _base_get_msix_index(ioc, NULL);
+	descriptor.SCSIIO.MSIxIndex = _base_set_and_get_msix_index(ioc, smid);
 	descriptor.SCSIIO.SMID = cpu_to_le16(smid);
 	descriptor.SCSIIO.DevHandle = cpu_to_le16(handle);
 	descriptor.SCSIIO.LMID = 0;
@@ -3619,7 +3643,7 @@ _base_put_smid_fast_path(struct MPT3SAS_ADAPTER *ioc, u16 smid,
 
 	descriptor.SCSIIO.RequestFlags =
 	    MPI25_REQ_DESCRIPT_FLAGS_FAST_PATH_SCSI_IO;
-	descriptor.SCSIIO.MSIxIndex = _base_get_msix_index(ioc, NULL);
+	descriptor.SCSIIO.MSIxIndex = _base_set_and_get_msix_index(ioc, smid);
 	descriptor.SCSIIO.SMID = cpu_to_le16(smid);
 	descriptor.SCSIIO.DevHandle = cpu_to_le16(handle);
 	descriptor.SCSIIO.LMID = 0;
@@ -3683,7 +3707,7 @@ mpt3sas_base_put_smid_nvme_encap(struct MPT3SAS_ADAPTER *ioc, u16 smid)
 
 	descriptor.Default.RequestFlags =
 		MPI26_REQ_DESCRIPT_FLAGS_PCIE_ENCAPSULATED;
-	descriptor.Default.MSIxIndex =  _base_get_msix_index(ioc, NULL);
+	descriptor.Default.MSIxIndex =  _base_set_and_get_msix_index(ioc, smid);
 	descriptor.Default.SMID = cpu_to_le16(smid);
 	descriptor.Default.LMID = 0;
 	descriptor.Default.DescriptorTypeDependent = 0;
@@ -3715,7 +3739,7 @@ _base_put_smid_default(struct MPT3SAS_ADAPTER *ioc, u16 smid)
 	}
 	request = (u64 *)&descriptor;
 	descriptor.Default.RequestFlags = MPI2_REQ_DESCRIPT_FLAGS_DEFAULT_TYPE;
-	descriptor.Default.MSIxIndex =  _base_get_msix_index(ioc, NULL);
+	descriptor.Default.MSIxIndex = _base_set_and_get_msix_index(ioc, smid);
 	descriptor.Default.SMID = cpu_to_le16(smid);
 	descriptor.Default.LMID = 0;
 	descriptor.Default.DescriptorTypeDependent = 0;
@@ -3745,7 +3769,7 @@ _base_put_smid_scsi_io_atomic(struct MPT3SAS_ADAPTER *ioc, u16 smid,
 	u32 *request = (u32 *)&descriptor;
 
 	descriptor.RequestFlags = MPI2_REQ_DESCRIPT_FLAGS_SCSI_IO;
-	descriptor.MSIxIndex = _base_get_msix_index(ioc, NULL);
+	descriptor.MSIxIndex = _base_set_and_get_msix_index(ioc, smid);
 	descriptor.SMID = cpu_to_le16(smid);
 
 	writel(cpu_to_le32(*request), &ioc->chip->AtomicRequestDescriptorPost);
@@ -3767,7 +3791,7 @@ _base_put_smid_fast_path_atomic(struct MPT3SAS_ADAPTER *ioc, u16 smid,
 	u32 *request = (u32 *)&descriptor;
 
 	descriptor.RequestFlags = MPI25_REQ_DESCRIPT_FLAGS_FAST_PATH_SCSI_IO;
-	descriptor.MSIxIndex = _base_get_msix_index(ioc, NULL);
+	descriptor.MSIxIndex = _base_set_and_get_msix_index(ioc, smid);
 	descriptor.SMID = cpu_to_le16(smid);
 
 	writel(cpu_to_le32(*request), &ioc->chip->AtomicRequestDescriptorPost);
@@ -3811,7 +3835,7 @@ _base_put_smid_default_atomic(struct MPT3SAS_ADAPTER *ioc, u16 smid)
 	u32 *request = (u32 *)&descriptor;
 
 	descriptor.RequestFlags = MPI2_REQ_DESCRIPT_FLAGS_DEFAULT_TYPE;
-	descriptor.MSIxIndex = _base_get_msix_index(ioc, NULL);
+	descriptor.MSIxIndex = _base_set_and_get_msix_index(ioc, smid);
 	descriptor.SMID = cpu_to_le16(smid);
 
 	writel(cpu_to_le32(*request), &ioc->chip->AtomicRequestDescriptorPost);
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index 85db1f2..f3818e3 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -830,6 +830,7 @@ struct chain_lookup {
  */
 struct scsiio_tracker {
 	u16	smid;
+	struct scsi_cmnd *scmd;
 	u8	cb_idx;
 	u8	direct_io;
 	struct pcie_sg_list pcie_sg_list;
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 1008c5e..3e93c4a 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -5210,6 +5210,7 @@ _scsih_io_done(struct MPT3SAS_ADAPTER *ioc, u16 smid, u8 msix_index, u32 reply)
 	     ((ioc_status & MPI2_IOCSTATUS_MASK)
 	      != MPI2_IOCSTATUS_SCSI_TASK_TERMINATED)) {
 		st->direct_io = 0;
+		st->scmd = scmd;
 		memcpy(mpi_request->CDB.CDB32, scmd->cmnd, scmd->cmd_len);
 		mpi_request->DevHandle =
 		    cpu_to_le16(sas_device_priv_data->sas_target->handle);
-- 
1.8.3.1

