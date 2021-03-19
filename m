Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D91F34272F
	for <lists+linux-scsi@lfdr.de>; Fri, 19 Mar 2021 21:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbhCSUvP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 19 Mar 2021 16:51:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29864 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229990AbhCSUul (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 19 Mar 2021 16:50:41 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12JKY8d3108786;
        Fri, 19 Mar 2021 16:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=H67d/giVwtfDKYWyd9uBTueyHWko0R99XUloYzHBBp4=;
 b=qvV0vOFS11ehK3BhSdaMWsfCxXDk9RAtlKNk8/gV2v+toonswst/Hx4syq4VALMCKQDW
 BYwR5FVTtxkZEJp1qUKQwDkxm3po6mUosq9ZMdAST0XqCurhZspcx9xAGcAb7+RB67Il
 aP/OpHrtZiHGM7tOoVDcvw+xuS43y3vjePM6zA+flH/lZTRy3AbbsqGV96czQxElHsAy
 bROiDIfZ9D/ak9WvefUephse3QyidNZ6xQ0qrA2I66/2t6AkQVkNmsbTq9taDdRxL9Fk
 a77p3YpZm58XSkXpfRR8ADrVqA7pEuS4FXUThp9qQR1HwgqEOKBx1wTZ4ZFLFO9L5jQY FA== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37cw8v2edj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Mar 2021 16:50:34 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12JKm4Cg022499;
        Fri, 19 Mar 2021 20:50:33 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma03dal.us.ibm.com with ESMTP id 378n1a4vay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Mar 2021 20:50:33 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12JKoVJq19071442
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Mar 2021 20:50:31 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 881B06E054;
        Fri, 19 Mar 2021 20:50:31 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B4536E04C;
        Fri, 19 Mar 2021 20:50:31 +0000 (GMT)
Received: from vios4361.aus.stglabs.ibm.com (unknown [9.3.43.61])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 19 Mar 2021 20:50:31 +0000 (GMT)
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
To:     james.bottomley@hansenpartnership.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        brking@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH 1/2] ibmvfc: fix potential race in ibmvfc_wait_for_ops
Date:   Fri, 19 Mar 2021 14:50:28 -0600
Message-Id: <20210319205029.312969-2-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210319205029.312969-1-tyreld@linux.ibm.com>
References: <20210319205029.312969-1-tyreld@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-19_10:2021-03-19,2021-03-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 mlxlogscore=999
 mlxscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103190140
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

For various EH activities the ibmvfc driver uses ibmvfc_wait_for_ops()
to wait for the completion of commands that match a given criteria be it
cancel key, or specific LUN. With recent changes commands are completed
outside the lock in bulk by removing them from the sent list and adding
them to a private completion list. This introduces a potential race in
ibmvfc_wait_for_ops() since the criteria for a command to be oustsanding
is no longer simply being on the sent list, but instead not being on the
free list.

Avoid this race by scanning the entire command event pool and checking
that any matching command that ibmvfc needs to wait on is not already on
the free list.

Fixes: 1f4a4a19508d ("scsi: ibmvfc: Complete commands outside the host/queue lock")
Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 42 ++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index f140eafc0d6a..5414b465a92f 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -2371,6 +2371,24 @@ static int ibmvfc_match_lun(struct ibmvfc_event *evt, void *device)
 	return 0;
 }
 
+/**
+ * ibmvfc_event_is_free - Check if event is free or not
+ * @evt:	ibmvfc event struct
+ *
+ * Returns:
+ *	true / false
+ **/
+static bool ibmvfc_event_is_free(struct ibmvfc_event *evt)
+{
+	struct ibmvfc_event *loop_evt;
+
+	list_for_each_entry(loop_evt, &evt->queue->free, queue_list)
+		if (loop_evt == evt)
+			return true;
+
+	return false;
+}
+
 /**
  * ibmvfc_wait_for_ops - Wait for ops to complete
  * @vhost:	ibmvfc host struct
@@ -2385,7 +2403,7 @@ static int ibmvfc_wait_for_ops(struct ibmvfc_host *vhost, void *device,
 {
 	struct ibmvfc_event *evt;
 	DECLARE_COMPLETION_ONSTACK(comp);
-	int wait;
+	int wait, i;
 	unsigned long flags;
 	signed long timeout = IBMVFC_ABORT_WAIT_TIMEOUT * HZ;
 
@@ -2393,10 +2411,13 @@ static int ibmvfc_wait_for_ops(struct ibmvfc_host *vhost, void *device,
 	do {
 		wait = 0;
 		spin_lock_irqsave(&vhost->crq.l_lock, flags);
-		list_for_each_entry(evt, &vhost->crq.sent, queue_list) {
-			if (match(evt, device)) {
-				evt->eh_comp = &comp;
-				wait++;
+		for (i = 0; i < vhost->crq.evt_pool.size; i++) {
+			evt = &vhost->crq.evt_pool.events[i];
+			if (!ibmvfc_event_is_free(evt)) {
+				if (match(evt, device)) {
+					evt->eh_comp = &comp;
+					wait++;
+				}
 			}
 		}
 		spin_unlock_irqrestore(&vhost->crq.l_lock, flags);
@@ -2407,10 +2428,13 @@ static int ibmvfc_wait_for_ops(struct ibmvfc_host *vhost, void *device,
 			if (!timeout) {
 				wait = 0;
 				spin_lock_irqsave(&vhost->crq.l_lock, flags);
-				list_for_each_entry(evt, &vhost->crq.sent, queue_list) {
-					if (match(evt, device)) {
-						evt->eh_comp = NULL;
-						wait++;
+				for (i = 0; i < vhost->crq.evt_pool.size; i++) {
+					evt = &vhost->crq.evt_pool.events[i];
+					if (!ibmvfc_event_is_free(evt)) {
+						if (match(evt, device)) {
+							evt->eh_comp = NULL;
+							wait++;
+						}
 					}
 				}
 				spin_unlock_irqrestore(&vhost->crq.l_lock, flags);
-- 
2.27.0

