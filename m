Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A88CB76E9D
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jul 2019 18:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfGZQJ1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Jul 2019 12:09:27 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:11050 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726769AbfGZQJ1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 26 Jul 2019 12:09:27 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6QG72Ui026052;
        Fri, 26 Jul 2019 09:08:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=46ZzjBki8ZUchIcK4JuDwbPz2JUQbLt2d2tR7iO6piY=;
 b=cddzu7a8hsuY6AuPpSm8gE7++MPg77UDwRZKt2xr4T5+ABQUv2Eag+xlP6vFU66BdN+T
 A2znwZed8HC5CZuauFUg3UfVolwvClMtz6lR6HQ8PMbuZFogVkUBSFkXYagY8nJfPjZj
 CeEzGX/+D1I70K+98SuOFfbUFYeqX34Vo31L/pvc8E1nzWsfyu2YtUzvMcX4YHZLZhWT
 sBPqlPawCxaaPCw0gzuhbk2GG4RhWia1VMLAd+3LIx71BmECOLKSoHUvyyyRlrsimSe+
 iyEa9tp+PB45PtOfyQBoh9gKVU8yphFPAfddZ9wtF5trOznOj85h9fb2Tp3CK3TknBUi nw== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2tx6256xd6-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 26 Jul 2019 09:08:24 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 26 Jul
 2019 09:08:22 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 26 Jul 2019 09:08:22 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 5BB6E3F703F;
        Fri, 26 Jul 2019 09:08:22 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x6QG8MTZ025786;
        Fri, 26 Jul 2019 09:08:22 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x6QG8M3r025785;
        Fri, 26 Jul 2019 09:08:22 -0700
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH 14/15] qla2xxx: Allow NVME IO to resume with short cable pull
Date:   Fri, 26 Jul 2019 09:07:39 -0700
Message-ID: <20190726160740.25687-15-hmadhani@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190726160740.25687-1-hmadhani@marvell.com>
References: <20190726160740.25687-1-hmadhani@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-07-26_11:2019-07-26,2019-07-26 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

Current driver report dev_loss_tmo to 0 for NVME devices
with short cable pull.  This causes NVME controller to be freed
along with NVME namespace.  The side affect is IO would stop.
By not setting dev_loss_tmo to 0, NVME namespace would stay
until cable is plug back in.  This allows IO to resume afterward.

Signed-off-by: Arun Easi <aeasi@marvell.com>
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
---
 drivers/scsi/qla2xxx/qla_nvme.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 963094b3c300..af7919a5acdc 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -653,7 +653,9 @@ void qla_nvme_unregister_remote_port(struct fc_port *fcport)
 	    "%s: unregister remoteport on %p %8phN\n",
 	    __func__, fcport, fcport->port_name);
 
-	nvme_fc_set_remoteport_devloss(fcport->nvme_remote_port, 0);
+	if (test_bit(PFLG_DRIVER_REMOVING, &fcport->vha->pci_flags))
+		nvme_fc_set_remoteport_devloss(fcport->nvme_remote_port, 0);
+
 	init_completion(&fcport->nvme_del_done);
 	ret = nvme_fc_unregister_remoteport(fcport->nvme_remote_port);
 	if (ret)
-- 
2.12.0

