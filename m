Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0254A195907
	for <lists+linux-scsi@lfdr.de>; Fri, 27 Mar 2020 15:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgC0OdC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 27 Mar 2020 10:33:02 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:24980 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726518AbgC0OdC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 27 Mar 2020 10:33:02 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02REW05u002932
        for <linux-scsi@vger.kernel.org>; Fri, 27 Mar 2020 07:33:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=0e5dnP2BSTJy/jbpWlCfdqjhTEjJqddzZdD3Awisgq8=;
 b=R7JdxfLpu+H8OL1QcAyPhyI917OVV72ETIxHnBnAHLvo41s1+lhwzHHgXOMB17kVNbZN
 KVjMlf9CggePu7YisXwA2mYyXwGtspDHruI2m2RBh1GC/nqEe8PWn4X2wmRVBkFPwf+D
 ew/nB9udLFxDUUQb6OgwuwAxIupa78HNzkzyJhhQ4ApLNMySnri245BN5MlMpxYymvOU
 KYGUWqkr4m3TE3N/WWVBBz37SiZ9gMaAF8HIEUlHZ4vDAixv4CWY6BR5SKlQXDN46Jqw
 H68jN2GJVo72YN3AKOfL+dLOCYIj5lbKxW2cvp0Dj1SpxNFnQgdXsWIPOGVQpW4fVv15 bg== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 300bpd1gdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Fri, 27 Mar 2020 07:33:01 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 27 Mar
 2020 07:32:58 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 27 Mar 2020 07:32:58 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id D3FD43F703F;
        Fri, 27 Mar 2020 07:32:58 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 02REWwQd027335;
        Fri, 27 Mar 2020 07:32:58 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 02REWwtq027334;
        Fri, 27 Mar 2020 07:32:58 -0700
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH v2 3/3] qla2xxx: delete all sessions before unregister local nvme port
Date:   Fri, 27 Mar 2020 07:32:48 -0700
Message-ID: <20200327143248.27288-4-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20200327143248.27288-1-njavali@marvell.com>
References: <20200327143248.27288-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-27_05:2020-03-27,2020-03-27 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

Delete all sessions before unregistering local nvme port.  This
allows nvme layer to decrement all active rport count down to zero.
Once the count is down to zero, nvme would call qla to continue with
the npiv port deletion.

PID: 27448  TASK: ffff9e34b777c1c0  CPU: 0   COMMAND: "qaucli"
 0 [ffff9e25e84abbd8] __schedule at ffffffff977858ca
 1 [ffff9e25e84abc68] schedule at ffffffff97785d79
 2 [ffff9e25e84abc78] schedule_timeout at ffffffff97783881
 3 [ffff9e25e84abd28] wait_for_completion at ffffffff9778612d
 4 [ffff9e25e84abd88] qla_nvme_delete at ffffffffc0e3024e [qla2xxx]
 5 [ffff9e25e84abda8] qla24xx_vport_delete at ffffffffc0e024b9 [qla2xxx]
 6 [ffff9e25e84abdf0] fc_vport_terminate at ffffffffc011c247 [scsi_transport_fc]
 7 [ffff9e25e84abe28] store_fc_host_vport_delete at ffffffffc011cd94 [scsi_transport_fc]
 8 [ffff9e25e84abe70] dev_attr_store at ffffffff974b376b
 9 [ffff9e25e84abe80] sysfs_kf_write at ffffffff972d9a92
10 [ffff9e25e84abe90] kernfs_fop_write at ffffffff972d907b
11 [ffff9e25e84abec8] vfs_write at ffffffff9724c790
12 [ffff9e25e84abf08] sys_write at ffffffff9724d55f
13 [ffff9e25e84abf50] system_call_fastpath at ffffffff97792ed2
    RIP: 00007fc0bd81a6fd  RSP: 00007ffff78d9648  RFLAGS: 00010202
    RAX: 0000000000000001  RBX: 0000000000000022  RCX: 00007ffff78d96e0
    RDX: 0000000000000022  RSI: 00007ffff78d94e0  RDI: 0000000000000008
    RBP: 00007ffff78d9440   R8: 0000000000000000   R9: 00007fc0bd48b2cd
    R10: 0000000000000017  R11: 0000000000000293  R12: 0000000000000000
    R13: 00005624e4dac840  R14: 00005624e4da9a10  R15: 0000000000000000
    ORIG_RAX: 0000000000000001  CS: 0033  SS: 002b

Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
index 3a5f6f27587e..4cfebf34ad7c 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -3055,11 +3055,11 @@ qla24xx_vport_delete(struct fc_vport *fc_vport)
 	    test_bit(FCPORT_UPDATE_NEEDED, &vha->dpc_flags))
 		msleep(1000);
 
-	qla_nvme_delete(vha);
 
 	qla24xx_disable_vp(vha);
 	qla2x00_wait_for_sess_deletion(vha);
 
+	qla_nvme_delete(vha);
 	vha->flags.delete_progress = 1;
 
 	qlt_remove_target(ha, vha);
-- 
2.19.0.rc0

