Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD271A0542
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Apr 2020 05:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgDGDXv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 6 Apr 2020 23:23:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48208 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726669AbgDGDXv (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 6 Apr 2020 23:23:51 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 39DFF315C476CAFAAFAE;
        Tue,  7 Apr 2020 11:23:40 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Tue, 7 Apr 2020
 11:23:33 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <anil.gurumurthy@qlogic.com>, <sudarsana.kalluru@qlogic.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH 7/7] scsi: bfa: bfad.c: make max_rport_logins static
Date:   Tue, 7 Apr 2020 11:22:02 +0800
Message-ID: <20200407032202.36789-8-yanaijie@huawei.com>
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

drivers/scsi/bfa/bfad.c:53:17: warning: symbol 'max_rport_logins' was
not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/bfa/bfad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/bfa/bfad.c b/drivers/scsi/bfa/bfad.c
index eb0c76338295..bc5d84f87d8f 100644
--- a/drivers/scsi/bfa/bfad.c
+++ b/drivers/scsi/bfa/bfad.c
@@ -50,7 +50,7 @@ int		pcie_max_read_reqsz;
 int		bfa_debugfs_enable = 1;
 int		msix_disable_cb = 0, msix_disable_ct = 0;
 int		max_xfer_size = BFAD_MAX_SECTORS >> 1;
-int		max_rport_logins = BFA_FCS_MAX_RPORT_LOGINS;
+static int	max_rport_logins = BFA_FCS_MAX_RPORT_LOGINS;
 
 /* Firmware releated */
 u32	bfi_image_cb_size, bfi_image_ct_size, bfi_image_ct2_size;
-- 
2.17.2

