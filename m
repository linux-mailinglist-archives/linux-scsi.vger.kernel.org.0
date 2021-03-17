Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06C233F493
	for <lists+linux-scsi@lfdr.de>; Wed, 17 Mar 2021 16:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbhCQPve (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 17 Mar 2021 11:51:34 -0400
Received: from smtp.infotech.no ([82.134.31.41]:37233 "EHLO smtp.infotech.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232391AbhCQPu5 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 17 Mar 2021 11:50:57 -0400
Received: from localhost (localhost [127.0.0.1])
        by smtp.infotech.no (Postfix) with ESMTP id 98DB920419D;
        Wed, 17 Mar 2021 16:28:11 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.6.6 (20110518) (Debian) at infotech.no
Received: from smtp.infotech.no ([127.0.0.1])
        by localhost (smtp.infotech.no [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VdgcuycnTVtb; Wed, 17 Mar 2021 16:28:08 +0100 (CET)
Received: from xtwo70.bingwo.ca (host-45-58-219-4.dyn.295.ca [45.58.219.4])
        by smtp.infotech.no (Postfix) with ESMTPA id 9A8C9204269;
        Wed, 17 Mar 2021 16:28:07 +0100 (CET)
From:   Douglas Gilbert <dgilbert@interlog.com>
To:     linux-scsi@vger.kernel.org
Cc:     martin.petersen@oracle.com, jejb@linux.vnet.ibm.com, hare@suse.de,
        dan.carpenter@oracle.com, colin.king@canonical.com,
        syzbot+0a0e8ecea895d38332e6@syzkaller.appspotmail.com
Subject: [PATCH v2 4/6] sg: fix double free of long scsi commands
Date:   Wed, 17 Mar 2021 11:27:56 -0400
Message-Id: <20210317152758.51689-5-dgilbert@interlog.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210317152758.51689-1-dgilbert@interlog.com>
References: <20210317152758.51689-1-dgilbert@interlog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

In the post: "[syzbot] KASAN: invalid-free in sg_finish_scsi_blk_rq"
on 20210315 to the linux-scsi list KASAN reported a double free.
Remove the offending scsi_req_free_cmd(scsi_rp) call and note
with a comment where the change in ownership of long SCSI command
(> 16 bytes long) takes place.

Reported-by: syzbot+0a0e8ecea895d38332e6@syzkaller.appspotmail.com
Signed-off-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/sg.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index b6e06e039d5b..c49f87c97dd4 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -3097,16 +3097,14 @@ sg_start_req(struct sg_request *srp, struct sg_comm_wr_t *cwrp, int dxfer_dir)
 		set_bit(SG_FFD_HIPRI_SEEN, sfp->ffd_bm);
 
 	if (cwrp->cmd_len > BLK_MAX_CDB)
-		scsi_rp->cmd = long_cmdp;
+		scsi_rp->cmd = long_cmdp;	/* transfer ownership */
 	if (cwrp->u_cmdp)
 		res = sg_fetch_cmnd(cwrp->filp, sfp, cwrp->u_cmdp,
 				    cwrp->cmd_len, scsi_rp->cmd);
 	else
 		res = -EPROTO;
-	if (res) {
-		kfree(long_cmdp);
-		return res;
-	}
+	if (res)
+		goto fini;
 	scsi_rp->cmd_len = cwrp->cmd_len;
 	srp->cmd_opcode = scsi_rp->cmd[0];
 	us_xfer = !(rq_flags & (SG_FLAG_NO_DXFER | SG_FLAG_MMAP_IO));
@@ -3178,7 +3176,6 @@ sg_start_req(struct sg_request *srp, struct sg_comm_wr_t *cwrp, int dxfer_dir)
 	}
 fini:
 	if (unlikely(res)) {		/* failure, free up resources */
-		scsi_req_free_cmd(scsi_rp);
 		if (likely(!test_and_set_bit(SG_FRQ_BLK_PUT_REQ,
 					     srp->frq_bm))) {
 			srp->rq = NULL;
-- 
2.25.1

