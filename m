Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 425E4125828
	for <lists+linux-scsi@lfdr.de>; Thu, 19 Dec 2019 00:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbfLRX6f (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 18 Dec 2019 18:58:35 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40216 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbfLRX6e (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 18 Dec 2019 18:58:34 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so3779668wmi.5
        for <linux-scsi@vger.kernel.org>; Wed, 18 Dec 2019 15:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4Gm7kV156yShIXHTK6fFqsQOeVAGlnxtZJEsUpw2+ZA=;
        b=r6kg800KlKafvQ47SzK0KPr2hIHK22sSilBDVxVpP34G5sa851T0NwvNFV4ji4uukn
         Qz7cksNm+SQhzX0vPR3v/ySbYVQhEnmH0fnxkMxRruKufEeibsO1/cPiofvdCjYWtAs8
         4zv994nq66rvnRR+pQ+yQaokbcqgQskRGnPJNqlKMFTk51rF785zUEPa0pP6n37Iao/b
         xxeTfywIc4BvijB5yOV4KU6Xjarfmhw9Efs24JW2ArVKqPy/oeDYbAWqtwTIOpH0RNeD
         heC45AdJPFFSnTAFBVGII1obakIeUIFIFbjzeoEh158QfG//1UUv01knYBK0XcROqq2K
         T0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4Gm7kV156yShIXHTK6fFqsQOeVAGlnxtZJEsUpw2+ZA=;
        b=akEL/fSNh3xYoWXyZ0iCDYZzPpeyzrLabWMrpUSnNiZtyRc1s+auq4JEaYUC840s0A
         0j4ej403UPCUYguDTpLvefNoQjsbbcyvySI3tmwV2qWnYsDNvhbBNSRZZX+7l2hgXoQO
         +JZxrMv7OP6lwMJFHUEVmRBK5zlBgDqp7kNYnjvW4auglt33gdzMucHchaus6iGUxfug
         MA0g/SBwxUDXR/0ZufLKBOyM2oOME+kCYL63Z3yllrV1NOQYdOsA2dIgc7+goK/ofh/5
         /RNpwA7QqppT0psi6Cw0nhLfK4hbgFhfHWyQg/8Zpd4wPb/9hcn2A/m769ZTjiPVujaW
         YkXg==
X-Gm-Message-State: APjAAAVdvKAtS5N9BWmA3O7P+aAWBNj7O4knxf6keX14DWAPdo0PabEN
        VIcKMb/FXT8IfbKgjonDc4zLLeDq
X-Google-Smtp-Source: APXvYqybzzM1gEwJuMBfcWI9Hs4ghx4K7lfgqG9zJ5Z8gRjCfNbZexuhPn4H7x6cGrLMzCMk5Uffwg==
X-Received: by 2002:a7b:c183:: with SMTP id y3mr6450059wmi.0.1576713512824;
        Wed, 18 Dec 2019 15:58:32 -0800 (PST)
Received: from os42.localdomain ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x11sm4240731wmg.46.2019.12.18.15.58.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Dec 2019 15:58:32 -0800 (PST)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 09/10] lpfc: Fix improper flag check for IO type
Date:   Wed, 18 Dec 2019 15:58:07 -0800
Message-Id: <20191218235808.31922-10-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20191218235808.31922-1-jsmart2021@gmail.com>
References: <20191218235808.31922-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Current driver code looks at iocb types and uses a "==" comparison
on the flags to determine type. If another flag were set, it would
disrupt the comparison.

Fix by converting to a bitwise & operation.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_scsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index b138d9fee675..2c7e0b22db2f 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -481,7 +481,7 @@ lpfc_sli4_vport_delete_fcp_xri_aborted(struct lpfc_vport *vport)
 		spin_lock(&qp->abts_io_buf_list_lock);
 		list_for_each_entry_safe(psb, next_psb,
 					 &qp->lpfc_abts_io_buf_list, list) {
-			if (psb->cur_iocbq.iocb_flag == LPFC_IO_NVME)
+			if (psb->cur_iocbq.iocb_flag & LPFC_IO_NVME)
 				continue;
 
 			if (psb->rdata && psb->rdata->pnode &&
@@ -528,7 +528,7 @@ lpfc_sli4_io_xri_aborted(struct lpfc_hba *phba,
 			list_del_init(&psb->list);
 			psb->flags &= ~LPFC_SBUF_XBUSY;
 			psb->status = IOSTAT_SUCCESS;
-			if (psb->cur_iocbq.iocb_flag == LPFC_IO_NVME) {
+			if (psb->cur_iocbq.iocb_flag & LPFC_IO_NVME) {
 				qp->abts_nvme_io_bufs--;
 				spin_unlock(&qp->abts_io_buf_list_lock);
 				spin_unlock_irqrestore(&phba->hbalock, iflag);
-- 
2.13.7

