Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17AA17F537
	for <lists+linux-scsi@lfdr.de>; Fri,  2 Aug 2019 12:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbfHBKi7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 2 Aug 2019 06:38:59 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36476 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbfHBKi7 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 2 Aug 2019 06:38:59 -0400
Received: by mail-pl1-f193.google.com with SMTP id k8so33514791plt.3;
        Fri, 02 Aug 2019 03:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e4E4iDDaEWxYk44Dl3X7u2CSK86rWU28f6rz4PaFwgQ=;
        b=c8mY5/Y7W2lQCMx8ytsyVH4mgYIDLMxGPxo/ulv0efyAz/l9DhtoZCRVfZtulpCMpf
         rarpmQ3vmepmhWfBs++FeswM9anMdyrYQ0Kxj/LNCalVPdRgKhd1fyJpZDxwJsJgwtUU
         XpsaZDFdCRJJL1AfD868hQ1WaJ2pLZp0lc2dWUlcK2zmaeMWYt0GGcPNPIRCA11L2689
         dXpezlDH8EibWcOonFaU0eYNiRaj5m3f5Zp+7AOorvvdQziZpTpHSCOiu1BtebzzDbNl
         tCqf7uolEbcI7BFc7r5DJlri4AKGyz/nyb/A8QRTziu5xu3YA50uKS435oXPhx2E9rIc
         xpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e4E4iDDaEWxYk44Dl3X7u2CSK86rWU28f6rz4PaFwgQ=;
        b=nDR2bPHKcQqHMQOgijrG5cdYcE1z4elfGuJgTJLM/U1R84g6d4fK5BZpV/GQqUfHDZ
         7Do6KNE/5hYLh+jeAvHS7G2ZT5drPbvn48cYLGpy9lKKrX+aMBDazy/Hetr0TdUSwXZX
         1w1wCFT688zFDhDlYXuCf1zsbp6zHF+tYAtPmKstizAOjXZ5jNqCvbmB9Z1Ee0MbJKt5
         H0KFnI+0GkbSmEDbPIl00ZXtZAhxwQizi9uEsqnDQvi5htvPjRW9AYpuyo/I6V9j60Ax
         mZcUu5zI9rrw60wfX348amssG1x3hSRNjkml46jpCMf64R1vm0gDHkUaWnGqdpEOWNic
         sQZw==
X-Gm-Message-State: APjAAAX93Sj3jRBWNeGV0tXHtk6XW0Hf2jJ3uSnagawnHbsaWD2zyLZD
        f/loPkJpmmIKV/kDOwsixymHhpa8
X-Google-Smtp-Source: APXvYqxnl1Jt2TcCRuQFZrvNRna0aRcZxqEdjYEJgDyqBoeDcIwRP6j5vNpV1JHjyEPKLrDRgfwesw==
X-Received: by 2002:a17:902:9041:: with SMTP id w1mr17262022plz.132.1564742338100;
        Fri, 02 Aug 2019 03:38:58 -0700 (PDT)
Received: from k8s-VirtualBox.cn.ibm.com ([103.49.135.195])
        by smtp.gmail.com with ESMTPSA id c23sm67395405pgj.62.2019.08.02.03.38.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 03:38:57 -0700 (PDT)
From:   Li Zhong <lizhongfs@gmail.com>
To:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Cc:     martin.petersen@oracle.com, lizhongfs@gmail.com
Subject: [RFC PATCH] target: tcmu: clean the nl_cmd of the udev when nl send fails
Date:   Fri,  2 Aug 2019 18:38:30 +0800
Message-Id: <20190802103830.8881-1-lizhongfs@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

If the userspace process crashes while we send the nl msg, it is possible
that the cmd in curr_nl_cmd of tcmu_dev never gets reset to 0, and
and returns busy for other commands after the userspace process is
restartd.

More details below:

/backstores/user:file/file> set attribute dev_size=2048
Cannot set attribute dev_size: [Errno 3] No such process
/backstores/user:file/file> set attribute dev_size=2048
Cannot set attribute dev_size: [Errno 16] Device or resource busy

with following kernel messages:
[173605.747169] Unable to reconfigure device
[173616.686674] tcmu daemon: command reply support 1.
[173623.866978] netlink cmd 3 already executing on file
[173623.866984] Unable to reconfigure device

Also, it is not safe to leave the nl_cmd in the list, and not get
deleted.

This patch removes the nl_cmd from the list, and clear its data if
it is not sent successfully.

Signed-off-by: Li Zhong <lizhongfs@gmail.com>
---
 drivers/target/target_core_user.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
index 04eda111920e..4ae3103e204c 100644
--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -1708,6 +1708,24 @@ static int tcmu_init_genl_cmd_reply(struct tcmu_dev *udev, int cmd)
 	return 0;
 }
 
+static void tcmu_destroy_genl_cmd_reply(struct tcmu_dev *udev)
+{
+	struct tcmu_nl_cmd *nl_cmd = &udev->curr_nl_cmd;
+
+	if (!tcmu_kern_cmd_reply_supported)
+		return;
+
+	if (udev->nl_reply_supported <= 0)
+		return;
+
+	mutex_lock(&tcmu_nl_cmd_mutex);
+
+	list_del(&nl_cmd->nl_list);
+	memset(nl_cmd, 0, sizeof(*nl_cmd));
+
+	mutex_unlock(&tcmu_nl_cmd_mutex);
+}
+
 static int tcmu_wait_genl_cmd_reply(struct tcmu_dev *udev)
 {
 	struct tcmu_nl_cmd *nl_cmd = &udev->curr_nl_cmd;
@@ -1788,6 +1806,9 @@ static int tcmu_netlink_event_send(struct tcmu_dev *udev,
 	if (ret == 0 ||
 	   (ret == -ESRCH && cmd == TCMU_CMD_ADDED_DEVICE))
 		return tcmu_wait_genl_cmd_reply(udev);
+	else
+		/* If failure, remove from the list and clear the nl_cmd */
+		tcmu_destroy_genl_cmd_reply(udev);
 
 	return ret;
 }
-- 
2.20.1

