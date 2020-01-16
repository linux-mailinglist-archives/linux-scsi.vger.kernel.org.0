Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5FDC13F141
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Jan 2020 19:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392281AbgAPR0R (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 16 Jan 2020 12:26:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:34886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392276AbgAPR0R (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 16 Jan 2020 12:26:17 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D84FF20730;
        Thu, 16 Jan 2020 17:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579195577;
        bh=8DDoQiOrvvIKFroA4z/RhkKhCGF4MSC6aNKkMx1JK84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NDI2iwCC5/XN0qPXzIpGOUx8EF4LLmm6Ndp98DMHaVf0fzdZ6V6Ew22wrKJ+CK6+9
         RjeMe7meeK6iQ5cZJ6KGC0iJ7czoeuqf3a/aLd7uMAg8ZwyhLvINGQZqc9CPRzM9Vg
         8uobCaLBt1JPWuKzgBeyEgHgau+q3aOnjRTatBP4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Mike Christie <mchristi@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Hannes Reinecke <hare@suse.com>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 159/371] scsi: target/core: Fix a race condition in the LUN lookup code
Date:   Thu, 16 Jan 2020 12:20:31 -0500
Message-Id: <20200116172403.18149-102-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit 63f7479439c95bcd49b7dd4af809862c316c71a3 ]

The rcu_dereference(deve->se_lun) expression occurs twice in the LUN lookup
functions. Since these expressions are not serialized against deve->se_lun
assignments each of these expressions may yield a different result. Avoid
that the wrong LUN pointer is stored in se_cmd by reading deve->se_lun only
once.

Cc: Mike Christie <mchristi@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Nicholas Bellinger <nab@linux-iscsi.org>
Fixes: 29a05deebf6c ("target: Convert se_node_acl->device_list[] to RCU hlist") # v4.10
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/target_core_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/target/target_core_device.c b/drivers/target/target_core_device.c
index 92b52d2314b5..cebef8e5a43d 100644
--- a/drivers/target/target_core_device.c
+++ b/drivers/target/target_core_device.c
@@ -85,7 +85,7 @@ transport_lookup_cmd_lun(struct se_cmd *se_cmd, u64 unpacked_lun)
 			goto out_unlock;
 		}
 
-		se_cmd->se_lun = rcu_dereference(deve->se_lun);
+		se_cmd->se_lun = se_lun;
 		se_cmd->pr_res_key = deve->pr_res_key;
 		se_cmd->orig_fe_lun = unpacked_lun;
 		se_cmd->se_cmd_flags |= SCF_SE_LUN_CMD;
@@ -176,7 +176,7 @@ int transport_lookup_tmr_lun(struct se_cmd *se_cmd, u64 unpacked_lun)
 			goto out_unlock;
 		}
 
-		se_cmd->se_lun = rcu_dereference(deve->se_lun);
+		se_cmd->se_lun = se_lun;
 		se_cmd->pr_res_key = deve->pr_res_key;
 		se_cmd->orig_fe_lun = unpacked_lun;
 		se_cmd->se_cmd_flags |= SCF_SE_LUN_CMD;
-- 
2.20.1

