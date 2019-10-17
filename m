Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADC4DA556
	for <lists+linux-scsi@lfdr.de>; Thu, 17 Oct 2019 08:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394580AbfJQGMi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 17 Oct 2019 02:12:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4233 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390579AbfJQGMi (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 17 Oct 2019 02:12:38 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id ED60EF72EFD8A04F1F1E;
        Thu, 17 Oct 2019 14:12:36 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 17 Oct 2019
 14:12:28 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <bvanassche@acm.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH v4 2/2] scsi: core: fix uninit-value access of variable sshdr
Date:   Thu, 17 Oct 2019 14:19:37 +0800
Message-ID: <1571293177-117087-3-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571293177-117087-1-git-send-email-zhengbin13@huawei.com>
References: <1571293177-117087-1-git-send-email-zhengbin13@huawei.com>
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

Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/scsi/scsi_lib.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 5447738..d5e29c5 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -255,6 +255,13 @@ int __scsi_execute(struct scsi_device *sdev, const unsigned char *cmd,
 	struct scsi_request *rq;
 	int ret = DRIVER_ERROR << 24;

+	/*
+	 * Zero-initialize sshdr for those callers that check the *sshdr
+	 * contents even if no sense data is available.
+	 */
+	if (sshdr)
+		memset(sshdr, 0, sizeof(struct scsi_sense_hdr));
+
 	req = blk_get_request(sdev->request_queue,
 			data_direction == DMA_TO_DEVICE ?
 			REQ_OP_SCSI_OUT : REQ_OP_SCSI_IN, BLK_MQ_REQ_PREEMPT);
--
2.7.4

