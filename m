Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB38260D3A
	for <lists+linux-scsi@lfdr.de>; Tue,  8 Sep 2020 10:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbgIHIPb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 8 Sep 2020 04:15:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:37144 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729744AbgIHIPZ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 8 Sep 2020 04:15:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 39646AD19;
        Tue,  8 Sep 2020 08:15:24 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Nilesh Javali <njavali@marvell.com>,
        Martin Wilck <mwilck@suse.com>, Arun Easi <aeasi@marvell.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v3 1/4] qla2xxx: Warn if done() or free() are called on an already freed srb
Date:   Tue,  8 Sep 2020 10:15:13 +0200
Message-Id: <20200908081516.8561-2-dwagner@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200908081516.8561-1-dwagner@suse.de>
References: <20200908081516.8561-1-dwagner@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Emit a warning when ->done or ->free are called on an already freed
srb. There is a hidden use-after-free bug in the driver which corrupts
the srb memory pool which originates from the cleanup callbacks.

An extensive search didn't bring any lights on the real problem. The
initial fix was to set both pointers to NULL and try to catch invalid
accesses. But instead the memory corruption was gone and the driver
didn't crash. Since not all calling places check for NULL pointer, add
explicitly default handlers. With this we workaround the memory
corruption and add a debug help.

Reviewed-by: Martin Wilck <mwilck@suse.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/scsi/qla2xxx/qla_init.c   | 10 ++++++++++
 drivers/scsi/qla2xxx/qla_inline.h |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 57a2d76aa691..fb7d57dc4e69 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -63,6 +63,16 @@ void qla2x00_sp_free(srb_t *sp)
 	qla2x00_rel_sp(sp);
 }
 
+void qla2xxx_rel_done_warning(srb_t *sp, int res)
+{
+	WARN_ONCE(1, "Calling done() of an already freed srb %p object\n", sp);
+}
+
+void qla2xxx_rel_free_warning(srb_t *sp)
+{
+	WARN_ONCE(1, "Calling free() of an already freed srb %p object\n", sp);
+}
+
 /* Asynchronous Login/Logout Routines -------------------------------------- */
 
 unsigned long
diff --git a/drivers/scsi/qla2xxx/qla_inline.h b/drivers/scsi/qla2xxx/qla_inline.h
index 861dc522723c..2aa6f81f87c4 100644
--- a/drivers/scsi/qla2xxx/qla_inline.h
+++ b/drivers/scsi/qla2xxx/qla_inline.h
@@ -207,10 +207,15 @@ qla2xxx_get_qpair_sp(scsi_qla_host_t *vha, struct qla_qpair *qpair,
 	return sp;
 }
 
+void qla2xxx_rel_done_warning(srb_t *sp, int res);
+void qla2xxx_rel_free_warning(srb_t *sp);
+
 static inline void
 qla2xxx_rel_qpair_sp(struct qla_qpair *qpair, srb_t *sp)
 {
 	sp->qpair = NULL;
+	sp->done = qla2xxx_rel_done_warning;
+	sp->free = qla2xxx_rel_free_warning;
 	mempool_free(sp, qpair->srb_mempool);
 	QLA_QPAIR_MARK_NOT_BUSY(qpair);
 }
-- 
2.16.4

