Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A093C6D6C43
	for <lists+linux-scsi@lfdr.de>; Tue,  4 Apr 2023 20:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236046AbjDDSfG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Apr 2023 14:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbjDDSeq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 4 Apr 2023 14:34:46 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38355618E;
        Tue,  4 Apr 2023 11:32:37 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id q16so43498326lfe.10;
        Tue, 04 Apr 2023 11:32:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680633155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SC3qFX3cppOOmIsochKPNMew46lgkTDShW84zGbqSAc=;
        b=wWncxs7Mj1Ngr0Rzl2KzaOLdISDtRUcjxUquZt4ZCnDRlW+niAh9hYbZDuOlO2f0OK
         pPYqXTygegEvjs+2Nki6Q6iTY0KX8K0ZXgJCXv1iFB2TLn6a6h2a7GEYDGCREOZBN41M
         dy7LFQtIIKfoW+T8BU292xy63a7fZTxV020JZeu9GdG1F8g/xkRAmcYcAfFQwAXy9FRy
         wBnRYenS6hY/Sb5FC1uAt0KNmp2VOD/qXHZE42eF21VsT9mSdRzNAxIaSMnrEpJMnPFc
         6vj3G3fhBjBC1OeLx7X/syRepcg8TZYij3B42P29gmWTMH5Fjn9aRvbl08u4lEBEkyZC
         QAzw==
X-Gm-Message-State: AAQBX9cuXxm9W1ylowtCaFUhao3SUrHWF7MHfeXvAYml3LRdb50Iw2Ut
        95t8Ypn2it9eRlEXVnxVi4OxKJhKXYIpmA==
X-Google-Smtp-Source: AKy350Y6ujVPXi5ruA+9cYxiqUrnKVtzGE8CxDO04H8EfJQra/YCzI9RTpOXsWrQzbPO5o4uVvyTwg==
X-Received: by 2002:ac2:561b:0:b0:4eb:2a26:babf with SMTP id v27-20020ac2561b000000b004eb2a26babfmr69262lfd.0.1680633155293;
        Tue, 04 Apr 2023 11:32:35 -0700 (PDT)
Received: from flawful.org (c-a3f5e255.011-101-6d6c6d3.bbcust.telenor.se. [85.226.245.163])
        by smtp.gmail.com with ESMTPSA id q5-20020ac25145000000b004e95f1c9e7dsm2432666lfd.78.2023.04.04.11.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 11:32:35 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
        id 25AF1865; Tue,  4 Apr 2023 20:32:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1680633154; bh=8QygcPIx/4EeXbdRDR3kJ+DC5go+i6+mTczbxTeFKUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tYykk+GOg7RMVUW5xbrfVtp+SJvE6k9jUhmGnktkTzkXvguRF9+TK/9VQBZCFOTtl
         f+cP5HGrjvnsF5lcLDgx0nhnTr50xdRF9oxW8ROxYIZ7lfcyZyvVlwHFcuHp+qYXhg
         /ejN74tg6YqtHdA/t7Ml4Hm+go5QLtzAbuu4BVoo=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
Received: from x1-carbon.lan (OpenWrt.lan [192.168.1.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by flawful.org (Postfix) with ESMTPSA id DC1F8D26;
        Tue,  4 Apr 2023 20:25:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
        t=1680632748; bh=8QygcPIx/4EeXbdRDR3kJ+DC5go+i6+mTczbxTeFKUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q5HD4JN05uE4dcpiB76EFNGx+h9UVgH39ZtnKqngEPpk2eyMnFbwajZIoBoAb2QEu
         rnarPvJIqgvXYTOjvjgzGEzGjO/1QwIbtOudDYQ3R+j7inwGZ0DVJ4ST5eTtc2R+H/
         StJ+mh23sPjkl75x67ogPzGUr9YqHrYJQEvFoico=
From:   Niklas Cassel <nks@flawful.org>
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-block@vger.kernel.org, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH v5 11/19] scsi: sd: handle read/write CDL timeout failures
Date:   Tue,  4 Apr 2023 20:24:16 +0200
Message-Id: <20230404182428.715140-12-nks@flawful.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404182428.715140-1-nks@flawful.org>
References: <20230404182428.715140-1-nks@flawful.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Niklas Cassel <niklas.cassel@wdc.com>

Commands using a duration limit descriptor that has limit policies set
to a value other than 0x0 may be failed by the device if one of the
limits are exceeded. For such commands, since the failure is the result
of the user duration limit configuration and workload, the commands
should not be retried and terminated immediately. Furthermore, to allow
the user to differentiate these "soft" failures from hard errors due to
hardware problem, a different error code than EIO should be returned.

There are 2 cases to consider:
(1) The failure is due to a limit policy failing the command with a
check condition sense key, that is, any limit policy other than 0xD.
For this case, scsi_check_sense() is modified to detect failures with
the ABORTED COMMAND sense key and the COMMAND TIMEOUT BEFORE PROCESSING
or COMMAND TIMEOUT DURING PROCESSING or COMMAND TIMEOUT DURING
PROCESSING DUE TO ERROR RECOVERY additional sense code. For these
failures, a SUCCESS disposition is returned so that
scsi_finish_command() is called to terminate the command.

(2) The failure is due to a limit policy set to 0xD, which result in the
command being terminated with a GOOD status, COMPLETED sense key, and
DATA CURRENTLY UNAVAILABLE additional sense code. To handle this case,
the scsi_check_sense() is modified to return a SUCCESS disposition so
that scsi_finish_command() is called to terminate the command.
In addition, scsi_decide_disposition() has to be modified to see if a
command being terminated with GOOD status has sense data.
This is as defined in SCSI Primary Commands - 6 (SPC-6), so all
according to spec, even if GOOD status commands were not checked before.

If scsi_check_sense() detects sense data representing a duration limit,
scsi_check_sense() will set the newly introduced SCSI ML byte
SCSIML_STAT_DL_TIMEOUT. This SCSI ML byte is checked in
scsi_noretry_cmd(), so that a command that failed because of a CDL
timeout cannot be retried. The SCSI ML byte is also checked in
scsi_result_to_blk_status() to complete the command request with the
BLK_STS_DURATION_LIMIT status, which result in the user seeing ETIME
errors for the failed commands.

Co-developed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 drivers/scsi/scsi_error.c | 45 +++++++++++++++++++++++++++++++++++++++
 drivers/scsi/scsi_lib.c   |  4 ++++
 drivers/scsi/scsi_priv.h  |  1 +
 3 files changed, 50 insertions(+)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index cf5ec5f5f4f6..dc85a75b33d9 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -536,6 +536,7 @@ static inline void set_scsi_ml_byte(struct scsi_cmnd *cmd, u8 status)
  */
 enum scsi_disposition scsi_check_sense(struct scsi_cmnd *scmd)
 {
+	struct request *req = scsi_cmd_to_rq(scmd);
 	struct scsi_device *sdev = scmd->device;
 	struct scsi_sense_hdr sshdr;
 
@@ -595,6 +596,22 @@ enum scsi_disposition scsi_check_sense(struct scsi_cmnd *scmd)
 		if (sshdr.asc == 0x10) /* DIF */
 			return SUCCESS;
 
+		/*
+		 * Check aborts due to command duration limit policy:
+		 * ABORTED COMMAND additional sense code with the
+		 * COMMAND TIMEOUT BEFORE PROCESSING or
+		 * COMMAND TIMEOUT DURING PROCESSING or
+		 * COMMAND TIMEOUT DURING PROCESSING DUE TO ERROR RECOVERY
+		 * additional sense code qualifiers.
+		 */
+		if (sshdr.asc == 0x2e &&
+		    sshdr.ascq >= 0x01 && sshdr.ascq <= 0x03) {
+			set_scsi_ml_byte(scmd, SCSIML_STAT_DL_TIMEOUT);
+			req->cmd_flags |= REQ_FAILFAST_DEV;
+			req->rq_flags |= RQF_QUIET;
+			return SUCCESS;
+		}
+
 		if (sshdr.asc == 0x44 && sdev->sdev_bflags & BLIST_RETRY_ITF)
 			return ADD_TO_MLQUEUE;
 		if (sshdr.asc == 0xc1 && sshdr.ascq == 0x01 &&
@@ -691,6 +708,14 @@ enum scsi_disposition scsi_check_sense(struct scsi_cmnd *scmd)
 		}
 		return SUCCESS;
 
+	case COMPLETED:
+		if (sshdr.asc == 0x55 && sshdr.ascq == 0x0a) {
+			set_scsi_ml_byte(scmd, SCSIML_STAT_DL_TIMEOUT);
+			req->cmd_flags |= REQ_FAILFAST_DEV;
+			req->rq_flags |= RQF_QUIET;
+		}
+		return SUCCESS;
+
 	default:
 		return SUCCESS;
 	}
@@ -785,6 +810,14 @@ static enum scsi_disposition scsi_eh_completed_normally(struct scsi_cmnd *scmd)
 	switch (get_status_byte(scmd)) {
 	case SAM_STAT_GOOD:
 		scsi_handle_queue_ramp_up(scmd->device);
+		if (scmd->sense_buffer && SCSI_SENSE_VALID(scmd))
+			/*
+			 * If we have sense data, call scsi_check_sense() in
+			 * order to set the correct SCSI ML byte (if any).
+			 * No point in checking the return value, since the
+			 * command has already completed successfully.
+			 */
+			scsi_check_sense(scmd);
 		fallthrough;
 	case SAM_STAT_COMMAND_TERMINATED:
 		return SUCCESS;
@@ -1807,6 +1840,10 @@ bool scsi_noretry_cmd(struct scsi_cmnd *scmd)
 		return !!(req->cmd_flags & REQ_FAILFAST_DRIVER);
 	}
 
+	/* Never retry commands aborted due to a duration limit timeout */
+	if (scsi_ml_byte(scmd->result) == SCSIML_STAT_DL_TIMEOUT)
+		return true;
+
 	if (!scsi_status_is_check_condition(scmd->result))
 		return false;
 
@@ -1966,6 +2003,14 @@ enum scsi_disposition scsi_decide_disposition(struct scsi_cmnd *scmd)
 		if (scmd->cmnd[0] == REPORT_LUNS)
 			scmd->device->sdev_target->expecting_lun_change = 0;
 		scsi_handle_queue_ramp_up(scmd->device);
+		if (scmd->sense_buffer && SCSI_SENSE_VALID(scmd))
+			/*
+			 * If we have sense data, call scsi_check_sense() in
+			 * order to set the correct SCSI ML byte (if any).
+			 * No point in checking the return value, since the
+			 * command has already completed successfully.
+			 */
+			scsi_check_sense(scmd);
 		fallthrough;
 	case SAM_STAT_COMMAND_TERMINATED:
 		return SUCCESS;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 633c4e8af830..b894432ca0b9 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -601,6 +601,8 @@ static blk_status_t scsi_result_to_blk_status(int result)
 		return BLK_STS_MEDIUM;
 	case SCSIML_STAT_TGT_FAILURE:
 		return BLK_STS_TARGET;
+	case SCSIML_STAT_DL_TIMEOUT:
+		return BLK_STS_DURATION_LIMIT;
 	}
 
 	switch (host_byte(result)) {
@@ -798,6 +800,8 @@ static void scsi_io_completion_action(struct scsi_cmnd *cmd, int result)
 				blk_stat = BLK_STS_ZONE_OPEN_RESOURCE;
 			}
 			break;
+		case COMPLETED:
+			fallthrough;
 		default:
 			action = ACTION_FAIL;
 			break;
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 74324fba4281..f42388ecb024 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -27,6 +27,7 @@ enum scsi_ml_status {
 	SCSIML_STAT_NOSPC		= 0x02,	/* Space allocation on the dev failed */
 	SCSIML_STAT_MED_ERROR		= 0x03,	/* Medium error */
 	SCSIML_STAT_TGT_FAILURE		= 0x04,	/* Permanent target failure */
+	SCSIML_STAT_DL_TIMEOUT		= 0x05, /* Command Duration Limit timeout */
 };
 
 static inline u8 scsi_ml_byte(int result)
-- 
2.39.2

