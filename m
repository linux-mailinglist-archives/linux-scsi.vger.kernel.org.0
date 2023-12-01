Return-Path: <linux-scsi+bounces-387-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B8480029D
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Dec 2023 05:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD5DD28148A
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Dec 2023 04:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73560881E
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Dec 2023 04:34:43 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811C51718;
	Thu, 30 Nov 2023 19:00:16 -0800 (PST)
Received: from dggpemd100001.china.huawei.com (unknown [172.30.72.57])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ShHl545gtzsRSY;
	Fri,  1 Dec 2023 10:56:33 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 dggpemd100001.china.huawei.com (7.185.36.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Fri, 1 Dec 2023 11:00:14 +0800
From: Xingui Yang <yangxingui@huawei.com>
To: <john.g.garry@oracle.com>, <yanaijie@huawei.com>,
	<damien.lemoal@opensource.wdc.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<wubo40@huawei.com>, <kangfenglong@huawei.com>
Subject: [PATCH v2] scsi: libsas: Put the disk offline if all recovery actions fail
Date: Fri, 1 Dec 2023 02:57:17 +0000
Message-ID: <20231201025717.16264-1-yangxingui@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemd100001.china.huawei.com (7.185.36.94)
X-CFilter-Loop: Reflected

Currently, after all recovery actions in sas_eh_handle_sas_errors() fail
for sas disk, we just clear all IO, but the disk is still online. Perhaps
we should free sas_task and continue the subsequent recovery process for IO
that cannot be processed. If it still fails, the disk will be offline in
scsi_eh_ready_devs().

Signed-off-by: Xingui Yang <yangxingui@huawei.com>
Signed-off-by: Bo Wu <wubo40@huawei.com>
---
v1 -> v2:
1. Free the sas_task of the work_q.
---
 drivers/scsi/libsas/sas_scsi_host.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 9047cfcd1072..0cd3b92a299f 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -637,8 +637,8 @@ static void sas_eh_handle_sas_errors(struct Scsi_Host *shost, struct list_head *
 			       SAS_ADDR(task->dev->sas_addr),
 			       cmd->device->lun);
 
-			sas_eh_finish_cmd(cmd);
-			goto clear_q;
+			list_move_tail(&cmd->eh_entry, work_q);
+			goto free_q_task;
 		}
 	}
  out:
@@ -646,6 +646,15 @@ static void sas_eh_handle_sas_errors(struct Scsi_Host *shost, struct list_head *
 	list_splice_tail_init(&ha->eh_ata_q, work_q);
 	return;
 
+free_q_task:
+	pr_debug("--- Exit %s -- free_q_task\n", __func__);
+	list_for_each_entry_safe(cmd, n, work_q, eh_entry) {
+		struct sas_task *task = TO_SAS_TASK(cmd);
+
+		sas_end_task(cmd, task);
+	}
+	goto out;
+
  clear_q:
 	pr_debug("--- Exit %s -- clear_q\n", __func__);
 	list_for_each_entry_safe(cmd, n, work_q, eh_entry)
-- 
2.17.1


