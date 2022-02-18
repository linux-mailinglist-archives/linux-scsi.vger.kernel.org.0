Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F804BC091
	for <lists+linux-scsi@lfdr.de>; Fri, 18 Feb 2022 20:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238235AbiBRTwa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 18 Feb 2022 14:52:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238271AbiBRTwJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 18 Feb 2022 14:52:09 -0500
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E838291F85
        for <linux-scsi@vger.kernel.org>; Fri, 18 Feb 2022 11:51:52 -0800 (PST)
Received: by mail-pf1-f173.google.com with SMTP id c4so3126758pfl.7
        for <linux-scsi@vger.kernel.org>; Fri, 18 Feb 2022 11:51:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rzT3EzQ4DCE8qaMk2M0orsVE5XN2yxnIAxRkAgTIWg4=;
        b=w9waDvdi+HzVGty9ZaGZg8ekkSqAs46dUcTR6DZmuA03pRrQ7BrKBM+Nkt8vE1XUoH
         gPrYf0MnbzbVQXfXdODwTvL3xyKlRQ6nhKXVmjGEwtTiBRNuBry3SFBrO26kqMD/SR/3
         bYz12hMBZQU02fSohNaUASN/2nm0j4Q7tgM+OzRK0+n34+GL8mN5OcVRTW93Rk+zwmqj
         H28fAykJEoip1FsV2wmxd31CGJyP13/lbm9wYozPa22MZdwtEJnEJVW/Ri4TNU7864gB
         yUQsET5+yUOY0DvQnt9kdxHW2iV5OOU9Tla2PtGay4+sMicrFlAFzEfOiVVXYYPAU85s
         u7Cg==
X-Gm-Message-State: AOAM530v1SDNUJa3wp/hhx5HWuVtmfWupCnog1kEGw0T3ccq6oQICifu
        RQ+ke4ytLvfLf/ZaUWw7duO3ZKJqjJuTSw==
X-Google-Smtp-Source: ABdhPJycbrZ/JcJwAUq/S2BUM6OwSF2AYDzAwhJVYHCrTcj5pi5oieiaIeBt/mFIfSemveo303by8w==
X-Received: by 2002:aa7:9017:0:b0:4df:e33f:f1b4 with SMTP id m23-20020aa79017000000b004dfe33ff1b4mr9365641pfo.80.1645213911829;
        Fri, 18 Feb 2022 11:51:51 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
        by smtp.gmail.com with ESMTPSA id e15sm3930523pfv.104.2022.02.18.11.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 11:51:51 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>
Subject: [PATCH v5 12/49] scsi: aacraid: Move the SCSI pointer to private command data
Date:   Fri, 18 Feb 2022 11:50:40 -0800
Message-Id: <20220218195117.25689-13-bvanassche@acm.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218195117.25689-1-bvanassche@acm.org>
References: <20220218195117.25689-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Set .cmd_size in the SCSI host template instead of using the SCSI pointer
from struct scsi_cmnd. This patch prepares for removal of the SCSI pointer
from struct scsi_cmnd.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/aacraid/aachba.c   | 43 ++++++++++++++++++---------------
 drivers/scsi/aacraid/aacraid.h  | 24 ++++++++++++++----
 drivers/scsi/aacraid/comminit.c |  2 +-
 drivers/scsi/aacraid/linit.c    | 21 ++++++++--------
 4 files changed, 54 insertions(+), 36 deletions(-)

diff --git a/drivers/scsi/aacraid/aachba.c b/drivers/scsi/aacraid/aachba.c
index b04d039da276..81462f4ddb90 100644
--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -338,7 +338,7 @@ static inline int aac_valid_context(struct scsi_cmnd *scsicmd,
 		aac_fib_complete(fibptr);
 		return 0;
 	}
-	scsicmd->SCp.phase = AAC_OWNER_MIDLEVEL;
+	aac_priv(scsicmd)->owner = AAC_OWNER_MIDLEVEL;
 	device = scsicmd->device;
 	if (unlikely(!device)) {
 		dprintk((KERN_WARNING "aac_valid_context: scsi device corrupt\n"));
@@ -592,7 +592,7 @@ static int aac_get_container_name(struct scsi_cmnd * scsicmd)
 
 	aac_fib_init(cmd_fibcontext);
 	dinfo = (struct aac_get_name *) fib_data(cmd_fibcontext);
-	scsicmd->SCp.phase = AAC_OWNER_FIRMWARE;
+	aac_priv(scsicmd)->owner = AAC_OWNER_FIRMWARE;
 
 	dinfo->command = cpu_to_le32(VM_ContainerConfig);
 	dinfo->type = cpu_to_le32(CT_READ_NAME);
@@ -634,14 +634,15 @@ static void _aac_probe_container2(void * context, struct fib * fibptr)
 {
 	struct fsa_dev_info *fsa_dev_ptr;
 	int (*callback)(struct scsi_cmnd *);
-	struct scsi_cmnd * scsicmd = (struct scsi_cmnd *)context;
+	struct scsi_cmnd *scsicmd = context;
+	struct aac_cmd_priv *cmd_priv = aac_priv(scsicmd);
 	int i;
 
 
 	if (!aac_valid_context(scsicmd, fibptr))
 		return;
 
-	scsicmd->SCp.Status = 0;
+	cmd_priv->status = 0;
 	fsa_dev_ptr = fibptr->dev->fsa_dev;
 	if (fsa_dev_ptr) {
 		struct aac_mount * dresp = (struct aac_mount *) fib_data(fibptr);
@@ -679,12 +680,12 @@ static void _aac_probe_container2(void * context, struct fib * fibptr)
 		}
 		if ((fsa_dev_ptr->valid & 1) == 0)
 			fsa_dev_ptr->valid = 0;
-		scsicmd->SCp.Status = le32_to_cpu(dresp->count);
+		cmd_priv->status = le32_to_cpu(dresp->count);
 	}
 	aac_fib_complete(fibptr);
 	aac_fib_free(fibptr);
-	callback = (int (*)(struct scsi_cmnd *))(scsicmd->SCp.ptr);
-	scsicmd->SCp.ptr = NULL;
+	callback = cmd_priv->callback;
+	cmd_priv->callback = NULL;
 	(*callback)(scsicmd);
 	return;
 }
@@ -722,7 +723,7 @@ static void _aac_probe_container1(void * context, struct fib * fibptr)
 
 	dinfo->count = cpu_to_le32(scmd_id(scsicmd));
 	dinfo->type = cpu_to_le32(FT_FILESYS);
-	scsicmd->SCp.phase = AAC_OWNER_FIRMWARE;
+	aac_priv(scsicmd)->owner = AAC_OWNER_FIRMWARE;
 
 	status = aac_fib_send(ContainerCommand,
 			  fibptr,
@@ -743,6 +744,7 @@ static void _aac_probe_container1(void * context, struct fib * fibptr)
 
 static int _aac_probe_container(struct scsi_cmnd * scsicmd, int (*callback)(struct scsi_cmnd *))
 {
+	struct aac_cmd_priv *cmd_priv = aac_priv(scsicmd);
 	struct fib * fibptr;
 	int status = -ENOMEM;
 
@@ -761,8 +763,8 @@ static int _aac_probe_container(struct scsi_cmnd * scsicmd, int (*callback)(stru
 
 		dinfo->count = cpu_to_le32(scmd_id(scsicmd));
 		dinfo->type = cpu_to_le32(FT_FILESYS);
-		scsicmd->SCp.ptr = (char *)callback;
-		scsicmd->SCp.phase = AAC_OWNER_FIRMWARE;
+		cmd_priv->callback = callback;
+		cmd_priv->owner = AAC_OWNER_FIRMWARE;
 
 		status = aac_fib_send(ContainerCommand,
 			  fibptr,
@@ -778,7 +780,7 @@ static int _aac_probe_container(struct scsi_cmnd * scsicmd, int (*callback)(stru
 			return 0;
 
 		if (status < 0) {
-			scsicmd->SCp.ptr = NULL;
+			cmd_priv->callback = NULL;
 			aac_fib_complete(fibptr);
 			aac_fib_free(fibptr);
 		}
@@ -817,6 +819,7 @@ static void aac_probe_container_scsi_done(struct scsi_cmnd *scsi_cmnd)
 int aac_probe_container(struct aac_dev *dev, int cid)
 {
 	struct scsi_cmnd *scsicmd = kzalloc(sizeof(*scsicmd), GFP_KERNEL);
+	struct aac_cmd_priv *cmd_priv = aac_priv(scsicmd);
 	struct scsi_device *scsidev = kzalloc(sizeof(*scsidev), GFP_KERNEL);
 	int status;
 
@@ -835,7 +838,7 @@ int aac_probe_container(struct aac_dev *dev, int cid)
 		while (scsicmd->device == scsidev)
 			schedule();
 	kfree(scsidev);
-	status = scsicmd->SCp.Status;
+	status = cmd_priv->status;
 	kfree(scsicmd);
 	return status;
 }
@@ -1128,7 +1131,7 @@ static int aac_get_container_serial(struct scsi_cmnd * scsicmd)
 	dinfo->command = cpu_to_le32(VM_ContainerConfig);
 	dinfo->type = cpu_to_le32(CT_CID_TO_32BITS_UID);
 	dinfo->cid = cpu_to_le32(scmd_id(scsicmd));
-	scsicmd->SCp.phase = AAC_OWNER_FIRMWARE;
+	aac_priv(scsicmd)->owner = AAC_OWNER_FIRMWARE;
 
 	status = aac_fib_send(ContainerCommand,
 		  cmd_fibcontext,
@@ -2486,7 +2489,7 @@ static int aac_read(struct scsi_cmnd * scsicmd)
 	 *	Alocate and initialize a Fib
 	 */
 	cmd_fibcontext = aac_fib_alloc_tag(dev, scsicmd);
-	scsicmd->SCp.phase = AAC_OWNER_FIRMWARE;
+	aac_priv(scsicmd)->owner = AAC_OWNER_FIRMWARE;
 	status = aac_adapter_read(cmd_fibcontext, scsicmd, lba, count);
 
 	/*
@@ -2577,7 +2580,7 @@ static int aac_write(struct scsi_cmnd * scsicmd)
 	 *	Allocate and initialize a Fib then setup a BlockWrite command
 	 */
 	cmd_fibcontext = aac_fib_alloc_tag(dev, scsicmd);
-	scsicmd->SCp.phase = AAC_OWNER_FIRMWARE;
+	aac_priv(scsicmd)->owner = AAC_OWNER_FIRMWARE;
 	status = aac_adapter_write(cmd_fibcontext, scsicmd, lba, count, fua);
 
 	/*
@@ -2660,7 +2663,7 @@ static int aac_synchronize(struct scsi_cmnd *scsicmd)
 	synchronizecmd->cid = cpu_to_le32(scmd_id(scsicmd));
 	synchronizecmd->count =
 	     cpu_to_le32(sizeof(((struct aac_synchronize_reply *)NULL)->data));
-	scsicmd->SCp.phase = AAC_OWNER_FIRMWARE;
+	aac_priv(scsicmd)->owner = AAC_OWNER_FIRMWARE;
 
 	/*
 	 *	Now send the Fib to the adapter
@@ -2736,7 +2739,7 @@ static int aac_start_stop(struct scsi_cmnd *scsicmd)
 	pmcmd->cid = cpu_to_le32(sdev_id(sdev));
 	pmcmd->parm = (scsicmd->cmnd[1] & 1) ?
 		cpu_to_le32(CT_PM_UNIT_IMMEDIATE) : 0;
-	scsicmd->SCp.phase = AAC_OWNER_FIRMWARE;
+	aac_priv(scsicmd)->owner = AAC_OWNER_FIRMWARE;
 
 	/*
 	 *	Now send the Fib to the adapter
@@ -3695,7 +3698,7 @@ void aac_hba_callback(void *context, struct fib *fibptr)
 	aac_fib_complete(fibptr);
 
 	if (fibptr->flags & FIB_CONTEXT_FLAG_NATIVE_HBA_TMF)
-		scsicmd->SCp.sent_command = 1;
+		aac_priv(scsicmd)->sent_command = 1;
 	else
 		aac_scsi_done(scsicmd);
 }
@@ -3725,7 +3728,7 @@ static int aac_send_srb_fib(struct scsi_cmnd* scsicmd)
 	 *	Allocate and initialize a Fib then setup a BlockWrite command
 	 */
 	cmd_fibcontext = aac_fib_alloc_tag(dev, scsicmd);
-	scsicmd->SCp.phase = AAC_OWNER_FIRMWARE;
+	aac_priv(scsicmd)->owner = AAC_OWNER_FIRMWARE;
 	status = aac_adapter_scsi(cmd_fibcontext, scsicmd);
 
 	/*
@@ -3769,7 +3772,7 @@ static int aac_send_hba_fib(struct scsi_cmnd *scsicmd)
 	if (!cmd_fibcontext)
 		return -1;
 
-	scsicmd->SCp.phase = AAC_OWNER_FIRMWARE;
+	aac_priv(scsicmd)->owner = AAC_OWNER_FIRMWARE;
 	status = aac_adapter_hba(cmd_fibcontext, scsicmd);
 
 	/*
diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.h
index 3733df77bc65..f849e7c9d428 100644
--- a/drivers/scsi/aacraid/aacraid.h
+++ b/drivers/scsi/aacraid/aacraid.h
@@ -29,6 +29,7 @@
 #include <linux/completion.h>
 #include <linux/pci.h>
 #include <scsi/scsi_host.h>
+#include <scsi/scsi_cmnd.h>
 
 /*------------------------------------------------------------------------------
  *              D E F I N E S
@@ -2673,11 +2674,24 @@ static inline void aac_cancel_rescan_worker(struct aac_dev *dev)
 	cancel_delayed_work_sync(&dev->src_reinit_aif_worker);
 }
 
-/* SCp.phase values */
-#define AAC_OWNER_MIDLEVEL	0x101
-#define AAC_OWNER_LOWLEVEL	0x102
-#define AAC_OWNER_ERROR_HANDLER	0x103
-#define AAC_OWNER_FIRMWARE	0x106
+enum aac_cmd_owner {
+	AAC_OWNER_MIDLEVEL	= 0x101,
+	AAC_OWNER_LOWLEVEL	= 0x102,
+	AAC_OWNER_ERROR_HANDLER	= 0x103,
+	AAC_OWNER_FIRMWARE	= 0x106,
+};
+
+struct aac_cmd_priv {
+	int			(*callback)(struct scsi_cmnd *);
+	int			status;
+	enum aac_cmd_owner	owner;
+	bool			sent_command;
+};
+
+static inline struct aac_cmd_priv *aac_priv(struct scsi_cmnd *cmd)
+{
+	return scsi_cmd_priv(cmd);
+}
 
 void aac_safw_rescan_worker(struct work_struct *work);
 void aac_src_reinit_aif_worker(struct work_struct *work);
diff --git a/drivers/scsi/aacraid/comminit.c b/drivers/scsi/aacraid/comminit.c
index 355b16f0b145..940a6deab38f 100644
--- a/drivers/scsi/aacraid/comminit.c
+++ b/drivers/scsi/aacraid/comminit.c
@@ -276,7 +276,7 @@ static bool wait_for_io_iter(struct scsi_cmnd *cmd, void *data, bool rsvd)
 {
 	int *active = data;
 
-	if (cmd->SCp.phase == AAC_OWNER_FIRMWARE)
+	if (aac_priv(cmd)->owner == AAC_OWNER_FIRMWARE)
 		*active = *active + 1;
 	return true;
 }
diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index a911252075a6..b91b72b923ec 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -241,10 +241,9 @@ static struct aac_driver_ident aac_drivers[] = {
 static int aac_queuecommand(struct Scsi_Host *shost,
 			    struct scsi_cmnd *cmd)
 {
-	int r = 0;
-	cmd->SCp.phase = AAC_OWNER_LOWLEVEL;
-	r = (aac_scsi_cmd(cmd) ? FAILED : 0);
-	return r;
+	aac_priv(cmd)->owner = AAC_OWNER_LOWLEVEL;
+
+	return aac_scsi_cmd(cmd) ? FAILED : 0;
 }
 
 /**
@@ -638,7 +637,7 @@ static bool fib_count_iter(struct scsi_cmnd *scmnd, void *data, bool reserved)
 {
 	struct fib_count_data *fib_count = data;
 
-	switch (scmnd->SCp.phase) {
+	switch (aac_priv(scmnd)->owner) {
 	case AAC_OWNER_FIRMWARE:
 		fib_count->fwcnt++;
 		break;
@@ -680,6 +679,7 @@ static int get_num_of_incomplete_fibs(struct aac_dev *aac)
 
 static int aac_eh_abort(struct scsi_cmnd* cmd)
 {
+	struct aac_cmd_priv *cmd_priv = aac_priv(cmd);
 	struct scsi_device * dev = cmd->device;
 	struct Scsi_Host * host = dev->host;
 	struct aac_dev * aac = (struct aac_dev *)host->hostdata;
@@ -732,7 +732,7 @@ static int aac_eh_abort(struct scsi_cmnd* cmd)
 		tmf->error_length = cpu_to_le32(FW_ERROR_BUFFER_SIZE);
 
 		fib->hbacmd_size = sizeof(*tmf);
-		cmd->SCp.sent_command = 0;
+		cmd_priv->sent_command = 0;
 
 		status = aac_hba_send(HBA_IU_TYPE_SCSI_TM_REQ, fib,
 				  (fib_callback) aac_hba_callback,
@@ -744,7 +744,7 @@ static int aac_eh_abort(struct scsi_cmnd* cmd)
 		}
 		/* Wait up to 15 secs for completion */
 		for (count = 0; count < 15; ++count) {
-			if (cmd->SCp.sent_command) {
+			if (cmd_priv->sent_command) {
 				ret = SUCCESS;
 				break;
 			}
@@ -784,7 +784,7 @@ static int aac_eh_abort(struct scsi_cmnd* cmd)
 				(fib->callback_data == cmd)) {
 					fib->flags |=
 						FIB_CONTEXT_FLAG_TIMED_OUT;
-					cmd->SCp.phase =
+					cmd_priv->owner =
 						AAC_OWNER_ERROR_HANDLER;
 					ret = SUCCESS;
 				}
@@ -811,7 +811,7 @@ static int aac_eh_abort(struct scsi_cmnd* cmd)
 					(command->device == cmd->device)) {
 					fib->flags |=
 						FIB_CONTEXT_FLAG_TIMED_OUT;
-					command->SCp.phase =
+					aac_priv(command)->owner =
 						AAC_OWNER_ERROR_HANDLER;
 					if (command == cmd)
 						ret = SUCCESS;
@@ -1058,7 +1058,7 @@ static int aac_eh_bus_reset(struct scsi_cmnd* cmd)
 			if (bus >= AAC_MAX_BUSES || cid >= AAC_MAX_TARGETS ||
 			    info->devtype != AAC_DEVTYPE_NATIVE_RAW) {
 				fib->flags |= FIB_CONTEXT_FLAG_EH_RESET;
-				cmd->SCp.phase = AAC_OWNER_ERROR_HANDLER;
+				aac_priv(cmd)->owner = AAC_OWNER_ERROR_HANDLER;
 			}
 		}
 	}
@@ -1507,6 +1507,7 @@ static struct scsi_host_template aac_driver_template = {
 #endif
 	.emulated			= 1,
 	.no_write_same			= 1,
+	.cmd_size			= sizeof(struct aac_cmd_priv),
 };
 
 static void __aac_shutdown(struct aac_dev * aac)
