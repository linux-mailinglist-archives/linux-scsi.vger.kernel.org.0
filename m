Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067C15179A2
	for <lists+linux-scsi@lfdr.de>; Tue,  3 May 2022 00:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387816AbiEBWFC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 2 May 2022 18:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387758AbiEBWDf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 2 May 2022 18:03:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527A2640B
        for <linux-scsi@vger.kernel.org>; Mon,  2 May 2022 15:00:04 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D72A021875;
        Mon,  2 May 2022 22:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1651528800; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VcRSk9+B9bVk8pVZlHZAKrjmwD2iT6Wm4p5geMW8EVE=;
        b=ZBkP7z7rjDpLVVbD+S0yByjtQbBtjRX4Lw/fJZDDs9IOnKW4zBJCfpzcj5RPdpbCEsAQ/e
        SQuh7hpa6uyBfFTrVBEotBh9NfpE65fNgIi8YbOPRmW5QiCUy8d+DOZRjHNNNChtszxxeD
        lq7bO4tP3YJtozRsH1s0Y545a33kONA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1651528800;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VcRSk9+B9bVk8pVZlHZAKrjmwD2iT6Wm4p5geMW8EVE=;
        b=kMxVtgcIh/yM+XSzsyOxzECrV7Pg202ikaVRKIKRFK0wmX7MIF+RE5YsnAnBVPwvTT0NoX
        G2WkhFUuSiNSvRAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id D15B52C161;
        Mon,  2 May 2022 22:00:00 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id CF387519415C; Tue,  3 May 2022 00:00:00 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: [PATCH 7/7] scsi_error: streamline scsi_eh_bus_device_reset()
Date:   Mon,  2 May 2022 23:59:49 +0200
Message-Id: <20220502215953.5463-15-hare@suse.de>
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

From: Hannes Reinecke <hare@suse.com>

Streamline to use a similar code flow as the other reset functions.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/scsi_error.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index ad68149ab8a1..b2e70e262095 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1547,6 +1547,7 @@ static int scsi_eh_bus_device_reset(struct Scsi_Host *shost,
 {
 	struct scsi_cmnd *scmd, *bdr_scmd, *next;
 	struct scsi_device *sdev;
+	LIST_HEAD(check_list);
 	enum scsi_disposition rtn;
 
 	shost_for_each_device(sdev, shost) {
@@ -1572,27 +1573,22 @@ static int scsi_eh_bus_device_reset(struct Scsi_Host *shost,
 			sdev_printk(KERN_INFO, sdev,
 				     "%s: Sending BDR\n", current->comm));
 		rtn = scsi_try_bus_device_reset(sdev);
-		if (rtn == SUCCESS || rtn == FAST_IO_FAIL) {
-			if (!scsi_device_online(sdev) ||
-			    rtn == FAST_IO_FAIL ||
-			    !scsi_eh_tur(bdr_scmd)) {
-				list_for_each_entry_safe(scmd, next,
-							 work_q, eh_entry) {
-					if (scmd->device == sdev &&
-					    scsi_eh_action(scmd, rtn) != FAILED)
-						__scsi_eh_finish_cmd(scmd,
-								     done_q,
-								     DID_RESET);
-				}
-			}
-		} else {
+		if (rtn != SUCCESS && rtn != FAST_IO_FAIL)
 			SCSI_LOG_ERROR_RECOVERY(3,
 				sdev_printk(KERN_INFO, sdev,
 					    "%s: BDR failed\n", current->comm));
+		list_for_each_entry_safe(scmd, next, work_q, eh_entry) {
+			if (scmd->device != sdev)
+				continue;
+			if (rtn == SUCCESS)
+				list_move_tail(&scmd->eh_entry, &check_list);
+			else if (rtn == FAST_IO_FAIL)
+				__scsi_eh_finish_cmd(scmd, done_q,
+						     DID_TRANSPORT_DISRUPTED);
 		}
 	}
 
-	return list_empty(work_q);
+	return scsi_eh_test_devices(&check_list, work_q, done_q, 0);
 }
 
 /**
-- 
2.29.2

