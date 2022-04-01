Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6BD4EF471
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Apr 2022 17:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347836AbiDAPD7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 1 Apr 2022 11:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349413AbiDAOze (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 1 Apr 2022 10:55:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C070522C1;
        Fri,  1 Apr 2022 07:43:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45062B824AF;
        Fri,  1 Apr 2022 14:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B44C340EE;
        Fri,  1 Apr 2022 14:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648824219;
        bh=D3MMkIZa9gVS2t4YZ8IbXig4tAtjQ5LpsMXgRj2Xx+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WQiHYwUaOM/X6CH4B+Pqoii8Pp9TgmOzvRY0nhsCcPSZpWyz1vYxv9JAD497cn1oh
         fQZ2hzUb+eB0OdcJuDJjAvP5lL+GYBu5k2SUw9dEuBV7HtpaKDuq1wLggM3iG5q9wT
         XVOV1KAbzZeRuTWbQIjefH8FaLC1LMbrSfy6tm4+r1xagDoof1N/+N6yog9N9y7NLW
         ciCP8k1S1okQRZ+hhXTjkEYea60mcW5pkQwPwUmi02jBxRoukrJtGcviXr0cv2Hl5o
         FfRjMUYVWmCJMHbgOP206gx4N7CnhfrDDfJGNLc2OkDmbAVMCRUxFwsS8zjc1QskOm
         DmTyRYC2s7BBg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        John Garry <john.garry@huawei.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, jinpu.wang@cloud.ionos.com,
        jejb@linux.ibm.com, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 35/65] scsi: pm8001: Fix task leak in pm8001_send_abort_all()
Date:   Fri,  1 Apr 2022 10:41:36 -0400
Message-Id: <20220401144206.1953700-35-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220401144206.1953700-1-sashal@kernel.org>
References: <20220401144206.1953700-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Damien Le Moal <damien.lemoal@opensource.wdc.com>

[ Upstream commit f90a74892f3acf0cdec5844e90fc8686ca13e7d7 ]

In pm8001_send_abort_all(), make sure to free the allocated sas task
if pm8001_tag_alloc() or pm8001_mpi_build_cmd() fail.

Link: https://lore.kernel.org/r/20220220031810.738362-21-damien.lemoal@opensource.wdc.com
Reviewed-by: John Garry <john.garry@huawei.com>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/pm8001/pm8001_hwi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index a6b8700c7f0c..4e43f0c295b2 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -1711,7 +1711,6 @@ static void pm8001_send_abort_all(struct pm8001_hba_info *pm8001_ha,
 	}
 
 	task = sas_alloc_slow_task(GFP_ATOMIC);
-
 	if (!task) {
 		pm8001_dbg(pm8001_ha, FAIL, "cannot allocate task\n");
 		return;
@@ -1720,8 +1719,10 @@ static void pm8001_send_abort_all(struct pm8001_hba_info *pm8001_ha,
 	task->task_done = pm8001_task_done;
 
 	res = pm8001_tag_alloc(pm8001_ha, &ccb_tag);
-	if (res)
+	if (res) {
+		sas_free_task(task);
 		return;
+	}
 
 	ccb = &pm8001_ha->ccb_info[ccb_tag];
 	ccb->device = pm8001_ha_dev;
@@ -1737,8 +1738,10 @@ static void pm8001_send_abort_all(struct pm8001_hba_info *pm8001_ha,
 
 	ret = pm8001_mpi_build_cmd(pm8001_ha, circularQ, opc, &task_abort,
 			sizeof(task_abort), 0);
-	if (ret)
+	if (ret) {
+		sas_free_task(task);
 		pm8001_tag_free(pm8001_ha, ccb_tag);
+	}
 
 }
 
-- 
2.34.1

