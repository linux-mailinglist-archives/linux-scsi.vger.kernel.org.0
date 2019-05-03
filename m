Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0D5125C6
	for <lists+linux-scsi@lfdr.de>; Fri,  3 May 2019 02:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfECAvM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 2 May 2019 20:51:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54844 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726328AbfECAvL (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 2 May 2019 20:51:11 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x430lcZi135743;
        Thu, 2 May 2019 20:51:04 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s8aj2hj8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 May 2019 20:51:04 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x42IsHxw013591;
        Thu, 2 May 2019 18:55:02 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01dal.us.ibm.com with ESMTP id 2s4eq3wvr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 May 2019 18:55:01 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x430p2kF24183006
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 May 2019 00:51:02 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7071628058;
        Fri,  3 May 2019 00:51:02 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDA6D2805A;
        Fri,  3 May 2019 00:51:01 +0000 (GMT)
Received: from ltcalpine2-lp11.aus.stglabs.ibm.com (unknown [9.40.195.194])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  3 May 2019 00:51:01 +0000 (GMT)
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
To:     james.bottomley@hansenpartnership.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, brking@linux.ibm.com,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v2 3/3] ibmvscsi: fix tripping of blk_mq_run_hw_queue WARN_ON
Date:   Thu,  2 May 2019 19:50:58 -0500
Message-Id: <20190503005058.8768-3-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190503005058.8768-1-tyreld@linux.ibm.com>
References: <20190503005058.8768-1-tyreld@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-02_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905030003
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

After a successful SRP login response we call scsi_unblock_requests() to
kick any pending IO's. The callback to process this SRP response happens in
a tasklet and therefore is in softirq context. The result of such is
that when blk-mq is enabled it is no longer safe to call
scsi_unblock_requests() from this context. The result of duing so
triggers the following WARN_ON splat in dmesg after a host reset or CRQ
reenablement.

WARNING: CPU: 0 PID: 0 at block/blk-mq.c:1375 __blk_mq_run_hw_queue+0x120/0x180
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.0.0-rc8 #4
NIP [c0000000009771e0] __blk_mq_run_hw_queue+0x120/0x180
LR [c000000000977484] __blk_mq_delay_run_hw_queue+0x244/0x250
Call Trace:

__blk_mq_delay_run_hw_queue+0x244/0x250
blk_mq_run_hw_queue+0x8c/0x1c0
blk_mq_run_hw_queues+0x60/0x90
scsi_run_queue+0x1e4/0x3b0
scsi_run_host_queues+0x48/0x80
login_rsp+0xb0/0x100
ibmvscsi_handle_crq+0x30c/0x3e0
ibmvscsi_task+0x54/0xe0
tasklet_action_common.isra.3+0xc4/0x1a0
__do_softirq+0x174/0x3f4
irq_exit+0xf0/0x120
__do_irq+0xb0/0x210
call_do_irq+0x14/0x24
do_IRQ+0x9c/0x130
hardware_interrupt_common+0x14c/0x150

This patch fixes the issue by introducing a new host action for
unblocking the scsi requests in our seperate work thread.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
Changes in v2:
	no change

 drivers/scsi/ibmvscsi/ibmvscsi.c | 5 ++++-
 drivers/scsi/ibmvscsi/ibmvscsi.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index 8df82c58e7b9..727c31dc11a0 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -1179,7 +1179,8 @@ static void login_rsp(struct srp_event_struct *evt_struct)
 		   be32_to_cpu(evt_struct->xfer_iu->srp.login_rsp.req_lim_delta));
 
 	/* If we had any pending I/Os, kick them */
-	scsi_unblock_requests(hostdata->host);
+	hostdata->action = IBMVSCSI_HOST_ACTION_UNBLOCK;
+	wake_up(&hostdata->work_wait_q);
 }
 
 /**
@@ -2123,6 +2124,7 @@ static void ibmvscsi_do_work(struct ibmvscsi_host_data *hostdata)
 	spin_lock_irqsave(hostdata->host->host_lock, flags);
 	switch (hostdata->action) {
 	case IBMVSCSI_HOST_ACTION_NONE:
+	case IBMVSCSI_HOST_ACTION_UNBLOCK:
 		break;
 	case IBMVSCSI_HOST_ACTION_RESET:
 		spin_unlock_irqrestore(hostdata->host->host_lock, flags);
@@ -2164,6 +2166,7 @@ static int __ibmvscsi_work_to_do(struct ibmvscsi_host_data *hostdata)
 		return 0;
 	case IBMVSCSI_HOST_ACTION_RESET:
 	case IBMVSCSI_HOST_ACTION_REENABLE:
+	case IBMVSCSI_HOST_ACTION_UNBLOCK:
 	default:
 		break;
 	}
diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.h b/drivers/scsi/ibmvscsi/ibmvscsi.h
index 04bcbc832dc9..d9bf502334ba 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.h
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.h
@@ -92,6 +92,7 @@ enum ibmvscsi_host_action {
 	IBMVSCSI_HOST_ACTION_NONE = 0,
 	IBMVSCSI_HOST_ACTION_RESET,
 	IBMVSCSI_HOST_ACTION_REENABLE,
+	IBMVSCSI_HOST_ACTION_UNBLOCK,
 };
 
 /* all driver data associated with a host adapter */
-- 
2.18.1

