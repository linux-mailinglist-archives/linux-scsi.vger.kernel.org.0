Return-Path: <linux-scsi+bounces-1958-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC6384122E
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Jan 2024 19:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C48DB1F27821
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Jan 2024 18:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9B915A498;
	Mon, 29 Jan 2024 18:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWkUFmC/"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B5976021;
	Mon, 29 Jan 2024 18:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706553312; cv=none; b=UxE2bBhC0qbidWxilOrfN5zqkq/BuHdvS3BlnsVQn2/hu7loZZPt7J4tExvhYvD8sdqiVqt4rhn5jOSHApZzbHZchYwibMlunq8aLanuYjXx+B6NiEtLZZu5RJ/OXMIMD3YGmRxsF6g5AY3ECTs55r1i+cf2INwFEakvVt5sv0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706553312; c=relaxed/simple;
	bh=l87KiJ170usvV5zSRSj06Qcf2I0kjoR1fXeN8IRGanI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mdGpCZkDk2Af4BTufI9HMKv+lil5xR0DlSuewflymyGRr1sz/xaP0ZxGvkBwpYFypr+vR64BUiKFY5LV2KFOGreswpVgUNWpqrG1QALMqsI6iz9LaiW2Rb+dH3X93m+UHpibtEiyHM7SlxHhbzQakkuXAr9PBr7sP5SfR8v2z70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWkUFmC/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693FEC43390;
	Mon, 29 Jan 2024 18:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706553312;
	bh=l87KiJ170usvV5zSRSj06Qcf2I0kjoR1fXeN8IRGanI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BWkUFmC/L0hNwmGobl7thyLMyE2q8g2ORy9VT/z1XRCN5OzDyWgqDV4szWTev7uTs
	 mrm4q2OwoVrknSdy66KY5+j02NkGRu8jpIdEA/HTTrYzFUK5ajup30TlQOwK6vzHQR
	 syoTgGNbtnF9Ht7ZOJhkTlb1S+bKyuXm4iyMXe61EcGlqDzcnJr1wXueA7JTpWwV0s
	 5mEn+KbC6Q+8N1IHAk/bkxyA76pXVQv9adPnczc2X/gjfOKNSJtOY94OJ5kDJ/09wL
	 ZQ6qLbRjcpUIEhJq80SXal3z8k2tUa9q5RlKHC/ai5AtjqcJp9/jTlIVG/VSPjbHJY
	 6ps3B4G8MiZ2g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Bogdanov <d.bogdanov@yadro.com>,
	Mike Christie <michael.christie@oracle.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 08/12] scsi: target: core: Add TMF to tmr_list handling
Date: Mon, 29 Jan 2024 13:34:17 -0500
Message-ID: <20240129183440.463998-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129183440.463998-1-sashal@kernel.org>
References: <20240129183440.463998-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.2
Content-Transfer-Encoding: 8bit

From: Dmitry Bogdanov <d.bogdanov@yadro.com>

[ Upstream commit 83ab68168a3d990d5ff39ab030ad5754cbbccb25 ]

An abort that is responded to by iSCSI itself is added to tmr_list but does
not go to target core. A LUN_RESET that goes through tmr_list takes a
refcounter on the abort and waits for completion. However, the abort will
be never complete because it was not started in target core.

 Unable to locate ITT: 0x05000000 on CID: 0
 Unable to locate RefTaskTag: 0x05000000 on CID: 0.
 wait_for_tasks: Stopping tmf LUN_RESET with tag 0x0 ref_task_tag 0x0 i_state 34 t_state ISTATE_PROCESSING refcnt 2 transport_state active,stop,fabric_stop
 wait for tasks: tmf LUN_RESET with tag 0x0 ref_task_tag 0x0 i_state 34 t_state ISTATE_PROCESSING refcnt 2 transport_state active,stop,fabric_stop
...
 INFO: task kworker/0:2:49 blocked for more than 491 seconds.
 task:kworker/0:2     state:D stack:    0 pid:   49 ppid:     2 flags:0x00000800
 Workqueue: events target_tmr_work [target_core_mod]
Call Trace:
 __switch_to+0x2c4/0x470
 _schedule+0x314/0x1730
 schedule+0x64/0x130
 schedule_timeout+0x168/0x430
 wait_for_completion+0x140/0x270
 target_put_cmd_and_wait+0x64/0xb0 [target_core_mod]
 core_tmr_lun_reset+0x30/0xa0 [target_core_mod]
 target_tmr_work+0xc8/0x1b0 [target_core_mod]
 process_one_work+0x2d4/0x5d0
 worker_thread+0x78/0x6c0

To fix this, only add abort to tmr_list if it will be handled by target
core.

Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
Link: https://lore.kernel.org/r/20240111125941.8688-1-d.bogdanov@yadro.com
Reviewed-by: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/target_core_device.c    | 5 -----
 drivers/target/target_core_transport.c | 4 ++++
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index 506193e870c4..7a85e6477e46 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -147,7 +147,6 @@ int transport_lookup_tmr_lun(struct se_cmd *se_cmd)
 	struct se_session *se_sess = se_cmd->se_sess;
 	struct se_node_acl *nacl = se_sess->se_node_acl;
 	struct se_tmr_req *se_tmr = se_cmd->se_tmr_req;
-	unsigned long flags;
 
 	rcu_read_lock();
 	deve = target_nacl_find_deve(nacl, se_cmd->orig_fe_lun);
@@ -178,10 +177,6 @@ int transport_lookup_tmr_lun(struct se_cmd *se_cmd)
 	se_cmd->se_dev = rcu_dereference_raw(se_lun->lun_se_dev);
 	se_tmr->tmr_dev = rcu_dereference_raw(se_lun->lun_se_dev);
 
-	spin_lock_irqsave(&se_tmr->tmr_dev->se_tmr_lock, flags);
-	list_add_tail(&se_tmr->tmr_list, &se_tmr->tmr_dev->dev_tmr_list);
-	spin_unlock_irqrestore(&se_tmr->tmr_dev->se_tmr_lock, flags);
-
 	return 0;
 }
 EXPORT_SYMBOL(transport_lookup_tmr_lun);
diff --git a/drivers/target/target_core_transport.c b/drivers/target/target_core_transport.c
index 670cfb7bd426..73d0d6133ac8 100644
--- a/drivers/target/target_core_transport.c
+++ b/drivers/target/target_core_transport.c
@@ -3629,6 +3629,10 @@ int transport_generic_handle_tmr(
 	unsigned long flags;
 	bool aborted = false;
 
+	spin_lock_irqsave(&cmd->se_dev->se_tmr_lock, flags);
+	list_add_tail(&cmd->se_tmr_req->tmr_list, &cmd->se_dev->dev_tmr_list);
+	spin_unlock_irqrestore(&cmd->se_dev->se_tmr_lock, flags);
+
 	spin_lock_irqsave(&cmd->t_state_lock, flags);
 	if (cmd->transport_state & CMD_T_ABORTED) {
 		aborted = true;
-- 
2.43.0


