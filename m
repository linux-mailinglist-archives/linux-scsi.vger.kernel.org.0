Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D10926BA23
	for <lists+linux-scsi@lfdr.de>; Wed, 16 Sep 2020 04:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgIPC2f (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 15 Sep 2020 22:28:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58530 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726406AbgIPC2G (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 15 Sep 2020 22:28:06 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 73DDE467085A06020A0E;
        Wed, 16 Sep 2020 10:28:04 +0800 (CST)
Received: from huawei.com (10.175.113.32) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Wed, 16 Sep 2020
 10:27:55 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Karan Tilak Kumar <kartilak@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH -next] scsi: snic: convert to use DEFINE_SEQ_ATTRIBUTE macro
Date:   Wed, 16 Sep 2020 10:50:30 +0800
Message-ID: <20200916025030.3992991-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use DEFINE_SEQ_ATTRIBUTE macro to simplify the code.

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 drivers/scsi/snic/snic_debugfs.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/snic/snic_debugfs.c b/drivers/scsi/snic/snic_debugfs.c
index 2b349365592f..4471c4c8aafa 100644
--- a/drivers/scsi/snic/snic_debugfs.c
+++ b/drivers/scsi/snic/snic_debugfs.c
@@ -439,26 +439,14 @@ snic_trc_seq_show(struct seq_file *sfp, void *data)
 	return 0;
 }
 
-static const struct seq_operations snic_trc_seq_ops = {
+static const struct seq_operations snic_trc_sops = {
 	.start	= snic_trc_seq_start,
 	.next	= snic_trc_seq_next,
 	.stop	= snic_trc_seq_stop,
 	.show	= snic_trc_seq_show,
 };
 
-static int
-snic_trc_open(struct inode *inode, struct file *filp)
-{
-	return seq_open(filp, &snic_trc_seq_ops);
-}
-
-static const struct file_operations snic_trc_fops = {
-	.owner	= THIS_MODULE,
-	.open	= snic_trc_open,
-	.read	= seq_read,
-	.llseek = seq_lseek,
-	.release = seq_release,
-};
+DEFINE_SEQ_ATTRIBUTE(snic_trc);
 
 /*
  * snic_trc_debugfs_init : creates trace/tracing_enable files for trace
-- 
2.25.1

