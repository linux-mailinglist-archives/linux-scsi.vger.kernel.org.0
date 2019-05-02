Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59D01110C0
	for <lists+linux-scsi@lfdr.de>; Thu,  2 May 2019 02:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbfEBArj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 1 May 2019 20:47:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33812 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726152AbfEBArj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 1 May 2019 20:47:39 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x420kcTL010025
        for <linux-scsi@vger.kernel.org>; Wed, 1 May 2019 20:47:38 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s7m0yukjc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Wed, 01 May 2019 20:47:38 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-scsi@vger.kernel.org> from <tyreld@linux.ibm.com>;
        Thu, 2 May 2019 01:47:37 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 2 May 2019 01:47:34 +0100
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x420lX5133489066
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 May 2019 00:47:33 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B89CF28060;
        Thu,  2 May 2019 00:47:33 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30B7D28058;
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
Subject: [PATCH 2/3] ibmvscsi: redo driver work thread to use enum action states
Date:   Wed,  1 May 2019 19:47:28 -0500
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20190502004729.19962-1-tyreld@linux.ibm.com>
References: <20190502004729.19962-1-tyreld@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19050200-0064-0000-0000-000003D54504
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011032; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01197265; UDB=6.00627943; IPR=6.00978119;
 MB=3.00026688; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-02 00:47:36
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050200-0065-0000-0000-00003D495A80
Message-Id: <20190502004729.19962-2-tyreld@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-01_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=807 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905020004
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>

The current implemenation relies on two flags in the drivers private host
structure to signal the need for a host reset or to reenable the CRQ after a
LPAR migration. This patch does away with those flags and introduces a single
action flag and defined enums for the supported kthread work actions. Lastly,
the if/else logic is replaced with a switch statement.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvscsi.c | 57 +++++++++++++++++++++-----------
 drivers/scsi/ibmvscsi/ibmvscsi.h |  9 +++--
 2 files changed, 45 insertions(+), 21 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvscsi.c
index 1c37244f16a0..683139e6c63f 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -828,7 +828,7 @@ static void ibmvscsi_reset_host(struct ibmvscsi_host_data *hostdata)
 	atomic_set(&hostdata->request_limit, 0);
 
 	purge_requests(hostdata, DID_ERROR);
-	hostdata->reset_crq = 1;
+	hostdata->action = IBMVSCSI_HOST_ACTION_RESET;
 	wake_up(&hostdata->work_wait_q);
 }
 
@@ -1797,7 +1797,7 @@ static void ibmvscsi_handle_crq(struct viosrp_crq *crq,
 			/* We need to re-setup the interpartition connection */
 			dev_info(hostdata->dev, "Re-enabling adapter!\n");
 			hostdata->client_migrated = 1;
-			hostdata->reenable_crq = 1;
+			hostdata->action = IBMVSCSI_HOST_ACTION_REENABLE;
 			purge_requests(hostdata, DID_REQUEUE);
 			wake_up(&hostdata->work_wait_q);
 		} else {
@@ -2118,26 +2118,32 @@ static unsigned long ibmvscsi_get_desired_dma(struct vio_dev *vdev)
 
 static void ibmvscsi_do_work(struct ibmvscsi_host_data *hostdata)
 {
+	unsigned long flags;
 	int rc;
 	char *action = "reset";
 
-	if (hostdata->reset_crq) {
-		smp_rmb();
-		hostdata->reset_crq = 0;
-
+	spin_lock_irqsave(hostdata->host->host_lock, flags);
+	switch (hostdata->action) {
+	case IBMVSCSI_HOST_ACTION_NONE:
+		break;
+	case IBMVSCSI_HOST_ACTION_RESET:
 		rc = ibmvscsi_reset_crq_queue(&hostdata->queue, hostdata);
 		if (!rc)
 			rc = ibmvscsi_send_crq(hostdata, 0xC001000000000000LL, 0);
 		vio_enable_interrupts(to_vio_dev(hostdata->dev));
-	} else if (hostdata->reenable_crq) {
-		smp_rmb();
+		break;
+	case IBMVSCSI_HOST_ACTION_REENABLE:
 		action = "enable";
 		rc = ibmvscsi_reenable_crq_queue(&hostdata->queue, hostdata);
-		hostdata->reenable_crq = 0;
 		if (!rc)
 			rc = ibmvscsi_send_crq(hostdata, 0xC001000000000000LL, 0);
-	} else
-		return;
+		break;
+	default:
+		break;
+	}
+
+	hostdata->action = IBMVSCSI_HOST_ACTION_NONE;
+	spin_unlock_irqrestore(hostdata->host->host_lock, flags);
 
 	if (rc) {
 		atomic_set(&hostdata->request_limit, -1);
@@ -2147,19 +2153,32 @@ static void ibmvscsi_do_work(struct ibmvscsi_host_data *hostdata)
 	scsi_unblock_requests(hostdata->host);
 }
 
-static int ibmvscsi_work_to_do(struct ibmvscsi_host_data *hostdata)
+static int __ibmvscsi_work_to_do(struct ibmvscsi_host_data *hostdata)
 {
 	if (kthread_should_stop())
 		return 1;
-	else if (hostdata->reset_crq) {
-		smp_rmb();
-		return 1;
-	} else if (hostdata->reenable_crq) {
-		smp_rmb();
-		return 1;
+	switch (hostdata->action) {
+	case IBMVSCSI_HOST_ACTION_NONE:
+		return 0;
+	case IBMVSCSI_HOST_ACTION_RESET:
+	case IBMVSCSI_HOST_ACTION_REENABLE:
+	default:
+		break;
 	}
 
-	return 0;
+	return 1;
+}
+
+static int ibmvscsi_work_to_do(struct ibmvscsi_host_data *hostdata)
+{
+	unsigned long flags;
+	int rc;
+
+	spin_lock_irqsave(hostdata->host->host_lock, flags);
+	rc = __ibmvscsi_work_to_do(hostdata);
+	spin_unlock_irqrestore(hostdata->host->host_lock, flags);
+
+	return rc;
 }
 
 static int ibmvscsi_work(void *data)
diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.h b/drivers/scsi/ibmvscsi/ibmvscsi.h
index 3a7875575616..04bcbc832dc9 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.h
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.h
@@ -88,13 +88,18 @@ struct event_pool {
 	dma_addr_t iu_token;
 };
 
+enum ibmvscsi_host_action {
+	IBMVSCSI_HOST_ACTION_NONE = 0,
+	IBMVSCSI_HOST_ACTION_RESET,
+	IBMVSCSI_HOST_ACTION_REENABLE,
+};
+
 /* all driver data associated with a host adapter */
 struct ibmvscsi_host_data {
 	struct list_head host_list;
 	atomic_t request_limit;
 	int client_migrated;
-	int reset_crq;
-	int reenable_crq;
+	enum ibmvscsi_host_action action;
 	struct device *dev;
 	struct event_pool pool;
 	struct crq_queue queue;
-- 
2.18.1

