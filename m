Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B78E2C4419
	for <lists+linux-scsi@lfdr.de>; Wed, 25 Nov 2020 16:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbgKYPky (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 25 Nov 2020 10:40:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:55226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730910AbgKYPhI (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 25 Nov 2020 10:37:08 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E178D221F8;
        Wed, 25 Nov 2020 15:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606318626;
        bh=vKN+smQs+O6NRO7xw/6qlFUKjZ99MLpoAhY7O11xeok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e6Xe9rEe1CNKwt62hov/qEp+pLQlVuAo0xTXWRavaVBnrbpCZFeNvlfzyz3Dwkr3U
         +vlzDdEiuqbgJINVauRoFGYrzeJsQEaMmq7cSeIeqT0WIg4QsYpGWXwG3wfUvNj+JZ
         bbv8kkpt004HV1cSHF1UOpLCz7a338uoXKt9f1kI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>,
        Maurizio Lombardi <mlombard@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 20/23] scsi: target: iscsi: Fix cmd abort fabric stop race
Date:   Wed, 25 Nov 2020 10:36:35 -0500
Message-Id: <20201125153638.810419-20-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201125153638.810419-1-sashal@kernel.org>
References: <20201125153638.810419-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Mike Christie <michael.christie@oracle.com>

[ Upstream commit f36199355c64a39fe82cfddc7623d827c7e050da ]

Maurizio found a race where the abort and cmd stop paths can race as
follows:

 1. thread1 runs iscsit_release_commands_from_conn and sets
    CMD_T_FABRIC_STOP.

 2. thread2 runs iscsit_aborted_task and then does __iscsit_free_cmd. It
    then returns from the aborted_task callout and we finish
    target_handle_abort and do:

    target_handle_abort -> transport_cmd_check_stop_to_fabric ->
	lio_check_stop_free -> target_put_sess_cmd

    The cmd is now freed.

 3. thread1 now finishes iscsit_release_commands_from_conn and runs
    iscsit_free_cmd while accessing a command we just released.

In __target_check_io_state we check for CMD_T_FABRIC_STOP and set the
CMD_T_ABORTED if the driver is not cleaning up the cmd because of a session
shutdown. However, iscsit_release_commands_from_conn only sets the
CMD_T_FABRIC_STOP and does not check to see if the abort path has claimed
completion ownership of the command.

This adds a check in iscsit_release_commands_from_conn so only the abort or
fabric stop path cleanup the command.

Link: https://lore.kernel.org/r/1605318378-9269-1-git-send-email-michael.christie@oracle.com
Reported-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: Maurizio Lombardi <mlombard@redhat.com>
Signed-off-by: Mike Christie <michael.christie@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/target/iscsi/iscsi_target.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index bca183369ad8b..3403667a9592f 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -483,8 +483,7 @@ EXPORT_SYMBOL(iscsit_queue_rsp);
 void iscsit_aborted_task(struct iscsi_conn *conn, struct iscsi_cmd *cmd)
 {
 	spin_lock_bh(&conn->cmd_lock);
-	if (!list_empty(&cmd->i_conn_node) &&
-	    !(cmd->se_cmd.transport_state & CMD_T_FABRIC_STOP))
+	if (!list_empty(&cmd->i_conn_node))
 		list_del_init(&cmd->i_conn_node);
 	spin_unlock_bh(&conn->cmd_lock);
 
@@ -4082,12 +4081,22 @@ static void iscsit_release_commands_from_conn(struct iscsi_conn *conn)
 	spin_lock_bh(&conn->cmd_lock);
 	list_splice_init(&conn->conn_cmd_list, &tmp_list);
 
-	list_for_each_entry(cmd, &tmp_list, i_conn_node) {
+	list_for_each_entry_safe(cmd, cmd_tmp, &tmp_list, i_conn_node) {
 		struct se_cmd *se_cmd = &cmd->se_cmd;
 
 		if (se_cmd->se_tfo != NULL) {
 			spin_lock_irq(&se_cmd->t_state_lock);
-			se_cmd->transport_state |= CMD_T_FABRIC_STOP;
+			if (se_cmd->transport_state & CMD_T_ABORTED) {
+				/*
+				 * LIO's abort path owns the cleanup for this,
+				 * so put it back on the list and let
+				 * aborted_task handle it.
+				 */
+				list_move_tail(&cmd->i_conn_node,
+					       &conn->conn_cmd_list);
+			} else {
+				se_cmd->transport_state |= CMD_T_FABRIC_STOP;
+			}
 			spin_unlock_irq(&se_cmd->t_state_lock);
 		}
 	}
-- 
2.27.0

