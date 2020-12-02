Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71EBF2CB20E
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Dec 2020 02:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbgLBBHG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 1 Dec 2020 20:07:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3102 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726908AbgLBBHF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 1 Dec 2020 20:07:05 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B216EGg193128;
        Tue, 1 Dec 2020 20:06:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=quLqGqXAl/PPgl+TuyjYAEjbjck4OUuu3Qk2jmO0lrg=;
 b=WS5/H5YXiO+7XfvRKuF7envEBEJT4i4LSIHloAtjWZuS/T8R2maNSylmG/h+nTeb0WkI
 uMPEu1dZSlZWFNN0Ifj6KMqOPrEcdvzVJWxGP36iCcmXmoGXQwtgTEzZmFrw9YBYaTWQ
 96zAPUO0VdxSZH9Ngbvdb9vtl6ciA10BpGHnnAOFtmKsvqtFSbQ45yGe39MFifQNEN3d
 MtPo1R3mKQmn/fPW0BwxH+83QbyUBayXf+W3KwUcnriYKah7bHXbYAGwNwb15LDcZZyq
 YjgD88y+ZN3gAcH3D9ql3jpp+U579tyNUxIeF8xfMCBit+pqm5zZU0RFxSin7k1ZENnB EA== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 355jt7d5cg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Dec 2020 20:05:10 -0500
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B20f5DJ016199;
        Wed, 2 Dec 2020 00:53:34 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma01wdc.us.ibm.com with ESMTP id 355vrfhrdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 00:53:34 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B20rN334391456
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Dec 2020 00:53:23 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 03D777805C;
        Wed,  2 Dec 2020 00:53:33 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 915E478060;
        Wed,  2 Dec 2020 00:53:32 +0000 (GMT)
Received: from vios4361.aus.stglabs.ibm.com (unknown [9.3.43.61])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  2 Dec 2020 00:53:32 +0000 (GMT)
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
To:     james.bottomley@hansenpartnership.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        brking@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>
Subject: [PATCH v2 03/17] ibmvfc: add Subordinate CRQ definitions
Date:   Tue,  1 Dec 2020 18:53:15 -0600
Message-Id: <20201202005329.4538-4-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201202005329.4538-1-tyreld@linux.ibm.com>
References: <20201202005329.4538-1-tyreld@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-01_12:2020-11-30,2020-12-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 adultscore=0 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=1 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012020000
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
Reviewed-by: Brian King <brking@linux.vnet.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.h b/drivers/scsi/ibmvscsi/ibmvfc.h
index e095daada70e..b3cd35cbf067 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.h
+++ b/drivers/scsi/ibmvscsi/ibmvfc.h
@@ -656,6 +656,29 @@ struct ibmvfc_crq_queue {
 	dma_addr_t msg_token;
 };
 
+struct ibmvfc_sub_crq {
+	struct ibmvfc_crq crq;
+	__be64 reserved[2];
+} __packed __aligned(8);
+
+struct ibmvfc_sub_queue {
+	struct ibmvfc_sub_crq *msgs;
+	dma_addr_t msg_token;
+	int size, cur;
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
+	struct ibmvfc_sub_queue *scrqs;
+	unsigned int active_queues;
+};
+
 enum ibmvfc_ae_link_state {
 	IBMVFC_AE_LS_LINK_UP		= 0x01,
 	IBMVFC_AE_LS_LINK_BOUNCED	= 0x02,
-- 
2.27.0

