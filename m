Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08D838D47E
	for <lists+linux-scsi@lfdr.de>; Sat, 22 May 2021 10:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhEVImW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 22 May 2021 04:42:22 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4581 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhEVImH (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 22 May 2021 04:42:07 -0400
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FnH0x0KHBzsT6B;
        Sat, 22 May 2021 16:37:53 +0800 (CST)
Received: from dggemi760-chm.china.huawei.com (10.1.198.146) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 16:40:41 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggemi760-chm.china.huawei.com (10.1.198.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 22 May 2021 16:40:40 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tanghui20@huawei.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Subject: [PATCH 21/24] scsi: ips: remove leading spaces before tabs
Date:   Sat, 22 May 2021 16:37:25 +0800
Message-ID: <1621672648-39955-22-git-send-email-tanghui20@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1621672648-39955-1-git-send-email-tanghui20@huawei.com>
References: <1621672648-39955-1-git-send-email-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggemi760-chm.china.huawei.com (10.1.198.146)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

There are a few leading spaces before tabs and remove it by running
the following commard:

    $ find . -name '*.[ch]' | xargs sed -r -i 's/^[ ]+\t/\t/'

Cc: Adaptec OEM Raid Solutions <aacraid@microsemi.com>
Signed-off-by: Hui Tang <tanghui20@huawei.com>
---
 drivers/scsi/ips.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ips.c b/drivers/scsi/ips.c
index bc33d54..07e0ceb 100644
--- a/drivers/scsi/ips.c
+++ b/drivers/scsi/ips.c
@@ -3314,7 +3314,7 @@ ips_map_status(ips_ha_t * ha, ips_scb_t * scb, ips_stat_t * sp)
 				if (scb->scsi_cmd->cmnd[0] == INQUIRY) {
 				    ips_scmd_buf_read(scb->scsi_cmd,
                                       &inquiryData, sizeof (inquiryData));
- 				    if ((inquiryData.DeviceType & 0x1f) == TYPE_DISK) {
+				    if ((inquiryData.DeviceType & 0x1f) == TYPE_DISK) {
 				        errcode = DID_TIME_OUT;
 				        break;
 				    }
@@ -4558,7 +4558,7 @@ ips_flush_and_reset(ips_ha_t *ha)
 {
 	ips_scb_t *scb;
 	int  ret;
- 	int  time;
+	int  time;
 	int  done;
 	dma_addr_t command_dma;
 
-- 
2.8.1

