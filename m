Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3593418229
	for <lists+linux-scsi@lfdr.de>; Sat, 25 Sep 2021 15:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244869AbhIYNEv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 25 Sep 2021 09:04:51 -0400
Received: from mx24.baidu.com ([111.206.215.185]:52746 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234877AbhIYNEu (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 25 Sep 2021 09:04:50 -0400
Received: from BC-Mail-Ex03.internal.baidu.com (unknown [172.31.51.43])
        by Forcepoint Email with ESMTPS id C948ED1B274F014CBFF8;
        Sat, 25 Sep 2021 20:46:58 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex03.internal.baidu.com (172.31.51.43) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Sat, 25 Sep 2021 20:46:58 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Sat, 25 Sep 2021 20:46:58 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        <MPT-FusionLinux.pdl@broadcom.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] scsi: message: fusion: Use direction definition DMA_BIDIRECTIONAL instead of PCI_DMA_BIDIRECTIONAL
Date:   Sat, 25 Sep 2021 20:46:51 +0800
Message-ID: <20210925124652.409-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex01.internal.baidu.com (10.127.64.11) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Replace direction definition PCI_DMA_BIDIRECTIONAL
with DMA_BIDIRECTIONAL, because it helps to enhance readability
and avoid possible inconsistency.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/message/fusion/mptsas.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/message/fusion/mptsas.c b/drivers/message/fusion/mptsas.c
index 85285ba8e817..ab63557be0b5 100644
--- a/drivers/message/fusion/mptsas.c
+++ b/drivers/message/fusion/mptsas.c
@@ -2301,7 +2301,7 @@ static void mptsas_smp_handler(struct bsg_job *job, struct Scsi_Host *shost,
 		       << MPI_SGE_FLAGS_SHIFT;
 
 	if (!dma_map_sg(&ioc->pcidev->dev, job->request_payload.sg_list,
-			1, PCI_DMA_BIDIRECTIONAL))
+			1, DMA_BIDIRECTIONAL))
 		goto put_mf;
 
 	flagsLength |= (sg_dma_len(job->request_payload.sg_list) - 4);
@@ -2318,7 +2318,7 @@ static void mptsas_smp_handler(struct bsg_job *job, struct Scsi_Host *shost,
 	flagsLength = flagsLength << MPI_SGE_FLAGS_SHIFT;
 
 	if (!dma_map_sg(&ioc->pcidev->dev, job->reply_payload.sg_list,
-			1, PCI_DMA_BIDIRECTIONAL))
+			1, DMA_BIDIRECTIONAL))
 		goto unmap_out;
 	flagsLength |= sg_dma_len(job->reply_payload.sg_list) + 4;
 	ioc->add_sge(psge, flagsLength,
@@ -2356,10 +2356,10 @@ static void mptsas_smp_handler(struct bsg_job *job, struct Scsi_Host *shost,
 
 unmap_in:
 	dma_unmap_sg(&ioc->pcidev->dev, job->reply_payload.sg_list, 1,
-			PCI_DMA_BIDIRECTIONAL);
+		     DMA_BIDIRECTIONAL);
 unmap_out:
 	dma_unmap_sg(&ioc->pcidev->dev, job->request_payload.sg_list, 1,
-			PCI_DMA_BIDIRECTIONAL);
+		     DMA_BIDIRECTIONAL);
 put_mf:
 	if (mf)
 		mpt_free_msg_frame(ioc, mf);
-- 
2.25.1

