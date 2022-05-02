Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3C251799F
	for <lists+linux-scsi@lfdr.de>; Tue,  3 May 2022 00:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385896AbiEBWEq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 2 May 2022 18:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387706AbiEBWDe (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 2 May 2022 18:03:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E89262D2
        for <linux-scsi@vger.kernel.org>; Mon,  2 May 2022 15:00:02 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B0BF5210EF;
        Mon,  2 May 2022 22:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651528800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eV3bVFMcfcndAL+wJ/F3x57k0w2HiqDO+IfUA2JvRMU=;
        b=FcYaJLLju6WMxi5oH0ETjiVdpJPcHLmBhno5X9/NaEMJOElE3PCLyeT0RkdqJeRwGsYK4k
        7Cli+5nDbzBU1f9PiyWSdihRwmI5rDbhW3/f08iGMH9BktiPPvwVQnIYH7TSnbtf9Cqo4a
        8ZJTMzi4IDVNJaqbATy+LPx9cmXy7Aw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651528800;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eV3bVFMcfcndAL+wJ/F3x57k0w2HiqDO+IfUA2JvRMU=;
        b=qcBLq1nQoK89hutYlo86zJkNHILmL+v7vOWpXLKyUrYawuUoIdv+zzT8Cmr/nHcccWfdhn
        61kcwC62LwdH9iBQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id A817A2C14F;
        Mon,  2 May 2022 22:00:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id A4DAE519414E; Tue,  3 May 2022 00:00:00 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH 04/11] scsi_transport_iscsi: use session as argument for iscsi_block_scsi_eh()
Date:   Mon,  2 May 2022 23:59:42 +0200
Message-Id: <20220502215953.5463-8-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220502215953.5463-1-hare@suse.de>
References: <20220502215953.5463-1-hare@suse.de>
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

We should be passing in the session directly instead of deriving it
from the scsi command.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/qla4xxx/ql4_os.c       | 34 ++++++++++++++++++-----------
 drivers/scsi/scsi_transport_iscsi.c |  6 ++---
 include/scsi/scsi_transport_iscsi.h |  2 +-
 3 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/scsi/qla4xxx/ql4_os.c b/drivers/scsi/qla4xxx/ql4_os.c
index 3f6cb2a5c2c2..f4969b99c07f 100644
--- a/drivers/scsi/qla4xxx/ql4_os.c
+++ b/drivers/scsi/qla4xxx/ql4_os.c
@@ -9262,15 +9262,18 @@ static int qla4xxx_eh_abort(struct scsi_cmnd *cmd)
  **/
 static int qla4xxx_eh_device_reset(struct scsi_cmnd *cmd)
 {
-	struct scsi_qla_host *ha = to_qla_host(cmd->device->host);
-	struct ddb_entry *ddb_entry = cmd->device->hostdata;
+	struct scsi_device *sdev = cmd->device;
+	struct scsi_qla_host *ha = to_qla_host(sdev->host);
+	struct iscsi_cls_session *session;
+	struct ddb_entry *ddb_entry = sdev->hostdata;
 	int ret = FAILED, stat;
 	int rval;
 
 	if (!ddb_entry)
 		return ret;
 
-	ret = iscsi_block_scsi_eh(cmd);
+	session = starget_to_session(scsi_target(sdev));
+	ret = iscsi_block_scsi_eh(session);
 	if (ret)
 		return ret;
 	ret = FAILED;
@@ -9331,19 +9334,25 @@ static int qla4xxx_eh_device_reset(struct scsi_cmnd *cmd)
  **/
 static int qla4xxx_eh_target_reset(struct scsi_cmnd *cmd)
 {
-	struct scsi_qla_host *ha = to_qla_host(cmd->device->host);
-	struct ddb_entry *ddb_entry = cmd->device->hostdata;
+	struct scsi_target *starget = scsi_target(cmd->device);
+	struct iscsi_cls_session *cls_session = starget_to_session(starget);
+	struct iscsi_session *sess;
+	struct scsi_qla_host *ha;
+	struct ddb_entry *ddb_entry;
 	int stat, ret;
 	int rval;
 
+	sess = cls_session->dd_data;
+	ddb_entry = sess->dd_data;
 	if (!ddb_entry)
 		return FAILED;
+	ha = ddb_entry->ha;
 
-	ret = iscsi_block_scsi_eh(cmd);
+	ret = iscsi_block_scsi_eh(cls_session);
 	if (ret)
 		return ret;
 
-	starget_printk(KERN_INFO, scsi_target(cmd->device),
+	starget_printk(KERN_INFO, starget,
 		       "WARM TARGET RESET ISSUED.\n");
 
 	DEBUG2(printk(KERN_INFO
@@ -9360,14 +9369,13 @@ static int qla4xxx_eh_target_reset(struct scsi_cmnd *cmd)
 
 	stat = qla4xxx_reset_target(ha, ddb_entry);
 	if (stat != QLA_SUCCESS) {
-		starget_printk(KERN_INFO, scsi_target(cmd->device),
+		starget_printk(KERN_INFO, starget,
 			       "WARM TARGET RESET FAILED.\n");
 		return FAILED;
 	}
 
-	if (qla4xxx_eh_wait_for_commands(ha, scsi_target(cmd->device),
-					 NULL)) {
-		starget_printk(KERN_INFO, scsi_target(cmd->device),
+	if (qla4xxx_eh_wait_for_commands(ha, starget, NULL)) {
+		starget_printk(KERN_INFO, starget,
 			       "WARM TARGET DEVICE RESET FAILED - "
 			       "waiting for commands.\n");
 		return FAILED;
@@ -9376,13 +9384,13 @@ static int qla4xxx_eh_target_reset(struct scsi_cmnd *cmd)
 	/* Send marker. */
 	if (qla4xxx_send_marker_iocb(ha, ddb_entry, cmd->device->lun,
 		MM_TGT_WARM_RESET) != QLA_SUCCESS) {
-		starget_printk(KERN_INFO, scsi_target(cmd->device),
+		starget_printk(KERN_INFO, starget,
 			       "WARM TARGET DEVICE RESET FAILED - "
 			       "marker iocb failed.\n");
 		return FAILED;
 	}
 
-	starget_printk(KERN_INFO, scsi_target(cmd->device),
+	starget_printk(KERN_INFO, starget,
 		       "WARM TARGET RESET SUCCEEDED.\n");
 	return SUCCESS;
 }
diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 2c0dd64159b0..bdc9ef29fe9c 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -1821,17 +1821,15 @@ static void iscsi_scan_session(struct work_struct *work)
 
 /**
  * iscsi_block_scsi_eh - block scsi eh until session state has transistioned
- * @cmd: scsi cmd passed to scsi eh handler
+ * @session: iscsi session derived from scsi eh handler argument
  *
  * If the session is down this function will wait for the recovery
  * timer to fire or for the session to be logged back in. If the
  * recovery timer fires then FAST_IO_FAIL is returned. The caller
  * should pass this error value to the scsi eh.
  */
-int iscsi_block_scsi_eh(struct scsi_cmnd *cmd)
+int iscsi_block_scsi_eh(struct iscsi_cls_session *session)
 {
-	struct iscsi_cls_session *session =
-			starget_to_session(scsi_target(cmd->device));
 	unsigned long flags;
 	int ret = 0;
 
diff --git a/include/scsi/scsi_transport_iscsi.h b/include/scsi/scsi_transport_iscsi.h
index 9acb8422f680..5771275f8bf3 100644
--- a/include/scsi/scsi_transport_iscsi.h
+++ b/include/scsi/scsi_transport_iscsi.h
@@ -456,7 +456,7 @@ extern struct iscsi_endpoint *iscsi_create_endpoint(int dd_size);
 extern void iscsi_destroy_endpoint(struct iscsi_endpoint *ep);
 extern struct iscsi_endpoint *iscsi_lookup_endpoint(u64 handle);
 extern void iscsi_put_endpoint(struct iscsi_endpoint *ep);
-extern int iscsi_block_scsi_eh(struct scsi_cmnd *cmd);
+extern int iscsi_block_scsi_eh(struct iscsi_cls_session *session);
 extern struct iscsi_iface *iscsi_create_iface(struct Scsi_Host *shost,
 					      struct iscsi_transport *t,
 					      uint32_t iface_type,
-- 
2.29.2

