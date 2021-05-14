Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774AF380857
	for <lists+linux-scsi@lfdr.de>; Fri, 14 May 2021 13:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhENLUD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 14 May 2021 07:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhENLUC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 14 May 2021 07:20:02 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72912C061574;
        Fri, 14 May 2021 04:18:51 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id n25so34303649edr.5;
        Fri, 14 May 2021 04:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NAmvbClEY+mrStLUW/u8Ax+hJj9P6K93jHMPCPzSQiY=;
        b=HKLbKcnZkXjPpZjGQVHRP5QTP/Yh5Cir45Yfgyc72ZxJGzEg4nDHuZUrlUJg79CXuM
         /VvnT2+/PSliUzKqDAjUtydNNGeb1HjpjIhWyBsRXMSZPDLD2RCoYUevobWGdUOJ/jbb
         zAny4CSlUMCogD1w6GLGxb+IO3mbKdDlB+7n4Ka5Xb0Nl7xlohKy0fucCbGkVxo9/YGr
         PTzox9goQhwkykwNCNzVMR8oMN+3w/bew/Jj4SVImzhs3gbBh+ekvwAcXAVnY9D2iLOY
         wcVzw63nGYFS6MPQZl8ZW2tnQhKNpnRl4rdE5H8MBt5H6AluGF/CA3jkEFwYUWDx7zRG
         75mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NAmvbClEY+mrStLUW/u8Ax+hJj9P6K93jHMPCPzSQiY=;
        b=TlMXH4eY01664wXiZfZkrBE/dQ6E9tYftFdJfkpRaJ8UTV37ayA3Z7ro8EpZ3ef2og
         CeIz32KiSilFK7O+n9J79TZ6+UECBKzcZtB++9vUrzfRa6Y8RB1VI7CZxAP3sjTv63X6
         kN/Gc+8ht9ySPvO5SKky6GCeNmRIKIjBzdKwUCZoOeGsj4UrKAipVytWtZ6Z40wGBt5B
         IajMtQ78pQdhkxXlhmuf2FuBnzvW7OvB/dwcL5WHCEFWSKRScMWYkjZ69dzzhQLdf+IV
         jJ6+W/u1KUerENl1WpJNPBjtllPVBoMSBGVUuBmTOazDicbsNI95V1RMGpiBfBQd2nRN
         Ygnw==
X-Gm-Message-State: AOAM532XZPYKR8o5a6UaG+EQ4GvHmfzCIuaxXBnR/g+Gl0xG+kjRctoc
        4JtXx+ksK1R/Z7ezvz/E3bCFgpiiwDc=
X-Google-Smtp-Source: ABdhPJxIdni7v2RNLJSK4SpshN7gu8XtYIaezZ5r32e/aQIfKw7BYtfBibGHJWgvjVAjiAXZErT+Qg==
X-Received: by 2002:a50:ff0a:: with SMTP id a10mr10110986edu.273.1620991130150;
        Fri, 14 May 2021 04:18:50 -0700 (PDT)
Received: from localhost (ipbcc11466.dynamic.kabel-deutschland.de. [188.193.20.102])
        by smtp.gmail.com with ESMTPSA id v18sm3219601ejg.63.2021.05.14.04.18.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 04:18:49 -0700 (PDT)
From:   Bodo Stroesser <bostroesser@gmail.com>
To:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Bodo Stroesser <bostroesser@gmail.com>
Subject: [PATCH v4] scsi: target: tcmu: Add new feature KEEP_BUF
Date:   Fri, 14 May 2021 13:18:40 +0200
Message-Id: <20210514111840.26297-1-bostroesser@gmail.com>
X-Mailer: git-send-email 2.12.3
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

When running command pipelining for WRITE direction commands,
(e.g. tape device write) userspace sends cmd completion to cmd
ring before processing write data. In that case userspace has to
copy data before sending completion, because cmd completion also
implicitly releases the data buffer in data area.

The new feature KEEP_BUF allows userspace to optionally keep the
buffer after completion by setting new bit TCMU_UFLAG_KEEP_BUF in
tcmu_cmd_entry_hdr->uflags. In that case buffer has to be released
explicitly by writing the cmd_id to new action item free_kept_buf.

All kept buffers are released during reset_ring and if userspace
closes uio device (tcmu_release).

Signed-off-by: Bodo Stroesser <bostroesser@gmail.com>
---

v4: Fix wrong condition in tcmu_free_kept_buf_store, which was
    introduced in v3.

v3: Changed xarray lock handling in tcmu_free_kept_buf_store to
    avoid RCU lock warnings.
    
v2: During tcmu_dev_kref_release not only kill timed out commands,
    but also completed commands waiting for explicit buffer free
    (change in tcmu_check_and_free_pending_cmd).
    The change is necessary due to tcmu_release not being called
    during tcmu device removal if userspace holds uio dev open.

 drivers/target/target_core_user.c     | 150 +++++++++++++++++++++++++++++++---
 include/uapi/linux/target_core_user.h |   2 +
 2 files changed, 141 insertions(+), 11 deletions(-)

diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
index ee391c62f6e1..eb469c1c27c5 100644
--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -191,6 +191,7 @@ struct tcmu_cmd {
 	unsigned long deadline;
 
 #define TCMU_CMD_BIT_EXPIRED 0
+#define TCMU_CMD_BIT_KEEP_BUF 1
 	unsigned long flags;
 };
 
@@ -1317,11 +1318,13 @@ tcmu_tmr_notify(struct se_device *se_dev, enum tcm_tmreq_table tmf,
 	mutex_unlock(&udev->cmdr_lock);
 }
 
-static void tcmu_handle_completion(struct tcmu_cmd *cmd, struct tcmu_cmd_entry *entry)
+static bool tcmu_handle_completion(struct tcmu_cmd *cmd,
+				   struct tcmu_cmd_entry *entry, bool keep_buf)
 {
 	struct se_cmd *se_cmd = cmd->se_cmd;
 	struct tcmu_dev *udev = cmd->tcmu_dev;
 	bool read_len_valid = false;
+	bool ret = true;
 	uint32_t read_len;
 
 	/*
@@ -1332,6 +1335,13 @@ static void tcmu_handle_completion(struct tcmu_cmd *cmd, struct tcmu_cmd_entry *
 		WARN_ON_ONCE(se_cmd);
 		goto out;
 	}
+	if (test_bit(TCMU_CMD_BIT_KEEP_BUF, &cmd->flags)) {
+		pr_err("cmd_id %u already completed with KEEP_BUF, ring is broken\n",
+		       entry->hdr.cmd_id);
+		set_bit(TCMU_DEV_BIT_BROKEN, &udev->flags);
+		ret = false;
+		goto out;
+	}
 
 	list_del_init(&cmd->queue_entry);
 
@@ -1381,8 +1391,22 @@ static void tcmu_handle_completion(struct tcmu_cmd *cmd, struct tcmu_cmd_entry *
 		target_complete_cmd(cmd->se_cmd, entry->rsp.scsi_status);
 
 out:
-	tcmu_cmd_free_data(cmd, cmd->dbi_cnt);
-	tcmu_free_cmd(cmd);
+	if (!keep_buf) {
+		tcmu_cmd_free_data(cmd, cmd->dbi_cnt);
+		tcmu_free_cmd(cmd);
+	} else {
+		/*
+		 * Keep this command after completion, since userspace still
+		 * needs the data buffer. Mark it with TCMU_CMD_BIT_KEEP_BUF
+		 * and reset potential TCMU_CMD_BIT_EXPIRED, so we don't accept
+		 * a second completion later.
+		 * Userspace can free the buffer later by writing the cmd_id
+		 * to new action attribute free_kept_buf.
+		 */
+		clear_bit(TCMU_CMD_BIT_EXPIRED, &cmd->flags);
+		set_bit(TCMU_CMD_BIT_KEEP_BUF, &cmd->flags);
+	}
+	return ret;
 }
 
 static int tcmu_run_tmr_queue(struct tcmu_dev *udev)
@@ -1434,6 +1458,7 @@ static bool tcmu_handle_completions(struct tcmu_dev *udev)
 	while (udev->cmdr_last_cleaned != READ_ONCE(mb->cmd_tail)) {
 
 		struct tcmu_cmd_entry *entry = udev->cmdr + udev->cmdr_last_cleaned;
+		bool keep_buf;
 
 		/*
 		 * Flush max. up to end of cmd ring since current entry might
@@ -1455,7 +1480,11 @@ static bool tcmu_handle_completions(struct tcmu_dev *udev)
 		}
 		WARN_ON(tcmu_hdr_get_op(entry->hdr.len_op) != TCMU_OP_CMD);
 
-		cmd = xa_erase(&udev->commands, entry->hdr.cmd_id);
+		keep_buf = !!(entry->hdr.uflags & TCMU_UFLAG_KEEP_BUF);
+		if (keep_buf)
+			cmd = xa_load(&udev->commands, entry->hdr.cmd_id);
+		else
+			cmd = xa_erase(&udev->commands, entry->hdr.cmd_id);
 		if (!cmd) {
 			pr_err("cmd_id %u not found, ring is broken\n",
 			       entry->hdr.cmd_id);
@@ -1463,7 +1492,8 @@ static bool tcmu_handle_completions(struct tcmu_dev *udev)
 			return false;
 		}
 
-		tcmu_handle_completion(cmd, entry);
+		if (!tcmu_handle_completion(cmd, entry, keep_buf))
+			break;
 
 		UPDATE_HEAD(udev->cmdr_last_cleaned,
 			    tcmu_hdr_get_len(entry->hdr.len_op),
@@ -1621,7 +1651,8 @@ static void tcmu_dev_call_rcu(struct rcu_head *p)
 
 static int tcmu_check_and_free_pending_cmd(struct tcmu_cmd *cmd)
 {
-	if (test_bit(TCMU_CMD_BIT_EXPIRED, &cmd->flags)) {
+	if (test_bit(TCMU_CMD_BIT_EXPIRED, &cmd->flags) ||
+	    test_bit(TCMU_CMD_BIT_KEEP_BUF, &cmd->flags)) {
 		kmem_cache_free(tcmu_cmd_cache, cmd);
 		return 0;
 	}
@@ -1905,6 +1936,38 @@ static int tcmu_open(struct uio_info *info, struct inode *inode)
 static int tcmu_release(struct uio_info *info, struct inode *inode)
 {
 	struct tcmu_dev *udev = container_of(info, struct tcmu_dev, uio_info);
+	struct tcmu_cmd *cmd;
+	unsigned long i;
+	bool freed = false;
+
+	mutex_lock(&udev->cmdr_lock);
+
+	xa_for_each(&udev->commands, i, cmd) {
+		/* Cmds with KEEP_BUF set are no longer on the ring, but
+		 * userspace still holds the data buffer. If userspace closes
+		 * we implicitly free these cmds and buffers, since after new
+		 * open the (new ?) userspace cannot find the cmd in the ring
+		 * and thus never will release the buffer by writing cmd_id to
+		 * free_kept_buf action attribute.
+		 */
+		if (!test_bit(TCMU_CMD_BIT_KEEP_BUF, &cmd->flags))
+			continue;
+		pr_debug("removing KEEP_BUF cmd %u on dev %s from ring\n",
+			 cmd->cmd_id, udev->name);
+		freed = true;
+
+		xa_erase(&udev->commands, i);
+		tcmu_cmd_free_data(cmd, cmd->dbi_cnt);
+		tcmu_free_cmd(cmd);
+	}
+	/*
+	 * We only freed data space, not ring space. Therefore we dont call
+	 * run_tmr_queue, but call run_qfull_queue if tmr_list is empty.
+	 */
+	if (freed && list_empty(&udev->tmr_queue))
+		run_qfull_queue(udev, false);
+
+	mutex_unlock(&udev->cmdr_lock);
 
 	clear_bit(TCMU_DEV_BIT_OPEN, &udev->flags);
 
@@ -2149,7 +2212,8 @@ static int tcmu_configure_device(struct se_device *dev)
 	mb->version = TCMU_MAILBOX_VERSION;
 	mb->flags = TCMU_MAILBOX_FLAG_CAP_OOOC |
 		    TCMU_MAILBOX_FLAG_CAP_READ_LEN |
-		    TCMU_MAILBOX_FLAG_CAP_TMR;
+		    TCMU_MAILBOX_FLAG_CAP_TMR |
+		    TCMU_MAILBOX_FLAG_CAP_KEEP_BUF;
 	mb->cmdr_off = CMDR_OFF;
 	mb->cmdr_size = udev->cmdr_size;
 
@@ -2281,12 +2345,16 @@ static void tcmu_reset_ring(struct tcmu_dev *udev, u8 err_level)
 	mutex_lock(&udev->cmdr_lock);
 
 	xa_for_each(&udev->commands, i, cmd) {
-		pr_debug("removing cmd %u on dev %s from ring (is expired %d)\n",
-			  cmd->cmd_id, udev->name,
-			  test_bit(TCMU_CMD_BIT_EXPIRED, &cmd->flags));
+		pr_debug("removing cmd %u on dev %s from ring %s\n",
+			 cmd->cmd_id, udev->name,
+			 test_bit(TCMU_CMD_BIT_EXPIRED, &cmd->flags) ?
+			 "(is expired)" :
+			 (test_bit(TCMU_CMD_BIT_KEEP_BUF, &cmd->flags) ?
+			 "(is keep buffer)" : ""));
 
 		xa_erase(&udev->commands, i);
-		if (!test_bit(TCMU_CMD_BIT_EXPIRED, &cmd->flags)) {
+		if (!test_bit(TCMU_CMD_BIT_EXPIRED, &cmd->flags) &&
+		    !test_bit(TCMU_CMD_BIT_KEEP_BUF, &cmd->flags)) {
 			WARN_ON(!cmd->se_cmd);
 			list_del_init(&cmd->queue_entry);
 			cmd->se_cmd->priv = NULL;
@@ -2935,6 +3003,65 @@ static ssize_t tcmu_reset_ring_store(struct config_item *item, const char *page,
 }
 CONFIGFS_ATTR_WO(tcmu_, reset_ring);
 
+static ssize_t tcmu_free_kept_buf_store(struct config_item *item, const char *page,
+					size_t count)
+{
+	struct se_device *se_dev = container_of(to_config_group(item),
+						struct se_device,
+						dev_action_group);
+	struct tcmu_dev *udev = TCMU_DEV(se_dev);
+	struct tcmu_cmd *cmd;
+	u16 cmd_id;
+	int ret;
+
+	if (!target_dev_configured(&udev->se_dev)) {
+		pr_err("Device is not configured.\n");
+		return -EINVAL;
+	}
+
+	ret = kstrtou16(page, 0, &cmd_id);
+	if (ret < 0)
+		return ret;
+
+	mutex_lock(&udev->cmdr_lock);
+
+	{
+		XA_STATE(xas, &udev->commands, cmd_id);
+
+		xas_lock(&xas);
+		cmd = xas_load(&xas);
+		if (!cmd) {
+			pr_err("free_kept_buf: cmd_id %d not found\n", cmd_id);
+			count = -EINVAL;
+			xas_unlock(&xas);
+			goto out_unlock;
+		}
+		if (!test_bit(TCMU_CMD_BIT_KEEP_BUF, &cmd->flags)) {
+			pr_err("free_kept_buf: cmd_id %d was not completed with KEEP_BUF\n",
+			       cmd_id);
+			count = -EINVAL;
+			xas_unlock(&xas);
+			goto out_unlock;
+		}
+		xas_store(&xas, NULL);
+		xas_unlock(&xas);
+	}
+
+	tcmu_cmd_free_data(cmd, cmd->dbi_cnt);
+	tcmu_free_cmd(cmd);
+	/*
+	 * We only freed data space, not ring space. Therefore we dont call
+	 * run_tmr_queue, but call run_qfull_queue if tmr_list is empty.
+	 */
+	if (list_empty(&udev->tmr_queue))
+		run_qfull_queue(udev, false);
+
+out_unlock:
+	mutex_unlock(&udev->cmdr_lock);
+	return count;
+}
+CONFIGFS_ATTR_WO(tcmu_, free_kept_buf);
+
 static struct configfs_attribute *tcmu_attrib_attrs[] = {
 	&tcmu_attr_cmd_time_out,
 	&tcmu_attr_qfull_time_out,
@@ -2953,6 +3080,7 @@ static struct configfs_attribute **tcmu_attrs;
 static struct configfs_attribute *tcmu_action_attrs[] = {
 	&tcmu_attr_block_dev,
 	&tcmu_attr_reset_ring,
+	&tcmu_attr_free_kept_buf,
 	NULL,
 };
 
diff --git a/include/uapi/linux/target_core_user.h b/include/uapi/linux/target_core_user.h
index 95b1597f16ae..27ace512babd 100644
--- a/include/uapi/linux/target_core_user.h
+++ b/include/uapi/linux/target_core_user.h
@@ -46,6 +46,7 @@
 #define TCMU_MAILBOX_FLAG_CAP_OOOC (1 << 0) /* Out-of-order completions */
 #define TCMU_MAILBOX_FLAG_CAP_READ_LEN (1 << 1) /* Read data length */
 #define TCMU_MAILBOX_FLAG_CAP_TMR (1 << 2) /* TMR notifications */
+#define TCMU_MAILBOX_FLAG_CAP_KEEP_BUF (1<<3) /* Keep buf after cmd completion */
 
 struct tcmu_mailbox {
 	__u16 version;
@@ -75,6 +76,7 @@ struct tcmu_cmd_entry_hdr {
 	__u8 kflags;
 #define TCMU_UFLAG_UNKNOWN_OP 0x1
 #define TCMU_UFLAG_READ_LEN   0x2
+#define TCMU_UFLAG_KEEP_BUF   0x4
 	__u8 uflags;
 
 } __packed;
-- 
2.12.3

