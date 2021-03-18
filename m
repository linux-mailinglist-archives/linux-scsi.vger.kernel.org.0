Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0D234018E
	for <lists+linux-scsi@lfdr.de>; Thu, 18 Mar 2021 10:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbhCRJM1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 18 Mar 2021 05:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbhCRJMW (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 18 Mar 2021 05:12:22 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11B1C06174A
        for <linux-scsi@vger.kernel.org>; Thu, 18 Mar 2021 02:12:21 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id o11so1029401pgs.4
        for <linux-scsi@vger.kernel.org>; Thu, 18 Mar 2021 02:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=mz8x7s4JuBtNkKE+7bNt5EHOAPddw+lqTK0C7SaMKPE=;
        b=aC6BA/kJ2RkUKbALoVbxQ7TgJv06RFGgyEN1YzxRHR/pVr5wd63gK1K8cJ1W6cl+lU
         HMsDwnjLs6O+M9fO+Ugr8FxgetkmWEUfUdEAo4KJNkfv5116a2T+8oIzGk1tqg5eroSL
         2Smnu/GWoEEX6WCDzsE2FUki6q+A17SoiH6/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=mz8x7s4JuBtNkKE+7bNt5EHOAPddw+lqTK0C7SaMKPE=;
        b=tIBTaDRzswG8z3pqSJKFuopfkKQvg/SuJi2P4csW/PRemsIIZ5YgDwKrXQE/5UV7V4
         ZMdXUHUHBM0OW+YiJy2+kmYEGpjEb5pJmotpeBekOnvUlOPL+LRZ0i0ImH8G0UdRWgYl
         RXhnKO0m579Hik2uPMP3VSnx6yruxucPy5JxETFHJclBmdMPzCbit434GoUvi+MDarxT
         yYNRY4eOSXbIHkzyqlTnOl9bjNIsttk++9NplPKICwW9nWotbfUklBwvYuqcYpPwGmvy
         FaPHkCgCIsMMZfPzpaI2TnY1yKWfVtH3GvQxq7fMb+JdwFJ3kUxszGQfVonVPMUYDeZF
         JzxA==
X-Gm-Message-State: AOAM5329tJht5xCTde8+rzpE05mJp0gcsr9w470qYiAF17E8Trle42Vz
        Vxv2cALnL1Csz4UJqQKzIz5Hs/FB/HHRwME7MHol4qFkTF3UFrNaZ01tSE5KjKVTx+4FnS5XewJ
        vtMmZLwSrKw8ZWMDexpWR8cFPDIx6zxgX/uxbD1mtsODOkdl0V32z8kGwTr8plGbfyNLY9vM3Ma
        jUYPpAmqIwR1lG0D1Hfr2F
X-Google-Smtp-Source: ABdhPJzrRm3pQAM5pPhPqMnfiXtf8IB6g2IWo0h2IcI+nsYJMlG9Uztsji/lVru02ZrIsdTayxkh7A==
X-Received: by 2002:a63:2441:: with SMTP id k62mr5929552pgk.332.1616058740079;
        Thu, 18 Mar 2021 02:12:20 -0700 (PDT)
Received: from dhcp-10-123-20-76.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 11sm1413350pgt.83.2021.03.18.02.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 02:12:19 -0700 (PDT)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com
Cc:     Sathya.Prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH V2 5/7] mpt3sas: Handle Reply post queue DMA allocations in same 4G region
Date:   Thu, 18 Mar 2021 14:41:49 +0530
Message-Id: <20210318091151.39349-6-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210318091151.39349-1-suganath-prabu.subramani@broadcom.com>
References: <20210318091151.39349-1-suganath-prabu.subramani@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000003846c705bdcbff2c"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--0000000000003846c705bdcbff2c
Content-Transfer-Encoding: 8bit

According to MPI Specification Reply Post buffers should not cross
4GB boundary. So while allocating Reply Post buffers, if any buffer
crosses the 4GB boundary then,
* Release the already allocated memory pools and
* Reallocate them by changing the DMA coherent mask to 32 bit.

Signed-off-by: Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 59 ++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 17 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index e8b2930..9e717b3 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -5594,6 +5594,42 @@ _base_allocate_reply_pool(struct MPT3SAS_ADAPTER *ioc, u32 sz)
 	return 0;
 }
 
+/**
+ * _base_allocate_reply_free_dma_pool - Allocating DMA'able memory
+ *			for reply free dma pool.
+ * @ioc: Adapter object
+ * @sz: DMA Pool size
+ * Return: 0 for success, non-zero for failure.
+ */
+static int
+_base_allocate_reply_free_dma_pool(struct MPT3SAS_ADAPTER *ioc, u32 sz)
+{
+	/* reply free queue, 16 byte align */
+	ioc->reply_free_dma_pool = dma_pool_create(
+	    "reply_free pool", &ioc->pdev->dev, sz, 16, 0);
+	if (!ioc->reply_free_dma_pool)
+		return -ENOMEM;
+	ioc->reply_free = dma_pool_alloc(ioc->reply_free_dma_pool,
+	    GFP_KERNEL, &ioc->reply_free_dma);
+	if (!ioc->reply_free)
+		return -EAGAIN;
+	if (!mpt3sas_check_same_4gb_region((long)ioc->reply_free, sz)) {
+		dinitprintk(ioc,
+		    pr_err("Bad Reply Free Pool! Reply Free (0x%p) Reply Free dma = (0x%llx)\n",
+		    ioc->reply_free, (unsigned long long) ioc->reply_free_dma));
+		ioc->use_32bit_dma = true;
+		return -EAGAIN;
+	}
+	memset(ioc->reply_free, 0, sz);
+	dinitprintk(ioc, ioc_info(ioc,
+	    "reply_free pool(0x%p): depth(%d), element_size(%d), pool_size(%d kB)\n",
+	    ioc->reply_free, ioc->reply_free_queue_depth, 4, sz/1024));
+	dinitprintk(ioc, ioc_info(ioc,
+	    "reply_free_dma (0x%llx)\n",
+	    (unsigned long long)ioc->reply_free_dma));
+	return 0;
+}
+
 /**
  * base_alloc_rdpq_dma_pool - Allocating DMA'able memory
  *                     for reply queues.
@@ -6051,29 +6087,18 @@ _base_allocate_memory_pools(struct MPT3SAS_ADAPTER *ioc)
 	else if (rc == -EAGAIN)
 		goto try_32bit_dma;
 	total_sz += sz;
+
 	/* reply free queue, 16 byte align */
 	sz = ioc->reply_free_queue_depth * 4;
-	ioc->reply_free_dma_pool = dma_pool_create("reply_free pool",
-	    &ioc->pdev->dev, sz, 16, 0);
-	if (!ioc->reply_free_dma_pool) {
-		ioc_err(ioc, "reply_free pool: dma_pool_create failed\n");
-		goto out;
-	}
-	ioc->reply_free = dma_pool_zalloc(ioc->reply_free_dma_pool, GFP_KERNEL,
-	    &ioc->reply_free_dma);
-	if (!ioc->reply_free) {
-		ioc_err(ioc, "reply_free pool: dma_pool_alloc failed\n");
-		goto out;
-	}
-	dinitprintk(ioc,
-		    ioc_info(ioc, "reply_free pool(0x%p): depth(%d), element_size(%d), pool_size(%d kB)\n",
-			     ioc->reply_free, ioc->reply_free_queue_depth,
-			     4, sz / 1024));
+	rc = _base_allocate_reply_free_dma_pool(ioc, sz);
+	if (rc  == -ENOMEM)
+		return -ENOMEM;
+	else if (rc == -EAGAIN)
+		goto try_32bit_dma;
 	dinitprintk(ioc,
 		    ioc_info(ioc, "reply_free_dma (0x%llx)\n",
 			     (unsigned long long)ioc->reply_free_dma));
 	total_sz += sz;
-
 	if (ioc->rdpq_array_enable) {
 		reply_post_free_array_sz = ioc->reply_queue_count *
 		    sizeof(Mpi2IOCInitRDPQArrayEntry);
-- 
2.27.0


--0000000000003846c705bdcbff2c
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
KoZIhvcNAQkEMSIEIKp5wFoVW38CrY3Y2CwF5PdCC5eUv/RAO7O4kUIonfw5MBgGCSqGSIb3DQEJ
AzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIxMDMxODA5MTIyMVowaQYJKoZIhvcNAQkP
MVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAL
BgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAS
O4R9ElYGgS9KiBCfb9a6tjxwlsJvR0hbc5UminFpcLLURQRzKRUW3ivy2Yt3vwEx6qYA/Anqy0MJ
uaGSGTgmiMcTBnaNz1HXni3RVy8084w68E7YIp4OFkw5j3dYM851ydtuIxUb9aXY03bxj8sMqnBt
IMWV45eXUTpeiXXBZ8ZsWwQGSCrrhoq6yfX8rzFUrfmRSxpAc0nYSVyecJ8Wi40f1uhtrQaOsF4i
Xp3UfIESwH5ZJSRysrUz4G9xAJ9eku7vcTcXMpn0fnd8UZuMefqmvUuN1+RuJ1gv3GxQoJgcxw4w
zv9+Wcum1ggFaNfRpWZZ/mulP7A+AgAU/GCU
--0000000000003846c705bdcbff2c--
