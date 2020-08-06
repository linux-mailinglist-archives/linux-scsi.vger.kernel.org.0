Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B704E23DA67
	for <lists+linux-scsi@lfdr.de>; Thu,  6 Aug 2020 14:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgHFMg5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 6 Aug 2020 08:36:57 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:25580 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726927AbgHFLOp (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 6 Aug 2020 07:14:45 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 076BA111021010
        for <linux-scsi@vger.kernel.org>; Thu, 6 Aug 2020 04:14:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=BX99jQrXhv7ip7IPsuey4HBNZzFoQRcaxUPdXDDEp9s=;
 b=V/f/XGm63NG2JuopX13EWhY+TgCZZv3kaHWa5CQf4s6yuzAD4J1RCTNOw3OWWkOwIMfi
 INywpQcQLqvxjB8a0E89maoDC2CRNTgnvkJnD56EFnEJl8cdnvNw/2qQXO3nEl7aNW5C
 uS4Kf0D6z4YGm0HVKG/CcdBlRF4f8R5zUKBPAdHAjiBw9DvcRhXMyEcn9HzozMia6hBv
 3ji6lCM3Me29zKJfxkPGcYVcpg/qITNAE5VIQfeq55xr/iwweu7pBxXR826CFL6UGXug
 W+96x8yk1wqXyNZHoQncoBwc5SG/iD3FEHzNUDEwNvb/KsEPdo3DrqlSu6zvd0Ivo+Tz /Q== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 32n8ff3xfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Thu, 06 Aug 2020 04:14:41 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 6 Aug
 2020 04:14:39 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 6 Aug 2020 04:14:40 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 073243F703F;
        Thu,  6 Aug 2020 04:14:40 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 076BEdBU028543;
        Thu, 6 Aug 2020 04:14:39 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 076BEdPd028541;
        Thu, 6 Aug 2020 04:14:39 -0700
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH v2 10/11] Revert "scsi: qla2xxx: Fix crash on qla2x00_mailbox_command"
Date:   Thu, 6 Aug 2020 04:10:13 -0700
Message-ID: <20200806111014.28434-11-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20200806111014.28434-1-njavali@marvell.com>
References: <20200806111014.28434-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-06_06:2020-08-06,2020-08-06 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

FCoE adapter initialization failed for ISP8021.

This reverts commit 3cb182b3fa8b7a61f05c671525494697cba39c6a.

Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_mbx.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index 73883435ab58..93aafef7f21c 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -334,14 +334,6 @@ qla2x00_mailbox_command(scsi_qla_host_t *vha, mbx_cmd_t *mcp)
 			if (time_after(jiffies, wait_time))
 				break;
 
-			/*
-			 * Check if it's UNLOADING, cause we cannot poll in
-			 * this case, or else a NULL pointer dereference
-			 * is triggered.
-			 */
-			if (unlikely(test_bit(UNLOADING, &base_vha->dpc_flags)))
-				return QLA_FUNCTION_TIMEOUT;
-
 			/* Check for pending interrupts. */
 			qla2x00_poll(ha->rsp_q_map[0]);
 
-- 
2.19.0.rc0

