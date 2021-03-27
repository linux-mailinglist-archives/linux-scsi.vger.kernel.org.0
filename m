Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492E234B3F6
	for <lists+linux-scsi@lfdr.de>; Sat, 27 Mar 2021 04:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhC0DJQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Mar 2021 23:09:16 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:21874 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbhC0DJL (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 26 Mar 2021 23:09:11 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id 324EE980117;
        Sat, 27 Mar 2021 11:09:08 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] scsi: scsi_priv: Remove duplicate declaration
Date:   Sat, 27 Mar 2021 11:08:50 +0800
Message-Id: <20210327030850.918018-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQklCTx1DSB8eSRpIVkpNSk1DSk9OT0NITEJVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mio6Cxw4SD8cGjMhPUNCDlZD
        GU8KCzFVSlVKTUpNQ0pPTk9DTUJOVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFJSkpLNwY+
X-HM-Tid: 0a7871a8255ad992kuws324ee980117
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

struct request and struct request_queue have been
declared at forward struct declaration.
Remove the duplicate and reorder the forward declaration
to be in alphabetic order.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/scsi/scsi_priv.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 180636d54982..811abc86f6d6 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -6,14 +6,14 @@
 #include <linux/async.h>
 #include <scsi/scsi_device.h>
 
-struct request_queue;
 struct request;
+struct request_queue;
+struct Scsi_Host;
 struct scsi_cmnd;
 struct scsi_device;
-struct scsi_target;
 struct scsi_host_template;
-struct Scsi_Host;
 struct scsi_nl_hdr;
+struct scsi_target;
 
 #define SCSI_CMD_RETRIES_NO_LIMIT -1
 
@@ -96,8 +96,6 @@ extern int scsi_mq_setup_tags(struct Scsi_Host *shost);
 extern void scsi_mq_destroy_tags(struct Scsi_Host *shost);
 extern void scsi_exit_queue(void);
 extern void scsi_evt_thread(struct work_struct *work);
-struct request_queue;
-struct request;
 
 /* scsi_proc.c */
 #ifdef CONFIG_SCSI_PROC_FS
-- 
2.25.1

