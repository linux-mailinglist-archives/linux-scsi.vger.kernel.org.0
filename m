Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1C422314D
	for <lists+linux-scsi@lfdr.de>; Mon, 20 May 2019 12:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731220AbfETK0k (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 May 2019 06:26:40 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41293 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbfETK0k (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 20 May 2019 06:26:40 -0400
Received: by mail-pf1-f193.google.com with SMTP id q17so6998081pfq.8
        for <linux-scsi@vger.kernel.org>; Mon, 20 May 2019 03:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cMFS9GBtROsaH5CDZc8e/QHuzEyulv6mByXqaaHqGNc=;
        b=U2OY1i9thjrg2gqdGM7h9c7yRzSXmPj/Sggl9gbzgWvVfiVN5ygE8op6hb/m/yDxOc
         kM52BVafaPBRRLmuls01k/0TqW2kzekN1uQfxzUbBupldD2MKJjwSq5izveYJlX8jJQN
         gHTs9PRzvlMgeNU4p4i98eWjpCqd/Isf94EdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cMFS9GBtROsaH5CDZc8e/QHuzEyulv6mByXqaaHqGNc=;
        b=lUYpKpupxnfsaF8XAeSfTCObII+/Oe1ECl+qL9KPb/tL0r14A09ZcDKLRE4lrVkj8l
         oJ3U5zkAG3BPgfUztNO2pS8X4eVTqTW8UXhDjuRZLx6ATWHWwI3zIyYpdUGpXkyfVAHr
         PvNV4lHKIqYNtX3oERNUnry+VSZ7uXBxojrxfPmNdv2ijEyYuiRcuzr5nhKM6vQkm4F4
         Hgo4jwEN14477A2wmP6dbonKK0GYAOYaQ50Jug7bDEN6KbTabC3IftRXVoQFc14yRbN9
         ck+shk5VZNG8rlmp7SKQKVZfEy2IyJoz1W0q1+QjFaClwMvPedhZYhx5Gy1VcdYecx/S
         9pzw==
X-Gm-Message-State: APjAAAVnbmXM3xPs/i3+YlKN61uU4bxSP9xGrprBvrgK7HyixE8Zv4fw
        w8Q27hDRVl7P/KOuvlJLNbGqUhop861jOmbTZdWp8T1hfkIM2tCej3w3SOu2gt40zwIlRji9Wes
        1VHr/sOZ6X1Mm2Ru5PQt9DuUq6dUCYWZzhtLhNCy29sCxLsN8lTvOOwAFDdZeHdy6DVbgf2soyi
        QsQ7A1WTJE8npbs3Tx+w==
X-Google-Smtp-Source: APXvYqzHlexFvKyfQYvYppll0xMWyvqrE3D563Bc6Bcj7SMaz5UL4Qm8nX7gjwNO1e308UhPXDciXg==
X-Received: by 2002:a63:d343:: with SMTP id u3mr74551287pgi.285.1558347999125;
        Mon, 20 May 2019 03:26:39 -0700 (PDT)
Received: from dhcp-10-123-20-26.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id j2sm15757309pfb.157.2019.05.20.03.26.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 03:26:38 -0700 (PDT)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     suganath-prabu.subramani@broadcom.com, Sathya.Prakash@broadcom.com,
        sreekanth.reddy@broadcom.com
Subject: [PATCH v2 08/10] mpt3sas: Enable interrupt coalescing on high iops
Date:   Mon, 20 May 2019 06:26:02 -0400
Message-Id: <20190520102604.3466-9-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190520102604.3466-1-suganath-prabu.subramani@broadcom.com>
References: <20190520102604.3466-1-suganath-prabu.subramani@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Suganath Prabu <suganath-prabu.subramani@broadcom.com>

Enable interrupt coalescing only on high iops queues when
high iops queues are enabled.

In ioc config page 1, offset 0x14 (ProductSpecific field)
is used to determine interrupt coalescing enabled/disabled on per
reply descriptor post queue group(8) basis.
If 31st bit is zero then interrupt coalescing is enabled for
all reply descriptor post queues. If 31st bit is set to one
then user can enable/disable interrupt coalescing on per reply
descriptor post queue group(8) basis. So to enable interrupt
coalescing only on first reply descriptor post queue group
(i.e. on high iops queues) set bit 0 and 31.

This configuration should reset during driver unload or shutdown
to the default settings. For this driver takes copy of default ioc page 1
and copy backs the default or unmodified ioc page1 during unload and
shutdown. so that on next driver load (e.g. if older version driver is
loaded by user), current modified changes on ioc page1 won't take effect.

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h  |  2 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c   | 16 ++++++++
 drivers/scsi/mpt3sas/mpt3sas_base.h   |  5 +++
 drivers/scsi/mpt3sas/mpt3sas_config.c | 71 +++++++++++++++++++++++++++++++++++
 drivers/scsi/mpt3sas/mpt3sas_scsih.c  | 17 ++++++++-
 5 files changed, 109 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h b/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
index a2f4a55..167d79d 100644
--- a/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
+++ b/drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h
@@ -1398,7 +1398,7 @@ typedef struct _MPI2_CONFIG_PAGE_IOC_1 {
 	U8                      PCIBusNum;                  /*0x0E */
 	U8                      PCIDomainSegment;           /*0x0F */
 	U32                     Reserved1;                  /*0x10 */
-	U32                     Reserved2;                  /*0x14 */
+	U32                     ProductSpecific;            /* 0x14 */
 } MPI2_CONFIG_PAGE_IOC_1,
 	*PTR_MPI2_CONFIG_PAGE_IOC_1,
 	Mpi2IOCPage1_t, *pMpi2IOCPage1_t;
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 6620c49..abc783f 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -4440,6 +4440,7 @@ _base_static_config_pages(struct MPT3SAS_ADAPTER *ioc)
 {
 	Mpi2ConfigReply_t mpi_reply;
 	u32 iounit_pg1_flags;
+	Mpi2IOCPage1_t ioc_pg1;
 
 	ioc->nvme_abort_timeout = 30;
 	mpt3sas_config_get_manufacturing_pg0(ioc, &mpi_reply, &ioc->manu_pg0);
@@ -4472,6 +4473,21 @@ _base_static_config_pages(struct MPT3SAS_ADAPTER *ioc)
 		else
 			ioc->nvme_abort_timeout = ioc->manu_pg11.NVMeAbortTO;
 	}
+	if (ioc->high_iops_queues) {
+		mpt3sas_config_get_ioc_pg1(ioc, &mpi_reply, &ioc_pg1);
+		pr_info(
+		"%s Enable interrupt coalescing only for first reply queue group(8)\n",
+		ioc->name);
+		/* If 31st bit is zero then interrupt coalescing is enabled
+		 * for all reply descriptor post queues. If 31st bit is set
+		 * to one then user can enable/disable interrupt coalescing
+		 * on per reply descriptor post queue group(8) basis. So to
+		 * enable interrupt coalescing only on first reply descriptor
+		 * post queue group 31st bit and zero th bit is enabled.
+		 */
+		ioc_pg1.ProductSpecific = cpu_to_le32(0x80000001);
+		mpt3sas_config_set_ioc_pg1(ioc, &mpi_reply, &ioc_pg1);
+	}
 
 	mpt3sas_config_get_bios_pg2(ioc, &mpi_reply, &ioc->bios_pg2);
 	mpt3sas_config_get_bios_pg3(ioc, &mpi_reply, &ioc->bios_pg3);
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index f3818e3..b5a2071 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -1286,6 +1286,7 @@ struct MPT3SAS_ADAPTER {
 	Mpi2IOUnitPage0_t iounit_pg0;
 	Mpi2IOUnitPage1_t iounit_pg1;
 	Mpi2IOUnitPage8_t iounit_pg8;
+	Mpi2IOCPage1_t	ioc_pg1_copy;
 
 	struct _boot_device req_boot_device;
 	struct _boot_device req_alt_boot_device;
@@ -1634,6 +1635,10 @@ int mpt3sas_config_get_sas_iounit_pg1(struct MPT3SAS_ADAPTER *ioc,
 int mpt3sas_config_set_sas_iounit_pg1(struct MPT3SAS_ADAPTER *ioc,
 	Mpi2ConfigReply_t *mpi_reply, Mpi2SasIOUnitPage1_t *config_page,
 	u16 sz);
+int mpt3sas_config_get_ioc_pg1(struct MPT3SAS_ADAPTER *ioc, Mpi2ConfigReply_t
+	*mpi_reply, Mpi2IOCPage1_t *config_page);
+int mpt3sas_config_set_ioc_pg1(struct MPT3SAS_ADAPTER *ioc, Mpi2ConfigReply_t
+	*mpi_reply, Mpi2IOCPage1_t *config_page);
 int mpt3sas_config_get_ioc_pg8(struct MPT3SAS_ADAPTER *ioc, Mpi2ConfigReply_t
 	*mpi_reply, Mpi2IOCPage8_t *config_page);
 int mpt3sas_config_get_expander_pg0(struct MPT3SAS_ADAPTER *ioc,
diff --git a/drivers/scsi/mpt3sas/mpt3sas_config.c b/drivers/scsi/mpt3sas/mpt3sas_config.c
index b18cbbc..14a1a27 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_config.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_config.c
@@ -949,6 +949,77 @@ mpt3sas_config_get_ioc_pg8(struct MPT3SAS_ADAPTER *ioc,
  out:
 	return r;
 }
+/**
+ * mpt3sas_config_get_ioc_pg1 - obtain ioc page 1
+ * @ioc: per adapter object
+ * @mpi_reply: reply mf payload returned from firmware
+ * @config_page: contents of the config page
+ * Context: sleep.
+ *
+ * Return: 0 for success, non-zero for failure.
+ */
+int
+mpt3sas_config_get_ioc_pg1(struct MPT3SAS_ADAPTER *ioc,
+	Mpi2ConfigReply_t *mpi_reply, Mpi2IOCPage1_t *config_page)
+{
+	Mpi2ConfigRequest_t mpi_request;
+	int r;
+
+	memset(&mpi_request, 0, sizeof(Mpi2ConfigRequest_t));
+	mpi_request.Function = MPI2_FUNCTION_CONFIG;
+	mpi_request.Action = MPI2_CONFIG_ACTION_PAGE_HEADER;
+	mpi_request.Header.PageType = MPI2_CONFIG_PAGETYPE_IOC;
+	mpi_request.Header.PageNumber = 1;
+	mpi_request.Header.PageVersion = MPI2_IOCPAGE8_PAGEVERSION;
+	ioc->build_zero_len_sge_mpi(ioc, &mpi_request.PageBufferSGE);
+	r = _config_request(ioc, &mpi_request, mpi_reply,
+	    MPT3_CONFIG_PAGE_DEFAULT_TIMEOUT, NULL, 0);
+	if (r)
+		goto out;
+
+	mpi_request.Action = MPI2_CONFIG_ACTION_PAGE_READ_CURRENT;
+	r = _config_request(ioc, &mpi_request, mpi_reply,
+	    MPT3_CONFIG_PAGE_DEFAULT_TIMEOUT, config_page,
+	    sizeof(*config_page));
+ out:
+	return r;
+}
+
+/**
+ * mpt3sas_config_set_ioc_pg1 - modify ioc page 1
+ * @ioc: per adapter object
+ * @mpi_reply: reply mf payload returned from firmware
+ * @config_page: contents of the config page
+ * Context: sleep.
+ *
+ * Return: 0 for success, non-zero for failure.
+ */
+int
+mpt3sas_config_set_ioc_pg1(struct MPT3SAS_ADAPTER *ioc,
+	Mpi2ConfigReply_t *mpi_reply, Mpi2IOCPage1_t *config_page)
+{
+	Mpi2ConfigRequest_t mpi_request;
+	int r;
+
+	memset(&mpi_request, 0, sizeof(Mpi2ConfigRequest_t));
+	mpi_request.Function = MPI2_FUNCTION_CONFIG;
+	mpi_request.Action = MPI2_CONFIG_ACTION_PAGE_HEADER;
+	mpi_request.Header.PageType = MPI2_CONFIG_PAGETYPE_IOC;
+	mpi_request.Header.PageNumber = 1;
+	mpi_request.Header.PageVersion = MPI2_IOCPAGE8_PAGEVERSION;
+	ioc->build_zero_len_sge_mpi(ioc, &mpi_request.PageBufferSGE);
+	r = _config_request(ioc, &mpi_request, mpi_reply,
+	    MPT3_CONFIG_PAGE_DEFAULT_TIMEOUT, NULL, 0);
+	if (r)
+		goto out;
+
+	mpi_request.Action = MPI2_CONFIG_ACTION_PAGE_WRITE_CURRENT;
+	r = _config_request(ioc, &mpi_request, mpi_reply,
+	    MPT3_CONFIG_PAGE_DEFAULT_TIMEOUT, config_page,
+	    sizeof(*config_page));
+ out:
+	return r;
+}
 
 /**
  * mpt3sas_config_get_sas_device_pg0 - obtain sas device page 0
diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 3e93c4a..d957f78 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -9671,6 +9671,7 @@ static void scsih_remove(struct pci_dev *pdev)
 	struct _pcie_device *pcie_device, *pcienext;
 	struct workqueue_struct	*wq;
 	unsigned long flags;
+	Mpi2ConfigReply_t mpi_reply;
 
 	ioc->remove_host = 1;
 
@@ -9685,7 +9686,13 @@ static void scsih_remove(struct pci_dev *pdev)
 	spin_unlock_irqrestore(&ioc->fw_event_lock, flags);
 	if (wq)
 		destroy_workqueue(wq);
-
+	/*
+	 * Copy back the unmodified ioc page1. so that on next driver load,
+	 * current modified changes on ioc page1 won't take effect.
+	 */
+	if (ioc->is_aero_ioc)
+		mpt3sas_config_set_ioc_pg1(ioc, &mpi_reply,
+				&ioc->ioc_pg1_copy);
 	/* release all the volumes */
 	_scsih_ir_shutdown(ioc);
 	sas_remove_host(shost);
@@ -9748,6 +9755,7 @@ scsih_shutdown(struct pci_dev *pdev)
 	struct MPT3SAS_ADAPTER *ioc = shost_priv(shost);
 	struct workqueue_struct	*wq;
 	unsigned long flags;
+	Mpi2ConfigReply_t mpi_reply;
 
 	ioc->remove_host = 1;
 
@@ -9762,6 +9770,13 @@ scsih_shutdown(struct pci_dev *pdev)
 	spin_unlock_irqrestore(&ioc->fw_event_lock, flags);
 	if (wq)
 		destroy_workqueue(wq);
+	/*
+	 * Copy back the unmodified ioc page1. so that on next driver load,
+	 * current modified changes on ioc page1 won't take effect.
+	 */
+	if (ioc->is_aero_ioc)
+		mpt3sas_config_set_ioc_pg1(ioc, &mpi_reply,
+				&ioc->ioc_pg1_copy);
 
 	_scsih_ir_shutdown(ioc);
 	mpt3sas_base_detach(ioc);
-- 
1.8.3.1

