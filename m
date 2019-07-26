Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86BC076E90
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jul 2019 18:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbfGZQH6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Jul 2019 12:07:58 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:64190 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726141AbfGZQH6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 26 Jul 2019 12:07:58 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6QG6bRa025486;
        Fri, 26 Jul 2019 09:07:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=7VQy4XhmIs9jGjtqQepoRhb1vjoS+nFSeKVbDNnOm0M=;
 b=gJX5J8QORYO6ceTSc4zn4ti1WbV4v6HerEin/Ht9XtJ3sTTvWkkgNqubMEPZfv6J3REt
 Te+/wW4BPqRJoYu3ErM+ys1hjdbaDDpxk2xrm0GQm6G2vniwLme/UCyc/6Z23P8c3Ley
 7S85h4qytG0ZGW3i7bwCayB29tqn9CCx8FxycawnlJ31jUTf388IKeX8/KjkjRbS6aJO
 V6ftuHP8meZwD9THwQTnU4ZL+5SfBN1YyUC+Dd76aJWx6Du1+EdfuISUiQQ6QB4OCea4
 PpSWW2MnhXs1RDoskjkffok19HKAV6UqOmm9L5lgWXr3WHo8Rfzy58P6iae8rsl5D4m9 2A== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2tx6256xap-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 26 Jul 2019 09:07:55 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 26 Jul
 2019 09:07:53 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 26 Jul 2019 09:07:53 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 845DF3F703F;
        Fri, 26 Jul 2019 09:07:53 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x6QG7rLM025746;
        Fri, 26 Jul 2019 09:07:53 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x6QG7rZd025745;
        Fri, 26 Jul 2019 09:07:53 -0700
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH 04/15] qla2xxx: Use Correct index for Q-Pair array
Date:   Fri, 26 Jul 2019 09:07:29 -0700
Message-ID: <20190726160740.25687-5-hmadhani@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190726160740.25687-1-hmadhani@marvell.com>
References: <20190726160740.25687-1-hmadhani@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-07-26_11:2019-07-26,2019-07-26 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

For target mode, the default number of Q-Pairs allowed
to use is 2. If the number of Q-Pair allocated is
lower than the default Q-Pairs, then lower value should
be the set as default.

Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
---
 drivers/scsi/qla2xxx/qla_target.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 1c1f63be6eed..d733e405c625 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -6671,6 +6671,8 @@ qlt_enable_vha(struct scsi_qla_host *vha)
 	if (vha->qlini_mode == QLA2XXX_INI_MODE_ENABLED)
 		return;
 
+	if (ha->tgt.num_act_qpairs > ha->max_qpairs)
+		ha->tgt.num_act_qpairs = ha->max_qpairs;
 	spin_lock_irqsave(&ha->hardware_lock, flags);
 	tgt->tgt_stopped = 0;
 	qlt_set_mode(vha);
-- 
2.12.0

