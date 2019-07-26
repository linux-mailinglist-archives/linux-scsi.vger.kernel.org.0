Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8F5E76E98
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jul 2019 18:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfGZQIQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Jul 2019 12:08:16 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:55548 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726141AbfGZQIQ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 26 Jul 2019 12:08:16 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6QG552b017085;
        Fri, 26 Jul 2019 09:08:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=U0LtqyZINzdlylPjBvHcVaxn41MFkG3ufUCjGcu6nPQ=;
 b=WLRirnZhXCFycXVX/jIEmse0MeZpBuW662E2MoG8/2V/T49GIzX2ulQy9VwsKZX5myWR
 S1pug+MlcYj0xdY9SYfUjz61REpumdhdOhoQSGZhzKSsC+7omK0bO5aYdmXQJZmvj40O
 M8EieIbaWIxAuhMcyG1aC2NeW2QDJTPBuGjk5msnqIB7mV7d01f2Nb2VR2eyI+geRXHm
 AWqsk8F0PROZIpOgrvIb0ePv2U7tS8yeineXzVLejrJf3dosDGtT27fBzoQYxKrZTVLw
 8JI7+9eMCHAoqEbwGKlQDqcK/iFsboE2t2OjwWTrz2S6RwF5l0CvPWfX+B+qoRfqSxnT UQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2tx61rqjyf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 26 Jul 2019 09:08:14 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 26 Jul
 2019 09:08:13 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 26 Jul 2019 09:08:12 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id C43B33F7040;
        Fri, 26 Jul 2019 09:08:12 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x6QG8CGN025774;
        Fri, 26 Jul 2019 09:08:12 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x6QG8CqP025773;
        Fri, 26 Jul 2019 09:08:12 -0700
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH 11/15] qla2xxx: Fix failed NVME port discovery after a short device port loss
Date:   Fri, 26 Jul 2019 09:07:36 -0700
Message-ID: <20190726160740.25687-12-hmadhani@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190726160740.25687-1-hmadhani@marvell.com>
References: <20190726160740.25687-1-hmadhani@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-07-26_12:2019-07-26,2019-07-26 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Arun Easi <aeasi@marvell.com>

The following sequence of event leads to NVME port disappearing:
    - device port shut
    - nvme_fc_unregister_remoteport
    - device port online
    - remote port delete completes
    - relogin is scheduled
    - "post gidpn" message appears due to rscn generation # mismatch

In short, if a device comes back online sooner than an unregister completion,
a mismatch in rscn generation number occurs, which is not handled correctly
during device relogin. Fix this by starting with a redo of GNL.

When ql2xextended_error_logging is enabled, the re-plugged device's discovery
stops with the following messages printed:

--8<--
qla2xxx [0000:41:00.0]-480d:3: Relogin scheduled.
qla2xxx [0000:41:00.0]-4800:3: DPC handler sleeping.
qla2xxx [0000:41:00.0]-2902:3: qla24xx_handle_relogin_event 21:00:00:24:ff:17:9e:91 DS 0 LS 7 P 0 del 2 cnfl
   (null) rscn 1|2 login 1|2 fl 1
qla2xxx [0000:41:00.0]-28e9:3: qla24xx_handle_relogin_event 1666 21:00:00:24:ff:17:9e:91 post gidpn
qla2xxx [0000:41:00.0]-480e:3: Relogin end.
--8<--

Signed-off-by: Arun Easi <aeasi@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
---
 drivers/scsi/qla2xxx/qla_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 1a8b4a587e0f..194a15b2f5f7 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -1687,9 +1687,9 @@ void qla24xx_handle_relogin_event(scsi_qla_host_t *vha,
 	}
 
 	if (fcport->last_rscn_gen != fcport->rscn_gen) {
-		ql_dbg(ql_dbg_disc, vha, 0x20e9, "%s %d %8phC post gidpn\n",
+		ql_dbg(ql_dbg_disc, vha, 0x20e9, "%s %d %8phC post gnl\n",
 		    __func__, __LINE__, fcport->port_name);
-
+		qla24xx_post_gnl_work(vha, fcport);
 		return;
 	}
 
-- 
2.12.0

