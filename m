Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD9613B7EF
	for <lists+linux-scsi@lfdr.de>; Wed, 15 Jan 2020 03:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgAOCoh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 14 Jan 2020 21:44:37 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:59626 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728877AbgAOCoh (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 14 Jan 2020 21:44:37 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00F2hHxZ029733;
        Tue, 14 Jan 2020 18:44:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=HYlAEnfjjQwDoQo+AjTxC9Os2y31lQ1rk8QSTF6fGF4=;
 b=Kq/MTJyC1ft692t7aHbz4fPG/UabnEVTmuQFC2PALK/nO52ISUSGPF0KnKXP+Ac+qDVF
 LLn4RWdJCwXkRHNFq91WGQo/E8mQA8BTyevmJgT02VzGaqyr/qRmsqURjzTZd4GdVNvK
 30oQoHy5NfW2YqHGQTzoYdxZ/e+adAUFZYDftKo/t8b6WmhPTvi8flBR5vnBBxb2yhmI
 dDbeSQL6FToOHsS5I+G2GU1ZAkLNWJM4REOrdmavVCZKQpLI8UFNCkU77lPGlkmkn3cQ
 89UWPT7Eh8eSDsbNYNn8NAHJre3D7J8HnqC2OSJed3F03XIk9EbxwUZvtnnrw44VSsXR ng== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 2xhrhe0buq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 14 Jan 2020 18:44:34 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 14 Jan
 2020 18:44:32 -0800
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 14 Jan 2020 18:44:31 -0800
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id EA5F73F703F;
        Tue, 14 Jan 2020 18:44:31 -0800 (PST)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 00F2iVYk005456;
        Tue, 14 Jan 2020 18:44:31 -0800
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 00F2iV43005455;
        Tue, 14 Jan 2020 18:44:31 -0800
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH] qla2xxx: Fix unbound NVME response length
Date:   Tue, 14 Jan 2020 18:44:31 -0800
Message-ID: <20200115024431.5421-1-hmadhani@marvell.com>
X-Mailer: git-send-email 2.12.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-14_06:2020-01-14,2020-01-14 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Arun Easi <aeasi@marvell.com>

On certain cases when response length is less than 32, NVME response data
is supplied inline in IOCB. This is indicated by some combination of state
flags. There was an instance when a high, and incorrect, response length was
indicated causing driver to overrun buffers. Fix this by checking and
limiting the response payload length.

Fixes: 7401bc18d1ee3 ("scsi: qla2xxx: Add FC-NVMe command handling")
Cc: stable@vger.kernel.com
Signed-off-by: Arun Easi <aeasi@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
---
Hi Martin,

We discovered issue with our newer Gen7 adapter when response length
happens to be larger than 32 bytes, could result into crash.

Please apply this to 5.5/scsi-fixes branch at your earliest convenience.

Thanks,
Himanshu
---
 drivers/scsi/qla2xxx/qla_isr.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index e7bad0bfffda..90e816d13b0e 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -1939,6 +1939,15 @@ static void qla24xx_nvme_iocb_entry(scsi_qla_host_t *vha, struct req_que *req,
 		inbuf = (uint32_t *)&sts->nvme_ersp_data;
 		outbuf = (uint32_t *)fd->rspaddr;
 		iocb->u.nvme.rsp_pyld_len = le16_to_cpu(sts->nvme_rsp_pyld_len);
+		if (unlikely(iocb->u.nvme.rsp_pyld_len > 32)) {
+			WARN_ONCE(1, "Unexpected response payload length %u.\n",
+					iocb->u.nvme.rsp_pyld_len);
+			ql_log(ql_log_warn, fcport->vha, 0x5100,
+				"Unexpected response payload length %u.\n",
+				iocb->u.nvme.rsp_pyld_len);
+			iocb->u.nvme.rsp_pyld_len = 32;
+			logit = 1;
+		}
 		iter = iocb->u.nvme.rsp_pyld_len >> 2;
 		for (; iter; iter--)
 			*outbuf++ = swab32(*inbuf++);
-- 
2.12.0

