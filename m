Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2513230DF2
	for <lists+linux-scsi@lfdr.de>; Fri, 31 May 2019 14:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfEaMP3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 31 May 2019 08:15:29 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41523 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfEaMP3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 31 May 2019 08:15:29 -0400
Received: by mail-ed1-f67.google.com with SMTP id x25so2042801eds.8
        for <linux-scsi@vger.kernel.org>; Fri, 31 May 2019 05:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B1LLZhiglBDPhGQDsb54hFx13DCMYE0QxeQLa1AlcRE=;
        b=IZpd43ti+wMXvRzRkNqzrAjov7uUCwQMEuzai5OkHinWKmGrkI5S8Dx/oHR0Kl2lEV
         mg3WX491bupxLE5zCcICKXAtAMpCpvUv9pm92Vg/IhVW3I8yEeFfJuKplE8786A8Wakd
         rVKGvXb2XNgoAzn+iaqIsvENtCkuHQYaHJSgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B1LLZhiglBDPhGQDsb54hFx13DCMYE0QxeQLa1AlcRE=;
        b=C5zLeIaEjvjI/i3/uwrnHvY6yamssQwra/uB/IPL0GrFXj72DlWMtdERAc+j8DqQ7q
         EEK1DwX5XU+7hS0SpqVz6TsjjIZSAtHJ6HWP2QkhsZvQ6ZD6hBoMjEVl8UEv4iZjMY0Z
         BF9pUBq4xkf3gHQ8ali67pzSn0LBuIAbztvVgqzm3Hkv2nWeZr5y5bpmVJ8tG8fdDatD
         jEl139RMBub5SLPN8l18OnypzKKHYiIInRIGHfDkPsD/aj5qsJ5uoxWQV6uWGQ74jzjz
         erY/vUxlF0lAQJGKYiOe49rPtBWg4ej1vV7tw5Ly5h+xs5BwIgymg3bQndpXPLl0RIRe
         zl3A==
X-Gm-Message-State: APjAAAUsoF6wyeFSUzajDJxuTEOQ2978vaBJTiGPBQRUGwqn/dl19FYK
        R0jcXbsmcTwECfReyId+UkFWxb71ngk6DTu1YTZRQae0N37EG68YR1vuEDXLVDcwFgFQML0kglY
        OMj2xZOe61PIPEmQjNc4T8G4lB7ILqo9oTTLOVTyiNTa0sSbJ3V78QWUYB6lPlJbmRukzgj8cSL
        1DgNrF+9Wpw51T1R1vHg==
X-Google-Smtp-Source: APXvYqxOUziEi3Rv2fTnJ439bFkL/tRwUmcQHTkBVxP1SXGF0gH0N3dE0LrR20cJF1uGZXcuE5PYsQ==
X-Received: by 2002:a17:906:4414:: with SMTP id x20mr8828444ejo.199.1559304927021;
        Fri, 31 May 2019 05:15:27 -0700 (PDT)
Received: from dhcp-10-123-20-26.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id jz15sm822186ejb.75.2019.05.31.05.15.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 05:15:26 -0700 (PDT)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com
Cc:     kashyap.desai@broadcom.com, sreekanth.reddy@broadcom.com,
        Sathya.Prakash@broadcom.com,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Subject: [V3 06/10] mpt3sas:save msix index and use same while posting RD
Date:   Fri, 31 May 2019 08:14:39 -0400
Message-Id: <20190531121443.30694-7-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190531121443.30694-1-suganath-prabu.subramani@broadcom.com>
References: <20190531121443.30694-1-suganath-prabu.subramani@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Code refactor:
In the IO submission path _base_get_msix_index is called twice,
one while getting the smid; msix index is saved in msix_io filed
in scsiio tracker and anther while posting the request descriptor(RD).

now code refactor is done to determine msix index only while posting
the request descriptor and save determined msix index in msix_io
field.

Signed-off-by: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c  | 42 ++++++++++++++++++++++------
 drivers/scsi/mpt3sas/mpt3sas_base.h  |  1 +
 drivers/scsi/mpt3sas/mpt3sas_scsih.c |  1 +
 3 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 74cb060..8779d2b 100644
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
@@ -3552,6 +3553,29 @@ _base_writeq(__u64 b, volatile void __iomem *addr, spinlock_t *writeq_lock)
 }
 #endif
 
+/**
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
+	struct scsiio_tracker *st = NULL;
+
+	if (smid < ioc->hi_priority_smid)
+		st = _get_st_from_smid(ioc, smid);
+
+	if (st == NULL)
+		return  _base_get_msix_index(ioc, NULL);
+
+	st->msix_io = ioc->get_msix_index_for_smlio(ioc, st->scmd);
+	return st->msix_io;
+}
+
 /**
  * _base_put_smid_mpi_ep_scsi_io - send SCSI_IO request to firmware
  * @ioc: per adapter object
@@ -3573,7 +3597,7 @@ _base_put_smid_mpi_ep_scsi_io(struct MPT3SAS_ADAPTER *ioc,
 	_base_clone_mpi_to_sys_mem(mpi_req_iomem, (void *)mfp,
 					ioc->request_sz);
 	descriptor.SCSIIO.RequestFlags = MPI2_REQ_DESCRIPT_FLAGS_SCSI_IO;
-	descriptor.SCSIIO.MSIxIndex =  _base_get_msix_index(ioc, NULL);
+	descriptor.SCSIIO.MSIxIndex = _base_set_and_get_msix_index(ioc, smid);
 	descriptor.SCSIIO.SMID = cpu_to_le16(smid);
 	descriptor.SCSIIO.DevHandle = cpu_to_le16(handle);
 	descriptor.SCSIIO.LMID = 0;
@@ -3595,7 +3619,7 @@ _base_put_smid_scsi_io(struct MPT3SAS_ADAPTER *ioc, u16 smid, u16 handle)
 
 
 	descriptor.SCSIIO.RequestFlags = MPI2_REQ_DESCRIPT_FLAGS_SCSI_IO;
-	descriptor.SCSIIO.MSIxIndex =  _base_get_msix_index(ioc, NULL);
+	descriptor.SCSIIO.MSIxIndex = _base_set_and_get_msix_index(ioc, smid);
 	descriptor.SCSIIO.SMID = cpu_to_le16(smid);
 	descriptor.SCSIIO.DevHandle = cpu_to_le16(handle);
 	descriptor.SCSIIO.LMID = 0;
@@ -3618,7 +3642,7 @@ _base_put_smid_fast_path(struct MPT3SAS_ADAPTER *ioc, u16 smid,
 
 	descriptor.SCSIIO.RequestFlags =
 	    MPI25_REQ_DESCRIPT_FLAGS_FAST_PATH_SCSI_IO;
-	descriptor.SCSIIO.MSIxIndex = _base_get_msix_index(ioc, NULL);
+	descriptor.SCSIIO.MSIxIndex = _base_set_and_get_msix_index(ioc, smid);
 	descriptor.SCSIIO.SMID = cpu_to_le16(smid);
 	descriptor.SCSIIO.DevHandle = cpu_to_le16(handle);
 	descriptor.SCSIIO.LMID = 0;
@@ -3682,7 +3706,7 @@ mpt3sas_base_put_smid_nvme_encap(struct MPT3SAS_ADAPTER *ioc, u16 smid)
 
 	descriptor.Default.RequestFlags =
 		MPI26_REQ_DESCRIPT_FLAGS_PCIE_ENCAPSULATED;
-	descriptor.Default.MSIxIndex =  _base_get_msix_index(ioc, NULL);
+	descriptor.Default.MSIxIndex =  _base_set_and_get_msix_index(ioc, smid);
 	descriptor.Default.SMID = cpu_to_le16(smid);
 	descriptor.Default.LMID = 0;
 	descriptor.Default.DescriptorTypeDependent = 0;
@@ -3714,7 +3738,7 @@ _base_put_smid_default(struct MPT3SAS_ADAPTER *ioc, u16 smid)
 	}
 	request = (u64 *)&descriptor;
 	descriptor.Default.RequestFlags = MPI2_REQ_DESCRIPT_FLAGS_DEFAULT_TYPE;
-	descriptor.Default.MSIxIndex =  _base_get_msix_index(ioc, NULL);
+	descriptor.Default.MSIxIndex = _base_set_and_get_msix_index(ioc, smid);
 	descriptor.Default.SMID = cpu_to_le16(smid);
 	descriptor.Default.LMID = 0;
 	descriptor.Default.DescriptorTypeDependent = 0;
@@ -3744,7 +3768,7 @@ _base_put_smid_scsi_io_atomic(struct MPT3SAS_ADAPTER *ioc, u16 smid,
 	u32 *request = (u32 *)&descriptor;
 
 	descriptor.RequestFlags = MPI2_REQ_DESCRIPT_FLAGS_SCSI_IO;
-	descriptor.MSIxIndex = _base_get_msix_index(ioc, NULL);
+	descriptor.MSIxIndex = _base_set_and_get_msix_index(ioc, smid);
 	descriptor.SMID = cpu_to_le16(smid);
 
 	writel(cpu_to_le32(*request), &ioc->chip->AtomicRequestDescriptorPost);
@@ -3766,7 +3790,7 @@ _base_put_smid_fast_path_atomic(struct MPT3SAS_ADAPTER *ioc, u16 smid,
 	u32 *request = (u32 *)&descriptor;
 
 	descriptor.RequestFlags = MPI25_REQ_DESCRIPT_FLAGS_FAST_PATH_SCSI_IO;
-	descriptor.MSIxIndex = _base_get_msix_index(ioc, NULL);
+	descriptor.MSIxIndex = _base_set_and_get_msix_index(ioc, smid);
 	descriptor.SMID = cpu_to_le16(smid);
 
 	writel(cpu_to_le32(*request), &ioc->chip->AtomicRequestDescriptorPost);
@@ -3810,7 +3834,7 @@ _base_put_smid_default_atomic(struct MPT3SAS_ADAPTER *ioc, u16 smid)
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
2.18.1

