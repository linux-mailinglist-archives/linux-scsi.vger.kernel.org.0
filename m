Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFF0C25B54
	for <lists+linux-scsi@lfdr.de>; Wed, 22 May 2019 02:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbfEVAti (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 21 May 2019 20:49:38 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36546 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbfEVAth (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 21 May 2019 20:49:37 -0400
Received: by mail-pl1-f195.google.com with SMTP id d21so180514plr.3
        for <linux-scsi@vger.kernel.org>; Tue, 21 May 2019 17:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xRt4kHIXH2tkalnzLg5rnVq4ZDA5QXvmA0Ae1wNV6O0=;
        b=mAebVITF0mOD1thE+TkeoCxro9u2Ph4e3kHpQ6CwnuLDY1gpZc8WOyBKX7ztVi3Q6A
         kWu4n/cM6EJFfL7okkbR2UOugsI7Q/gvpQkISXOp/xilZf1IeQ0KoJCa7Vqxf6AQI7or
         NvivV3kASvwJyov41Yb+P7QYWFFrEcoN/nNcTcIRR1FoQYLP7dztbJlUaGNIQhb1ZPa5
         Jqozt+UbthtCFzk5HUAQ98buxctxoM5GbhojLn87z8E+I+TAmgXbi6sRp5TC/rK1Lc2B
         PUZVWmWM4zGeWURHRlF86pzwQM4wiUvGjYH+LqaeQbwtgsgzx03oQvwbvB9pVhszgvQZ
         PIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xRt4kHIXH2tkalnzLg5rnVq4ZDA5QXvmA0Ae1wNV6O0=;
        b=GXLJorGoxZLyTy+z4zpPb72xSNL1fdSTRxcsFP3qpO6w2KS8hP8YibAwnGdkgNntW0
         7DlZbOHCJDNIF2vOS5NgK9vRv2XEN7u+kHVhjBDA2gzlQvjWQK+7HVc1I3PZihnVZT9n
         EU8P0rMMjKRk+zW9xZOexKHmFVqgL1g+jPt9OpRE1PwX7zq2oUDPw6sU4pmkMo6f8NdA
         1hlW17ey1z/1SrJFX8GfqBh25UM9OtB8kovoRqBt3/xsgvz9eDpdpC//jyxOe6y0+J2v
         8eewvOfSSHRhtwgyA48zZnztzQTHs56as3o2QTHPUDWH9LvUUVZtlOx8ZKIEUVl2bJpf
         6mpQ==
X-Gm-Message-State: APjAAAX68UcioIhrFBtaVdBGzeoqzNzBCa/6CJpbO7Dggyg9IA6mfss8
        b/LgBt0xnmVbkXC4X1H03qhmedkd
X-Google-Smtp-Source: APXvYqz9i9JJtumbm+fQjXz9inGntyp4QlBKQGaDFBEUbvVZlLw+uytXYf/ROz0MUffpLz/0pZ1hWg==
X-Received: by 2002:a17:902:8303:: with SMTP id bd3mr38671029plb.240.1558486176934;
        Tue, 21 May 2019 17:49:36 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j184sm22550121pge.83.2019.05.21.17.49.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 May 2019 17:49:36 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 19/21] lpfc: Fix BFS crash with t10-dif enabled.
Date:   Tue, 21 May 2019 17:49:09 -0700
Message-Id: <20190522004911.573-20-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190522004911.573-1-jsmart2021@gmail.com>
References: <20190522004911.573-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Crashes in scsi_queue_rq or in dma_unmap_direct_sg during BFS when
lpfc has lpfc_enable_bg=1.

lpfc is setting the t10-dif and prot sg after scsi_add_host_with_dma()
has been called. The scsi_host_set_prot() and scsi_host_set_guard()
routines need to be called before scsi_add_host_with_dma().

Revise the calling sequence to set the protection/guard data before
calling scsi_add_host_with_dma().

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_init.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 416f0fb155f5..a2b827dd36ff 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -94,6 +94,7 @@ static void lpfc_sli4_disable_intr(struct lpfc_hba *);
 static uint32_t lpfc_sli4_enable_intr(struct lpfc_hba *, uint32_t);
 static void lpfc_sli4_oas_verify(struct lpfc_hba *phba);
 static uint16_t lpfc_find_cpu_handle(struct lpfc_hba *, uint16_t, int);
+static void lpfc_setup_bg(struct lpfc_hba *, struct Scsi_Host *);
 
 static struct scsi_transport_template *lpfc_transport_template = NULL;
 static struct scsi_transport_template *lpfc_vport_transport_template = NULL;
@@ -4348,6 +4349,9 @@ lpfc_create_port(struct lpfc_hba *phba, int instance, struct device *dev)
 
 	timer_setup(&vport->delayed_disc_tmo, lpfc_delayed_disc_tmo, 0);
 
+	if (phba->sli3_options & LPFC_SLI3_BG_ENABLED)
+		lpfc_setup_bg(phba, shost);
+
 	error = scsi_add_host_with_dma(shost, dev, &phba->pcidev->dev);
 	if (error)
 		goto out_put_shost;
@@ -7669,8 +7673,6 @@ lpfc_post_init_setup(struct lpfc_hba *phba)
 	 */
 	shost = pci_get_drvdata(phba->pcidev);
 	shost->can_queue = phba->cfg_hba_queue_depth - 10;
-	if (phba->sli3_options & LPFC_SLI3_BG_ENABLED)
-		lpfc_setup_bg(phba, shost);
 
 	lpfc_host_attrib_init(shost);
 
-- 
2.13.7

