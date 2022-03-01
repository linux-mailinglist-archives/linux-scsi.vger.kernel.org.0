Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78624C8DEE
	for <lists+linux-scsi@lfdr.de>; Tue,  1 Mar 2022 15:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbiCAOi0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 1 Mar 2022 09:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235350AbiCAOiQ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 1 Mar 2022 09:38:16 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AA026FA
        for <linux-scsi@vger.kernel.org>; Tue,  1 Mar 2022 06:37:32 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E21F31F39D;
        Tue,  1 Mar 2022 14:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646145450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9v8RQ6Ib06ZR4xAHxEGTuhF9yPcqpnFDL+ZywEc5h5s=;
        b=2DswJzlVFZakDg6ySF6IW3lvA8g74YP24brqArG2/oMXRf53wKK4BgOXghyFFDVXyISZCh
        YUtwGM5IWEBTItOUF5kRPzV1iNVSJZLWdo3EFHDtxwiT3ZiKDnEO8HPxKE/mpBgA4kUr9P
        SY0EuP9ayBhmjoDOee2bGxOdXCf/wPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646145450;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9v8RQ6Ib06ZR4xAHxEGTuhF9yPcqpnFDL+ZywEc5h5s=;
        b=O1/CYpsEiYk5osZESTrcY5GJGlaWpED7AAku3skWNCvcaFDYMJ9EnD651+bczfS4Auo1sL
        /HBDXC98g1GvAdCQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id AB7D5A3B91;
        Tue,  1 Mar 2022 14:37:30 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 9DFF751933CA; Tue,  1 Mar 2022 15:37:30 +0100 (CET)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        James Smart <jsmart2021@gmail.com>,
        James Smart <james.smart@broadcom.com>
Subject: [PATCH 2/5] lpfc: drop lpfc_no_handler()
Date:   Tue,  1 Mar 2022 15:37:15 +0100
Message-Id: <20220301143718.40913-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220301143718.40913-1-hare@suse.de>
References: <20220301143718.40913-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The default SCSI EH action for a non-existing EH callback is to
return FAILED, so having a callback just returning FAILED is pointless.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: James Smart <jsmart2021@gmail.com>
Cc: James Smart <james.smart@broadcom.com>
---
 drivers/scsi/lpfc/lpfc_scsi.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index a061b4ed4b00..943f7e826ccb 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -7093,12 +7093,6 @@ lpfc_no_command(struct Scsi_Host *shost, struct scsi_cmnd *cmnd)
 	return SCSI_MLQUEUE_HOST_BUSY;
 }
 
-static int
-lpfc_no_handler(struct scsi_cmnd *cmnd)
-{
-	return FAILED;
-}
-
 static int
 lpfc_no_slave(struct scsi_device *sdev)
 {
@@ -7111,10 +7105,6 @@ struct scsi_host_template lpfc_template_nvme = {
 	.proc_name		= LPFC_DRIVER_NAME,
 	.info			= lpfc_info,
 	.queuecommand		= lpfc_no_command,
-	.eh_abort_handler	= lpfc_no_handler,
-	.eh_device_reset_handler = lpfc_no_handler,
-	.eh_target_reset_handler = lpfc_no_handler,
-	.eh_host_reset_handler  = lpfc_no_handler,
 	.slave_alloc		= lpfc_no_slave,
 	.slave_configure	= lpfc_no_slave,
 	.scan_finished		= lpfc_scan_finished,
-- 
2.29.2

