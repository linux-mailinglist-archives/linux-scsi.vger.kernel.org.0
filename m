Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE1545CE61
	for <lists+linux-scsi@lfdr.de>; Tue,  2 Jul 2019 13:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfGBL1I (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 2 Jul 2019 07:27:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36318 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725835AbfGBL1I (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 2 Jul 2019 07:27:08 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4E65286677;
        Tue,  2 Jul 2019 11:27:08 +0000 (UTC)
Received: from manaslu.redhat.com (ovpn-204-182.brq.redhat.com [10.40.204.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98AE519C5B;
        Tue,  2 Jul 2019 11:27:06 +0000 (UTC)
From:   Maurizio Lombardi <mlombard@redhat.com>
To:     jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Subject: [PATCH] scsi: use scmd_printk() to print which command timed out
Date:   Tue,  2 Jul 2019 13:27:05 +0200
Message-Id: <20190702112705.30458-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 02 Jul 2019 11:27:08 +0000 (UTC)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

With a possibly faulty disk the following messages may appear in the logs:

kernel: sd 0:0:9:0: timing out command, waited 180s
kernel: sd 0:0:9:0: timing out command, waited 20s
kernel: sd 0:0:9:0: timing out command, waited 20s
kernel: sd 0:0:9:0: timing out command, waited 60s
kernel: sd 0:0:9:0: timing out command, waited 20s

This is not very informative because it's not possible to identify
the command that timed out.

This patch replaces sdev_printk() with scmd_printk().

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/scsi/scsi_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index f6437b98296b..97ed233fa469 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1501,7 +1501,7 @@ static void scsi_softirq_done(struct request *rq)
 	disposition = scsi_decide_disposition(cmd);
 	if (disposition != SUCCESS &&
 	    time_before(cmd->jiffies_at_alloc + wait_for, jiffies)) {
-		sdev_printk(KERN_ERR, cmd->device,
+		scmd_printk(KERN_ERR, cmd,
 			    "timing out command, waited %lus\n",
 			    wait_for/HZ);
 		disposition = SUCCESS;
-- 
Maurizio Lombardi

