Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0A7425DE6
	for <lists+linux-scsi@lfdr.de>; Thu,  7 Oct 2021 22:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242002AbhJGUtW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 7 Oct 2021 16:49:22 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:37802 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbhJGUtV (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 7 Oct 2021 16:49:21 -0400
Received: by mail-pg1-f179.google.com with SMTP id r201so965910pgr.4
        for <linux-scsi@vger.kernel.org>; Thu, 07 Oct 2021 13:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dKpCGq1wQcfqFzphG0preYf5riMrotsWxO0kLpFP/G0=;
        b=OXaDI34dxG0d5QO1mmfqea9Ni+22fI6amUJ6VUFoM9E2dnUqmfONUzEWFPB+pPq/Rs
         VQvsGykiNmkY7DXQN1IYR27IGVqZo/JHCPVIqMdhLgylXhIajX8Ptv+zqSq9Tsg/NMqD
         clXYsrn7CqTSgXpz0SNNSO1ejuDBxbdAadbvX51NsKoY3/Mmarn0UK28t4DPesEBZMKQ
         CkwffbsjT/ZldwvY3xBk6iccTtjpP0NpSX8lSJyuF03sCiCS8FATH91YUHhEEM9GMFdn
         9gUBnGRa4bYtCL+B3/dASuLpkKKc+aP36IT7hWKjrw4mYoy4xJvCIO8JuQSIrDKGk0dx
         aaTg==
X-Gm-Message-State: AOAM530R6mimUBCXOHF4WQII/pimdZS2M7FBPMMd8VbE3HP/sVt0oOC8
        43g/o+OQsLR1gFOOJrJgn7A=
X-Google-Smtp-Source: ABdhPJyuLGAII9kPqDBfnRcMzcx+AESVDkVxkvToUDvJg0dRwVJpuKxFvqNRAJq3+AflU1M57O4csA==
X-Received: by 2002:a05:6a00:1ad4:b0:44c:619e:f386 with SMTP id f20-20020a056a001ad400b0044c619ef386mr6529008pfv.66.1633639646287;
        Thu, 07 Oct 2021 13:47:26 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ae88:8f16:b90b:5f1d])
        by smtp.gmail.com with ESMTPSA id 17sm280831pfh.216.2021.10.07.13.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 13:47:25 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Bean Huo <beanhuo@micron.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Can Guo <cang@codeaurora.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Avri Altman <avri.altman@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Adam Radford <aradford@gmail.com>,
        Khalid Aziz <khalid@gonehiking.org>,
        Matthew Wilcox <willy@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        "Juergen E. Fischer" <fischer@norbit.de>,
        Russell King <linux@armlinux.org.uk>,
        Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        Oliver Neukum <oliver@neukum.org>,
        Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        Satish Kharat <satishkh@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        HighPoint Linux Team <linux@highpoint-tech.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        GOTO Masanori <gotom@debian.or.jp>,
        Geoff Levand <geoff@infradead.org>,
        Vishal Bhakta <vbhakta@vmware.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Kershner <david.kershner@unisys.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        ching Huang <ching2048@areca.com.tw>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Song Chen <chensong_2000@189.cn>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v3 88/88] scsi: Remove the 'done' argument from SCSI queuecommand_lck functions
Date:   Thu,  7 Oct 2021 13:46:14 -0700
Message-Id: <20211007204618.2196847-14-bvanassche@acm.org>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
In-Reply-To: <20211007202923.2174984-1-bvanassche@acm.org>
References: <20211007202923.2174984-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The DEF_SCSI_QCMD() macro passes the addresses of the SCSI host lock and
also that of the scsi_done function to the queuecommand_lck() function
implementations. Remove the 'scsi_done' argument since its address is
now a constant and instead call 'scsi_done' directly from inside the
queuecommand_lck() functions.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/scsi/3w-9xxx.c                          |  3 ++-
 drivers/scsi/3w-sas.c                           |  3 ++-
 drivers/scsi/3w-xxxx.c                          |  3 ++-
 drivers/scsi/53c700.c                           |  3 +--
 drivers/scsi/BusLogic.c                         |  4 ++--
 drivers/scsi/a100u2w.c                          |  2 +-
 drivers/scsi/advansys.c                         |  3 +--
 drivers/scsi/aha152x.c                          |  4 +---
 drivers/scsi/aha1740.c                          |  4 ++--
 drivers/scsi/aic7xxx/aic79xx_osm.c              |  3 +--
 drivers/scsi/aic7xxx/aic7xxx_osm.c              |  3 +--
 drivers/scsi/arcmsr/arcmsr_hba.c                |  3 +--
 drivers/scsi/arm/acornscsi.c                    | 14 +++-----------
 drivers/scsi/arm/fas216.c                       | 10 ++++------
 drivers/scsi/atp870u.c                          |  4 ++--
 drivers/scsi/bfa/bfad_im.c                      |  4 ++--
 drivers/scsi/dc395x.c                           |  3 ++-
 drivers/scsi/dpt_i2o.c                          |  2 +-
 drivers/scsi/esp_scsi.c                         |  2 +-
 drivers/scsi/fnic/fnic_scsi.c                   |  3 ++-
 drivers/scsi/hptiop.c                           |  3 +--
 drivers/scsi/ibmvscsi/ibmvscsi.c                |  4 ++--
 drivers/scsi/imm.c                              |  3 +--
 drivers/scsi/initio.c                           |  3 +--
 drivers/scsi/ips.c                              |  3 ++-
 drivers/scsi/mac53c94.c                         |  3 +--
 drivers/scsi/megaraid.c                         |  3 +--
 drivers/scsi/megaraid/megaraid_mbox.c           |  4 ++--
 drivers/scsi/mesh.c                             |  2 +-
 drivers/scsi/ncr53c8xx.c                        |  3 ++-
 drivers/scsi/nsp32.c                            |  4 ++--
 drivers/scsi/pcmcia/nsp_cs.c                    |  3 +--
 drivers/scsi/pcmcia/sym53c500_cs.c              |  3 +--
 drivers/scsi/pmcraid.c                          |  5 +----
 drivers/scsi/ppa.c                              |  3 +--
 drivers/scsi/ps3rom.c                           |  3 +--
 drivers/scsi/qla1280.c                          |  3 +--
 drivers/scsi/qlogicfas408.c                     |  4 ++--
 drivers/scsi/qlogicpti.c                        |  3 ++-
 drivers/scsi/stex.c                             |  4 ++--
 drivers/scsi/sym53c8xx_2/sym_glue.c             |  3 +--
 drivers/scsi/vmw_pvscsi.c                       |  2 +-
 drivers/scsi/wd33c93.c                          |  4 +---
 drivers/staging/rts5208/rtsx.c                  |  4 ++--
 drivers/staging/unisys/visorhba/visorhba_main.c |  5 ++---
 drivers/usb/image/microtek.c                    |  5 ++---
 drivers/usb/storage/scsiglue.c                  |  4 ++--
 drivers/usb/storage/uas.c                       |  3 +--
 include/scsi/scsi_host.h                        |  2 +-
 49 files changed, 75 insertions(+), 103 deletions(-)

diff --git a/drivers/scsi/3w-9xxx.c b/drivers/scsi/3w-9xxx.c
index 4ebc2c79f45f..778d4892ed7d 100644
--- a/drivers/scsi/3w-9xxx.c
+++ b/drivers/scsi/3w-9xxx.c
@@ -1744,8 +1744,9 @@ static int twa_scsi_eh_reset(struct scsi_cmnd *SCpnt)
 } /* End twa_scsi_eh_reset() */
 
 /* This is the main scsi queue function to handle scsi opcodes */
-static int twa_scsi_queue_lck(struct scsi_cmnd *SCpnt, void (*done)(struct scsi_cmnd *))
+static int twa_scsi_queue_lck(struct scsi_cmnd *SCpnt)
 {
+	void (*done)(struct scsi_cmnd *) = scsi_done;
 	int request_id, retval;
 	TW_Device_Extension *tw_dev = (TW_Device_Extension *)SCpnt->device->host->hostdata;
 
diff --git a/drivers/scsi/3w-sas.c b/drivers/scsi/3w-sas.c
index e6f51904f5b1..fc9a2f27aaf9 100644
--- a/drivers/scsi/3w-sas.c
+++ b/drivers/scsi/3w-sas.c
@@ -1450,8 +1450,9 @@ static int twl_scsi_eh_reset(struct scsi_cmnd *SCpnt)
 } /* End twl_scsi_eh_reset() */
 
 /* This is the main scsi queue function to handle scsi opcodes */
-static int twl_scsi_queue_lck(struct scsi_cmnd *SCpnt, void (*done)(struct scsi_cmnd *))
+static int twl_scsi_queue_lck(struct scsi_cmnd *SCpnt)
 {
+	void (*done)(struct scsi_cmnd *) = scsi_done;
 	int request_id, retval;
 	TW_Device_Extension *tw_dev = (TW_Device_Extension *)SCpnt->device->host->hostdata;
 
diff --git a/drivers/scsi/3w-xxxx.c b/drivers/scsi/3w-xxxx.c
index bdd3ab8875e2..498a5ab7a321 100644
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -1918,8 +1918,9 @@ static int tw_scsiop_test_unit_ready_complete(TW_Device_Extension *tw_dev, int r
 } /* End tw_scsiop_test_unit_ready_complete() */
 
 /* This is the main scsi queue function to handle scsi opcodes */
-static int tw_scsi_queue_lck(struct scsi_cmnd *SCpnt, void (*done)(struct scsi_cmnd *))
+static int tw_scsi_queue_lck(struct scsi_cmnd *SCpnt)
 {
+	void (*done)(struct scsi_cmnd *) = scsi_done;
 	unsigned char *command = SCpnt->cmnd;
 	int request_id = 0;
 	int retval = 1;
diff --git a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
index e7ed2fd6cdec..f1cbac77959e 100644
--- a/drivers/scsi/53c700.c
+++ b/drivers/scsi/53c700.c
@@ -1751,8 +1751,7 @@ NCR_700_intr(int irq, void *dev_id)
 	return IRQ_RETVAL(handled);
 }
 
-static int
-NCR_700_queuecommand_lck(struct scsi_cmnd *SCp, void (*done)(struct scsi_cmnd *))
+static int NCR_700_queuecommand_lck(struct scsi_cmnd *SCp)
 {
 	struct NCR_700_Host_Parameters *hostdata = 
 		(struct NCR_700_Host_Parameters *)SCp->device->host->hostdata[0];
diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
index 7287a9081684..a897c8f914cf 100644
--- a/drivers/scsi/BusLogic.c
+++ b/drivers/scsi/BusLogic.c
@@ -2866,9 +2866,9 @@ static int blogic_hostreset(struct scsi_cmnd *SCpnt)
   Outgoing Mailbox for execution by the associated Host Adapter.
 */
 
-static int blogic_qcmd_lck(struct scsi_cmnd *command,
-		void (*comp_cb) (struct scsi_cmnd *))
+static int blogic_qcmd_lck(struct scsi_cmnd *command)
 {
+	void (*comp_cb)(struct scsi_cmnd *) = scsi_done;
 	struct blogic_adapter *adapter =
 		(struct blogic_adapter *) command->device->host->hostdata;
 	struct blogic_tgt_flags *tgt_flags =
diff --git a/drivers/scsi/a100u2w.c b/drivers/scsi/a100u2w.c
index 68343bcb4616..564ade03b530 100644
--- a/drivers/scsi/a100u2w.c
+++ b/drivers/scsi/a100u2w.c
@@ -911,7 +911,7 @@ static int inia100_build_scb(struct orc_host * host, struct orc_scb * scb, struc
  *	queue the command down to the controller
  */
 
-static int inia100_queue_lck(struct scsi_cmnd * cmd, void (*done) (struct scsi_cmnd *))
+static int inia100_queue_lck(struct scsi_cmnd *cmd)
 {
 	struct orc_scb *scb;
 	struct orc_host *host;		/* Point to Host adapter control block */
diff --git a/drivers/scsi/advansys.c b/drivers/scsi/advansys.c
index f2f14fbd5069..ace5eff828e9 100644
--- a/drivers/scsi/advansys.c
+++ b/drivers/scsi/advansys.c
@@ -8453,8 +8453,7 @@ static int asc_execute_scsi_cmnd(struct scsi_cmnd *scp)
  * This function always returns 0. Command return status is saved
  * in the 'scp' result field.
  */
-static int
-advansys_queuecommand_lck(struct scsi_cmnd *scp, void (*done)(struct scsi_cmnd *))
+static int advansys_queuecommand_lck(struct scsi_cmnd *scp)
 {
 	struct Scsi_Host *shost = scp->device->host;
 	int asc_res, result = 0;
diff --git a/drivers/scsi/aha152x.c b/drivers/scsi/aha152x.c
index f07de9912790..d17880b57d17 100644
--- a/drivers/scsi/aha152x.c
+++ b/drivers/scsi/aha152x.c
@@ -975,10 +975,8 @@ static int aha152x_internal_queue(struct scsi_cmnd *SCpnt,
  *  queue a command
  *
  */
-static int aha152x_queue_lck(struct scsi_cmnd *SCpnt,
-			     void (*done)(struct scsi_cmnd *))
+static int aha152x_queue_lck(struct scsi_cmnd *SCpnt)
 {
-	WARN_ON_ONCE(done != scsi_done);
 	return aha152x_internal_queue(SCpnt, NULL, 0);
 }
 
diff --git a/drivers/scsi/aha1740.c b/drivers/scsi/aha1740.c
index 39d8759fe558..18eb4cfcef9a 100644
--- a/drivers/scsi/aha1740.c
+++ b/drivers/scsi/aha1740.c
@@ -315,9 +315,9 @@ static irqreturn_t aha1740_intr_handle(int irq, void *dev_id)
 	return IRQ_RETVAL(handled);
 }
 
-static int aha1740_queuecommand_lck(struct scsi_cmnd * SCpnt,
-				    void (*done)(struct scsi_cmnd *))
+static int aha1740_queuecommand_lck(struct scsi_cmnd *SCpnt)
 {
+	void (*done)(struct scsi_cmnd *) = scsi_done;
 	unchar direction;
 	unchar *cmd = (unchar *) SCpnt->cmnd;
 	unchar target = scmd_id(SCpnt);
diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.c b/drivers/scsi/aic7xxx/aic79xx_osm.c
index af49c32cfaf7..5d566d2b2997 100644
--- a/drivers/scsi/aic7xxx/aic79xx_osm.c
+++ b/drivers/scsi/aic7xxx/aic79xx_osm.c
@@ -572,8 +572,7 @@ ahd_linux_info(struct Scsi_Host *host)
 /*
  * Queue an SCB to the controller.
  */
-static int
-ahd_linux_queue_lck(struct scsi_cmnd * cmd, void (*scsi_done) (struct scsi_cmnd *))
+static int ahd_linux_queue_lck(struct scsi_cmnd *cmd)
 {
 	struct	 ahd_softc *ahd;
 	struct	 ahd_linux_device *dev = scsi_transport_device_data(cmd->device);
diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.c b/drivers/scsi/aic7xxx/aic7xxx_osm.c
index f2daca41f3f2..d3b1082654d5 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
@@ -518,8 +518,7 @@ ahc_linux_info(struct Scsi_Host *host)
 /*
  * Queue an SCB to the controller.
  */
-static int
-ahc_linux_queue_lck(struct scsi_cmnd * cmd, void (*scsi_done) (struct scsi_cmnd *))
+static int ahc_linux_queue_lck(struct scsi_cmnd *cmd)
 {
 	struct	 ahc_softc *ahc;
 	struct	 ahc_linux_device *dev = scsi_transport_device_data(cmd->device);
diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index e2692ca87a6e..daa8cf61f6d6 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -3231,8 +3231,7 @@ static void arcmsr_handle_virtual_command(struct AdapterControlBlock *acb,
 	}
 }
 
-static int arcmsr_queue_command_lck(struct scsi_cmnd *cmd,
-	void (* done)(struct scsi_cmnd *))
+static int arcmsr_queue_command_lck(struct scsi_cmnd *cmd)
 {
 	struct Scsi_Host *host = cmd->device->host;
 	struct AdapterControlBlock *acb = (struct AdapterControlBlock *) host->hostdata;
diff --git a/drivers/scsi/arm/acornscsi.c b/drivers/scsi/arm/acornscsi.c
index dadaf5ee0ea9..81eb3bbdfc51 100644
--- a/drivers/scsi/arm/acornscsi.c
+++ b/drivers/scsi/arm/acornscsi.c
@@ -2397,24 +2397,16 @@ acornscsi_intr(int irq, void *dev_id)
  */
 
 /*
- * Function : acornscsi_queuecmd(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *))
+ * Function : acornscsi_queuecmd(struct scsi_cmnd *cmd)
  * Purpose  : queues a SCSI command
  * Params   : cmd  - SCSI command
- *	      done - function called on completion, with pointer to command descriptor
  * Returns  : 0, or < 0 on error.
  */
-static int acornscsi_queuecmd_lck(struct scsi_cmnd *SCpnt,
-		       void (*done)(struct scsi_cmnd *))
+static int acornscsi_queuecmd_lck(struct scsi_cmnd *SCpnt)
 {
+    void (*done)(struct scsi_cmnd *) = scsi_done;
     AS_Host *host = (AS_Host *)SCpnt->device->host->hostdata;
 
-    if (!done) {
-	/* there should be some way of rejecting errors like this without panicing... */
-	panic("scsi%d: queuecommand called with NULL done function [cmd=%p]",
-		host->host->host_no, SCpnt);
-	return -EINVAL;
-    }
-
 #if (DEBUG & DEBUG_NO_WRITE)
     if (acornscsi_cmdtype(SCpnt->cmnd[0]) == CMD_WRITE && (NO_WRITE & (1 << SCpnt->device->id))) {
 	printk(KERN_CRIT "scsi%d.%c: WRITE attempted with NO_WRITE flag set\n",
diff --git a/drivers/scsi/arm/fas216.c b/drivers/scsi/arm/fas216.c
index 285980b9257d..423a85fda9f8 100644
--- a/drivers/scsi/arm/fas216.c
+++ b/drivers/scsi/arm/fas216.c
@@ -2235,10 +2235,9 @@ static int fas216_queue_command_internal(struct scsi_cmnd *SCpnt,
 	return result;
 }
 
-static int fas216_queue_command_lck(struct scsi_cmnd *SCpnt,
-				    void (*done)(struct scsi_cmnd *))
+static int fas216_queue_command_lck(struct scsi_cmnd *SCpnt)
 {
-	return fas216_queue_command_internal(SCpnt, done);
+	return fas216_queue_command_internal(SCpnt, scsi_done);
 }
 
 DEF_SCSI_QCMD(fas216_queue_command)
@@ -2266,8 +2265,7 @@ static void fas216_internal_done(struct scsi_cmnd *SCpnt)
  * Returns: scsi result code.
  * Notes: io_request_lock is held, interrupts are disabled.
  */
-static int fas216_noqueue_command_lck(struct scsi_cmnd *SCpnt,
-			   void (*done)(struct scsi_cmnd *))
+static int fas216_noqueue_command_lck(struct scsi_cmnd *SCpnt)
 {
 	FAS216_Info *info = (FAS216_Info *)SCpnt->device->host->hostdata;
 
@@ -2308,7 +2306,7 @@ static int fas216_noqueue_command_lck(struct scsi_cmnd *SCpnt,
 
 	spin_lock_irq(info->host->host_lock);
 
-	done(SCpnt);
+	scsi_done(SCpnt);
 
 	return 0;
 }
diff --git a/drivers/scsi/atp870u.c b/drivers/scsi/atp870u.c
index 6e1595b32bc0..dcd6fae65a88 100644
--- a/drivers/scsi/atp870u.c
+++ b/drivers/scsi/atp870u.c
@@ -618,9 +618,9 @@ static irqreturn_t atp870u_intr_handle(int irq, void *dev_id)
  *
  *	Queue a command to the ATP queue. Called with the host lock held.
  */
-static int atp870u_queuecommand_lck(struct scsi_cmnd *req_p,
-			 void (*done) (struct scsi_cmnd *))
+static int atp870u_queuecommand_lck(struct scsi_cmnd *req_p)
 {
+	void (*done)(struct scsi_cmnd *) = scsi_done;
 	unsigned char c;
 	unsigned int m;
 	struct atp_unit *dev;
diff --git a/drivers/scsi/bfa/bfad_im.c b/drivers/scsi/bfa/bfad_im.c
index e12ae60efd33..79d8f2af1294 100644
--- a/drivers/scsi/bfa/bfad_im.c
+++ b/drivers/scsi/bfa/bfad_im.c
@@ -1199,9 +1199,9 @@ bfad_im_itnim_work_handler(struct work_struct *work)
 /*
  * Scsi_Host template entry, queue a SCSI command to the BFAD.
  */
-static int
-bfad_im_queuecommand_lck(struct scsi_cmnd *cmnd, void (*done) (struct scsi_cmnd *))
+static int bfad_im_queuecommand_lck(struct scsi_cmnd *cmnd)
 {
+	void (*done)(struct scsi_cmnd *) = scsi_done;
 	struct bfad_im_port_s *im_port =
 		(struct bfad_im_port_s *) cmnd->device->host->hostdata[0];
 	struct bfad_s         *bfad = im_port->bfad;
diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index 5adbc7f61c19..9b8796c9e634 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -960,8 +960,9 @@ static void build_srb(struct scsi_cmnd *cmd, struct DeviceCtlBlk *dcb,
  *        and is expected to be held on return.
  *
  **/
-static int dc395x_queue_command_lck(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *))
+static int dc395x_queue_command_lck(struct scsi_cmnd *cmd)
 {
+	void (*done)(struct scsi_cmnd *) = scsi_done;
 	struct DeviceCtlBlk *dcb;
 	struct ScsiReqBlk *srb;
 	struct AdapterCtlBlk *acb =
diff --git a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
index 1f00afcfe440..93227c04ef59 100644
--- a/drivers/scsi/dpt_i2o.c
+++ b/drivers/scsi/dpt_i2o.c
@@ -416,7 +416,7 @@ static int adpt_slave_configure(struct scsi_device * device)
 	return 0;
 }
 
-static int adpt_queue_lck(struct scsi_cmnd * cmd, void (*done) (struct scsi_cmnd *))
+static int adpt_queue_lck(struct scsi_cmnd *cmd)
 {
 	adpt_hba* pHba = NULL;
 	struct adpt_device* pDev = NULL;	/* dpt per device information */
diff --git a/drivers/scsi/esp_scsi.c b/drivers/scsi/esp_scsi.c
index f7c2d64f1cef..57787537285a 100644
--- a/drivers/scsi/esp_scsi.c
+++ b/drivers/scsi/esp_scsi.c
@@ -952,7 +952,7 @@ static void esp_event_queue_full(struct esp *esp, struct esp_cmd_entry *ent)
 	scsi_track_queue_full(dev, lp->num_tagged - 1);
 }
 
-static int esp_queuecommand_lck(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *))
+static int esp_queuecommand_lck(struct scsi_cmnd *cmd)
 {
 	struct scsi_device *dev = cmd->device;
 	struct esp *esp = shost_priv(dev->host);
diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index 09b8bf5adaf5..88c549f257db 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -420,8 +420,9 @@ static inline int fnic_queue_wq_copy_desc(struct fnic *fnic,
  * Routine to send a scsi cdb
  * Called with host_lock held and interrupts disabled.
  */
-static int fnic_queuecommand_lck(struct scsi_cmnd *sc, void (*done)(struct scsi_cmnd *))
+static int fnic_queuecommand_lck(struct scsi_cmnd *sc)
 {
+	void (*done)(struct scsi_cmnd *) = scsi_done;
 	const int tag = scsi_cmd_to_rq(sc)->tag;
 	struct fc_lport *lp = shost_priv(sc->device->host);
 	struct fc_rport *rport;
diff --git a/drivers/scsi/hptiop.c b/drivers/scsi/hptiop.c
index f18f6a677c1b..f9a9def394cc 100644
--- a/drivers/scsi/hptiop.c
+++ b/drivers/scsi/hptiop.c
@@ -993,8 +993,7 @@ static int hptiop_reset_comm_mvfrey(struct hptiop_hba *hba)
 	return 0;
 }
 
-static int hptiop_queuecommand_lck(struct scsi_cmnd *scp,
-				void (*done)(struct scsi_cmnd *))
+static int hptiop_queuecommand_lck(struct scsi_cmnd *scp)
 {
 	struct Scsi_Host *host = scp->device->host;
 	struct hptiop_hba *hba = (struct hptiop_hba *)host->hostdata;
diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index 50df7dd9cb91..5cc37859b874 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -1039,9 +1039,9 @@ static inline u16 lun_from_dev(struct scsi_device *dev)
  * @cmnd:	struct scsi_cmnd to be executed
  * @done:	Callback function to be called when cmd is completed
 */
-static int ibmvscsi_queuecommand_lck(struct scsi_cmnd *cmnd,
-				 void (*done) (struct scsi_cmnd *))
+static int ibmvscsi_queuecommand_lck(struct scsi_cmnd *cmnd)
 {
+	void (*done)(struct scsi_cmnd *) = scsi_done;
 	struct srp_cmd *srp_cmd;
 	struct srp_event_struct *evt_struct;
 	struct srp_indirect_buf *indirect;
diff --git a/drivers/scsi/imm.c b/drivers/scsi/imm.c
index be8edcff0177..8afdb4dba2be 100644
--- a/drivers/scsi/imm.c
+++ b/drivers/scsi/imm.c
@@ -910,8 +910,7 @@ static int imm_engine(imm_struct *dev, struct scsi_cmnd *cmd)
 	return 0;
 }
 
-static int imm_queuecommand_lck(struct scsi_cmnd *cmd,
-		void (*done)(struct scsi_cmnd *))
+static int imm_queuecommand_lck(struct scsi_cmnd *cmd)
 {
 	imm_struct *dev = imm_dev(cmd->device->host);
 
diff --git a/drivers/scsi/initio.c b/drivers/scsi/initio.c
index 183f95758636..fd6da96bc51a 100644
--- a/drivers/scsi/initio.c
+++ b/drivers/scsi/initio.c
@@ -2609,8 +2609,7 @@ static void initio_build_scb(struct initio_host * host, struct scsi_ctrl_blk * c
  *	will cause the mid layer to call us again later with the command)
  */
 
-static int i91u_queuecommand_lck(struct scsi_cmnd *cmd,
-		void (*done)(struct scsi_cmnd *))
+static int i91u_queuecommand_lck(struct scsi_cmnd *cmd)
 {
 	struct initio_host *host = (struct initio_host *) cmd->device->host->hostdata;
 	struct scsi_ctrl_blk *cmnd;
diff --git a/drivers/scsi/ips.c b/drivers/scsi/ips.c
index 0c93ec359e9b..498bf04499ce 100644
--- a/drivers/scsi/ips.c
+++ b/drivers/scsi/ips.c
@@ -1035,8 +1035,9 @@ static int ips_eh_reset(struct scsi_cmnd *SC)
 /*    Linux obtains io_request_lock before calling this function            */
 /*                                                                          */
 /****************************************************************************/
-static int ips_queue_lck(struct scsi_cmnd *SC, void (*done) (struct scsi_cmnd *))
+static int ips_queue_lck(struct scsi_cmnd *SC)
 {
+	void (*done)(struct scsi_cmnd *) = scsi_done;
 	ips_ha_t *ha;
 	ips_passthru_t *pt;
 
diff --git a/drivers/scsi/mac53c94.c b/drivers/scsi/mac53c94.c
index 9731855805f5..3976a18f6333 100644
--- a/drivers/scsi/mac53c94.c
+++ b/drivers/scsi/mac53c94.c
@@ -66,8 +66,7 @@ static irqreturn_t do_mac53c94_interrupt(int, void *);
 static void cmd_done(struct fsc_state *, int result);
 static void set_dma_cmds(struct fsc_state *, struct scsi_cmnd *);
 
-
-static int mac53c94_queue_lck(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *))
+static int mac53c94_queue_lck(struct scsi_cmnd *cmd)
 {
 	struct fsc_state *state;
 
diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
index c4ea833586e0..0d31d7a5e335 100644
--- a/drivers/scsi/megaraid.c
+++ b/drivers/scsi/megaraid.c
@@ -370,8 +370,7 @@ mega_runpendq(adapter_t *adapter)
  *
  * The command queuing entry point for the mid-layer.
  */
-static int
-megaraid_queue_lck(struct scsi_cmnd *scmd, void (*done)(struct scsi_cmnd *))
+static int megaraid_queue_lck(struct scsi_cmnd *scmd)
 {
 	adapter_t	*adapter;
 	scb_t	*scb;
diff --git a/drivers/scsi/megaraid/megaraid_mbox.c b/drivers/scsi/megaraid/megaraid_mbox.c
index 705c5027ba91..0f47a9862ef9 100644
--- a/drivers/scsi/megaraid/megaraid_mbox.c
+++ b/drivers/scsi/megaraid/megaraid_mbox.c
@@ -1432,9 +1432,9 @@ mbox_post_cmd(adapter_t *adapter, scb_t *scb)
  *
  * Queue entry point for mailbox based controllers.
  */
-static int
-megaraid_queue_command_lck(struct scsi_cmnd *scp, void (*done)(struct scsi_cmnd *))
+static int megaraid_queue_command_lck(struct scsi_cmnd *scp)
 {
+	void (*done)(struct scsi_cmnd *) = scsi_done;
 	adapter_t	*adapter;
 	scb_t		*scb;
 	int		if_busy;
diff --git a/drivers/scsi/mesh.c b/drivers/scsi/mesh.c
index 73a3e85802ad..ca133e0a140a 100644
--- a/drivers/scsi/mesh.c
+++ b/drivers/scsi/mesh.c
@@ -1621,7 +1621,7 @@ static void cmd_complete(struct mesh_state *ms)
  * Called by midlayer with host locked to queue a new
  * request
  */
-static int mesh_queue_lck(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *))
+static int mesh_queue_lck(struct scsi_cmnd *cmd)
 {
 	struct mesh_state *ms;
 
diff --git a/drivers/scsi/ncr53c8xx.c b/drivers/scsi/ncr53c8xx.c
index 6ad43a98409c..168b854ccf14 100644
--- a/drivers/scsi/ncr53c8xx.c
+++ b/drivers/scsi/ncr53c8xx.c
@@ -7852,8 +7852,9 @@ static int ncr53c8xx_slave_configure(struct scsi_device *device)
 	return 0;
 }
 
-static int ncr53c8xx_queue_command_lck (struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *))
+static int ncr53c8xx_queue_command_lck(struct scsi_cmnd *cmd)
 {
+     void (*done)(struct scsi_cmnd *) = scsi_done;
      struct ncb *np = ((struct host_data *) cmd->device->host->hostdata)->ncb;
      unsigned long flags;
      int sts;
diff --git a/drivers/scsi/nsp32.c b/drivers/scsi/nsp32.c
index 1057b6fd7569..bd3ee3bf08ee 100644
--- a/drivers/scsi/nsp32.c
+++ b/drivers/scsi/nsp32.c
@@ -904,9 +904,9 @@ static int nsp32_setup_sg_table(struct scsi_cmnd *SCpnt)
 	return TRUE;
 }
 
-static int nsp32_queuecommand_lck(struct scsi_cmnd *SCpnt,
-				  void (*done)(struct scsi_cmnd *))
+static int nsp32_queuecommand_lck(struct scsi_cmnd *SCpnt)
 {
+	void (*done)(struct scsi_cmnd *) = scsi_done;
 	nsp32_hw_data *data = (nsp32_hw_data *)SCpnt->device->host->hostdata;
 	nsp32_target *target;
 	nsp32_lunt   *cur_lunt;
diff --git a/drivers/scsi/pcmcia/nsp_cs.c b/drivers/scsi/pcmcia/nsp_cs.c
index 0271d534133a..8b9e889bc306 100644
--- a/drivers/scsi/pcmcia/nsp_cs.c
+++ b/drivers/scsi/pcmcia/nsp_cs.c
@@ -181,8 +181,7 @@ static void nsp_scsi_done(struct scsi_cmnd *SCpnt)
 	scsi_done(SCpnt);
 }
 
-static int nsp_queuecommand_lck(struct scsi_cmnd *SCpnt,
-			    void (*done)(struct scsi_cmnd *))
+static int nsp_queuecommand_lck(struct scsi_cmnd *SCpnt)
 {
 #ifdef NSP_DEBUG
 	/*unsigned int host_id = SCpnt->device->host->this_id;*/
diff --git a/drivers/scsi/pcmcia/sym53c500_cs.c b/drivers/scsi/pcmcia/sym53c500_cs.c
index d2adda815d7b..d5c30ac662ba 100644
--- a/drivers/scsi/pcmcia/sym53c500_cs.c
+++ b/drivers/scsi/pcmcia/sym53c500_cs.c
@@ -537,8 +537,7 @@ SYM53C500_info(struct Scsi_Host *SChost)
 	return (info_msg);
 }
 
-static int 
-SYM53C500_queue_lck(struct scsi_cmnd *SCpnt, void (*done)(struct scsi_cmnd *))
+static int SYM53C500_queue_lck(struct scsi_cmnd *SCpnt)
 {
 	int i;
 	int port_base = SCpnt->device->host->io_port;
diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index 11f36fd4e62f..18efb3e64c84 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -3313,10 +3313,7 @@ static int pmcraid_copy_sglist(
  *	  SCSI_MLQUEUE_DEVICE_BUSY if device is busy
  *	  SCSI_MLQUEUE_HOST_BUSY if host is busy
  */
-static int pmcraid_queuecommand_lck(
-	struct scsi_cmnd *scsi_cmd,
-	void (*done) (struct scsi_cmnd *)
-)
+static int pmcraid_queuecommand_lck(struct scsi_cmnd *scsi_cmd)
 {
 	struct pmcraid_instance *pinstance;
 	struct pmcraid_resource_entry *res;
diff --git a/drivers/scsi/ppa.c b/drivers/scsi/ppa.c
index 799ad8562e24..003043de23a5 100644
--- a/drivers/scsi/ppa.c
+++ b/drivers/scsi/ppa.c
@@ -786,8 +786,7 @@ static int ppa_engine(ppa_struct *dev, struct scsi_cmnd *cmd)
 	return 0;
 }
 
-static int ppa_queuecommand_lck(struct scsi_cmnd *cmd,
-		void (*done) (struct scsi_cmnd *))
+static int ppa_queuecommand_lck(struct scsi_cmnd *cmd)
 {
 	ppa_struct *dev = ppa_dev(cmd->device->host);
 
diff --git a/drivers/scsi/ps3rom.c b/drivers/scsi/ps3rom.c
index 08e970300b3f..2b80cab70333 100644
--- a/drivers/scsi/ps3rom.c
+++ b/drivers/scsi/ps3rom.c
@@ -200,8 +200,7 @@ static int ps3rom_write_request(struct ps3_storage_device *dev,
 	return 0;
 }
 
-static int ps3rom_queuecommand_lck(struct scsi_cmnd *cmd,
-			       void (*done)(struct scsi_cmnd *))
+static int ps3rom_queuecommand_lck(struct scsi_cmnd *cmd)
 {
 	struct ps3rom_private *priv = shost_priv(cmd->device->host);
 	struct ps3_storage_device *dev = priv->dev;
diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
index c508a6e20519..1dc56f4c89d8 100644
--- a/drivers/scsi/qla1280.c
+++ b/drivers/scsi/qla1280.c
@@ -689,8 +689,7 @@ qla1280_info(struct Scsi_Host *host)
  * handling).   Unfortunately, it sometimes calls the scheduler in interrupt
  * context which is a big NO! NO!.
  **************************************************************************/
-static int
-qla1280_queuecommand_lck(struct scsi_cmnd *cmd, void (*fn)(struct scsi_cmnd *))
+static int qla1280_queuecommand_lck(struct scsi_cmnd *cmd)
 {
 	struct Scsi_Host *host = cmd->device->host;
 	struct scsi_qla_host *ha = (struct scsi_qla_host *)host->hostdata;
diff --git a/drivers/scsi/qlogicfas408.c b/drivers/scsi/qlogicfas408.c
index 5471c046a4b7..30a88849a626 100644
--- a/drivers/scsi/qlogicfas408.c
+++ b/drivers/scsi/qlogicfas408.c
@@ -460,9 +460,9 @@ irqreturn_t qlogicfas408_ihandl(int irq, void *dev_id)
  *	Queued command
  */
 
-static int qlogicfas408_queuecommand_lck(struct scsi_cmnd *cmd,
-			      void (*done) (struct scsi_cmnd *))
+static int qlogicfas408_queuecommand_lck(struct scsi_cmnd *cmd)
 {
+	void (*done)(struct scsi_cmnd *) = scsi_done;
 	struct qlogicfas408_priv *priv = get_priv_by_cmd(cmd);
 
 	set_host_byte(cmd, DID_OK);
diff --git a/drivers/scsi/qlogicpti.c b/drivers/scsi/qlogicpti.c
index 30b5e98b5de0..57f2f4135a06 100644
--- a/drivers/scsi/qlogicpti.c
+++ b/drivers/scsi/qlogicpti.c
@@ -1013,8 +1013,9 @@ static int qlogicpti_slave_configure(struct scsi_device *sdev)
  *
  * "This code must fly." -davem
  */
-static int qlogicpti_queuecommand_lck(struct scsi_cmnd *Cmnd, void (*done)(struct scsi_cmnd *))
+static int qlogicpti_queuecommand_lck(struct scsi_cmnd *Cmnd)
 {
+	void (*done)(struct scsi_cmnd *) = scsi_done;
 	struct Scsi_Host *host = Cmnd->device->host;
 	struct qlogicpti *qpti = (struct qlogicpti *) host->hostdata;
 	struct Command_Entry *cmd;
diff --git a/drivers/scsi/stex.c b/drivers/scsi/stex.c
index 2f96a2fdaa40..e6420f2127ce 100644
--- a/drivers/scsi/stex.c
+++ b/drivers/scsi/stex.c
@@ -590,9 +590,9 @@ stex_slave_config(struct scsi_device *sdev)
 	return 0;
 }
 
-static int
-stex_queuecommand_lck(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *))
+static int stex_queuecommand_lck(struct scsi_cmnd *cmd)
 {
+	void (*done)(struct scsi_cmnd *) = scsi_done;
 	struct st_hba *hba;
 	struct Scsi_Host *host;
 	unsigned int id, lun;
diff --git a/drivers/scsi/sym53c8xx_2/sym_glue.c b/drivers/scsi/sym53c8xx_2/sym_glue.c
index 76747e180b17..b04bfde65e3f 100644
--- a/drivers/scsi/sym53c8xx_2/sym_glue.c
+++ b/drivers/scsi/sym53c8xx_2/sym_glue.c
@@ -486,8 +486,7 @@ void sym_log_bus_error(struct Scsi_Host *shost)
  * queuecommand method.  Entered with the host adapter lock held and
  * interrupts disabled.
  */
-static int sym53c8xx_queue_command_lck(struct scsi_cmnd *cmd,
-					void (*done)(struct scsi_cmnd *))
+static int sym53c8xx_queue_command_lck(struct scsi_cmnd *cmd)
 {
 	struct sym_hcb *np = SYM_SOFTC_PTR(cmd);
 	struct sym_ucmd *ucp = SYM_UCMD_PTR(cmd);
diff --git a/drivers/scsi/vmw_pvscsi.c b/drivers/scsi/vmw_pvscsi.c
index 7bfa023d0feb..c2ba65224633 100644
--- a/drivers/scsi/vmw_pvscsi.c
+++ b/drivers/scsi/vmw_pvscsi.c
@@ -768,7 +768,7 @@ static int pvscsi_queue_ring(struct pvscsi_adapter *adapter,
 	return 0;
 }
 
-static int pvscsi_queue_lck(struct scsi_cmnd *cmd, void (*done)(struct scsi_cmnd *))
+static int pvscsi_queue_lck(struct scsi_cmnd *cmd)
 {
 	struct Scsi_Host *host = cmd->device->host;
 	struct pvscsi_adapter *adapter = shost_priv(host);
diff --git a/drivers/scsi/wd33c93.c b/drivers/scsi/wd33c93.c
index fe28d21c7e93..7d2f00f3571a 100644
--- a/drivers/scsi/wd33c93.c
+++ b/drivers/scsi/wd33c93.c
@@ -362,9 +362,7 @@ calc_sync_msg(unsigned int period, unsigned int offset, unsigned int fast,
 	msg[1] = offset;
 }
 
-static int
-wd33c93_queuecommand_lck(struct scsi_cmnd *cmd,
-		void (*done)(struct scsi_cmnd *))
+static int wd33c93_queuecommand_lck(struct scsi_cmnd *cmd)
 {
 	struct WD33C93_hostdata *hostdata;
 	struct scsi_cmnd *tmp;
diff --git a/drivers/staging/rts5208/rtsx.c b/drivers/staging/rts5208/rtsx.c
index f1136f6bcee2..8d6139fce13e 100644
--- a/drivers/staging/rts5208/rtsx.c
+++ b/drivers/staging/rts5208/rtsx.c
@@ -118,9 +118,9 @@ static int slave_configure(struct scsi_device *sdev)
 
 /* queue a command */
 /* This is always called with scsi_lock(host) held */
-static int queuecommand_lck(struct scsi_cmnd *srb,
-			    void (*done)(struct scsi_cmnd *))
+static int queuecommand_lck(struct scsi_cmnd *srb)
 {
+	void (*done)(struct scsi_cmnd *) = scsi_done;
 	struct rtsx_dev *dev = host_to_rtsx(srb->device->host);
 	struct rtsx_chip *chip = dev->chip;
 
diff --git a/drivers/staging/unisys/visorhba/visorhba_main.c b/drivers/staging/unisys/visorhba/visorhba_main.c
index 6a8fa0587280..b40c8cacb813 100644
--- a/drivers/staging/unisys/visorhba/visorhba_main.c
+++ b/drivers/staging/unisys/visorhba/visorhba_main.c
@@ -446,10 +446,9 @@ static u32 dma_data_dir_linux_to_spar(enum dma_data_direction d)
  * Return: 0 if successfully queued to the Service Partition, otherwise
  *	   error code
  */
-static int visorhba_queue_command_lck(struct scsi_cmnd *scsicmd,
-				      void (*visorhba_cmnd_done)
-					   (struct scsi_cmnd *))
+static int visorhba_queue_command_lck(struct scsi_cmnd *scsicmd)
 {
+	void (*visorhba_cmnd_done)(struct scsi_cmnd *) = scsi_done;
 	struct uiscmdrsp *cmdrsp;
 	struct scsi_device *scsidev = scsicmd->device;
 	int insert_location;
diff --git a/drivers/usb/image/microtek.c b/drivers/usb/image/microtek.c
index 59b02a539963..b8dc6fa6a5a3 100644
--- a/drivers/usb/image/microtek.c
+++ b/drivers/usb/image/microtek.c
@@ -561,10 +561,9 @@ mts_build_transfer_context(struct scsi_cmnd *srb, struct mts_desc* desc)
 	desc->context.data_pipe = pipe;
 }
 
-
-static int
-mts_scsi_queuecommand_lck(struct scsi_cmnd *srb, mts_scsi_cmnd_callback callback)
+static int mts_scsi_queuecommand_lck(struct scsi_cmnd *srb)
 {
+	mts_scsi_cmnd_callback callback = scsi_done;
 	struct mts_desc* desc = (struct mts_desc*)(srb->device->host->hostdata[0]);
 	int res;
 
diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
index 9dfea19e5a91..220aa1cf4b3d 100644
--- a/drivers/usb/storage/scsiglue.c
+++ b/drivers/usb/storage/scsiglue.c
@@ -363,9 +363,9 @@ static int target_alloc(struct scsi_target *starget)
 
 /* queue a command */
 /* This is always called with scsi_lock(host) held */
-static int queuecommand_lck(struct scsi_cmnd *srb,
-			void (*done)(struct scsi_cmnd *))
+static int queuecommand_lck(struct scsi_cmnd *srb)
 {
+	void (*done)(struct scsi_cmnd *) = scsi_done;
 	struct us_data *us = host_to_us(srb->device->host);
 
 	/* check for state-transition errors */
diff --git a/drivers/usb/storage/uas.c b/drivers/usb/storage/uas.c
index 774d18907f47..7f2944729ecd 100644
--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -633,8 +633,7 @@ static int uas_submit_urbs(struct scsi_cmnd *cmnd,
 	return 0;
 }
 
-static int uas_queuecommand_lck(struct scsi_cmnd *cmnd,
-					void (*done)(struct scsi_cmnd *))
+static int uas_queuecommand_lck(struct scsi_cmnd *cmnd)
 {
 	struct scsi_device *sdev = cmnd->device;
 	struct uas_dev_info *devinfo = sdev->hostdata;
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 04e9b821c0c7..3bb46b188e1c 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -516,7 +516,7 @@ struct scsi_host_template {
 		unsigned long irq_flags;				\
 		int rc;							\
 		spin_lock_irqsave(shost->host_lock, irq_flags);		\
-		rc = func_name##_lck(cmd, scsi_done);			\
+		rc = func_name##_lck(cmd);				\
 		spin_unlock_irqrestore(shost->host_lock, irq_flags);	\
 		return rc;						\
 	}
