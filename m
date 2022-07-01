Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7D6563BA9
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Jul 2022 23:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbiGAVPX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 1 Jul 2022 17:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiGAVPP (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 1 Jul 2022 17:15:15 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0F63F325
        for <linux-scsi@vger.kernel.org>; Fri,  1 Jul 2022 14:15:13 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id b125so2697979qkg.11
        for <linux-scsi@vger.kernel.org>; Fri, 01 Jul 2022 14:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CXe+kAvhqcJNryfETgqBvKY9WtxF+2cqHKXIOsEXtA0=;
        b=asHpVEGkiVJ3aDUYCkOwFb+Hh5qWPpO5R2nTyLwQgVmDQHspQ/6/OvVVwz1bEaCL7c
         1mp/bYgLoimPQxGnBoD8fHrado9Vamyj/SwBs3pdzt2xgeTTDzthzixJgtAZL5nOrTlU
         4lDUTxUyElMXhtk7k+63+FyxocWYTMSLLIfQtkxYG2L6QKJLWet0Ydzx92c0CkrpV0vs
         jqa/HfOtDzrDsD5UoPp1VcKFZXJn9GPp4LXdfEd5jfB0EpWyeb9A2VQASiEGZYX0Tzkt
         BYKD+sX+sufHQK+L0Lqmreplw/9Zuax7m2KVIc6eUv0wWMTFlkI+RLLVhgJr7puxNjJa
         Hk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CXe+kAvhqcJNryfETgqBvKY9WtxF+2cqHKXIOsEXtA0=;
        b=cEPlCjWXbAn3VzXqJR1pVZLLr9fQNqrhiP58dNpvuud7iPdWORqFddRqV37/Q6x5Dp
         PtGT/vRVwDOqLIARUKNBs0yTmLQsiK6j5ujWrfq5Jt/KFPc+T5Z/vgoTtgftp4B4xF9o
         satI9XJNAES5TVEAlKANTq/xyEBw6HXpb7S+aoK41k3oMpkJ9kE6tKpf1YDlwaniObaD
         2L3+lQLZZUOXXWD1TIEcYSrSS9voYV9craNZeZLG9dZMgTsBO6vK6yNTw8YmlxumPBf6
         ZZ/PCvFkKfakwvRw0LTq9lh9bZY1XvobKPx0dPPW6yYcnIaH8dEPdkX3D6YUdgp++pPJ
         wH0g==
X-Gm-Message-State: AJIora+/Xzm0GxLgJqLb/Bfj5sfTZ0t2XnreyVhd6MNzU179kSnc9QUu
        JisHoipCNEfz8EITqR7mKgwu+u97+B0=
X-Google-Smtp-Source: AGRyM1vJ+t1NyPaxcMXaFNzkqZt2SFfK0RW4XqMPQdB7nfQkbm8X61x2blMaKCsAPYvgvEfmnjwLbw==
X-Received: by 2002:a05:620a:4055:b0:6b0:151f:7281 with SMTP id i21-20020a05620a405500b006b0151f7281mr11977187qko.601.1656710112870;
        Fri, 01 Jul 2022 14:15:12 -0700 (PDT)
Received: from mail-lvn-it-01.broadcom.com ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g6-20020ac842c6000000b00317ccc66971sm14584509qtm.52.2022.07.01.14.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 14:15:12 -0700 (PDT)
From:   James Smart <jsmart2021@gmail.com>
To:     linux-scsi@vger.kernel.org
Cc:     James Smart <jsmart2021@gmail.com>,
        Justin Tee <justin.tee@broadcom.com>
Subject: [PATCH 10/12] lpfc: Remove Menlo/Hornet related code
Date:   Fri,  1 Jul 2022 14:14:23 -0700
Message-Id: <20220701211425.2708-11-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220701211425.2708-1-jsmart2021@gmail.com>
References: <20220701211425.2708-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The Menlo/Hornet adapter was never released to the field. As such,
driver code specific to the adapter is unnecessary and should be
removed.

Co-developed-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc.h         |   7 -
 drivers/scsi/lpfc/lpfc_attr.c    |  27 +--
 drivers/scsi/lpfc/lpfc_bsg.c     | 324 -------------------------------
 drivers/scsi/lpfc/lpfc_bsg.h     |  12 --
 drivers/scsi/lpfc/lpfc_els.c     |   9 -
 drivers/scsi/lpfc/lpfc_hbadisc.c |  57 +-----
 drivers/scsi/lpfc/lpfc_hw.h      |  10 -
 drivers/scsi/lpfc/lpfc_ids.h     |   2 -
 drivers/scsi/lpfc/lpfc_init.c    |  13 --
 drivers/scsi/lpfc/lpfc_sli.c     |  10 -
 drivers/scsi/lpfc/lpfc_sli.h     |   1 -
 11 files changed, 7 insertions(+), 465 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index cf4ccc54a7f2..e6a083d098a1 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -48,9 +48,6 @@ struct lpfc_sli2_slim;
 					   the NameServer  before giving up. */
 #define LPFC_CMD_PER_LUN	3	/* max outstanding cmds per lun */
 #define LPFC_DEFAULT_SG_SEG_CNT 64	/* sg element count per scsi cmnd */
-#define LPFC_DEFAULT_MENLO_SG_SEG_CNT 128	/* sg element count per scsi
-		cmnd for menlo needs nearly twice as for firmware
-		downloads using bsg */
 
 #define LPFC_DEFAULT_XPSGL_SIZE	256
 #define LPFC_MAX_SG_TABLESIZE	0xffff
@@ -1439,8 +1436,6 @@ struct lpfc_hba {
 	 */
 #define QUE_BUFTAG_BIT  (1<<31)
 	uint32_t buffer_tag_count;
-	int wait_4_mlo_maint_flg;
-	wait_queue_head_t wait_4_mlo_m_q;
 	/* data structure used for latency data collection */
 #define LPFC_NO_BUCKET	   0
 #define LPFC_LINEAR_BUCKET 1
@@ -1475,8 +1470,6 @@ struct lpfc_hba {
 	/* RAS Support */
 	struct lpfc_ras_fwlog ras_fwlog;
 
-	uint8_t menlo_flag;	/* menlo generic flags */
-#define HBA_MENLO_SUPPORT	0x1 /* HBA supports menlo commands */
 	uint32_t iocb_cnt;
 	uint32_t iocb_max;
 	atomic_t sdev_cnt;
diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index 3caaa7c4af48..09cf2cd0ae60 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -921,25 +921,6 @@ lpfc_programtype_show(struct device *dev, struct device_attribute *attr,
 	return scnprintf(buf, PAGE_SIZE, "%s\n", phba->ProgramType);
 }
 
-/**
- * lpfc_mlomgmt_show - Return the Menlo Maintenance sli flag
- * @dev: class converted to a Scsi_host structure.
- * @attr: device attribute, not used.
- * @buf: on return contains the Menlo Maintenance sli flag.
- *
- * Returns: size of formatted string.
- **/
-static ssize_t
-lpfc_mlomgmt_show(struct device *dev, struct device_attribute *attr, char *buf)
-{
-	struct Scsi_Host  *shost = class_to_shost(dev);
-	struct lpfc_vport *vport = (struct lpfc_vport *)shost->hostdata;
-	struct lpfc_hba   *phba = vport->phba;
-
-	return scnprintf(buf, PAGE_SIZE, "%d\n",
-		(phba->sli.sli_flag & LPFC_MENLO_MAINT));
-}
-
 /**
  * lpfc_vportnum_show - Return the port number in ascii of the hba
  * @dev: class converted to a Scsi_host structure.
@@ -1109,10 +1090,7 @@ lpfc_link_state_show(struct device *dev, struct device_attribute *attr,
 					"Unknown\n");
 			break;
 		}
-		if (phba->sli.sli_flag & LPFC_MENLO_MAINT)
-			len += scnprintf(buf + len, PAGE_SIZE-len,
-					"   Menlo Maint Mode\n");
-		else if (phba->fc_topology == LPFC_TOPOLOGY_LOOP) {
+		if (phba->fc_topology == LPFC_TOPOLOGY_LOOP) {
 			if (vport->fc_flag & FC_PUBLIC_LOOP)
 				len += scnprintf(buf + len, PAGE_SIZE-len,
 						"   Public Loop\n");
@@ -2827,7 +2805,6 @@ static DEVICE_ATTR(option_rom_version, S_IRUGO,
 		   lpfc_option_rom_version_show, NULL);
 static DEVICE_ATTR(num_discovered_ports, S_IRUGO,
 		   lpfc_num_discovered_ports_show, NULL);
-static DEVICE_ATTR(menlo_mgmt_mode, S_IRUGO, lpfc_mlomgmt_show, NULL);
 static DEVICE_ATTR(nport_evt_cnt, S_IRUGO, lpfc_nport_evt_cnt_show, NULL);
 static DEVICE_ATTR_RO(lpfc_drvr_version);
 static DEVICE_ATTR_RO(lpfc_enable_fip);
@@ -6220,7 +6197,6 @@ static struct attribute *lpfc_hba_attrs[] = {
 	&dev_attr_option_rom_version.attr,
 	&dev_attr_link_state.attr,
 	&dev_attr_num_discovered_ports.attr,
-	&dev_attr_menlo_mgmt_mode.attr,
 	&dev_attr_lpfc_drvr_version.attr,
 	&dev_attr_lpfc_enable_fip.attr,
 	&dev_attr_lpfc_temp_sensor.attr,
@@ -7396,7 +7372,6 @@ lpfc_get_hba_function_mode(struct lpfc_hba *phba)
 	case PCI_DEVICE_ID_LANCER_FCOE:
 	case PCI_DEVICE_ID_LANCER_FCOE_VF:
 	case PCI_DEVICE_ID_ZEPHYR_DCSP:
-	case PCI_DEVICE_ID_HORNET:
 	case PCI_DEVICE_ID_TIGERSHARK:
 	case PCI_DEVICE_ID_TOMCAT:
 		phba->hba_flag |= HBA_FCOE_MODE;
diff --git a/drivers/scsi/lpfc/lpfc_bsg.c b/drivers/scsi/lpfc/lpfc_bsg.c
index 676e7d54b97a..9be3bb01a8ec 100644
--- a/drivers/scsi/lpfc/lpfc_bsg.c
+++ b/drivers/scsi/lpfc/lpfc_bsg.c
@@ -88,17 +88,9 @@ struct lpfc_bsg_mbox {
 	uint32_t outExtWLen; /* from app */
 };
 
-#define MENLO_DID 0x0000FC0E
-
-struct lpfc_bsg_menlo {
-	struct lpfc_iocbq *cmdiocbq;
-	struct lpfc_dmabuf *rmp;
-};
-
 #define TYPE_EVT 	1
 #define TYPE_IOCB	2
 #define TYPE_MBOX	3
-#define TYPE_MENLO	4
 struct bsg_job_data {
 	uint32_t type;
 	struct bsg_job *set_job; /* job waiting for this iocb to finish */
@@ -106,7 +98,6 @@ struct bsg_job_data {
 		struct lpfc_bsg_event *evt;
 		struct lpfc_bsg_iocb iocb;
 		struct lpfc_bsg_mbox mbox;
-		struct lpfc_bsg_menlo menlo;
 	} context_un;
 };
 
@@ -3502,15 +3493,6 @@ static int lpfc_bsg_check_cmd_access(struct lpfc_hba *phba,
 			"1226 mbox: set_variable 0x%x, 0x%x\n",
 			mb->un.varWords[0],
 			mb->un.varWords[1]);
-		if ((mb->un.varWords[0] == SETVAR_MLOMNT)
-			&& (mb->un.varWords[1] == 1)) {
-			phba->wait_4_mlo_maint_flg = 1;
-		} else if (mb->un.varWords[0] == SETVAR_MLORST) {
-			spin_lock_irq(&phba->hbalock);
-			phba->link_flag &= ~LS_LOOPBACK_MODE;
-			spin_unlock_irq(&phba->hbalock);
-			phba->fc_topology = LPFC_TOPOLOGY_PT_PT;
-		}
 		break;
 	case MBX_READ_SPARM64:
 	case MBX_REG_LOGIN:
@@ -4992,283 +4974,6 @@ lpfc_bsg_mbox_cmd(struct bsg_job *job)
 	return rc;
 }
 
-/**
- * lpfc_bsg_menlo_cmd_cmp - lpfc_menlo_cmd completion handler
- * @phba: Pointer to HBA context object.
- * @cmdiocbq: Pointer to command iocb.
- * @rspiocbq: Pointer to response iocb.
- *
- * This function is the completion handler for iocbs issued using
- * lpfc_menlo_cmd function. This function is called by the
- * ring event handler function without any lock held. This function
- * can be called from both worker thread context and interrupt
- * context. This function also can be called from another thread which
- * cleans up the SLI layer objects.
- * This function copies the contents of the response iocb to the
- * response iocb memory object provided by the caller of
- * lpfc_sli_issue_iocb_wait and then wakes up the thread which
- * sleeps for the iocb completion.
- **/
-static void
-lpfc_bsg_menlo_cmd_cmp(struct lpfc_hba *phba,
-			struct lpfc_iocbq *cmdiocbq,
-			struct lpfc_iocbq *rspiocbq)
-{
-	struct bsg_job_data *dd_data;
-	struct bsg_job *job;
-	struct fc_bsg_reply *bsg_reply;
-	IOCB_t *rsp;
-	struct lpfc_dmabuf *bmp, *cmp, *rmp;
-	struct lpfc_bsg_menlo *menlo;
-	unsigned long flags;
-	struct menlo_response *menlo_resp;
-	unsigned int rsp_size;
-	int rc = 0;
-
-	dd_data = cmdiocbq->context_un.dd_data;
-	cmp = cmdiocbq->cmd_dmabuf;
-	bmp = cmdiocbq->bpl_dmabuf;
-	menlo = &dd_data->context_un.menlo;
-	rmp = menlo->rmp;
-	rsp = &rspiocbq->iocb;
-
-	/* Determine if job has been aborted */
-	spin_lock_irqsave(&phba->ct_ev_lock, flags);
-	job = dd_data->set_job;
-	if (job) {
-		bsg_reply = job->reply;
-		/* Prevent timeout handling from trying to abort job  */
-		job->dd_data = NULL;
-	}
-	spin_unlock_irqrestore(&phba->ct_ev_lock, flags);
-
-	/* Copy the job data or set the failing status for the job */
-
-	if (job) {
-		/* always return the xri, this would be used in the case
-		 * of a menlo download to allow the data to be sent as a
-		 * continuation of the exchange.
-		 */
-
-		menlo_resp = (struct menlo_response *)
-			bsg_reply->reply_data.vendor_reply.vendor_rsp;
-		menlo_resp->xri = rsp->ulpContext;
-		if (rsp->ulpStatus) {
-			if (rsp->ulpStatus == IOSTAT_LOCAL_REJECT) {
-				switch (rsp->un.ulpWord[4] & IOERR_PARAM_MASK) {
-				case IOERR_SEQUENCE_TIMEOUT:
-					rc = -ETIMEDOUT;
-					break;
-				case IOERR_INVALID_RPI:
-					rc = -EFAULT;
-					break;
-				default:
-					rc = -EACCES;
-					break;
-				}
-			} else {
-				rc = -EACCES;
-			}
-		} else {
-			rsp_size = rsp->un.genreq64.bdl.bdeSize;
-			bsg_reply->reply_payload_rcv_len =
-				lpfc_bsg_copy_data(rmp, &job->reply_payload,
-						   rsp_size, 0);
-		}
-
-	}
-
-	lpfc_sli_release_iocbq(phba, cmdiocbq);
-	lpfc_free_bsg_buffers(phba, cmp);
-	lpfc_free_bsg_buffers(phba, rmp);
-	lpfc_mbuf_free(phba, bmp->virt, bmp->phys);
-	kfree(bmp);
-	kfree(dd_data);
-
-	/* Complete the job if active */
-
-	if (job) {
-		bsg_reply->result = rc;
-		bsg_job_done(job, bsg_reply->result,
-			       bsg_reply->reply_payload_rcv_len);
-	}
-
-	return;
-}
-
-/**
- * lpfc_menlo_cmd - send an ioctl for menlo hardware
- * @job: fc_bsg_job to handle
- *
- * This function issues a gen request 64 CR ioctl for all menlo cmd requests,
- * all the command completions will return the xri for the command.
- * For menlo data requests a gen request 64 CX is used to continue the exchange
- * supplied in the menlo request header xri field.
- **/
-static int
-lpfc_menlo_cmd(struct bsg_job *job)
-{
-	struct lpfc_vport *vport = shost_priv(fc_bsg_to_shost(job));
-	struct fc_bsg_request *bsg_request = job->request;
-	struct fc_bsg_reply *bsg_reply = job->reply;
-	struct lpfc_hba *phba = vport->phba;
-	struct lpfc_iocbq *cmdiocbq;
-	IOCB_t *cmd;
-	int rc = 0;
-	struct menlo_command *menlo_cmd;
-	struct lpfc_dmabuf *bmp = NULL, *cmp = NULL, *rmp = NULL;
-	int request_nseg;
-	int reply_nseg;
-	struct bsg_job_data *dd_data;
-	struct ulp_bde64 *bpl = NULL;
-
-	/* in case no data is returned return just the return code */
-	bsg_reply->reply_payload_rcv_len = 0;
-
-	if (job->request_len <
-	    sizeof(struct fc_bsg_request) +
-		sizeof(struct menlo_command)) {
-		lpfc_printf_log(phba, KERN_WARNING, LOG_LIBDFC,
-				"2784 Received MENLO_CMD request below "
-				"minimum size\n");
-		rc = -ERANGE;
-		goto no_dd_data;
-	}
-
-	if (job->reply_len < sizeof(*bsg_reply) +
-				sizeof(struct menlo_response)) {
-		lpfc_printf_log(phba, KERN_WARNING, LOG_LIBDFC,
-				"2785 Received MENLO_CMD reply below "
-				"minimum size\n");
-		rc = -ERANGE;
-		goto no_dd_data;
-	}
-
-	if (!(phba->menlo_flag & HBA_MENLO_SUPPORT)) {
-		lpfc_printf_log(phba, KERN_WARNING, LOG_LIBDFC,
-				"2786 Adapter does not support menlo "
-				"commands\n");
-		rc = -EPERM;
-		goto no_dd_data;
-	}
-
-	menlo_cmd = (struct menlo_command *)
-		bsg_request->rqst_data.h_vendor.vendor_cmd;
-
-	/* allocate our bsg tracking structure */
-	dd_data = kmalloc(sizeof(struct bsg_job_data), GFP_KERNEL);
-	if (!dd_data) {
-		lpfc_printf_log(phba, KERN_WARNING, LOG_LIBDFC,
-				"2787 Failed allocation of dd_data\n");
-		rc = -ENOMEM;
-		goto no_dd_data;
-	}
-
-	bmp = kmalloc(sizeof(struct lpfc_dmabuf), GFP_KERNEL);
-	if (!bmp) {
-		rc = -ENOMEM;
-		goto free_dd;
-	}
-
-	bmp->virt = lpfc_mbuf_alloc(phba, 0, &bmp->phys);
-	if (!bmp->virt) {
-		rc = -ENOMEM;
-		goto free_bmp;
-	}
-
-	INIT_LIST_HEAD(&bmp->list);
-
-	bpl = (struct ulp_bde64 *)bmp->virt;
-	request_nseg = LPFC_BPL_SIZE/sizeof(struct ulp_bde64);
-	cmp = lpfc_alloc_bsg_buffers(phba, job->request_payload.payload_len,
-				     1, bpl, &request_nseg);
-	if (!cmp) {
-		rc = -ENOMEM;
-		goto free_bmp;
-	}
-	lpfc_bsg_copy_data(cmp, &job->request_payload,
-			   job->request_payload.payload_len, 1);
-
-	bpl += request_nseg;
-	reply_nseg = LPFC_BPL_SIZE/sizeof(struct ulp_bde64) - request_nseg;
-	rmp = lpfc_alloc_bsg_buffers(phba, job->reply_payload.payload_len, 0,
-				     bpl, &reply_nseg);
-	if (!rmp) {
-		rc = -ENOMEM;
-		goto free_cmp;
-	}
-
-	cmdiocbq = lpfc_sli_get_iocbq(phba);
-	if (!cmdiocbq) {
-		rc = -ENOMEM;
-		goto free_rmp;
-	}
-
-	cmd = &cmdiocbq->iocb;
-	cmd->un.genreq64.bdl.ulpIoTag32 = 0;
-	cmd->un.genreq64.bdl.addrHigh = putPaddrHigh(bmp->phys);
-	cmd->un.genreq64.bdl.addrLow = putPaddrLow(bmp->phys);
-	cmd->un.genreq64.bdl.bdeFlags = BUFF_TYPE_BLP_64;
-	cmd->un.genreq64.bdl.bdeSize =
-	    (request_nseg + reply_nseg) * sizeof(struct ulp_bde64);
-	cmd->un.genreq64.w5.hcsw.Fctl = (SI | LA);
-	cmd->un.genreq64.w5.hcsw.Dfctl = 0;
-	cmd->un.genreq64.w5.hcsw.Rctl = FC_RCTL_DD_UNSOL_CMD;
-	cmd->un.genreq64.w5.hcsw.Type = MENLO_TRANSPORT_TYPE; /* 0xfe */
-	cmd->ulpBdeCount = 1;
-	cmd->ulpClass = CLASS3;
-	cmd->ulpOwner = OWN_CHIP;
-	cmd->ulpLe = 1; /* Limited Edition */
-	cmdiocbq->cmd_flag |= LPFC_IO_LIBDFC;
-	cmdiocbq->vport = phba->pport;
-	/* We want the firmware to timeout before we do */
-	cmd->ulpTimeout = MENLO_TIMEOUT - 5;
-	cmdiocbq->cmd_cmpl = lpfc_bsg_menlo_cmd_cmp;
-	cmdiocbq->context_un.dd_data = dd_data;
-	cmdiocbq->cmd_dmabuf = cmp;
-	cmdiocbq->bpl_dmabuf = bmp;
-	if (menlo_cmd->cmd == LPFC_BSG_VENDOR_MENLO_CMD) {
-		cmd->ulpCommand = CMD_GEN_REQUEST64_CR;
-		cmd->ulpPU = MENLO_PU; /* 3 */
-		cmd->un.ulpWord[4] = MENLO_DID; /* 0x0000FC0E */
-		cmd->ulpContext = MENLO_CONTEXT; /* 0 */
-	} else {
-		cmd->ulpCommand = CMD_GEN_REQUEST64_CX;
-		cmd->ulpPU = 1;
-		cmd->un.ulpWord[4] = 0;
-		cmd->ulpContext = menlo_cmd->xri;
-	}
-
-	dd_data->type = TYPE_MENLO;
-	dd_data->set_job = job;
-	dd_data->context_un.menlo.cmdiocbq = cmdiocbq;
-	dd_data->context_un.menlo.rmp = rmp;
-	job->dd_data = dd_data;
-
-	rc = lpfc_sli_issue_iocb(phba, LPFC_ELS_RING, cmdiocbq,
-		MENLO_TIMEOUT - 5);
-	if (rc == IOCB_SUCCESS)
-		return 0; /* done for now */
-
-	lpfc_sli_release_iocbq(phba, cmdiocbq);
-
-free_rmp:
-	lpfc_free_bsg_buffers(phba, rmp);
-free_cmp:
-	lpfc_free_bsg_buffers(phba, cmp);
-free_bmp:
-	if (bmp->virt)
-		lpfc_mbuf_free(phba, bmp->virt, bmp->phys);
-	kfree(bmp);
-free_dd:
-	kfree(dd_data);
-no_dd_data:
-	/* make error code available to userspace */
-	bsg_reply->result = rc;
-	job->dd_data = NULL;
-	return rc;
-}
-
 static int
 lpfc_forced_link_speed(struct bsg_job *job)
 {
@@ -5823,10 +5528,6 @@ lpfc_bsg_hst_vendor(struct bsg_job *job)
 	case LPFC_BSG_VENDOR_MBOX:
 		rc = lpfc_bsg_mbox_cmd(job);
 		break;
-	case LPFC_BSG_VENDOR_MENLO_CMD:
-	case LPFC_BSG_VENDOR_MENLO_DATA:
-		rc = lpfc_menlo_cmd(job);
-		break;
 	case LPFC_BSG_VENDOR_FORCED_LINK_SPEED:
 		rc = lpfc_forced_link_speed(job);
 		break;
@@ -5979,31 +5680,6 @@ lpfc_bsg_timeout(struct bsg_job *job)
 			phba->mbox_ext_buf_ctx.state = LPFC_BSG_MBOX_ABTS;
 		spin_unlock_irqrestore(&phba->ct_ev_lock, flags);
 		break;
-	case TYPE_MENLO:
-		/* Check to see if IOCB was issued to the port or not. If not,
-		 * remove it from the txq queue and call cancel iocbs.
-		 * Otherwise, call abort iotag.
-		 */
-		cmdiocb = dd_data->context_un.menlo.cmdiocbq;
-		spin_unlock_irqrestore(&phba->ct_ev_lock, flags);
-
-		spin_lock_irqsave(&phba->hbalock, flags);
-		list_for_each_entry_safe(check_iocb, next_iocb, &pring->txq,
-					 list) {
-			if (check_iocb == cmdiocb) {
-				list_move_tail(&check_iocb->list, &completions);
-				break;
-			}
-		}
-		if (list_empty(&completions))
-			lpfc_sli_issue_abort_iotag(phba, pring, cmdiocb, NULL);
-		spin_unlock_irqrestore(&phba->hbalock, flags);
-		if (!list_empty(&completions)) {
-			lpfc_sli_cancel_iocbs(phba, &completions,
-					      IOSTAT_LOCAL_REJECT,
-					      IOERR_SLI_ABORTED);
-		}
-		break;
 	default:
 		spin_unlock_irqrestore(&phba->ct_ev_lock, flags);
 		break;
diff --git a/drivers/scsi/lpfc/lpfc_bsg.h b/drivers/scsi/lpfc/lpfc_bsg.h
index 749d6c43cfce..8b1b2b1bc448 100644
--- a/drivers/scsi/lpfc/lpfc_bsg.h
+++ b/drivers/scsi/lpfc/lpfc_bsg.h
@@ -33,8 +33,6 @@
 #define LPFC_BSG_VENDOR_DIAG_RUN_LOOPBACK	5
 #define LPFC_BSG_VENDOR_GET_MGMT_REV		6
 #define LPFC_BSG_VENDOR_MBOX			7
-#define LPFC_BSG_VENDOR_MENLO_CMD		8
-#define LPFC_BSG_VENDOR_MENLO_DATA		9
 #define LPFC_BSG_VENDOR_DIAG_MODE_END		10
 #define LPFC_BSG_VENDOR_LINK_DIAG_TEST		11
 #define LPFC_BSG_VENDOR_FORCED_LINK_SPEED	14
@@ -131,16 +129,6 @@ struct dfc_mbox_req {
 	uint32_t extSeqNum;
 };
 
-/* Used for menlo command or menlo data. The xri is only used for menlo data */
-struct menlo_command {
-	uint32_t cmd;
-	uint32_t xri;
-};
-
-struct menlo_response {
-	uint32_t xri; /* return the xri of the iocb exchange */
-};
-
 /*
  * macros and data structures for handling sli-config mailbox command
  * pass-through support, this header file is shared between user and
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 9371829e11b2..9e69de9eb992 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -4570,15 +4570,6 @@ lpfc_els_retry(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
 	case IOSTAT_LOCAL_REJECT:
 		switch ((ulp_word4 & IOERR_PARAM_MASK)) {
 		case IOERR_LOOP_OPEN_FAILURE:
-			if (cmd == ELS_CMD_FLOGI) {
-				if (PCI_DEVICE_ID_HORNET ==
-					phba->pcidev->device) {
-					phba->fc_topology = LPFC_TOPOLOGY_LOOP;
-					phba->pport->fc_myDID = 0;
-					phba->alpa_map[0] = 0;
-					phba->alpa_map[1] = 0;
-				}
-			}
 			if (cmd == ELS_CMD_PLOGI && cmdiocb->retry == 0)
 				delay = 1000;
 			retry = 1;
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 5cd838eac455..2645def612e6 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -3762,18 +3762,8 @@ lpfc_mbx_cmpl_read_topology(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 	}
 
 	phba->fc_eventTag = la->eventTag;
-	if (phba->sli_rev < LPFC_SLI_REV4) {
-		spin_lock_irqsave(&phba->hbalock, iflags);
-		if (bf_get(lpfc_mbx_read_top_mm, la))
-			phba->sli.sli_flag |= LPFC_MENLO_MAINT;
-		else
-			phba->sli.sli_flag &= ~LPFC_MENLO_MAINT;
-		spin_unlock_irqrestore(&phba->hbalock, iflags);
-	}
-
 	phba->link_events++;
-	if ((attn_type == LPFC_ATT_LINK_UP) &&
-	    !(phba->sli.sli_flag & LPFC_MENLO_MAINT)) {
+	if (attn_type == LPFC_ATT_LINK_UP) {
 		phba->fc_stat.LinkUp++;
 		if (phba->link_flag & LS_LOOPBACK_MODE) {
 			lpfc_printf_log(phba, KERN_ERR, LOG_LINK_EVENT,
@@ -3787,15 +3777,13 @@ lpfc_mbx_cmpl_read_topology(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 		} else {
 			lpfc_printf_log(phba, KERN_ERR, LOG_LINK_EVENT,
 					"1303 Link Up Event x%x received "
-					"Data: x%x x%x x%x x%x x%x x%x %d\n",
+					"Data: x%x x%x x%x x%x x%x\n",
 					la->eventTag, phba->fc_eventTag,
 					bf_get(lpfc_mbx_read_top_alpa_granted,
 					       la),
 					bf_get(lpfc_mbx_read_top_link_spd, la),
 					phba->alpa_map[0],
-					bf_get(lpfc_mbx_read_top_mm, la),
-					bf_get(lpfc_mbx_read_top_fa, la),
-					phba->wait_4_mlo_maint_flg);
+					bf_get(lpfc_mbx_read_top_fa, la));
 		}
 		lpfc_mbx_process_link_up(phba, la);
 
@@ -3815,58 +3803,25 @@ lpfc_mbx_cmpl_read_topology(struct lpfc_hba *phba, LPFC_MBOXQ_t *pmb)
 		else if (attn_type == LPFC_ATT_UNEXP_WWPN)
 			lpfc_printf_log(phba, KERN_ERR, LOG_LINK_EVENT,
 				"1313 Link Down Unexpected FA WWPN Event x%x "
-				"received Data: x%x x%x x%x x%x x%x\n",
+				"received Data: x%x x%x x%x x%x\n",
 				la->eventTag, phba->fc_eventTag,
 				phba->pport->port_state, vport->fc_flag,
-				bf_get(lpfc_mbx_read_top_mm, la),
 				bf_get(lpfc_mbx_read_top_fa, la));
 		else
 			lpfc_printf_log(phba, KERN_ERR, LOG_LINK_EVENT,
 				"1305 Link Down Event x%x received "
-				"Data: x%x x%x x%x x%x x%x\n",
+				"Data: x%x x%x x%x x%x\n",
 				la->eventTag, phba->fc_eventTag,
 				phba->pport->port_state, vport->fc_flag,
-				bf_get(lpfc_mbx_read_top_mm, la),
 				bf_get(lpfc_mbx_read_top_fa, la));
 		lpfc_mbx_issue_link_down(phba);
 	}
-	if (phba->sli.sli_flag & LPFC_MENLO_MAINT &&
-	    attn_type == LPFC_ATT_LINK_UP) {
-		if (phba->link_state != LPFC_LINK_DOWN) {
-			phba->fc_stat.LinkDown++;
-			lpfc_printf_log(phba, KERN_ERR, LOG_LINK_EVENT,
-				"1312 Link Down Event x%x received "
-				"Data: x%x x%x x%x\n",
-				la->eventTag, phba->fc_eventTag,
-				phba->pport->port_state, vport->fc_flag);
-			lpfc_mbx_issue_link_down(phba);
-		} else
-			lpfc_enable_la(phba);
-
-		lpfc_printf_log(phba, KERN_ERR, LOG_LINK_EVENT,
-				"1310 Menlo Maint Mode Link up Event x%x rcvd "
-				"Data: x%x x%x x%x\n",
-				la->eventTag, phba->fc_eventTag,
-				phba->pport->port_state, vport->fc_flag);
-		/*
-		 * The cmnd that triggered this will be waiting for this
-		 * signal.
-		 */
-		/* WAKEUP for MENLO_SET_MODE or MENLO_RESET command. */
-		if (phba->wait_4_mlo_maint_flg) {
-			phba->wait_4_mlo_maint_flg = 0;
-			wake_up_interruptible(&phba->wait_4_mlo_m_q);
-		}
-	}
 
 	if ((phba->sli_rev < LPFC_SLI_REV4) &&
-	    bf_get(lpfc_mbx_read_top_fa, la)) {
-		if (phba->sli.sli_flag & LPFC_MENLO_MAINT)
-			lpfc_issue_clear_la(phba, vport);
+	    bf_get(lpfc_mbx_read_top_fa, la))
 		lpfc_printf_log(phba, KERN_INFO, LOG_LINK_EVENT,
 				"1311 fa %d\n",
 				bf_get(lpfc_mbx_read_top_fa, la));
-	}
 
 lpfc_mbx_cmpl_read_topology_free_mbuf:
 	lpfc_mbox_rsrc_cleanup(phba, pmb, MBOX_THD_UNLOCKED);
diff --git a/drivers/scsi/lpfc/lpfc_hw.h b/drivers/scsi/lpfc/lpfc_hw.h
index 7b8cf678abb5..071983e2cdfe 100644
--- a/drivers/scsi/lpfc/lpfc_hw.h
+++ b/drivers/scsi/lpfc/lpfc_hw.h
@@ -1728,7 +1728,6 @@ struct lpfc_fdmi_reg_portattr {
 #define PCI_DEVICE_ID_HELIOS_SCSP   0xfd11
 #define PCI_DEVICE_ID_HELIOS_DCSP   0xfd12
 #define PCI_DEVICE_ID_ZEPHYR        0xfe00
-#define PCI_DEVICE_ID_HORNET        0xfe05
 #define PCI_DEVICE_ID_ZEPHYR_SCSP   0xfe11
 #define PCI_DEVICE_ID_ZEPHYR_DCSP   0xfe12
 #define PCI_VENDOR_ID_SERVERENGINE  0x19a2
@@ -1773,7 +1772,6 @@ struct lpfc_fdmi_reg_portattr {
 #define ZEPHYR_JEDEC_ID             0x0577
 #define VIPER_JEDEC_ID              0x4838
 #define SATURN_JEDEC_ID             0x1004
-#define HORNET_JDEC_ID              0x2057706D
 
 #define JEDEC_ID_MASK               0x0FFFF000
 #define JEDEC_ID_SHIFT              12
@@ -3074,7 +3072,6 @@ struct lpfc_mbx_read_top {
 #define lpfc_mbx_read_top_topology_WORD		word3
 #define LPFC_TOPOLOGY_PT_PT 0x01	/* Topology is pt-pt / pt-fabric */
 #define LPFC_TOPOLOGY_LOOP  0x02	/* Topology is FC-AL */
-#define LPFC_TOPOLOGY_MM    0x05	/* maint mode zephtr to menlo */
 	/* store the LILP AL_PA position map into */
 	struct ulp_bde64 lilpBde64;
 #define LPFC_ALPA_MAP_SIZE	128
@@ -4423,11 +4420,4 @@ lpfc_error_lost_link(u32 ulp_status, u32 ulp_word4)
 		 ulp_word4 == IOERR_SLI_DOWN));
 }
 
-#define MENLO_TRANSPORT_TYPE 0xfe
-#define MENLO_CONTEXT 0
-#define MENLO_PU 3
-#define MENLO_TIMEOUT 30
-#define SETVAR_MLOMNT 0x103107
-#define SETVAR_MLORST 0x103007
-
 #define BPL_ALIGN_SZ 8 /* 8 byte alignment for bpl and mbufs */
diff --git a/drivers/scsi/lpfc/lpfc_ids.h b/drivers/scsi/lpfc/lpfc_ids.h
index a1b9be245560..a9bb161395f8 100644
--- a/drivers/scsi/lpfc/lpfc_ids.h
+++ b/drivers/scsi/lpfc/lpfc_ids.h
@@ -60,8 +60,6 @@ const struct pci_device_id lpfc_id_table[] = {
 		PCI_ANY_ID, PCI_ANY_ID, },
 	{PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_ZEPHYR,
 		PCI_ANY_ID, PCI_ANY_ID, },
-	{PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_HORNET,
-		PCI_ANY_ID, PCI_ANY_ID, },
 	{PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_ZEPHYR_SCSP,
 		PCI_ANY_ID, PCI_ANY_ID, },
 	{PCI_VENDOR_ID_EMULEX, PCI_DEVICE_ID_ZEPHYR_DCSP,
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 7424b194d20e..4a0eadd1c22c 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -2685,11 +2685,6 @@ lpfc_get_hba_model_desc(struct lpfc_hba *phba, uint8_t *mdp, uint8_t *descp)
 	case PCI_DEVICE_ID_SAT_S:
 		m = (typeof(m)){"LPe12000-S", "PCIe", "Fibre Channel Adapter"};
 		break;
-	case PCI_DEVICE_ID_HORNET:
-		m = (typeof(m)){"LP21000", "PCIe",
-				"Obsolete, Unsupported FCoE Adapter"};
-		GE = 1;
-		break;
 	case PCI_DEVICE_ID_PROTEUS_VF:
 		m = (typeof(m)){"LPev12000", "PCIe IOV",
 				"Obsolete, Unsupported Fibre Channel Adapter"};
@@ -7695,7 +7690,6 @@ lpfc_setup_driver_resource_phase1(struct lpfc_hba *phba)
 	INIT_LIST_HEAD(&phba->port_list);
 
 	INIT_LIST_HEAD(&phba->work_list);
-	init_waitqueue_head(&phba->wait_4_mlo_m_q);
 
 	/* Initialize the wait queue head for the kernel thread */
 	init_waitqueue_head(&phba->work_waitq);
@@ -7779,13 +7773,6 @@ lpfc_sli_driver_resource_setup(struct lpfc_hba *phba)
 	if (rc)
 		return -ENODEV;
 
-	if (phba->pcidev->device == PCI_DEVICE_ID_HORNET) {
-		phba->menlo_flag |= HBA_MENLO_SUPPORT;
-		/* check for menlo minimum sg count */
-		if (phba->cfg_sg_seg_cnt < LPFC_DEFAULT_MENLO_SG_SEG_CNT)
-			phba->cfg_sg_seg_cnt = LPFC_DEFAULT_MENLO_SG_SEG_CNT;
-	}
-
 	if (!phba->sli.sli3_ring)
 		phba->sli.sli3_ring = kcalloc(LPFC_SLI3_MAX_RING,
 					      sizeof(struct lpfc_sli_ring),
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 3aa9e5c85aa5..608016725db9 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -10223,16 +10223,6 @@ __lpfc_sli_issue_iocb_s3(struct lpfc_hba *phba, uint32_t ring_number,
 		 * can be issued if the link is not up.
 		 */
 		switch (piocb->iocb.ulpCommand) {
-		case CMD_GEN_REQUEST64_CR:
-		case CMD_GEN_REQUEST64_CX:
-			if (!(phba->sli.sli_flag & LPFC_MENLO_MAINT) ||
-				(piocb->iocb.un.genreq64.w5.hcsw.Rctl !=
-					FC_RCTL_DD_UNSOL_CMD) ||
-				(piocb->iocb.un.genreq64.w5.hcsw.Type !=
-					MENLO_TRANSPORT_TYPE))
-
-				goto iocb_busy;
-			break;
 		case CMD_QUE_RING_BUF_CN:
 		case CMD_QUE_RING_BUF64_CN:
 			/*
diff --git a/drivers/scsi/lpfc/lpfc_sli.h b/drivers/scsi/lpfc/lpfc_sli.h
index 0af6860b8936..cd33dfec758c 100644
--- a/drivers/scsi/lpfc/lpfc_sli.h
+++ b/drivers/scsi/lpfc/lpfc_sli.h
@@ -355,7 +355,6 @@ struct lpfc_sli {
 #define LPFC_SLI_ACTIVE           0x200	/* SLI in firmware is active */
 #define LPFC_PROCESS_LA           0x400	/* Able to process link attention */
 #define LPFC_BLOCK_MGMT_IO        0x800	/* Don't allow mgmt mbx or iocb cmds */
-#define LPFC_MENLO_MAINT          0x1000 /* need for menl fw download */
 #define LPFC_SLI_ASYNC_MBX_BLK    0x2000 /* Async mailbox is blocked */
 #define LPFC_SLI_SUPPRESS_RSP     0x4000 /* Suppress RSP feature is supported */
 #define LPFC_SLI_USE_EQDR         0x8000 /* EQ Delay Register is supported */
-- 
2.26.2

