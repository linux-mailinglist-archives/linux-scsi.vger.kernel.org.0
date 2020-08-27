Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6862542DA
	for <lists+linux-scsi@lfdr.de>; Thu, 27 Aug 2020 11:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgH0J6d (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 27 Aug 2020 05:58:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:37234 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728386AbgH0J6d (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 27 Aug 2020 05:58:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 20731AD79;
        Thu, 27 Aug 2020 09:59:03 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Nilesh Javali <njavali@marvell.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: [PATCH 1/4] qla2xxx: Reset done and free callback pointer on release
Date:   Thu, 27 Aug 2020 11:58:26 +0200
Message-Id: <20200827095829.63871-2-dwagner@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200827095829.63871-1-dwagner@suse.de>
References: <20200827095829.63871-1-dwagner@suse.de>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Reset ->done and ->free when releasing the srb. There is a hidden
use-after-free bug in the driver which corrupts the srb memory pool
which originates from the cleanup callbacks. By explicitly resetting
the callbacks to NULL, we workaround the memory corruption.

An extensive search didn't bring any lights on the real problem. The
initial idea was to set both pointers to NULL and try to catch invalid
accesses. But instead the memory corruption was gone and the driver
didn't crash.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/scsi/qla2xxx/qla_inline.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_inline.h b/drivers/scsi/qla2xxx/qla_inline.h
index 861dc522723c..6d41d758fc17 100644
--- a/drivers/scsi/qla2xxx/qla_inline.h
+++ b/drivers/scsi/qla2xxx/qla_inline.h
@@ -211,6 +211,8 @@ static inline void
 qla2xxx_rel_qpair_sp(struct qla_qpair *qpair, srb_t *sp)
 {
 	sp->qpair = NULL;
+	sp->done = NULL;
+	sp->free = NULL;
 	mempool_free(sp, qpair->srb_mempool);
 	QLA_QPAIR_MARK_NOT_BUSY(qpair);
 }
-- 
2.16.4

