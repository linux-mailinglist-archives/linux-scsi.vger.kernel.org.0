Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9AB0630A14
	for <lists+linux-scsi@lfdr.de>; Sat, 19 Nov 2022 03:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbiKSCXC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 18 Nov 2022 21:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235806AbiKSCWO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 18 Nov 2022 21:22:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E7AC697A;
        Fri, 18 Nov 2022 18:15:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B29A62836;
        Sat, 19 Nov 2022 02:14:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787F2C433C1;
        Sat, 19 Nov 2022 02:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668824067;
        bh=OvQ1e3jmtfV4wEihgDgauKDzIR3WutwV7g39nsP/k1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LhxdTLeeQ4/0f3XZb5CcjmzpIy0+LUwl2BBcvKdKn3o4CsmdLDaq0bY0q3GlYZicL
         xoHrUp9X5YCppbrE85yNYoLRs7QtgRGRiKhxqgv8TcgFIyyobzysuSpWwLm3zjY4qD
         nCmoMpZrO+Rr5ksJH5eivQprvRkchOR+i3GIg2Xuohbd3c+lsVMaQtwPbFsHKdwm6F
         S8JOv6C/cI8aY3Qp4e0hwigy39Cjcf2LMvaRbTFSMHv1zAP0oArlmKv9IMcEd4N+Vq
         MCgQtHw/1KvMkxz0UmckCHrnfsjShNcrcMJLcXI2WhYOCXISz6w9RFvdFMRWpELeJy
         iDqX41PsLEKFA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Brian King <brking@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, tyreld@linux.ibm.com,
        mpe@ellerman.id.au, jejb@linux.ibm.com, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 5.15 18/27] scsi: ibmvfc: Avoid path failures during live migration
Date:   Fri, 18 Nov 2022 21:13:43 -0500
Message-Id: <20221119021352.1774592-18-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221119021352.1774592-1-sashal@kernel.org>
References: <20221119021352.1774592-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Brian King <brking@linux.vnet.ibm.com>

[ Upstream commit 62fa3ce05d5d73c5eccc40b2db493f55fecfc446 ]

Fix an issue reported when performing a live migration when multipath is
configured with a short fast fail timeout of 5 seconds and also to have
no_path_retry set to fail. In this scenario, all paths would go into the
devloss state while the ibmvfc driver went through discovery to log back
in. On a loaded system, the discovery might take longer than 5 seconds,
which was resulting in all paths being marked failed, which then resulted
in a read only filesystem.

This patch changes the migration code in ibmvfc to avoid deleting rports at
all in this scenario, so we avoid losing all paths.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
Link: https://lore.kernel.org/r/20221026181356.148517-1-brking@linux.vnet.ibm.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index b3531065a438..45ef78f388dc 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -708,8 +708,13 @@ static void ibmvfc_init_host(struct ibmvfc_host *vhost)
 		memset(vhost->async_crq.msgs.async, 0, PAGE_SIZE);
 		vhost->async_crq.cur = 0;
 
-		list_for_each_entry(tgt, &vhost->targets, queue)
-			ibmvfc_del_tgt(tgt);
+		list_for_each_entry(tgt, &vhost->targets, queue) {
+			if (vhost->client_migrated)
+				tgt->need_login = 1;
+			else
+				ibmvfc_del_tgt(tgt);
+		}
+
 		scsi_block_requests(vhost->host);
 		ibmvfc_set_host_action(vhost, IBMVFC_HOST_ACTION_INIT);
 		vhost->job_step = ibmvfc_npiv_login;
@@ -3235,9 +3240,12 @@ static void ibmvfc_handle_crq(struct ibmvfc_crq *crq, struct ibmvfc_host *vhost,
 			/* We need to re-setup the interpartition connection */
 			dev_info(vhost->dev, "Partition migrated, Re-enabling adapter\n");
 			vhost->client_migrated = 1;
+
+			scsi_block_requests(vhost->host);
 			ibmvfc_purge_requests(vhost, DID_REQUEUE);
-			ibmvfc_link_down(vhost, IBMVFC_LINK_DOWN);
+			ibmvfc_set_host_state(vhost, IBMVFC_LINK_DOWN);
 			ibmvfc_set_host_action(vhost, IBMVFC_HOST_ACTION_REENABLE);
+			wake_up(&vhost->work_wait_q);
 		} else if (crq->format == IBMVFC_PARTNER_FAILED || crq->format == IBMVFC_PARTNER_DEREGISTER) {
 			dev_err(vhost->dev, "Host partner adapter deregistered or failed (rc=%d)\n", crq->format);
 			ibmvfc_purge_requests(vhost, DID_ERROR);
-- 
2.35.1

