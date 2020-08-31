Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD68257E82
	for <lists+linux-scsi@lfdr.de>; Mon, 31 Aug 2020 18:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbgHaQTX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 31 Aug 2020 12:19:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:45878 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728384AbgHaQTW (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 31 Aug 2020 12:19:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 82578AD7A;
        Mon, 31 Aug 2020 16:19:19 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Nilesh Javali <njavali@marvell.com>,
        Martin Wilck <mwilck@suse.com>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 2/4] qla2xxx: Simplify return value logic in qla2x00_get_sp_from_handle()
Date:   Mon, 31 Aug 2020 18:18:52 +0200
Message-Id: <20200831161854.70879-3-dwagner@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200831161854.70879-1-dwagner@suse.de>
References: <20200831161854.70879-1-dwagner@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Refactor qla2x00_get_sp_from_handle() to avoid the unecessary
goto if early returns are used. With this we can also avoid
preinitilzing the sp pointer.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/scsi/qla2xxx/qla_isr.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 27bcd346af7c..5d278155e4e7 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -1716,7 +1716,7 @@ qla2x00_get_sp_from_handle(scsi_qla_host_t *vha, const char *func,
 {
 	struct qla_hw_data *ha = vha->hw;
 	sts_entry_t *pkt = iocb;
-	srb_t *sp = NULL;
+	srb_t *sp;
 	uint16_t index;
 
 	index = LSW(pkt->handle);
@@ -1728,13 +1728,13 @@ qla2x00_get_sp_from_handle(scsi_qla_host_t *vha, const char *func,
 			set_bit(FCOE_CTX_RESET_NEEDED, &vha->dpc_flags);
 		else
 			set_bit(ISP_ABORT_NEEDED, &vha->dpc_flags);
-		goto done;
+		return NULL;
 	}
 	sp = req->outstanding_cmds[index];
 	if (!sp) {
 		ql_log(ql_log_warn, vha, 0x5032,
 		    "Invalid completion handle (%x) -- timed-out.\n", index);
-		return sp;
+		return NULL;
 	}
 	if (sp->handle != index) {
 		ql_log(ql_log_warn, vha, 0x5033,
@@ -1743,8 +1743,6 @@ qla2x00_get_sp_from_handle(scsi_qla_host_t *vha, const char *func,
 	}
 
 	req->outstanding_cmds[index] = NULL;
-
-done:
 	return sp;
 }
 
-- 
2.16.4

