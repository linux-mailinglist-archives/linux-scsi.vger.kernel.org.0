Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0AC2C4CCC
	for <lists+linux-scsi@lfdr.de>; Thu, 26 Nov 2020 02:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732185AbgKZBsn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 25 Nov 2020 20:48:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17310 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731956AbgKZBsm (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 25 Nov 2020 20:48:42 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AQ1VMuu186026;
        Wed, 25 Nov 2020 20:48:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=gC/vWuYTDA9qvAo5cfOWV0B5mMeAskVmH5S9vCf6JzY=;
 b=srhamtFOYAtPey0Sp+1sonArwZCbUZx3bCP8cVNy3B5N8ELYGZevmKSpQHofQMEfHM4F
 YG1bx5V+JXCZvyomG0zpqxYXhLHyvd9tVWaCZcvn8mGnFoagxYrKo+oxg6pDqlZgKAuS
 erUSWpN49i03d+3s/WY9J0TANVp1wcrGD22TdKzEZvdrDlpL5edIFOldySzATU4CHIDU
 zNEyPan9c/+qXvHDKwW4q/ttEwbWOa1mq7VlcNxdnhIHP7QtFi/kyo5K5R620pW4VP6b
 bfSWJJ+IDgn//v59GXkKMWkRFicOrTW+tYWJyl+5fsLFgkU05pudrZfOvGVLrCKFuQYM 1Q== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3521th1cyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Nov 2020 20:48:33 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AQ1lesS018622;
        Thu, 26 Nov 2020 01:48:33 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma05wdc.us.ibm.com with ESMTP id 34xth9bpx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Nov 2020 01:48:33 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AQ1mM7W40370676
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Nov 2020 01:48:22 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4BA46E04C;
        Thu, 26 Nov 2020 01:48:31 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5447C6E053;
        Thu, 26 Nov 2020 01:48:31 +0000 (GMT)
Received: from vios4361.aus.stglabs.ibm.com (unknown [9.3.43.61])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 26 Nov 2020 01:48:31 +0000 (GMT)
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
To:     james.bottomley@hansenpartnership.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        brking@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH 05/13] ibmvfc: add Sub-CRQ IRQ enable/disable routine
Date:   Wed, 25 Nov 2020 19:48:16 -0600
Message-Id: <20201126014824.123831-6-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201126014824.123831-1-tyreld@linux.ibm.com>
References: <20201126014824.123831-1-tyreld@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-25_14:2020-11-25,2020-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=740 suspectscore=1
 priorityscore=1501 mlxscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011260001
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Each Sub-CRQ has its own interrupt. A hypercall is required to toggle
the IRQ state. Provide the necessary mechanism via a helper function.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index 571abdb48384..6eaedda4917a 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -3351,6 +3351,26 @@ static void ibmvfc_tasklet(void *data)
 	spin_unlock_irqrestore(vhost->host->host_lock, flags);
 }
 
+static int ibmvfc_toggle_scrq_irq(struct ibmvfc_sub_queue *scrq, int enable)
+{
+	struct device *dev = scrq->vhost->dev;
+	struct vio_dev *vdev = to_vio_dev(dev);
+	unsigned long rc;
+	int irq_action = H_ENABLE_VIO_INTERRUPT;
+
+	if (!enable)
+		irq_action = H_DISABLE_VIO_INTERRUPT;
+
+	rc = plpar_hcall_norets(H_VIOCTL, vdev->unit_address, irq_action,
+				scrq->hw_irq, 0, 0);
+
+	if (rc)
+		dev_err(dev, "Couldn't %s sub-crq[%lu] irq. rc=%ld\n",
+			enable ? "enable" : "disable", scrq->hwq_id, rc);
+
+	return rc;
+}
+
 /**
  * ibmvfc_init_tgt - Set the next init job step for the target
  * @tgt:		ibmvfc target struct
-- 
2.27.0

