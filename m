Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6525675A38E
	for <lists+linux-scsi@lfdr.de>; Thu, 20 Jul 2023 02:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjGTApi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 19 Jul 2023 20:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGTAph (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 19 Jul 2023 20:45:37 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F371BF7;
        Wed, 19 Jul 2023 17:45:33 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fd32e611e0so404358e87.0;
        Wed, 19 Jul 2023 17:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689813932; x=1690418732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bf+cq0KOQ6B5uZI8TM4cRLer265iTJeb9lwKk3HU/qo=;
        b=Nh0zEjt+CICrDeh2uQ8F3vyGb7Ik5UzqqU6LzNJN6aWqKiSCYdfKTUBJC77jU85nuX
         eky02TmZzCk26Qdwxoldz3zYAj0W469fU+oaZYrP4Kkx+lb67bWGIKgXkaNQTRkkAWiI
         ej7QgQhcgXRAzHPNR8a2Q1XzmW494kWjZHT9Ckn+OZjPUGDPFvjXaaO0OFWujmGizO0D
         Zi8uJzHoaI/BTupZ9LRFNfsD9LKG5j8tcLXl5ItyU0mlmzulChLVKFTLCcnqbvfE3hHd
         mUkRkkaSi24QPzDpLWp2qm/lNyZeKzTKr+2LOIgj7LrpwmmXECve2vgBsoRDJl8cHbqw
         rkWg==
X-Gm-Message-State: ABy/qLb0jHiN1MDIkWZ7ZeTFXanDRso3JyHF2OC5fGpTl5utXgo5cmZq
        4KhZScVlQU+jWeYAJBA9RTb4lQbENPTLAfCB
X-Google-Smtp-Source: APBJJlEoVYFMXCPEk3kx9Dz276ceKp4MUEciSuUrW3KTgHTVKF7dgUrMZ5oU3ZGtHY6uDqPTGFV1+g==
X-Received: by 2002:a05:6512:1593:b0:4f8:6ac4:1aa9 with SMTP id bp19-20020a056512159300b004f86ac41aa9mr398056lfb.21.1689813931806;
        Wed, 19 Jul 2023 17:45:31 -0700 (PDT)
Received: from flawful.org (c-f5f0e255.011-101-6d6c6d3.bbcust.telenor.se. [85.226.240.245])
        by smtp.gmail.com with ESMTPSA id x20-20020ac25dd4000000b004fddd638cecsm9050lfq.89.2023.07.19.17.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 17:45:31 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
        id 97FF43F10; Thu, 20 Jul 2023 02:45:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1689813930; bh=djK1c+XScXXsMYC+D41Ymb/KysvO005rEBilmbSc9XQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fOc2KAkxxw5NxghKmJqWEhLFOkJmvFDgXJnQUubA2BM2A+uGCnOBa4TTwtsgKtgYK
         OthqP39Ri1oP9H/mNuosvwb0jlq99p1nnJpIQ2pnBGI+dFYGYrjhKKa0nkWmGLpEtC
         acHdwCfO2QFs9l3LU/GkVqjJrD6bUmydSS3VEstY=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
Received: from x1-carbon.lan (OpenWrt.lan [192.168.1.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by flawful.org (Postfix) with ESMTPSA id 3FF553EF1;
        Thu, 20 Jul 2023 02:44:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1689813844; bh=djK1c+XScXXsMYC+D41Ymb/KysvO005rEBilmbSc9XQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ea/l/7e+s5dWQHJirqYWUKFPFoC22cM8GYQuwO3Sqqqgzoa8HdpuGJ4MmJrFODCQQ
         6Rt4uLkwXZLvq2Z9lAu6Em9XK+HbocxK5v2mC6zK/lusSQqo4rXpEQ18mdM0s888J+
         hITRchnE6nMSMdEghSdH5cDjjJoKjfYdtxRzlpj8=
From:   Niklas Cassel <nks@flawful.org>
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Hannes Reinecke <hare@suse.com>,
        John Garry <john.g.garry@oracle.com>,
        linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>,
        Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v2 1/8] ata: remove reference to non-existing error_handler()
Date:   Thu, 20 Jul 2023 02:42:42 +0200
Message-ID: <20230720004257.307031-2-nks@flawful.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230720004257.307031-1-nks@flawful.org>
References: <20230720004257.307031-1-nks@flawful.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Hannes Reinecke <hare@suse.de>

With commit 65a15d6560df ("scsi: ipr: Remove SATA support") all
libata drivers now have the error_handler() callback provided,
so we can stop checking for non-existing error_handler callback.

Signed-off-by: Hannes Reinecke <hare@suse.de>
[niklas: fixed review comments, rebased, solved conflicts during rebase,
fixed bug that unconditionally dumped all QCs, removed the now unused
function ata_dump_status(), removed the now unreachable failure paths in
atapi_qc_complete(), removed the non-EH function to request ATAPI sense]
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/ata/libata-core.c | 209 +++++++++++++++-----------------------
 drivers/ata/libata-eh.c   | 150 ++++++++++++---------------
 drivers/ata/libata-sata.c |   7 +-
 drivers/ata/libata-scsi.c | 142 ++------------------------
 drivers/ata/libata-sff.c  |  30 ++----
 5 files changed, 166 insertions(+), 372 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index d37ab6087f2f..1f0306522649 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1586,13 +1586,11 @@ static unsigned ata_exec_internal_sg(struct ata_device *dev,
 		}
 	}
 
-	if (ap->ops->error_handler)
-		ata_eh_release(ap);
+	ata_eh_release(ap);
 
 	rc = wait_for_completion_timeout(&wait, msecs_to_jiffies(timeout));
 
-	if (ap->ops->error_handler)
-		ata_eh_acquire(ap);
+	ata_eh_acquire(ap);
 
 	ata_sff_flush_pio_task(ap);
 
@@ -1607,10 +1605,7 @@ static unsigned ata_exec_internal_sg(struct ata_device *dev,
 		if (qc->flags & ATA_QCFLAG_ACTIVE) {
 			qc->err_mask |= AC_ERR_TIMEOUT;
 
-			if (ap->ops->error_handler)
-				ata_port_freeze(ap);
-			else
-				ata_qc_complete(qc);
+			ata_port_freeze(ap);
 
 			ata_dev_warn(dev, "qc timeout after %u msecs (cmd 0x%x)\n",
 				     timeout, command);
@@ -4874,126 +4869,103 @@ static void ata_verify_xfer(struct ata_queued_cmd *qc)
 void ata_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
+	struct ata_device *dev = qc->dev;
+	struct ata_eh_info *ehi = &dev->link->eh_info;
 
 	/* Trigger the LED (if available) */
 	ledtrig_disk_activity(!!(qc->tf.flags & ATA_TFLAG_WRITE));
 
-	/* XXX: New EH and old EH use different mechanisms to
-	 * synchronize EH with regular execution path.
-	 *
-	 * In new EH, a qc owned by EH is marked with ATA_QCFLAG_EH.
-	 * Normal execution path is responsible for not accessing a
-	 * qc owned by EH.  libata core enforces the rule by returning NULL
-	 * from ata_qc_from_tag() for qcs owned by EH.
+	/*
+	 * In order to synchronize EH with the regular execution path, a qc that
+	 * is owned by EH is marked with ATA_QCFLAG_EH.
 	 *
-	 * Old EH depends on ata_qc_complete() nullifying completion
-	 * requests if ATA_QCFLAG_EH_SCHEDULED is set.  Old EH does
-	 * not synchronize with interrupt handler.  Only PIO task is
-	 * taken care of.
+	 * The normal execution path is responsible for not accessing a qc owned
+	 * by EH.  libata core enforces the rule by returning NULL from
+	 * ata_qc_from_tag() for qcs owned by EH.
 	 */
-	if (ap->ops->error_handler) {
-		struct ata_device *dev = qc->dev;
-		struct ata_eh_info *ehi = &dev->link->eh_info;
-
-		if (unlikely(qc->err_mask))
-			qc->flags |= ATA_QCFLAG_EH;
+	if (unlikely(qc->err_mask))
+		qc->flags |= ATA_QCFLAG_EH;
 
-		/*
-		 * Finish internal commands without any further processing
-		 * and always with the result TF filled.
-		 */
-		if (unlikely(ata_tag_internal(qc->tag))) {
-			fill_result_tf(qc);
-			trace_ata_qc_complete_internal(qc);
-			__ata_qc_complete(qc);
-			return;
-		}
+	/*
+	 * Finish internal commands without any further processing and always
+	 * with the result TF filled.
+	 */
+	if (unlikely(ata_tag_internal(qc->tag))) {
+		fill_result_tf(qc);
+		trace_ata_qc_complete_internal(qc);
+		__ata_qc_complete(qc);
+		return;
+	}
 
-		/*
-		 * Non-internal qc has failed.  Fill the result TF and
-		 * summon EH.
-		 */
-		if (unlikely(qc->flags & ATA_QCFLAG_EH)) {
-			fill_result_tf(qc);
-			trace_ata_qc_complete_failed(qc);
-			ata_qc_schedule_eh(qc);
-			return;
-		}
+	/* Non-internal qc has failed.  Fill the result TF and summon EH. */
+	if (unlikely(qc->flags & ATA_QCFLAG_EH)) {
+		fill_result_tf(qc);
+		trace_ata_qc_complete_failed(qc);
+		ata_qc_schedule_eh(qc);
+		return;
+	}
 
-		WARN_ON_ONCE(ata_port_is_frozen(ap));
+	WARN_ON_ONCE(ata_port_is_frozen(ap));
 
-		/* read result TF if requested */
-		if (qc->flags & ATA_QCFLAG_RESULT_TF)
-			fill_result_tf(qc);
+	/* read result TF if requested */
+	if (qc->flags & ATA_QCFLAG_RESULT_TF)
+		fill_result_tf(qc);
 
-		trace_ata_qc_complete_done(qc);
+	trace_ata_qc_complete_done(qc);
 
+	/*
+	 * For CDL commands that completed without an error, check if we have
+	 * sense data (ATA_SENSE is set). If we do, then the command may have
+	 * been aborted by the device due to a limit timeout using the policy
+	 * 0xD. For these commands, invoke EH to get the command sense data.
+	 */
+	if (qc->result_tf.status & ATA_SENSE &&
+	    ((ata_is_ncq(qc->tf.protocol) &&
+	      dev->flags & ATA_DFLAG_CDL_ENABLED) ||
+	     (!(ata_is_ncq(qc->tf.protocol) &&
+		ata_id_sense_reporting_enabled(dev->id))))) {
 		/*
-		 * For CDL commands that completed without an error, check if
-		 * we have sense data (ATA_SENSE is set). If we do, then the
-		 * command may have been aborted by the device due to a limit
-		 * timeout using the policy 0xD. For these commands, invoke EH
-		 * to get the command sense data.
+		 * Tell SCSI EH to not overwrite scmd->result even if this
+		 * command is finished with result SAM_STAT_GOOD.
 		 */
-		if (qc->result_tf.status & ATA_SENSE &&
-		    ((ata_is_ncq(qc->tf.protocol) &&
-		      dev->flags & ATA_DFLAG_CDL_ENABLED) ||
-		     (!(ata_is_ncq(qc->tf.protocol) &&
-			ata_id_sense_reporting_enabled(dev->id))))) {
-			/*
-			 * Tell SCSI EH to not overwrite scmd->result even if
-			 * this command is finished with result SAM_STAT_GOOD.
-			 */
-			qc->scsicmd->flags |= SCMD_FORCE_EH_SUCCESS;
-			qc->flags |= ATA_QCFLAG_EH_SUCCESS_CMD;
-			ehi->dev_action[dev->devno] |= ATA_EH_GET_SUCCESS_SENSE;
-
-			/*
-			 * set pending so that ata_qc_schedule_eh() does not
-			 * trigger fast drain, and freeze the port.
-			 */
-			ap->pflags |= ATA_PFLAG_EH_PENDING;
-			ata_qc_schedule_eh(qc);
-			return;
-		}
+		qc->scsicmd->flags |= SCMD_FORCE_EH_SUCCESS;
+		qc->flags |= ATA_QCFLAG_EH_SUCCESS_CMD;
+		ehi->dev_action[dev->devno] |= ATA_EH_GET_SUCCESS_SENSE;
 
-		/* Some commands need post-processing after successful
-		 * completion.
+		/*
+		 * set pending so that ata_qc_schedule_eh() does not trigger
+		 * fast drain, and freeze the port.
 		 */
-		switch (qc->tf.command) {
-		case ATA_CMD_SET_FEATURES:
-			if (qc->tf.feature != SETFEATURES_WC_ON &&
-			    qc->tf.feature != SETFEATURES_WC_OFF &&
-			    qc->tf.feature != SETFEATURES_RA_ON &&
-			    qc->tf.feature != SETFEATURES_RA_OFF)
-				break;
-			fallthrough;
-		case ATA_CMD_INIT_DEV_PARAMS: /* CHS translation changed */
-		case ATA_CMD_SET_MULTI: /* multi_count changed */
-			/* revalidate device */
-			ehi->dev_action[dev->devno] |= ATA_EH_REVALIDATE;
-			ata_port_schedule_eh(ap);
-			break;
+		ap->pflags |= ATA_PFLAG_EH_PENDING;
+		ata_qc_schedule_eh(qc);
+		return;
+	}
 
-		case ATA_CMD_SLEEP:
-			dev->flags |= ATA_DFLAG_SLEEPING;
+	/* Some commands need post-processing after successful completion. */
+	switch (qc->tf.command) {
+	case ATA_CMD_SET_FEATURES:
+		if (qc->tf.feature != SETFEATURES_WC_ON &&
+		    qc->tf.feature != SETFEATURES_WC_OFF &&
+		    qc->tf.feature != SETFEATURES_RA_ON &&
+		    qc->tf.feature != SETFEATURES_RA_OFF)
 			break;
-		}
-
-		if (unlikely(dev->flags & ATA_DFLAG_DUBIOUS_XFER))
-			ata_verify_xfer(qc);
+		fallthrough;
+	case ATA_CMD_INIT_DEV_PARAMS: /* CHS translation changed */
+	case ATA_CMD_SET_MULTI: /* multi_count changed */
+		/* revalidate device */
+		ehi->dev_action[dev->devno] |= ATA_EH_REVALIDATE;
+		ata_port_schedule_eh(ap);
+		break;
 
-		__ata_qc_complete(qc);
-	} else {
-		if (qc->flags & ATA_QCFLAG_EH_SCHEDULED)
-			return;
+	case ATA_CMD_SLEEP:
+		dev->flags |= ATA_DFLAG_SLEEPING;
+		break;
+	}
 
-		/* read result TF if failed or requested */
-		if (qc->err_mask || qc->flags & ATA_QCFLAG_RESULT_TF)
-			fill_result_tf(qc);
+	if (unlikely(dev->flags & ATA_DFLAG_DUBIOUS_XFER))
+		ata_verify_xfer(qc);
 
-		__ata_qc_complete(qc);
-	}
+	__ata_qc_complete(qc);
 }
 EXPORT_SYMBOL_GPL(ata_qc_complete);
 
@@ -5039,11 +5011,8 @@ void ata_qc_issue(struct ata_queued_cmd *qc)
 	struct ata_link *link = qc->dev->link;
 	u8 prot = qc->tf.protocol;
 
-	/* Make sure only one non-NCQ command is outstanding.  The
-	 * check is skipped for old EH because it reuses active qc to
-	 * request ATAPI sense.
-	 */
-	WARN_ON_ONCE(ap->ops->error_handler && ata_tag_valid(link->active_tag));
+	/* Make sure only one non-NCQ command is outstanding. */
+	WARN_ON_ONCE(ata_tag_valid(link->active_tag));
 
 	if (ata_is_ncq(prot)) {
 		WARN_ON_ONCE(link->sactive & (1 << qc->hw_tag));
@@ -5917,15 +5886,9 @@ void __ata_port_probe(struct ata_port *ap)
 
 int ata_port_probe(struct ata_port *ap)
 {
-	int rc = 0;
-
-	if (ap->ops->error_handler) {
-		__ata_port_probe(ap);
-		ata_port_wait_eh(ap);
-	} else {
-		rc = ata_bus_probe(ap);
-	}
-	return rc;
+	__ata_port_probe(ap);
+	ata_port_wait_eh(ap);
+	return 0;
 }
 
 
@@ -6130,9 +6093,6 @@ static void ata_port_detach(struct ata_port *ap)
 	struct ata_link *link;
 	struct ata_device *dev;
 
-	if (!ap->ops->error_handler)
-		goto skip_eh;
-
 	/* tell EH we're leaving & flush EH */
 	spin_lock_irqsave(ap->lock, flags);
 	ap->pflags |= ATA_PFLAG_UNLOADING;
@@ -6148,7 +6108,6 @@ static void ata_port_detach(struct ata_port *ap)
 	cancel_delayed_work_sync(&ap->hotplug_task);
 	cancel_delayed_work_sync(&ap->scsi_rescan_task);
 
- skip_eh:
 	/* clean up zpodd on port removal */
 	ata_for_each_link(link, ap, HOST_FIRST) {
 		ata_for_each_dev(dev, link, ALL) {
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 35e03679b0bf..dc7857f9aa94 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -571,13 +571,10 @@ void ata_scsi_cmd_error_handler(struct Scsi_Host *host, struct ata_port *ap,
 	/* make sure sff pio task is not running */
 	ata_sff_flush_pio_task(ap);
 
-	if (!ap->ops->error_handler)
-		return;
-
 	/* synchronize with host lock and sort out timeouts */
 
 	/*
-	 * For new EH, all qcs are finished in one of three ways -
+	 * For EH, all qcs are finished in one of three ways -
 	 * normal completion, error completion, and SCSI timeout.
 	 * Both completions can race against SCSI timeout.  When normal
 	 * completion wins, the qc never reaches EH.  When error
@@ -659,94 +656,89 @@ EXPORT_SYMBOL(ata_scsi_cmd_error_handler);
 void ata_scsi_port_error_handler(struct Scsi_Host *host, struct ata_port *ap)
 {
 	unsigned long flags;
+	struct ata_link *link;
 
 	/* invoke error handler */
-	if (ap->ops->error_handler) {
-		struct ata_link *link;
 
-		/* acquire EH ownership */
-		ata_eh_acquire(ap);
+	/* acquire EH ownership */
+	ata_eh_acquire(ap);
  repeat:
-		/* kill fast drain timer */
-		del_timer_sync(&ap->fastdrain_timer);
+	/* kill fast drain timer */
+	del_timer_sync(&ap->fastdrain_timer);
 
-		/* process port resume request */
-		ata_eh_handle_port_resume(ap);
+	/* process port resume request */
+	ata_eh_handle_port_resume(ap);
 
-		/* fetch & clear EH info */
-		spin_lock_irqsave(ap->lock, flags);
+	/* fetch & clear EH info */
+	spin_lock_irqsave(ap->lock, flags);
 
-		ata_for_each_link(link, ap, HOST_FIRST) {
-			struct ata_eh_context *ehc = &link->eh_context;
-			struct ata_device *dev;
+	ata_for_each_link(link, ap, HOST_FIRST) {
+		struct ata_eh_context *ehc = &link->eh_context;
+		struct ata_device *dev;
 
-			memset(&link->eh_context, 0, sizeof(link->eh_context));
-			link->eh_context.i = link->eh_info;
-			memset(&link->eh_info, 0, sizeof(link->eh_info));
+		memset(&link->eh_context, 0, sizeof(link->eh_context));
+		link->eh_context.i = link->eh_info;
+		memset(&link->eh_info, 0, sizeof(link->eh_info));
 
-			ata_for_each_dev(dev, link, ENABLED) {
-				int devno = dev->devno;
+		ata_for_each_dev(dev, link, ENABLED) {
+			int devno = dev->devno;
 
-				ehc->saved_xfer_mode[devno] = dev->xfer_mode;
-				if (ata_ncq_enabled(dev))
-					ehc->saved_ncq_enabled |= 1 << devno;
-			}
+			ehc->saved_xfer_mode[devno] = dev->xfer_mode;
+			if (ata_ncq_enabled(dev))
+				ehc->saved_ncq_enabled |= 1 << devno;
 		}
+	}
 
-		ap->pflags |= ATA_PFLAG_EH_IN_PROGRESS;
-		ap->pflags &= ~ATA_PFLAG_EH_PENDING;
-		ap->excl_link = NULL;	/* don't maintain exclusion over EH */
+	ap->pflags |= ATA_PFLAG_EH_IN_PROGRESS;
+	ap->pflags &= ~ATA_PFLAG_EH_PENDING;
+	ap->excl_link = NULL;	/* don't maintain exclusion over EH */
 
-		spin_unlock_irqrestore(ap->lock, flags);
+	spin_unlock_irqrestore(ap->lock, flags);
 
-		/* invoke EH, skip if unloading or suspended */
-		if (!(ap->pflags & (ATA_PFLAG_UNLOADING | ATA_PFLAG_SUSPENDED)))
-			ap->ops->error_handler(ap);
-		else {
-			/* if unloading, commence suicide */
-			if ((ap->pflags & ATA_PFLAG_UNLOADING) &&
-			    !(ap->pflags & ATA_PFLAG_UNLOADED))
-				ata_eh_unload(ap);
-			ata_eh_finish(ap);
-		}
+	/* invoke EH, skip if unloading or suspended */
+	if (!(ap->pflags & (ATA_PFLAG_UNLOADING | ATA_PFLAG_SUSPENDED)))
+		ap->ops->error_handler(ap);
+	else {
+		/* if unloading, commence suicide */
+		if ((ap->pflags & ATA_PFLAG_UNLOADING) &&
+		    !(ap->pflags & ATA_PFLAG_UNLOADED))
+			ata_eh_unload(ap);
+		ata_eh_finish(ap);
+	}
 
-		/* process port suspend request */
-		ata_eh_handle_port_suspend(ap);
+	/* process port suspend request */
+	ata_eh_handle_port_suspend(ap);
 
-		/* Exception might have happened after ->error_handler
-		 * recovered the port but before this point.  Repeat
-		 * EH in such case.
-		 */
-		spin_lock_irqsave(ap->lock, flags);
+	/*
+	 * Exception might have happened after ->error_handler recovered the
+	 * port but before this point.  Repeat EH in such case.
+	 */
+	spin_lock_irqsave(ap->lock, flags);
 
-		if (ap->pflags & ATA_PFLAG_EH_PENDING) {
-			if (--ap->eh_tries) {
-				spin_unlock_irqrestore(ap->lock, flags);
-				goto repeat;
-			}
-			ata_port_err(ap,
-				     "EH pending after %d tries, giving up\n",
-				     ATA_EH_MAX_TRIES);
-			ap->pflags &= ~ATA_PFLAG_EH_PENDING;
+	if (ap->pflags & ATA_PFLAG_EH_PENDING) {
+		if (--ap->eh_tries) {
+			spin_unlock_irqrestore(ap->lock, flags);
+			goto repeat;
 		}
+		ata_port_err(ap,
+			     "EH pending after %d tries, giving up\n",
+			     ATA_EH_MAX_TRIES);
+		ap->pflags &= ~ATA_PFLAG_EH_PENDING;
+	}
 
-		/* this run is complete, make sure EH info is clear */
-		ata_for_each_link(link, ap, HOST_FIRST)
-			memset(&link->eh_info, 0, sizeof(link->eh_info));
+	/* this run is complete, make sure EH info is clear */
+	ata_for_each_link(link, ap, HOST_FIRST)
+		memset(&link->eh_info, 0, sizeof(link->eh_info));
 
-		/* end eh (clear host_eh_scheduled) while holding
-		 * ap->lock such that if exception occurs after this
-		 * point but before EH completion, SCSI midlayer will
-		 * re-initiate EH.
-		 */
-		ap->ops->end_eh(ap);
+	/*
+	 * end eh (clear host_eh_scheduled) while holding ap->lock such that if
+	 * exception occurs after this point but before EH completion, SCSI
+	 * midlayer will re-initiate EH.
+	 */
+	ap->ops->end_eh(ap);
 
-		spin_unlock_irqrestore(ap->lock, flags);
-		ata_eh_release(ap);
-	} else {
-		WARN_ON(ata_qc_from_tag(ap, ap->link.active_tag) == NULL);
-		ap->ops->eng_timeout(ap);
-	}
+	spin_unlock_irqrestore(ap->lock, flags);
+	ata_eh_release(ap);
 
 	scsi_eh_flush_done_q(&ap->eh_done_q);
 
@@ -912,8 +904,6 @@ void ata_qc_schedule_eh(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 
-	WARN_ON(!ap->ops->error_handler);
-
 	qc->flags |= ATA_QCFLAG_EH;
 	ata_eh_set_pending(ap, 1);
 
@@ -934,8 +924,6 @@ void ata_qc_schedule_eh(struct ata_queued_cmd *qc)
  */
 void ata_std_sched_eh(struct ata_port *ap)
 {
-	WARN_ON(!ap->ops->error_handler);
-
 	if (ap->pflags & ATA_PFLAG_INITIALIZING)
 		return;
 
@@ -989,8 +977,6 @@ static int ata_do_link_abort(struct ata_port *ap, struct ata_link *link)
 	struct ata_queued_cmd *qc;
 	int tag, nr_aborted = 0;
 
-	WARN_ON(!ap->ops->error_handler);
-
 	/* we're gonna abort all commands, no need for fast drain */
 	ata_eh_set_pending(ap, 0);
 
@@ -1065,8 +1051,6 @@ EXPORT_SYMBOL_GPL(ata_port_abort);
  */
 static void __ata_port_freeze(struct ata_port *ap)
 {
-	WARN_ON(!ap->ops->error_handler);
-
 	if (ap->ops->freeze)
 		ap->ops->freeze(ap);
 
@@ -1091,8 +1075,6 @@ static void __ata_port_freeze(struct ata_port *ap)
  */
 int ata_port_freeze(struct ata_port *ap)
 {
-	WARN_ON(!ap->ops->error_handler);
-
 	__ata_port_freeze(ap);
 
 	return ata_port_abort(ap);
@@ -1112,9 +1094,6 @@ void ata_eh_freeze_port(struct ata_port *ap)
 {
 	unsigned long flags;
 
-	if (!ap->ops->error_handler)
-		return;
-
 	spin_lock_irqsave(ap->lock, flags);
 	__ata_port_freeze(ap);
 	spin_unlock_irqrestore(ap->lock, flags);
@@ -1134,9 +1113,6 @@ void ata_eh_thaw_port(struct ata_port *ap)
 {
 	unsigned long flags;
 
-	if (!ap->ops->error_handler)
-		return;
-
 	spin_lock_irqsave(ap->lock, flags);
 
 	ap->pflags &= ~ATA_PFLAG_FROZEN;
diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 85e279a12f62..99d4ab04bcce 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -1158,12 +1158,7 @@ EXPORT_SYMBOL_GPL(ata_sas_port_alloc);
  */
 int ata_sas_port_start(struct ata_port *ap)
 {
-	/*
-	 * the port is marked as frozen at allocation time, but if we don't
-	 * have new eh, we won't thaw it
-	 */
-	if (!ap->ops->error_handler)
-		ap->pflags &= ~ATA_PFLAG_FROZEN;
+	/* the port is marked as frozen at allocation time */
 	return 0;
 }
 EXPORT_SYMBOL_GPL(ata_sas_port_start);
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 370d18aca71e..dd427a6a3276 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -709,47 +709,6 @@ static void ata_qc_set_pc_nbytes(struct ata_queued_cmd *qc)
 	qc->nbytes = scsi_bufflen(scmd) + qc->extrabytes;
 }
 
-/**
- *	ata_dump_status - user friendly display of error info
- *	@ap: the port in question
- *	@tf: ptr to filled out taskfile
- *
- *	Decode and dump the ATA error/status registers for the user so
- *	that they have some idea what really happened at the non
- *	make-believe layer.
- *
- *	LOCKING:
- *	inherited from caller
- */
-static void ata_dump_status(struct ata_port *ap, struct ata_taskfile *tf)
-{
-	u8 stat = tf->status, err = tf->error;
-
-	if (stat & ATA_BUSY) {
-		ata_port_warn(ap, "status=0x%02x {Busy} ", stat);
-	} else {
-		ata_port_warn(ap, "status=0x%02x { %s%s%s%s%s%s%s} ", stat,
-			      stat & ATA_DRDY ? "DriveReady " : "",
-			      stat & ATA_DF ? "DeviceFault " : "",
-			      stat & ATA_DSC ? "SeekComplete " : "",
-			      stat & ATA_DRQ ? "DataRequest " : "",
-			      stat & ATA_CORR ? "CorrectedError " : "",
-			      stat & ATA_SENSE ? "Sense " : "",
-			      stat & ATA_ERR ? "Error " : "");
-		if (err)
-			ata_port_warn(ap, "error=0x%02x {%s%s%s%s%s%s", err,
-				      err & ATA_ABORTED ?
-				      "DriveStatusError " : "",
-				      err & ATA_ICRC ?
-				      (err & ATA_ABORTED ?
-				       "BadCRC " : "Sector ") : "",
-				      err & ATA_UNC ? "UncorrectableError " : "",
-				      err & ATA_IDNF ? "SectorIdNotFound " : "",
-				      err & ATA_TRK0NF ? "TrackZeroNotFound " : "",
-				      err & ATA_AMNF ? "AddrMarkNotFound " : "");
-	}
-}
-
 /**
  *	ata_to_sense_error - convert ATA error to SCSI error
  *	@id: ATA device number
@@ -904,7 +863,6 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 	struct ata_taskfile *tf = &qc->result_tf;
 	unsigned char *sb = cmd->sense_buffer;
 	unsigned char *desc = sb + 8;
-	int verbose = qc->ap->ops->error_handler == NULL;
 	u8 sense_key, asc, ascq;
 
 	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
@@ -916,7 +874,7 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 	if (qc->err_mask ||
 	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
 		ata_to_sense_error(qc->ap->print_id, tf->status, tf->error,
-				   &sense_key, &asc, &ascq, verbose);
+				   &sense_key, &asc, &ascq, false);
 		ata_scsi_set_sense(qc->dev, cmd, sense_key, asc, ascq);
 	} else {
 		/*
@@ -999,7 +957,6 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	struct ata_taskfile *tf = &qc->result_tf;
 	unsigned char *sb = cmd->sense_buffer;
-	int verbose = qc->ap->ops->error_handler == NULL;
 	u64 block;
 	u8 sense_key, asc, ascq;
 
@@ -1017,7 +974,7 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 	if (qc->err_mask ||
 	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
 		ata_to_sense_error(qc->ap->print_id, tf->status, tf->error,
-				   &sense_key, &asc, &ascq, verbose);
+				   &sense_key, &asc, &ascq, false);
 		ata_scsi_set_sense(dev, cmd, sense_key, asc, ascq);
 	} else {
 		/* Could not decode error */
@@ -1179,9 +1136,6 @@ void ata_scsi_slave_destroy(struct scsi_device *sdev)
 	unsigned long flags;
 	struct ata_device *dev;
 
-	if (!ap->ops->error_handler)
-		return;
-
 	spin_lock_irqsave(ap->lock, flags);
 	dev = __ata_scsi_find_dev(ap, sdev);
 	if (dev && dev->sdev) {
@@ -1668,7 +1622,6 @@ static void ata_qc_done(struct ata_queued_cmd *qc)
 
 static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 {
-	struct ata_port *ap = qc->ap;
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	u8 *cdb = cmd->cmnd;
 	int need_sense = (qc->err_mask != 0) &&
@@ -1692,9 +1645,6 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 		/* Keep the SCSI ML and status byte, clear host byte. */
 		cmd->result &= 0x0000ffff;
 
-	if (need_sense && !ap->ops->error_handler)
-		ata_dump_status(ap, &qc->result_tf);
-
 	ata_qc_done(qc);
 }
 
@@ -2601,71 +2551,12 @@ static unsigned int ata_scsiop_report_luns(struct ata_scsi_args *args, u8 *rbuf)
 	return 0;
 }
 
-static void atapi_sense_complete(struct ata_queued_cmd *qc)
-{
-	if (qc->err_mask && ((qc->err_mask & AC_ERR_DEV) == 0)) {
-		/* FIXME: not quite right; we don't want the
-		 * translation of taskfile registers into
-		 * a sense descriptors, since that's only
-		 * correct for ATA, not ATAPI
-		 */
-		ata_gen_passthru_sense(qc);
-	}
-
-	ata_qc_done(qc);
-}
-
 /* is it pointless to prefer PIO for "safety reasons"? */
 static inline int ata_pio_use_silly(struct ata_port *ap)
 {
 	return (ap->flags & ATA_FLAG_PIO_DMA);
 }
 
-static void atapi_request_sense(struct ata_queued_cmd *qc)
-{
-	struct ata_port *ap = qc->ap;
-	struct scsi_cmnd *cmd = qc->scsicmd;
-
-	memset(cmd->sense_buffer, 0, SCSI_SENSE_BUFFERSIZE);
-
-#ifdef CONFIG_ATA_SFF
-	if (ap->ops->sff_tf_read)
-		ap->ops->sff_tf_read(ap, &qc->tf);
-#endif
-
-	/* fill these in, for the case where they are -not- overwritten */
-	cmd->sense_buffer[0] = 0x70;
-	cmd->sense_buffer[2] = qc->tf.error >> 4;
-
-	ata_qc_reinit(qc);
-
-	/* setup sg table and init transfer direction */
-	sg_init_one(&qc->sgent, cmd->sense_buffer, SCSI_SENSE_BUFFERSIZE);
-	ata_sg_init(qc, &qc->sgent, 1);
-	qc->dma_dir = DMA_FROM_DEVICE;
-
-	memset(&qc->cdb, 0, qc->dev->cdb_len);
-	qc->cdb[0] = REQUEST_SENSE;
-	qc->cdb[4] = SCSI_SENSE_BUFFERSIZE;
-
-	qc->tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
-	qc->tf.command = ATA_CMD_PACKET;
-
-	if (ata_pio_use_silly(ap)) {
-		qc->tf.protocol = ATAPI_PROT_DMA;
-		qc->tf.feature |= ATAPI_PKT_DMA;
-	} else {
-		qc->tf.protocol = ATAPI_PROT_PIO;
-		qc->tf.lbam = SCSI_SENSE_BUFFERSIZE;
-		qc->tf.lbah = 0;
-	}
-	qc->nbytes = SCSI_SENSE_BUFFERSIZE;
-
-	qc->complete_fn = atapi_sense_complete;
-
-	ata_qc_issue(qc);
-}
-
 /*
  * ATAPI devices typically report zero for their SCSI version, and sometimes
  * deviate from the spec WRT response data format.  If SCSI version is
@@ -2691,9 +2582,8 @@ static void atapi_qc_complete(struct ata_queued_cmd *qc)
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	unsigned int err_mask = qc->err_mask;
 
-	/* handle completion from new EH */
-	if (unlikely(qc->ap->ops->error_handler &&
-		     (err_mask || qc->flags & ATA_QCFLAG_SENSE_VALID))) {
+	/* handle completion from EH */
+	if (unlikely(err_mask || qc->flags & ATA_QCFLAG_SENSE_VALID)) {
 
 		if (!(qc->flags & ATA_QCFLAG_SENSE_VALID)) {
 			/* FIXME: not quite right; we don't want the
@@ -2725,23 +2615,10 @@ static void atapi_qc_complete(struct ata_queued_cmd *qc)
 		return;
 	}
 
-	/* successful completion or old EH failure path */
-	if (unlikely(err_mask & AC_ERR_DEV)) {
-		cmd->result = SAM_STAT_CHECK_CONDITION;
-		atapi_request_sense(qc);
-		return;
-	} else if (unlikely(err_mask)) {
-		/* FIXME: not quite right; we don't want the
-		 * translation of taskfile registers into
-		 * a sense descriptors, since that's only
-		 * correct for ATA, not ATAPI
-		 */
-		ata_gen_passthru_sense(qc);
-	} else {
-		if (cmd->cmnd[0] == INQUIRY && (cmd->cmnd[1] & 0x03) == 0)
-			atapi_fixup_inquiry(cmd);
-		cmd->result = SAM_STAT_GOOD;
-	}
+	/* successful completion path */
+	if (cmd->cmnd[0] == INQUIRY && (cmd->cmnd[1] & 0x03) == 0)
+		atapi_fixup_inquiry(cmd);
+	cmd->result = SAM_STAT_GOOD;
 
 	ata_qc_done(qc);
 }
@@ -4790,9 +4667,6 @@ int ata_scsi_user_scan(struct Scsi_Host *shost, unsigned int channel,
 	unsigned long flags;
 	int devno, rc = 0;
 
-	if (!ap->ops->error_handler)
-		return -EOPNOTSUPP;
-
 	if (lun != SCAN_WILD_CARD && lun)
 		return -EINVAL;
 
diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 9d28badfe41d..84471d92cd1b 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -883,31 +883,21 @@ static void ata_hsm_qc_complete(struct ata_queued_cmd *qc, int in_wq)
 {
 	struct ata_port *ap = qc->ap;
 
-	if (ap->ops->error_handler) {
-		if (in_wq) {
-			/* EH might have kicked in while host lock is
-			 * released.
-			 */
-			qc = ata_qc_from_tag(ap, qc->tag);
-			if (qc) {
-				if (likely(!(qc->err_mask & AC_ERR_HSM))) {
-					ata_sff_irq_on(ap);
-					ata_qc_complete(qc);
-				} else
-					ata_port_freeze(ap);
-			}
-		} else {
-			if (likely(!(qc->err_mask & AC_ERR_HSM)))
+	if (in_wq) {
+		/* EH might have kicked in while host lock is released. */
+		qc = ata_qc_from_tag(ap, qc->tag);
+		if (qc) {
+			if (likely(!(qc->err_mask & AC_ERR_HSM))) {
+				ata_sff_irq_on(ap);
 				ata_qc_complete(qc);
-			else
+			} else
 				ata_port_freeze(ap);
 		}
 	} else {
-		if (in_wq) {
-			ata_sff_irq_on(ap);
-			ata_qc_complete(qc);
-		} else
+		if (likely(!(qc->err_mask & AC_ERR_HSM)))
 			ata_qc_complete(qc);
+		else
+			ata_port_freeze(ap);
 	}
 }
 
-- 
2.41.0

