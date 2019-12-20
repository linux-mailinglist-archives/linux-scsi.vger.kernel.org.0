Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2C712850C
	for <lists+linux-scsi@lfdr.de>; Fri, 20 Dec 2019 23:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfLTWiC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 20 Dec 2019 17:38:02 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:41134 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfLTWiC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 20 Dec 2019 17:38:02 -0500
Received: by mail-pl1-f178.google.com with SMTP id bd4so4708497plb.8
        for <linux-scsi@vger.kernel.org>; Fri, 20 Dec 2019 14:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q5Tm5tghx9q1OnmYYaowYo00oEHOWvO6q6lQbOubEgM=;
        b=VuTWIrg6ZMmuFfIrDisAqIG0wIi5uF720NHIKSt0GxMJP/W6i60mM1uuSWADpwJaWm
         lSDntUU3wiUMOrDLVog5b5qRUby7iD1z3BL+gi094MQt2V0PA7g6CVo/Ak89iTwt+MEd
         VVy0X2QXoa63nknHmGKQGS+CsUyM/KD7NvfceR10haDp7Kw/lfiz66u3Kx8mGtNnLoQT
         6Sf3+1dp84EGOeBRL77EI9kuxk0NagwdyaR2LyP4QMc1Hg6zuZwH7xr+jWKZELuZmMrB
         HUbRP7n8PGAIQyIS1B1ACfjuwFr/oAdKVw4hMD1z29bx5EogoB807B3KSbXcgVVT5K7e
         YjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q5Tm5tghx9q1OnmYYaowYo00oEHOWvO6q6lQbOubEgM=;
        b=H2eFxZf+/+FDDw4aetcmfK7hPRaowEowyuas/wsmYCwmCvH/83JRXypp34svT1jRNy
         PNSKB55Lt/L/nJO3M1RDV255JEakHWmwD6mQYEgtYDUVSBwhsczVHi0Re5YR/L36FqUF
         WwiIk11h24k5PTpBzp8K8eVc0WwbVccliNyHIhnZwcxmK7LgF2HaE+2r/pMbJ+ynjo6e
         IZmhINGfp2IcVvNzRvOK01kQr4uV+zw1Zr9iWbnL1jhOFCacbGsleq61Bq6W4oWoftQs
         GiKrBd41WWUqflF4WZs81JERDA2LPXv2AXNpWVNOXuujrCmr1MZn492nnN9QA/Kf14l7
         gyqw==
X-Gm-Message-State: APjAAAWCRv+uxIpRyl9EWbjhHaVnYsTs400tBEVlufIonnZ/6zkdGWfV
        FB6DvFqTaP8toGm5tFhKNGz+CXRK
X-Google-Smtp-Source: APXvYqypVt8E5M0XnPnOJzKe7OQJiqlaGDiIHalMTUgwA+szzywGBx6JRHJDLIdAiBj6qi0CbGayWg==
X-Received: by 2002:a17:90a:9bc3:: with SMTP id b3mr6058164pjw.64.1576881479391;
        Fri, 20 Dec 2019 14:37:59 -0800 (PST)
Received: from os42.localdomain ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j28sm12219877pgb.36.2019.12.20.14.37.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Dec 2019 14:37:58 -0800 (PST)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     maier@linux.ibm.com, dwagner@suse.de, bvanassche@acm.org,
        James Smart <jsmart2021@gmail.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>
Subject: [PATCH v2 24/32] elx: efct: LIO backend interface routines
Date:   Fri, 20 Dec 2019 14:37:15 -0800
Message-Id: <20191220223723.26563-25-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20191220223723.26563-1-jsmart2021@gmail.com>
References: <20191220223723.26563-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This patch continues the efct driver population.

This patch adds driver definitions for:
LIO backend template registration and template functions.

Signed-off-by: Ram Vegesna <ram.vegesna@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/elx/efct/efct_lio.c | 1921 ++++++++++++++++++++++++++++++++++++++
 drivers/scsi/elx/efct/efct_lio.h |  192 ++++
 2 files changed, 2113 insertions(+)
 create mode 100644 drivers/scsi/elx/efct/efct_lio.c
 create mode 100644 drivers/scsi/elx/efct/efct_lio.h

diff --git a/drivers/scsi/elx/efct/efct_lio.c b/drivers/scsi/elx/efct/efct_lio.c
new file mode 100644
index 000000000000..89bd8c0efb24
--- /dev/null
+++ b/drivers/scsi/elx/efct/efct_lio.c
@@ -0,0 +1,1921 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019 Broadcom. All Rights Reserved. The term
+ * “Broadcom” refers to Broadcom Inc. and/or its subsidiaries.
+ */
+
+#include "efct_driver.h"
+
+#include <scsi/scsi_tcq.h>
+#include <target/target_core_base.h>
+#include <target/target_core_fabric.h>
+
+#include "efct_lio.h"
+
+static struct workqueue_struct *lio_wq;
+
+static int
+efct_format_wwn(char *str, size_t len, char *pre, u64 wwn)
+{
+	u8 a[8];
+
+	put_unaligned_be64(wwn, a);
+	return snprintf(str, len,
+			"%s%02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x",
+			pre, a[0], a[1], a[2], a[3], a[4], a[5], a[6], a[7]);
+}
+
+static int
+efct_lio_parse_wwn(const char *name, u64 *wwp, u8 npiv)
+{
+	int a[8], num;
+	u8 b[8];
+
+	if (npiv) {
+		num = sscanf(name, "%02x%02x%02x%02x%02x%02x%02x%02x",
+			     &a[0], &a[1], &a[2], &a[3], &a[4],
+				 &a[5], &a[6], &a[7]);
+	} else {
+		num = sscanf(name,
+			     "%02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x",
+			     &a[0], &a[1], &a[2], &a[3], &a[4],
+			     &a[5], &a[6], &a[7]);
+	}
+
+	if (num != 8)
+		return -EINVAL;
+
+	for (num = 0; num < 8; ++num)
+		b[num] = (u8) a[num];
+
+	*wwp = get_unaligned_be64(b);
+	return 0;
+}
+
+static int
+efct_lio_parse_npiv_wwn(const char *name, size_t size, u64 *wwpn, u64 *wwnn)
+{
+	unsigned int cnt = size;
+	int rc;
+
+	*wwpn = *wwnn = 0;
+	if (name[cnt - 1] == '\n' || name[cnt - 1] == 0)
+		cnt--;
+
+	/* validate we have enough characters for WWPN */
+	if ((cnt != (16 + 1 + 16)) || (name[16] != ':'))
+		return -EINVAL;
+
+	rc = efct_lio_parse_wwn(&name[0], wwpn, 1);
+	if (rc)
+		return rc;
+
+	rc = efct_lio_parse_wwn(&name[17], wwnn, 1);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static ssize_t
+efct_lio_tpg_enable_show(struct config_item *item, char *page)
+{
+	struct se_portal_group *se_tpg = to_tpg(item);
+	struct efct_lio_tpg *tpg = container_of(se_tpg,
+						struct efct_lio_tpg, tpg);
+
+	return snprintf(page, PAGE_SIZE, "%d\n", atomic_read(&tpg->enabled));
+}
+
+static ssize_t
+efct_lio_tpg_enable_store(struct config_item *item, const char *page,
+			  size_t count)
+{
+	struct se_portal_group *se_tpg = to_tpg(item);
+	struct efct_lio_tpg *tpg = container_of(se_tpg,
+						struct efct_lio_tpg, tpg);
+	struct efct *efct;
+	struct efc *efc;
+	unsigned long op;
+	int ret;
+
+	if (!tpg->sport || !tpg->sport->efct) {
+		pr_err("%s: Unable to find EFCT device\n", __func__);
+		return -EINVAL;
+	}
+
+	efct = tpg->sport->efct;
+	efc = efct->efcport;
+
+	if (kstrtoul(page, 0, &op) < 0)
+		return -EINVAL;
+
+	if (op == 1) {
+		atomic_set(&tpg->enabled, 1);
+		efc_log_debug(efct, "enable portal group %d\n", tpg->tpgt);
+
+		ret = efct_xport_control(efct->xport, EFCT_XPORT_PORT_ONLINE);
+		if (ret) {
+			efct->tgt_efct.lio_sport = NULL;
+			efc_log_test(efct, "cannot bring port online\n");
+			return ret;
+		}
+	} else if (op == 0) {
+		efc_log_debug(efct, "disable portal group %d\n", tpg->tpgt);
+
+		if (efc->domain && efc->domain->sport)
+			efct_scsi_tgt_del_sport(efc, efc->domain->sport);
+
+		atomic_set(&tpg->enabled, 0);
+	} else {
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+static ssize_t
+efct_lio_npiv_tpg_enable_show(struct config_item *item, char *page)
+{
+	struct se_portal_group *se_tpg = to_tpg(item);
+	struct efct_lio_tpg *tpg = container_of(se_tpg,
+						struct efct_lio_tpg, tpg);
+
+	return snprintf(page, PAGE_SIZE, "%d\n", atomic_read(&tpg->enabled));
+}
+
+static ssize_t
+efct_lio_npiv_tpg_enable_store(struct config_item *item, const char *page,
+			       size_t count)
+{
+	struct se_portal_group *se_tpg = to_tpg(item);
+	struct efct_lio_tpg *tpg = container_of(se_tpg,
+						struct efct_lio_tpg, tpg);
+	struct efct_lio_vport *lio_vport = tpg->vport;
+	struct efct_lio_vport_data_t *vport_data;
+	struct efct *efct;
+	struct efc *efc;
+	int ret = -1;
+	unsigned long op, flags = 0;
+
+	if (kstrtoul(page, 0, &op) < 0)
+		return -EINVAL;
+
+	if (!lio_vport) {
+		pr_err("Unable to find vport\n");
+		return -EINVAL;
+	}
+
+	efct = lio_vport->efct;
+	efc = efct->efcport;
+
+	if (op == 1) {
+		atomic_set(&tpg->enabled, 1);
+		efc_log_debug(efct, "enable portal group %d\n", tpg->tpgt);
+
+		if (efc->domain) {
+			ret = efc_sport_vport_new(efc->domain,
+						  lio_vport->npiv_wwpn,
+						  lio_vport->npiv_wwnn,
+						  U32_MAX, false, true,
+						  NULL, NULL, true);
+			if (ret != 0) {
+				efc_log_err(efct, "Failed to create Vport\n");
+				return ret;
+			}
+			return count;
+		}
+
+		vport_data = kmalloc(sizeof(*vport_data), GFP_KERNEL);
+		if (!vport_data)
+			return ret;
+
+		memset(vport_data, 0, sizeof(struct efct_lio_vport_data_t));
+		vport_data->phy_wwpn            = lio_vport->wwpn;
+		vport_data->vport_wwpn          = lio_vport->npiv_wwpn;
+		vport_data->vport_wwnn          = lio_vport->npiv_wwnn;
+		vport_data->target_mode         = 1;
+		vport_data->initiator_mode      = 0;
+		vport_data->lio_vport           = lio_vport;
+
+		/* There is no domain.  Add to pending list. When the
+		 * domain is created, the driver will create the vport.
+		 */
+		efc_log_debug(efct, "link down, move to pending\n");
+		spin_lock_irqsave(&efct->tgt_efct.efct_lio_lock, flags);
+		INIT_LIST_HEAD(&vport_data->list_entry);
+		list_add_tail(&vport_data->list_entry,
+			      &efct->tgt_efct.vport_pend_list);
+		spin_unlock_irqrestore(&efct->tgt_efct.efct_lio_lock, flags);
+
+	} else if (op == 0) {
+		struct efct_lio_vport_data_t *virt_target_data, *next;
+
+		efc_log_debug(efct, "disable portal group %d\n", tpg->tpgt);
+
+		atomic_set(&tpg->enabled, 0);
+		/* only physical sport should exist, free lio_sport
+		 * allocated in efct_lio_make_sport
+		 */
+		if (efc->domain) {
+			efc_sport_vport_del(efct->efcport, efc->domain,
+					    lio_vport->npiv_wwpn,
+					    lio_vport->npiv_wwnn);
+			return count;
+		}
+		spin_lock_irqsave(&efct->tgt_efct.efct_lio_lock, flags);
+		list_for_each_entry_safe(virt_target_data, next,
+					 &efct->tgt_efct.vport_pend_list,
+					 list_entry) {
+			if (virt_target_data->lio_vport == lio_vport) {
+				list_del(&virt_target_data->list_entry);
+				kfree(virt_target_data);
+				break;
+			}
+		}
+		spin_unlock_irqrestore(&efct->tgt_efct.efct_lio_lock, flags);
+	} else {
+		return -EINVAL;
+	}
+	return count;
+}
+
+static bool efct_lio_node_is_initiator(struct efc_node *node)
+{
+	if (!node)
+		return 0;
+
+	if (node->rnode.fc_id && node->rnode.fc_id != FC_FID_FLOGI &&
+	    node->rnode.fc_id != FC_FID_DIR_SERV &&
+	    node->rnode.fc_id != FC_FID_FCTRL) {
+		return 1;
+	}
+
+	return 0;
+}
+
+static int  efct_lio_tgt_session_data(struct efct *efct, u64 wwpn,
+				      char *buf, int size)
+{
+	struct efc_sli_port *sport = NULL;
+	struct efc_node *node = NULL;
+	struct efc *efc = efct->efcport;
+	u16 loop_id = 0;
+	int off = 0, rc = 0;
+
+	if (!efc->domain) {
+		efc_log_err(efct, "failed to find efct/domain\n");
+		return -1;
+	}
+
+	list_for_each_entry(sport, &efc->domain->sport_list, list_entry) {
+		if (sport->wwpn != wwpn)
+			continue;
+		list_for_each_entry(node, &sport->node_list,
+				    list_entry) {
+			/* Dump only remote NPORT sessions */
+			if (!efct_lio_node_is_initiator(node))
+				continue;
+
+			rc = snprintf(buf + off, size - off,
+				"0x%016llx,0x%08x,0x%04x\n",
+				get_unaligned_be64(node->wwpn),
+				node->rnode.fc_id, loop_id);
+			if (rc < 0)
+				break;
+			off += rc;
+		}
+	}
+
+	buf[size - 1] = '\0';
+	return 0;
+}
+
+static int efct_debugfs_session_open(struct inode *inode, struct file *filp)
+{
+	struct efct_lio_sport *sport = inode->i_private;
+	int size = 17 * PAGE_SIZE; /* 34 byte per session*2048 sessions */
+
+	if (!(filp->f_mode & FMODE_READ)) {
+		filp->private_data = sport;
+		return 0;
+	}
+
+	filp->private_data = kmalloc(size, GFP_KERNEL);
+	if (!filp->private_data)
+		return -ENOMEM;
+
+	memset(filp->private_data, 0, size);
+	efct_lio_tgt_session_data(sport->efct, sport->wwpn, filp->private_data,
+				  size);
+	return 0;
+}
+
+static int efct_debugfs_session_close(struct inode *inode, struct file *filp)
+{
+	if (filp->f_mode & FMODE_READ)
+		kfree(filp->private_data);
+
+	return 0;
+}
+
+static ssize_t efct_debugfs_session_read(struct file *filp, char __user *buf,
+					 size_t count, loff_t *ppos)
+{
+	if (!(filp->f_mode & FMODE_READ))
+		return -EPERM;
+	return simple_read_from_buffer(buf, count, ppos, filp->private_data,
+				       strlen(filp->private_data));
+}
+
+static int efct_npiv_debugfs_session_open(struct inode *inode,
+					  struct file *filp)
+{
+	struct efct_lio_vport *sport = inode->i_private;
+	int size = 17 * PAGE_SIZE; /* 34 byte per session*2048 sessions */
+
+	if (!(filp->f_mode & FMODE_READ)) {
+		filp->private_data = sport;
+		return 0;
+	}
+
+	filp->private_data = kmalloc(size, GFP_KERNEL);
+	if (!filp->private_data)
+		return -ENOMEM;
+
+	memset(filp->private_data, 0, size);
+	efct_lio_tgt_session_data(sport->efct, sport->npiv_wwpn,
+				  filp->private_data, size);
+	return 0;
+}
+
+static const struct file_operations efct_debugfs_session_fops = {
+	.owner		= THIS_MODULE,
+	.open		= efct_debugfs_session_open,
+	.release	= efct_debugfs_session_close,
+	.read		= efct_debugfs_session_read,
+	.llseek		= default_llseek,
+};
+
+static const struct file_operations efct_npiv_debugfs_session_fops = {
+	.owner		= THIS_MODULE,
+	.open		= efct_npiv_debugfs_session_open,
+	.release	= efct_debugfs_session_close,
+	.read		= efct_debugfs_session_read,
+	.llseek		= default_llseek,
+};
+
+static char *efct_lio_get_fabric_wwn(struct se_portal_group *se_tpg)
+{
+	struct efct_lio_tpg *tpg = container_of(se_tpg,
+						struct efct_lio_tpg, tpg);
+
+	return tpg->sport->wwpn_str;
+}
+
+static char *efct_lio_get_npiv_fabric_wwn(struct se_portal_group *se_tpg)
+{
+	struct efct_lio_tpg *tpg = container_of(se_tpg,
+						struct efct_lio_tpg, tpg);
+
+	return tpg->vport->wwpn_str;
+}
+
+static u16 efct_lio_get_tag(struct se_portal_group *se_tpg)
+{
+	struct efct_lio_tpg *tpg = container_of(se_tpg,
+						struct efct_lio_tpg, tpg);
+
+	return tpg->tpgt;
+}
+
+static u16 efct_lio_get_npiv_tag(struct se_portal_group *se_tpg)
+{
+	struct efct_lio_tpg *tpg = container_of(se_tpg,
+						struct efct_lio_tpg, tpg);
+
+	return tpg->tpgt;
+}
+
+static int efct_lio_check_demo_mode(struct se_portal_group *se_tpg)
+{
+	return 1;
+}
+
+static int efct_lio_check_demo_mode_cache(struct se_portal_group *se_tpg)
+{
+	return 1;
+}
+
+static int efct_lio_check_demo_write_protect(struct se_portal_group *se_tpg)
+{
+	struct efct_lio_tpg *tpg = container_of(se_tpg,
+						struct efct_lio_tpg, tpg);
+
+	return tpg->tpg_attrib.demo_mode_write_protect;
+}
+
+static int
+efct_lio_npiv_check_demo_write_protect(struct se_portal_group *se_tpg)
+{
+	struct efct_lio_tpg *tpg = container_of(se_tpg,
+						struct efct_lio_tpg, tpg);
+
+	return tpg->tpg_attrib.demo_mode_write_protect;
+}
+
+static int efct_lio_check_prod_write_protect(struct se_portal_group *se_tpg)
+{
+	struct efct_lio_tpg *tpg = container_of(se_tpg,
+						struct efct_lio_tpg, tpg);
+
+	return tpg->tpg_attrib.prod_mode_write_protect;
+}
+
+static int
+efct_lio_npiv_check_prod_write_protect(struct se_portal_group *se_tpg)
+{
+	struct efct_lio_tpg *tpg = container_of(se_tpg,
+						struct efct_lio_tpg, tpg);
+
+	return tpg->tpg_attrib.prod_mode_write_protect;
+}
+
+static u32 efct_lio_tpg_get_inst_index(struct se_portal_group *se_tpg)
+{
+	return 0;
+}
+
+static int efct_lio_check_stop_free(struct se_cmd *se_cmd)
+{
+	struct efct_scsi_tgt_io *ocp = container_of(se_cmd,
+						     struct efct_scsi_tgt_io,
+						     cmd);
+	struct efct_io *io = container_of(ocp, struct efct_io, tgt_io);
+
+	efct_set_lio_io_state(io, EFCT_LIO_STATE_TFO_CHK_STOP_FREE);
+	return target_put_sess_cmd(se_cmd);
+}
+
+static int
+efct_lio_abort_tgt_cb(struct efct_io *io,
+		      enum efct_scsi_io_status scsi_status,
+		      u32 flags, void *arg)
+{
+	efct_lio_io_printf(io, "%s\n", __func__);
+	return 0;
+}
+
+/* command has been aborted, cleanup here */
+static void efct_lio_aborted_task(struct se_cmd *se_cmd)
+{
+	struct efct_scsi_tgt_io *ocp = container_of(se_cmd,
+						     struct efct_scsi_tgt_io,
+						     cmd);
+	struct efct_io *io = container_of(ocp, struct efct_io, tgt_io);
+
+	efct_set_lio_io_state(io, EFCT_LIO_STATE_TFO_ABORTED_TASK);
+
+	if (!(se_cmd->transport_state & CMD_T_ABORTED) || ocp->rsp_sent)
+		return;
+
+	ocp->aborting = true;
+	ocp->err = EFCT_SCSI_STATUS_ABORTED;
+	/* terminate the exchange */
+	efct_scsi_tgt_abort_io(io, efct_lio_abort_tgt_cb, NULL);
+}
+
+/* Called when se_cmd's ref count goes to 0 */
+static void efct_lio_release_cmd(struct se_cmd *se_cmd)
+{
+	struct efct_scsi_tgt_io *ocp = container_of(se_cmd,
+						     struct efct_scsi_tgt_io,
+						     cmd);
+	struct efct_io *io = container_of(ocp, struct efct_io, tgt_io);
+	struct efct *efct = io->efct;
+
+	efct_set_lio_io_state(io, EFCT_LIO_STATE_TFO_RELEASE_CMD);
+	efct_scsi_io_complete(io);
+	atomic_sub_return(1, &efct->tgt_efct.ios_in_use);
+	efct_set_lio_io_state(io, EFCT_LIO_STATE_SCSI_CMPL_CMD);
+}
+
+static void efct_lio_close_session(struct se_session *se_sess)
+{
+	struct efc_node *node = se_sess->fabric_sess_ptr;
+	struct efct *efct = NULL;
+	int rc;
+
+	pr_debug("se_sess=%p node=%p", se_sess, node);
+
+	if (!node) {
+		pr_debug("node is NULL");
+		return;
+	}
+
+	efct = node->efc->base;
+	rc = efct_xport_control(efct->xport,
+				EFCT_XPORT_POST_NODE_EVENT, node,
+		EFCT_XPORT_SHUTDOWN, NULL);
+	if (rc != 0) {
+		efc_log_test(efct,
+			      "Failed to shutdown session %p node %p\n",
+			     se_sess, node);
+		return;
+	}
+}
+
+static u32 efct_lio_sess_get_index(struct se_session *se_sess)
+{
+	return 0;
+}
+
+static void efct_lio_set_default_node_attrs(struct se_node_acl *nacl)
+{
+}
+
+static int efct_lio_get_cmd_state(struct se_cmd *se_cmd)
+{
+	return 0;
+}
+
+static int
+efct_lio_sg_map(struct efct_io *io)
+{
+	struct efct_scsi_tgt_io *ocp = &io->tgt_io;
+	struct se_cmd *cmd = &ocp->cmd;
+
+	ocp->seg_map_cnt = pci_map_sg(io->efct->pcidev, cmd->t_data_sg,
+				      cmd->t_data_nents, cmd->data_direction);
+	if (ocp->seg_map_cnt == 0)
+		return -EFAULT;
+	return 0;
+}
+
+static void
+efct_lio_sg_unmap(struct efct_io *io)
+{
+	struct efct_scsi_tgt_io *ocp = &io->tgt_io;
+	struct se_cmd *cmd = &ocp->cmd;
+
+	if (WARN_ON(!ocp->seg_map_cnt || !cmd->t_data_sg))
+		return;
+
+	pci_unmap_sg(io->efct->pcidev, cmd->t_data_sg,
+		     ocp->seg_map_cnt, cmd->data_direction);
+	ocp->seg_map_cnt = 0;
+}
+
+static int
+efct_lio_status_done(struct efct_io *io,
+		     enum efct_scsi_io_status scsi_status,
+		     u32 flags, void *arg)
+{
+	struct efct_scsi_tgt_io *ocp = &io->tgt_io;
+
+	efct_set_lio_io_state(io, EFCT_LIO_STATE_SCSI_RSP_DONE);
+	if (scsi_status != EFCT_SCSI_STATUS_GOOD) {
+		efct_lio_io_printf(io, "callback completed with error=%d\n",
+				   scsi_status);
+		ocp->err = scsi_status;
+	}
+	if (ocp->seg_map_cnt)
+		efct_lio_sg_unmap(io);
+
+	efct_lio_io_printf(io, "status=%d, err=%d flags=0x%x, dir=%d\n",
+				scsi_status, ocp->err, flags, ocp->ddir);
+
+	transport_generic_free_cmd(&io->tgt_io.cmd, 0);
+	efct_set_lio_io_state(io, EFCT_LIO_STATE_TGT_GENERIC_FREE);
+	return 0;
+}
+
+static int
+efct_lio_datamove_done(struct efct_io *io, enum efct_scsi_io_status scsi_status,
+		       u32 flags, void *arg);
+
+static int
+efct_lio_write_pending(struct se_cmd *cmd)
+{
+	struct efct_scsi_tgt_io *ocp = container_of(cmd,
+						     struct efct_scsi_tgt_io,
+						     cmd);
+	struct efct_io *io = container_of(ocp, struct efct_io, tgt_io);
+	struct efct_scsi_sgl *sgl = io->sgl;
+	struct scatterlist *sg;
+	u32 flags = 0, cnt, curcnt;
+	u64 length = 0;
+	int rc = 0;
+
+	efct_set_lio_io_state(io, EFCT_LIO_STATE_TFO_WRITE_PENDING);
+	efct_lio_io_printf(io, "trans_state=0x%x se_cmd_flags=0x%x\n",
+			  cmd->transport_state, cmd->se_cmd_flags);
+
+	if (ocp->seg_cnt == 0) {
+		ocp->seg_cnt = cmd->t_data_nents;
+		ocp->cur_seg = 0;
+		if (efct_lio_sg_map(io)) {
+			efct_lio_io_printf(io, "efct_lio_sg_map failed\n");
+			return -EFAULT;
+		}
+	}
+	curcnt = (ocp->seg_map_cnt - ocp->cur_seg);
+	curcnt = (curcnt < io->sgl_allocated) ? curcnt : io->sgl_allocated;
+	/* find current sg */
+	for (cnt = 0, sg = cmd->t_data_sg; cnt < ocp->cur_seg; cnt++,
+	     sg = sg_next(sg))
+		;
+
+	for (cnt = 0; cnt < curcnt; cnt++, sg = sg_next(sg)) {
+		sgl[cnt].addr = sg_dma_address(sg);
+		sgl[cnt].dif_addr = 0;
+		sgl[cnt].len = sg_dma_len(sg);
+		length += sgl[cnt].len;
+		ocp->cur_seg++;
+	}
+	if (ocp->cur_seg == ocp->seg_cnt)
+		flags = EFCT_SCSI_LAST_DATAPHASE;
+	rc = efct_scsi_recv_wr_data(io, flags, NULL, sgl, curcnt, length,
+				    efct_lio_datamove_done, NULL);
+	return rc;
+}
+
+static int
+efct_lio_queue_data_in(struct se_cmd *cmd)
+{
+	struct efct_scsi_tgt_io *ocp = container_of(cmd,
+						     struct efct_scsi_tgt_io,
+						     cmd);
+	struct efct_io *io = container_of(ocp, struct efct_io, tgt_io);
+	struct efct_scsi_sgl *sgl = io->sgl;
+	struct scatterlist *sg = NULL;
+	uint flags = 0, cnt = 0, curcnt = 0;
+	u64 length = 0;
+	int rc = 0;
+
+	efct_set_lio_io_state(io, EFCT_LIO_STATE_TFO_QUEUE_DATA_IN);
+
+	if (ocp->seg_cnt == 0) {
+		if (cmd->data_length) {
+			ocp->seg_cnt = cmd->t_data_nents;
+			ocp->cur_seg = 0;
+			if (efct_lio_sg_map(io)) {
+				efct_lio_io_printf(io,
+						   "efct_lio_sg_map failed\n");
+				return -EAGAIN;
+			}
+		} else {
+			/* If command length is 0, send the response status */
+			struct efct_scsi_cmd_resp rsp;
+
+			memset(&rsp, 0, sizeof(rsp));
+			efct_lio_io_printf(io,
+					   "cmd : %p length 0, send status\n",
+					   cmd);
+			return efct_scsi_send_resp(io, 0, &rsp,
+						  efct_lio_status_done, NULL);
+		}
+	}
+	curcnt = min(ocp->seg_map_cnt - ocp->cur_seg, io->sgl_allocated);
+
+	while (cnt < curcnt) {
+		sg = &cmd->t_data_sg[ocp->cur_seg];
+		sgl[cnt].addr = sg_dma_address(sg);
+		sgl[cnt].dif_addr = 0;
+		if (ocp->transferred_len + sg_dma_len(sg) >= cmd->data_length)
+			sgl[cnt].len = cmd->data_length - ocp->transferred_len;
+		else
+			sgl[cnt].len = sg_dma_len(sg);
+
+		ocp->transferred_len += sgl[cnt].len;
+		length += sgl[cnt].len;
+		ocp->cur_seg++;
+		cnt++;
+		if (ocp->transferred_len == cmd->data_length)
+			break;
+	}
+
+	if (ocp->transferred_len == cmd->data_length) {
+		flags = EFCT_SCSI_LAST_DATAPHASE;
+		ocp->seg_cnt = ocp->cur_seg;
+	}
+
+	/* If there is residual, disable Auto Good Response */
+	if (cmd->residual_count)
+		flags |= EFCT_SCSI_NO_AUTO_RESPONSE;
+
+	rc = efct_scsi_send_rd_data(io, flags, NULL, sgl, curcnt, length,
+				    efct_lio_datamove_done, NULL);
+	efct_set_lio_io_state(io, EFCT_LIO_STATE_SCSI_SEND_RD_DATA);
+	return rc;
+}
+
+static int
+efct_lio_datamove_done(struct efct_io *io,
+		       enum efct_scsi_io_status scsi_status,
+		      u32 flags, void *arg)
+{
+	struct efct_scsi_tgt_io *ocp = &io->tgt_io;
+	struct se_cmd *cmd = &io->tgt_io.cmd;
+	int rc;
+
+	efct_set_lio_io_state(io, EFCT_LIO_STATE_SCSI_DATA_DONE);
+	if (scsi_status != EFCT_SCSI_STATUS_GOOD) {
+		efct_lio_io_printf(io, "callback completed with error=%d\n",
+				   scsi_status);
+		ocp->err = scsi_status;
+	}
+	efct_lio_io_printf(io, "seg_map_cnt=%d\n", ocp->seg_map_cnt);
+	if (ocp->seg_map_cnt) {
+		if (ocp->err == EFCT_SCSI_STATUS_GOOD &&
+		    ocp->cur_seg < ocp->seg_cnt) {
+			efct_lio_io_printf(io, "continuing cmd at segm=%d\n",
+					  ocp->cur_seg);
+			if (ocp->ddir == DMA_TO_DEVICE)
+				rc = efct_lio_write_pending(&ocp->cmd);
+			else
+				rc = efct_lio_queue_data_in(&ocp->cmd);
+			if (rc == 0)
+				return 0;
+			ocp->err = EFCT_SCSI_STATUS_ERROR;
+			efct_lio_io_printf(io, "could not continue command\n");
+		}
+		efct_lio_sg_unmap(io);
+	}
+
+	if (io->tgt_io.aborting) {
+		efct_lio_io_printf(io, "IO done aborted\n");
+		return 0;
+	}
+
+	if (ocp->ddir == DMA_TO_DEVICE) {
+		efct_lio_io_printf(io, "Write done, trans_state=0x%x\n",
+				  io->tgt_io.cmd.transport_state);
+		if (scsi_status != EFCT_SCSI_STATUS_GOOD) {
+			transport_generic_request_failure(&io->tgt_io.cmd,
+					TCM_CHECK_CONDITION_ABORT_CMD);
+			efct_set_lio_io_state(io,
+				EFCT_LIO_STATE_TGT_GENERIC_REQ_FAILURE);
+		} else {
+			efct_set_lio_io_state(io,
+						EFCT_LIO_STATE_TGT_EXECUTE_CMD);
+			target_execute_cmd(&io->tgt_io.cmd);
+		}
+	} else {
+		if ((flags & EFCT_SCSI_IO_CMPL_RSP_SENT) == 0) {
+			struct efct_scsi_cmd_resp rsp;
+			/* send check condition if an error occurred */
+			memset(&rsp, 0, sizeof(rsp));
+			rsp.scsi_status = cmd->scsi_status;
+			rsp.sense_data = (uint8_t *)io->tgt_io.sense_buffer;
+			rsp.sense_data_length = cmd->scsi_sense_length;
+
+			/* Check for residual underrun or overrun */
+			if (cmd->se_cmd_flags & SCF_OVERFLOW_BIT)
+				rsp.residual = -cmd->residual_count;
+			else if (cmd->se_cmd_flags & SCF_UNDERFLOW_BIT)
+				rsp.residual = cmd->residual_count;
+
+			rc = efct_scsi_send_resp(io, 0, &rsp,
+						 efct_lio_status_done, NULL);
+			efct_set_lio_io_state(io,
+						EFCT_LIO_STATE_SCSI_SEND_RSP);
+			if (rc != 0) {
+				efct_lio_io_printf(io,
+						   "Read done, failed to send rsp, rc=%d\n",
+				      rc);
+				transport_generic_free_cmd(&io->tgt_io.cmd, 0);
+				efct_set_lio_io_state(io,
+					EFCT_LIO_STATE_TGT_GENERIC_FREE);
+			} else {
+				ocp->rsp_sent = true;
+			}
+		} else {
+			ocp->rsp_sent = true;
+			transport_generic_free_cmd(&io->tgt_io.cmd, 0);
+			efct_set_lio_io_state(io,
+					EFCT_LIO_STATE_TGT_GENERIC_FREE);
+		}
+	}
+	return 0;
+}
+
+static int
+efct_lio_tmf_done(struct efct_io *io, enum efct_scsi_io_status scsi_status,
+		  u32 flags, void *arg)
+{
+	efct_lio_tmfio_printf(io, "cmd=%p status=%d, flags=0x%x\n",
+			      &io->tgt_io.cmd, scsi_status, flags);
+
+	transport_generic_free_cmd(&io->tgt_io.cmd, 0);
+	efct_set_lio_io_state(io, EFCT_LIO_STATE_TGT_GENERIC_FREE);
+	return 0;
+}
+
+static int
+efct_lio_null_tmf_done(struct efct_io *tmfio,
+		       enum efct_scsi_io_status scsi_status,
+		      u32 flags, void *arg)
+{
+	efct_lio_tmfio_printf(tmfio, "cmd=%p status=%d, flags=0x%x\n",
+			      &tmfio->tgt_io.cmd, scsi_status, flags);
+
+	/* free struct efct_io only, no active se_cmd */
+	efct_scsi_io_complete(tmfio);
+	return 0;
+}
+
+static int
+efct_lio_queue_status(struct se_cmd *cmd)
+{
+	struct efct_scsi_cmd_resp rsp;
+	struct efct_scsi_tgt_io *ocp = container_of(cmd,
+						     struct efct_scsi_tgt_io,
+						     cmd);
+	struct efct_io *io = container_of(ocp, struct efct_io, tgt_io);
+	int rc = 0;
+
+	efct_set_lio_io_state(io, EFCT_LIO_STATE_TFO_QUEUE_STATUS);
+	efct_lio_io_printf(io,
+		"status=0x%x trans_state=0x%x se_cmd_flags=0x%x sns_len=%d\n",
+		cmd->scsi_status, cmd->transport_state, cmd->se_cmd_flags,
+		cmd->scsi_sense_length);
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.scsi_status = cmd->scsi_status;
+	rsp.sense_data = (u8 *)io->tgt_io.sense_buffer;
+	rsp.sense_data_length = cmd->scsi_sense_length;
+
+	/* Check for residual underrun or overrun, mark negitive value for
+	 * underrun to recognize in HW
+	 */
+	if (cmd->se_cmd_flags & SCF_OVERFLOW_BIT)
+		rsp.residual = -cmd->residual_count;
+	else if (cmd->se_cmd_flags & SCF_UNDERFLOW_BIT)
+		rsp.residual = cmd->residual_count;
+
+	rc = efct_scsi_send_resp(io, 0, &rsp, efct_lio_status_done, NULL);
+	efct_set_lio_io_state(io, EFCT_LIO_STATE_SCSI_SEND_RSP);
+	if (rc == 0)
+		ocp->rsp_sent = true;
+	return rc;
+}
+
+static void efct_lio_queue_tm_rsp(struct se_cmd *cmd)
+{
+	struct efct_scsi_tgt_io *ocp = container_of(cmd,
+						     struct efct_scsi_tgt_io,
+						     cmd);
+	struct efct_io *tmfio = container_of(ocp, struct efct_io, tgt_io);
+	struct se_tmr_req *se_tmr = cmd->se_tmr_req;
+	u8 rspcode;
+
+	efct_lio_tmfio_printf(tmfio, "cmd=%p function=0x%x tmr->response=%d\n",
+			      cmd, se_tmr->function, se_tmr->response);
+	switch (se_tmr->response) {
+	case TMR_FUNCTION_COMPLETE:
+		rspcode = EFCT_SCSI_TMF_FUNCTION_COMPLETE;
+		break;
+	case TMR_TASK_DOES_NOT_EXIST:
+		rspcode = EFCT_SCSI_TMF_FUNCTION_IO_NOT_FOUND;
+		break;
+	case TMR_LUN_DOES_NOT_EXIST:
+		rspcode = EFCT_SCSI_TMF_INCORRECT_LOGICAL_UNIT_NUMBER;
+		break;
+	case TMR_FUNCTION_REJECTED:
+	default:
+		rspcode = EFCT_SCSI_TMF_FUNCTION_REJECTED;
+		break;
+	}
+	efct_scsi_send_tmf_resp(tmfio, rspcode, NULL, efct_lio_tmf_done, NULL);
+}
+
+static struct efct *efct_find_wwpn(u64 wwpn)
+{
+	int efctidx;
+	struct efct *efct;
+
+	 /* Search for the HBA that has this WWPN */
+	for (efctidx = 0; efctidx < MAX_EFCT_DEVICES; efctidx++) {
+		u64 pwwn;
+		u8 pn[8];
+
+		efct = efct_devices[efctidx];
+		if (!efct)
+			continue;
+
+		memcpy(pn, efct_hw_get_ptr(&efct->hw, EFCT_HW_WWN_PORT),
+		       sizeof(pn));
+
+		pwwn = get_unaligned_be64(pn);
+		if (pwwn == wwpn)
+			break;
+	}
+
+	if (efctidx == MAX_EFCT_DEVICES)
+		return NULL;
+
+	return efct_devices[efctidx];
+}
+
+static struct dentry *
+efct_create_dfs_session(struct efct *efct, void *data, u8 npiv)
+{
+	char name[16];
+
+	if (!efct->sess_debugfs_dir)
+		return NULL;
+
+	if (npiv)
+		snprintf(name, sizeof(name), "efct-sessions-%d",
+			 efct->instance_index);
+	else
+		snprintf(name, sizeof(name), "sessions-npiv-%d",
+			 efct->instance_index);
+
+	return debugfs_create_file(name, 0644, efct->sess_debugfs_dir,
+				   data, &efct_debugfs_session_fops);
+}
+
+static struct se_wwn *
+efct_lio_make_sport(struct target_fabric_configfs *tf,
+		    struct config_group *group, const char *name)
+{
+	struct efct_lio_sport *lio_sport;
+	struct efct *efct;
+	int ret;
+	u64 wwpn;
+
+	ret = efct_lio_parse_wwn(name, &wwpn, 0);
+	if (ret)
+		return ERR_PTR(ret);
+
+	efct = efct_find_wwpn(wwpn);
+	if (!efct) {
+		pr_err("cannot find EFCT for base wwpn %s\n", name);
+		return ERR_PTR(-ENXIO);
+	}
+
+	lio_sport = kzalloc(sizeof(*lio_sport), GFP_KERNEL);
+	if (!lio_sport)
+		return ERR_PTR(-ENOMEM);
+
+	lio_sport->efct = efct;
+	lio_sport->wwpn = wwpn;
+	efct_format_wwn(lio_sport->wwpn_str, sizeof(lio_sport->wwpn_str),
+			"naa.", wwpn);
+	efct->tgt_efct.lio_sport = lio_sport;
+
+	lio_sport->sessions = efct_create_dfs_session(efct, lio_sport, 0);
+	return &lio_sport->sport_wwn;
+}
+
+static struct se_wwn *
+efct_lio_npiv_make_sport(struct target_fabric_configfs *tf,
+			 struct config_group *group, const char *name)
+{
+	struct efct_lio_vport *lio_vport;
+	struct efct *efct;
+	int ret = -1;
+	u64 p_wwpn, npiv_wwpn, npiv_wwnn;
+	char *p, tmp[128];
+	struct efct_lio_vport_list_t *vport_list;
+	struct fc_vport *new_fc_vport;
+	struct fc_vport_identifiers vport_id;
+	unsigned long flags = 0;
+
+	snprintf(tmp, 128, "%s", name);
+
+	p = strchr(tmp, '@');
+
+	if (!p) {
+		pr_err("Unable to find separator operator(@)\n");
+		return ERR_PTR(ret);
+	}
+	*p++ = '\0';
+
+	ret = efct_lio_parse_wwn(tmp, &p_wwpn, 0);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = efct_lio_parse_npiv_wwn(p, strlen(p) + 1, &npiv_wwpn, &npiv_wwnn);
+	if (ret)
+		return ERR_PTR(ret);
+
+	efct = efct_find_wwpn(p_wwpn);
+	if (!efct) {
+		pr_err("cannot find EFCT for base wwpn %s\n", name);
+		return ERR_PTR(-ENXIO);
+	}
+
+	lio_vport = kzalloc(sizeof(*lio_vport), GFP_KERNEL);
+	if (!lio_vport)
+		return ERR_PTR(-ENOMEM);
+
+	lio_vport->efct = efct;
+	lio_vport->wwpn = p_wwpn;
+	lio_vport->npiv_wwpn = npiv_wwpn;
+	lio_vport->npiv_wwnn = npiv_wwnn;
+
+	efct_format_wwn(lio_vport->wwpn_str, sizeof(lio_vport->wwpn_str),
+			"naa.", npiv_wwpn);
+
+	vport_list = kmalloc(sizeof(*vport_list), GFP_KERNEL);
+	if (!vport_list) {
+		kfree(lio_vport);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	memset(vport_list, 0, sizeof(struct efct_lio_vport_list_t));
+	vport_list->lio_vport = lio_vport;
+	spin_lock_irqsave(&efct->tgt_efct.efct_lio_lock, flags);
+	INIT_LIST_HEAD(&vport_list->list_entry);
+	list_add_tail(&vport_list->list_entry, &efct->tgt_efct.vport_list);
+	spin_unlock_irqrestore(&efct->tgt_efct.efct_lio_lock, flags);
+
+	lio_vport->sessions = efct_create_dfs_session(efct, lio_vport, 1);
+
+	memset(&vport_id, 0, sizeof(vport_id));
+	vport_id.port_name = npiv_wwpn;
+	vport_id.node_name = npiv_wwnn;
+	vport_id.roles = FC_PORT_ROLE_FCP_INITIATOR;
+	vport_id.vport_type = FC_PORTTYPE_NPIV;
+	vport_id.disable = false;
+
+	new_fc_vport = fc_vport_create(efct->shost, 0, &vport_id);
+	if (!new_fc_vport) {
+		efc_log_err(efct, "fc_vport_create failed\n");
+		kfree(lio_vport);
+		kfree(vport_list);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	lio_vport->fc_vport = new_fc_vport;
+
+	return &lio_vport->vport_wwn;
+}
+
+static void
+efct_lio_drop_sport(struct se_wwn *wwn)
+{
+	struct efct_lio_sport *lio_sport = container_of(wwn,
+					    struct efct_lio_sport, sport_wwn);
+	struct efct *efct = lio_sport->efct;
+
+	/* only physical sport should exist, free lio_sport allocated
+	 * in efct_lio_make_sport.
+	 */
+
+	debugfs_remove(lio_sport->sessions);
+	lio_sport->sessions = NULL;
+
+	kfree(efct->tgt_efct.lio_sport);
+	efct->tgt_efct.lio_sport = NULL;
+}
+
+static void
+efct_lio_npiv_drop_sport(struct se_wwn *wwn)
+{
+	struct efct_lio_vport *lio_vport = container_of(wwn,
+			struct efct_lio_vport, vport_wwn);
+	struct efct_lio_vport_list_t *vport, *next_vport;
+	struct efct *efct = lio_vport->efct;
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(&efct->tgt_efct.efct_lio_lock, flags);
+
+	debugfs_remove(lio_vport->sessions);
+
+	if (lio_vport->fc_vport)
+		fc_vport_terminate(lio_vport->fc_vport);
+
+	lio_vport->sessions = NULL;
+
+	list_for_each_entry_safe(vport, next_vport, &efct->tgt_efct.vport_list,
+				 list_entry) {
+		if (vport->lio_vport == lio_vport) {
+			list_del(&vport->list_entry);
+			kfree(vport->lio_vport);
+			kfree(vport);
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&efct->tgt_efct.efct_lio_lock, flags);
+}
+
+static struct se_portal_group *
+efct_lio_make_tpg(struct se_wwn *wwn, const char *name)
+{
+	struct efct_lio_sport *lio_sport = container_of(wwn,
+					    struct efct_lio_sport, sport_wwn);
+	struct efct_lio_tpg *tpg;
+	struct efct *efct;
+	unsigned long n;
+	int ret;
+
+	if (strstr(name, "tpgt_") != name)
+		return ERR_PTR(-EINVAL);
+	if (kstrtoul(name + 5, 10, &n) || n > USHRT_MAX)
+		return ERR_PTR(-EINVAL);
+
+	tpg = kzalloc(sizeof(*tpg), GFP_KERNEL);
+	if (!tpg)
+		return ERR_PTR(-ENOMEM);
+
+	tpg->sport = lio_sport;
+	tpg->tpgt = n;
+	atomic_set(&tpg->enabled, 0);
+
+	tpg->tpg_attrib.generate_node_acls = 1;
+	tpg->tpg_attrib.demo_mode_write_protect = 1;
+	tpg->tpg_attrib.cache_dynamic_acls = 1;
+	tpg->tpg_attrib.demo_mode_login_only = 1;
+	tpg->tpg_attrib.session_deletion_wait = 1;
+
+	ret = core_tpg_register(wwn, &tpg->tpg, SCSI_PROTOCOL_FCP);
+	if (ret < 0) {
+		kfree(tpg);
+		return NULL;
+	}
+	efct = lio_sport->efct;
+	efct->tgt_efct.tpg = tpg;
+	efc_log_debug(efct, "create portal group %d\n", tpg->tpgt);
+
+	return &tpg->tpg;
+}
+
+static void
+efct_lio_drop_tpg(struct se_portal_group *se_tpg)
+{
+	struct efct_lio_tpg *tpg = container_of(se_tpg,
+						struct efct_lio_tpg, tpg);
+
+	efc_log_debug(tpg->sport->efct, "drop portal group %d\n", tpg->tpgt);
+	tpg->sport->efct->tgt_efct.tpg = NULL;
+	core_tpg_deregister(se_tpg);
+	kfree(tpg);
+}
+
+static struct se_portal_group *
+efct_lio_npiv_make_tpg(struct se_wwn *wwn, const char *name)
+{
+	struct efct_lio_vport *lio_vport = container_of(wwn,
+			struct efct_lio_vport, vport_wwn);
+	struct efct_lio_tpg *tpg;
+	struct efct *efct;
+	unsigned long n;
+	int ret;
+
+	efct = lio_vport->efct;
+	if (strstr(name, "tpgt_") != name)
+		return ERR_PTR(-EINVAL);
+	if (kstrtoul(name + 5, 10, &n) || n > USHRT_MAX)
+		return ERR_PTR(-EINVAL);
+
+	if (n != 1) {
+		efc_log_err(efct, "Invalid tpgt index: %ld provided\n", n);
+		return ERR_PTR(-EINVAL);
+	}
+
+	tpg = kzalloc(sizeof(*tpg), GFP_KERNEL);
+	if (!tpg)
+		return ERR_PTR(-ENOMEM);
+
+	tpg->vport = lio_vport;
+	tpg->tpgt = n;
+	atomic_set(&tpg->enabled, 0);
+
+	tpg->tpg_attrib.generate_node_acls = 1;
+	tpg->tpg_attrib.demo_mode_write_protect = 1;
+	tpg->tpg_attrib.cache_dynamic_acls = 1;
+	tpg->tpg_attrib.demo_mode_login_only = 1;
+	tpg->tpg_attrib.session_deletion_wait = 1;
+
+	ret = core_tpg_register(wwn, &tpg->tpg, SCSI_PROTOCOL_FCP);
+
+	if (ret < 0) {
+		kfree(tpg);
+		return NULL;
+	}
+	lio_vport->tpg = tpg;
+	efc_log_debug(efct, "create vport portal group %d\n", tpg->tpgt);
+
+	return &tpg->tpg;
+}
+
+static void
+efct_lio_npiv_drop_tpg(struct se_portal_group *se_tpg)
+{
+	struct efct_lio_tpg *tpg = container_of(se_tpg,
+						struct efct_lio_tpg, tpg);
+
+	efc_log_debug(tpg->vport->efct, "drop npiv portal group %d\n",
+		       tpg->tpgt);
+	core_tpg_deregister(se_tpg);
+	kfree(tpg);
+}
+
+static int
+efct_lio_init_nodeacl(struct se_node_acl *se_nacl, const char *name)
+{
+	struct efct_lio_nacl *nacl;
+	u64 wwnn;
+
+	if (efct_lio_parse_wwn(name, &wwnn, 0) < 0)
+		return -EINVAL;
+
+	nacl = container_of(se_nacl, struct efct_lio_nacl, se_node_acl);
+	nacl->nport_wwnn = wwnn;
+
+	efct_format_wwn(nacl->nport_name, sizeof(nacl->nport_name), "", wwnn);
+	return 0;
+}
+
+static int efct_lio_check_demo_mode_login_only(struct se_portal_group *stpg)
+{
+	struct efct_lio_tpg *tpg = container_of(stpg, struct efct_lio_tpg, tpg);
+
+	return tpg->tpg_attrib.demo_mode_login_only;
+}
+
+static int
+efct_lio_npiv_check_demo_mode_login_only(struct se_portal_group *stpg)
+{
+	struct efct_lio_tpg *tpg = container_of(stpg, struct efct_lio_tpg, tpg);
+
+	return tpg->tpg_attrib.demo_mode_login_only;
+}
+
+static struct efct_lio_tpg *
+efct_get_vport_tpg(struct efc_node *node)
+{
+	struct efct *efct;
+	u64 wwpn = node->sport->wwpn;
+	struct efct_lio_vport_list_t *vport, *next;
+	struct efct_lio_vport *lio_vport = NULL;
+	struct efct_lio_tpg *tpg = NULL;
+	unsigned long flags = 0;
+
+	efct = node->efc->base;
+	spin_lock_irqsave(&efct->tgt_efct.efct_lio_lock, flags);
+	list_for_each_entry_safe(vport, next, &efct->tgt_efct.vport_list,
+				 list_entry) {
+		lio_vport = vport->lio_vport;
+		if (wwpn && lio_vport &&
+		    lio_vport->npiv_wwpn == wwpn) {
+			efc_log_test(efct, "found tpg on vport\n");
+			tpg = lio_vport->tpg;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&efct->tgt_efct.efct_lio_lock, flags);
+	return tpg;
+}
+
+static int efct_session_cb(struct se_portal_group *se_tpg,
+			   struct se_session *se_sess, void *private)
+{
+	struct efc_node *node = private;
+	struct efct_scsi_tgt_node *tgt_node = NULL;
+
+	tgt_node = kzalloc(sizeof(*tgt_node), GFP_KERNEL);
+	if (!tgt_node)
+		return -1;
+
+	tgt_node->session = se_sess;
+	node->tgt_node = tgt_node;
+
+	return 0;
+}
+
+int efct_scsi_tgt_new_device(struct efct *efct)
+{
+	int rc = 0;
+	u32 total_ios;
+
+	/* Get the max settings */
+	efct->tgt_efct.max_sge =
+			efct_scsi_get_property(efct, EFCT_SCSI_MAX_SGE);
+	efct->tgt_efct.max_sgl =
+			efct_scsi_get_property(efct, EFCT_SCSI_MAX_SGL);
+
+	/* initialize IO watermark fields */
+	atomic_set(&efct->tgt_efct.ios_in_use, 0);
+	total_ios = efct_scsi_get_property(efct, EFCT_SCSI_MAX_IOS);
+	efc_log_debug(efct, "total_ios=%d\n", total_ios);
+	efct->tgt_efct.watermark_min =
+			(total_ios * EFCT_WATERMARK_LOW_PCT) / 100;
+	efct->tgt_efct.watermark_max =
+			(total_ios * EFCT_WATERMARK_HIGH_PCT) / 100;
+	atomic_set(&efct->tgt_efct.io_high_watermark,
+		   efct->tgt_efct.watermark_max);
+	atomic_set(&efct->tgt_efct.watermark_hit, 0);
+	atomic_set(&efct->tgt_efct.initiator_count, 0);
+
+	lio_wq = create_singlethread_workqueue("efct_lio_worker");
+	if (!lio_wq) {
+		efc_log_err(efct, "workqueue create failed\n");
+		return -ENOMEM;
+	}
+
+	spin_lock_init(&efct->tgt_efct.efct_lio_lock);
+	INIT_LIST_HEAD(&efct->tgt_efct.vport_pend_list);
+	INIT_LIST_HEAD(&efct->tgt_efct.vport_list);
+
+	return rc;
+}
+
+int efct_scsi_tgt_del_device(struct efct *efct)
+{
+	int rc = 0;
+
+	flush_workqueue(lio_wq);
+
+	return rc;
+}
+
+int
+efct_scsi_tgt_new_domain(struct efc *efc, struct efc_domain *domain)
+{
+	int status = 0;
+	struct efct *efct = domain->efc->base;
+	struct efct_lio_vport_data_t *virt_target_data, *next;
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(&efct->tgt_efct.efct_lio_lock, flags);
+	list_for_each_entry_safe(virt_target_data, next,
+		 &efct->tgt_efct.vport_pend_list, list_entry) {
+		list_del(&virt_target_data->list_entry);
+
+		status = efc_sport_vport_new(domain,
+					     virt_target_data->vport_wwpn,
+					     virt_target_data->vport_wwnn,
+					     U32_MAX,
+					     virt_target_data->initiator_mode,
+					     virt_target_data->target_mode,
+					     virt_target_data, NULL, true);
+		if (status != 0) {
+			/* Put this back on list and try again next time */
+			efc_log_test(efct,
+				      "Could not create new vport for WWPN:0x%llx\n",
+				 virt_target_data->vport_wwpn);
+			list_add(&efct->tgt_efct.vport_pend_list,
+				 &virt_target_data->list_entry);
+		} else {
+			efc_log_debug(efct,
+				       "Created new vport for WWPN: 0x%llx\n",
+				      virt_target_data->vport_wwpn);
+			kfree(virt_target_data);
+		}
+	}
+	spin_unlock_irqrestore(&efct->tgt_efct.efct_lio_lock, flags);
+	return status;
+}
+
+void
+efct_scsi_tgt_del_domain(struct efc *efc, struct efc_domain *domain)
+{
+}
+
+/* Called by the libefc when new sli port (sport) is discovered */
+int
+efct_scsi_tgt_new_sport(struct efc *efc, struct efc_sli_port *sport)
+{
+	struct efct *efct = sport->efc->base;
+
+	efc_log_debug(efct, "New SPORT: %s bound to %s\n", sport->display_name,
+		       efct->tgt_efct.lio_sport->wwpn_str);
+
+	return 0;
+}
+
+/* Called by the libefc when a sport goes away. */
+void
+efct_scsi_tgt_del_sport(struct efc *efc, struct efc_sli_port *sport)
+{
+	efc_log_debug(efc, "Del SPORT: %s\n",
+		       sport->display_name);
+}
+/* Called by libefc to validate node. */
+int
+efct_scsi_validate_initiator(struct efc *efc, struct efc_node *node)
+{
+	return 1;
+}
+
+static void efct_lio_setup_session(struct work_struct *work)
+{
+	struct efct_lio_wq_data *wq_data = container_of(work,
+					   struct efct_lio_wq_data, work);
+	struct efct *efct = wq_data->efct;
+	struct efc_node *node = wq_data->ptr;
+	char wwpn[WWN_NAME_LEN];
+	struct efct_lio_tpg *tpg = NULL;
+	struct se_portal_group *se_tpg;
+	struct se_session *se_sess;
+	int watermark;
+	int initiator_count;
+
+	/* Check to see if it's belongs to vport,
+	 * if not get physical port
+	 */
+	tpg = efct_get_vport_tpg(node);
+	if (tpg) {
+		se_tpg = &tpg->tpg;
+	} else if (efct->tgt_efct.tpg) {
+		tpg = efct->tgt_efct.tpg;
+		se_tpg = &tpg->tpg;
+	} else {
+		efc_log_err(efct, "failed to init session\n");
+		return;
+	}
+
+	/*
+	 * Format the FCP Initiator port_name into colon
+	 * separated values to match the format by our explicit
+	 * ConfigFS NodeACLs.
+	 */
+	efct_format_wwn(wwpn, sizeof(wwpn), "",
+			efc_node_get_wwpn(node));
+
+	se_sess = target_setup_session(se_tpg, 0, 0,
+				       TARGET_PROT_NORMAL,
+				       wwpn, node,
+				       efct_session_cb);
+	if (IS_ERR(se_sess)) {
+		efc_log_err(efct, "failed to setup session\n");
+		return;
+	}
+
+	efc_log_debug(efct, "new initiator se_sess=%p node=%p\n",
+		      se_sess, node);
+
+	/* update IO watermark: increment initiator count */
+	initiator_count =
+	atomic_add_return(1, &efct->tgt_efct.initiator_count);
+	watermark = (efct->tgt_efct.watermark_max -
+	     initiator_count * EFCT_IO_WATERMARK_PER_INITIATOR);
+	watermark = (efct->tgt_efct.watermark_min > watermark) ?
+		efct->tgt_efct.watermark_min : watermark;
+	atomic_set(&efct->tgt_efct.io_high_watermark,
+		   watermark);
+
+	kfree(wq_data);
+}
+
+/* Called by the libefc when new a new remote initiator is discovered */
+int efct_scsi_new_initiator(struct efc *efc, struct efc_node *node)
+{
+	struct efct *efct = node->efc->base;
+	struct efct_lio_wq_data *wq_data;
+
+	/*
+	 * Since LIO only supports initiator validation at thread level,
+	 * we are open minded and accept all callers.
+	 */
+	wq_data = kzalloc(sizeof(*wq_data), GFP_ATOMIC);
+	if (!wq_data)
+		return -ENOMEM;
+
+	wq_data->ptr = node;
+	wq_data->efct = efct;
+	INIT_WORK(&wq_data->work, efct_lio_setup_session);
+	queue_work(lio_wq, &wq_data->work);
+	return 0;
+}
+
+static void efct_lio_remove_session(struct work_struct *work)
+{
+	struct efct_lio_wq_data *wq_data = container_of(work,
+					   struct efct_lio_wq_data, work);
+	struct efct *efct = wq_data->efct;
+	struct efc_node *node = wq_data->ptr;
+	struct efct_scsi_tgt_node *tgt_node = NULL;
+	struct se_session *se_sess;
+
+	tgt_node = node->tgt_node;
+	se_sess = tgt_node->session;
+
+	if (!se_sess) {
+		/* base driver has sent back-to-back requests
+		 * to unreg session with no intervening
+		 * register
+		 */
+		efc_log_test(efct,
+			      "unreg session for NULL session\n");
+		efc_scsi_del_initiator_complete(node->efc,
+						node);
+		return;
+	}
+
+	efc_log_debug(efct, "unreg session se_sess=%p node=%p\n",
+		       se_sess, node);
+
+	/* first flag all session commands to complete */
+	target_sess_cmd_list_set_waiting(se_sess);
+
+	/* now wait for session commands to complete */
+	target_wait_for_sess_cmds(se_sess);
+	target_remove_session(se_sess);
+
+	kfree(node->tgt_node);
+
+	node->tgt_node = NULL;
+	efc_scsi_del_initiator_complete(node->efc, node);
+
+	kfree(wq_data);
+}
+
+/* Called by the libefc when an initiator goes away. */
+int efct_scsi_del_initiator(struct efc *efc, struct efc_node *node,
+			int reason)
+{
+	struct efct *efct = node->efc->base;
+	struct efct_lio_wq_data *wq_data;
+	int watermark;
+	int initiator_count;
+
+	if (reason == EFCT_SCSI_INITIATOR_MISSING)
+		return EFCT_SCSI_CALL_COMPLETE;
+
+	wq_data = kmalloc(sizeof(*wq_data), GFP_ATOMIC);
+	if (!wq_data)
+		return EFCT_SCSI_CALL_COMPLETE;
+
+	memset(wq_data, 0, sizeof(*wq_data));
+	wq_data->ptr = node;
+	wq_data->efct = efct;
+	INIT_WORK(&wq_data->work, efct_lio_remove_session);
+	queue_work(lio_wq, &wq_data->work);
+
+	/*
+	 * update IO watermark: decrement initiator count
+	 */
+	initiator_count =
+		atomic_sub_return(1, &efct->tgt_efct.initiator_count);
+	watermark = (efct->tgt_efct.watermark_max -
+			initiator_count * EFCT_IO_WATERMARK_PER_INITIATOR);
+	watermark = (efct->tgt_efct.watermark_min > watermark) ?
+			efct->tgt_efct.watermark_min : watermark;
+	atomic_set(&efct->tgt_efct.io_high_watermark, watermark);
+
+	return EFCT_SCSI_CALL_ASYNC;
+}
+
+int efct_scsi_recv_cmd(struct efct_io *io, uint64_t lun, u8 *cdb,
+		       u32 cdb_len, u32 flags)
+{
+	struct efct_scsi_tgt_io *ocp = &io->tgt_io;
+	struct efct *efct = io->efct;
+	char *ddir;
+	struct efct_scsi_tgt_node *tgt_node = NULL;
+	struct se_session *se_sess;
+	int rc = 0;
+
+	memset(ocp, 0, sizeof(struct efct_scsi_tgt_io));
+	efct_set_lio_io_state(io, EFCT_LIO_STATE_SCSI_RECV_CMD);
+	atomic_add_return(1, &efct->tgt_efct.ios_in_use);
+
+	/* set target timeout */
+	io->timeout = efct->target_io_timer_sec;
+
+	if (flags & EFCT_SCSI_CMD_SIMPLE)
+		ocp->task_attr = TCM_SIMPLE_TAG;
+	else if (flags & EFCT_SCSI_CMD_HEAD_OF_QUEUE)
+		ocp->task_attr = TCM_HEAD_TAG;
+	else if (flags & EFCT_SCSI_CMD_ORDERED)
+		ocp->task_attr = TCM_ORDERED_TAG;
+	else if (flags & EFCT_SCSI_CMD_ACA)
+		ocp->task_attr = TCM_ACA_TAG;
+
+	switch (flags & (EFCT_SCSI_CMD_DIR_IN | EFCT_SCSI_CMD_DIR_OUT)) {
+	case EFCT_SCSI_CMD_DIR_IN:
+		ddir = "FROM_INITIATOR";
+		ocp->ddir = DMA_TO_DEVICE;
+		break;
+	case EFCT_SCSI_CMD_DIR_OUT:
+		ddir = "TO_INITIATOR";
+		ocp->ddir = DMA_FROM_DEVICE;
+		break;
+	case EFCT_SCSI_CMD_DIR_IN | EFCT_SCSI_CMD_DIR_OUT:
+		ddir = "BIDIR";
+		ocp->ddir = DMA_BIDIRECTIONAL;
+		break;
+	default:
+		ddir = "NONE";
+		ocp->ddir = DMA_NONE;
+		break;
+	}
+
+	ocp->cdb_opcode = cdb[0];
+	ocp->cdb_len = cdb_len;
+	ocp->lun = lun;
+	efct_lio_io_printf(io, "new cmd=0x%x ddir=%s dl=%u\n",
+			  cdb[0], ddir, io->exp_xfer_len);
+
+	tgt_node = io->node->tgt_node;
+	se_sess = tgt_node->session;
+	if (se_sess) {
+		efct_set_lio_io_state(io, EFCT_LIO_STATE_TGT_SUBMIT_CMD);
+		rc = target_submit_cmd(&io->tgt_io.cmd, se_sess,
+				       cdb, &io->tgt_io.sense_buffer[0],
+				       ocp->lun, io->exp_xfer_len,
+				       ocp->task_attr, ocp->ddir,
+				       TARGET_SCF_ACK_KREF);
+		if (rc) {
+			efc_log_err(efct, "failed to submit cmd se_cmd: %p\n",
+				    &ocp->cmd);
+			efct_scsi_io_free(io);
+		}
+	}
+
+	return rc;
+}
+
+int
+efct_scsi_recv_tmf(struct efct_io *tmfio, u32 lun,
+		   enum efct_scsi_tmf_cmd cmd,
+		  struct efct_io *io_to_abort, u32 flags)
+{
+	unsigned char tmr_func;
+	struct efct *efct = tmfio->efct;
+	struct efct_scsi_tgt_io *ocp = &tmfio->tgt_io;
+	struct efct_scsi_tgt_node *tgt_node = NULL;
+	struct se_session *se_sess;
+	int rc;
+
+	memset(ocp, 0, sizeof(struct efct_scsi_tgt_io));
+	efct_set_lio_io_state(tmfio, EFCT_LIO_STATE_SCSI_RECV_TMF);
+	atomic_add_return(1, &efct->tgt_efct.ios_in_use);
+	efct_lio_tmfio_printf(tmfio, "%s: new tmf %x lun=%u\n",
+			      tmfio->display_name, cmd, lun);
+
+	switch (cmd) {
+	case EFCT_SCSI_TMF_ABORT_TASK:
+		tmr_func = TMR_ABORT_TASK;
+		break;
+	case EFCT_SCSI_TMF_ABORT_TASK_SET:
+		tmr_func = TMR_ABORT_TASK_SET;
+		break;
+	case EFCT_SCSI_TMF_CLEAR_TASK_SET:
+		tmr_func = TMR_CLEAR_TASK_SET;
+		break;
+	case EFCT_SCSI_TMF_LOGICAL_UNIT_RESET:
+		tmr_func = TMR_LUN_RESET;
+		break;
+	case EFCT_SCSI_TMF_CLEAR_ACA:
+		tmr_func = TMR_CLEAR_ACA;
+		break;
+	case EFCT_SCSI_TMF_TARGET_RESET:
+		tmr_func = TMR_TARGET_WARM_RESET;
+		break;
+	case EFCT_SCSI_TMF_QUERY_ASYNCHRONOUS_EVENT:
+	case EFCT_SCSI_TMF_QUERY_TASK_SET:
+	default:
+		goto tmf_fail;
+	}
+
+	tmfio->tgt_io.tmf = tmr_func;
+	tmfio->tgt_io.lun = lun;
+	tmfio->tgt_io.io_to_abort = io_to_abort;
+
+	tgt_node = tmfio->node->tgt_node;
+
+	se_sess = tgt_node->session;
+	if (!se_sess)
+		return 0;
+
+	rc = target_submit_tmr(&ocp->cmd, se_sess, NULL, lun, ocp, tmr_func,
+			GFP_ATOMIC, tmfio->init_task_tag, TARGET_SCF_ACK_KREF);
+
+	efct_set_lio_io_state(tmfio, EFCT_LIO_STATE_TGT_SUBMIT_TMR);
+	if (rc)
+		goto tmf_fail;
+
+	return 0;
+
+tmf_fail:
+	efct_scsi_send_tmf_resp(tmfio, EFCT_SCSI_TMF_FUNCTION_REJECTED,
+				NULL, efct_lio_null_tmf_done, NULL);
+	return 0;
+}
+
+/* Start items for efct_lio_tpg_attrib_cit */
+
+#define DEF_EFCT_TPG_ATTRIB(name)					  \
+									  \
+static ssize_t efct_lio_tpg_attrib_##name##_show(			  \
+		struct config_item *item, char *page)			  \
+{									  \
+	struct se_portal_group *se_tpg = to_tpg(item);			  \
+	struct efct_lio_tpg *tpg = container_of(se_tpg,			  \
+			struct efct_lio_tpg, tpg);			  \
+									  \
+	return sprintf(page, "%u\n", tpg->tpg_attrib.name);		  \
+}									  \
+									  \
+static ssize_t efct_lio_tpg_attrib_##name##_store(			  \
+		struct config_item *item, const char *page, size_t count) \
+{									  \
+	struct se_portal_group *se_tpg = to_tpg(item);			  \
+	struct efct_lio_tpg *tpg = container_of(se_tpg,			  \
+					struct efct_lio_tpg, tpg);	  \
+	struct efct_lio_tpg_attrib *a = &tpg->tpg_attrib;		  \
+	unsigned long val;						  \
+	int ret;							  \
+									  \
+	ret = kstrtoul(page, 0, &val);					  \
+	if (ret < 0) {							  \
+		pr_err("kstrtoul() failed with ret: %d\n", ret);	  \
+		return -EINVAL;						  \
+	}								  \
+									  \
+	if (val != 0 && val != 1) {					  \
+		pr_err("Illegal boolean value %lu\n", val);		  \
+		return -EINVAL;						  \
+	}								  \
+									  \
+	a->name = val;							  \
+									  \
+	return count;							  \
+}									  \
+CONFIGFS_ATTR(efct_lio_tpg_attrib_, name)
+
+DEF_EFCT_TPG_ATTRIB(generate_node_acls);
+DEF_EFCT_TPG_ATTRIB(cache_dynamic_acls);
+DEF_EFCT_TPG_ATTRIB(demo_mode_write_protect);
+DEF_EFCT_TPG_ATTRIB(prod_mode_write_protect);
+DEF_EFCT_TPG_ATTRIB(demo_mode_login_only);
+DEF_EFCT_TPG_ATTRIB(session_deletion_wait);
+
+static struct configfs_attribute *efct_lio_tpg_attrib_attrs[] = {
+	&efct_lio_tpg_attrib_attr_generate_node_acls,
+	&efct_lio_tpg_attrib_attr_cache_dynamic_acls,
+	&efct_lio_tpg_attrib_attr_demo_mode_write_protect,
+	&efct_lio_tpg_attrib_attr_prod_mode_write_protect,
+	&efct_lio_tpg_attrib_attr_demo_mode_login_only,
+	&efct_lio_tpg_attrib_attr_session_deletion_wait,
+	NULL,
+};
+
+#define DEF_EFCT_NPIV_TPG_ATTRIB(name)					   \
+									   \
+static ssize_t efct_lio_npiv_tpg_attrib_##name##_show(			   \
+		struct config_item *item, char *page)			   \
+{									   \
+	struct se_portal_group *se_tpg = to_tpg(item);			   \
+	struct efct_lio_tpg *tpg = container_of(se_tpg,			   \
+			struct efct_lio_tpg, tpg);			   \
+									   \
+	return sprintf(page, "%u\n", tpg->tpg_attrib.name);		   \
+}									   \
+									   \
+static ssize_t efct_lio_npiv_tpg_attrib_##name##_store(			   \
+		struct config_item *item, const char *page, size_t count)  \
+{									   \
+	struct se_portal_group *se_tpg = to_tpg(item);			   \
+	struct efct_lio_tpg *tpg = container_of(se_tpg,			   \
+			struct efct_lio_tpg, tpg);			   \
+	struct efct_lio_tpg_attrib *a = &tpg->tpg_attrib;		   \
+	unsigned long val;						   \
+	int ret;							   \
+									   \
+	ret = kstrtoul(page, 0, &val);					   \
+	if (ret < 0) {							   \
+		pr_err("kstrtoul() failed with ret: %d\n", ret);	   \
+		return -EINVAL;						   \
+	}								   \
+									   \
+	if (val != 0 && val != 1) {					   \
+		pr_err("Illegal boolean value %lu\n", val);		   \
+		return -EINVAL;						   \
+	}								   \
+									   \
+	a->name = val;							   \
+									   \
+	return count;							   \
+}									   \
+CONFIGFS_ATTR(efct_lio_npiv_tpg_attrib_, name)
+
+DEF_EFCT_NPIV_TPG_ATTRIB(generate_node_acls);
+DEF_EFCT_NPIV_TPG_ATTRIB(cache_dynamic_acls);
+DEF_EFCT_NPIV_TPG_ATTRIB(demo_mode_write_protect);
+DEF_EFCT_NPIV_TPG_ATTRIB(prod_mode_write_protect);
+DEF_EFCT_NPIV_TPG_ATTRIB(demo_mode_login_only);
+DEF_EFCT_NPIV_TPG_ATTRIB(session_deletion_wait);
+
+static struct configfs_attribute *efct_lio_npiv_tpg_attrib_attrs[] = {
+	&efct_lio_npiv_tpg_attrib_attr_generate_node_acls,
+	&efct_lio_npiv_tpg_attrib_attr_cache_dynamic_acls,
+	&efct_lio_npiv_tpg_attrib_attr_demo_mode_write_protect,
+	&efct_lio_npiv_tpg_attrib_attr_prod_mode_write_protect,
+	&efct_lio_npiv_tpg_attrib_attr_demo_mode_login_only,
+	&efct_lio_npiv_tpg_attrib_attr_session_deletion_wait,
+	NULL,
+};
+
+CONFIGFS_ATTR(efct_lio_tpg_, enable);
+static struct configfs_attribute *efct_lio_tpg_attrs[] = {
+				&efct_lio_tpg_attr_enable, NULL };
+CONFIGFS_ATTR(efct_lio_npiv_tpg_, enable);
+static struct configfs_attribute *efct_lio_npiv_tpg_attrs[] = {
+				&efct_lio_npiv_tpg_attr_enable, NULL };
+
+static const struct target_core_fabric_ops efct_lio_ops = {
+	.module				= THIS_MODULE,
+	.fabric_name			= "efct",
+	.node_acl_size			= sizeof(struct efct_lio_nacl),
+	.max_data_sg_nents		= 65535,
+	.tpg_get_wwn			= efct_lio_get_fabric_wwn,
+	.tpg_get_tag			= efct_lio_get_tag,
+	.fabric_init_nodeacl		= efct_lio_init_nodeacl,
+	.tpg_check_demo_mode		= efct_lio_check_demo_mode,
+	.tpg_check_demo_mode_cache      = efct_lio_check_demo_mode_cache,
+	.tpg_check_demo_mode_write_protect = efct_lio_check_demo_write_protect,
+	.tpg_check_prod_mode_write_protect = efct_lio_check_prod_write_protect,
+	.tpg_get_inst_index		= efct_lio_tpg_get_inst_index,
+	.check_stop_free		= efct_lio_check_stop_free,
+	.aborted_task			= efct_lio_aborted_task,
+	.release_cmd			= efct_lio_release_cmd,
+	.close_session			= efct_lio_close_session,
+	.sess_get_index			= efct_lio_sess_get_index,
+	.write_pending			= efct_lio_write_pending,
+	.set_default_node_attributes	= efct_lio_set_default_node_attrs,
+	.get_cmd_state			= efct_lio_get_cmd_state,
+	.queue_data_in			= efct_lio_queue_data_in,
+	.queue_status			= efct_lio_queue_status,
+	.queue_tm_rsp			= efct_lio_queue_tm_rsp,
+	.fabric_make_wwn		= efct_lio_make_sport,
+	.fabric_drop_wwn		= efct_lio_drop_sport,
+	.fabric_make_tpg		= efct_lio_make_tpg,
+	.fabric_drop_tpg		= efct_lio_drop_tpg,
+	.tpg_check_demo_mode_login_only = efct_lio_check_demo_mode_login_only,
+	.tpg_check_prot_fabric_only	= NULL,
+	.sess_get_initiator_sid		= NULL,
+	.tfc_tpg_base_attrs		= efct_lio_tpg_attrs,
+	.tfc_tpg_attrib_attrs           = efct_lio_tpg_attrib_attrs,
+};
+
+static const struct target_core_fabric_ops efct_lio_npiv_ops = {
+	.module				= THIS_MODULE,
+	.fabric_name			= "efct_npiv",
+	.node_acl_size			= sizeof(struct efct_lio_nacl),
+	.max_data_sg_nents		= 65535,
+	.tpg_get_wwn			= efct_lio_get_npiv_fabric_wwn,
+	.tpg_get_tag			= efct_lio_get_npiv_tag,
+	.fabric_init_nodeacl		= efct_lio_init_nodeacl,
+	.tpg_check_demo_mode		= efct_lio_check_demo_mode,
+	.tpg_check_demo_mode_cache      = efct_lio_check_demo_mode_cache,
+	.tpg_check_demo_mode_write_protect =
+					efct_lio_npiv_check_demo_write_protect,
+	.tpg_check_prod_mode_write_protect =
+					efct_lio_npiv_check_prod_write_protect,
+	.tpg_get_inst_index		= efct_lio_tpg_get_inst_index,
+	.check_stop_free		= efct_lio_check_stop_free,
+	.aborted_task			= efct_lio_aborted_task,
+	.release_cmd			= efct_lio_release_cmd,
+	.close_session			= efct_lio_close_session,
+	.sess_get_index			= efct_lio_sess_get_index,
+	.write_pending			= efct_lio_write_pending,
+	.set_default_node_attributes	= efct_lio_set_default_node_attrs,
+	.get_cmd_state			= efct_lio_get_cmd_state,
+	.queue_data_in			= efct_lio_queue_data_in,
+	.queue_status			= efct_lio_queue_status,
+	.queue_tm_rsp			= efct_lio_queue_tm_rsp,
+	.fabric_make_wwn		= efct_lio_npiv_make_sport,
+	.fabric_drop_wwn		= efct_lio_npiv_drop_sport,
+	.fabric_make_tpg		= efct_lio_npiv_make_tpg,
+	.fabric_drop_tpg		= efct_lio_npiv_drop_tpg,
+	.tpg_check_demo_mode_login_only =
+				efct_lio_npiv_check_demo_mode_login_only,
+	.tpg_check_prot_fabric_only	= NULL,
+	.sess_get_initiator_sid		= NULL,
+	.tfc_tpg_base_attrs		= efct_lio_npiv_tpg_attrs,
+	.tfc_tpg_attrib_attrs		= efct_lio_npiv_tpg_attrib_attrs,
+};
+
+int efct_scsi_tgt_driver_init(void)
+{
+	int rc;
+
+	/* Register the top level struct config_item_type with TCM core */
+	rc = target_register_template(&efct_lio_ops);
+	if (rc < 0) {
+		pr_err("target_fabric_configfs_register failed with %d\n", rc);
+		return rc;
+	}
+	rc = target_register_template(&efct_lio_npiv_ops);
+	if (rc < 0) {
+		pr_err("target_fabric_configfs_register failed with %d\n", rc);
+		target_unregister_template(&efct_lio_ops);
+		return rc;
+	}
+	return 0;
+}
+
+int efct_scsi_tgt_driver_exit(void)
+{
+	target_unregister_template(&efct_lio_ops);
+	target_unregister_template(&efct_lio_npiv_ops);
+	return 0;
+}
diff --git a/drivers/scsi/elx/efct/efct_lio.h b/drivers/scsi/elx/efct/efct_lio.h
new file mode 100644
index 000000000000..66d3790bea45
--- /dev/null
+++ b/drivers/scsi/elx/efct/efct_lio.h
@@ -0,0 +1,192 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019 Broadcom. All Rights Reserved. The term
+ * “Broadcom” refers to Broadcom Inc. and/or its subsidiaries.
+ */
+
+#ifndef __EFCT_LIO_H__
+#define __EFCT_LIO_H__
+
+#include "efct_scsi.h"
+#include <target/target_core_base.h>
+
+#define efct_lio_io_printf(io, fmt, ...) \
+	efc_log_debug(io->efct, \
+		"[%s] [%04x][i:%04x t:%04x h:%04x][c:%02x]" fmt, \
+		io->node->display_name, io->instance_index, \
+		io->init_task_tag, io->tgt_task_tag, io->hw_tag, \
+		io->tgt_io.cdb_opcode, ##__VA_ARGS__)
+
+#define efct_lio_tmfio_printf(io, fmt, ...) \
+	efc_log_debug(io->efct, \
+		"[%s] [%04x][i:%04x t:%04x h:%04x][f:%02x]" fmt, \
+		io->node->display_name, io->instance_index, \
+		io->init_task_tag, io->tgt_task_tag, io->hw_tag, \
+		io->tgt_io.tmf,  ##__VA_ARGS__)
+
+#define efct_set_lio_io_state(io, value) (io->tgt_io.state |= value)
+
+struct efct_lio_wq_data {
+	struct efct		*efct;
+	void			*ptr;
+	struct work_struct	work;
+};
+
+/* Target private efct structure */
+struct efct_scsi_tgt {
+	u32			max_sge;
+	u32			max_sgl;
+
+	/*
+	 * Variables used to send task set full. We are using a high watermark
+	 * method to send task set full. We will reserve a fixed number of IOs
+	 * per initiator plus a fudge factor. Once we reach this number,
+	 * then the target will start sending task set full/busy responses.
+	 */
+	atomic_t		initiator_count;
+	atomic_t		ios_in_use;
+	atomic_t		io_high_watermark;
+
+	atomic_t		watermark_hit;
+	int			watermark_min;
+	int			watermark_max;
+
+	struct efct_lio_sport	*lio_sport;
+	struct efct_lio_tpg	*tpg;
+
+	struct list_head	vport_pend_list;
+	struct list_head	vport_list;
+	/* Protects vport list*/
+	spinlock_t		efct_lio_lock;
+
+	u64			wwnn;
+};
+
+struct efct_scsi_tgt_sport {
+	struct efct_lio_sport	*lio_sport;
+};
+
+struct efct_scsi_tgt_node {
+	struct se_session	*session;
+};
+
+#define EFCT_LIO_STATE_SCSI_RECV_CMD		(1 << 0)
+#define EFCT_LIO_STATE_TGT_SUBMIT_CMD		(1 << 1)
+#define EFCT_LIO_STATE_TFO_QUEUE_DATA_IN	(1 << 2)
+#define EFCT_LIO_STATE_TFO_WRITE_PENDING	(1 << 3)
+#define EFCT_LIO_STATE_TGT_EXECUTE_CMD		(1 << 4)
+#define EFCT_LIO_STATE_SCSI_SEND_RD_DATA	(1 << 5)
+#define EFCT_LIO_STATE_TFO_CHK_STOP_FREE	(1 << 6)
+#define EFCT_LIO_STATE_SCSI_DATA_DONE		(1 << 7)
+#define EFCT_LIO_STATE_TFO_QUEUE_STATUS		(1 << 8)
+#define EFCT_LIO_STATE_SCSI_SEND_RSP		(1 << 9)
+#define EFCT_LIO_STATE_SCSI_RSP_DONE		(1 << 10)
+#define EFCT_LIO_STATE_TGT_GENERIC_FREE		(1 << 11)
+#define EFCT_LIO_STATE_SCSI_RECV_TMF		(1 << 12)
+#define EFCT_LIO_STATE_TGT_SUBMIT_TMR		(1 << 13)
+#define EFCT_LIO_STATE_TFO_WRITE_PEND_STATUS	(1 << 14)
+#define EFCT_LIO_STATE_TGT_GENERIC_REQ_FAILURE  (1 << 15)
+
+#define EFCT_LIO_STATE_TFO_ABORTED_TASK		(1 << 29)
+#define EFCT_LIO_STATE_TFO_RELEASE_CMD		(1 << 30)
+#define EFCT_LIO_STATE_SCSI_CMPL_CMD		(1 << 31)
+
+struct efct_scsi_tgt_io {
+	struct se_cmd		cmd;
+	unsigned char		sense_buffer[TRANSPORT_SENSE_BUFFER];
+	int			ddir;
+	int			task_attr;
+	u64			lun;
+
+	u32			state;
+	u8			cdb_opcode;
+	u8			tmf;
+	struct efct_io		*io_to_abort;
+	u32			cdb_len;
+	u32			seg_map_cnt;
+	u32			seg_cnt;
+	u32			cur_seg;
+	enum efct_scsi_io_status err;
+	bool			aborting;
+	bool			rsp_sent;
+	uint32_t		transferred_len;
+};
+
+/* Handler return codes */
+enum {
+	SCSI_HANDLER_DATAPHASE_STARTED = 1,
+	SCSI_HANDLER_RESP_STARTED,
+	SCSI_HANDLER_VALIDATED_DATAPHASE_STARTED,
+	SCSI_CMD_NOT_SUPPORTED,
+};
+
+#define WWN_NAME_LEN		32
+struct efct_lio_vport {
+	u64			wwpn;
+	u64			npiv_wwpn;
+	u64			npiv_wwnn;
+	unsigned char		wwpn_str[WWN_NAME_LEN];
+	struct se_wwn		vport_wwn;
+	struct efct_lio_tpg	*tpg;
+	struct efct		*efct;
+	struct dentry		*sessions;
+	struct Scsi_Host	*shost;
+	struct fc_vport		*fc_vport;
+	atomic_t		enable;
+};
+
+struct efct_lio_sport {
+	u64			wwpn;
+	unsigned char		wwpn_str[WWN_NAME_LEN];
+	struct se_wwn		sport_wwn;
+	struct efct_lio_tpg	*tpg;
+	struct efct		*efct;
+	struct dentry		*sessions;
+	atomic_t		enable;
+};
+
+struct efct_lio_tpg_attrib {
+	int			generate_node_acls;
+	int			cache_dynamic_acls;
+	int			demo_mode_write_protect;
+	int			prod_mode_write_protect;
+	int			demo_mode_login_only;
+	bool			session_deletion_wait;
+};
+
+struct efct_lio_tpg {
+	struct se_portal_group	tpg;
+	struct efct_lio_sport	*sport;
+	struct efct_lio_vport	*vport;
+	struct efct_lio_tpg_attrib tpg_attrib;
+	unsigned short		tpgt;
+	atomic_t		enabled;
+};
+
+struct efct_lio_nacl {
+	u64			nport_wwnn;
+	char			nport_name[WWN_NAME_LEN];
+	struct se_session	*session;
+	struct se_node_acl	se_node_acl;
+};
+
+struct efct_lio_vport_data_t {
+	struct list_head	list_entry;
+	bool			initiator_mode;
+	bool			target_mode;
+	u64			phy_wwpn;
+	u64			phy_wwnn;
+	u64			vport_wwpn;
+	u64			vport_wwnn;
+	struct efct_lio_vport	*lio_vport;
+};
+
+struct efct_lio_vport_list_t {
+	struct list_head	list_entry;
+	struct efct_lio_vport	*lio_vport;
+};
+
+int efct_scsi_tgt_driver_init(void);
+int efct_scsi_tgt_driver_exit(void);
+
+#endif /*__EFCT_LIO_H__ */
-- 
2.13.7

