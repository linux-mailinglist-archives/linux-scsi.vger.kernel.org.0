Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E86C524B2E
	for <lists+linux-scsi@lfdr.de>; Thu, 12 May 2022 13:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353083AbiELLNl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 12 May 2022 07:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353045AbiELLM6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 12 May 2022 07:12:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32AD63BE8
        for <linux-scsi@vger.kernel.org>; Thu, 12 May 2022 04:12:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 85A2B1F93D;
        Thu, 12 May 2022 11:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652353966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zIeY8oQMBTfmegoKFHThi/YAmdimxrERE/EraAB74Pc=;
        b=YLJyUeYjnO8BCRx7nGA3nSpNmKv8oHg+eNnG2edpuyXYNHYPHQupk/g+49y2nPGavgAzEn
        Is+8ewZihzl+xVtSj3DB5DRYh9aiWGdS66Qer2s5u6qs/E8QtjUI4OJp19r99jTy3a0BPa
        +PLYy0+BVWFQkmU6jj2GwMt3jQpAqVI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652353966;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zIeY8oQMBTfmegoKFHThi/YAmdimxrERE/EraAB74Pc=;
        b=FIUe5EZxvT61aSI3blD34e8Uzyv6I4dbtzh3TtEkqNMeQFsCgqLJBKPIs6tdTvYSNvKenr
        xeOO6r0Uzv+LhyCQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id 507F32C15B;
        Thu, 12 May 2022 11:12:46 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 1E1BC51943F0; Thu, 12 May 2022 13:12:46 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
        kernel test robot <lkp@intel.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 12/20] aic7xxx: make BUILD_SCSIID() a function
Date:   Thu, 12 May 2022 13:12:28 +0200
Message-Id: <20220512111236.109851-13-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220512111236.109851-1-hare@suse.de>
References: <20220512111236.109851-1-hare@suse.de>
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

Convert BUILD_SCSIID() into a function and add a scsi_device argument.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/scsi/aic7xxx/aic7xxx_osm.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/aic7xxx/aic7xxx_osm.c b/drivers/scsi/aic7xxx/aic7xxx_osm.c
index d3b1082654d5..15e53b33b955 100644
--- a/drivers/scsi/aic7xxx/aic7xxx_osm.c
+++ b/drivers/scsi/aic7xxx/aic7xxx_osm.c
@@ -798,11 +798,18 @@ struct scsi_host_template aic7xxx_driver_template = {
 
 /**************************** Tasklet Handler *********************************/
 
-/******************************** Macros **************************************/
-#define BUILD_SCSIID(ahc, cmd)						    \
-	((((cmd)->device->id << TID_SHIFT) & TID)			    \
-	| (((cmd)->device->channel == 0) ? (ahc)->our_id : (ahc)->our_id_b) \
-	| (((cmd)->device->channel == 0) ? 0 : TWIN_CHNLB))
+
+static inline unsigned int ahc_build_scsiid(struct ahc_softc *ahc,
+					    struct scsi_device *sdev)
+{
+	unsigned int scsiid = (sdev->id << TID_SHIFT) & TID;
+
+	if (sdev->channel == 0)
+		scsiid |= ahc->our_id;
+	else
+		scsiid |= ahc->our_id_b | TWIN_CHNLB;
+	return scsiid;
+}
 
 /******************************** Bus DMA *************************************/
 int
@@ -1457,7 +1464,7 @@ ahc_linux_run_command(struct ahc_softc *ahc, struct ahc_linux_device *dev,
 	 * Fill out basics of the HSCB.
 	 */
 	hscb->control = 0;
-	hscb->scsiid = BUILD_SCSIID(ahc, cmd);
+	hscb->scsiid = ahc_build_scsiid(ahc, cmd->device);
 	hscb->lun = cmd->device->lun;
 	mask = SCB_GET_TARGET_MASK(ahc, scb);
 	tinfo = ahc_fetch_transinfo(ahc, SCB_GET_CHANNEL(ahc, scb),
-- 
2.29.2

