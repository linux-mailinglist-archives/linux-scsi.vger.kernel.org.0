Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A9B2F240E
	for <lists+linux-scsi@lfdr.de>; Tue, 12 Jan 2021 01:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405533AbhALAZp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 11 Jan 2021 19:25:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32696 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403853AbhAKXNU (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 11 Jan 2021 18:13:20 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10BN3Jtv109839;
        Mon, 11 Jan 2021 18:12:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=KuKVw+l4AKfXXo1oLHlINLaq9JT/aeLO017xRvNUuos=;
 b=Mh6tAdxax+d4LBQv47QWEwanub4jsCePsvswQ/3fLtE+n8aXEw6AyGT6z1RUoNC5GRxe
 MRnsnWkmF58qcmYAJClEI51rXhmMirI5ikE0KeWLm7HRelRS5RhFPZIHLTkTDjh6MCIe
 VtdVoAGw6tmCEQaRbzJ4Ugyv60rIz9GP/kSiM9n85Aso//l0/8IPZLOh4txvecSItIgg
 mO8hvQFy82Dxf6TS+QQbVVdhF+3QT/5DVvnUvIwPajg9u49SC8HeTc3U9QGpDrEIfY/R
 gIUrtW2Bl4AmVyMIUnVbYheMzPKi2zGvBh2kVdA/gi1EQEttC31PaTnXf5iou/LY44B/ /g== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 360y9ksbuq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jan 2021 18:12:33 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10BN7v6d022232;
        Mon, 11 Jan 2021 23:12:32 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma01dal.us.ibm.com with ESMTP id 35y448xesk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jan 2021 23:12:32 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10BNCUBX28246430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jan 2021 23:12:30 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3DBA78068;
        Mon, 11 Jan 2021 23:12:30 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51B647805C;
        Mon, 11 Jan 2021 23:12:30 +0000 (GMT)
Received: from vios4361.aus.stglabs.ibm.com (unknown [9.3.43.61])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 11 Jan 2021 23:12:30 +0000 (GMT)
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
To:     james.bottomley@hansenpartnership.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        brking@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v4 06/21] ibmvfc: add Subordinate CRQ definitions
Date:   Mon, 11 Jan 2021 17:12:10 -0600
Message-Id: <20210111231225.105347-7-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210111231225.105347-1-tyreld@linux.ibm.com>
References: <20210111231225.105347-1-tyreld@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-11_32:2021-01-11,2021-01-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101110130
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Subordinate Command Response Queues (Sub CRQ) are used in conjunction
with the primary CRQ when more than one queue is needed by the virtual
IO adapter. Recent phyp firmware versions support Sub CRQ's with ibmvfc
adapters. This feature is a prerequisite for supporting multiple
hardware backed submission queues in the vfc adapter.

The Sub CRQ command element differs from the standard CRQ in that it is
32bytes long as opposed to 16bytes for the latter. Despite this extra
16bytes the ibmvfc protocol will use the original CRQ command element
mapped to the first 16bytes of the Sub CRQ element initially.

Add definitions for the Sub CRQ command element and queue.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.h b/drivers/scsi/ibmvscsi/ibmvfc.h
index dd6d89292867..b9eed05c165f 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.h
+++ b/drivers/scsi/ibmvscsi/ibmvfc.h
@@ -650,6 +650,11 @@ struct ibmvfc_crq {
 	volatile __be64 ioba;
 } __packed __aligned(8);
 
+struct ibmvfc_sub_crq {
+	struct ibmvfc_crq crq;
+	__be64 reserved[2];
+} __packed __aligned(8);
+
 enum ibmvfc_ae_link_state {
 	IBMVFC_AE_LS_LINK_UP		= 0x01,
 	IBMVFC_AE_LS_LINK_BOUNCED	= 0x02,
@@ -761,12 +766,14 @@ struct ibmvfc_event_pool {
 enum ibmvfc_msg_fmt {
 	IBMVFC_CRQ_FMT = 0,
 	IBMVFC_ASYNC_FMT,
+	IBMVFC_SUB_CRQ_FMT,
 };
 
 union ibmvfc_msgs {
 	void *handle;
 	struct ibmvfc_crq *crq;
 	struct ibmvfc_async_crq *async;
+	struct ibmvfc_sub_crq *scrq;
 };
 
 struct ibmvfc_queue {
@@ -781,6 +788,20 @@ struct ibmvfc_queue {
 	struct list_head sent;
 	struct list_head free;
 	spinlock_t l_lock;
+
+	/* Sub-CRQ fields */
+	struct ibmvfc_host *vhost;
+	unsigned long cookie;
+	unsigned long vios_cookie;
+	unsigned long hw_irq;
+	unsigned long irq;
+	unsigned long hwq_id;
+	char name[32];
+};
+
+struct ibmvfc_scsi_channels {
+	struct ibmvfc_queue *scrqs;
+	unsigned int active_queues;
 };
 
 enum ibmvfc_host_action {
-- 
2.27.0

