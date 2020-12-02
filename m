Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E432CB1D2
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Dec 2020 01:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgLBAyz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 1 Dec 2020 19:54:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29456 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727408AbgLBAy2 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 1 Dec 2020 19:54:28 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B20TdhG159676;
        Tue, 1 Dec 2020 19:53:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=NCYPa09weoXfv2ZV/9wvgFwzMI/xZtfM+1jEYRxr/VY=;
 b=IBc9mYMMgLkd4WPrPA1j1Ny07Z3Vhsf5AnVFTyheOwXHQpi/d8CngdsNmrL5TS4ncNkG
 35G7kNZIY569g7b312Kujhtpux30jJDTkhjbdmkS/uXQypxsr4TEms8wd6EXLg6YQ54u
 A3CvVaSijWdcNTgw2TujrRVZFpl0wWtQXswht97Ykqn8aNSMTkigCNusQu4c09oHRmE2
 FMIKJoSP8EdWaWxm+hK5i9MW5cn1SQW2gVuVACPnoywvOkESUrDpWCUq1f/7cqF9atEv
 Oz+0XmGOCfKdALCJ+ITrvf1NsoAmL+2KWAh8i+tk7Tg355JX21FwnO6OnZSGcwJh78Wh Zg== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 355jwvgtw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 19:53:36 -0500
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B20bLHn021930;
        Wed, 2 Dec 2020 00:53:35 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma03wdc.us.ibm.com with ESMTP id 353e694cvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 00:53:35 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B20rR9017761018
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Dec 2020 00:53:27 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7174C7805E;
        Wed,  2 Dec 2020 00:53:34 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1473F78060;
        Wed,  2 Dec 2020 00:53:34 +0000 (GMT)
Received: from vios4361.aus.stglabs.ibm.com (unknown [9.3.43.61])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  2 Dec 2020 00:53:34 +0000 (GMT)
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
To:     james.bottomley@hansenpartnership.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        brking@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v2 06/17] ibmvfc: add handlers to drain and complete Sub-CRQ responses
Date:   Tue,  1 Dec 2020 18:53:18 -0600
Message-Id: <20201202005329.4538-7-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201202005329.4538-1-tyreld@linux.ibm.com>
References: <20201202005329.4538-1-tyreld@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_12:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 suspectscore=3 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012010142
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The logic for iterating over the Sub-CRQ responses is similiar to that
of the primary CRQ. Add the necessary handlers for processing those
responses.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 77 ++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index 97f00fefa809..e9da3f60c793 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -3381,6 +3381,83 @@ static int ibmvfc_toggle_scrq_irq(struct ibmvfc_sub_queue *scrq, int enable)
 	return rc;
 }
 
+static void ibmvfc_handle_scrq(struct ibmvfc_crq *crq, struct ibmvfc_host *vhost)
+{
+	struct ibmvfc_event *evt = (struct ibmvfc_event *)be64_to_cpu(crq->ioba);
+	unsigned long flags;
+
+	switch (crq->valid) {
+	case IBMVFC_CRQ_CMD_RSP:
+		break;
+	case IBMVFC_CRQ_XPORT_EVENT:
+		return;
+	default:
+		dev_err(vhost->dev, "Got and invalid message type 0x%02x\n", crq->valid);
+		return;
+	}
+
+	/* The only kind of payload CRQs we should get are responses to
+	 * things we send. Make sure this response is to something we
+	 * actually sent
+	 */
+	if (unlikely(!ibmvfc_valid_event(&vhost->pool, evt))) {
+		dev_err(vhost->dev, "Returned correlation_token 0x%08llx is invalid!\n",
+			crq->ioba);
+		return;
+	}
+
+	if (unlikely(atomic_read(&evt->free))) {
+		dev_err(vhost->dev, "Received duplicate correlation_token 0x%08llx!\n",
+			crq->ioba);
+		return;
+	}
+
+	spin_lock_irqsave(vhost->host->host_lock, flags);
+	del_timer(&evt->timer);
+	list_del(&evt->queue);
+	ibmvfc_trc_end(evt);
+	spin_unlock_irqrestore(vhost->host->host_lock, flags);
+	evt->done(evt);
+}
+
+static struct ibmvfc_crq *ibmvfc_next_scrq(struct ibmvfc_sub_queue *scrq)
+{
+	struct ibmvfc_crq *crq;
+
+	crq = &scrq->msgs[scrq->cur].crq;
+	if (crq->valid & 0x80) {
+		if (++scrq->cur == scrq->size)
+			scrq->cur = 0;
+		rmb();
+	} else
+		crq = NULL;
+
+	return crq;
+}
+
+static void ibmvfc_drain_sub_crq(struct ibmvfc_sub_queue *scrq)
+{
+	struct ibmvfc_crq *crq;
+	int done = 0;
+
+	while (!done) {
+		while ((crq = ibmvfc_next_scrq(scrq)) != NULL) {
+			ibmvfc_handle_scrq(crq, scrq->vhost);
+			crq->valid = 0;
+			wmb();
+		}
+
+		ibmvfc_toggle_scrq_irq(scrq, 1);
+		if ((crq = ibmvfc_next_scrq(scrq)) != NULL) {
+			ibmvfc_toggle_scrq_irq(scrq, 0);
+			ibmvfc_handle_scrq(crq, scrq->vhost);
+			crq->valid = 0;
+			wmb();
+		} else
+			done = 1;
+	}
+}
+
 /**
  * ibmvfc_init_tgt - Set the next init job step for the target
  * @tgt:		ibmvfc target struct
-- 
2.27.0

