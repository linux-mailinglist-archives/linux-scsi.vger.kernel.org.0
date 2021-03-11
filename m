Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017F1337C3A
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Mar 2021 19:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhCKSOr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 11 Mar 2021 13:14:47 -0500
Received: from smtp.infotech.no ([82.134.31.41]:51100 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229811AbhCKSOg (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 11 Mar 2021 13:14:36 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 12D97204271;
        Thu, 11 Mar 2021 19:14:32 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NO4eeIsn8kxH; Thu, 11 Mar 2021 19:14:29 +0100 (CET)
Received: from xtwo70.bingwo.ca (host-45-58-219-4.dyn.295.ca [45.58.219.4])
        by smtp.infotech.no (Postfix) with ESMTPA id 7A94B204269;
        Thu, 11 Mar 2021 19:14:28 +0100 (CET)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        colin.king@canonical.com
Subject: [PATCH 2/4] sg: sg_remove_sfp_usercontext: remove NULL check
Date:   Thu, 11 Mar 2021 13:14:21 -0500
Message-Id: <20210311181423.137646-3-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210311181423.137646-1-dgilbert@interlog.com>
References: <20210311181423.137646-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The NULL check on sdp is useless as it has already been
de-referenced. sg_fd object without valid parent pointer
(sdp) should never occur.

Reported-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 7d4a0fd9ee32..77fec70b7c2f 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -3918,10 +3918,8 @@ sg_remove_sfp_usercontext(struct work_struct *work)
 	       o_count, sfp);
 	kfree(sfp);
 
-	if (sdp) {
-		scsi_device_put(sdp->device);
-		kref_put(&sdp->d_ref, sg_device_destroy);
-	}
+	scsi_device_put(sdp->device);
+	kref_put(&sdp->d_ref, sg_device_destroy);
 	module_put(THIS_MODULE);
 }
 
-- 
2.25.1

