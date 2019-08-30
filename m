Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7EBA4086
	for <lists+linux-scsi@lfdr.de>; Sat, 31 Aug 2019 00:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfH3WYa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 30 Aug 2019 18:24:30 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:57942 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728157AbfH3WY2 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 30 Aug 2019 18:24:28 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7UMOOO4005338;
        Fri, 30 Aug 2019 15:24:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=fvn1UDPuFAOsz8HLEhqLFfD3HAU2At4ZSdJMotp+YL4=;
 b=wtE1jnWyNJ+5EZaIWcRUVII9xTtB6Dty3xGTdoP+Oxwk26zTq82Q41LCwukpXz3AcKbE
 AkSstkinA3ZL2OXKBax9nLVU2TXV0+kfWi5deRvk9kH6N+XEiv1VKMskp/nGbs3Dh106
 4Hjs4PnwjCXsRf4tBh/VK602UQZ+AZMj9tlG1plpOk38HRUf4G+d4SRjDYpbYMBE3F7z
 VQlRs17McBReRUSJZutfJarB+iuDDm+vgEkVNK5RdEk3ioU/Z1hrcY84HNvyoJvwF8pE
 IHRnL/rGMSELbRy9DU5YDdrZnTaYXWM3FnuBiNF2tMYGuhHG+pv4rwCw09ckZn4gul9X gQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 2uk4rm2dat-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 30 Aug 2019 15:24:24 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 30 Aug
 2019 15:24:18 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 30 Aug 2019 15:24:18 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 89DFE3F703F;
        Fri, 30 Aug 2019 15:24:18 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x7UMOIJ6023743;
        Fri, 30 Aug 2019 15:24:18 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x7UMOIfe023742;
        Fri, 30 Aug 2019 15:24:18 -0700
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH 5/6] qla2xxx: Fix stale session
Date:   Fri, 30 Aug 2019 15:24:01 -0700
Message-ID: <20190830222402.23688-6-hmadhani@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190830222402.23688-1-hmadhani@marvell.com>
References: <20190830222402.23688-1-hmadhani@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-08-30_09:2019-08-29,2019-08-30 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

On fast cable pull, where driver is unable to detect device
has disappeared and came back based on switch info, qla2xxx
would not re-login while remote port has already invalidate
the session.  This cause IO timeout.  This patch would relogin
to remote device for RSCN affected port.

Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
---
 drivers/scsi/qla2xxx/qla_gs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index 03f94eb372b6..dc0e36676313 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -3628,7 +3628,6 @@ void qla24xx_async_gnnft_done(scsi_qla_host_t *vha, srb_t *sp)
 		list_for_each_entry(fcport, &vha->vp_fcports, list) {
 			if (memcmp(rp->port_name, fcport->port_name, WWN_SIZE))
 				continue;
-			fcport->scan_needed = 0;
 			fcport->scan_state = QLA_FCPORT_FOUND;
 			found = true;
 			/*
@@ -3637,10 +3636,12 @@ void qla24xx_async_gnnft_done(scsi_qla_host_t *vha, srb_t *sp)
 			if ((fcport->flags & FCF_FABRIC_DEVICE) == 0) {
 				qla2x00_clear_loop_id(fcport);
 				fcport->flags |= FCF_FABRIC_DEVICE;
-			} else if (fcport->d_id.b24 != rp->id.b24) {
+			} else if (fcport->d_id.b24 != rp->id.b24 ||
+				fcport->scan_needed) {
 				qlt_schedule_sess_for_deletion(fcport);
 			}
 			fcport->d_id.b24 = rp->id.b24;
+			fcport->scan_needed = 0;
 			break;
 		}
 
-- 
2.12.0

