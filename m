Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A30A47EC8A
	for <lists+linux-scsi@lfdr.de>; Fri, 24 Dec 2021 08:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351806AbhLXHIP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 24 Dec 2021 02:08:15 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:8046 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351768AbhLXHHz (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 24 Dec 2021 02:07:55 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BO2o6Ag008389
        for <linux-scsi@vger.kernel.org>; Thu, 23 Dec 2021 23:07:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=qwjkVMKQKeNApWtjRPGrJUNMQh+LWh/R1GrUMYWDQXE=;
 b=adigH1XgedtJnEUAB+MyDO75H6GTCn6JepT8BVOORLiAIaflUUUgOP0M4JsL2QaCnMC0
 ivXXN7G0XhJ6Hj4y7nDt28FJUapYGyBmBFuSvh4sA64airJRtqbeLblPsik+KpSOdv20
 I5OPwO5ktSI7MWuZXrsgjpRCQ6TQtCDVAHat56HM3LSvldDpR5zryaEaDtyicOP3Ro49
 rA9vRHvaqr76/iZh/t7GGsXbmjgJ/ZPe4/vgTlFahmSbHg4q7WYtaWqcLuHHFQUoV94O
 84xGe+z7pT0tRTu5CXqH2eoAQI5oSRp9dGjxKBUORHwv9e6ar71VT8bR4NH5WfCkINb2 4g== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3d4t6kjua3-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Thu, 23 Dec 2021 23:07:54 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 23 Dec
 2021 23:07:50 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 23 Dec 2021 23:07:50 -0800
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 28C4D3F7078;
        Thu, 23 Dec 2021 23:07:50 -0800 (PST)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 1BO77ocZ018008;
        Thu, 23 Dec 2021 23:07:50 -0800
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 1BO77oIJ018007;
        Thu, 23 Dec 2021 23:07:50 -0800
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH 15/16] qla2xxx: Suppress a kernel complaint in qla_create_qpair()
Date:   Thu, 23 Dec 2021 23:07:11 -0800
Message-ID: <20211224070712.17905-16-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20211224070712.17905-1-njavali@marvell.com>
References: <20211224070712.17905-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: 4j7V4MIbAoF5XCvDfrvaGOxxLnHOKjAi
X-Proofpoint-ORIG-GUID: 4j7V4MIbAoF5XCvDfrvaGOxxLnHOKjAi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-24_02,2021-12-24_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Saurav Kashyap <skashyap@marvell.com>

[   12.323788] BUG: using smp_processor_id() in preemptible [00000000] code: systemd-udevd/1020
[   12.332297] caller is qla2xxx_create_qpair+0x32a/0x5d0 [qla2xxx]
[   12.338417] CPU: 7 PID: 1020 Comm: systemd-udevd Tainted: G          I      --------- ---  5.14.0-29.el9.x86_64 #1
[   12.348827] Hardware name: Dell Inc. PowerEdge R610/0F0XJ6, BIOS 6.6.0 05/22/2018
[   12.356356] Call Trace:
[   12.358821]  dump_stack_lvl+0x34/0x44
[   12.362514]  check_preemption_disabled+0xd9/0xe0
[   12.367164]  qla2xxx_create_qpair+0x32a/0x5d0 [qla2xxx]
[   12.372481]  qla2x00_probe_one+0xa3a/0x1b80 [qla2xxx]
[   12.377617]  ? _raw_spin_lock_irqsave+0x19/0x40
[   12.384284]  local_pci_probe+0x42/0x80
[   12.390162]  ? pci_match_device+0xd7/0x110
[   12.396366]  pci_device_probe+0xfd/0x1b0
[   12.402372]  really_probe+0x1e7/0x3e0
[   12.408114]  __driver_probe_device+0xfe/0x180
[   12.414544]  driver_probe_device+0x1e/0x90
[   12.420685]  __driver_attach+0xc0/0x1c0
[   12.426536]  ? __device_attach_driver+0xe0/0xe0
[   12.433061]  ? __device_attach_driver+0xe0/0xe0
[   12.439538]  bus_for_each_dev+0x78/0xc0
[   12.445294]  bus_add_driver+0x12b/0x1e0
[   12.451021]  driver_register+0x8f/0xe0
[   12.456631]  ? 0xffffffffc07bc000
[   12.461773]  qla2x00_module_init+0x1be/0x229 [qla2xxx]
[   12.468776]  do_one_initcall+0x44/0x200
[   12.474401]  ? load_module+0xad3/0xba0
[   12.479908]  ? kmem_cache_alloc_trace+0x45/0x410
[   12.486268]  do_init_module+0x5c/0x280
[   12.491730]  __do_sys_init_module+0x12e/0x1b0
[   12.497785]  do_syscall_64+0x3b/0x90
[   12.503029]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   12.509764] RIP: 0033:0x7f554f73ab2e

Cc: stable@vger.kernel.org
Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 87382477ff85..7e2b629e885f 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -9412,7 +9412,7 @@ struct qla_qpair *qla2xxx_create_qpair(struct scsi_qla_host *vha, int qos,
 		qpair->rsp->req = qpair->req;
 		qpair->rsp->qpair = qpair;
 		/* init qpair to this cpu. Will adjust at run time. */
-		qla_cpu_update(qpair, smp_processor_id());
+		qla_cpu_update(qpair, raw_smp_processor_id());
 
 		if (IS_T10_PI_CAPABLE(ha) && ql2xenabledif) {
 			if (ha->fw_attributes & BIT_4)
-- 
2.23.1

