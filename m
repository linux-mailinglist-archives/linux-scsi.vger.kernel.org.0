Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08DB723D9C3
	for <lists+linux-scsi@lfdr.de>; Thu,  6 Aug 2020 13:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbgHFLPy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 6 Aug 2020 07:15:54 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:52594 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725812AbgHFLOA (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 6 Aug 2020 07:14:00 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 076BAoVS017312
        for <linux-scsi@vger.kernel.org>; Thu, 6 Aug 2020 04:13:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=HSrhICL+l6PibeSHcC7kpM/iAyeIK7hXRPn8BAVe3Ws=;
 b=Qw23GVzyxvbua+Rcn3LQipoLrqfcSpq2Mp9tUAMu/+yYE6W8ar72eRHBX7DWI9DpPtRe
 lZHt+OKTmN5vt3cBYUzba/EH2P5whphwutHq0NHQeByhWogXRtWF+R3W/4QLsTgZoDkQ
 +wBwrZjn2AZT+fj+OjeSVtoxk3HeFwcLCha6nsd5lX9D/UVjBVRKY/ASD4vpsuvfgzvf
 CHs24m4dFsoz8j9/dlBAzZE4Yeu0RNzuDKVml0yeWZaVElYAQwyjVzvTgvYdm1hMw8PE
 YUPotAfKCf+3g2bgy32+rkAEGDzAgMYXwrtceNZMoizWCap0cqXWWg6kDuLuYQSd9fRA OQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 32n6cgvgtn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Thu, 06 Aug 2020 04:13:53 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 6 Aug
 2020 04:13:53 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 6 Aug
 2020 04:13:51 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 6 Aug 2020 04:13:51 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id BCB213F703F;
        Thu,  6 Aug 2020 04:13:51 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 076BDpEm028526;
        Thu, 6 Aug 2020 04:13:51 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 076BDpJH028525;
        Thu, 6 Aug 2020 04:13:51 -0700
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH v2 08/11] qla2xxx: Check if FW supports MQ before enabling
Date:   Thu, 6 Aug 2020 04:10:11 -0700
Message-ID: <20200806111014.28434-9-njavali@marvell.com>
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

From: Saurav Kashyap <skashyap@marvell.com>

OS boot during Boot from SAN was stuck at dracut emergency shell
after enabling nvme driver parameter. For non MQ support the driver
was enabling MQ. Add a check to confirm if FW supports MQ.

Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_os.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 9b59f032a569..fda812b9b564 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -2017,6 +2017,11 @@ qla2x00_iospace_config(struct qla_hw_data *ha)
 	/* Determine queue resources */
 	ha->max_req_queues = ha->max_rsp_queues = 1;
 	ha->msix_count = QLA_BASE_VECTORS;
+
+	/* Check if FW supports MQ or not */
+	if (!(ha->fw_attributes & BIT_6))
+		goto mqiobase_exit;
+
 	if (!ql2xmqsupport || !ql2xnvmeenable ||
 	    (!IS_QLA25XX(ha) && !IS_QLA81XX(ha)))
 		goto mqiobase_exit;
-- 
2.19.0.rc0

