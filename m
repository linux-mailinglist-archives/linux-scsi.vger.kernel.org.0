Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E66221A053C
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Apr 2020 05:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgDGDXm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 6 Apr 2020 23:23:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12686 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726668AbgDGDXm (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 6 Apr 2020 23:23:42 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1FE08379BE46164F456;
        Tue,  7 Apr 2020 11:23:40 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Tue, 7 Apr 2020
 11:23:30 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <anil.gurumurthy@qlogic.com>, <sudarsana.kalluru@qlogic.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH 3/7] scsi: bfa: bfa_fcpim.c: make two functions static
Date:   Tue, 7 Apr 2020 11:21:58 +0800
Message-ID: <20200407032202.36789-4-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200407032202.36789-1-yanaijie@huawei.com>
References: <20200407032202.36789-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix the following sparse warning:

drivers/scsi/bfa/bfa_fcpim.c:440:1: warning: symbol
'bfa_ioim_profile_comp' was not declared. Should it be static?
drivers/scsi/bfa/bfa_fcpim.c:457:1: warning: symbol
'bfa_ioim_profile_start' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/bfa/bfa_fcpim.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/bfa/bfa_fcpim.c b/drivers/scsi/bfa/bfa_fcpim.c
index 284baa3b0c8e..766f2b5ed2ab 100644
--- a/drivers/scsi/bfa/bfa_fcpim.c
+++ b/drivers/scsi/bfa/bfa_fcpim.c
@@ -436,7 +436,7 @@ bfa_fcpim_port_iostats(struct bfa_s *bfa,
 	return BFA_STATUS_OK;
 }
 
-void
+static void
 bfa_ioim_profile_comp(struct bfa_ioim_s *ioim)
 {
 	struct bfa_itnim_latency_s *io_lat =
@@ -453,7 +453,7 @@ bfa_ioim_profile_comp(struct bfa_ioim_s *ioim)
 	io_lat->avg[idx] += val;
 }
 
-void
+static void
 bfa_ioim_profile_start(struct bfa_ioim_s *ioim)
 {
 	ioim->start_time = jiffies;
-- 
2.17.2

