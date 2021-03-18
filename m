Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1B0434018B
	for <lists+linux-scsi@lfdr.de>; Thu, 18 Mar 2021 10:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhCRJMZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 18 Mar 2021 05:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbhCRJMJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 18 Mar 2021 05:12:09 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A91FC06174A
        for <linux-scsi@vger.kernel.org>; Thu, 18 Mar 2021 02:12:09 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so4682159pjc.2
        for <linux-scsi@vger.kernel.org>; Thu, 18 Mar 2021 02:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=YAmAOHK31R6/RwMTRAYDP1Lp216tbQiYdyZBXO4uE3c=;
        b=aFtDHQe76wk0jUjdtjlaTh6eR5q9RkCRBlIWB0d8OkxBkeLvxxP4ZPw15KKMEVc0ip
         N60AsLueLgn1PTuu+8f6tPa3BHbFfWkQ6qmt7CIS790xjUMv/eA7NsM2z2psZac9t8WX
         9qysQijzokivyFoVI/MCLPrhqQXoPckTw7kk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=YAmAOHK31R6/RwMTRAYDP1Lp216tbQiYdyZBXO4uE3c=;
        b=Rr77jXOX5Bk1d3SxtWcmmEzH27YafnKfQ50PnbIyTSSg2/QyTAI9oQywW057U9G0/h
         JUy4/gzkmRFBM/8jfA+bByjW3PMpK/tSzXysS7Gt1cOk5oBD/p3QuKxx40F+uFOPt80U
         6ntzTnjiUQxzTpplJ/Yglqe+pelRCzS2pIrKfKvEKX4xVdO+ViZo8vEKlAqNW8Y1zr6J
         729TzANp74+gPjWl+tajCPB1/EhT4umJzxboC40OUZW1Dyki+FXkucpGdF3crbCLzNkw
         9tFeYkH9+m+gwXi8DhHt5Exl6gAOIep1ZAA3IPA4gZXgTwRR6SS6bIJgbTu/cQOw1SAL
         PrpA==
X-Gm-Message-State: AOAM533c7JeNJa6vhUucZJlmUzAC4kV1NVfww3N/43OQFjPVpHrLe1PC
        BNazlSi7cgR4UxvJoy8qqMUmV1EHtStlXq52y9jwdvZ+DhX7ql7vFt1Rh79UhDGfEiGEKe6zKOM
        FanvKRn2Qs6+rYF8zfSJHIxGU9nYYI9SumOZuB1HpWxRq1qyoklIn8vNeB5m+BVD/Bv4mkKRrKe
        lt81iCuQwwAanZ44ALh1Gt
X-Google-Smtp-Source: ABdhPJxoqSauc5WukHreEmHhVXuAe7CCyzQal6v+GhqaBNOCwgKtZHnFdQj8Oju3/htl8dwTTToM5g==
X-Received: by 2002:a17:90b:3449:: with SMTP id lj9mr3399916pjb.55.1616058727719;
        Thu, 18 Mar 2021 02:12:07 -0700 (PDT)
Received: from dhcp-10-123-20-76.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 11sm1413350pgt.83.2021.03.18.02.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 02:12:07 -0700 (PDT)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com
Cc:     Sathya.Prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH V2 1/7] mpt3sas: Handle PCIe sgl's in same 4G region.
Date:   Thu, 18 Mar 2021 14:41:45 +0530
Message-Id: <20210318091151.39349-2-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318091151.39349-1-suganath-prabu.subramani@broadcom.com>
References: <20210318091151.39349-1-suganath-prabu.subramani@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000772a1205bdcbfe4b"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--000000000000772a1205bdcbfe4b
Content-Transfer-Encoding: 8bit

According to MPI Specification PCIe SGL buffers should not cross
4GB boundary. So while allocating PCIe SGL buffers, if any buffer
crosses the 4GB boundary then,
* Release the already allocated memory pools and
* Reallocate them by changing the DMA coherent mask to 32 bit.

Signed-off-by: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 159 ++++++++++++++++++++--------
 drivers/scsi/mpt3sas/mpt3sas_base.h |   1 +
 2 files changed, 113 insertions(+), 47 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index ac066f8..f9e6f8e 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -2905,23 +2905,22 @@ static int
 _base_config_dma_addressing(struct MPT3SAS_ADAPTER *ioc, struct pci_dev *pdev)
 {
 	struct sysinfo s;
-	int dma_mask;
 
 	if (ioc->is_mcpu_endpoint ||
 	    sizeof(dma_addr_t) == 4 || ioc->use_32bit_dma ||
 	    dma_get_required_mask(&pdev->dev) <= 32)
-		dma_mask = 32;
+		ioc->dma_mask = 32;
 	/* Set 63 bit DMA mask for all SAS3 and SAS35 controllers */
 	else if (ioc->hba_mpi_version_belonged > MPI2_VERSION)
-		dma_mask = 63;
+		ioc->dma_mask = 63;
 	else
-		dma_mask = 64;
+		ioc->dma_mask = 64;
 
-	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(dma_mask)) ||
-	    dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(dma_mask)))
+	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(ioc->dma_mask)) ||
+	    dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(ioc->dma_mask)))
 		return -ENODEV;
 
-	if (dma_mask > 32) {
+	if (ioc->dma_mask > 32) {
 		ioc->base_add_sg_single = &_base_add_sg_single_64;
 		ioc->sge_size = sizeof(Mpi2SGESimple64_t);
 	} else {
@@ -2931,7 +2930,7 @@ _base_config_dma_addressing(struct MPT3SAS_ADAPTER *ioc, struct pci_dev *pdev)
 
 	si_meminfo(&s);
 	ioc_info(ioc, "%d BIT PCI BUS DMA ADDRESSING SUPPORTED, total mem (%ld kB)\n",
-		dma_mask, convert_to_kb(s.totalram));
+		ioc->dma_mask, convert_to_kb(s.totalram));
 
 	return 0;
 }
@@ -5338,10 +5337,10 @@ _base_release_memory_pools(struct MPT3SAS_ADAPTER *ioc)
 			dma_pool_free(ioc->pcie_sgl_dma_pool,
 					ioc->pcie_sg_lookup[i].pcie_sgl,
 					ioc->pcie_sg_lookup[i].pcie_sgl_dma);
+			ioc->pcie_sg_lookup[i].pcie_sgl = NULL;
 		}
 		dma_pool_destroy(ioc->pcie_sgl_dma_pool);
 	}
-
 	if (ioc->config_page) {
 		dexitprintk(ioc,
 			    ioc_info(ioc, "config_page(0x%p): free\n",
@@ -5399,6 +5398,89 @@ mpt3sas_check_same_4gb_region(long reply_pool_start_address, u32 pool_sz)
 		return 0;
 }
 
+/**
+ * _base_reduce_hba_queue_depth- Retry with reduced queue depth
+ * @ioc: Adapter object
+ *
+ * Return: 0 for success, non-zero for failure.
+ **/
+static inline int
+_base_reduce_hba_queue_depth(struct MPT3SAS_ADAPTER *ioc)
+{
+	int reduce_sz = 64;
+
+	if ((ioc->hba_queue_depth - reduce_sz) >
+	    (ioc->internal_depth + INTERNAL_SCSIIO_CMDS_COUNT)) {
+		ioc->hba_queue_depth -= reduce_sz;
+		return 0;
+	} else
+		return -ENOMEM;
+}
+
+/**
+ * _base_allocate_pcie_sgl_pool - Allocating DMA'able memory
+ *			for pcie sgl pools.
+ * @ioc: Adapter object
+ * @sz: DMA Pool size
+ * @ct: Chain tracker
+ * Return: 0 for success, non-zero for failure.
+ */
+
+static int
+_base_allocate_pcie_sgl_pool(struct MPT3SAS_ADAPTER *ioc, u32 sz)
+{
+	int i = 0, j = 0;
+	struct chain_tracker *ct;
+
+	ioc->pcie_sgl_dma_pool =
+	    dma_pool_create("PCIe SGL pool", &ioc->pdev->dev, sz,
+	    ioc->page_size, 0);
+	if (!ioc->pcie_sgl_dma_pool) {
+		ioc_err(ioc, "PCIe SGL pool: dma_pool_create failed\n");
+		return -ENOMEM;
+	}
+
+	ioc->chains_per_prp_buffer = sz/ioc->chain_segment_sz;
+	ioc->chains_per_prp_buffer =
+	    min(ioc->chains_per_prp_buffer, ioc->chains_needed_per_io);
+	for (i = 0; i < ioc->scsiio_depth; i++) {
+		ioc->pcie_sg_lookup[i].pcie_sgl =
+		    dma_pool_alloc(ioc->pcie_sgl_dma_pool, GFP_KERNEL,
+		    &ioc->pcie_sg_lookup[i].pcie_sgl_dma);
+		if (!ioc->pcie_sg_lookup[i].pcie_sgl) {
+			ioc_err(ioc, "PCIe SGL pool: dma_pool_alloc failed\n");
+			return -EAGAIN;
+		}
+
+		if (!mpt3sas_check_same_4gb_region(
+		    (long)ioc->pcie_sg_lookup[i].pcie_sgl, sz)) {
+			ioc_err(ioc, "PCIE SGLs are not in same 4G !! pcie sgl (0x%p) dma = (0x%llx)\n",
+			    ioc->pcie_sg_lookup[i].pcie_sgl,
+			    (unsigned long long)
+			    ioc->pcie_sg_lookup[i].pcie_sgl_dma);
+			ioc->use_32bit_dma = true;
+			return -EAGAIN;
+		}
+
+		for (j = 0; j < ioc->chains_per_prp_buffer; j++) {
+			ct = &ioc->chain_lookup[i].chains_per_smid[j];
+			ct->chain_buffer =
+			    ioc->pcie_sg_lookup[i].pcie_sgl +
+			    (j * ioc->chain_segment_sz);
+			ct->chain_buffer_dma =
+			    ioc->pcie_sg_lookup[i].pcie_sgl_dma +
+			    (j * ioc->chain_segment_sz);
+		}
+	}
+	dinitprintk(ioc, ioc_info(ioc,
+	    "PCIe sgl pool depth(%d), element_size(%d), pool_size(%d kB)\n",
+	    ioc->scsiio_depth, sz, (sz * ioc->scsiio_depth)/1024));
+	dinitprintk(ioc, ioc_info(ioc,
+	    "Number of chains can fit in a PRP page(%d)\n",
+	    ioc->chains_per_prp_buffer));
+	return 0;
+}
+
 /**
  * base_alloc_rdpq_dma_pool - Allocating DMA'able memory
  *                     for reply queues.
@@ -5497,7 +5579,7 @@ _base_allocate_memory_pools(struct MPT3SAS_ADAPTER *ioc)
 	unsigned short sg_tablesize;
 	u16 sge_size;
 	int i, j;
-	int ret = 0;
+	int ret = 0, rc = 0;
 	struct chain_tracker *ct;
 
 	dinitprintk(ioc, ioc_info(ioc, "%s\n", __func__));
@@ -5802,6 +5884,7 @@ _base_allocate_memory_pools(struct MPT3SAS_ADAPTER *ioc)
 	 * be required for NVMe PRP's, only each set of NVMe blocks will be
 	 * contiguous, so a new set is allocated for each possible I/O.
 	 */
+
 	ioc->chains_per_prp_buffer = 0;
 	if (ioc->facts.ProtocolFlags & MPI2_IOCFACTS_PROTOCOL_NVME_DEVICES) {
 		nvme_blocks_needed =
@@ -5816,43 +5899,11 @@ _base_allocate_memory_pools(struct MPT3SAS_ADAPTER *ioc)
 			goto out;
 		}
 		sz = nvme_blocks_needed * ioc->page_size;
-		ioc->pcie_sgl_dma_pool =
-			dma_pool_create("PCIe SGL pool", &ioc->pdev->dev, sz, 16, 0);
-		if (!ioc->pcie_sgl_dma_pool) {
-			ioc_info(ioc, "PCIe SGL pool: dma_pool_create failed\n");
-			goto out;
-		}
-
-		ioc->chains_per_prp_buffer = sz/ioc->chain_segment_sz;
-		ioc->chains_per_prp_buffer = min(ioc->chains_per_prp_buffer,
-						ioc->chains_needed_per_io);
-
-		for (i = 0; i < ioc->scsiio_depth; i++) {
-			ioc->pcie_sg_lookup[i].pcie_sgl = dma_pool_alloc(
-				ioc->pcie_sgl_dma_pool, GFP_KERNEL,
-				&ioc->pcie_sg_lookup[i].pcie_sgl_dma);
-			if (!ioc->pcie_sg_lookup[i].pcie_sgl) {
-				ioc_info(ioc, "PCIe SGL pool: dma_pool_alloc failed\n");
-				goto out;
-			}
-			for (j = 0; j < ioc->chains_per_prp_buffer; j++) {
-				ct = &ioc->chain_lookup[i].chains_per_smid[j];
-				ct->chain_buffer =
-				    ioc->pcie_sg_lookup[i].pcie_sgl +
-				    (j * ioc->chain_segment_sz);
-				ct->chain_buffer_dma =
-				    ioc->pcie_sg_lookup[i].pcie_sgl_dma +
-				    (j * ioc->chain_segment_sz);
-			}
-		}
-
-		dinitprintk(ioc,
-			    ioc_info(ioc, "PCIe sgl pool depth(%d), element_size(%d), pool_size(%d kB)\n",
-				     ioc->scsiio_depth, sz,
-				     (sz * ioc->scsiio_depth) / 1024));
-		dinitprintk(ioc,
-			    ioc_info(ioc, "Number of chains can fit in a PRP page(%d)\n",
-				     ioc->chains_per_prp_buffer));
+		rc = _base_allocate_pcie_sgl_pool(ioc, sz);
+		if (rc == -ENOMEM)
+			return -ENOMEM;
+		else if (rc == -EAGAIN)
+			goto try_32bit_dma;
 		total_sz += sz * ioc->scsiio_depth;
 	}
 
@@ -6022,6 +6073,19 @@ _base_allocate_memory_pools(struct MPT3SAS_ADAPTER *ioc)
 		 ioc->shost->sg_tablesize);
 	return 0;
 
+try_32bit_dma:
+	_base_release_memory_pools(ioc);
+	if (ioc->use_32bit_dma && (ioc->dma_mask > 32)) {
+		/* Change dma coherent mask to 32 bit and reallocate */
+		if (_base_config_dma_addressing(ioc, ioc->pdev) != 0) {
+			pr_err("Setting 32 bit coherent DMA mask Failed %s\n",
+			    pci_name(ioc->pdev));
+			return -ENODEV;
+		}
+	} else if (_base_reduce_hba_queue_depth(ioc) != 0)
+		return -ENOMEM;
+	goto retry_allocation;
+
  out:
 	return -ENOMEM;
 }
@@ -7682,6 +7746,7 @@ mpt3sas_base_attach(struct MPT3SAS_ADAPTER *ioc)
 
 	ioc->rdpq_array_enable_assigned = 0;
 	ioc->use_32bit_dma = false;
+	ioc->dma_mask = 64;
 	if (ioc->is_aero_ioc)
 		ioc->base_readl = &_base_readl_aero;
 	else
diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.h b/drivers/scsi/mpt3sas/mpt3sas_base.h
index 315aee6..b86eced 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.h
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.h
@@ -1371,6 +1371,7 @@ struct MPT3SAS_ADAPTER {
 	u16		thresh_hold;
 	u8		high_iops_queues;
 	u32		drv_support_bitmap;
+	u32             dma_mask;
 	bool		enable_sdev_max_qd;
 	bool		use_32bit_dma;
 
-- 
2.27.0


--000000000000772a1205bdcbfe4b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBXAwggRYoAMCAQICDCAc2j96+IoHW5040jANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMTAyMjIxMjQzNTVaFw0yMjA5MTUxMTMwMjdaMIGm
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xITAfBgNVBAMTGFN1Z2FuYXRoIFByYWJ1IFN1YnJhbWFuaTE0
MDIGCSqGSIb3DQEJARYlc3VnYW5hdGgtcHJhYnUuc3VicmFtYW5pQGJyb2FkY29tLmNvbTCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJp3W6i+yVqwmKTbucNHNrAD35AKBa4GklrnUcWS
As4Yz62jxfJOu+dcysfahgpi3JcAhTe/eRMLc5on8ReYZAYCMNJ+jpNKRuf1Abgh6nfhcNf+cuGb
S83CJlqxdJjbnimwwbueitA/edWTFjcULNUDZZEmAPJkbHXmlTlJD8TMdR0ezem/d4niexc4RCyt
YMUhnlcyFg+2OR0MKuT2Q714Ka0IamXFyyXhX5wD9B+ITo5hu+ZtXV2RuOXy0U2bIEQzFPVJ7QA9
hUD4z7+jEN/0xIbuF8EJZMsb6XAT+CFOjnizM5yvGFfmupDlyQ4JuVb86R8v2AEDpXmbdnS1tDkC
AwEAAaOCAeYwggHiMA4GA1UdDwEB/wQEAwIFoDCBowYIKwYBBQUHAQEEgZYwgZMwTgYIKwYBBQUH
MAKGQmh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNydDBBBggrBgEFBQcwAYY1aHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3Nn
Y2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAwTQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYB
BQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAw
SQYDVR0fBEIwQDA+oDygOoY4aHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29u
YWxzaWduMmNhMjAyMC5jcmwwMAYDVR0RBCkwJ4Elc3VnYW5hdGgtcHJhYnUuc3VicmFtYW5pQGJy
b2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk
1b5I3qGPzzAdBgNVHQ4EFgQURmgYmHXuw9VrKqnEjPBuviQS0CEwDQYJKoZIhvcNAQELBQADggEB
AAp1Yt9kkxViI/9B/AQxLFmuC9wWruix0ajjegaJ/HZ6C1ky/V9QvI1MwweIhBiuk2jttOzO4h87
rADIQnEI3bf5ccaw61CJNqc6Cb4LiEIjPF7py8f6+rHL928xCUnKqeCO2sC0A+k39bCiyHaGo432
eXxWNXxGrLg6/2TuwgOtvbil0hWwK/Wf5ql2YiZXy8wRo9IhHoY/4cJLS/Fay8yKX8IdhEc3pNbu
dDLaJg39U0ikF3NHtNMaXXHgh6TMs3OsWhH4+zlvkC0eSC6dvasGxmpPQPQe/0huBB8gDbzGrRg/
cRn2ctMmNHxZO4EBJ5SzsV/lHimTk+5K39lzkzYxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQ
ZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwgHNo/eviKB1udONIwDQYJYIZIAWUDBAIBBQCggdQwLwYJ
KoZIhvcNAQkEMSIEIPPzfLxwSoB8/0B0WDdEiAaUJQvdO96th9iRmrcU0UIoMBgGCSqGSIb3DQEJ
AzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIxMDMxODA5MTIwOFowaQYJKoZIhvcNAQkP
MVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAL
BgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBb
KtMcI8plnViGEa1NWR4SriZMLoV9SbGJo6mzTAXKTpo8+ZdCzEAby9utsX3xfp4Pp9xMTlfxUQ50
WcheeMRfU5LdNUTtuwaqm/dSC/IVWfYFXH3MNqcZghVuulbuDnw13MPvF2g2syUlPhDuecRPFpI1
3ZDmeNgkaqnzV0MgEmMJPxpd5+MBlegCpypEQrq1omiq5banJOmgkdYLvwEJZjUr3MC3vGjtPLcL
xTds1jsSYyjU3WW4ZrZs+RIyoyOP/8/gzNUq5Yk5vXObCEtvCgbVBOb7yDABlB0aztN0czEPyXI9
k+qEtxwTYitTTupik9mK3rVbLXCSCMV5sZV9
--000000000000772a1205bdcbfe4b--
