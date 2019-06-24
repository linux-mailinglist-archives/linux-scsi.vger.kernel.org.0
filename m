Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1D650EE0
	for <lists+linux-scsi@lfdr.de>; Mon, 24 Jun 2019 16:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbfFXOnU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 Jun 2019 10:43:20 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34529 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730259AbfFXOnS (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 24 Jun 2019 10:43:18 -0400
Received: by mail-pf1-f196.google.com with SMTP id c85so7646649pfc.1
        for <linux-scsi@vger.kernel.org>; Mon, 24 Jun 2019 07:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KvMuSakjFHTcojwSLspD+wsYHmwTaEXxbHX5+A0BcG0=;
        b=IuHKDuZYC7Yujv5BBLqZFG9bs0jvrZoDYGIEvKv8OO9NuuHKNhDul+qBrnFDnVHG0y
         gGMcHu9pYX6T1leuv3w3wuzIu+M3z7J9aLn/TfK4GjvIlWbUrOKQ8ZiOOySAWxL6phWZ
         ZuyeQmZlnmLV9O5FNEkvI/WEtmB7rbJ96KTEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KvMuSakjFHTcojwSLspD+wsYHmwTaEXxbHX5+A0BcG0=;
        b=Jt/Ajrpofk8+lpILG4chZHCgEX8pneDu0de3C6PrdiCIIMbOUkCw0c3NMx5D7HAFZG
         Ckz2rOsaVjDs5Pg/CdshB4wOA/uh0E6IMRV9mudoTeR2iXgX9gJwKfLRXeccLqIRtQUI
         weiaZDC1yKsW38YlK7APUu3n1EtlTXIuaVxNQSKdGGcjJ1DMlqhpuBDBRK3tPi4cD9KX
         NtAa+HLRZ7k8cC6SKGL3CdJkCUJ717xOwtTtFc+1ak8Pw03bL5zXJB6YUqeR1rQCwTm5
         S0AvK9FCKWWiZ7Lo8NkiLteNevCF2CWDz0rvdQcFO8zgCcTNFz6l6udzannNE9v59JgY
         jdfQ==
X-Gm-Message-State: APjAAAVpcvGvzRc8bRC/vDzSd3o+PQDA+Og09vDEVOCdjoGqrmGEcmSb
        OB8LGZ5cdfbEKRayNBQIoo6fsw==
X-Google-Smtp-Source: APXvYqzgOky6GYlJcji23wkgWa7S0+5hwqA3un8OwJMpLoWlDwYecEwjPdcDkMDnvuRa+ZXGRBR2Fw==
X-Received: by 2002:a65:500d:: with SMTP id f13mr32763338pgo.151.1561387397882;
        Mon, 24 Jun 2019 07:43:17 -0700 (PDT)
Received: from dhcp-10-123-20-15.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id k197sm12991799pgc.22.2019.06.24.07.43.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 07:43:17 -0700 (PDT)
From:   Sreekanth Reddy <sreekanth.reddy@broadcom.com>
To:     martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, suganath-prabu.subramani@broadcom.com,
        sathya.prakash@broadcom.com,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Subject: [PATCH 4/4] mpt3sas: Fix msix load balance on and off settings 
Date:   Mon, 24 Jun 2019 10:42:56 -0400
Message-Id: <1561387376-28323-5-git-send-email-sreekanth.reddy@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1561387376-28323-1-git-send-email-sreekanth.reddy@broadcom.com>
References: <1561387376-28323-1-git-send-email-sreekanth.reddy@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Enable msix load balance only when combined reply queue mode
is disabled on the SAS3 and above generation HBA devices.

Earlier msix load balance used to enable if the number of online
cpus are greater than the number of MSIX vectors enabled on the HBA.
Combined reply queue mode will be disabled only on those HBA
which works in shared resources mode. i.e. on SAS3 HBAs
it will be <= 8 and on SAS35 HBA devices it will be <= 16.

- Before this patch if system has 256 logical CPU and
  HBA expose 128 MSIx vector, driver will enable msix load balance.
- After this patch if system has 256 logical CPU and
  HBA expose 128 MSIx vector, driver will disable msix load balance.
- After this patch if system has 256 logical CPU and
  HBA expose 16 MSIx vector (due to combined reply queue mode is off
  in HW), driver will enable msix load balance.

Signed-off-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 722599a..89418b1 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -2884,11 +2884,9 @@ _base_assign_reply_queues(struct MPT3SAS_ADAPTER *ioc)
 
 	if (!_base_is_controller_msix_enabled(ioc))
 		return;
-	ioc->msix_load_balance = false;
-	if (ioc->reply_queue_count < num_online_cpus()) {
-		ioc->msix_load_balance = true;
+
+	if (ioc->msix_load_balance)
 		return;
-	}
 
 	memset(ioc->cpu_msix_table, 0, ioc->cpu_msix_table_sz);
 
@@ -3060,6 +3058,8 @@ _base_enable_msix(struct MPT3SAS_ADAPTER *ioc)
 	int i, local_max_msix_vectors;
 	u8 try_msix = 0;
 
+	ioc->msix_load_balance = false;
+
 	if (msix_disable == -1 || msix_disable == 0)
 		try_msix = 1;
 
@@ -3090,7 +3090,20 @@ _base_enable_msix(struct MPT3SAS_ADAPTER *ioc)
 	else if (local_max_msix_vectors == 0)
 		goto try_ioapic;
 
-	if (ioc->msix_vector_count < ioc->cpu_count)
+	/*
+	 * Enable msix_load_balance only if combined reply queue mode is
+	 * disabled on SAS3 & above generation HBA devices.
+	 */
+	if (!ioc->combined_reply_queue &&
+	    ioc->hba_mpi_version_belonged != MPI2_VERSION) {
+		ioc->msix_load_balance = true;
+	}
+
+	/*
+	 * smp affinity setting is not need when msix load balance
+	 * is enabled.
+	 */
+	if (ioc->msix_load_balance)
 		ioc->smp_affinity_enable = 0;
 
 	r = _base_alloc_irq_vectors(ioc);
-- 
1.8.3.1

