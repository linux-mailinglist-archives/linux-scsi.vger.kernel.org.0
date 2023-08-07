Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2CF772387
	for <lists+linux-scsi@lfdr.de>; Mon,  7 Aug 2023 14:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjHGMLw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 7 Aug 2023 08:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbjHGMLp (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 7 Aug 2023 08:11:45 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC3C1BC
        for <linux-scsi@vger.kernel.org>; Mon,  7 Aug 2023 05:11:18 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3777mefj005711
        for <linux-scsi@vger.kernel.org>; Mon, 7 Aug 2023 05:11:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=ZnsC1hmtUORW8dXT47QOPEPHZ1j9fm2/WoVk5ourfZo=;
 b=hcnpfBv2Lj/sNPDNydljyyhaY09h2BcKeFuotKNNm41ehtpif07BTbmDsiitH5caUT8K
 mAKe5Tj3Ib0eUTtmvHOwom08VGSP9mSyA6IRMhAY1gXa6Ab5TE7LQcyRoBzKyVGyx5If
 3jyZ2LaQjT9yTUtsD+ImqbbKAt2Xj8Z6reZrWVjl8g4eiCr+w7vqI0iULGDy/Aio3FKW
 35a8AuIRZTCS99/IMq4XXjrGj4pYiYO7pgbPHhu453J9c91tTHUFC9mlXGnW43E79PZv
 P3I0zRWeHIi9aveyF96hGb+ulAo4pNZRo0L0R3nc1n8OkXUhQOyUgjFTpcVm7qGlB/Fg hA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3s9nxkvhur-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Mon, 07 Aug 2023 05:11:03 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 7 Aug
 2023 05:10:25 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Mon, 7 Aug 2023 05:10:25 -0700
Received: from localhost.marvell.com (unknown [10.30.46.195])
        by maili.marvell.com (Postfix) with ESMTP id 7F2183F70A0;
        Mon,  7 Aug 2023 05:10:23 -0700 (PDT)
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>,
        <agurumurthy@marvell.com>, <sdeodhar@marvell.com>
Subject: [PATCH v2 09/10] Revert "scsi: qla2xxx: Fix buffer overrun"
Date:   Mon, 7 Aug 2023 17:39:57 +0530
Message-ID: <20230807120958.3730-10-njavali@marvell.com>
X-Mailer: git-send-email 2.23.1
In-Reply-To: <20230807120958.3730-1-njavali@marvell.com>
References: <20230807120958.3730-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: OJmekoXpRPYcWpdFcJoiM4WvBmO0SilV
X-Proofpoint-ORIG-GUID: OJmekoXpRPYcWpdFcJoiM4WvBmO0SilV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_11,2023-08-03_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Revert due to Get PLOGI Template failed.
This reverts commit b68710a8094fdffe8dd4f7a82c82649f479bb453.

Cc: stable@vger.kernel.org
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/scsi/qla2xxx/qla_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 62087ce51b3f..d4df07aaa0ab 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -5607,7 +5607,7 @@ static void qla_get_login_template(scsi_qla_host_t *vha)
 	__be32 *q;
 
 	memset(ha->init_cb, 0, ha->init_cb_size);
-	sz = min_t(int, sizeof(struct fc_els_csp), ha->init_cb_size);
+	sz = min_t(int, sizeof(struct fc_els_flogi), ha->init_cb_size);
 	rval = qla24xx_get_port_login_templ(vha, ha->init_cb_dma,
 					    ha->init_cb, sz);
 	if (rval != QLA_SUCCESS) {
-- 
2.23.1

