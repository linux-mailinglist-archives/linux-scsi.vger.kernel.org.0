Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40DFF3E524E
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Aug 2021 06:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237130AbhHJEjK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 10 Aug 2021 00:39:10 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:65166 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237133AbhHJEi6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 10 Aug 2021 00:38:58 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17A4amVg008701
        for <linux-scsi@vger.kernel.org>; Mon, 9 Aug 2021 21:38:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=sGTeTC3lZMs0pUmakzTvU/HmfwKRLOhOBZBvPHLDCHU=;
 b=Xeax1vY6jP6lg3HH2R3JTuxaijbZn8/T++Sd/zA9kGoLWHkOgDAOi8VlNLfu/FXoc+ag
 XKR6ChIp9Ta5+BC/SjpNr9aQf2zMDjIf2zvjUmUJXLie4oskfVvTqkaDZmkBUzQdLoLq
 yYu8mFi/TlMD2ySe8Y7eoO2MYd9g6svySeJ9Kn4pJ3CZJVlUXC35DjHGiLdpLemdbt6p
 CGDVdzfVB/mBWOCXa7E3jGbTqODYQqqQipMf98xaCh3IKEX3bWjg/0WWnOD38ba1nezn
 /gu55Gq/3uneQuZ9ZP41JrxDJE7Bu14chEL0Hsf/v2jAatkoaKzUVUuJaGjcD4BtRlSP GQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 3abfu2gf56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Mon, 09 Aug 2021 21:38:36 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 9 Aug
 2021 21:38:35 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 9 Aug 2021 21:38:35 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 21BC83F709B;
        Mon,  9 Aug 2021 21:38:35 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 17A4cYV1001196;
        Mon, 9 Aug 2021 21:38:34 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 17A4cYj0001195;
        Mon, 9 Aug 2021 21:38:34 -0700
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH v2 04/14] qla2xxx: Changes to support FCP2 Target
Date:   Mon, 9 Aug 2021 21:37:10 -0700
Message-ID: <20210810043720.1137-5-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20210810043720.1137-1-njavali@marvell.com>
References: <20210810043720.1137-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: oDusv3HcR6yTzzxNvCFWYOu07GnArBde
X-Proofpoint-GUID: oDusv3HcR6yTzzxNvCFWYOu07GnArBde
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-10_01:2021-08-06,2021-08-10 signatures=0
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Saurav Kashyap <skashyap@marvell.com>

Add changes to support FCP2 Target.

Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/scsi/qla2xxx/qla_dbg.c  |  3 +--
 drivers/scsi/qla2xxx/qla_init.c |  6 ++++++
 drivers/scsi/qla2xxx/qla_os.c   | 10 ++++++++++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_dbg.c b/drivers/scsi/qla2xxx/qla_dbg.c
index f2d05592c1e2..25549a8a2d72 100644
--- a/drivers/scsi/qla2xxx/qla_dbg.c
+++ b/drivers/scsi/qla2xxx/qla_dbg.c
@@ -12,8 +12,7 @@
  * ----------------------------------------------------------------------
  * | Module Init and Probe        |       0x0199       |                |
  * | Mailbox commands             |       0x1206       | 0x11a5-0x11ff	|
- * | Device Discovery             |       0x2134       | 0x210e-0x2116  |
- * |				  | 		       | 0x211a         |
+ * | Device Discovery             |       0x2134       | 0x210e-0x2115  |
  * |                              |                    | 0x211c-0x2128  |
  * |                              |                    | 0x212c-0x2134  |
  * | Queue Command and IO tracing |       0x3074       | 0x300b         |
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 24683ac1a620..8fa0cc3fcca0 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1787,6 +1787,12 @@ void qla2x00_handle_rscn(scsi_qla_host_t *vha, struct event_arg *ea)
 
 	fcport = qla2x00_find_fcport_by_nportid(vha, &ea->id, 1);
 	if (fcport) {
+		if (fcport->flags & FCF_FCP2_DEVICE) {
+			ql_dbg(ql_dbg_disc, vha, 0x2115,
+			       "Delaying session delete for FCP2 portid=%06x %8phC ",
+			       fcport->d_id.b24, fcport->port_name);
+			return;
+		}
 		fcport->scan_needed = 1;
 		fcport->rscn_gen++;
 	}
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 921bd4d127f4..3b8230c35f26 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -3981,6 +3981,16 @@ qla2x00_mark_all_devices_lost(scsi_qla_host_t *vha)
 	    "Mark all dev lost\n");
 
 	list_for_each_entry(fcport, &vha->vp_fcports, list) {
+		if (fcport->loop_id != FC_NO_LOOP_ID &&
+		    (fcport->flags & FCF_FCP2_DEVICE) &&
+		    fcport->port_type == FCT_TARGET &&
+		    !qla2x00_reset_active(vha)) {
+			ql_dbg(ql_dbg_disc, vha, 0x211a,
+			       "Delaying session delete for FCP2 flags 0x%x port_type = 0x%x port_id=%06x %phC",
+			       fcport->flags, fcport->port_type,
+			       fcport->d_id.b24, fcport->port_name);
+			continue;
+		}
 		fcport->scan_state = 0;
 		qlt_schedule_sess_for_deletion(fcport);
 	}
-- 
2.19.0.rc0

