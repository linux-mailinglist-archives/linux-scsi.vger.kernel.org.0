Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9D8B3EE978
	for <lists+linux-scsi@lfdr.de>; Tue, 17 Aug 2021 11:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239336AbhHQJSL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 17 Aug 2021 05:18:11 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47748 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239388AbhHQJRV (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 17 Aug 2021 05:17:21 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F1D8020031;
        Tue, 17 Aug 2021 09:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1629191802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=REUvCDjGKDy6I/jUjHfIYSMuy1Fh5JzfD6YjKjh7N1w=;
        b=d6u53/ASZ4HGf6gRWKhGo7afkG8a5/vBmU26u+w0R+8Qgw2mSQdVMLp5/Z3ABgDdMv8PPN
        WU3UeE52/lA/ZyAvmbrsvqHI9vQDgrv1xLWcZ+pspX6uZiVHxEZTShv15ydaIREQFzO0vx
        8E0088SZ+Ken3TARUZ7k3uZ6W8NQpKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1629191802;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=REUvCDjGKDy6I/jUjHfIYSMuy1Fh5JzfD6YjKjh7N1w=;
        b=KyW6h1KM7BuZaSLniUTafke3U3X/nsGMDYstGx3wcvlujL2UBISiJGw1QHatbp7kNnmXE/
        oqgR3M3LXeU+t8Cw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
        by relay2.suse.de (Postfix) with ESMTP id EB8CAA3BC1;
        Tue, 17 Aug 2021 09:16:42 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
        id E8A84518CEC5; Tue, 17 Aug 2021 11:16:42 +0200 (CEST)
From:   Hannes Reinecke <hare@suse.de>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        James Bottomley <james.bottomley@hansenpartnership.com>,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>
Subject: [PATCH 51/51] scsi_error: streamline scsi_eh_bus_device_reset()
Date:   Tue, 17 Aug 2021 11:14:56 +0200
Message-Id: <20210817091456.73342-52-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210817091456.73342-1-hare@suse.de>
References: <20210817091456.73342-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Hannes Reinecke <hare@suse.com>

Streamline to use a similar code flow than the other reset functions.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/scsi/scsi_error.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 5cfff3fa306c..d4ab10113648 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1516,6 +1516,7 @@ static int scsi_eh_bus_device_reset(struct Scsi_Host *shost,
 {
 	struct scsi_cmnd *scmd, *bdr_scmd, *next;
 	struct scsi_device *sdev;
+	LIST_HEAD(check_list);
 	enum scsi_disposition rtn;
 
 	shost_for_each_device(sdev, shost) {
@@ -1541,27 +1542,22 @@ static int scsi_eh_bus_device_reset(struct Scsi_Host *shost,
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

