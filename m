Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 866D076E8F
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jul 2019 18:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfGZQHy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Jul 2019 12:07:54 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:49082 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727115AbfGZQHy (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 26 Jul 2019 12:07:54 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6QG52Eg017082;
        Fri, 26 Jul 2019 09:07:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=LUwZ5HlqqPMqSWOsIkODHf5Vf4QLWPLBTFMWMffUIcU=;
 b=mrOmptAfe1Mpw5znwf3BF44sa/iCOQC+ZhzwZ3vLfgU3RhBrbfi0B8fNzxRPp+T1avFC
 eZcCSzqie7YLUiGR8lvnr0m+bDoQ/AEZASKP7UBQvnqKlAiSSxjqVX9Y9pABo48QoUE7
 FoJxBbTqCpkBcXScIMH12olzjUI6Otx9TNYgMtfO1K83YMoMwhBxr1NoL67Gp1vZwl4y
 hnIyWUFeu89VBeRMvLo+la6ywZtxta2ctqEZr0J22vXV4Gv4ZagRzl+7Z/3zknQ5XFJl
 DGgrSnhmFCwv3InNSmYUAP+HYnwu8bt6G1bhNQkZWiy81Qioxce1Fod4T4O00qb2hOjH 9Q== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2tx61rqjw6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 26 Jul 2019 09:07:48 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 26 Jul
 2019 09:07:47 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 26 Jul 2019 09:07:47 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 2B3FF3F703F;
        Fri, 26 Jul 2019 09:07:47 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x6QG7lGw025730;
        Fri, 26 Jul 2019 09:07:47 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x6QG7kDc025729;
        Fri, 26 Jul 2019 09:07:47 -0700
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH 02/15] qla2xxx: Fix different size DMA Alloc/Unmap
Date:   Fri, 26 Jul 2019 09:07:27 -0700
Message-ID: <20190726160740.25687-3-hmadhani@marvell.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20190726160740.25687-1-hmadhani@marvell.com>
References: <20190726160740.25687-1-hmadhani@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-07-26_12:2019-07-26,2019-07-26 signatures=0
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Quinn Tran <qutran@marvell.com>

[   17.177276] qla2xxx 0000:05:00.0: DMA-API: device driver frees DMA memory
    with different size [device address=0x00000006198b0000] [map size=32784 bytes]
    [unmap size=8208 bytes]
[   17.177390] RIP: 0010:check_unmap+0x7a2/0x1750
[   17.177425] Call Trace:
[   17.177438]  debug_dma_free_coherent+0x1b5/0x2d5
[   17.177470]  dma_free_attrs+0x7f/0x140
[   17.177489]  qla24xx_sp_unmap+0x1e2/0x610 [qla2xxx]
[   17.177509]  qla24xx_async_gnnft_done+0x9c6/0x17d0 [qla2xxx]
[   17.177535]  qla2x00_do_work+0x514/0x2200 [qla2xxx]

Fixes: b5f3bc39a0e8 ("scsi: qla2xxx: Fix inconsistent DMA mem alloc/free")
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
---
 drivers/scsi/qla2xxx/qla_gs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index 9f58e591666d..ebf223cfebbc 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -4152,7 +4152,7 @@ int qla24xx_async_gpnft(scsi_qla_host_t *vha, u8 fc4_type, srb_t *sp)
 								rspsz,
 								&sp->u.iocb_cmd.u.ctarg.rsp_dma,
 								GFP_KERNEL);
-		sp->u.iocb_cmd.u.ctarg.rsp_allocated_size = sizeof(struct ct_sns_pkt);
+		sp->u.iocb_cmd.u.ctarg.rsp_allocated_size = rspsz;
 		if (!sp->u.iocb_cmd.u.ctarg.rsp) {
 			ql_log(ql_log_warn, vha, 0xffff,
 			    "Failed to allocate ct_sns request.\n");
-- 
2.12.0

