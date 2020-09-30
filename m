Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2064A27DE66
	for <lists+linux-scsi@lfdr.de>; Wed, 30 Sep 2020 04:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbgI3CSb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 29 Sep 2020 22:18:31 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14729 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729322AbgI3CSb (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 29 Sep 2020 22:18:31 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6FF3124992858853F8A1;
        Wed, 30 Sep 2020 10:18:30 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Wed, 30 Sep 2020
 10:18:22 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <satishkh@cisco.com>, <sebaddel@cisco.com>, <kartilak@cisco.com>,
        <linux-scsi@vger.kernel.org>
CC:     Ye Bin <yebin10@huawei.com>, Hulk Robot <hulkci@huawei.com>
Subject: [PATCH] scsi: fnic: Fix inconsistent of format with argument type in fnic_debugfs.c
Date:   Wed, 30 Sep 2020 10:19:18 +0800
Message-ID: <20200930021919.2832860-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

fix follow warnings:
[drivers/scsi/fnic/fnic_debugfs.c:123]: (warning) %u in format string (no. 1)
	requires 'unsigned int' but the argument type is 'int'.
[drivers/scsi/fnic/fnic_debugfs.c:125]: (warning) %u in format string (no. 1)
	requires 'unsigned int' but the argument type is 'int'.
[drivers/scsi/fnic/fnic_debugfs.c:127]: (warning) %u in format string (no. 1)
	requires 'unsigned int' but the argument type is 'int'.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/scsi/fnic/fnic_debugfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_debugfs.c b/drivers/scsi/fnic/fnic_debugfs.c
index 13f7d88d6e57..6c049360f136 100644
--- a/drivers/scsi/fnic/fnic_debugfs.c
+++ b/drivers/scsi/fnic/fnic_debugfs.c
@@ -120,11 +120,11 @@ static ssize_t fnic_trace_ctrl_read(struct file *filp,
 	len = 0;
 	trace_type = (u8 *)filp->private_data;
 	if (*trace_type == fc_trc_flag->fnic_trace)
-		len = sprintf(buf, "%u\n", fnic_tracing_enabled);
+		len = sprintf(buf, "%d\n", fnic_tracing_enabled);
 	else if (*trace_type == fc_trc_flag->fc_trace)
-		len = sprintf(buf, "%u\n", fnic_fc_tracing_enabled);
+		len = sprintf(buf, "%d\n", fnic_fc_tracing_enabled);
 	else if (*trace_type == fc_trc_flag->fc_clear)
-		len = sprintf(buf, "%u\n", fnic_fc_trace_cleared);
+		len = sprintf(buf, "%d\n", fnic_fc_trace_cleared);
 	else
 		pr_err("fnic: Cannot read to any debugfs file\n");
 
-- 
2.25.4

