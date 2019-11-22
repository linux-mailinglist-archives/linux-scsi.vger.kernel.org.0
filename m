Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 093B8106455
	for <lists+linux-scsi@lfdr.de>; Fri, 22 Nov 2019 07:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfKVGQs (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 22 Nov 2019 01:16:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:51068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729447AbfKVGNn (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 22 Nov 2019 01:13:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79D0D20715;
        Fri, 22 Nov 2019 06:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574403222;
        bh=+dhwOKoTwp3bRqCgfQD7aUTOSt0rDYzemDVM9IYjrdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QCrShE2l0X2mOwmruUeNLJwZp4RibpUN38Mzd6x6mXSrZbo8o1/J2cA0y5tMB9KAb
         S+6YjjW/cOn3yqPXAcjTP+xz3WMR34ukBJfduFJwszDy+iDZFHrHBSl7RxaqJ6TFGt
         8PEK21UjNQI96WN4jQOm7H9F0viZjRZgXD/zO6LE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anatoliy Glagolev <glagolig@gmail.com>,
        Himanshu Madhani <hmadhani@marvell.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 36/68] scsi: qla2xxx: deadlock by configfs_depend_item
Date:   Fri, 22 Nov 2019 01:12:29 -0500
Message-Id: <20191122061301.4947-35-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122061301.4947-1-sashal@kernel.org>
References: <20191122061301.4947-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Anatoliy Glagolev <glagolig@gmail.com>

[ Upstream commit 17b18eaa6f59044a5172db7d07149e31ede0f920 ]

The intent of invoking configfs_depend_item in commit 7474f52a82d51
("tcm_qla2xxx: Perform configfs depend/undepend for base_tpg")
was to prevent a physical Fibre Channel port removal when
virtual (NPIV) ports announced through that physical port are active.
The change does not work as expected: it makes enabled physical port
dependent on target configfs subsystem (the port's parent), something
the configfs guarantees anyway.

Besides, scheduling work in a worker thread and waiting for the work's
completion is not really a valid workaround for the requirement not to call
configfs_depend_item from a configfs callback: the call occasionally
deadlocks.

Thus, removing configfs_depend_item calls does not break anything and fixes
the deadlock problem.

Signed-off-by: Anatoliy Glagolev <glagolig@gmail.com>
Acked-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qla2xxx/tcm_qla2xxx.c | 48 +++++-------------------------
 drivers/scsi/qla2xxx/tcm_qla2xxx.h |  3 --
 2 files changed, 8 insertions(+), 43 deletions(-)

diff --git a/drivers/scsi/qla2xxx/tcm_qla2xxx.c b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
index 81af294f15a7d..b1233ce6cb475 100644
--- a/drivers/scsi/qla2xxx/tcm_qla2xxx.c
+++ b/drivers/scsi/qla2xxx/tcm_qla2xxx.c
@@ -793,38 +793,14 @@ static ssize_t tcm_qla2xxx_tpg_enable_show(struct config_item *item,
 			atomic_read(&tpg->lport_tpg_enabled));
 }
 
-static void tcm_qla2xxx_depend_tpg(struct work_struct *work)
-{
-	struct tcm_qla2xxx_tpg *base_tpg = container_of(work,
-				struct tcm_qla2xxx_tpg, tpg_base_work);
-	struct se_portal_group *se_tpg = &base_tpg->se_tpg;
-	struct scsi_qla_host *base_vha = base_tpg->lport->qla_vha;
-
-	if (!target_depend_item(&se_tpg->tpg_group.cg_item)) {
-		atomic_set(&base_tpg->lport_tpg_enabled, 1);
-		qlt_enable_vha(base_vha);
-	}
-	complete(&base_tpg->tpg_base_comp);
-}
-
-static void tcm_qla2xxx_undepend_tpg(struct work_struct *work)
-{
-	struct tcm_qla2xxx_tpg *base_tpg = container_of(work,
-				struct tcm_qla2xxx_tpg, tpg_base_work);
-	struct se_portal_group *se_tpg = &base_tpg->se_tpg;
-	struct scsi_qla_host *base_vha = base_tpg->lport->qla_vha;
-
-	if (!qlt_stop_phase1(base_vha->vha_tgt.qla_tgt)) {
-		atomic_set(&base_tpg->lport_tpg_enabled, 0);
-		target_undepend_item(&se_tpg->tpg_group.cg_item);
-	}
-	complete(&base_tpg->tpg_base_comp);
-}
-
 static ssize_t tcm_qla2xxx_tpg_enable_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct se_portal_group *se_tpg = to_tpg(item);
+	struct se_wwn *se_wwn = se_tpg->se_tpg_wwn;
+	struct tcm_qla2xxx_lport *lport = container_of(se_wwn,
+			struct tcm_qla2xxx_lport, lport_wwn);
+	struct scsi_qla_host *vha = lport->qla_vha;
 	struct tcm_qla2xxx_tpg *tpg = container_of(se_tpg,
 			struct tcm_qla2xxx_tpg, se_tpg);
 	unsigned long op;
@@ -843,24 +819,16 @@ static ssize_t tcm_qla2xxx_tpg_enable_store(struct config_item *item,
 		if (atomic_read(&tpg->lport_tpg_enabled))
 			return -EEXIST;
 
-		INIT_WORK(&tpg->tpg_base_work, tcm_qla2xxx_depend_tpg);
+		atomic_set(&tpg->lport_tpg_enabled, 1);
+		qlt_enable_vha(vha);
 	} else {
 		if (!atomic_read(&tpg->lport_tpg_enabled))
 			return count;
 
-		INIT_WORK(&tpg->tpg_base_work, tcm_qla2xxx_undepend_tpg);
+		atomic_set(&tpg->lport_tpg_enabled, 0);
+		qlt_stop_phase1(vha->vha_tgt.qla_tgt);
 	}
-	init_completion(&tpg->tpg_base_comp);
-	schedule_work(&tpg->tpg_base_work);
-	wait_for_completion(&tpg->tpg_base_comp);
 
-	if (op) {
-		if (!atomic_read(&tpg->lport_tpg_enabled))
-			return -ENODEV;
-	} else {
-		if (atomic_read(&tpg->lport_tpg_enabled))
-			return -EPERM;
-	}
 	return count;
 }
 
diff --git a/drivers/scsi/qla2xxx/tcm_qla2xxx.h b/drivers/scsi/qla2xxx/tcm_qla2xxx.h
index 3bbf4cb6fd97e..344f4eab5403c 100644
--- a/drivers/scsi/qla2xxx/tcm_qla2xxx.h
+++ b/drivers/scsi/qla2xxx/tcm_qla2xxx.h
@@ -47,9 +47,6 @@ struct tcm_qla2xxx_tpg {
 	struct tcm_qla2xxx_tpg_attrib tpg_attrib;
 	/* Returned by tcm_qla2xxx_make_tpg() */
 	struct se_portal_group se_tpg;
-	/* Items for dealing with configfs_depend_item */
-	struct completion tpg_base_comp;
-	struct work_struct tpg_base_work;
 };
 
 struct tcm_qla2xxx_fc_loopid {
-- 
2.20.1

