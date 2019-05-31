Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F80230DF4
	for <lists+linux-scsi@lfdr.de>; Fri, 31 May 2019 14:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbfEaMPi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 31 May 2019 08:15:38 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43295 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbfEaMPh (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 31 May 2019 08:15:37 -0400
Received: by mail-ed1-f66.google.com with SMTP id w33so14211163edb.10
        for <linux-scsi@vger.kernel.org>; Fri, 31 May 2019 05:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HuHPaGeiEcy7bxHbajQf6/a//ubyh3TG4J4c+mDa+HM=;
        b=ZWoTLqStxdFpn00VbFYaTh6XPWemklDXHQRnzBAZAwAWWld/nx10cheGZ0LSWmdbv+
         e4V1LqPHWT4qkSlHd93xYQengWhXqIM7Dd41Ot5ocZFcwSwlcJWMx9t+GgLnXUBHPbb5
         CD9P85MI/O/5Sk5AOjORLDU3pndaI7AEDYbDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HuHPaGeiEcy7bxHbajQf6/a//ubyh3TG4J4c+mDa+HM=;
        b=fgd24hCWKSOstKIM6EpYPywv3TuroZUqg5W84HIqewMTFousTqE1w9aeSR3/Yo2Sma
         GuN+nUVm8sZipaNrdOWriSwBM6X+ROp9J9CzVvyWuwpfQ73A7RU0G/M+TzUjpXGktoun
         AbNuUUBosnMw8w4uqKSLl9pDe5nx/ln1NoalrnQkLi7+aa9KvSm8Jy1G/0nxUfAPufv3
         ANGD8MzwMRA8hv8NyLlfw1YdYQHgwj1TjeF8TyeDmThFJ6VBlGivqRu8HduNZP8+UDfx
         6auepmfFfqzqus3wJE2MpQq3nSl2mxmgG/VZNCsqLxTpEiDXz5Lk2VfI909AHKp/2FJ3
         lfWQ==
X-Gm-Message-State: APjAAAXTz2Bt2WsmSMZqso/rjUKXt0kCwWurH+f+bs5rokOZLlVJVRB3
        D/1RpDveKA/16daw7SEmD5geSUxVU6qRw5G+TN2dmuk9h8BILi9SGHjYTMa9sLPyc4oUudF0dYC
        fY+aBrHJAcR6zp3x5DOba15IHjmbaWj4lja4iHrivPcXxqRBFaAlKSMi36lG1fT6I0QGl1eIk1B
        NSAzx/ejwgEK4/SdOxFA==
X-Google-Smtp-Source: APXvYqzIq+rqK/g0JBN0/Nui20rKTzTK31dOVh+pDqx8CWEJ2HukeygzshDCg5ZUTlnRcKxNO8efbg==
X-Received: by 2002:a05:6402:1543:: with SMTP id p3mr11236676edx.108.1559304935180;
        Fri, 31 May 2019 05:15:35 -0700 (PDT)
Received: from dhcp-10-123-20-26.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id jz15sm822186ejb.75.2019.05.31.05.15.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 May 2019 05:15:34 -0700 (PDT)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com
Cc:     kashyap.desai@broadcom.com, sreekanth.reddy@broadcom.com,
        Sathya.Prakash@broadcom.com,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Subject: [V3 08/10] mpt3sas: Enable interrupt coalescing on high iops
Date:   Fri, 31 May 2019 08:14:41 -0400
Message-Id: <20190531121443.30694-9-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190531121443.30694-1-suganath-prabu.subramani@broadcom.com>
References: <20190531121443.30694-1-suganath-prabu.subramani@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

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

Signed-off-by: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h  |  2 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c   | 16 ++++++
 drivers/scsi/mpt3sas/mpt3sas_base.h   |  5 ++
 drivers/scsi/mpt3sas/mpt3sas_config.c | 71 +++++++++++++++++++++++++++
 drivers/scsi/mpt3sas/mpt3sas_scsih.c  | 17 ++++++-
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
index 4a4ef3c..c9418d9 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -4439,6 +4439,7 @@ _base_static_config_pages(struct MPT3SAS_ADAPTER *ioc)
 {
 	Mpi2ConfigReply_t mpi_reply;
 	u32 iounit_pg1_flags;
+	Mpi2IOCPage1_t ioc_pg1;
 
 	ioc->nvme_abort_timeout = 30;
 	mpt3sas_config_get_manufacturing_pg0(ioc, &mpi_reply, &ioc->manu_pg0);
@@ -4471,6 +4472,21 @@ _base_static_config_pages(struct MPT3SAS_ADAPTER *ioc)
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
2.18.1

