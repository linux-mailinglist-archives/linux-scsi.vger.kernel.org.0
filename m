Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAE9CDA555
	for <lists+linux-scsi@lfdr.de>; Thu, 17 Oct 2019 08:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404729AbfJQGMj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 17 Oct 2019 02:12:39 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4234 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392543AbfJQGMi (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 17 Oct 2019 02:12:38 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F27E2EBFAF4DE34A05CA;
        Thu, 17 Oct 2019 14:12:36 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 17 Oct 2019
 14:12:27 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <bvanassche@acm.org>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH v4 1/2] sr: need to check whether sshdr is valid in sr_do_ioctl
Date:   Thu, 17 Oct 2019 14:19:36 +0800
Message-ID: <1571293177-117087-2-git-send-email-zhengbin13@huawei.com>
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

Like other callers of scsi_execute(send_trespass_cmd, hp_sw_tur...),
we need to check whether sshdr is valid.

Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/scsi/sr_ioctl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/sr_ioctl.c b/drivers/scsi/sr_ioctl.c
index ffcf902..335cfdd 100644
--- a/drivers/scsi/sr_ioctl.c
+++ b/drivers/scsi/sr_ioctl.c
@@ -206,6 +206,11 @@ int sr_do_ioctl(Scsi_CD *cd, struct packet_command *cgc)

 	/* Minimal error checking.  Ignore cases we know about, and report the rest. */
 	if (driver_byte(result) != 0) {
+		if (!scsi_sense_valid(sshdr)) {
+			err = -EIO;
+			goto out;
+		}
+
 		switch (sshdr->sense_key) {
 		case UNIT_ATTENTION:
 			SDev->changed = 1;
--
2.7.4

