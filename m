Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 533A62EC4B8
	for <lists+linux-scsi@lfdr.de>; Wed,  6 Jan 2021 21:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbhAFUTf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 6 Jan 2021 15:19:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48402 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727917AbhAFUTf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 6 Jan 2021 15:19:35 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 106K8lo9062486;
        Wed, 6 Jan 2021 15:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=lXJUBf1oxIqCJpJ6ym/qwdc9fGeVh+yzmCACo/2hwV0=;
 b=KgkfO7F1x8UdzgJipnQZAcFWvPL2QnqHY4hIeJN+Kn/iNocS4KQbeKcVoNxv/IQyzL4Z
 Kxv9mfr7KWxlhXaawn1624P3HhwvAJE2fVGwJr0HBjC7StfTD4gXO1fpB/dchvpZhjif
 xnLKaePEO3vwQfYrqY5j0KWgiH4xob5A3bIhrTGWDYcHDhqv/Ksl/NGi4UrGF+bBZjdg
 IJI+Y9xwh/1YS36hxfIa30xJVOx92r7FlfybA9qqg+vS/bLjtxZpKPPo9PZVGQQepI4h
 ubbvBDvhqffRGlL+bdFcnNcywCGYYgco8vL9hvPerVAmH79LQEqJz9mMHhtFic+Q40EF Rw== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35wkc9h4kp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jan 2021 15:18:49 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 106KIGhL015652;
        Wed, 6 Jan 2021 20:18:48 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04dal.us.ibm.com with ESMTP id 35tgf9ybww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Jan 2021 20:18:48 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 106KIkKN21955010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Jan 2021 20:18:47 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D53B5C6057;
        Wed,  6 Jan 2021 20:18:46 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B11AC605B;
        Wed,  6 Jan 2021 20:18:46 +0000 (GMT)
Received: from vios4361.aus.stglabs.ibm.com (unknown [9.3.43.61])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed,  6 Jan 2021 20:18:46 +0000 (GMT)
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
To:     james.bottomley@hansenpartnership.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        brking@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>,
        Brian King <brking@linux.vnet.ibm.com>
Subject: [PATCH v2 5/5] ibmvfc: relax locking around ibmvfc_queuecommand
Date:   Wed,  6 Jan 2021 14:18:35 -0600
Message-Id: <20210106201835.1053593-6-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210106201835.1053593-1-tyreld@linux.ibm.com>
References: <20210106201835.1053593-1-tyreld@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-06_11:2021-01-06,2021-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101060113
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The drivers queuecommand routine is still wrapped to hold the host lock
for the duration of the call. This will become problematic when moving
to multiple queues due to the lock contention preventing asynchronous
submissions to mulitple queues. There is no real legatimate reason to
hold the host lock, and previous patches have insured proper protection
of moving ibmvfc_event objects between free and sent lists.

Signed-off-by: Tyrel Datwyler <tyreld@linux.ibm.com>
Reviewed-by: Brian King <brking@linux.vnet.ibm.com>
---
 drivers/scsi/ibmvscsi/ibmvfc.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index f680f96d5d06..ff86c43b4b33 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -1793,10 +1793,9 @@ static struct ibmvfc_cmd *ibmvfc_init_vfc_cmd(struct ibmvfc_event *evt, struct s
  * Returns:
  *	0 on success / other on failure
  **/
-static int ibmvfc_queuecommand_lck(struct scsi_cmnd *cmnd,
-			       void (*done) (struct scsi_cmnd *))
+static int ibmvfc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *cmnd)
 {
-	struct ibmvfc_host *vhost = shost_priv(cmnd->device->host);
+	struct ibmvfc_host *vhost = shost_priv(shost);
 	struct fc_rport *rport = starget_to_rport(scsi_target(cmnd->device));
 	struct ibmvfc_cmd *vfc_cmd;
 	struct ibmvfc_fcp_cmd_iu *iu;
@@ -1806,7 +1805,7 @@ static int ibmvfc_queuecommand_lck(struct scsi_cmnd *cmnd,
 	if (unlikely((rc = fc_remote_port_chkready(rport))) ||
 	    unlikely((rc = ibmvfc_host_chkready(vhost)))) {
 		cmnd->result = rc;
-		done(cmnd);
+		cmnd->scsi_done(cmnd);
 		return 0;
 	}
 
@@ -1814,7 +1813,6 @@ static int ibmvfc_queuecommand_lck(struct scsi_cmnd *cmnd,
 	evt = ibmvfc_get_event(&vhost->crq);
 	ibmvfc_init_event(evt, ibmvfc_scsi_done, IBMVFC_CMD_FORMAT);
 	evt->cmnd = cmnd;
-	cmnd->scsi_done = done;
 
 	vfc_cmd = ibmvfc_init_vfc_cmd(evt, cmnd->device);
 	iu = ibmvfc_get_fcp_iu(vhost, vfc_cmd);
@@ -1841,12 +1839,10 @@ static int ibmvfc_queuecommand_lck(struct scsi_cmnd *cmnd,
 			    "Failed to map DMA buffer for command. rc=%d\n", rc);
 
 	cmnd->result = DID_ERROR << 16;
-	done(cmnd);
+	cmnd->scsi_done(cmnd);
 	return 0;
 }
 
-static DEF_SCSI_QCMD(ibmvfc_queuecommand)
-
 /**
  * ibmvfc_sync_completion - Signal that a synchronous command has completed
  * @evt:	ibmvfc event struct
-- 
2.27.0

