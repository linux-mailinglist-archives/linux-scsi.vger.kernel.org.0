Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD892F6C24
	for <lists+linux-scsi@lfdr.de>; Thu, 14 Jan 2021 21:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbhANUdL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 14 Jan 2021 15:33:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56062 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728060AbhANUcq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 14 Jan 2021 15:32:46 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10EKVl5B036570;
        Thu, 14 Jan 2021 15:32:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=z3nI/cWv0TReJ7MoPJifthz7mo+0RrF8eBMrSt6XeU0=;
 b=ffreLlDgKO2EhYoW8D4HFwBnytpqwN0yuaRI5ETvLPDafQ0rb6CgIoY9Xt5/oAhNhLnw
 ycIyWn8xc8Nw8zWozfv4R4CYsp1NTQ1b/Z4KDbIqWHLX23TQaNuRyi0HBjHHduQ3FyzE
 uiVepPWoUDMaYCRMjxzJ0PznxVkqWHWcI+S/zcmukKruLEb7SsEvc0vrY9UWu+lNjOBv
 D0YKtF5+eVKBN9KffQC4RAqkBWf3wYwm5gbLah9lDbHvCscQgbeRyE3GDRcL0+goSZEb
 nKVOp+fGZ39nfJ0pNdGMxzX8xH4ZD/d0RWC68u1fQQfaQzqMW0hJ5IbO0jehCEm0fTdk cw== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 362vbj94ur-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jan 2021 15:32:00 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10EKROJW032073;
        Thu, 14 Jan 2021 20:31:59 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04wdc.us.ibm.com with ESMTP id 35y449fskh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jan 2021 20:31:59 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10EKVwua23986446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Jan 2021 20:31:58 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18A306E050;
        Thu, 14 Jan 2021 20:31:58 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA6386E05B;
        Thu, 14 Jan 2021 20:31:57 +0000 (GMT)
Received: from vios4361.aus.stglabs.ibm.com (unknown [9.3.43.61])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 14 Jan 2021 20:31:57 +0000 (GMT)
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
To:     james.bottomley@hansenpartnership.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        brking@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>
Subject: [PATCH v5 19/21] ibmvfc: purge scsi channels after transport loss/reset
Date:   Thu, 14 Jan 2021 14:31:46 -0600
Message-Id: <20210114203148.246656-20-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210114203148.246656-1-tyreld@linux.ibm.com>
References: <20210114203148.246656-1-tyreld@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-14_07:2021-01-14,2021-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 spamscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2101140115
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Grab the queue and list lock for each Sub-CRQ and add any uncompleted
events to the host purge list.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
Reviewed-by: Brian King <brking@linux.vnet.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index 5ca8fcafd1d5..d314dffaafc4 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -1056,7 +1056,13 @@ static void ibmvfc_fail_request(struct ibmvfc_event *evt, int error_code)
 static void ibmvfc_purge_requests(struct ibmvfc_host *vhost, int error_code)
 {
 	struct ibmvfc_event *evt, *pos;
+	struct ibmvfc_queue *queues = vhost->scsi_scrqs.scrqs;
 	unsigned long flags;
+	int hwqs = 0;
+	int i;
+
+	if (vhost->using_channels)
+		hwqs = vhost->scsi_scrqs.active_queues;
 
 	ibmvfc_dbg(vhost, "Purging all requests\n");
 	spin_lock_irqsave(&vhost->crq.l_lock, flags);
@@ -1064,6 +1070,16 @@ static void ibmvfc_purge_requests(struct ibmvfc_host *vhost, int error_code)
 		ibmvfc_fail_request(evt, error_code);
 	list_splice_init(&vhost->crq.sent, &vhost->purge);
 	spin_unlock_irqrestore(&vhost->crq.l_lock, flags);
+
+	for (i = 0; i < hwqs; i++) {
+		spin_lock_irqsave(queues[i].q_lock, flags);
+		spin_lock(&queues[i].l_lock);
+		list_for_each_entry_safe(evt, pos, &queues[i].sent, queue_list)
+			ibmvfc_fail_request(evt, error_code);
+		list_splice_init(&queues[i].sent, &vhost->purge);
+		spin_unlock(&queues[i].l_lock);
+		spin_unlock_irqrestore(queues[i].q_lock, flags);
+	}
 }
 
 /**
-- 
2.27.0

