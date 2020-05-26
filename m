Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA0AD19D398
	for <lists+linux-scsi@lfdr.de>; Fri,  3 Apr 2020 11:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389758AbgDCJ1V (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 3 Apr 2020 05:27:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:53912 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbgDCJ1U (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 3 Apr 2020 05:27:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 68850AC2C;
        Fri,  3 Apr 2020 09:27:19 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-scsi@vger.kernel.org
Cc:     Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.com>,
        Saurav Kashyap <skashyap@marvell.com>
Subject: [PATCH v2] scsi: qedf: Simplify mutex_unlock() usage
Date:   Fri,  3 Apr 2020 11:27:17 +0200
Message-Id: <20200403092717.19779-1-dwagner@suse.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The commit 6d1368e8f987 ("scsi: qedf: fixup locking in
qedf_restart_rport()") introduced the lock. Though the lock protects
only the fc_rport_create() call. Thus, we can move the mutex unlock up
before the if statement and drop the else body.

Cc: Hannes Reinecke <hare@suse.com>
Cc: Saurav Kashyap <skashyap@marvell.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

changes since v1:
  - refactor the fcport->rdata assignemnt.

 drivers/scsi/qedf/qedf_els.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/qedf/qedf_els.c b/drivers/scsi/qedf/qedf_els.c
index 87e169dcebdb..542ba9454257 100644
--- a/drivers/scsi/qedf/qedf_els.c
+++ b/drivers/scsi/qedf/qedf_els.c
@@ -388,14 +388,10 @@ void qedf_restart_rport(struct qedf_rport *fcport)
 		mutex_lock(&lport->disc.disc_mutex);
 		/* Recreate the rport and log back in */
 		rdata = fc_rport_create(lport, port_id);
-		if (rdata) {
-			mutex_unlock(&lport->disc.disc_mutex);
+		mutex_unlock(&lport->disc.disc_mutex);
+		if (rdata)
 			fc_rport_login(rdata);
-			fcport->rdata = rdata;
-		} else {
-			mutex_unlock(&lport->disc.disc_mutex);
-			fcport->rdata = NULL;
-		}
+		fcport->rdata = rdata;
 	}
 	clear_bit(QEDF_RPORT_IN_RESET, &fcport->flags);
 }
-- 
2.26.0

