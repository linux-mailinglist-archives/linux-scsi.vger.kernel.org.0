Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE73A21A2A
	for <lists+linux-scsi@lfdr.de>; Fri, 17 May 2019 16:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbfEQO7a (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 17 May 2019 10:59:30 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34112 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728968AbfEQO7a (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 17 May 2019 10:59:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id n19so3828769pfa.1
        for <linux-scsi@vger.kernel.org>; Fri, 17 May 2019 07:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kHyeiicC53vyOfXPobuXUMO+udNTPYC0tL/cVvq+QGk=;
        b=fDK+IOPWSKRGlA+iE+2pINPufOvJAgI1H9/HOGWxjtVfOybKM1GW5uDda0WVlPNSAj
         7wMDvCS0l3jPwa+2i5VRQhhQGTEV086Ff3ZUk1fLN3u5eT9muyap/b7X4VgAAWX2vx3q
         DAVfVm8NuCzcFTl6uj6H+r5ovZa9I/o6LlrtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kHyeiicC53vyOfXPobuXUMO+udNTPYC0tL/cVvq+QGk=;
        b=uoCkdVYx0X3Of6tlEW9aGgD3A9B5QUPwEBIr+y9RlMIr0m+/ZzUV6V369Vpw8Uly3R
         F2dWIjwQpBv8ypkd7huRTFuTb5iiKYHGNdKwoQ+5xDUZAJKfNMKnukT54HIu20luxqWr
         8GKCfXUOrAKUSqUYt3+l42wbJEQS2O0ukKlNKkyk07WBp3bQa0WzYvMFchJp/yH3UFwQ
         2AKy+6CAPlq4r3DfT2dlMjz0pE7mvTCACQHSYxiHxG9d/AU9Z8UDmvolDJU1JBCz0BnH
         xAbELO4//BwOZQya6ygjZfMnTNoci78h0lV+JIi8NJEOoTsEN46QUiHZpv2Ej4fXmHQZ
         sRpw==
X-Gm-Message-State: APjAAAWXZL4rcFX/yhtmHLc37dQQZLOKutkmmTkms4VrtL4HnJDjVj6L
        K4/jory65iIc5UR/IgC1lm7KpB+RiMxZkSR8tuM2o5QkB5NfmEXrSpmUGjN9HlUyu8TH0wtk5NW
        D0Zuyt3EXPz+v60EKuYEfA6qmIjgH97rgCeZ45D9lWdZCPp6ek8qBHbhk6/zN+qNvTfd7h83w1B
        z9LNd6ixwmTGykFu3Y4g==
X-Google-Smtp-Source: APXvYqyXvwfnKPjLmavNj8IyGvsrjKfWiC0b/bJYpAY3Th3xRriyX3wTpz1953Glz7IAOkq4aWZGzg==
X-Received: by 2002:a65:42ca:: with SMTP id l10mr4675715pgp.181.1558105168819;
        Fri, 17 May 2019 07:59:28 -0700 (PDT)
Received: from dhcp-10-123-20-26.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id c189sm20739195pfg.46.2019.05.17.07.59.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 07:59:28 -0700 (PDT)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     suganath-prabu.subramani@gmail.com, Sathya.Prakash@broadcom.com,
        sreekanth.reddy@broadcom.com,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH 04/10] mpt3sas: change _base_get_msix_index prototype
Date:   Fri, 17 May 2019 10:58:59 -0400
Message-Id: <20190517145905.4765-5-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190517145905.4765-1-suganath-prabu.subramani@broadcom.com>
References: <20190517145905.4765-1-suganath-prabu.subramani@broadcom.com>
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
 drivers/scsi/mpt3sas/mpt3sas_base.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 9f9e91c..143d193 100644
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

