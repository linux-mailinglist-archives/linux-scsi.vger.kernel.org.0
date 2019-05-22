Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA1B825B53
	for <lists+linux-scsi@lfdr.de>; Wed, 22 May 2019 02:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbfEVAti (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 21 May 2019 20:49:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33003 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbfEVAtg (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 21 May 2019 20:49:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id h17so388550pgv.0
        for <linux-scsi@vger.kernel.org>; Tue, 21 May 2019 17:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8vlxPfdjqDnpKOFwQDs/sHb8PGm43i0NxnYIMcUCHf8=;
        b=RFlJJF/TN6uhVaf0zWcpKnuaW2gU6qT/DlBNldofv5kSjQwYO1hQLrJPYM/cXZ3VTu
         Y5O8QYqJPjEosCN7xL2yujr98ugFn/hnsNBsEn2LQbKElnfEOiYci4ty+jc77+Va9HNT
         jNVGflG1fPBTbYeizOAb/Uq6ieuVslqU2c5rs5znrx0W7XRK1CNWN6mik+1/t0fTdv35
         6MtbcXD8stdqVfOT8YxxLktmPyrriG69bM2osSTG+zZ0Ki6ExwCA874vl4rUdr8usI9z
         YnqZejdFtlC++Xsy300rhlSOvCOH1ICpUOmxucMoJA2ED6hYalgLOYgWWfeVqytH04tq
         jbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8vlxPfdjqDnpKOFwQDs/sHb8PGm43i0NxnYIMcUCHf8=;
        b=qdvE3Yqc/bVxbwQReNpagyWM1s93Vcl6Wc9vTR0ss5ie0OHN2+HAI5C+/IdaPe1CAK
         CdSdyxPa9+979mjc7VHYIrhpYOj39ylvc1t2nXMZl55z/vkx61qDxjHdZZofhJKXN56X
         Qr0waadNqLiey2g99om9mcH5PU3X1a5w3wFmnYWFjpOqXKCNAiyru6nhjSVgg3RWBk61
         wRJIy2jza/F2sl2cnYIjuQVTYCB1f+VLoK+G7FjXOIjn3K8XHz7nCbnKsBhCTgiuvzXd
         pDfDHEB+OSaEjNQ8HrcQmTJhhfiC5lJ6L/E/h5l1v0DW8X+rQE8W/yBz1VxDyRDVCDjU
         vsLQ==
X-Gm-Message-State: APjAAAWkwIFYPjpl0JGNU1Ory+z8FKT+CT4qpf8N9YnQZhIxTVOmxHQu
        tAbqnZUzRhuQJ1MrYyu0NDN63mrn
X-Google-Smtp-Source: APXvYqwrGVfES7gDMUyJ0ZAohIkkuGmuVlCstIWaUWFRG0XYVKT/+oP2XlkBlBWEGdsKAjTtFskX7A==
X-Received: by 2002:a62:2f87:: with SMTP id v129mr18587238pfv.9.1558486176127;
        Tue, 21 May 2019 17:49:36 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j184sm22550121pge.83.2019.05.21.17.49.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 May 2019 17:49:35 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: [PATCH 18/21] lpfc: Fix FDMI fc4type for nvme support
Date:   Tue, 21 May 2019 17:49:08 -0700
Message-Id: <20190522004911.573-19-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190522004911.573-1-jsmart2021@gmail.com>
References: <20190522004911.573-1-jsmart2021@gmail.com>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

FDMI protocol support registration was not accurately showing
nvme support. The fcponly-path clears the parameter object.

Move the code out of the fcponly code path.
Fix the FDMI registration data to properly check for nvme support.
Commonize the manner in which the fdmi routines set protocol
support.

Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_ct.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
index 4812bbbf43cc..ec72c39997d2 100644
--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -2358,6 +2358,7 @@ static int
 lpfc_fdmi_port_attr_fc4type(struct lpfc_vport *vport,
 			    struct lpfc_fdmi_attr_def *ad)
 {
+	struct lpfc_hba   *phba = vport->phba;
 	struct lpfc_fdmi_attr_entry *ae;
 	uint32_t size;
 
@@ -2366,9 +2367,13 @@ lpfc_fdmi_port_attr_fc4type(struct lpfc_vport *vport,
 
 	ae->un.AttrTypes[3] = 0x02; /* Type 0x1 - ELS */
 	ae->un.AttrTypes[2] = 0x01; /* Type 0x8 - FCP */
-	if (vport->nvmei_support || vport->phba->nvmet_support)
-		ae->un.AttrTypes[6] = 0x01; /* Type 0x28 - NVME */
 	ae->un.AttrTypes[7] = 0x01; /* Type 0x20 - CT */
+
+	/* Check to see if Firmware supports NVME and on physical port */
+	if ((phba->sli_rev == LPFC_SLI_REV4) && (vport == phba->pport) &&
+	    phba->sli4_hba.pc_sli4_params.nvme)
+		ae->un.AttrTypes[6] = 0x01; /* Type 0x28 - NVME */
+
 	size = FOURBYTES + 32;
 	ad->AttrLen = cpu_to_be16(size);
 	ad->AttrType = cpu_to_be16(RPRT_SUPPORTED_FC4_TYPES);
@@ -2680,9 +2685,12 @@ lpfc_fdmi_port_attr_active_fc4type(struct lpfc_vport *vport,
 
 	ae->un.AttrTypes[3] = 0x02; /* Type 0x1 - ELS */
 	ae->un.AttrTypes[2] = 0x01; /* Type 0x8 - FCP */
+	ae->un.AttrTypes[7] = 0x01; /* Type 0x20 - CT */
+
+	/* Check to see if NVME is configured or not */
 	if (vport->phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME)
 		ae->un.AttrTypes[6] = 0x1; /* Type 0x28 - NVME */
-	ae->un.AttrTypes[7] = 0x01; /* Type 0x20 - CT */
+
 	size = FOURBYTES + 32;
 	ad->AttrLen = cpu_to_be16(size);
 	ad->AttrType = cpu_to_be16(RPRT_ACTIVE_FC4_TYPES);
-- 
2.13.7

