Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A927110C1
	for <lists+linux-scsi@lfdr.de>; Thu,  2 May 2019 02:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbfEBArw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 1 May 2019 20:47:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60236 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726152AbfEBArw (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 1 May 2019 20:47:52 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x420lAxI040238;
        Wed, 1 May 2019 20:47:36 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s7jaj6mam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 May 2019 20:47:36 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x41IhGSZ027427;
        Wed, 1 May 2019 18:51:31 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 2s4eq3v0gy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 May 2019 18:51:31 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x420lYVV38797588
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 May 2019 00:47:34 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A6032805A;
        Thu,  2 May 2019 00:47:34 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6E3028059;
        Thu,  2 May 2019 00:47:33 +0000 (GMT)
Received: from ltcalpine2-lp11.aus.stglabs.ibm.com (unknown [9.40.195.194])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu,  2 May 2019 00:47:33 +0000 (GMT)
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
To:     james.bottomley@hansenpartnership.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, brking@linux.ibm.com,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH 3/3] ibmvscsi: fix tripping of blk_mq_run_hw_queue WARN_ON
Date:   Wed,  1 May 2019 19:47:29 -0500
Message-Id: <20190502004729.19962-3-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190502004729.19962-1-tyreld@linux.ibm.com>
References: <20190502004729.19962-1-tyreld@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-01_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905020004
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
 drivers/scsi/ibmvscsi/ibmvscsi.c | 5 ++++-
 drivers/scsi/ibmvscsi/ibmvscsi.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index 683139e6c63f..c1d83eb5c5f7 100644
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
@@ -2125,6 +2126,7 @@ static void ibmvscsi_do_work(struct ibmvscsi_host_data *hostdata)
 	spin_lock_irqsave(hostdata->host->host_lock, flags);
 	switch (hostdata->action) {
 	case IBMVSCSI_HOST_ACTION_NONE:
+	case IBMVSCSI_HOST_ACTION_UNBLOCK:
 		break;
 	case IBMVSCSI_HOST_ACTION_RESET:
 		rc = ibmvscsi_reset_crq_queue(&hostdata->queue, hostdata);
@@ -2162,6 +2164,7 @@ static int __ibmvscsi_work_to_do(struct ibmvscsi_host_data *hostdata)
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

