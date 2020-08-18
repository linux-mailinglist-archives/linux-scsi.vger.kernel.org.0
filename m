Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F42F2484C2
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Aug 2020 14:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgHRMcx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Aug 2020 08:32:53 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:60422 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726635AbgHRMcw (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 18 Aug 2020 08:32:52 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07ICTPrb027424
        for <linux-scsi@vger.kernel.org>; Tue, 18 Aug 2020 05:32:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=HWyhWHBJv5n7HrmYb7czs1lDkUxeFAGizXKV5Wn2jek=;
 b=OhGQLPPfRRyvsckZ3m7x8y9C8pGjsbj3ErMZSecLi3vg4lQu7wE1AKHHr3s34oWRahYV
 b3j5OjO1ymkDaV25+Xwdx3zXAvDTLeitxiaKxKBwNnpqRGXxB+Xb6+3hSsQtVOh+0Ru8
 NLVDSHBi647HS02FJU44wt7rT+uimtbcHhDKqqG4opD/tK6FOK074QjI8tqsHU3Q8jMf
 8Y0hw3RD6AELJcLHKFY5NnYnyACC8kCedvrBvuDeYVCGX8dyt2vE+FbIUEdptaMhFr0t
 zeuqoctKvmIOZuKL9p712arjIvbi16faShjDDC6pFwuDN6XpVOgpUeIJhF//MMeCs0mD vA== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 3304fhjedt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Tue, 18 Aug 2020 05:32:52 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 18 Aug
 2020 05:32:51 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 18 Aug 2020 05:32:51 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 69FB93F703F;
        Tue, 18 Aug 2020 05:32:51 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 07ICWp7F020401;
        Tue, 18 Aug 2020 05:32:51 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 07ICWpBs020400;
        Tue, 18 Aug 2020 05:32:51 -0700
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH 01/12] qla2xxx: Fix I/O failures during remote port toggle testing
Date:   Tue, 18 Aug 2020 05:31:52 -0700
Message-ID: <20200818123203.20361-2-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20200818123203.20361-1-njavali@marvell.com>
References: <20200818123203.20361-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-18_07:2020-08-18,2020-08-18 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Arun Easi <aeasi@marvell.com>

Driver was using a lower value for dev_loss_tmo making it more prone to
I/O failures during remote port toggle testing. Set dev_loss_tmo to zero
during remote port registration to allow nvme-fc default dev_loss_tmo to
be used, which is higher than what driver was using.

Signed-off-by: Arun Easi <aeasi@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_nvme.c | 2 +-
 drivers/scsi/qla2xxx/qla_nvme.h | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 90bbc61f361b..435f17f87301 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -42,7 +42,7 @@ int qla_nvme_register_remote(struct scsi_qla_host *vha, struct fc_port *fcport)
 	req.port_name = wwn_to_u64(fcport->port_name);
 	req.node_name = wwn_to_u64(fcport->node_name);
 	req.port_role = 0;
-	req.dev_loss_tmo = NVME_FC_DEV_LOSS_TMO;
+	req.dev_loss_tmo = 0;
 
 	if (fcport->nvme_prli_service_param & NVME_PRLI_SP_INITIATOR)
 		req.port_role = FC_PORT_ROLE_NVME_INITIATOR;
diff --git a/drivers/scsi/qla2xxx/qla_nvme.h b/drivers/scsi/qla2xxx/qla_nvme.h
index fbb844226630..cf45a5b277f1 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.h
+++ b/drivers/scsi/qla2xxx/qla_nvme.h
@@ -14,9 +14,6 @@
 #include "qla_def.h"
 #include "qla_dsd.h"
 
-/* default dev loss time (seconds) before transport tears down ctrl */
-#define NVME_FC_DEV_LOSS_TMO  30
-
 #define NVME_ATIO_CMD_OFF 32
 #define NVME_FIRST_PACKET_CMDLEN (64 - NVME_ATIO_CMD_OFF)
 #define Q2T_NVME_NUM_TAGS 2048
-- 
2.19.0.rc0

