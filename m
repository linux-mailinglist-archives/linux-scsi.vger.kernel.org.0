Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22B87AA547
	for <lists+linux-scsi@lfdr.de>; Fri, 22 Sep 2023 00:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjIUWy4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 21 Sep 2023 18:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjIUWyv (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 21 Sep 2023 18:54:51 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA65A91
        for <linux-scsi@vger.kernel.org>; Thu, 21 Sep 2023 15:54:43 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38LMcPem027344;
        Thu, 21 Sep 2023 22:54:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=sYV91EpsYSDRuiDEMboKRrYHn6Te9LADut9iEozt/qc=;
 b=BkA15sxdU+A5LxZQ3HUkjVYAYHidopcIs2pr3+J5Cq1ZEHgYVBXAs/3tzEgNFAG5PCz9
 t3bj+KDHNAKTbA3KnCimTYB6pAp64bKqCcuYR7V/Tws9QiYEHRxB1Yg4BS0AwETx9VaG
 EilKrtxpys1Ttk9JE6cJ7PnUljLL9TF5UAAnzc8ASj+xhE0ulQwvp/BsSGlL0sy388nn
 HCqSvtpYoss9EfEEsTzbrzrD1JyiUk+EQoIWVSA/QYFwkSfWKLEqBowe8YGnFXvUnETK
 kknH4Kry3psyLR+3DSN767+0/5vlKGSfzZf1/X+vTBfU309brMttjPwy+wjTyfJP4nXi Ow== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t8w11u5ms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 22:54:39 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38LLx6Zn025947;
        Thu, 21 Sep 2023 22:54:38 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t8tspm6v5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 22:54:38 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38LMsc0k9110146
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 22:54:38 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4EAE58051;
        Thu, 21 Sep 2023 22:54:37 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2D735805E;
        Thu, 21 Sep 2023 22:54:37 +0000 (GMT)
Received: from vios4361.aus.stglabs.ibm.com (unknown [9.3.43.61])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 21 Sep 2023 22:54:37 +0000 (GMT)
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
To:     martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, brking@linux.ibm.com,
        james.bottomley@hansenpartnership.com,
        Tyrel Datwyler <tyreld@linux.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>
Subject: [PATCH v2 02/11] ibmvfc: implement channel queue depth and event buffer accounting
Date:   Thu, 21 Sep 2023 17:54:26 -0500
Message-Id: <20230921225435.3537728-3-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230921225435.3537728-1-tyreld@linux.ibm.com>
References: <20230921225435.3537728-1-tyreld@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5B4w4xndLylatTgx2odJmBi7auwq5B9S
X-Proofpoint-GUID: 5B4w4xndLylatTgx2odJmBi7auwq5B9S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_19,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 phishscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309210196
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Extend ibmvfc_queue, ibmvfc_event, and ibmvfc_event_pool to provide
queue depths for general IO commands and reserved commands as well as
proper accounting of the free events of each type from the general event
pool. Further, calculate the negotiated max command limit with the VIOS
at NPIV login time as a function of the number of queues times their
total queue depth (general and reserved depths combined).

This does away with the legacy max_request value, and allows the driver
to better manage and track it resources.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
Reviewed-by: Brian King <brking@linux.vnet.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 112 +++++++++++++++++++++------------
 drivers/scsi/ibmvscsi/ibmvfc.h |   9 +++
 2 files changed, 80 insertions(+), 41 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index 712d109cb558..6d66a416c44e 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -38,6 +38,7 @@ static unsigned int default_timeout = IBMVFC_DEFAULT_TIMEOUT;
 static u64 max_lun = IBMVFC_MAX_LUN;
 static unsigned int max_targets = IBMVFC_MAX_TARGETS;
 static unsigned int max_requests = IBMVFC_MAX_REQUESTS_DEFAULT;
+static u16 scsi_qdepth = IBMVFC_SCSI_QDEPTH;
 static unsigned int disc_threads = IBMVFC_MAX_DISC_THREADS;
 static unsigned int ibmvfc_debug = IBMVFC_DEBUG;
 static unsigned int log_level = IBMVFC_DEFAULT_LOG_LEVEL;
@@ -83,6 +84,9 @@ MODULE_PARM_DESC(default_timeout,
 module_param_named(max_requests, max_requests, uint, S_IRUGO);
 MODULE_PARM_DESC(max_requests, "Maximum requests for this adapter. "
 		 "[Default=" __stringify(IBMVFC_MAX_REQUESTS_DEFAULT) "]");
+module_param_named(scsi_qdepth, scsi_qdepth, ushort, S_IRUGO);
+MODULE_PARM_DESC(scsi_qdepth, "Maximum scsi command depth per adapter queue. "
+		 "[Default=" __stringify(IBMVFC_SCSI_QDEPTH) "]");
 module_param_named(max_lun, max_lun, ullong, S_IRUGO);
 MODULE_PARM_DESC(max_lun, "Maximum allowed LUN. "
 		 "[Default=" __stringify(IBMVFC_MAX_LUN) "]");
@@ -776,28 +780,26 @@ static int ibmvfc_send_crq_init_complete(struct ibmvfc_host *vhost)
  * ibmvfc_init_event_pool - Allocates and initializes the event pool for a host
  * @vhost:	ibmvfc host who owns the event pool
  * @queue:      ibmvfc queue struct
- * @size:       pool size
  *
  * Returns zero on success.
  **/
 static int ibmvfc_init_event_pool(struct ibmvfc_host *vhost,
-				  struct ibmvfc_queue *queue,
-				  unsigned int size)
+				  struct ibmvfc_queue *queue)
 {
 	int i;
 	struct ibmvfc_event_pool *pool = &queue->evt_pool;
 
 	ENTER;
-	if (!size)
+	if (!queue->total_depth)
 		return 0;
 
-	pool->size = size;
-	pool->events = kcalloc(size, sizeof(*pool->events), GFP_KERNEL);
+	pool->size = queue->total_depth;
+	pool->events = kcalloc(pool->size, sizeof(*pool->events), GFP_KERNEL);
 	if (!pool->events)
 		return -ENOMEM;
 
 	pool->iu_storage = dma_alloc_coherent(vhost->dev,
-					      size * sizeof(*pool->iu_storage),
+					      pool->size * sizeof(*pool->iu_storage),
 					      &pool->iu_token, 0);
 
 	if (!pool->iu_storage) {
@@ -807,9 +809,11 @@ static int ibmvfc_init_event_pool(struct ibmvfc_host *vhost,
 
 	INIT_LIST_HEAD(&queue->sent);
 	INIT_LIST_HEAD(&queue->free);
+	queue->evt_free = queue->evt_depth;
+	queue->reserved_free = queue->reserved_depth;
 	spin_lock_init(&queue->l_lock);
 
-	for (i = 0; i < size; ++i) {
+	for (i = 0; i < pool->size; ++i) {
 		struct ibmvfc_event *evt = &pool->events[i];
 
 		/*
@@ -1033,6 +1037,12 @@ static void ibmvfc_free_event(struct ibmvfc_event *evt)
 
 	spin_lock_irqsave(&evt->queue->l_lock, flags);
 	list_add_tail(&evt->queue_list, &evt->queue->free);
+	if (evt->reserved) {
+		evt->reserved = 0;
+		evt->queue->reserved_free++;
+	} else {
+		evt->queue->evt_free++;
+	}
 	if (evt->eh_comp)
 		complete(evt->eh_comp);
 	spin_unlock_irqrestore(&evt->queue->l_lock, flags);
@@ -1475,6 +1485,12 @@ static void ibmvfc_set_login_info(struct ibmvfc_host *vhost)
 	struct ibmvfc_queue *async_crq = &vhost->async_crq;
 	struct device_node *of_node = vhost->dev->of_node;
 	const char *location;
+	u16 max_cmds;
+
+	max_cmds = scsi_qdepth + IBMVFC_NUM_INTERNAL_REQ;
+	if (mq_enabled)
+		max_cmds += (scsi_qdepth + IBMVFC_NUM_INTERNAL_SUBQ_REQ) *
+			vhost->client_scsi_channels;
 
 	memset(login_info, 0, sizeof(*login_info));
 
@@ -1489,7 +1505,7 @@ static void ibmvfc_set_login_info(struct ibmvfc_host *vhost)
 	if (vhost->client_migrated)
 		login_info->flags |= cpu_to_be16(IBMVFC_CLIENT_MIGRATED);
 
-	login_info->max_cmds = cpu_to_be32(max_requests + IBMVFC_NUM_INTERNAL_REQ);
+	login_info->max_cmds = cpu_to_be32(max_cmds);
 	login_info->capabilities = cpu_to_be64(IBMVFC_CAN_MIGRATE | IBMVFC_CAN_SEND_VF_WWPN);
 
 	if (vhost->mq_enabled || vhost->using_channels)
@@ -1508,29 +1524,39 @@ static void ibmvfc_set_login_info(struct ibmvfc_host *vhost)
 }
 
 /**
- * ibmvfc_get_event - Gets the next free event in pool
+ * __ibmvfc_get_event - Gets the next free event in pool
  * @queue:      ibmvfc queue struct
+ * @reserved:	event is for a reserved management command
  *
  * Returns a free event from the pool.
  **/
-static struct ibmvfc_event *ibmvfc_get_event(struct ibmvfc_queue *queue)
+static struct ibmvfc_event *__ibmvfc_get_event(struct ibmvfc_queue *queue, int reserved)
 {
-	struct ibmvfc_event *evt;
+	struct ibmvfc_event *evt = NULL;
 	unsigned long flags;
 
 	spin_lock_irqsave(&queue->l_lock, flags);
-	if (list_empty(&queue->free)) {
-		ibmvfc_log(queue->vhost, 4, "empty event pool on queue:%ld\n", queue->hwq_id);
-		spin_unlock_irqrestore(&queue->l_lock, flags);
-		return NULL;
+	if (reserved && queue->reserved_free) {
+		evt = list_entry(queue->free.next, struct ibmvfc_event, queue_list);
+		evt->reserved = 1;
+		queue->reserved_free--;
+	} else if (queue->evt_free) {
+		evt = list_entry(queue->free.next, struct ibmvfc_event, queue_list);
+		queue->evt_free--;
+	} else {
+		goto out;
 	}
-	evt = list_entry(queue->free.next, struct ibmvfc_event, queue_list);
+
 	atomic_set(&evt->free, 0);
 	list_del(&evt->queue_list);
+out:
 	spin_unlock_irqrestore(&queue->l_lock, flags);
 	return evt;
 }
 
+#define ibmvfc_get_event(queue) __ibmvfc_get_event(queue, 0)
+#define ibmvfc_get_reserved_event(queue) __ibmvfc_get_event(queue, 1)
+
 /**
  * ibmvfc_locked_done - Calls evt completion with host_lock held
  * @evt:	ibmvfc evt to complete
@@ -2047,7 +2073,7 @@ static int ibmvfc_bsg_timeout(struct bsg_job *job)
 	}
 
 	vhost->aborting_passthru = 1;
-	evt = ibmvfc_get_event(&vhost->crq);
+	evt = ibmvfc_get_reserved_event(&vhost->crq);
 	if (!evt) {
 		spin_unlock_irqrestore(vhost->host->host_lock, flags);
 		return -ENOMEM;
@@ -2110,7 +2136,7 @@ static int ibmvfc_bsg_plogi(struct ibmvfc_host *vhost, unsigned int port_id)
 	if (unlikely((rc = ibmvfc_host_chkready(vhost))))
 		goto unlock_out;
 
-	evt = ibmvfc_get_event(&vhost->crq);
+	evt = ibmvfc_get_reserved_event(&vhost->crq);
 	if (!evt) {
 		rc = -ENOMEM;
 		goto unlock_out;
@@ -2232,7 +2258,7 @@ static int ibmvfc_bsg_request(struct bsg_job *job)
 		goto out;
 	}
 
-	evt = ibmvfc_get_event(&vhost->crq);
+	evt = ibmvfc_get_reserved_event(&vhost->crq);
 	if (!evt) {
 		spin_unlock_irqrestore(vhost->host->host_lock, flags);
 		rc = -ENOMEM;
@@ -2533,7 +2559,7 @@ static struct ibmvfc_event *ibmvfc_init_tmf(struct ibmvfc_queue *queue,
 	struct ibmvfc_event *evt;
 	struct ibmvfc_tmf *tmf;
 
-	evt = ibmvfc_get_event(queue);
+	evt = ibmvfc_get_reserved_event(queue);
 	if (!evt)
 		return NULL;
 	ibmvfc_init_event(evt, ibmvfc_sync_completion, IBMVFC_MAD_FORMAT);
@@ -3673,7 +3699,6 @@ static const struct scsi_host_template driver_template = {
 	.max_sectors = IBMVFC_MAX_SECTORS,
 	.shost_groups = ibmvfc_host_groups,
 	.track_queue_depth = 1,
-	.host_tagset = 1,
 };
 
 /**
@@ -4071,7 +4096,7 @@ static void ibmvfc_tgt_send_prli(struct ibmvfc_target *tgt)
 		return;
 
 	kref_get(&tgt->kref);
-	evt = ibmvfc_get_event(&vhost->crq);
+	evt = ibmvfc_get_reserved_event(&vhost->crq);
 	if (!evt) {
 		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_NONE);
 		kref_put(&tgt->kref, ibmvfc_release_tgt);
@@ -4184,7 +4209,7 @@ static void ibmvfc_tgt_send_plogi(struct ibmvfc_target *tgt)
 
 	kref_get(&tgt->kref);
 	tgt->logo_rcvd = 0;
-	evt = ibmvfc_get_event(&vhost->crq);
+	evt = ibmvfc_get_reserved_event(&vhost->crq);
 	if (!evt) {
 		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_NONE);
 		kref_put(&tgt->kref, ibmvfc_release_tgt);
@@ -4266,7 +4291,7 @@ static struct ibmvfc_event *__ibmvfc_tgt_get_implicit_logout_evt(struct ibmvfc_t
 	struct ibmvfc_event *evt;
 
 	kref_get(&tgt->kref);
-	evt = ibmvfc_get_event(&vhost->crq);
+	evt = ibmvfc_get_reserved_event(&vhost->crq);
 	if (!evt)
 		return NULL;
 	ibmvfc_init_event(evt, done, IBMVFC_MAD_FORMAT);
@@ -4441,7 +4466,7 @@ static void ibmvfc_tgt_move_login(struct ibmvfc_target *tgt)
 		return;
 
 	kref_get(&tgt->kref);
-	evt = ibmvfc_get_event(&vhost->crq);
+	evt = ibmvfc_get_reserved_event(&vhost->crq);
 	if (!evt) {
 		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_DEL_RPORT);
 		kref_put(&tgt->kref, ibmvfc_release_tgt);
@@ -4613,7 +4638,7 @@ static void ibmvfc_adisc_timeout(struct timer_list *t)
 
 	vhost->abort_threads++;
 	kref_get(&tgt->kref);
-	evt = ibmvfc_get_event(&vhost->crq);
+	evt = ibmvfc_get_reserved_event(&vhost->crq);
 	if (!evt) {
 		tgt_err(tgt, "Failed to get cancel event for ADISC.\n");
 		vhost->abort_threads--;
@@ -4671,7 +4696,7 @@ static void ibmvfc_tgt_adisc(struct ibmvfc_target *tgt)
 		return;
 
 	kref_get(&tgt->kref);
-	evt = ibmvfc_get_event(&vhost->crq);
+	evt = ibmvfc_get_reserved_event(&vhost->crq);
 	if (!evt) {
 		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_NONE);
 		kref_put(&tgt->kref, ibmvfc_release_tgt);
@@ -4780,7 +4805,7 @@ static void ibmvfc_tgt_query_target(struct ibmvfc_target *tgt)
 		return;
 
 	kref_get(&tgt->kref);
-	evt = ibmvfc_get_event(&vhost->crq);
+	evt = ibmvfc_get_reserved_event(&vhost->crq);
 	if (!evt) {
 		ibmvfc_set_tgt_action(tgt, IBMVFC_TGT_ACTION_NONE);
 		kref_put(&tgt->kref, ibmvfc_release_tgt);
@@ -4958,7 +4983,7 @@ static void ibmvfc_discover_targets_done(struct ibmvfc_event *evt)
 static void ibmvfc_discover_targets(struct ibmvfc_host *vhost)
 {
 	struct ibmvfc_discover_targets *mad;
-	struct ibmvfc_event *evt = ibmvfc_get_event(&vhost->crq);
+	struct ibmvfc_event *evt = ibmvfc_get_reserved_event(&vhost->crq);
 	int level = IBMVFC_DEFAULT_LOG_LEVEL;
 
 	if (!evt) {
@@ -5039,7 +5064,7 @@ static void ibmvfc_channel_setup(struct ibmvfc_host *vhost)
 {
 	struct ibmvfc_channel_setup_mad *mad;
 	struct ibmvfc_channel_setup *setup_buf = vhost->channel_setup_buf;
-	struct ibmvfc_event *evt = ibmvfc_get_event(&vhost->crq);
+	struct ibmvfc_event *evt = ibmvfc_get_reserved_event(&vhost->crq);
 	struct ibmvfc_scsi_channels *scrqs = &vhost->scsi_scrqs;
 	unsigned int num_channels =
 		min(vhost->client_scsi_channels, vhost->max_vios_scsi_channels);
@@ -5112,7 +5137,7 @@ static void ibmvfc_channel_enquiry_done(struct ibmvfc_event *evt)
 static void ibmvfc_channel_enquiry(struct ibmvfc_host *vhost)
 {
 	struct ibmvfc_channel_enquiry *mad;
-	struct ibmvfc_event *evt = ibmvfc_get_event(&vhost->crq);
+	struct ibmvfc_event *evt = ibmvfc_get_reserved_event(&vhost->crq);
 	int level = IBMVFC_DEFAULT_LOG_LEVEL;
 
 	if (!evt) {
@@ -5240,7 +5265,7 @@ static void ibmvfc_npiv_login_done(struct ibmvfc_event *evt)
 static void ibmvfc_npiv_login(struct ibmvfc_host *vhost)
 {
 	struct ibmvfc_npiv_login_mad *mad;
-	struct ibmvfc_event *evt = ibmvfc_get_event(&vhost->crq);
+	struct ibmvfc_event *evt = ibmvfc_get_reserved_event(&vhost->crq);
 
 	if (!evt) {
 		ibmvfc_dbg(vhost, "NPIV Login failed: no available events\n");
@@ -5311,7 +5336,7 @@ static void ibmvfc_npiv_logout(struct ibmvfc_host *vhost)
 	struct ibmvfc_npiv_logout_mad *mad;
 	struct ibmvfc_event *evt;
 
-	evt = ibmvfc_get_event(&vhost->crq);
+	evt = ibmvfc_get_reserved_event(&vhost->crq);
 	if (!evt) {
 		ibmvfc_dbg(vhost, "NPIV Logout failed: no available events\n");
 		ibmvfc_hard_reset_host(vhost);
@@ -5765,7 +5790,6 @@ static int ibmvfc_alloc_queue(struct ibmvfc_host *vhost,
 {
 	struct device *dev = vhost->dev;
 	size_t fmt_size;
-	unsigned int pool_size = 0;
 
 	ENTER;
 	spin_lock_init(&queue->_lock);
@@ -5774,7 +5798,9 @@ static int ibmvfc_alloc_queue(struct ibmvfc_host *vhost,
 	switch (fmt) {
 	case IBMVFC_CRQ_FMT:
 		fmt_size = sizeof(*queue->msgs.crq);
-		pool_size = max_requests + IBMVFC_NUM_INTERNAL_REQ;
+		queue->total_depth = scsi_qdepth + IBMVFC_NUM_INTERNAL_REQ;
+		queue->evt_depth = scsi_qdepth;
+		queue->reserved_depth = IBMVFC_NUM_INTERNAL_REQ;
 		break;
 	case IBMVFC_ASYNC_FMT:
 		fmt_size = sizeof(*queue->msgs.async);
@@ -5782,14 +5808,17 @@ static int ibmvfc_alloc_queue(struct ibmvfc_host *vhost,
 	case IBMVFC_SUB_CRQ_FMT:
 		fmt_size = sizeof(*queue->msgs.scrq);
 		/* We need one extra event for Cancel Commands */
-		pool_size = max_requests + 1;
+		queue->total_depth = scsi_qdepth + IBMVFC_NUM_INTERNAL_SUBQ_REQ;
+		queue->evt_depth = scsi_qdepth;
+		queue->reserved_depth = IBMVFC_NUM_INTERNAL_SUBQ_REQ;
 		break;
 	default:
 		dev_warn(dev, "Unknown command/response queue message format: %d\n", fmt);
 		return -EINVAL;
 	}
 
-	if (ibmvfc_init_event_pool(vhost, queue, pool_size)) {
+	queue->fmt = fmt;
+	if (ibmvfc_init_event_pool(vhost, queue)) {
 		dev_err(dev, "Couldn't initialize event pool.\n");
 		return -ENOMEM;
 	}
@@ -5808,7 +5837,6 @@ static int ibmvfc_alloc_queue(struct ibmvfc_host *vhost,
 	}
 
 	queue->cur = 0;
-	queue->fmt = fmt;
 	queue->size = PAGE_SIZE / fmt_size;
 
 	queue->vhost = vhost;
@@ -6243,7 +6271,7 @@ static int ibmvfc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 	}
 
 	shost->transportt = ibmvfc_transport_template;
-	shost->can_queue = max_requests;
+	shost->can_queue = scsi_qdepth;
 	shost->max_lun = max_lun;
 	shost->max_id = max_targets;
 	shost->max_sectors = IBMVFC_MAX_SECTORS;
@@ -6402,7 +6430,9 @@ static int ibmvfc_resume(struct device *dev)
  */
 static unsigned long ibmvfc_get_desired_dma(struct vio_dev *vdev)
 {
-	unsigned long pool_dma = max_requests * sizeof(union ibmvfc_iu);
+	unsigned long pool_dma;
+
+	pool_dma = (IBMVFC_MAX_SCSI_QUEUES * scsi_qdepth) * sizeof(union ibmvfc_iu);
 	return pool_dma + ((512 * 1024) * driver_template.cmd_per_lun);
 }
 
diff --git a/drivers/scsi/ibmvscsi/ibmvfc.h b/drivers/scsi/ibmvscsi/ibmvfc.h
index c39a245f43d0..0e641a880e1c 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.h
+++ b/drivers/scsi/ibmvscsi/ibmvfc.h
@@ -27,6 +27,7 @@
 #define IBMVFC_ABORT_TIMEOUT		8
 #define IBMVFC_ABORT_WAIT_TIMEOUT	40
 #define IBMVFC_MAX_REQUESTS_DEFAULT	100
+#define IBMVFC_SCSI_QDEPTH		128
 
 #define IBMVFC_DEBUG			0
 #define IBMVFC_MAX_TARGETS		1024
@@ -57,6 +58,8 @@
  * 2 for each discovery thread
  */
 #define IBMVFC_NUM_INTERNAL_REQ	(1 + 1 + 1 + 2 + (disc_threads * 2))
+/* Reserved suset of events for cancelling channelized IO commands */
+#define IBMVFC_NUM_INTERNAL_SUBQ_REQ 4
 
 #define IBMVFC_MAD_SUCCESS		0x00
 #define IBMVFC_MAD_NOT_SUPPORTED	0xF1
@@ -758,6 +761,7 @@ struct ibmvfc_event {
 	struct completion *eh_comp;
 	struct timer_list timer;
 	u16 hwq;
+	u8 reserved;
 };
 
 /* a pool of event structs for use */
@@ -793,6 +797,11 @@ struct ibmvfc_queue {
 	struct ibmvfc_event_pool evt_pool;
 	struct list_head sent;
 	struct list_head free;
+	u16 total_depth;
+	u16 evt_depth;
+	u16 reserved_depth;
+	u16 evt_free;
+	u16 reserved_free;
 	spinlock_t l_lock;
 
 	union ibmvfc_iu cancel_rsp;
-- 
2.31.1

