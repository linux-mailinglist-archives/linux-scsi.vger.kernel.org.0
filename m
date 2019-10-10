Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7E8ED2881
	for <lists+linux-scsi@lfdr.de>; Thu, 10 Oct 2019 13:58:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbfJJL6l (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 10 Oct 2019 07:58:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34548 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726869AbfJJL6l (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 10 Oct 2019 07:58:41 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 08BC439041757D57A4D2;
        Thu, 10 Oct 2019 19:58:39 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Thu, 10 Oct 2019
 19:58:32 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH] scsi: core: fix uninit-value access of variable sshdr
Date:   Thu, 10 Oct 2019 20:05:43 +0800
Message-ID: <1570709143-147364-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

kmsan report a warning in 5.1-rc4:

BUG: KMSAN: uninit-value in sr_get_events drivers/scsi/sr.c:207 [inline]
BUG: KMSAN: uninit-value in sr_check_events+0x2cf/0x1090 drivers/scsi/sr.c:243
CPU: 1 PID: 13858 Comm: syz-executor.0 Tainted: G    B             5.1.0-rc4+ #8
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x173/0x1d0 lib/dump_stack.c:113
 kmsan_report+0x131/0x2a0 mm/kmsan/kmsan.c:619
 __msan_warning+0x7a/0xf0 mm/kmsan/kmsan_instr.c:310
 sr_get_events drivers/scsi/sr.c:207 [inline]
 sr_check_events+0x2cf/0x1090 drivers/scsi/sr.c:243

The reason is as follows:
sr_get_events
  struct scsi_sense_hdr sshdr;  -->uninit
  scsi_execute_req              -->If fail, will not set sshdr
  scsi_sense_valid(&sshdr)      -->access sshdr

We can init sshdr in sr_get_events, but there have many callers of
scsi_execute, scsi_execute_req, we have to troubleshoot all callers,
the simpler way is init sshdr in __scsi_execute.

BTW: we can't just init sshdr->response_code, sr_do_ioctl use
sshdr->sense_key(Need to troubleshoot all callers)

Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/scsi/scsi_lib.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 5447738..037fb2a 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -255,6 +255,12 @@ int __scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 	struct scsi_request *rq;
 	int ret = DRIVER_ERROR << 24;

+	/*
+	 * need to initial sshdr to avoid uninit-value access
+	 */
+	if (sshdr)
+		memset(sshdr, 0, sizeof(struct scsi_sense_hdr));
+
 	req = blk_get_request(sdev->request_queue,
 			data_direction == DMA_TO_DEVICE ?
 			REQ_OP_SCSI_OUT : REQ_OP_SCSI_IN, BLK_MQ_REQ_PREEMPT);
--
2.7.4

