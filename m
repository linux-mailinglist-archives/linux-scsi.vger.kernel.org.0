Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E959A1B65B2
	for <lists+linux-scsi@lfdr.de>; Thu, 23 Apr 2020 22:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgDWUqZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 23 Apr 2020 16:46:25 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:33934 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgDWUqZ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 23 Apr 2020 16:46:25 -0400
Received: from localhost.localdomain ([93.22.149.4])
        by mwinf5d27 with ME
        id WLmM2200505vvQD03LmMKL; Thu, 23 Apr 2020 22:46:23 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 23 Apr 2020 22:46:23 +0200
X-ME-IP: 93.22.149.4
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     satishkh@cisco.com, sebaddel@cisco.com, kartilak@cisco.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] scsi: fnic: Use kmalloc instead of vmalloc for a small memory allocation
Date:   Thu, 23 Apr 2020 22:46:20 +0200
Message-Id: <20200423204620.26395-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

'struct fc_trace_flag_type' is just a few bytes long. There is no need
to allocate such a structure with vmalloc. Using kmalloc instead.

While at it, axe a useless test when freeing the memory.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/scsi/fnic/fnic_debugfs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_debugfs.c b/drivers/scsi/fnic/fnic_debugfs.c
index 13f7d88d6e57..8d6ce3470594 100644
--- a/drivers/scsi/fnic/fnic_debugfs.c
+++ b/drivers/scsi/fnic/fnic_debugfs.c
@@ -58,8 +58,7 @@ int fnic_debugfs_init(void)
 						fnic_trace_debugfs_root);
 
 	/* Allocate memory to structure */
-	fc_trc_flag = (struct fc_trace_flag_type *)
-		vmalloc(sizeof(struct fc_trace_flag_type));
+	fc_trc_flag = kmalloc(sizeof(*fc_trc_flag), GFP_KERNEL);
 
 	if (fc_trc_flag) {
 		fc_trc_flag->fc_row_file = 0;
@@ -87,8 +86,7 @@ void fnic_debugfs_terminate(void)
 	debugfs_remove(fnic_trace_debugfs_root);
 	fnic_trace_debugfs_root = NULL;
 
-	if (fc_trc_flag)
-		vfree(fc_trc_flag);
+	kfree(fc_trc_flag);
 }
 
 /*
-- 
2.20.1

