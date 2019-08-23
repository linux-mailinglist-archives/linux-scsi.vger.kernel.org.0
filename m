Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F41099ABF5
	for <lists+linux-scsi@lfdr.de>; Fri, 23 Aug 2019 11:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389004AbfHWJwx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 23 Aug 2019 05:52:53 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:51742 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732878AbfHWJwx (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 23 Aug 2019 05:52:53 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x7N9nWrm002566
        for <linux-scsi@vger.kernel.org>; Fri, 23 Aug 2019 02:52:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=3XmTsvZNHdTEqYiAmCnR4xgnCvFEaqt24KQVA7augX0=;
 b=m/cM3EXrmqQdGxSxUUbYyi7sIA3FYm6uCzjr/8vIX22JekFPmL8b98QqNKbUe2pCkfdY
 CAvWr+aikb/oevvfPm4UjbU5r+M+Qvrx0FxIdUqT4CiI0zqmmT83KMfw7eThI9LGgB7v
 9i04TECeTD51UUwIBHD4iz+nMGuDGgIffDxW4OEAoFf9n7T/aLPmFcpz+kLKAl/ivJHL
 DDN0fxuzgbSA7/fR/l3M5WikP3pNNsZKivlMv4W+FTYv4HDO4qkrIQwdTG0J+xSob8Xe
 FWnUd9vHhITIXp1emi2rq4UZ+qv79bu8OFa8/DplX30JE1lMzvj6EH6nUQLyoS+jxcvl ag== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2uhad4072q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Fri, 23 Aug 2019 02:52:52 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 23 Aug
 2019 02:52:51 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 23 Aug 2019 02:52:51 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id EBE073F7040;
        Fri, 23 Aug 2019 02:52:50 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x7N9qoCV007873;
        Fri, 23 Aug 2019 02:52:50 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x7N9qoP2007872;
        Fri, 23 Aug 2019 02:52:50 -0700
From:   Saurav Kashyap <skashyap@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <gbasrur@marvell.com>, <svernekar@marvell.com>,
        <linux-scsi@vger.kernel.org>
Subject: [PATCH 02/14] qedf: Stop sending fipvlan request on unload.
Date:   Fri, 23 Aug 2019 02:52:32 -0700
Message-ID: <20190823095244.7830-3-skashyap@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190823095244.7830-1-skashyap@marvell.com>
References: <20190823095244.7830-1-skashyap@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-08-23_03:2019-08-21,2019-08-23 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

- On some setups fipvlan can be retried for long duration
and the connection to switch was not there so it was not
getting any reply.
- During unload this thread was hanging.

Problem Resolution:
Check if unload is in progress then quit from fipvlan thread.

Signed-off-by: Saurav Kashyap <skashyap@marvell.com>
---
 drivers/scsi/qedf/qedf_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/qedf/qedf_main.c b/drivers/scsi/qedf/qedf_main.c
index 3e245b0..2d69860 100644
--- a/drivers/scsi/qedf/qedf_main.c
+++ b/drivers/scsi/qedf/qedf_main.c
@@ -128,6 +128,11 @@ static bool qedf_initiate_fipvlan_req(struct qedf_ctx *qedf)
 			return false;
 		}
 
+		if (test_bit(QEDF_UNLOADING, &qedf->flags)) {
+			QEDF_ERR(&qedf->dbg_ctx, "Driver unloading.\n");
+			return false;
+		}
+
 		if (qedf->vlan_id > 0) {
 			QEDF_INFO(&qedf->dbg_ctx, QEDF_LOG_DISC,
 				  "vlan = 0x%x already set.\n", qedf->vlan_id);
-- 
1.8.3.1

