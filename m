Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2201433F48F
	for <lists+linux-scsi@lfdr.de>; Wed, 17 Mar 2021 16:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbhCQPve (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 17 Mar 2021 11:51:34 -0400
Received: from smtp.infotech.no ([82.134.31.41]:37230 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232810AbhCQPus (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 17 Mar 2021 11:50:48 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id D0FEC20426F;
        Wed, 17 Mar 2021 16:28:08 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id G34WKiQ8AFta; Wed, 17 Mar 2021 16:28:07 +0100 (CET)
Received: from xtwo70.bingwo.ca (host-45-58-219-4.dyn.295.ca [45.58.219.4])
        by smtp.infotech.no (Postfix) with ESMTPA id 169BA20418C;
        Wed, 17 Mar 2021 16:28:05 +0100 (CET)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        dan.carpenter@oracle.com, colin.king@canonical.com
Subject: [PATCH v2 3/6] sg: sg_rq_end_io: set SG_FRQ_ISSUED
Date:   Wed, 17 Mar 2021 11:27:55 -0400
Message-Id: <20210317152758.51689-4-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210317152758.51689-1-dgilbert@interlog.com>
References: <20210317152758.51689-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The SG_FRQ_ISSUED flag should be set when the driver knows the
block layer has issued a request with blk_execute_rq_nowait().
This flag was set on the line following that nowait() call.
However with blk_poll() the request may have already invoked
the completion call-back (sg_rq_end_io()) so set this flag
there as well.

Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 77fec70b7c2f..b6e06e039d5b 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -2624,6 +2624,7 @@ sg_rq_end_io(struct request *rq, blk_status_t status)
 			set_bit(SG_FRQ_DEACT_ORPHAN, srp->frq_bm);
 		}
 	}
+	set_bit(SG_FRQ_ISSUED, srp->frq_bm);
 	if (test_bit(SG_FRQ_COUNT_ACTIVE, srp->frq_bm)) {
 		int num = atomic_inc_return(&sfp->waiting);
 
-- 
2.25.1

