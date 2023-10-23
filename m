Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AA37D2E3C
	for <lists+linux-scsi@lfdr.de>; Mon, 23 Oct 2023 11:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjJWJ2v (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 23 Oct 2023 05:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjJWJ2r (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 23 Oct 2023 05:28:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42EFBE
        for <linux-scsi@vger.kernel.org>; Mon, 23 Oct 2023 02:28:44 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2C3E621ACD;
        Mon, 23 Oct 2023 09:28:43 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id D4F362CF56;
        Mon, 23 Oct 2023 09:28:42 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id 0E99051EC352; Mon, 23 Oct 2023 11:28:43 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 08/10] scsi_error: iterate over list of failed commands in scsi_eh_bus_device_reset()
Date:   Mon, 23 Oct 2023 11:28:35 +0200
Message-Id: <20231023092837.33786-9-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231023092837.33786-1-hare@suse.de>
References: <20231023092837.33786-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        dmarc=none;
        spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor denied by domain of hare@suse.de) smtp.mailfrom=hare@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [5.49 / 50.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.20)[suse.de];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.60)[~all:c];
         RCPT_COUNT_FIVE(0.00)[5];
         TO_MATCH_ENVRCPT_SOME(0.00)[];
         VIOLATED_DIRECT_SPF(3.50)[];
         MX_GOOD(-0.01)[];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         BAYES_HAM(-0.00)[10.35%]
X-Spam-Score: 5.49
X-Rspamd-Queue-Id: 2C3E621ACD
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Iterating over all devices in scsi_eh_bus_device_reset() is
inefficient as not all devices may be affected during SCSI EH.
There also is no reason to open-code scsi_eh_test_devices()
as for FAST_IO_FAIL we really should just return the commands
without further ado.
So rewrite the loop in scsi_eh_bus_device_reset() to match the
loop in scsi_eh_target_reset() and scsi_eh_bus_reset().

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/scsi_error.c | 58 ++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 31 deletions(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 63b762d5d66f..7c655d08a305 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1570,54 +1570,50 @@ static int scsi_eh_bus_device_reset(struct Scsi_Host *shost,
 				    struct list_head *work_q,
 				    struct list_head *done_q)
 {
-	struct scsi_cmnd *scmd, *bdr_scmd, *next;
-	struct scsi_device *sdev;
-	enum scsi_disposition rtn;
+	struct scsi_cmnd *scmd, *next;
+	LIST_HEAD(tmp_list);
+	LIST_HEAD(check_list);
+
+	list_splice_init(work_q, &tmp_list);
+
+	while (!list_empty(&tmp_list)) {
+		struct scsi_device *sdev;
+		enum scsi_disposition rtn;
+
+		scmd = list_entry(tmp_list.next, struct scsi_cmnd, eh_entry);
+		sdev = scmd->device;
 
-	shost_for_each_device(sdev, shost) {
 		if (scsi_host_eh_past_deadline(shost)) {
+			/* push back on work queue for further processing */
+			list_splice_init(&check_list, work_q);
+			list_splice_init(&tmp_list, work_q);
 			SCSI_LOG_ERROR_RECOVERY(3,
 				sdev_printk(KERN_INFO, sdev,
 					    "%s: skip BDR, past eh deadline\n",
 					     current->comm));
-			scsi_device_put(sdev);
-			break;
+			return list_empty(work_q);
 		}
-		bdr_scmd = NULL;
-		list_for_each_entry(scmd, work_q, eh_entry)
-			if (scmd->device == sdev) {
-				bdr_scmd = scmd;
-				break;
-			}
-
-		if (!bdr_scmd)
-			continue;
-
 		SCSI_LOG_ERROR_RECOVERY(3,
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
-					    scsi_eh_action(scmd, rtn) != FAILED) {
-						set_host_byte(scmd, DID_RESET);
-						scsi_eh_finish_cmd(scmd, done_q);
-					}
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
+			else if (rtn == FAST_IO_FAIL) {
+				set_host_byte(scmd, DID_TRANSPORT_FAILFAST);
+				scsi_eh_finish_cmd(scmd, done_q);
+			}
 		}
 	}
 
-	return list_empty(work_q);
+	return scsi_eh_test_devices(&check_list, work_q, done_q, 0);
 }
 
 /**
-- 
2.35.3

