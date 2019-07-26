Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E539B76E9C
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jul 2019 18:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfGZQJU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 26 Jul 2019 12:09:20 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:26238 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726769AbfGZQJT (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 26 Jul 2019 12:09:19 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6QG5fBe017783;
        Fri, 26 Jul 2019 09:08:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0818; bh=8+UMeTcwRNBZ5QyntRoc88ZiOSPOafy2ti4qEKKqNEI=;
 b=kZNuHWc1OsSA00tOxqkFRTtfcTQQUL0ZbpA/itvT1oNgYpyDeSEQFjXumMuuhYooaz8j
 6UsgsEMI//w1VQdBC+0RzLbHt5icSmyPkQry0IBaGG95LRmCibnfAcwsXaREZyiM1n/m
 UychcaQJG3MF4SI5UwIIfv0Zy+A14GWH0cAfHy1lz8TYyPVfMNRlN1vs9RHZ3u9trRDX
 uYi7AVdzevNYtWnbOkDKnoq+NFuU+Y9Y1WszAv5tA12SW5QxYnt12wtpYJXu2dCScdWl
 eUXwKX9r+1A/E9IJa1+nMCICBD7Bz3PB0sCXrKvhggP4kEhPJcmOAKCPs0KC2w34WiTh 0Q== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2tx61rqjyu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 26 Jul 2019 09:08:17 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 26 Jul
 2019 09:08:16 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 26 Jul 2019 09:08:16 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
        by maili.marvell.com (Postfix) with ESMTP id 010073F703F;
        Fri, 26 Jul 2019 09:08:15 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
        by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id x6QG8Fpb025778;
        Fri, 26 Jul 2019 09:08:15 -0700
Received: (from root@localhost)
        by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id x6QG8FsD025777;
        Fri, 26 Jul 2019 09:08:15 -0700
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>
CC:     <hmadhani@marvell.com>, <linux-scsi@vger.kernel.org>
Subject: [PATCH 12/15] qla2xxx: Use common update-firmware-options routine for ISP27xx+
Date:   Fri, 26 Jul 2019 09:07:37 -0700
Message-ID: <20190726160740.25687-13-hmadhani@marvell.com>
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

From: Andrew Vasquez <andrewv@marvell.com>

Leverage the generic routine, qla24xx_update_fw_options(), for the
configuration of firmware options for ISP27xx/ISP28xx.

Signed-off-by: Andrew Vasquez <andrewv@marvell.com>
Signed-off-by: Himanshu Madhani <hmadhani@marvell.com>
---
 drivers/scsi/qla2xxx/qla_os.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 17d581563eec..1bb4b417fb6a 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -2491,7 +2491,7 @@ static struct isp_operations qla27xx_isp_ops = {
 	.config_rings		= qla24xx_config_rings,
 	.reset_adapter		= qla24xx_reset_adapter,
 	.nvram_config		= qla81xx_nvram_config,
-	.update_fw_options	= qla81xx_update_fw_options,
+	.update_fw_options	= qla24xx_update_fw_options,
 	.load_risc		= qla81xx_load_risc,
 	.pci_info_str		= qla24xx_pci_info_str,
 	.fw_version_str		= qla24xx_fw_version_str,
-- 
2.12.0

