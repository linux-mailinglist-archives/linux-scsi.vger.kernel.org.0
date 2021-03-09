Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44129331F70
	for <lists+linux-scsi@lfdr.de>; Tue,  9 Mar 2021 07:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbhCIGlL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 9 Mar 2021 01:41:11 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:57091 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229689AbhCIGlL (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 9 Mar 2021 01:41:11 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UR1u9NJ_1615272065;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UR1u9NJ_1615272065)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 09 Mar 2021 14:41:06 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     aradford@gmail.com
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] scsi: 3w-sas: remove unneeded variable 'retval'
Date:   Tue,  9 Mar 2021 14:41:04 +0800
Message-Id: <1615272064-42109-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix the following coccicheck warning:
./drivers/scsi/3w-sas.c:866:5-11: Unneeded variable: "retval". Return
"1" on line 898

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/scsi/3w-sas.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/3w-sas.c b/drivers/scsi/3w-sas.c
index 3db0e42..eae706e 100644
--- a/drivers/scsi/3w-sas.c
+++ b/drivers/scsi/3w-sas.c
@@ -863,7 +863,6 @@ static int twl_fill_sense(TW_Device_Extension *tw_dev, int i, int request_id, in
 	TW_Command_Full *full_command_packet;
 	unsigned short error;
 	char *error_str;
-	int retval = 1;
 
 	header = tw_dev->sense_buffer_virt[i];
 	full_command_packet = tw_dev->command_packet_virt[request_id];
@@ -895,7 +894,7 @@ static int twl_fill_sense(TW_Device_Extension *tw_dev, int i, int request_id, in
 		goto out;
 	}
 out:
-	return retval;
+	return 1;
 } /* End twl_fill_sense() */
 
 /* This function will free up device extension resources */
-- 
1.8.3.1

