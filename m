Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9DA23C4B6
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Aug 2020 06:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgHEEpn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 5 Aug 2020 00:45:43 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:55586 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726008AbgHEEpn (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 5 Aug 2020 00:45:43 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0754ZZxl023966
        for <linux-scsi@vger.kernel.org>; Tue, 4 Aug 2020 21:45:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=QU1riLo7tCDR2VuVGws1O5nRrxFfOCClgqgKHPL8tic=;
 b=nM6Gqa9z80Y2rdTVyIdDRuh1RudXyM+2kTXfqJ9d6xEfFPG2Oda9PcAXhhjTx7f2B8hD
 gd+Rf5/A/Xq969N5WA9njXkp48ewtsmyn3wAo23a7P8BD7NIh0YHr6B6CNsvEt9bC/Bv
 3O6IlskidMKtcmTf9E0QO08cXt9J+t3QGcr+2a3kemAI5S7vF6wG98vMWOkQNa0AAZrC
 BZZVsPvZMAC7zN9SxfFGi/1ll2pgi7tWuuiw/e+SBQHcBQKEq6wdF2yHPGz8DUSNfq/H
 q8ZdDFxOYWjAbdfsXTqgyKfgo3dWgidgA8T02BgQhrCakbcQaIYDIwndbBsrhu8Z4kvh Uw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 32n8fex8d2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Tue, 04 Aug 2020 21:45:42 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 4 Aug
 2020 21:45:41 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 4 Aug
 2020 21:45:39 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 4 Aug 2020 21:45:39 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 7FB863F7040;
        Tue,  4 Aug 2020 21:45:39 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 0754jdmc030608;
        Tue, 4 Aug 2020 21:45:39 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 0754jdDO030599;
        Tue, 4 Aug 2020 21:45:39 -0700
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH 03/10] qla2xxx: Indicate correct supported speeds for Mezz card
Date:   Tue, 4 Aug 2020 21:43:55 -0700
Message-ID: <20200805044402.30543-4-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20200805044402.30543-1-njavali@marvell.com>
References: <20200805044402.30543-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-05_03:2020-08-03,2020-08-05 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

Correct the supported speeds for 16G Mezz card.

Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_gs.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index d9ce8d31457a..8c30d9dbb48c 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -1505,11 +1505,11 @@ qla2x00_prep_ct_fdmi_req(struct ct_sns_pkt *p, uint16_t cmd,
 static uint
 qla25xx_fdmi_port_speed_capability(struct qla_hw_data *ha)
 {
+	uint speeds = 0;
+
 	if (IS_CNA_CAPABLE(ha))
 		return FDMI_PORT_SPEED_10GB;
 	if (IS_QLA28XX(ha) || IS_QLA27XX(ha)) {
-		uint speeds = 0;
-
 		if (ha->max_supported_speed == 2) {
 			if (ha->min_supported_speed <= 6)
 				speeds |= FDMI_PORT_SPEED_64GB;
@@ -1536,9 +1536,16 @@ qla25xx_fdmi_port_speed_capability(struct qla_hw_data *ha)
 		}
 		return speeds;
 	}
-	if (IS_QLA2031(ha))
-		return FDMI_PORT_SPEED_16GB|FDMI_PORT_SPEED_8GB|
-			FDMI_PORT_SPEED_4GB;
+	if (IS_QLA2031(ha)) {
+		if ((ha->pdev->subsystem_vendor == 0x103C) &&
+		    (ha->pdev->subsystem_device == 0x8002)) {
+			speeds = FDMI_PORT_SPEED_16GB;
+		} else {
+			speeds = FDMI_PORT_SPEED_16GB|FDMI_PORT_SPEED_8GB|
+				FDMI_PORT_SPEED_4GB;
+		}
+		return speeds;
+	}
 	if (IS_QLA25XX(ha))
 		return FDMI_PORT_SPEED_8GB|FDMI_PORT_SPEED_4GB|
 			FDMI_PORT_SPEED_2GB|FDMI_PORT_SPEED_1GB;
-- 
2.19.0.rc0

