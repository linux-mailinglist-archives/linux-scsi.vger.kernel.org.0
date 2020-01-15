Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7410113C8E2
	for <lists+linux-scsi@lfdr.de>; Wed, 15 Jan 2020 17:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgAOQMt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 15 Jan 2020 11:12:49 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:60868 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726132AbgAOQMt (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 15 Jan 2020 11:12:49 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00FG9HbJ023722;
        Wed, 15 Jan 2020 08:12:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=Wsjj1zAEQkqk/nkIbLUq/35Zq/Mpo2QvJTr5Tdmva6g=;
 b=NmmS2+21q8pCsKoM9RVv92bFyZws7wrR5TwMiC9jST69fXOqEiJfRNyOxMxHmq9zx/XQ
 wDR0W5ahAConxZjY9uDuWMFmco1x8gg5ze76mthjFTHnaOzS+19vuf/ATSxUcHo7jU6R
 XJ+TV1WWbaPxWstgWdTrH3aMlQzUW2B4v/ZtWEwh40k1dNMXEXrEd2+9Vb+xP4jy9ECY
 JvlbERaeRLuPP8gC2654ZSschYV9MhqEt3sJ+uVMfJfpAOJS5mOPzjChI2jFT0+KKss5
 r28zcekJN6gm9urA+UD3U8WuFUwDfer3Fb4xleHoLGby7aK9CEYFNVfQNPe3jol2Ptgs VA== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0b-0016f401.pphosted.com with ESMTP id 2xhrhe2xe9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 15 Jan 2020 08:12:45 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 15 Jan
 2020 08:12:43 -0800
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Jan 2020 08:12:43 -0800
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 595363F7044;
        Wed, 15 Jan 2020 08:12:43 -0800 (PST)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 00FGChtJ019186;
        Wed, 15 Jan 2020 08:12:43 -0800
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 00FGChSn019185;
        Wed, 15 Jan 2020 08:12:43 -0800
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH v2] qla2xxx: Fix unbound NVME response length
Date:   Wed, 15 Jan 2020 08:12:43 -0800
Message-ID: <20200115161243.19151-1-hmadhani@marvell.com>
X-Mailer: git-send-email 2.12.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-15_02:2020-01-15,2020-01-15 signatures=0
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
Cc: stable@vger.kernel.org
Signed-off-by: Arun Easi <aeasi@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
---
Hi Martin,

We discovered issue with our newer Gen7 adapter when response length
happens to be larger than 32 bytes, could result into crash.

Please apply this to 5.5/scsi-fixes branch at your earliest convenience.

Changes from v1 -> v2

o Fixed the tag for stable. 
o Removed logit which got spilled from other patch to prevent compile failure.

Thanks,
Himanshu
---
 drivers/scsi/qla2xxx/qla_isr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index e7bad0bfffda..36ea934da1a0 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -1939,6 +1939,14 @@ static void qla24xx_nvme_iocb_entry(scsi_qla_host_t *vha, struct req_que *req,
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
+		}
 		iter = iocb->u.nvme.rsp_pyld_len >> 2;
 		for (; iter; iter--)
 			*outbuf++ = swab32(*inbuf++);
-- 
2.12.0

