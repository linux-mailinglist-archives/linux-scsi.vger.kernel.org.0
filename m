Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC592E657
	for <lists+linux-scsi@lfdr.de>; Wed, 29 May 2019 22:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbfE2Ukd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 16:40:33 -0400
Received: from www17.your-server.de ([213.133.104.17]:60038 "EHLO
        www17.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfE2Ukc (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 16:40:32 -0400
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www17.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <thomas@m3y3r.de>)
        id 1hW54s-0005y9-E9; Wed, 29 May 2019 22:21:38 +0200
Received: from [2a02:908:4c22:ec00:915f:2518:d2f6:b586] (helo=maria.localdomain)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <thomas@m3y3r.de>)
        id 1hW54r-0006OR-5S; Wed, 29 May 2019 22:21:38 +0200
Received: by maria.localdomain (sSMTP sendmail emulation); Wed, 29 May 2019 22:21:36 +0200
From:   "Thomas Meyer" <thomas@m3y3r.de>
Date:   Wed, 29 May 2019 22:21:36 +0200
Subject: [PATCH] scsi: lpfc: Use *_pool_zalloc rather than *_pool_alloc
To:     james.smart@broadcom.com, dick.kennedy@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Patch: Cocci
X-Mailer: DiffSplit
Message-ID: <1559161113901-1017843021-1-diffsplit-thomas@m3y3r.de>
References: <1559161113889-196429735-0-diffsplit-thomas@m3y3r.de>
In-Reply-To: <1559161113889-196429735-0-diffsplit-thomas@m3y3r.de>
X-Serial-No: 1
X-Authenticated-Sender: thomas@m3y3r.de
X-Virus-Scanned: Clear (ClamAV 0.100.3/25464/Wed May 29 09:59:09 2019)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use *_pool_zalloc rather than *_pool_alloc followed by memset with 0.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -4114,14 +4114,13 @@ lpfc_new_io_buf(struct lpfc_hba *phba, i
 		 * pci bus space for an I/O. The DMA buffer includes the
 		 * number of SGE's necessary to support the sg_tablesize.
 		 */
-		lpfc_ncmd->data = dma_pool_alloc(phba->lpfc_sg_dma_buf_pool,
-				GFP_KERNEL,
-				&lpfc_ncmd->dma_handle);
+		lpfc_ncmd->data = dma_pool_zalloc(phba->lpfc_sg_dma_buf_pool,
+						  GFP_KERNEL,
+						  &lpfc_ncmd->dma_handle);
 		if (!lpfc_ncmd->data) {
 			kfree(lpfc_ncmd);
 			break;
 		}
-		memset(lpfc_ncmd->data, 0, phba->cfg_sg_dma_buf_size);
 
 		/*
 		 * 4K Page alignment is CRITICAL to BlockGuard, double check
