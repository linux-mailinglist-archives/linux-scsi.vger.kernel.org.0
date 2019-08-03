Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A666C8066D
	for <lists+linux-scsi@lfdr.de>; Sat,  3 Aug 2019 16:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391012AbfHCOAP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 3 Aug 2019 10:00:15 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43828 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387781AbfHCOAP (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 3 Aug 2019 10:00:15 -0400
Received: by mail-pl1-f194.google.com with SMTP id 4so27724410pld.10
        for <linux-scsi@vger.kernel.org>; Sat, 03 Aug 2019 07:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6wN1C0AvC9x7tBljRtSGnfqzECeBaW2pIXhX7Ubn5/E=;
        b=iPegaWhgohApRqdbz7dn4PxzQ2bOGwiHF5Xo51nvma2UcxrloGU06Kw9vAbyQOeP6z
         onykP09idxdOEyKHWlIuuizz8Syb/C8n+BQeDoKwKuk6EtBRDib7MRkUIFtFWhwNJbk7
         H72FCPxcRhQ91Q6UhFcVtOHr1OVBCJz/DoFg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6wN1C0AvC9x7tBljRtSGnfqzECeBaW2pIXhX7Ubn5/E=;
        b=DwRbRLZZPmEN0/xKQ8KEY3B2SG3Lj+sgR3CVzEOqWZ+Q6m2qXyvReWB8Y1A5ELWlnh
         EX2lRQ+bXbPnFmO41QvglfWPhTJIQWymPUyAq7okFjAHrKZHAOW5RrkzYEaMtxsGiGHD
         Emk6b/k/r5q7igS87r9y3tfbgPcFq9YcqDeoXh9royuMuIO+s0vwEZ3lmhiovajy8V+E
         3sEKCAhGYbQO3JZTNNUT8vdM5emQdGPCk6Mu5O8PGU/Me6JH8clXHIFG0E637QDMRYPJ
         +aAgn6YleqGjXeN91yx7ju8iwSMo1i/nUoI9kid9Zwx1hJlsR7O2vti5JCVOhJX7FhCM
         2FJw==
X-Gm-Message-State: APjAAAWSxg0+YZCNGM3VdLOQgJLipFhjmRBihwHlaYRR7cn8+UYAgXRx
        LfGzh8n9YoYAQ3xaNALNVI4P1BAGire3rQhpVEemhWpBrKUUTKRgBnfNahaODE/WHkIdQNFhpMf
        gaMDYYrnKVeMBDKpmrJozJBxYUs0fVAcCsIbkuZKdNR3lzobt1QZ2HuNqsAxCVdxqm1+15hAYuX
        RpHPHR/1UHRjUZzog8Eg==
X-Google-Smtp-Source: APXvYqw2W8JDGETD3SbUXCoxmGIwXIArO1EcsrrMI25X8JMo5J77UNztYrJohCBqe5eM4KiWb34qTg==
X-Received: by 2002:a17:902:a714:: with SMTP id w20mr136523376plq.127.1564840814368;
        Sat, 03 Aug 2019 07:00:14 -0700 (PDT)
Received: from dhcp-10-123-20-15.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id c69sm11711615pje.6.2019.08.03.07.00.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Aug 2019 07:00:13 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org
Cc:     Sathya.Prakash@broadcom.com, kashyap.desai@broadcom.com,
        sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH 02/12] mpt3sas: memset request frame before reusing
Date:   Sat,  3 Aug 2019 09:59:47 -0400
Message-Id: <1564840797-5876-3-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1564840797-5876-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1564840797-5876-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Driver gets a request frame from the free pool of DMA able
request frames and fill in the required information and pass
the address of the frame to IOC/FW to pull the complete request
frame. In certain places the driver used the request frame allocated
from the free pool without completely clearing the previous data
stored in it. The request contents were cleared only for the
size of the new request to be issued and that left out some
stale data in the unused part of the request. Though the
IOC/FW is not expected to access the request beyond the specified
size it is good practice to clear complete request message frame.

So reinitialize the complete request message frame with 0's
before using it.

Signed-off-by: Suganath Prabu <suganath-prabu.subramani@broadcom.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 2 ++
 drivers/scsi/mpt3sas/mpt3sas_ctl.c  | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 050c0f0..ba83f59 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -5037,6 +5037,7 @@ _base_allocate_memory_pools(struct MPT3SAS_ADAPTER *ioc)
 		_base_release_memory_pools(ioc);
 		goto retry_allocation;
 	}
+	memset(ioc->request, 0, sz);
 
 	if (retry_sz)
 		ioc_err(ioc, "request pool: dma_alloc_coherent succeed: hba_depth(%d), chains_per_io(%d), frame_sz(%d), total(%d kb)\n",
@@ -5868,6 +5869,7 @@ mpt3sas_base_scsi_enclosure_processor(struct MPT3SAS_ADAPTER *ioc,
 	ioc->base_cmds.status = MPT3_CMD_PENDING;
 	request = mpt3sas_base_get_msg_frame(ioc, smid);
 	ioc->base_cmds.smid = smid;
+	memset(request, 0, ioc->request_sz);
 	memcpy(request, mpi_request, sizeof(Mpi2SepReply_t));
 	init_completion(&ioc->base_cmds.done);
 	ioc->put_smid_default(ioc, smid);
diff --git a/drivers/scsi/mpt3sas/mpt3sas_ctl.c b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
index acd803a..ea87871 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_ctl.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_ctl.c
@@ -707,6 +707,7 @@ _ctl_do_mpt_command(struct MPT3SAS_ADAPTER *ioc, struct mpt3_ioctl_command karg,
 	ioc->ctl_cmds.status = MPT3_CMD_PENDING;
 	memset(ioc->ctl_cmds.reply, 0, ioc->reply_sz);
 	request = mpt3sas_base_get_msg_frame(ioc, smid);
+	memset(request, 0, ioc->request_sz);
 	memcpy(request, mpi_request, karg.data_sge_offset*4);
 	ioc->ctl_cmds.smid = smid;
 	data_out_sz = karg.data_out_size;
-- 
1.8.3.1

