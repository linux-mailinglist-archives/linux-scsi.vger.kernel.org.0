Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC54E54AAA2
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Jun 2022 09:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240380AbiFNHaQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 14 Jun 2022 03:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239923AbiFNHaM (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 14 Jun 2022 03:30:12 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DFA3EA81
        for <linux-scsi@vger.kernel.org>; Tue, 14 Jun 2022 00:30:02 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25E2fWDL021034
        for <linux-scsi@vger.kernel.org>; Tue, 14 Jun 2022 00:30:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=t9K0bQIsh0c5jQVaXBFGyZQ5hkIlvJDDEFPQEIyDcXk=;
 b=Koiz5Uh2I3iYvw9anh5fNvuDuXr9mDPOX215Hhv3+cN1IWWCBDXLM1TVBXf5AtEv763c
 Uy4w7gdvy6FkxUuZrutzk81X8RQWZDPkBOmzvcrROR/bvXmVt+6g3CMoQQdIvMf+bGxi
 0P/aHY8YTMHBEE8Mapi+TnDe09WCxHlPMRyDxYqw2R+wO3honG2GsF/BMqQcpIQS4sJh
 DlHUOnYLZzIKPZGPw8wI6GQcuSQbFBk7qSGZHEJKYNxOEUTXKE+ypEIWpnAbhmY8SVAB
 UKG7wOZWG+pXBN02SHhYDK5CXFtewBW8MClyXBUGObS3xBmdw94FDxrXlUIfIJ4b2/bT Pg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3gmtjp2bje-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Tue, 14 Jun 2022 00:30:01 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 14 Jun
 2022 00:29:59 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Jun 2022 00:29:59 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id E7CB13F70AA;
        Tue, 14 Jun 2022 00:29:58 -0700 (PDT)
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH 04/11] qla2xxx: Turn off multi-queue for 8G adapter
Date:   Tue, 14 Jun 2022 00:29:46 -0700
Message-ID: <20220614072953.16462-5-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20220614072953.16462-1-njavali@marvell.com>
References: <20220614072953.16462-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: fNZ3Z4qSy1N_EdbhXNnnZup60v--b4tn
X-Proofpoint-ORIG-GUID: fNZ3Z4qSy1N_EdbhXNnnZup60v--b4tn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-14_02,2022-06-13_01,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

For 8G adapter, multi-queue was enabled accidentally.
This patch make sure multi-queue is not enabled accidentally.

Cc: stable@vger.kernel.org
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_def.h |  4 ++--
 drivers/scsi/qla2xxx/qla_isr.c | 16 ++++++----------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 74d4234e5a31..89cb6c24258d 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -4273,8 +4273,8 @@ struct qla_hw_data {
 #define IS_OEM_001(ha)          ((ha)->device_type & DT_OEM_001)
 #define HAS_EXTENDED_IDS(ha)    ((ha)->device_type & DT_EXTENDED_IDS)
 #define IS_CT6_SUPPORTED(ha)	((ha)->device_type & DT_CT6_SUPPORTED)
-#define IS_MQUE_CAPABLE(ha)	((ha)->mqenable || IS_QLA83XX(ha) || \
-				IS_QLA27XX(ha) || IS_QLA28XX(ha))
+#define IS_MQUE_CAPABLE(ha)	(IS_QLA83XX(ha) || IS_QLA27XX(ha) || \
+				 IS_QLA28XX(ha))
 #define IS_BIDI_CAPABLE(ha) \
     (IS_QLA25XX(ha) || IS_QLA2031(ha) || IS_QLA27XX(ha) || IS_QLA28XX(ha))
 /* Bit 21 of fw_attributes decides the MCTP capabilities */
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 9af9b35edc27..24f9a3b116d8 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -4430,16 +4430,12 @@ qla24xx_enable_msix(struct qla_hw_data *ha, struct rsp_que *rsp)
 	}
 
 	/* Enable MSI-X vector for response queue update for queue 0 */
-	if (IS_QLA83XX(ha) || IS_QLA27XX(ha) || IS_QLA28XX(ha)) {
-		if (ha->msixbase && ha->mqiobase &&
-		    (ha->max_rsp_queues > 1 || ha->max_req_queues > 1 ||
-		     ql2xmqsupport))
-			ha->mqenable = 1;
-	} else
-		if (ha->mqiobase &&
-		    (ha->max_rsp_queues > 1 || ha->max_req_queues > 1 ||
-		     ql2xmqsupport))
-			ha->mqenable = 1;
+	if (IS_MQUE_CAPABLE(ha) &&
+	    (ha->msixbase && ha->mqiobase && ha->max_qpairs))
+		ha->mqenable = 1;
+	else
+		ha->mqenable = 0;
+
 	ql_dbg(ql_dbg_multiq, vha, 0xc005,
 	    "mqiobase=%p, max_rsp_queues=%d, max_req_queues=%d.\n",
 	    ha->mqiobase, ha->max_rsp_queues, ha->max_req_queues);
-- 
2.19.0.rc0

