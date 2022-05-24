Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2892A5322ED
	for <lists+linux-scsi@lfdr.de>; Tue, 24 May 2022 08:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234755AbiEXGQS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 24 May 2022 02:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbiEXGQN (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 24 May 2022 02:16:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B700FD28
        for <linux-scsi@vger.kernel.org>; Mon, 23 May 2022 23:16:12 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CB9F31F920;
        Tue, 24 May 2022 06:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653372970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8qKJBbif5ygTcs6ZfAghq7JqttecLOh1XuEENdq9MaE=;
        b=VTJPt5Ua2nRhPxuSgY0enlphZ/5vDWacMx//WvS9mEmJVmYrNeSoe14HgEcHupsIrhbNgn
        EYD8SlrdVpSHL5CRfC09gVnXxyyJ7y9BSJkUs01m4rwZhFy1izvPghRLIz5OQ8He/XRiBM
        3h6BANpGXUB6gmkwEpceyDHbJkdGkvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653372970;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8qKJBbif5ygTcs6ZfAghq7JqttecLOh1XuEENdq9MaE=;
        b=V/cDgxergdBbKjxeVb4V/2+BBqK2/eaR7GuW1Ds+D1i0UKvKN1b9aWw0bH0y5sA68/LfXu
        7/as2bCWMiekZCCQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 9EF8D2C145;
        Tue, 24 May 2022 06:16:10 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 92DD7519463E; Tue, 24 May 2022 08:16:10 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 03/16] mptfc: simplify mpt_fc_block_error_handler()
Date:   Tue, 24 May 2022 08:15:49 +0200
Message-Id: <20220524061602.86760-4-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220524061602.86760-1-hare@suse.de>
References: <20220524061602.86760-1-hare@suse.de>
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

Instead of passing the a function we can as well return a status
and call the function directly afterwards.

Signed-off-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/message/fusion/mptfc.c | 83 ++++++++++++++++++++++------------
 1 file changed, 54 insertions(+), 29 deletions(-)

diff --git a/drivers/message/fusion/mptfc.c b/drivers/message/fusion/mptfc.c
index fac747109209..ea8fc32dacfa 100644
--- a/drivers/message/fusion/mptfc.c
+++ b/drivers/message/fusion/mptfc.c
@@ -183,73 +183,98 @@ static struct fc_function_template mptfc_transport_functions = {
 };
 
 static int
-mptfc_block_error_handler(struct scsi_cmnd *SCpnt,
-			  int (*func)(struct scsi_cmnd *SCpnt),
-			  const char *caller)
+mptfc_block_error_handler(struct fc_rport *rport)
 {
 	MPT_SCSI_HOST		*hd;
-	struct scsi_device	*sdev = SCpnt->device;
-	struct Scsi_Host	*shost = sdev->host;
-	struct fc_rport		*rport = starget_to_rport(scsi_target(sdev));
+	struct Scsi_Host	*shost = rport_to_shost(rport);
 	unsigned long		flags;
 	int			ready;
-	MPT_ADAPTER 		*ioc;
+	MPT_ADAPTER		*ioc;
 	int			loops = 40;	/* seconds */
 
-	hd = shost_priv(SCpnt->device->host);
+	hd = shost_priv(shost);
 	ioc = hd->ioc;
 	spin_lock_irqsave(shost->host_lock, flags);
 	while ((ready = fc_remote_port_chkready(rport) >> 16) == DID_IMM_RETRY
 	 || (loops > 0 && ioc->active == 0)) {
 		spin_unlock_irqrestore(shost->host_lock, flags);
 		dfcprintk (ioc, printk(MYIOC_s_DEBUG_FMT
-			"mptfc_block_error_handler.%d: %d:%llu, port status is "
-			"%x, active flag %d, deferring %s recovery.\n",
+			"mptfc_block_error_handler.%d: %s, port status is "
+			"%x, active flag %d, deferring recovery.\n",
 			ioc->name, ioc->sh->host_no,
-			SCpnt->device->id, SCpnt->device->lun,
-			ready, ioc->active, caller));
+			dev_name(&rport->dev), ready, ioc->active));
 		msleep(1000);
 		spin_lock_irqsave(shost->host_lock, flags);
 		loops --;
 	}
 	spin_unlock_irqrestore(shost->host_lock, flags);
 
-	if (ready == DID_NO_CONNECT || !SCpnt->device->hostdata
-	 || ioc->active == 0) {
+	if (ready == DID_NO_CONNECT || ioc->active == 0) {
 		dfcprintk (ioc, printk(MYIOC_s_DEBUG_FMT
-			"%s.%d: %d:%llu, failing recovery, "
-			"port state %x, active %d, vdevice %p.\n", caller,
+			"mpt_block_error_handler.%d: %s, failing recovery, "
+			"port state %x, active %d.\n",
 			ioc->name, ioc->sh->host_no,
-			SCpnt->device->id, SCpnt->device->lun, ready,
-			ioc->active, SCpnt->device->hostdata));
+			dev_name(&rport->dev), ready, ioc->active));
 		return FAILED;
 	}
-	dfcprintk (ioc, printk(MYIOC_s_DEBUG_FMT
-		"%s.%d: %d:%llu, executing recovery.\n", caller,
-		ioc->name, ioc->sh->host_no,
-		SCpnt->device->id, SCpnt->device->lun));
-	return (*func)(SCpnt);
+	return SUCCESS;
 }
 
 static int
 mptfc_abort(struct scsi_cmnd *SCpnt)
 {
-	return
-	    mptfc_block_error_handler(SCpnt, mptscsih_abort, __func__);
+	struct Scsi_Host *shost = SCpnt->device->host;
+	struct fc_rport *rport = starget_to_rport(scsi_target(SCpnt->device));
+	MPT_SCSI_HOST __maybe_unused *hd = shost_priv(shost);
+	int rtn;
+
+	rtn = mptfc_block_error_handler(rport);
+	if (rtn == SUCCESS) {
+		dfcprintk (hd->ioc, printk(MYIOC_s_DEBUG_FMT
+			"%s.%d: %d:%llu, executing recovery.\n", __func__,
+			hd->ioc->name, shost->host_no,
+			SCpnt->device->id, SCpnt->device->lun));
+		rtn = mptscsih_abort(SCpnt);
+	}
+	return rtn;
 }
 
 static int
 mptfc_dev_reset(struct scsi_cmnd *SCpnt)
 {
-	return
-	    mptfc_block_error_handler(SCpnt, mptscsih_dev_reset, __func__);
+	struct Scsi_Host *shost = SCpnt->device->host;
+	struct fc_rport *rport = starget_to_rport(scsi_target(SCpnt->device));
+	MPT_SCSI_HOST __maybe_unused *hd = shost_priv(shost);
+	int rtn;
+
+	rtn = mptfc_block_error_handler(rport);
+	if (rtn == SUCCESS) {
+		dfcprintk (hd->ioc, printk(MYIOC_s_DEBUG_FMT
+			"%s.%d: %d:%llu, executing recovery.\n", __func__,
+			hd->ioc->name, shost->host_no,
+			SCpnt->device->id, SCpnt->device->lun));
+		rtn = mptscsih_dev_reset(SCpnt);
+	}
+	return rtn;
 }
 
 static int
 mptfc_bus_reset(struct scsi_cmnd *SCpnt)
 {
-	return
-	    mptfc_block_error_handler(SCpnt, mptscsih_bus_reset, __func__);
+	struct Scsi_Host *shost = SCpnt->device->host;
+	struct fc_rport *rport = starget_to_rport(scsi_target(SCpnt->device));
+	MPT_SCSI_HOST __maybe_unused *hd = shost_priv(shost);
+	int rtn;
+
+	rtn = mptfc_block_error_handler(rport);
+	if (rtn == SUCCESS) {
+		dfcprintk (hd->ioc, printk(MYIOC_s_DEBUG_FMT
+			"%s.%d: %d:%llu, executing recovery.\n", __func__,
+			hd->ioc->name, shost->host_no,
+			SCpnt->device->id, SCpnt->device->lun));
+		rtn = mptscsih_bus_reset(SCpnt);
+	}
+	return rtn;
 }
 
 static void
-- 
2.29.2

