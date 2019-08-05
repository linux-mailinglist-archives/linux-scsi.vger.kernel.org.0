Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63D4E80FD3
	for <lists+linux-scsi@lfdr.de>; Mon,  5 Aug 2019 02:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfHEAn7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 4 Aug 2019 20:43:59 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35945 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfHEAn7 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 4 Aug 2019 20:43:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id l21so38753367pgm.3;
        Sun, 04 Aug 2019 17:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TgZ9+rbKeAVKT4OSxX6UTZLTIVp5FDzLdAz6+W1+EeM=;
        b=u2V97PcEo76l33qCbk2NupEBzVoIDm08juiRXRpFKbKu25eXEobqbwIrFCKHw2YHEg
         LqFWQtOG19Nv8AzldyXrcTaVGE28XUYTZLZxcmcGZ7jzqRdRuEbxlbkCgqtgQKl/+mNo
         YGEjiZ/IX6ai7dMXpm4jRhaBE4x2/mSMzdfEm2xYNFifgGh6WGzYrHbrxTmwuuYxjC6X
         h6QS5aayFPlvIBlqHKreAjLQLWYyzYS9VfsuYCcTw11u12K4MjR5HYRkQFMMzI391CQ2
         uBUHX22xJTV1miuxY3/qjt4iqk2CRalvWfGAr7Aa9sf46SqSVvYQaFaq1z2nKgsqgum4
         S/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TgZ9+rbKeAVKT4OSxX6UTZLTIVp5FDzLdAz6+W1+EeM=;
        b=s9s+VuDXyyZn0JaUFAcCwR/TLlHBmtH3Vh3pyI/QelZXT9EDNIxZHlvWsKjM6dM0Vu
         Ry9LaFTy0dCLqkpntOPyLmmDZixFEwK3sWVRAuCiV+caERX917s0mXOr5iffADmsyR9y
         AtX+Cru0TENZA+rlI5bajEDudfOJn/9t8/vfL6XZiStw4DoMkhxDx7bkzt8mWDztg7cb
         HsTO43EujnKDEwYeNAFVBnkZmN9c1H5afOrwKIadioV/t/JGtWaVY05L3oRKe65Jmoqk
         GQPfUjqllsywaXMVKnsSRQgsHb/6ZZCo7uEVnGWqIrB4vdCYSYcj+6sUt3yqzOa3qvK1
         bdBg==
X-Gm-Message-State: APjAAAWzrLVgdSFmz2mDXbq4dLh435jXgsVmkj1SEfizpjM3sDDExJpa
        NEu45kul04yKe5D4TkDvJu2lAgIp
X-Google-Smtp-Source: APXvYqyNZyPx2u6uQ/oDlTxjnuOWY8+Dxcu1HQLLFuAXuaWn37qCEIcLhdsoXBlTrAQRXfmdFMO5AA==
X-Received: by 2002:a62:e403:: with SMTP id r3mr67570752pfh.37.1564965838155;
        Sun, 04 Aug 2019 17:43:58 -0700 (PDT)
Received: from k8s-VirtualBox.cn.ibm.com ([103.49.135.195])
        by smtp.gmail.com with ESMTPSA id 85sm87257202pfv.130.2019.08.04.17.43.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 04 Aug 2019 17:43:57 -0700 (PDT)
From:   Li Zhong <lizhongfs@gmail.com>
To:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Cc:     martin.petersen@oracle.com, lizhongfs@gmail.com,
        mchristi@redhat.com
Subject: [RFC PATCH v2] target: tcmu: clean the nl_cmd of the udev when nl send fails
Date:   Mon,  5 Aug 2019 08:43:36 +0800
Message-Id: <20190805004336.16181-1-lizhongfs@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <5D446BC2.9000303@redhat.com>
References: <5D446BC2.9000303@redhat.com>
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
 drivers/target/target_core_user.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
index 04eda111920e..68045cbca595 100644
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
@@ -1788,6 +1806,8 @@ static int tcmu_netlink_event_send(struct tcmu_dev *udev,
 	if (ret == 0 ||
 	   (ret == -ESRCH && cmd == TCMU_CMD_ADDED_DEVICE))
 		return tcmu_wait_genl_cmd_reply(udev);
+	else
+		tcmu_destroy_genl_cmd_reply(udev);
 
 	return ret;
 }
-- 
2.20.1

