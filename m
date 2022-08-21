Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F5959B17C
	for <lists+linux-scsi@lfdr.de>; Sun, 21 Aug 2022 06:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiHUD6T (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 20 Aug 2022 23:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiHUD6R (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 20 Aug 2022 23:58:17 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA50125DC
        for <linux-scsi@vger.kernel.org>; Sat, 20 Aug 2022 20:58:13 -0700 (PDT)
Received: from fsav314.sakura.ne.jp (fsav314.sakura.ne.jp [153.120.85.145])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 27L3vsxX026704;
        Sun, 21 Aug 2022 12:57:54 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav314.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp);
 Sun, 21 Aug 2022 12:57:54 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav314.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 27L3vsVu026701
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 21 Aug 2022 12:57:54 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <0c335e86-5624-b599-5137-f1377419fb0c@I-love.SAKURA.ne.jp>
Date:   Sun, 21 Aug 2022 12:57:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Content-Language: en-US
To:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org,
        Himanshu Madhani <himanshu.madhani@oracle.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH v5 1/4] scsi: qla2xxx: Remove unused del_sess_list field
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

"struct qla_tgt"->del_sess_list is no longer used since commit
726b85487067d7f5 ("qla2xxx: Add framework for async fabric discovery").

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Tested-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
Changes in v5:
  Added Reviewed-by and Tested-by from Himanshu Madhani.

 drivers/scsi/qla2xxx/qla_target.c | 1 -
 drivers/scsi/qla2xxx/qla_target.h | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 62666df1a59e..164bd0637a08 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -6512,7 +6512,6 @@ int qlt_add_target(struct qla_hw_data *ha, struct scsi_qla_host *base_vha)
 	tgt->ha = ha;
 	tgt->vha = base_vha;
 	init_waitqueue_head(&tgt->waitQ);
-	INIT_LIST_HEAD(&tgt->del_sess_list);
 	spin_lock_init(&tgt->sess_work_lock);
 	INIT_WORK(&tgt->sess_work, qlt_sess_work_fn);
 	INIT_LIST_HEAD(&tgt->sess_works_list);
diff --git a/drivers/scsi/qla2xxx/qla_target.h b/drivers/scsi/qla2xxx/qla_target.h
index de3942b8efc4..e899e13696e9 100644
--- a/drivers/scsi/qla2xxx/qla_target.h
+++ b/drivers/scsi/qla2xxx/qla_target.h
@@ -813,9 +813,6 @@ struct qla_tgt {
 	/* Count of sessions refering qla_tgt. Protected by hardware_lock. */
 	int sess_count;
 
-	/* Protected by hardware_lock */
-	struct list_head del_sess_list;
-
 	spinlock_t sess_work_lock;
 	struct list_head sess_works_list;
 	struct work_struct sess_work;
-- 
2.18.4
