Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24E821B1CFA
	for <lists+linux-scsi@lfdr.de>; Tue, 21 Apr 2020 05:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgDUDkm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 20 Apr 2020 23:40:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2811 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726958AbgDUDkm (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 20 Apr 2020 23:40:42 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D90B5BE50431154AF9E5;
        Tue, 21 Apr 2020 11:40:36 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Tue, 21 Apr 2020
 11:40:28 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <anil.gurumurthy@qlogic.com>, <sudarsana.kalluru@qlogic.com>,
        <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <tglx@linutronix.de>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] scsi: bfa: remove unneeded semicolon in bfa_fcs_rport.c
Date:   Tue, 21 Apr 2020 11:39:57 +0800
Message-ID: <20200421033957.27783-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix the following coccicheck warning:

drivers/scsi/bfa/bfa_fcs_rport.c:2452:2-3: Unneeded semicolon
drivers/scsi/bfa/bfa_fcs_rport.c:1578:3-4: Unneeded semicolon

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/bfa/bfa_fcs_rport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/bfa/bfa_fcs_rport.c b/drivers/scsi/bfa/bfa_fcs_rport.c
index 82801b366500..fc294e1950a6 100644
--- a/drivers/scsi/bfa/bfa_fcs_rport.c
+++ b/drivers/scsi/bfa/bfa_fcs_rport.c
@@ -1575,7 +1575,7 @@ bfa_fcs_rport_sm_nsdisc_sent(struct bfa_fcs_rport_s *rport,
 			bfa_timer_start(rport->fcs->bfa, &rport->timer,
 					bfa_fcs_rport_timeout, rport,
 					bfa_fcs_rport_del_timeout);
-		};
+		}
 		break;
 
 	case RPSM_EVENT_DELETE:
@@ -2449,7 +2449,7 @@ bfa_fcs_rport_hal_online_action(struct bfa_fcs_rport_s *rport)
 		bfa_fcs_itnim_brp_online(rport->itnim);
 		if (!BFA_FCS_PID_IS_WKA(rport->pid))
 			bfa_fcs_rpf_rport_online(rport);
-	};
+	}
 
 	wwn2str(lpwwn_buf, bfa_fcs_lport_get_pwwn(port));
 	wwn2str(rpwwn_buf, rport->pwwn);
-- 
2.21.1

