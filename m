Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 208F499601
	for <lists+linux-scsi@lfdr.de>; Thu, 22 Aug 2019 16:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733309AbfHVOL3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 22 Aug 2019 10:11:29 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4763 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733285AbfHVOL3 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 22 Aug 2019 10:11:29 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6D540538ACD6F6321CBC;
        Thu, 22 Aug 2019 22:11:24 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Thu, 22 Aug 2019
 22:11:15 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <anil.gurumurthy@qlogic.com>, <sudarsana.kalluru@qlogic.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH 2/4] scsi: bfa: remove set but not used variable 'rp'
Date:   Thu, 22 Aug 2019 22:17:44 +0800
Message-ID: <1566483466-120175-3-git-send-email-zhengbin13@huawei.com>
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

drivers/scsi/bfa/bfa_fcpim.c: In function bfa_fcpim_lunmask_delete:
drivers/scsi/bfa/bfa_fcpim.c:2346:22: warning: variable rp set but not used [-Wunused-but-set-variable]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/scsi/bfa/bfa_fcpim.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/bfa/bfa_fcpim.c b/drivers/scsi/bfa/bfa_fcpim.c
index 284baa3..63e936d 100644
--- a/drivers/scsi/bfa/bfa_fcpim.c
+++ b/drivers/scsi/bfa/bfa_fcpim.c
@@ -2335,7 +2335,6 @@ bfa_fcpim_lunmask_delete(struct bfa_s *bfa, u16 vf_id, wwn_t *pwwn,
 			 wwn_t rpwwn, struct scsi_lun lun)
 {
 	struct bfa_lun_mask_s	*lunm_list;
-	struct bfa_rport_s	*rp = NULL;
 	struct bfa_fcs_lport_s *port = NULL;
 	struct bfa_fcs_rport_s *rp_fcs;
 	int	i;
@@ -2356,8 +2355,6 @@ bfa_fcpim_lunmask_delete(struct bfa_s *bfa, u16 vf_id, wwn_t *pwwn,
 		if (port) {
 			*pwwn = port->port_cfg.pwwn;
 			rp_fcs = bfa_fcs_lport_get_rport_by_pwwn(port, rpwwn);
-			if (rp_fcs)
-				rp = rp_fcs->bfa_rport;
 		}
 	}

--
2.7.4

