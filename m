Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47A34EF326
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Apr 2022 17:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348664AbiDAO53 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 1 Apr 2022 10:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351352AbiDAOss (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 1 Apr 2022 10:48:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E73A28AC60;
        Fri,  1 Apr 2022 07:39:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13EB160B9A;
        Fri,  1 Apr 2022 14:39:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49578C36AEA;
        Fri,  1 Apr 2022 14:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648823960;
        bh=bzbMuzZ+tSaSt+LWshNcwUC09neSrYgdPcYOVo06zZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d1xBqUJTzeB30yX+tPeZv9fWIUNl5Dd6gQG30MvuP9h/2L4rGTgnvgOye2BYGNBw/
         JXzT0sstTQrmQlg/qZhJoLhb9p22ZZgRCrvDQ4XpPGVW/rf7UMZ2nujLVJJQ/u3dGl
         gJO/rJ1NfifFFa2WAIaUs8Ej6S0dInv3+y8E8qODtL2i63nsvyevs+nyp1eqtbdw2k
         qrU+RCQUgmWlJkMIXazN+85caZuzJl1ImdCERS54VzZ6ph0IdwWJlv4qlnQeOWl6F/
         w7cy8KkezWCzH59TOrdmappCeIMDR7w/Vuzah9VenoUBbMiIEF4Z0uAbGFjaX76XAQ
         jRU+tI0V6obWA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mahesh Rajashekhara <mahesh.rajashekhara@microchip.com>,
        Kevin Barnett <kevin.barnett@microchip.com>,
        Scott Benesh <scott.benesh@microchip.com>,
        Scott Teel <scott.teel@microchip.com>,
        Don Brace <don.brace@microchip.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, jejb@linux.ibm.com,
        storagedev@microchip.com, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 31/98] scsi: smartpqi: Fix kdump issue when controller is locked up
Date:   Fri,  1 Apr 2022 10:36:35 -0400
Message-Id: <20220401143742.1952163-31-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220401143742.1952163-1-sashal@kernel.org>
References: <20220401143742.1952163-1-sashal@kernel.org>
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

From: Mahesh Rajashekhara <mahesh.rajashekhara@microchip.com>

[ Upstream commit 3ada501d602abf02353445c03bb3258146445d90 ]

Avoid dropping into shell if the controller is in locked up state.

Driver issues SIS soft reset to bring back the controller to SIS mode while
OS boots into kdump mode.

If the controller is in lockup state, SIS soft reset does not work.

Since the controller lockup code has not been cleared, driver considers the
firmware is no longer up and running. Driver returns back an error code to
OS and the kdump fails.

Link: https://lore.kernel.org/r/164375212337.440833.11955356190354940369.stgit@brunhilda.pdev.net
Reviewed-by: Kevin Barnett <kevin.barnett@microchip.com>
Reviewed-by: Scott Benesh <scott.benesh@microchip.com>
Reviewed-by: Scott Teel <scott.teel@microchip.com>
Signed-off-by: Mahesh Rajashekhara <mahesh.rajashekhara@microchip.com>
Signed-off-by: Don Brace <don.brace@microchip.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/smartpqi/smartpqi_init.c | 39 ++++++++++++++++-----------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index a5453f5e87c3..2e690d8a3444 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -7653,6 +7653,21 @@ static int pqi_force_sis_mode(struct pqi_ctrl_info *ctrl_info)
 	return pqi_revert_to_sis_mode(ctrl_info);
 }
 
+static void pqi_perform_lockup_action(void)
+{
+	switch (pqi_lockup_action) {
+	case PANIC:
+		panic("FATAL: Smart Family Controller lockup detected");
+		break;
+	case REBOOT:
+		emergency_restart();
+		break;
+	case NONE:
+	default:
+		break;
+	}
+}
+
 static int pqi_ctrl_init(struct pqi_ctrl_info *ctrl_info)
 {
 	int rc;
@@ -7677,8 +7692,15 @@ static int pqi_ctrl_init(struct pqi_ctrl_info *ctrl_info)
 	 * commands.
 	 */
 	rc = sis_wait_for_ctrl_ready(ctrl_info);
-	if (rc)
+	if (rc) {
+		if (reset_devices) {
+			dev_err(&ctrl_info->pci_dev->dev,
+				"kdump init failed with error %d\n", rc);
+			pqi_lockup_action = REBOOT;
+			pqi_perform_lockup_action();
+		}
 		return rc;
+	}
 
 	/*
 	 * Get the controller properties.  This allows us to determine
@@ -8402,21 +8424,6 @@ static int pqi_ofa_ctrl_restart(struct pqi_ctrl_info *ctrl_info, unsigned int de
 	return pqi_ctrl_init_resume(ctrl_info);
 }
 
-static void pqi_perform_lockup_action(void)
-{
-	switch (pqi_lockup_action) {
-	case PANIC:
-		panic("FATAL: Smart Family Controller lockup detected");
-		break;
-	case REBOOT:
-		emergency_restart();
-		break;
-	case NONE:
-	default:
-		break;
-	}
-}
-
 static struct pqi_raid_error_info pqi_ctrl_offline_raid_error_info = {
 	.data_out_result = PQI_DATA_IN_OUT_HARDWARE_ERROR,
 	.status = SAM_STAT_CHECK_CONDITION,
-- 
2.34.1

