Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1132B52D280
	for <lists+linux-scsi@lfdr.de>; Thu, 19 May 2022 14:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237939AbiESMba (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 19 May 2022 08:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237848AbiESMbV (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 19 May 2022 08:31:21 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF2F1759F
        for <linux-scsi@vger.kernel.org>; Thu, 19 May 2022 05:31:20 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id q4so4644393plr.11
        for <linux-scsi@vger.kernel.org>; Thu, 19 May 2022 05:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kio7SQB6T9WafpqyDE1ABw14HZ6FvqJqlfJVTDttngc=;
        b=cqVT1ZcSfTmh+Tnun/90BMpRWAOpMGLlkdnApzjVKB3o9+vbE6GjiNTy57cMTWGfCg
         YwK5R8pEtwt8iim8F6qBdz+iHJUhCe0JsvOqNMomQqbX5014OR8GbyRbWaLF0F/jjHhz
         VtmTVBX7bPupJNAxWhEdnoAC7PC1mamuirS04Ti++xf1YcpSJr9kpJt3v/PfdS9iLatR
         0f47R9Ray7Uj5H7iovZj9lxBegL50QpOYG+rU46MXrt2ngjNyUcPdNjRaSsYJTmZEiNp
         15A3slDmH3VkLIy4yErw83z1w1e/KatmpZbonAjs/eKWa8VsRYdnB3rze+ddBd14NK6H
         JAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kio7SQB6T9WafpqyDE1ABw14HZ6FvqJqlfJVTDttngc=;
        b=lrhZioIC1znrXPzs4VnrNKb3rJF7KG6r0OMT3LLQlP4yEfYmpW6j5mdCEwuVTr3UDZ
         5k8FCwBAr11MarYMLiTA/NzAeb/nP6Y0Fv9ctLo/y9rAj73M+W6iUOg/+tdYIavF5gNe
         ybG2/5OlfNHBAA+jyCxF5/2HjnxQ0sb9kN7xx6TFey608AJM32g2/k4OJBh3bWsARFgU
         DVD2Rwg6l1eVkWopAq/pjOiPnpttJhSfhGfuVJU5xeX93LM0UQPH2t2NSbErZIy5ZNSy
         B1ONw6SgI3uMhG+I/vDB36LRShi8fEXoeChQ8BHUEVZw8MNfwQcms00LC23TQlVzHwyx
         7FQQ==
X-Gm-Message-State: AOAM532WoOFUgr7iqpBohy11ckqJL2Qw4HXAC72+PitSoNi7crHEk5wZ
        kAb5+Mc8V6VOZfApKBS/X13gBA+imyg=
X-Google-Smtp-Source: ABdhPJwiY6+J4VB+82SPX6SJcC5YzIv1thh5onQSAe08WmMI7aj7Z15eRTkD1/iyIbLo3CI6gIXymA==
X-Received: by 2002:a17:903:2285:b0:161:c7ed:38f2 with SMTP id b5-20020a170903228500b00161c7ed38f2mr4436098plh.49.1652963479107;
        Thu, 19 May 2022 05:31:19 -0700 (PDT)
Received: from mail-lvn-it-01.broadcom.com (ip174-67-196-173.oc.oc.cox.net. [174.67.196.173])
        by smtp.gmail.com with ESMTPSA id z26-20020aa79e5a000000b005180f4733a8sm3581797pfq.106.2022.05.19.05.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 05:31:18 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Gaurav Srivastava <gaurav.srivastava@broadcom.com>,
        Hannes Reinecke <hare@suse.de>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH v2 2/4] lpfc: commonize VMID code location
Date:   Thu, 19 May 2022 05:31:08 -0700
Message-Id: <20220519123110.17361-3-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220519123110.17361-1-jsmart2021@gmail.com>
References: <20220519123110.17361-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Remove VMID code from its scsi-specific location and move to a new
file solely for VMID code.

Signed-off-by: Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/scsi/lpfc/Makefile    |   2 +-
 drivers/scsi/lpfc/lpfc_crtn.h |   2 +
 drivers/scsi/lpfc/lpfc_scsi.c | 256 ------------------------------
 drivers/scsi/lpfc/lpfc_vmid.c | 288 ++++++++++++++++++++++++++++++++++
 4 files changed, 291 insertions(+), 257 deletions(-)
 create mode 100644 drivers/scsi/lpfc/lpfc_vmid.c

diff --git a/drivers/scsi/lpfc/Makefile b/drivers/scsi/lpfc/Makefile
index 092a971d066b..bbd1faf41e80 100644
--- a/drivers/scsi/lpfc/Makefile
+++ b/drivers/scsi/lpfc/Makefile
@@ -33,4 +33,4 @@ obj-$(CONFIG_SCSI_LPFC) := lpfc.o
 lpfc-objs := lpfc_mem.o lpfc_sli.o lpfc_ct.o lpfc_els.o \
 	lpfc_hbadisc.o	lpfc_init.o lpfc_mbox.o lpfc_nportdisc.o   \
 	lpfc_scsi.o lpfc_attr.o lpfc_vport.o lpfc_debugfs.o lpfc_bsg.o \
-	lpfc_nvme.o lpfc_nvmet.o
+	lpfc_nvme.o lpfc_nvmet.o lpfc_vmid.o
diff --git a/drivers/scsi/lpfc/lpfc_crtn.h b/drivers/scsi/lpfc/lpfc_crtn.h
index b0775be31d5c..913844f01bf5 100644
--- a/drivers/scsi/lpfc/lpfc_crtn.h
+++ b/drivers/scsi/lpfc/lpfc_crtn.h
@@ -671,6 +671,8 @@ int lpfc_vmid_cmd(struct lpfc_vport *vport,
 int lpfc_vmid_hash_fn(const char *vmid, int len);
 struct lpfc_vmid *lpfc_get_vmid_from_hashtable(struct lpfc_vport *vport,
 					      uint32_t hash, uint8_t *buf);
+int lpfc_vmid_get_appid(struct lpfc_vport *vport, char *uuid, struct
+			       scsi_cmnd * cmd, union lpfc_vmid_io_tag *tag);
 void lpfc_vmid_vport_cleanup(struct lpfc_vport *vport);
 int lpfc_issue_els_qfpa(struct lpfc_vport *vport);
 
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index 1d134a01ff3e..70d0a4d3d92e 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -87,14 +87,6 @@ static void
 lpfc_release_scsi_buf_s3(struct lpfc_hba *phba, struct lpfc_io_buf *psb);
 static int
 lpfc_prot_group_type(struct lpfc_hba *phba, struct scsi_cmnd *sc);
-static void
-lpfc_put_vmid_in_hashtable(struct lpfc_vport *vport, u32 hash,
-			   struct lpfc_vmid *vmp);
-static void lpfc_vmid_update_entry(struct lpfc_vport *vport, struct scsi_cmnd
-				   *cmd, struct lpfc_vmid *vmp,
-				   union lpfc_vmid_io_tag *tag);
-static void lpfc_vmid_assign_cs_ctl(struct lpfc_vport *vport,
-				    struct lpfc_vmid *vmid);
 
 /**
  * lpfc_sli4_set_rsp_sgl_last - Set the last bit in the response sge.
@@ -5270,254 +5262,6 @@ void lpfc_poll_timeout(struct timer_list *t)
 	}
 }
 
-/*
- * lpfc_get_vmid_from_hashtable - search the UUID in the hash table
- * @vport: The virtual port for which this call is being executed.
- * @hash: calculated hash value
- * @buf: uuid associated with the VE
- * Return the VMID entry associated with the UUID
- * Make sure to acquire the appropriate lock before invoking this routine.
- */
-struct lpfc_vmid *lpfc_get_vmid_from_hashtable(struct lpfc_vport *vport,
-					      u32 hash, u8 *buf)
-{
-	struct lpfc_vmid *vmp;
-
-	hash_for_each_possible(vport->hash_table, vmp, hnode, hash) {
-		if (memcmp(&vmp->host_vmid[0], buf, 16) == 0)
-			return vmp;
-	}
-	return NULL;
-}
-
-/*
- * lpfc_put_vmid_in_hashtable - put the VMID in the hash table
- * @vport: The virtual port for which this call is being executed.
- * @hash - calculated hash value
- * @vmp: Pointer to a VMID entry representing a VM sending I/O
- *
- * This routine will insert the newly acquired VMID entity in the hash table.
- * Make sure to acquire the appropriate lock before invoking this routine.
- */
-static void
-lpfc_put_vmid_in_hashtable(struct lpfc_vport *vport, u32 hash,
-			   struct lpfc_vmid *vmp)
-{
-	hash_add(vport->hash_table, &vmp->hnode, hash);
-}
-
-/*
- * lpfc_vmid_hash_fn - create a hash value of the UUID
- * @vmid: uuid associated with the VE
- * @len: length of the VMID string
- * Returns the calculated hash value
- */
-int lpfc_vmid_hash_fn(const char *vmid, int len)
-{
-	int c;
-	int hash = 0;
-
-	if (len == 0)
-		return 0;
-	while (len--) {
-		c = *vmid++;
-		if (c >= 'A' && c <= 'Z')
-			c += 'a' - 'A';
-
-		hash = (hash + (c << LPFC_VMID_HASH_SHIFT) +
-			(c >> LPFC_VMID_HASH_SHIFT)) * 19;
-	}
-
-	return hash & LPFC_VMID_HASH_MASK;
-}
-
-/*
- * lpfc_vmid_update_entry - update the vmid entry in the hash table
- * @vport: The virtual port for which this call is being executed.
- * @cmd: address of scsi cmd descriptor
- * @vmp: Pointer to a VMID entry representing a VM sending I/O
- * @tag: VMID tag
- */
-static void lpfc_vmid_update_entry(struct lpfc_vport *vport, struct scsi_cmnd
-				   *cmd, struct lpfc_vmid *vmp,
-				   union lpfc_vmid_io_tag *tag)
-{
-	u64 *lta;
-
-	if (vport->phba->pport->vmid_flag & LPFC_VMID_TYPE_PRIO)
-		tag->cs_ctl_vmid = vmp->un.cs_ctl_vmid;
-	else if (vport->phba->cfg_vmid_app_header)
-		tag->app_id = vmp->un.app_id;
-
-	if (cmd->sc_data_direction == DMA_TO_DEVICE)
-		vmp->io_wr_cnt++;
-	else
-		vmp->io_rd_cnt++;
-
-	/* update the last access timestamp in the table */
-	lta = per_cpu_ptr(vmp->last_io_time, raw_smp_processor_id());
-	*lta = jiffies;
-}
-
-static void lpfc_vmid_assign_cs_ctl(struct lpfc_vport *vport,
-				    struct lpfc_vmid *vmid)
-{
-	u32 hash;
-	struct lpfc_vmid *pvmid;
-
-	if (vport->port_type == LPFC_PHYSICAL_PORT) {
-		vmid->un.cs_ctl_vmid = lpfc_vmid_get_cs_ctl(vport);
-	} else {
-		hash = lpfc_vmid_hash_fn(vmid->host_vmid, vmid->vmid_len);
-		pvmid =
-		    lpfc_get_vmid_from_hashtable(vport->phba->pport, hash,
-						vmid->host_vmid);
-		if (pvmid)
-			vmid->un.cs_ctl_vmid = pvmid->un.cs_ctl_vmid;
-		else
-			vmid->un.cs_ctl_vmid = lpfc_vmid_get_cs_ctl(vport);
-	}
-}
-
-/*
- * lpfc_vmid_get_appid - get the VMID associated with the UUID
- * @vport: The virtual port for which this call is being executed.
- * @uuid: UUID associated with the VE
- * @cmd: address of scsi_cmd descriptor
- * @tag: VMID tag
- * Returns status of the function
- */
-static int lpfc_vmid_get_appid(struct lpfc_vport *vport, char *uuid, struct
-			       scsi_cmnd * cmd, union lpfc_vmid_io_tag *tag)
-{
-	struct lpfc_vmid *vmp = NULL;
-	int hash, len, rc = -EPERM, i;
-
-	/* check if QFPA is complete */
-	if (lpfc_vmid_is_type_priority_tag(vport) &&
-	    !(vport->vmid_flag & LPFC_VMID_QFPA_CMPL) &&
-	    (vport->vmid_flag & LPFC_VMID_ISSUE_QFPA)) {
-		vport->work_port_events |= WORKER_CHECK_VMID_ISSUE_QFPA;
-		return -EAGAIN;
-	}
-
-	/* search if the UUID has already been mapped to the VMID */
-	len = strlen(uuid);
-	hash = lpfc_vmid_hash_fn(uuid, len);
-
-	/* search for the VMID in the table */
-	read_lock(&vport->vmid_lock);
-	vmp = lpfc_get_vmid_from_hashtable(vport, hash, uuid);
-
-	/* if found, check if its already registered  */
-	if (vmp  && vmp->flag & LPFC_VMID_REGISTERED) {
-		read_unlock(&vport->vmid_lock);
-		lpfc_vmid_update_entry(vport, cmd, vmp, tag);
-		rc = 0;
-	} else if (vmp && (vmp->flag & LPFC_VMID_REQ_REGISTER ||
-			   vmp->flag & LPFC_VMID_DE_REGISTER)) {
-		/* else if register or dereg request has already been sent */
-		/* Hence VMID tag will not be added for this I/O */
-		read_unlock(&vport->vmid_lock);
-		rc = -EBUSY;
-	} else {
-		/* The VMID was not found in the hashtable. At this point, */
-		/* drop the read lock first before proceeding further */
-		read_unlock(&vport->vmid_lock);
-		/* start the process to obtain one as per the */
-		/* type of the VMID indicated */
-		write_lock(&vport->vmid_lock);
-		vmp = lpfc_get_vmid_from_hashtable(vport, hash, uuid);
-
-		/* while the read lock was released, in case the entry was */
-		/* added by other context or is in process of being added */
-		if (vmp && vmp->flag & LPFC_VMID_REGISTERED) {
-			lpfc_vmid_update_entry(vport, cmd, vmp, tag);
-			write_unlock(&vport->vmid_lock);
-			return 0;
-		} else if (vmp && vmp->flag & LPFC_VMID_REQ_REGISTER) {
-			write_unlock(&vport->vmid_lock);
-			return -EBUSY;
-		}
-
-		/* else search and allocate a free slot in the hash table */
-		if (vport->cur_vmid_cnt < vport->max_vmid) {
-			for (i = 0; i < vport->max_vmid; i++) {
-				vmp = vport->vmid + i;
-				if (vmp->flag == LPFC_VMID_SLOT_FREE)
-					break;
-			}
-			if (i == vport->max_vmid)
-				vmp = NULL;
-		} else {
-			vmp = NULL;
-		}
-
-		if (!vmp) {
-			write_unlock(&vport->vmid_lock);
-			return -ENOMEM;
-		}
-
-		/* Add the vmid and register */
-		lpfc_put_vmid_in_hashtable(vport, hash, vmp);
-		vmp->vmid_len = len;
-		memcpy(vmp->host_vmid, uuid, vmp->vmid_len);
-		vmp->io_rd_cnt = 0;
-		vmp->io_wr_cnt = 0;
-		vmp->flag = LPFC_VMID_SLOT_USED;
-
-		vmp->delete_inactive =
-			vport->vmid_inactivity_timeout ? 1 : 0;
-
-		/* if type priority tag, get next available VMID */
-		if (vport->phba->pport->vmid_flag & LPFC_VMID_TYPE_PRIO)
-			lpfc_vmid_assign_cs_ctl(vport, vmp);
-
-		/* allocate the per cpu variable for holding */
-		/* the last access time stamp only if VMID is enabled */
-		if (!vmp->last_io_time)
-			vmp->last_io_time = __alloc_percpu(sizeof(u64),
-							   __alignof__(struct
-							   lpfc_vmid));
-		if (!vmp->last_io_time) {
-			hash_del(&vmp->hnode);
-			vmp->flag = LPFC_VMID_SLOT_FREE;
-			write_unlock(&vport->vmid_lock);
-			return -EIO;
-		}
-
-		write_unlock(&vport->vmid_lock);
-
-		/* complete transaction with switch */
-		if (vport->phba->pport->vmid_flag & LPFC_VMID_TYPE_PRIO)
-			rc = lpfc_vmid_uvem(vport, vmp, true);
-		else if (vport->phba->cfg_vmid_app_header)
-			rc = lpfc_vmid_cmd(vport, SLI_CTAS_RAPP_IDENT, vmp);
-		if (!rc) {
-			write_lock(&vport->vmid_lock);
-			vport->cur_vmid_cnt++;
-			vmp->flag |= LPFC_VMID_REQ_REGISTER;
-			write_unlock(&vport->vmid_lock);
-		} else {
-			write_lock(&vport->vmid_lock);
-			hash_del(&vmp->hnode);
-			vmp->flag = LPFC_VMID_SLOT_FREE;
-			free_percpu(vmp->last_io_time);
-			write_unlock(&vport->vmid_lock);
-			return -EIO;
-		}
-
-		/* finally, enable the idle timer once */
-		if (!(vport->phba->pport->vmid_flag & LPFC_VMID_TIMER_ENBLD)) {
-			mod_timer(&vport->phba->inactive_vmid_poll,
-				  jiffies +
-				  msecs_to_jiffies(1000 * LPFC_VMID_TIMER));
-			vport->phba->pport->vmid_flag |= LPFC_VMID_TIMER_ENBLD;
-		}
-	}
-	return rc;
-}
-
 /*
  * lpfc_is_command_vm_io - get the UUID from blk cgroup
  * @cmd: Pointer to scsi_cmnd data structure
diff --git a/drivers/scsi/lpfc/lpfc_vmid.c b/drivers/scsi/lpfc/lpfc_vmid.c
new file mode 100644
index 000000000000..f64ced04b912
--- /dev/null
+++ b/drivers/scsi/lpfc/lpfc_vmid.c
@@ -0,0 +1,288 @@
+/*******************************************************************
+ * This file is part of the Emulex Linux Device Driver for         *
+ * Fibre Channel Host Bus Adapters.                                *
+ * Copyright (C) 2017-2022 Broadcom. All Rights Reserved. The term *
+ * “Broadcom” refers to Broadcom Inc. and/or its subsidiaries.     *
+ * Copyright (C) 2004-2016 Emulex.  All rights reserved.           *
+ * EMULEX and SLI are trademarks of Emulex.                        *
+ * www.broadcom.com                                                *
+ * Portions Copyright (C) 2004-2005 Christoph Hellwig              *
+ *                                                                 *
+ * This program is free software; you can redistribute it and/or   *
+ * modify it under the terms of version 2 of the GNU General       *
+ * Public License as published by the Free Software Foundation.    *
+ * This program is distributed in the hope that it will be useful. *
+ * ALL EXPRESS OR IMPLIED CONDITIONS, REPRESENTATIONS AND          *
+ * WARRANTIES, INCLUDING ANY IMPLIED WARRANTY OF MERCHANTABILITY,  *
+ * FITNESS FOR A PARTICULAR PURPOSE, OR NON-INFRINGEMENT, ARE      *
+ * DISCLAIMED, EXCEPT TO THE EXTENT THAT SUCH DISCLAIMERS ARE HELD *
+ * TO BE LEGALLY INVALID.  See the GNU General Public License for  *
+ * more details, a copy of which can be found in the file COPYING  *
+ * included with this package.                                     *
+ *******************************************************************/
+
+#include <linux/interrupt.h>
+#include <linux/dma-direction.h>
+
+#include <scsi/scsi_transport_fc.h>
+
+#include "lpfc_hw4.h"
+#include "lpfc_hw.h"
+#include "lpfc_sli.h"
+#include "lpfc_sli4.h"
+#include "lpfc_nl.h"
+#include "lpfc_disc.h"
+#include "lpfc.h"
+#include "lpfc_crtn.h"
+
+
+/*
+ * lpfc_get_vmid_from_hashtable - search the UUID in the hash table
+ * @vport: The virtual port for which this call is being executed.
+ * @hash: calculated hash value
+ * @buf: uuid associated with the VE
+ * Return the VMID entry associated with the UUID
+ * Make sure to acquire the appropriate lock before invoking this routine.
+ */
+struct lpfc_vmid *lpfc_get_vmid_from_hashtable(struct lpfc_vport *vport,
+					       u32 hash, u8 *buf)
+{
+	struct lpfc_vmid *vmp;
+
+	hash_for_each_possible(vport->hash_table, vmp, hnode, hash) {
+		if (memcmp(&vmp->host_vmid[0], buf, 16) == 0)
+			return vmp;
+	}
+	return NULL;
+}
+
+/*
+ * lpfc_put_vmid_in_hashtable - put the VMID in the hash table
+ * @vport: The virtual port for which this call is being executed.
+ * @hash - calculated hash value
+ * @vmp: Pointer to a VMID entry representing a VM sending I/O
+ *
+ * This routine will insert the newly acquired VMID entity in the hash table.
+ * Make sure to acquire the appropriate lock before invoking this routine.
+ */
+static void
+lpfc_put_vmid_in_hashtable(struct lpfc_vport *vport, u32 hash,
+			   struct lpfc_vmid *vmp)
+{
+	hash_add(vport->hash_table, &vmp->hnode, hash);
+}
+
+/*
+ * lpfc_vmid_hash_fn - create a hash value of the UUID
+ * @vmid: uuid associated with the VE
+ * @len: length of the VMID string
+ * Returns the calculated hash value
+ */
+int lpfc_vmid_hash_fn(const char *vmid, int len)
+{
+	int c;
+	int hash = 0;
+
+	if (len == 0)
+		return 0;
+	while (len--) {
+		c = *vmid++;
+		if (c >= 'A' && c <= 'Z')
+			c += 'a' - 'A';
+
+		hash = (hash + (c << LPFC_VMID_HASH_SHIFT) +
+			(c >> LPFC_VMID_HASH_SHIFT)) * 19;
+	}
+
+	return hash & LPFC_VMID_HASH_MASK;
+}
+
+/*
+ * lpfc_vmid_update_entry - update the vmid entry in the hash table
+ * @vport: The virtual port for which this call is being executed.
+ * @iodir: io direction
+ * @vmp: Pointer to a VMID entry representing a VM sending I/O
+ * @tag: VMID tag
+ */
+static void lpfc_vmid_update_entry(struct lpfc_vport *vport,
+				   enum dma_data_direction iodir,
+				   struct lpfc_vmid *vmp,
+				   union lpfc_vmid_io_tag *tag)
+{
+	u64 *lta;
+
+	if (vport->phba->pport->vmid_flag & LPFC_VMID_TYPE_PRIO)
+		tag->cs_ctl_vmid = vmp->un.cs_ctl_vmid;
+	else if (vport->phba->cfg_vmid_app_header)
+		tag->app_id = vmp->un.app_id;
+
+	if (iodir == DMA_TO_DEVICE)
+		vmp->io_wr_cnt++;
+	else if (iodir == DMA_FROM_DEVICE)
+		vmp->io_rd_cnt++;
+
+	/* update the last access timestamp in the table */
+	lta = per_cpu_ptr(vmp->last_io_time, raw_smp_processor_id());
+	*lta = jiffies;
+}
+
+static void lpfc_vmid_assign_cs_ctl(struct lpfc_vport *vport,
+				    struct lpfc_vmid *vmid)
+{
+	u32 hash;
+	struct lpfc_vmid *pvmid;
+
+	if (vport->port_type == LPFC_PHYSICAL_PORT) {
+		vmid->un.cs_ctl_vmid = lpfc_vmid_get_cs_ctl(vport);
+	} else {
+		hash = lpfc_vmid_hash_fn(vmid->host_vmid, vmid->vmid_len);
+		pvmid =
+		    lpfc_get_vmid_from_hashtable(vport->phba->pport, hash,
+						 vmid->host_vmid);
+		if (pvmid)
+			vmid->un.cs_ctl_vmid = pvmid->un.cs_ctl_vmid;
+		else
+			vmid->un.cs_ctl_vmid = lpfc_vmid_get_cs_ctl(vport);
+	}
+}
+
+/*
+ * lpfc_vmid_get_appid - get the VMID associated with the UUID
+ * @vport: The virtual port for which this call is being executed.
+ * @uuid: UUID associated with the VE
+ * @cmd: address of scsi_cmd descriptor
+ * @iodir: io direction
+ * @tag: VMID tag
+ * Returns status of the function
+ */
+int lpfc_vmid_get_appid(struct lpfc_vport *vport, char *uuid,
+			enum dma_data_direction iodir,
+			union lpfc_vmid_io_tag *tag)
+{
+	struct lpfc_vmid *vmp = NULL;
+	int hash, len, rc = -EPERM, i;
+
+	/* check if QFPA is complete */
+	if (lpfc_vmid_is_type_priority_tag(vport) &&
+	    !(vport->vmid_flag & LPFC_VMID_QFPA_CMPL) &&
+	    (vport->vmid_flag & LPFC_VMID_ISSUE_QFPA)) {
+		vport->work_port_events |= WORKER_CHECK_VMID_ISSUE_QFPA;
+		return -EAGAIN;
+	}
+
+	/* search if the UUID has already been mapped to the VMID */
+	len = strlen(uuid);
+	hash = lpfc_vmid_hash_fn(uuid, len);
+
+	/* search for the VMID in the table */
+	read_lock(&vport->vmid_lock);
+	vmp = lpfc_get_vmid_from_hashtable(vport, hash, uuid);
+
+	/* if found, check if its already registered  */
+	if (vmp  && vmp->flag & LPFC_VMID_REGISTERED) {
+		read_unlock(&vport->vmid_lock);
+		lpfc_vmid_update_entry(vport, iodir, vmp, tag);
+		rc = 0;
+	} else if (vmp && (vmp->flag & LPFC_VMID_REQ_REGISTER ||
+			   vmp->flag & LPFC_VMID_DE_REGISTER)) {
+		/* else if register or dereg request has already been sent */
+		/* Hence VMID tag will not be added for this I/O */
+		read_unlock(&vport->vmid_lock);
+		rc = -EBUSY;
+	} else {
+		/* The VMID was not found in the hashtable. At this point, */
+		/* drop the read lock first before proceeding further */
+		read_unlock(&vport->vmid_lock);
+		/* start the process to obtain one as per the */
+		/* type of the VMID indicated */
+		write_lock(&vport->vmid_lock);
+		vmp = lpfc_get_vmid_from_hashtable(vport, hash, uuid);
+
+		/* while the read lock was released, in case the entry was */
+		/* added by other context or is in process of being added */
+		if (vmp && vmp->flag & LPFC_VMID_REGISTERED) {
+			lpfc_vmid_update_entry(vport, iodir, vmp, tag);
+			write_unlock(&vport->vmid_lock);
+			return 0;
+		} else if (vmp && vmp->flag & LPFC_VMID_REQ_REGISTER) {
+			write_unlock(&vport->vmid_lock);
+			return -EBUSY;
+		}
+
+		/* else search and allocate a free slot in the hash table */
+		if (vport->cur_vmid_cnt < vport->max_vmid) {
+			for (i = 0; i < vport->max_vmid; i++) {
+				vmp = vport->vmid + i;
+				if (vmp->flag == LPFC_VMID_SLOT_FREE)
+					break;
+			}
+			if (i == vport->max_vmid)
+				vmp = NULL;
+		} else {
+			vmp = NULL;
+		}
+
+		if (!vmp) {
+			write_unlock(&vport->vmid_lock);
+			return -ENOMEM;
+		}
+
+		/* Add the vmid and register */
+		lpfc_put_vmid_in_hashtable(vport, hash, vmp);
+		vmp->vmid_len = len;
+		memcpy(vmp->host_vmid, uuid, vmp->vmid_len);
+		vmp->io_rd_cnt = 0;
+		vmp->io_wr_cnt = 0;
+		vmp->flag = LPFC_VMID_SLOT_USED;
+
+		vmp->delete_inactive =
+			vport->vmid_inactivity_timeout ? 1 : 0;
+
+		/* if type priority tag, get next available VMID */
+		if (vport->phba->pport->vmid_flag & LPFC_VMID_TYPE_PRIO)
+			lpfc_vmid_assign_cs_ctl(vport, vmp);
+
+		/* allocate the per cpu variable for holding */
+		/* the last access time stamp only if VMID is enabled */
+		if (!vmp->last_io_time)
+			vmp->last_io_time = __alloc_percpu(sizeof(u64),
+							   __alignof__(struct
+							   lpfc_vmid));
+		if (!vmp->last_io_time) {
+			hash_del(&vmp->hnode);
+			vmp->flag = LPFC_VMID_SLOT_FREE;
+			write_unlock(&vport->vmid_lock);
+			return -EIO;
+		}
+
+		write_unlock(&vport->vmid_lock);
+
+		/* complete transaction with switch */
+		if (vport->phba->pport->vmid_flag & LPFC_VMID_TYPE_PRIO)
+			rc = lpfc_vmid_uvem(vport, vmp, true);
+		else if (vport->phba->cfg_vmid_app_header)
+			rc = lpfc_vmid_cmd(vport, SLI_CTAS_RAPP_IDENT, vmp);
+		if (!rc) {
+			write_lock(&vport->vmid_lock);
+			vport->cur_vmid_cnt++;
+			vmp->flag |= LPFC_VMID_REQ_REGISTER;
+			write_unlock(&vport->vmid_lock);
+		} else {
+			write_lock(&vport->vmid_lock);
+			hash_del(&vmp->hnode);
+			vmp->flag = LPFC_VMID_SLOT_FREE;
+			free_percpu(vmp->last_io_time);
+			write_unlock(&vport->vmid_lock);
+			return -EIO;
+		}
+
+		/* finally, enable the idle timer once */
+		if (!(vport->phba->pport->vmid_flag & LPFC_VMID_TIMER_ENBLD)) {
+			mod_timer(&vport->phba->inactive_vmid_poll,
+				  jiffies +
+				  msecs_to_jiffies(1000 * LPFC_VMID_TIMER));
+			vport->phba->pport->vmid_flag |= LPFC_VMID_TIMER_ENBLD;
+		}
+	}
+	return rc;
+}
-- 
2.26.2

