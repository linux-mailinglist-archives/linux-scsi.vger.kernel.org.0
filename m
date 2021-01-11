Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00E32F236A
	for <lists+linux-scsi@lfdr.de>; Tue, 12 Jan 2021 01:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391766AbhALAZr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 11 Jan 2021 19:25:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23044 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403872AbhAKXNX (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 11 Jan 2021 18:13:23 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10BN2UBG175401;
        Mon, 11 Jan 2021 18:12:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=GmNvDU70WRRDHGJO5ab1fmTFybGNSQl2UdTKfI7awiA=;
 b=tJgxcxYtkfnXs6IVD/eBdT0dQl+tDnTPOk6AFTab02hgb+Tauz/9fKDeWfWvGM2T14dn
 aqZMipMs3zqICG/tSn3cCvOPQ/mfaROcc/fEqJtPjilDUkgYMNMnJW+hGwNzrlxCytzL
 0xvGgzyD4jPDraTzexOSAcdnFmqD1BIJwl7+W/YV2IiEpUOpCuRWSbVXQfUzbWteYq9F
 0JEPV3KkUdO3GyRVeULyGAjzXup7q41Zxa4YNgk+R4i2po0lQiTABl0gHPonSKh7Pa1U
 1iIvVJj50I6oLKBKbo8d5AIOetDuND7K3Y3YQhiCmakTmzr7zTapHQy0xg+YrFwCH2xf SQ== 
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 360yvkrf51-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jan 2021 18:12:38 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10BN7xjI008136;
        Mon, 11 Jan 2021 23:12:37 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma03dal.us.ibm.com with ESMTP id 35y448xcph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jan 2021 23:12:37 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10BNCa7v23855526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jan 2021 23:12:36 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 164407805F;
        Mon, 11 Jan 2021 23:12:36 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A962C78067;
        Mon, 11 Jan 2021 23:12:35 +0000 (GMT)
Received: from vios4361.aus.stglabs.ibm.com (unknown [9.3.43.61])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 11 Jan 2021 23:12:35 +0000 (GMT)
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
To:     james.bottomley@hansenpartnership.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        brking@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v4 17/21] ibmvfc: add cancel mad initialization helper
Date:   Mon, 11 Jan 2021 17:12:21 -0600
Message-Id: <20210111231225.105347-18-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210111231225.105347-1-tyreld@linux.ibm.com>
References: <20210111231225.105347-1-tyreld@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-11_32:2021-01-11,2021-01-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101110126
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Add a helper routine for initializing a Cancel MAD. This will be useful
for a channelized client that needs to send Cancel commands down every
channel commands were sent for a particular LUN.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 68 ++++++++++++++++++++--------------
 1 file changed, 40 insertions(+), 28 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index 578e27180f10..b0b0212344f3 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -2379,6 +2379,45 @@ static int ibmvfc_wait_for_ops(struct ibmvfc_host *vhost, void *device,
 	return SUCCESS;
 }
 
+static struct ibmvfc_event *ibmvfc_init_tmf(struct ibmvfc_queue *queue,
+					    struct scsi_device *sdev,
+					    int type)
+{
+	struct ibmvfc_host *vhost = shost_priv(sdev->host);
+	struct scsi_target *starget = scsi_target(sdev);
+	struct fc_rport *rport = starget_to_rport(starget);
+	struct ibmvfc_event *evt;
+	struct ibmvfc_tmf *tmf;
+
+	evt = ibmvfc_get_event(queue);
+	ibmvfc_init_event(evt, ibmvfc_sync_completion, IBMVFC_MAD_FORMAT);
+
+	tmf = &evt->iu.tmf;
+	memset(tmf, 0, sizeof(*tmf));
+	if (ibmvfc_check_caps(vhost, IBMVFC_HANDLE_VF_WWPN)) {
+		tmf->common.version = cpu_to_be32(2);
+		tmf->target_wwpn = cpu_to_be64(rport->port_name);
+	} else {
+		tmf->common.version = cpu_to_be32(1);
+	}
+	tmf->common.opcode = cpu_to_be32(IBMVFC_TMF_MAD);
+	tmf->common.length = cpu_to_be16(sizeof(*tmf));
+	tmf->scsi_id = cpu_to_be64(rport->port_id);
+	int_to_scsilun(sdev->lun, &tmf->lun);
+	if (!ibmvfc_check_caps(vhost, IBMVFC_CAN_SUPPRESS_ABTS))
+		type &= ~IBMVFC_TMF_SUPPRESS_ABTS;
+	if (vhost->state == IBMVFC_ACTIVE)
+		tmf->flags = cpu_to_be32((type | IBMVFC_TMF_LUA_VALID));
+	else
+		tmf->flags = cpu_to_be32(((type & IBMVFC_TMF_SUPPRESS_ABTS) | IBMVFC_TMF_LUA_VALID));
+	tmf->cancel_key = cpu_to_be32((unsigned long)sdev->hostdata);
+	tmf->my_cancel_key = cpu_to_be32((unsigned long)starget->hostdata);
+
+	init_completion(&evt->comp);
+
+	return evt;
+}
+
 /**
  * ibmvfc_cancel_all - Cancel all outstanding commands to the device
  * @sdev:	scsi device to cancel commands
@@ -2393,9 +2432,6 @@ static int ibmvfc_wait_for_ops(struct ibmvfc_host *vhost, void *device,
 static int ibmvfc_cancel_all(struct scsi_device *sdev, int type)
 {
 	struct ibmvfc_host *vhost = shost_priv(sdev->host);
-	struct scsi_target *starget = scsi_target(sdev);
-	struct fc_rport *rport = starget_to_rport(starget);
-	struct ibmvfc_tmf *tmf;
 	struct ibmvfc_event *evt, *found_evt;
 	union ibmvfc_iu rsp;
 	int rsp_rc = -EBUSY;
@@ -2422,32 +2458,8 @@ static int ibmvfc_cancel_all(struct scsi_device *sdev, int type)
 	}
 
 	if (vhost->logged_in) {
-		evt = ibmvfc_get_event(&vhost->crq);
-		ibmvfc_init_event(evt, ibmvfc_sync_completion, IBMVFC_MAD_FORMAT);
-
-		tmf = &evt->iu.tmf;
-		memset(tmf, 0, sizeof(*tmf));
-		if (ibmvfc_check_caps(vhost, IBMVFC_HANDLE_VF_WWPN)) {
-			tmf->common.version = cpu_to_be32(2);
-			tmf->target_wwpn = cpu_to_be64(rport->port_name);
-		} else {
-			tmf->common.version = cpu_to_be32(1);
-		}
-		tmf->common.opcode = cpu_to_be32(IBMVFC_TMF_MAD);
-		tmf->common.length = cpu_to_be16(sizeof(*tmf));
-		tmf->scsi_id = cpu_to_be64(rport->port_id);
-		int_to_scsilun(sdev->lun, &tmf->lun);
-		if (!ibmvfc_check_caps(vhost, IBMVFC_CAN_SUPPRESS_ABTS))
-			type &= ~IBMVFC_TMF_SUPPRESS_ABTS;
-		if (vhost->state == IBMVFC_ACTIVE)
-			tmf->flags = cpu_to_be32((type | IBMVFC_TMF_LUA_VALID));
-		else
-			tmf->flags = cpu_to_be32(((type & IBMVFC_TMF_SUPPRESS_ABTS) | IBMVFC_TMF_LUA_VALID));
-		tmf->cancel_key = cpu_to_be32((unsigned long)sdev->hostdata);
-		tmf->my_cancel_key = cpu_to_be32((unsigned long)starget->hostdata);
-
+		evt = ibmvfc_init_tmf(&vhost->crq, sdev, type);
 		evt->sync_iu = &rsp;
-		init_completion(&evt->comp);
 		rsp_rc = ibmvfc_send_event(evt, vhost, default_timeout);
 	}
 
-- 
2.27.0

