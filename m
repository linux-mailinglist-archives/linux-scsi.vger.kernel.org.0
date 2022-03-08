Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668924D1209
	for <lists+linux-scsi@lfdr.de>; Tue,  8 Mar 2022 09:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344973AbiCHIWK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 8 Mar 2022 03:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344901AbiCHIWE (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 8 Mar 2022 03:22:04 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9159E3F304
        for <linux-scsi@vger.kernel.org>; Tue,  8 Mar 2022 00:21:07 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22883jqf000787
        for <linux-scsi@vger.kernel.org>; Tue, 8 Mar 2022 00:21:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=mdo7I5BQgSXhkZdEVbh6RH8Pt6GTQY7vqtKmyGjF+xs=;
 b=KqrS/6diGUrs9aR+rErA2OE43RCgu3jxqCUv4bn+ohIcycx3LgLPbZXTgQsJpCA2I4GP
 up+KFFNxLS8zop8bPOIzMGQnvrLPyu2hOyP1rvm3CTltG4pjPD3IhtKWd7v37dZwhcMP
 8Vhxa2aw09IhrgyivyNVNIt94qbOKEaqspZi+otpyNkS+sV0ZCvI0yAG9d+aV4+bj71A
 RYnEOODDcOCByTyUUYIT92FtbBPstn4FDBjyosCJvfgYKEQP+w5bxqqNFHEiT4y36WmV
 D8zrfy8TbRwqcbtpU5V8Dnm3Y/hQbRkSMewe8phcEFuewusfgdhrqfCZxv8NlMkHGo0F fQ== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ep39x82uy-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Tue, 08 Mar 2022 00:21:07 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 8 Mar
 2022 00:21:05 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Mar 2022 00:21:05 -0800
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id ADB8E5B692A;
        Tue,  8 Mar 2022 00:21:05 -0800 (PST)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 2288L5qS009821;
        Tue, 8 Mar 2022 00:21:05 -0800
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 2288L5FF009820;
        Tue, 8 Mar 2022 00:21:05 -0800
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH 03/13] qla2xxx: Fix loss of NVME namespaces after driver reload test
Date:   Tue, 8 Mar 2022 00:20:38 -0800
Message-ID: <20220308082048.9774-4-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20220308082048.9774-1-njavali@marvell.com>
References: <20220308082048.9774-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Rfv5XtrF98-mJwLgXY5tNbvM_rDNhYmF
X-Proofpoint-GUID: Rfv5XtrF98-mJwLgXY5tNbvM_rDNhYmF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-08_03,2022-03-04_01,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Arun Easi <aeasi@marvell.com>

Driver registration of localport can race when it
happens at the remote port discovery time. Fix
this by calling the registration under a mutex.

Reported-by: Marco Patalano <mpatalan@redhat.com>
Tested-by: Marco Patalano <mpatalan@redhat.com>
Cc: stable@vger.kernel.org
Fixes: e84067d74301 ("scsi: qla2xxx: Add FC-NVMe F/W initialization and transport registration")
Signed-off-by: Arun Easi <aeasi@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_nvme.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index 5723082d94d6..3bf5cbd754a7 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -782,8 +782,6 @@ int qla_nvme_register_hba(struct scsi_qla_host *vha)
 	ha = vha->hw;
 	tmpl = &qla_nvme_fc_transport;
 
-	WARN_ON(vha->nvme_local_port);
-
 	if (ql2xnvme_queues < MIN_NVME_HW_QUEUES || ql2xnvme_queues > MAX_NVME_HW_QUEUES) {
 		ql_log(ql_log_warn, vha, 0xfffd,
 		    "ql2xnvme_queues=%d is out of range(MIN:%d - MAX:%d). Resetting ql2xnvme_queues to:%d\n",
@@ -797,7 +795,7 @@ int qla_nvme_register_hba(struct scsi_qla_host *vha)
 		(uint8_t)(ha->max_qpairs ? ha->max_qpairs : 1));
 
 	ql_log(ql_log_info, vha, 0xfffb,
-	    "Number of NVME queues used for this port: %d\n",
+	       "Number of NVME queues used for this port: %d\n",
 	    qla_nvme_fc_transport.max_hw_queues);
 
 	pinfo.node_name = wwn_to_u64(vha->node_name);
@@ -805,13 +803,25 @@ int qla_nvme_register_hba(struct scsi_qla_host *vha)
 	pinfo.port_role = FC_PORT_ROLE_NVME_INITIATOR;
 	pinfo.port_id = vha->d_id.b24;
 
-	ql_log(ql_log_info, vha, 0xffff,
-	    "register_localport: host-traddr=nn-0x%llx:pn-0x%llx on portID:%x\n",
-	    pinfo.node_name, pinfo.port_name, pinfo.port_id);
-	qla_nvme_fc_transport.dma_boundary = vha->host->dma_boundary;
-
-	ret = nvme_fc_register_localport(&pinfo, tmpl,
-	    get_device(&ha->pdev->dev), &vha->nvme_local_port);
+	mutex_lock(&ha->vport_lock);
+	/*
+	 * Check again for nvme_local_port to see if any other thread raced
+	 * with this one and finished registration.
+	 */
+	if (!vha->nvme_local_port) {
+		ql_log(ql_log_info, vha, 0xffff,
+		    "register_localport: host-traddr=nn-0x%llx:pn-0x%llx on portID:%x\n",
+		    pinfo.node_name, pinfo.port_name, pinfo.port_id);
+		qla_nvme_fc_transport.dma_boundary = vha->host->dma_boundary;
+
+		ret = nvme_fc_register_localport(&pinfo, tmpl,
+						 get_device(&ha->pdev->dev),
+						 &vha->nvme_local_port);
+		mutex_unlock(&ha->vport_lock);
+	} else {
+		mutex_unlock(&ha->vport_lock);
+		return 0;
+	}
 	if (ret) {
 		ql_log(ql_log_warn, vha, 0xffff,
 		    "register_localport failed: ret=%x\n", ret);
-- 
2.19.0.rc0

