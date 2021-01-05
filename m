Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F932EA52F
	for <lists+linux-scsi@lfdr.de>; Tue,  5 Jan 2021 07:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbhAEGGs (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 5 Jan 2021 01:06:48 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:63962 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726222AbhAEGGr (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 5 Jan 2021 01:06:47 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10566603017112
        for <linux-scsi@vger.kernel.org>; Mon, 4 Jan 2021 22:06:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=BvGPA9oq+j6/fRmLkVAavSsMr4ZCtVGYLkZ9WzhXaRg=;
 b=g3grfujqrcOc5ZnfNLsuu3Lqxgg2D1YbtpfOe2ut6VaQug2h7zMU5rV94FJlUEgjlcW1
 SSytXcaOzUP4VcADOJDId8acqT1Czs1qNfpSVBwWLCSzl0sAr6H0s+oSHSeDr1iB2cO5
 /Fizxpyu/ZgXLVGoAiTi32h0knpIGriFi+qSrpo8GOpiVEBBkZTEX1NVFVf2qM48xCgY
 M1WnqAtzcoVRlmIWsI2YxXYYUlWWvXobFxwUPBHWOl9z1I7P7lrmHpXjUwuyzM+0yt7a
 rZkV3441shQAGCMTeHiBs4Pgtwfj0JsPp63kZwH9dEoAXUEJuREpPdTXeTC0Z0JEkmMZ 5Q== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 35ts7rnchb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Mon, 04 Jan 2021 22:06:06 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 4 Jan
 2021 22:06:02 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 4 Jan
 2021 22:06:00 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 4 Jan 2021 22:06:00 -0800
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 82DB03F703F;
        Mon,  4 Jan 2021 22:06:00 -0800 (PST)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 105660PU020339;
        Mon, 4 Jan 2021 22:06:00 -0800
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 1056601S020338;
        Mon, 4 Jan 2021 22:06:00 -0800
From:   Nilesh Javali <njavali@marvell.com>
To:     <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>,
        <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH v2 5/7] qla2xxx: Fix mailbox Ch erroneous error
Date:   Mon, 4 Jan 2021 22:03:33 -0800
Message-ID: <20210105060335.20267-6-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20210105060335.20267-1-njavali@marvell.com>
References: <20210105060335.20267-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-05_01:2021-01-04,2021-01-05 signatures=0
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

Mailbox Ch/dump ram extend expects mb register 10 to be
set. If not set/clear, firmware can pick up garbage from previous
invocation of this mailbox. Example: mctp dump can set mb10.
On subsequent flash read which use mailbox cmd Ch, mb10 can
retain previous value.

Cc: stable@vger.kernel.org
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
---
 drivers/scsi/qla2xxx/qla_dbg.c | 1 +
 drivers/scsi/qla2xxx/qla_mbx.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_dbg.c b/drivers/scsi/qla2xxx/qla_dbg.c
index bb7431912d41..144a893e7335 100644
--- a/drivers/scsi/qla2xxx/qla_dbg.c
+++ b/drivers/scsi/qla2xxx/qla_dbg.c
@@ -202,6 +202,7 @@ qla24xx_dump_ram(struct qla_hw_data *ha, uint32_t addr, __be32 *ram,
 		wrt_reg_word(&reg->mailbox0, MBC_DUMP_RISC_RAM_EXTENDED);
 		wrt_reg_word(&reg->mailbox1, LSW(addr));
 		wrt_reg_word(&reg->mailbox8, MSW(addr));
+		wrt_reg_word(&reg->mailbox10, 0);
 
 		wrt_reg_word(&reg->mailbox2, MSW(LSD(dump_dma)));
 		wrt_reg_word(&reg->mailbox3, LSW(LSD(dump_dma)));
diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index 629af6fe8c55..06c99963b2c9 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -4291,7 +4291,8 @@ qla2x00_dump_ram(scsi_qla_host_t *vha, dma_addr_t req_dma, uint32_t addr,
 	if (MSW(addr) || IS_FWI2_CAPABLE(vha->hw)) {
 		mcp->mb[0] = MBC_DUMP_RISC_RAM_EXTENDED;
 		mcp->mb[8] = MSW(addr);
-		mcp->out_mb = MBX_8|MBX_0;
+		mcp->mb[10] = 0;
+		mcp->out_mb = MBX_10|MBX_8|MBX_0;
 	} else {
 		mcp->mb[0] = MBC_DUMP_RISC_RAM;
 		mcp->out_mb = MBX_0;
-- 
2.19.0.rc0

