Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831265179A1
	for <lists+linux-scsi@lfdr.de>; Tue,  3 May 2022 00:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387811AbiEBWEx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 2 May 2022 18:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbiEBWDe (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 2 May 2022 18:03:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FBB3899
        for <linux-scsi@vger.kernel.org>; Mon,  2 May 2022 15:00:02 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 99636210ED;
        Mon,  2 May 2022 22:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651528800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C+4C/okcxVt++KQi4mJTufog1MDbupDXVj9PO2rD1Vs=;
        b=ivhA317fhXEttaVXpXvmShf8jX63B0/2YkI1p4Sa1Rwrr00kqEH13tgd+BJEDMHuOTahgQ
        HWKjwJD3108s8uV5DTsXqQIK2YGK31fLHgSRJVtTaIirsQ1OWwj/uhdyXu3eM+BZndnksG
        ArM+gKBaTCkGd0wmZVTkfc/oz2vS3w8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651528800;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C+4C/okcxVt++KQi4mJTufog1MDbupDXVj9PO2rD1Vs=;
        b=AyJcRnvieOz2br14t+WJuSHTYz+2r7NhEbkNuI2lo+gU6k3cL+Yj87vPI4Ewbwztc4nfWe
        5JoFMGkvbLIbrDBw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 90D502C146;
        Mon,  2 May 2022 22:00:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 8C8E15194146; Tue,  3 May 2022 00:00:00 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH 2/7] scsi: Use Scsi_Host and channel number as argument for eh_bus_reset_handler()
Date:   Mon,  2 May 2022 23:59:38 +0200
Message-Id: <20220502215953.5463-4-hare@suse.de>
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

The bus reset should not depend on any command, but rather only
use the SCSI Host and the channel/bus number as argument.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 Documentation/scsi/scsi_eh.rst                |  2 +-
 Documentation/scsi/scsi_mid_low_api.rst       |  5 ++-
 drivers/message/fusion/mptfc.c                | 13 +++----
 drivers/message/fusion/mptscsih.c             | 21 ++++-------
 drivers/message/fusion/mptscsih.h             |  2 +-
 drivers/scsi/a100u2w.c                        |  4 +-
 drivers/scsi/aacraid/linit.c                  | 11 +++---
 drivers/scsi/aha152x.c                        |  4 +-
 drivers/scsi/aha1542.c                        |  4 +-
 drivers/scsi/aic7xxx/aic79xx_osm.c            | 10 ++---
 drivers/scsi/aic7xxx/aic7xxx_osm.c            |  6 +--
 drivers/scsi/arcmsr/arcmsr_hba.c              |  6 +--
 drivers/scsi/arm/fas216.c                     |  9 +++--
 drivers/scsi/arm/fas216.h                     |  5 ++-
 drivers/scsi/dc395x.c                         | 25 ++++++-------
 drivers/scsi/dpt_i2o.c                        |  9 +++--
 drivers/scsi/dpti.h                           |  2 +-
 drivers/scsi/esas2r/esas2r.h                  |  2 +-
 drivers/scsi/esas2r/esas2r_main.c             |  4 +-
 drivers/scsi/esp_scsi.c                       |  4 +-
 drivers/scsi/initio.c                         | 11 +++---
 drivers/scsi/mpi3mr/mpi3mr_os.c               | 37 +++++++++++--------
 drivers/scsi/ncr53c8xx.c                      |  4 +-
 drivers/scsi/pcmcia/nsp_cs.c                  |  6 +--
 drivers/scsi/pcmcia/nsp_cs.h                  |  2 +-
 drivers/scsi/pmcraid.c                        |  7 ++--
 drivers/scsi/qla1280.c                        | 12 +++---
 drivers/scsi/qla2xxx/qla_os.c                 | 17 +++------
 drivers/scsi/scsi_debug.c                     | 31 ++++++----------
 drivers/scsi/scsi_error.c                     |  2 +-
 drivers/scsi/sym53c8xx_2/sym_glue.c           |  7 ++--
 drivers/scsi/vmw_pvscsi.c                     |  5 +--
 drivers/scsi/wd719x.c                         | 11 +++---
 .../staging/unisys/visorhba/visorhba_main.c   |  7 ++--
 drivers/usb/storage/scsiglue.c                |  4 +-
 include/scsi/scsi_host.h                      |  2 +-
 36 files changed, 150 insertions(+), 163 deletions(-)

diff --git a/Documentation/scsi/scsi_eh.rst b/Documentation/scsi/scsi_eh.rst
index 12113cca5ad9..5e2d04e64005 100644
--- a/Documentation/scsi/scsi_eh.rst
+++ b/Documentation/scsi/scsi_eh.rst
@@ -214,7 +214,7 @@ considered to fail always.
 
     int (* eh_abort_handler)(struct scsi_cmnd *);
     int (* eh_device_reset_handler)(struct scsi_cmnd *);
-    int (* eh_bus_reset_handler)(struct scsi_cmnd *);
+    int (* eh_bus_reset_handler)(struct Scsi_Host *, int);
     int (* eh_host_reset_handler)(struct Scsi_Host *);
 
 Higher-severity actions are taken only when lower-severity actions
diff --git a/Documentation/scsi/scsi_mid_low_api.rst b/Documentation/scsi/scsi_mid_low_api.rst
index 784587ea7eee..1b1c37445580 100644
--- a/Documentation/scsi/scsi_mid_low_api.rst
+++ b/Documentation/scsi/scsi_mid_low_api.rst
@@ -741,7 +741,8 @@ Details::
 
     /**
     *      eh_bus_reset_handler - issue SCSI bus reset
-    *      @scp: SCSI bus that contains this device should be reset
+    *      @host: SCSI Host that contains the channel which should be reset
+    *      @channel: channel to be reset
     *
     *      Returns SUCCESS if command aborted else FAILED
     *
@@ -754,7 +755,7 @@ Details::
     *
     *      Optionally defined in: LLD
     **/
-	int eh_bus_reset_handler(struct scsi_cmnd * scp)
+	int eh_bus_reset_handler(struct Scsi_Host * host, int channel)
 
 
     /**
diff --git a/drivers/message/fusion/mptfc.c b/drivers/message/fusion/mptfc.c
index 4a621380a4eb..bc62f0cc0cbd 100644
--- a/drivers/message/fusion/mptfc.c
+++ b/drivers/message/fusion/mptfc.c
@@ -103,7 +103,7 @@ static void mptfc_set_rport_loss_tmo(struct fc_rport *rport, uint32_t timeout);
 static void mptfc_remove(struct pci_dev *pdev);
 static int mptfc_abort(struct scsi_cmnd *SCpnt);
 static int mptfc_dev_reset(struct scsi_cmnd *SCpnt);
-static int mptfc_bus_reset(struct scsi_cmnd *SCpnt);
+static int mptfc_bus_reset(struct Scsi_Host *shost, int channel);
 
 static struct scsi_host_template mptfc_driver_template = {
 	.module				= THIS_MODULE,
@@ -259,11 +259,9 @@ mptfc_dev_reset(struct scsi_cmnd *SCpnt)
 }
 
 static int
-mptfc_bus_reset(struct scsi_cmnd *SCpnt)
+mptfc_bus_reset(struct Scsi_Host *shost, int channel)
 {
-	struct Scsi_Host *shost = SCpnt->device->host;
 	MPT_SCSI_HOST __maybe_unused *hd = shost_priv(shost);
-	int channel = SCpnt->device->channel;
 	struct mptfc_rport_info *ri;
 	int rtn;
 
@@ -280,10 +278,9 @@ mptfc_bus_reset(struct scsi_cmnd *SCpnt)
 	}
 	if (rtn == 0) {
 		dfcprintk (hd->ioc, printk(MYIOC_s_DEBUG_FMT
-			"%s.%d: %d:%llu, executing recovery.\n", __func__,
-			hd->ioc->name, shost->host_no,
-			SCpnt->device->id, SCpnt->device->lun));
-		rtn = mptscsih_bus_reset(SCpnt);
+			"%s.%d: 0:0, executing recovery.\n", __func__,
+			hd->ioc->name, shost->host_no));
+		rtn = mptscsih_bus_reset(shost, channel);
 	}
 	return rtn;
 }
diff --git a/drivers/message/fusion/mptscsih.c b/drivers/message/fusion/mptscsih.c
index 3df07e024026..afdbc8138346 100644
--- a/drivers/message/fusion/mptscsih.c
+++ b/drivers/message/fusion/mptscsih.c
@@ -1914,39 +1914,34 @@ mptscsih_target_reset(struct scsi_cmnd * SCpnt)
  *	Returns SUCCESS or FAILED.
  **/
 int
-mptscsih_bus_reset(struct scsi_cmnd * SCpnt)
+mptscsih_bus_reset(struct Scsi_Host * shost, int channel)
 {
 	MPT_SCSI_HOST	*hd;
 	int		 retval;
-	VirtDevice	 *vdevice;
 	MPT_ADAPTER	*ioc;
 
 	/* If we can't locate our host adapter structure, return FAILED status.
 	 */
-	if ((hd = shost_priv(SCpnt->device->host)) == NULL){
+	if ((hd = shost_priv(shost)) == NULL){
 		printk(KERN_ERR MYNAM ": bus reset: "
-		   "Can't locate host! (sc=%p)\n", SCpnt);
+		   "Can't locate host!\n");
 		return FAILED;
 	}
 
 	ioc = hd->ioc;
-	printk(MYIOC_s_INFO_FMT "attempting bus reset! (sc=%p)\n",
-	       ioc->name, SCpnt);
-	scsi_print_command(SCpnt);
+	printk(MYIOC_s_INFO_FMT "attempting bus reset!\n",
+	       ioc->name);
 
 	if (ioc->timeouts < -1)
 		ioc->timeouts++;
 
-	vdevice = SCpnt->device->hostdata;
-	if (!vdevice || !vdevice->vtarget)
-		return SUCCESS;
 	retval = mptscsih_IssueTaskMgmt(hd,
 					MPI_SCSITASKMGMT_TASKTYPE_RESET_BUS,
-					vdevice->vtarget->channel, 0, 0, 0,
+					channel, 0, 0, 0,
 					mptscsih_get_tm_timeout(ioc));
 
-	printk(MYIOC_s_INFO_FMT "bus reset: %s (sc=%p)\n",
-	    ioc->name, ((retval == 0) ? "SUCCESS" : "FAILED" ), SCpnt);
+	printk(MYIOC_s_INFO_FMT "bus reset: %s\n",
+	    ioc->name, ((retval == 0) ? "SUCCESS" : "FAILED" ));
 
 	if (retval == 0)
 		return SUCCESS;
diff --git a/drivers/message/fusion/mptscsih.h b/drivers/message/fusion/mptscsih.h
index 0faefe9c7541..9f3756bd25eb 100644
--- a/drivers/message/fusion/mptscsih.h
+++ b/drivers/message/fusion/mptscsih.h
@@ -121,7 +121,7 @@ extern int mptscsih_slave_configure(struct scsi_device *device);
 extern int mptscsih_abort(struct scsi_cmnd * SCpnt);
 extern int mptscsih_dev_reset(struct scsi_cmnd * SCpnt);
 extern int mptscsih_target_reset(struct scsi_cmnd * SCpnt);
-extern int mptscsih_bus_reset(struct scsi_cmnd * SCpnt);
+extern int mptscsih_bus_reset(struct Scsi_Host *, int);
 extern int mptscsih_host_reset(struct Scsi_Host *sh);
 extern int mptscsih_bios_param(struct scsi_device * sdev, struct block_device *bdev, sector_t capacity, int geom[]);
 extern int mptscsih_io_done(MPT_ADAPTER *ioc, MPT_FRAME_HDR *mf, MPT_FRAME_HDR *r);
diff --git a/drivers/scsi/a100u2w.c b/drivers/scsi/a100u2w.c
index bf552c818958..dab79824e2f6 100644
--- a/drivers/scsi/a100u2w.c
+++ b/drivers/scsi/a100u2w.c
@@ -934,10 +934,10 @@ static int inia100_abort(struct scsi_cmnd * cmd)
  Output         : None.
  Return         : pSRB  -       Pointer to SCSI request block.
 *****************************************************************************/
-static int inia100_bus_reset(struct scsi_cmnd * cmd)
+static int inia100_bus_reset(struct Scsi_Host * shost, int channel)
 {				/* I need Host Control Block Information */
 	struct orc_host *host;
-	host = (struct orc_host *) cmd->device->host->hostdata;
+	host = (struct orc_host *) shost->hostdata;
 	return orc_reset_scsi_bus(host);
 }
 
diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
index 19a012c9a3c9..de7e0985ac2b 100644
--- a/drivers/scsi/aacraid/linit.c
+++ b/drivers/scsi/aacraid/linit.c
@@ -1025,20 +1025,18 @@ static int aac_eh_target_reset(struct scsi_cmnd *cmd)
 
 /*
  *	aac_eh_bus_reset	- Bus reset command handling
- *	@scsi_cmd:	SCSI command block causing the reset
+ *	@host:	SCSI host causing the reset
+ *	@channel:	Number of the bus to be reset
  *
  */
-static int aac_eh_bus_reset(struct scsi_cmnd* cmd)
+static int aac_eh_bus_reset(struct Scsi_Host *host, int channel)
 {
-	struct scsi_device * dev = cmd->device;
-	struct Scsi_Host * host = dev->host;
 	struct aac_dev * aac = (struct aac_dev *)host->hostdata;
 	int count;
 	u32 cmd_bus;
 	int status = 0;
 
-
-	cmd_bus = aac_logical_to_phys(scmd_channel(cmd));
+	cmd_bus = aac_logical_to_phys(channel);
 	/* Mark the assoc. FIB to not complete, eh handler does this */
 	for (count = 0; count < (host->can_queue + AAC_NUM_MGT_FIB); ++count) {
 		struct fib *fib = &aac->fibs[count];
@@ -1046,6 +1044,7 @@ static int aac_eh_bus_reset(struct scsi_cmnd* cmd)
 		if (fib->hw_fib_va->header.XferState &&
 		    (fib->flags & FIB_CONTEXT_FLAG) &&
 		    (fib->flags & FIB_CONTEXT_FLAG_SCSI_CMD)) {
+			struct scsi_cmnd *cmd;
 			struct aac_hba_map_info *info;
 			u32 bus, cid;
 
diff --git a/drivers/scsi/aha152x.c b/drivers/scsi/aha152x.c
index 7e58f25c599b..1312dc5ef6d2 100644
--- a/drivers/scsi/aha152x.c
+++ b/drivers/scsi/aha152x.c
@@ -1192,9 +1192,9 @@ static int aha152x_bus_reset_host(struct Scsi_Host *shpnt)
  * Reset the bus
  *
  */
-static int aha152x_bus_reset(struct scsi_cmnd *SCpnt)
+static int aha152x_bus_reset(struct Scsi_Host *shpnt, int channel)
 {
-	return aha152x_bus_reset_host(SCpnt->device->host);
+	return aha152x_bus_reset_host(shpnt);
 }
 
 /*
diff --git a/drivers/scsi/aha1542.c b/drivers/scsi/aha1542.c
index 69063fe4aab8..797a49f927dd 100644
--- a/drivers/scsi/aha1542.c
+++ b/drivers/scsi/aha1542.c
@@ -980,9 +980,9 @@ static int aha1542_reset(struct Scsi_Host *sh, u8 reset_cmd)
 	return SUCCESS;
 }
 
-static int aha1542_bus_reset(struct scsi_cmnd *cmd)
+static int aha1542_bus_reset(struct Scsi_Host *sh, int channel)
 {
-	return aha1542_reset(cmd->device->host, SCRST);
+	return aha1542_reset(sh, SCRST);
 }
 
 static int aha1542_host_reset(struct Scsi_Host *sh)
diff --git a/drivers/scsi/aic7xxx/aic79xx_osm.c b/drivers/scsi/aic7xxx/aic79xx_osm.c
index c46e8152af28..00786c37f39f 100644
--- a/drivers/scsi/aic7xxx/aic79xx_osm.c
+++ b/drivers/scsi/aic7xxx/aic79xx_osm.c
@@ -866,21 +866,21 @@ ahd_linux_dev_reset(struct scsi_cmnd *cmd)
  * Reset the SCSI bus.
  */
 static int
-ahd_linux_bus_reset(struct scsi_cmnd *cmd)
+ahd_linux_bus_reset(struct Scsi_Host *shost, int channel)
 {
 	struct ahd_softc *ahd;
 	int    found;
 	unsigned long flags;
 
-	ahd = *(struct ahd_softc **)cmd->device->host->hostdata;
+	ahd = *(struct ahd_softc **)shost->hostdata;
 #ifdef AHD_DEBUG
 	if ((ahd_debug & AHD_SHOW_RECOVERY) != 0)
-		printk("%s: Bus reset called for cmd %p\n",
-		       ahd_name(ahd), cmd);
+		printk("%s: Bus reset called for channel %d\n",
+		       ahd_name(ahd), channel);
 #endif
 	ahd_lock(ahd, &flags);
 
-	found = ahd_reset_channel(ahd, scmd_channel(cmd) + 'A',
+	found = ahd_reset_channel(ahd, channel + 'A',
 				  /*initiate reset*/TRUE);
 	ahd_unlock(ahd, &flags);
 
diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.c b/drivers/scsi/aic7xxx/aic7xxx_osm.c
index 0ad429b7ebcf..f6c547cef26c 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
@@ -753,16 +753,16 @@ ahc_linux_dev_reset(struct scsi_cmnd *cmd)
  * Reset the SCSI bus.
  */
 static int
-ahc_linux_bus_reset(struct scsi_cmnd *cmd)
+ahc_linux_bus_reset(struct Scsi_Host *shost, int channel)
 {
 	struct ahc_softc *ahc;
 	int    found;
 	unsigned long flags;
 
-	ahc = *(struct ahc_softc **)cmd->device->host->hostdata;
+	ahc = *(struct ahc_softc **)shost->hostdata;
 
 	ahc_lock(ahc, &flags);
-	found = ahc_reset_channel(ahc, scmd_channel(cmd) + 'A',
+	found = ahc_reset_channel(ahc, channel + 'A',
 				  /*initiate reset*/TRUE);
 	ahc_unlock(ahc, &flags);
 
diff --git a/drivers/scsi/arcmsr/arcmsr_hba.c b/drivers/scsi/arcmsr/arcmsr_hba.c
index d3fb8a9c1c39..baa03ead75d9 100644
--- a/drivers/scsi/arcmsr/arcmsr_hba.c
+++ b/drivers/scsi/arcmsr/arcmsr_hba.c
@@ -111,7 +111,7 @@ static int arcmsr_iop_message_xfer(struct AdapterControlBlock *acb,
 					struct scsi_cmnd *cmd);
 static int arcmsr_iop_confirm(struct AdapterControlBlock *acb);
 static int arcmsr_abort(struct scsi_cmnd *);
-static int arcmsr_bus_reset(struct scsi_cmnd *);
+static int arcmsr_bus_reset(struct Scsi_Host *, int);
 static int arcmsr_bios_param(struct scsi_device *sdev,
 		struct block_device *bdev, sector_t capacity, int *info);
 static int arcmsr_queue_command(struct Scsi_Host *h, struct scsi_cmnd *cmd);
@@ -4573,12 +4573,12 @@ static uint8_t arcmsr_iop_reset(struct AdapterControlBlock *acb)
 	return rtnval;
 }
 
-static int arcmsr_bus_reset(struct scsi_cmnd *cmd)
+static int arcmsr_bus_reset(struct Scsi_Host *shost, int channel)
 {
 	struct AdapterControlBlock *acb;
 	int retry_count = 0;
 	int rtn = FAILED;
-	acb = (struct AdapterControlBlock *) cmd->device->host->hostdata;
+	acb = (struct AdapterControlBlock *) shost->hostdata;
 	if (acb->acb_flags & ACB_F_ADAPTER_REMOVED)
 		return SUCCESS;
 	pr_notice("arcmsr: executing bus reset eh.....num_resets = %d,"
diff --git a/drivers/scsi/arm/fas216.c b/drivers/scsi/arm/fas216.c
index 38eec967155d..c27b49c42c4f 100644
--- a/drivers/scsi/arm/fas216.c
+++ b/drivers/scsi/arm/fas216.c
@@ -2550,15 +2550,16 @@ int fas216_eh_device_reset(struct scsi_cmnd *SCpnt)
 
 /**
  * fas216_eh_bus_reset - Reset the bus associated with the command
- * @SCpnt: command specifing bus to reset
+ * @shost: host to be reset
+ * @channel: bus number to reset
  *
- * Reset the bus associated with the command.
+ * Reset the bus.
  * Returns: FAILED if unable to reset.
  * Notes: Further commands are blocked.
  */
-int fas216_eh_bus_reset(struct scsi_cmnd *SCpnt)
+int fas216_eh_bus_reset(struct Scsi_Host *shost, int channel)
 {
-	FAS216_Info *info = (FAS216_Info *)SCpnt->device->host->hostdata;
+	FAS216_Info *info = (FAS216_Info *)shost->hostdata;
 	unsigned long flags;
 	struct scsi_device *SDpnt;
 
diff --git a/drivers/scsi/arm/fas216.h b/drivers/scsi/arm/fas216.h
index f17583f143b3..27a4b564f054 100644
--- a/drivers/scsi/arm/fas216.h
+++ b/drivers/scsi/arm/fas216.h
@@ -389,10 +389,11 @@ extern int fas216_eh_device_reset(struct scsi_cmnd *SCpnt);
 
 /* Function: int fas216_eh_bus_reset(struct scsi_cmnd *SCpnt)
  * Purpose : Reset the complete bus associated with this command
- * Params  : SCpnt - command specifing bus to reset
+ * Params  : shost - host to be reset
+ *           channel - bus to be reset
  * Returns : FAILED if unable to reset
  */
-extern int fas216_eh_bus_reset(struct scsi_cmnd *SCpnt);
+extern int fas216_eh_bus_reset(struct Scsi_Host *shost, int channel);
 
 /* Function: int fas216_eh_host_reset(struct Scsi_Host *shost)
  * Purpose : Reset the host associated with this command
diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index 67a89715c863..7374eda8cffa 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -1144,19 +1144,18 @@ static void reset_dev_param(struct AdapterCtlBlk *acb)
  * @cmd - some command for this host (for fetching hooks)
  * Returns: SUCCESS (0x2002) on success, else FAILED (0x2003).
  */
-static int __dc395x_eh_bus_reset(struct scsi_cmnd *cmd)
+static int __dc395x_eh_bus_reset(struct Scsi_Host *shost, int channel)
 {
 	struct AdapterCtlBlk *acb =
-		(struct AdapterCtlBlk *)cmd->device->host->hostdata;
+		(struct AdapterCtlBlk *)shost->hostdata;
 	dprintkl(KERN_INFO,
-		"eh_bus_reset: (0%p) target=<%02i-%i> cmd=%p\n",
-		cmd, cmd->device->id, (u8)cmd->device->lun, cmd);
+		 "eh_bus_reset: bus=<%02i>\n", channel);
 
 	if (timer_pending(&acb->waiting_timer))
 		del_timer(&acb->waiting_timer);
 
 	/*
-	 * disable interrupt    
+	 * disable interrupt
 	 */
 	DC395x_write8(acb, TRM_S1040_DMA_INTEN, 0x00);
 	DC395x_write8(acb, TRM_S1040_SCSI_INTEN, 0x00);
@@ -1172,7 +1171,7 @@ static int __dc395x_eh_bus_reset(struct scsi_cmnd *cmd)
 	    HZ * acb->eeprom.delay_time;
 
 	/*
-	 * re-enable interrupt      
+	 * re-enable interrupt
 	 */
 	/* Clear SCSI FIFO          */
 	DC395x_write8(acb, TRM_S1040_DMA_CONTROL, CLRXFIFO);
@@ -1182,7 +1181,7 @@ static int __dc395x_eh_bus_reset(struct scsi_cmnd *cmd)
 	set_basic_config(acb);
 
 	reset_dev_param(acb);
-	doing_srb_done(acb, DID_RESET, cmd, 0);
+	doing_srb_done(acb, DID_RESET, NULL, 0);
 	acb->active_dcb = NULL;
 	acb->acb_flag = 0;	/* RESET_DETECT, RESET_DONE ,RESET_DEV */
 	waiting_process_next(acb);
@@ -1190,13 +1189,13 @@ static int __dc395x_eh_bus_reset(struct scsi_cmnd *cmd)
 	return SUCCESS;
 }
 
-static int dc395x_eh_bus_reset(struct scsi_cmnd *cmd)
+static int dc395x_eh_bus_reset(struct Scsi_Host *shost, int channel)
 {
 	int rc;
 
-	spin_lock_irq(cmd->device->host->host_lock);
-	rc = __dc395x_eh_bus_reset(cmd);
-	spin_unlock_irq(cmd->device->host->host_lock);
+	spin_lock_irq(shost->host_lock);
+	rc = __dc395x_eh_bus_reset(shost, channel);
+	spin_unlock_irq(shost->host_lock);
 
 	return rc;
 }
@@ -3338,7 +3337,7 @@ static void srb_done(struct AdapterCtlBlk *acb, struct DeviceCtlBlk *dcb,
 
 /* abort all cmds in our queues */
 static void doing_srb_done(struct AdapterCtlBlk *acb, u8 did_flag,
-		struct scsi_cmnd *cmd, u8 force)
+			   struct scsi_cmnd *cmd, u8 force)
 {
 	struct DeviceCtlBlk *dcb;
 	dprintkl(KERN_INFO, "doing_srb_done: pids ");
@@ -3386,7 +3385,7 @@ static void doing_srb_done(struct AdapterCtlBlk *acb, u8 did_flag,
 			set_status_byte(p, SAM_STAT_GOOD);
 			pci_unmap_srb_sense(acb, srb);
 			pci_unmap_srb(acb, srb);
-			if (force) {
+			if (force && cmd) {
 				/* For new EH, we normally don't need to give commands back,
 				 * as they all complete or all time out */
 				scsi_done(cmd);
diff --git a/drivers/scsi/dpt_i2o.c b/drivers/scsi/dpt_i2o.c
index 6e3ad0e5b533..b1ab772aff0e 100644
--- a/drivers/scsi/dpt_i2o.c
+++ b/drivers/scsi/dpt_i2o.c
@@ -718,17 +718,18 @@ static int adpt_device_reset(struct scsi_cmnd* cmd)
 
 #define I2O_HBA_BUS_RESET 0x87
 // This version of bus reset is called by the eh_error handler
-static int adpt_bus_reset(struct scsi_cmnd* cmd)
+static int adpt_bus_reset(struct Scsi_Host *shost, int channel)
 {
 	adpt_hba* pHba;
 	u32 msg[4];
 	u32 rcode;
 
-	pHba = (adpt_hba*)cmd->device->host->hostdata[0];
+	pHba = (adpt_hba*)shost->hostdata[0];
 	memset(msg, 0, sizeof(msg));
-	printk(KERN_WARNING"%s: Bus reset: SCSI Bus %d: tid: %d\n",pHba->name, cmd->device->channel,pHba->channel[cmd->device->channel].tid );
+	printk(KERN_WARNING"%s: Bus reset: SCSI Bus %d: tid: %d\n",
+	       pHba->name, channel, pHba->channel[channel].tid );
 	msg[0] = FOUR_WORD_MSG_SIZE|SGL_OFFSET_0;
-	msg[1] = (I2O_HBA_BUS_RESET<<24|HOST_TID<<12|pHba->channel[cmd->device->channel].tid);
+	msg[1] = (I2O_HBA_BUS_RESET<<24|HOST_TID<<12|pHba->channel[channel].tid);
 	msg[2] = 0;
 	msg[3] = 0;
 	if (pHba->host)
diff --git a/drivers/scsi/dpti.h b/drivers/scsi/dpti.h
index b77a3625fa6f..48878e69ab2c 100644
--- a/drivers/scsi/dpti.h
+++ b/drivers/scsi/dpti.h
@@ -35,7 +35,7 @@ static const char *adpt_info(struct Scsi_Host *pSHost);
 static int adpt_bios_param(struct scsi_device * sdev, struct block_device *dev,
 		sector_t, int geom[]);
 
-static int adpt_bus_reset(struct scsi_cmnd* cmd);
+static int adpt_bus_reset(struct Scsi_Host* shost, int channel);
 static int adpt_device_reset(struct scsi_cmnd* cmd);
 
 
diff --git a/drivers/scsi/esas2r/esas2r.h b/drivers/scsi/esas2r/esas2r.h
index a104d1a3a9da..5c1eeaffc090 100644
--- a/drivers/scsi/esas2r/esas2r.h
+++ b/drivers/scsi/esas2r/esas2r.h
@@ -977,7 +977,7 @@ long esas2r_proc_ioctl(struct file *fp, unsigned int cmd, unsigned long arg);
 int esas2r_eh_abort(struct scsi_cmnd *cmd);
 int esas2r_device_reset(struct scsi_cmnd *cmd);
 int esas2r_host_reset(struct Scsi_Host *shost);
-int esas2r_bus_reset(struct scsi_cmnd *cmd);
+int esas2r_bus_reset(struct Scsi_Host *shost, int channel);
 int esas2r_target_reset(struct scsi_cmnd *cmd);
 
 /* Internal functions */
diff --git a/drivers/scsi/esas2r/esas2r_main.c b/drivers/scsi/esas2r/esas2r_main.c
index 52494c8bb656..315b8a61d0d7 100644
--- a/drivers/scsi/esas2r/esas2r_main.c
+++ b/drivers/scsi/esas2r/esas2r_main.c
@@ -1094,10 +1094,8 @@ int esas2r_host_reset(struct Scsi_Host *shost)
 	return esas2r_host_bus_reset(shost, true);
 }
 
-int esas2r_bus_reset(struct scsi_cmnd *cmd)
+int esas2r_bus_reset(struct Scsi_Host *shost, int channel)
 {
-	struct Scsi_Host *shost = cmd->device->host;
-
 	esas2r_log(ESAS2R_LOG_INFO, "bus_reset (%p)", shost);
 
 	return esas2r_host_bus_reset(shost, false);
diff --git a/drivers/scsi/esp_scsi.c b/drivers/scsi/esp_scsi.c
index b41eac8b5e0f..2fa53100df24 100644
--- a/drivers/scsi/esp_scsi.c
+++ b/drivers/scsi/esp_scsi.c
@@ -2604,9 +2604,9 @@ static int esp_eh_abort_handler(struct scsi_cmnd *cmd)
 	return FAILED;
 }
 
-static int esp_eh_bus_reset_handler(struct scsi_cmnd *cmd)
+static int esp_eh_bus_reset_handler(struct Scsi_Host *shost, int channel)
 {
-	struct esp *esp = shost_priv(cmd->device->host);
+	struct esp *esp = shost_priv(shost);
 	struct completion eh_reset;
 	unsigned long flags;
 
diff --git a/drivers/scsi/initio.c b/drivers/scsi/initio.c
index f585d6e5fab9..adddedfdbcc7 100644
--- a/drivers/scsi/initio.c
+++ b/drivers/scsi/initio.c
@@ -2625,20 +2625,21 @@ static DEF_SCSI_QCMD(i91u_queuecommand)
 
 /**
  *	i91u_bus_reset		-	reset the SCSI bus
- *	@cmnd: Command block we want to trigger the reset for
+ *	@shost: SCSI host to be reset
+ *	@channel: Bus number to be reset
  *
  *	Initiate a SCSI bus reset sequence
  */
 
-static int i91u_bus_reset(struct scsi_cmnd * cmnd)
+static int i91u_bus_reset(struct Scsi_Host * shost, int channel)
 {
 	struct initio_host *host;
 
-	host = (struct initio_host *) cmnd->device->host->hostdata;
+	host = (struct initio_host *) shost->hostdata;
 
-	spin_lock_irq(cmnd->device->host->host_lock);
+	spin_lock_irq(shost->host_lock);
 	initio_reset_scsi(host, 0);
-	spin_unlock_irq(cmnd->device->host->host_lock);
+	spin_unlock_irq(shost->host_lock);
 
 	return SUCCESS;
 }
diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
index bd42d3a56590..88fbd01c05d0 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_os.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
@@ -3362,39 +3362,46 @@ static int mpi3mr_eh_host_reset(struct Scsi_Host *shost)
 
 /**
  * mpi3mr_eh_bus_reset - Bus reset error handling callback
- * @scmd: SCSI command reference
+ * @shost: SCSI host reference
+ * @channel: bus number
  *
  * Checks whether pending I/Os are present for the RAID volume;
  * if not there's no need to reset the adapter.
  *
  * Return: SUCCESS of successful reset else FAILED
  */
-static int mpi3mr_eh_bus_reset(struct scsi_cmnd *scmd)
+static int mpi3mr_eh_bus_reset(struct Scsi_Host *shost, int channel)
 {
-	struct mpi3mr_ioc *mrioc = shost_priv(scmd->device->host);
+	struct mpi3mr_ioc *mrioc = shost_priv(shost);
+	struct mpi3mr_tgt_dev *tgtdev;
 	struct mpi3mr_stgt_priv_data *stgt_priv_data;
-	struct mpi3mr_sdev_priv_data *sdev_priv_data;
-	u8 dev_type = MPI3_DEVICE_DEVFORM_VD;
 	int retval = FAILED;
 
-	sdev_priv_data = scmd->device->hostdata;
-	if (sdev_priv_data && sdev_priv_data->tgt_priv_data) {
-		stgt_priv_data = sdev_priv_data->tgt_priv_data;
-		dev_type = stgt_priv_data->dev_type;
+	spin_lock(&mrioc->tgtdev_lock);
+	list_for_each_entry(tgtdev, &mrioc->tgtdev_list, list) {
+		if (!tgtdev->starget || !tgtdev->starget->hostdata)
+			continue;
+		stgt_priv_data = (struct mpi3mr_stgt_priv_data *)
+			tgtdev->starget->hostdata;
+		if (stgt_priv_data->dev_type == MPI3_DEVICE_DEVFORM_VD) {
+			retval = SUCCESS;
+			break;
+		}
 	}
+	spin_unlock(&mrioc->tgtdev_lock);
 
-	if (dev_type == MPI3_DEVICE_DEVFORM_VD) {
+	if (retval == SUCCESS) {
 		mpi3mr_wait_for_host_io(mrioc,
 			MPI3MR_RAID_ERRREC_RESET_TIMEOUT);
-		if (!mpi3mr_get_fw_pending_ios(mrioc))
-			retval = SUCCESS;
+		if (mpi3mr_get_fw_pending_ios(mrioc))
+			retval = FAILED;
 	}
 	if (retval == FAILED)
 		mpi3mr_print_pending_host_io(mrioc);
 
-	sdev_printk(KERN_INFO, scmd->device,
-		"Bus reset is %s for scmd(%p)\n",
-		((retval == SUCCESS) ? "SUCCESS" : "FAILED"), scmd);
+	shost_printk(KERN_INFO, shost,
+		"Bus reset is %s\n",
+		((retval == SUCCESS) ? "SUCCESS" : "FAILED"));
 	return retval;
 }
 
diff --git a/drivers/scsi/ncr53c8xx.c b/drivers/scsi/ncr53c8xx.c
index 4458449c960b..2d4470686a4b 100644
--- a/drivers/scsi/ncr53c8xx.c
+++ b/drivers/scsi/ncr53c8xx.c
@@ -7936,9 +7936,9 @@ static void ncr53c8xx_timeout(struct timer_list *t)
 		ncr_flush_done_cmds(done_list);
 }
 
-static int ncr53c8xx_bus_reset(struct scsi_cmnd *cmd)
+static int ncr53c8xx_bus_reset(struct Scsi_Host *host, int channel)
 {
-	struct ncb *np = ((struct host_data *) cmd->device->host->hostdata)->ncb;
+	struct ncb *np = ((struct host_data *) host->hostdata)->ncb;
 	int sts;
 	unsigned long flags;
 	struct scsi_cmnd *done_list;
diff --git a/drivers/scsi/pcmcia/nsp_cs.c b/drivers/scsi/pcmcia/nsp_cs.c
index 4aa9737fa711..b1bce76c83b9 100644
--- a/drivers/scsi/pcmcia/nsp_cs.c
+++ b/drivers/scsi/pcmcia/nsp_cs.c
@@ -1488,11 +1488,11 @@ static int nsp_bus_reset(nsp_hw_data *data)
 	return SUCCESS;
 }
 
-static int nsp_eh_bus_reset(struct scsi_cmnd *SCpnt)
+static int nsp_eh_bus_reset(struct Scsi_Host *host, int channel)
 {
-	nsp_hw_data *data = (nsp_hw_data *)SCpnt->device->host->hostdata;
+	nsp_hw_data *data = (nsp_hw_data *)host->hostdata;
 
-	nsp_dbg(NSP_DEBUG_BUSRESET, "SCpnt=0x%p", SCpnt);
+	nsp_dbg(NSP_DEBUG_BUSRESET, "channel=0x%d", channel);
 
 	return nsp_bus_reset(data);
 }
diff --git a/drivers/scsi/pcmcia/nsp_cs.h b/drivers/scsi/pcmcia/nsp_cs.h
index f532adb5f166..8636f0053c02 100644
--- a/drivers/scsi/pcmcia/nsp_cs.h
+++ b/drivers/scsi/pcmcia/nsp_cs.h
@@ -299,7 +299,7 @@ static int nsp_queuecommand(struct Scsi_Host *h, struct scsi_cmnd *SCpnt);
 /* Error handler */
 /*static int nsp_eh_abort       (struct scsi_cmnd *SCpnt);*/
 /*static int nsp_eh_device_reset(struct scsi_cmnd *SCpnt);*/
-static int nsp_eh_bus_reset    (struct scsi_cmnd *SCpnt);
+static int nsp_eh_bus_reset    (struct Scsi_Host *host, int channel);
 static int nsp_eh_host_reset   (struct Scsi_Host *host);
 static int nsp_bus_reset       (nsp_hw_data *data);
 
diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index 79ca737ac75b..14e90807d38c 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -3023,9 +3023,8 @@ static int pmcraid_eh_device_reset_handler(struct scsi_cmnd *scmd)
 				    RESET_DEVICE_LUN);
 }
 
-static int pmcraid_eh_bus_reset_handler(struct scsi_cmnd *scmd)
+static int pmcraid_eh_bus_reset_handler(struct Scsi_Host *host, int channel)
 {
-	struct Scsi_Host *host = scmd->device->host;
 	struct pmcraid_instance *pinstance =
 		(struct pmcraid_instance *)host->hostdata;
 	struct pmcraid_resource_entry *res = NULL;
@@ -3039,11 +3038,11 @@ static int pmcraid_eh_bus_reset_handler(struct scsi_cmnd *scmd)
 	 */
 	spin_lock_irqsave(&pinstance->resource_lock, lock_flags);
 	list_for_each_entry(temp, &pinstance->used_res_q, queue) {
-		if (scmd->device->channel == PMCRAID_VSET_BUS_ID &&
+		if (channel == PMCRAID_VSET_BUS_ID &&
 		    RES_IS_VSET(temp->cfg_entry)) {
 			res = temp;
 			break;
-		} else if (scmd->device->channel == PMCRAID_PHYS_BUS_ID &&
+		} else if (channel == PMCRAID_PHYS_BUS_ID &&
 			   RES_IS_GSCSI(temp->cfg_entry)) {
 			res = temp;
 			break;
diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
index cd4c7126c1c9..f32f00c7a390 100644
--- a/drivers/scsi/qla1280.c
+++ b/drivers/scsi/qla1280.c
@@ -979,13 +979,15 @@ qla1280_eh_device_reset(struct scsi_cmnd *cmd)
  *     Reset the specified bus.
  **************************************************************************/
 static int
-qla1280_eh_bus_reset(struct scsi_cmnd *cmd)
+qla1280_eh_bus_reset(struct Scsi_Host *shost, int bus)
 {
-	int rc;
+	int rc = FAILED;
+	struct scsi_qla_host *ha = (struct scsi_qla_host *)shost->hostdata;
 
-	spin_lock_irq(cmd->device->host->host_lock);
-	rc = qla1280_error_action(cmd, BUS_RESET);
-	spin_unlock_irq(cmd->device->host->host_lock);
+	spin_lock_irq(shost->host_lock);
+	if (qla1280_bus_reset(ha, bus) == 0)
+		rc = qla1280_wait_for_pending_commands(ha, 1, 0);
+	spin_unlock_irq(shost->host_lock);
 
 	return rc;
 }
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 5f86e7bd5a0e..11e7dc22b94d 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -1537,7 +1537,7 @@ qla2xxx_eh_target_reset(struct scsi_cmnd *cmd)
 *    commands.
 *
 * Input:
-*    cmd = Linux SCSI command packet of the command that cause the
+*    host = Linux SCSI command packet of the command that cause the
 *          bus reset.
 *
 * Returns:
@@ -1545,12 +1545,10 @@ qla2xxx_eh_target_reset(struct scsi_cmnd *cmd)
 *
 **************************************************************************/
 static int
-qla2xxx_eh_bus_reset(struct scsi_cmnd *cmd)
+qla2xxx_eh_bus_reset(struct Scsi_Host *shost, int channel)
 {
-	scsi_qla_host_t *vha = shost_priv(cmd->device->host);
+	scsi_qla_host_t *vha = shost_priv(shost);
 	int ret = FAILED;
-	unsigned int id;
-	uint64_t lun;
 	struct qla_hw_data *ha = vha->hw;
 
 	if (qla2x00_isp_reg_stat(ha)) {
@@ -1560,14 +1558,11 @@ qla2xxx_eh_bus_reset(struct scsi_cmnd *cmd)
 		return FAILED;
 	}
 
-	id = cmd->device->id;
-	lun = cmd->device->lun;
-
 	if (qla2x00_chip_is_down(vha))
 		return ret;
 
 	ql_log(ql_log_info, vha, 0x8012,
-	    "BUS RESET ISSUED nexus=%ld:%d:%llu.\n", vha->host_no, id, lun);
+	    "BUS RESET ISSUED nexus=%ld:%d.\n", vha->host_no, channel);
 
 	if (qla2x00_wait_for_hba_online(vha) != QLA_SUCCESS) {
 		ql_log(ql_log_fatal, vha, 0x8013,
@@ -1591,8 +1586,8 @@ qla2xxx_eh_bus_reset(struct scsi_cmnd *cmd)
 
 eh_bus_reset_done:
 	ql_log(ql_log_warn, vha, 0x802b,
-	    "BUS RESET %s nexus=%ld:%d:%llu.\n",
-	    (ret == FAILED) ? "FAILED" : "SUCCEEDED", vha->host_no, id, lun);
+	    "BUS RESET %s nexus=%ld:%d.\n",
+	    (ret == FAILED) ? "FAILED" : "SUCCEEDED", vha->host_no, channel);
 
 	return ret;
 }
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 6292ac7aef7a..f2d3271bc80b 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -5324,36 +5324,27 @@ static int scsi_debug_target_reset(struct scsi_cmnd *SCpnt)
 	return SUCCESS;
 }
 
-static int scsi_debug_bus_reset(struct scsi_cmnd *SCpnt)
+static int scsi_debug_bus_reset(struct Scsi_Host * hp, int channel)
 {
-	struct sdebug_host_info *sdbg_host;
+	struct sdebug_host_info *sdbg_host =
+		*(struct sdebug_host_info **)shost_priv(hp);
 	struct sdebug_dev_info *devip;
-	struct scsi_device *sdp;
-	struct Scsi_Host *hp;
 	int k = 0;
 
 	++num_bus_resets;
-	if (!(SCpnt && SCpnt->device))
-		goto lie;
-	sdp = SCpnt->device;
 	if (SDEBUG_OPT_ALL_NOISE & sdebug_opts)
-		sdev_printk(KERN_INFO, sdp, "%s\n", __func__);
-	hp = sdp->host;
-	if (hp) {
-		sdbg_host = *(struct sdebug_host_info **)shost_priv(hp);
-		if (sdbg_host) {
-			list_for_each_entry(devip,
-					    &sdbg_host->dev_info_list,
-					    dev_list) {
-				set_bit(SDEBUG_UA_BUS_RESET, devip->uas_bm);
-				++k;
-			}
+		shost_printk(KERN_INFO, hp, "%s\n", __func__);
+	if (sdbg_host) {
+		list_for_each_entry(devip,
+				    &sdbg_host->dev_info_list,
+				    dev_list) {
+			set_bit(SDEBUG_UA_BUS_RESET, devip->uas_bm);
+			++k;
 		}
 	}
 	if (SDEBUG_OPT_RESET_NOISE & sdebug_opts)
-		sdev_printk(KERN_INFO, sdp,
+		shost_printk(KERN_INFO, hp,
 			    "%s: %d device(s) found in host\n", __func__, k);
-lie:
 	return SUCCESS;
 }
 
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 747131ca8970..148cab3e61c0 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -871,7 +871,7 @@ static enum scsi_disposition scsi_try_bus_reset(struct scsi_cmnd *scmd)
 	if (!hostt->eh_bus_reset_handler)
 		return FAILED;
 
-	rtn = hostt->eh_bus_reset_handler(scmd);
+	rtn = hostt->eh_bus_reset_handler(host, scmd_channel(scmd));
 
 	if (rtn == SUCCESS) {
 		if (!hostt->skip_settle_delay)
diff --git a/drivers/scsi/sym53c8xx_2/sym_glue.c b/drivers/scsi/sym53c8xx_2/sym_glue.c
index a573baa5bdf2..aef828731995 100644
--- a/drivers/scsi/sym53c8xx_2/sym_glue.c
+++ b/drivers/scsi/sym53c8xx_2/sym_glue.c
@@ -670,14 +670,13 @@ static int sym53c8xx_eh_target_reset_handler(struct scsi_cmnd *cmd)
 	return SCSI_SUCCESS;
 }
 
-static int sym53c8xx_eh_bus_reset_handler(struct scsi_cmnd *cmd)
+static int sym53c8xx_eh_bus_reset_handler(struct Scsi_Host *shost, int channel)
 {
-	struct Scsi_Host *shost = cmd->device->host;
 	struct sym_data *sym_data = shost_priv(shost);
 	struct pci_dev *pdev = sym_data->pdev;
 	struct sym_hcb *np = sym_data->ncb;
 
-	scmd_printk(KERN_WARNING, cmd, "BUS RESET operation started\n");
+	shost_printk(KERN_WARNING, shost, "BUS RESET operation started\n");
 
 	/*
 	 * Escalate to host reset if the PCI bus went down
@@ -689,7 +688,7 @@ static int sym53c8xx_eh_bus_reset_handler(struct scsi_cmnd *cmd)
 	sym_reset_scsi_bus(np, 1);
 	spin_unlock_irq(shost->host_lock);
 
-	dev_warn(&cmd->device->sdev_gendev, "BUS RESET operation complete.\n");
+	shost_printk(KERN_WARNING, shost, "BUS RESET operation complete.\n");
 	return SCSI_SUCCESS;
 }
 
diff --git a/drivers/scsi/vmw_pvscsi.c b/drivers/scsi/vmw_pvscsi.c
index ddf1837babc0..9c62d446ea9e 100644
--- a/drivers/scsi/vmw_pvscsi.c
+++ b/drivers/scsi/vmw_pvscsi.c
@@ -947,13 +947,12 @@ static int pvscsi_host_reset(struct Scsi_Host *host)
 	return SUCCESS;
 }
 
-static int pvscsi_bus_reset(struct scsi_cmnd *cmd)
+static int pvscsi_bus_reset(struct Scsi_Host *host, int channel)
 {
-	struct Scsi_Host *host = cmd->device->host;
 	struct pvscsi_adapter *adapter = shost_priv(host);
 	unsigned long flags;
 
-	scmd_printk(KERN_INFO, cmd, "SCSI Bus reset\n");
+	shost_printk(KERN_INFO, host, "SCSI Bus reset\n");
 
 	/*
 	 * We don't want to queue new requests for this bus after
diff --git a/drivers/scsi/wd719x.c b/drivers/scsi/wd719x.c
index 02b8eb153944..fd297c7517cd 100644
--- a/drivers/scsi/wd719x.c
+++ b/drivers/scsi/wd719x.c
@@ -484,11 +484,11 @@ static int wd719x_abort(struct scsi_cmnd *cmd)
 	return SUCCESS;
 }
 
-static int wd719x_reset(struct scsi_cmnd *cmd, u8 opcode, u8 device)
+static int wd719x_reset(struct Scsi_Host *shost, u8 opcode, u8 device)
 {
 	int result;
 	unsigned long flags;
-	struct wd719x *wd = shost_priv(cmd->device->host);
+	struct wd719x *wd = shost_priv(shost);
 	struct wd719x_scb *scb, *tmp;
 
 	dev_info(&wd->pdev->dev, "%s reset requested\n",
@@ -512,12 +512,13 @@ static int wd719x_reset(struct scsi_cmnd *cmd, u8 opcode, u8 device)
 
 static int wd719x_dev_reset(struct scsi_cmnd *cmd)
 {
-	return wd719x_reset(cmd, WD719X_CMD_RESET, cmd->device->id);
+	return wd719x_reset(cmd->device->host, WD719X_CMD_RESET,
+			    cmd->device->id);
 }
 
-static int wd719x_bus_reset(struct scsi_cmnd *cmd)
+static int wd719x_bus_reset(struct Scsi_Host *host, int channel)
 {
-	return wd719x_reset(cmd, WD719X_CMD_BUSRESET, 0);
+	return wd719x_reset(host, WD719X_CMD_BUSRESET, 0);
 }
 
 static int wd719x_host_reset(struct Scsi_Host *host)
diff --git a/drivers/staging/unisys/visorhba/visorhba_main.c b/drivers/staging/unisys/visorhba/visorhba_main.c
index 0de0dd09cf9d..28c59218077d 100644
--- a/drivers/staging/unisys/visorhba/visorhba_main.c
+++ b/drivers/staging/unisys/visorhba/visorhba_main.c
@@ -366,14 +366,15 @@ static int visorhba_device_reset_handler(struct scsi_cmnd *scsicmd)
  *
  * Return: SUCCESS if inserted, FAILED otherwise
  */
-static int visorhba_bus_reset_handler(struct scsi_cmnd *scsicmd)
+static int visorhba_bus_reset_handler(struct Scsi_Host *scsihost, int channel)
 {
 	struct scsi_device *scsidev;
 	struct visordisk_info *vdisk;
 	int rtn;
 
-	scsidev = scsicmd->device;
-	shost_for_each_device(scsidev, scsidev->host) {
+	shost_for_each_device(scsidev, scsihost) {
+		if (scsidev->channel != channel)
+			continue;
 		vdisk = scsidev->hostdata;
 		if (atomic_read(&vdisk->error_count) < VISORHBA_ERROR_COUNT)
 			atomic_inc(&vdisk->error_count);
diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
index 8931df5a85fd..17dabfba6b2b 100644
--- a/drivers/usb/storage/scsiglue.c
+++ b/drivers/usb/storage/scsiglue.c
@@ -464,9 +464,9 @@ static int device_reset(struct scsi_cmnd *srb)
 }
 
 /* Simulate a SCSI bus reset by resetting the device's USB port. */
-static int bus_reset(struct scsi_cmnd *srb)
+static int bus_reset(struct Scsi_Host *shost, int channel)
 {
-	struct us_data *us = host_to_us(srb->device->host);
+	struct us_data *us = host_to_us(shost);
 	int result;
 
 	usb_stor_dbg(us, "%s called\n", __func__);
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 3b8d9e65ea57..73c9971e7334 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -140,7 +140,7 @@ struct scsi_host_template {
 	int (* eh_abort_handler)(struct scsi_cmnd *);
 	int (* eh_device_reset_handler)(struct scsi_cmnd *);
 	int (* eh_target_reset_handler)(struct scsi_cmnd *);
-	int (* eh_bus_reset_handler)(struct scsi_cmnd *);
+	int (* eh_bus_reset_handler)(struct Scsi_Host *, int);
 	int (* eh_host_reset_handler)(struct Scsi_Host *);
 
 	/*
-- 
2.29.2

