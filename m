Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72D5199605
	for <lists+linux-scsi@lfdr.de>; Thu, 22 Aug 2019 16:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387441AbfHVOLi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 22 Aug 2019 10:11:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4762 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733177AbfHVOLi (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 22 Aug 2019 10:11:38 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 685DC52D373AC0B9A965;
        Thu, 22 Aug 2019 22:11:24 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Thu, 22 Aug 2019
 22:11:15 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <anil.gurumurthy@qlogic.com>, <sudarsana.kalluru@qlogic.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH 1/4] scsi: bfa: remove set but not used variable 'fchs'
Date:   Thu, 22 Aug 2019 22:17:43 +0800
Message-ID: <1566483466-120175-2-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566483466-120175-1-git-send-email-zhengbin13@huawei.com>
References: <1566483466-120175-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/scsi/bfa/bfa_svc.c: In function uf_recv:
drivers/scsi/bfa/bfa_svc.c:5528:17: warning: variable fchs set but not used [-Wunused-but-set-variable]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/scsi/bfa/bfa_svc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/bfa/bfa_svc.c b/drivers/scsi/bfa/bfa_svc.c
index 6d21314..f345cbf 100644
--- a/drivers/scsi/bfa/bfa_svc.c
+++ b/drivers/scsi/bfa/bfa_svc.c
@@ -5517,7 +5517,6 @@ uf_recv(struct bfa_s *bfa, struct bfi_uf_frm_rcvd_s *m)
 	struct bfa_uf_s *uf = &ufm->uf_list[uf_tag];
 	struct bfa_uf_buf_s *uf_buf;
 	uint8_t *buf;
-	struct fchs_s *fchs;

 	uf_buf = (struct bfa_uf_buf_s *)
 			bfa_mem_get_dmabuf_kva(ufm, uf_tag, uf->pb_len);
@@ -5526,8 +5525,6 @@ uf_recv(struct bfa_s *bfa, struct bfi_uf_frm_rcvd_s *m)
 	m->frm_len = be16_to_cpu(m->frm_len);
 	m->xfr_len = be16_to_cpu(m->xfr_len);

-	fchs = (struct fchs_s *)uf_buf;
-
 	list_del(&uf->qe);	/* dequeue from posted queue */

 	uf->data_ptr = buf;
--
2.7.4

