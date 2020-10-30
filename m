Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76FA82A0068
	for <lists+linux-scsi@lfdr.de>; Fri, 30 Oct 2020 09:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgJ3Iuo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 30 Oct 2020 04:50:44 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:6943 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgJ3IuY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 30 Oct 2020 04:50:24 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4CMwWp0wLDz70S0;
        Fri, 30 Oct 2020 16:31:34 +0800 (CST)
Received: from huawei.com (10.69.192.56) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Fri, 30 Oct 2020
 16:31:24 +0800
From:   Luo Jiaxing <luojiaxing@huawei.com>
To:     <akpm@linux-foundation.org>, <viro@zeniv.linux.org.uk>,
        <andriy.shevchenko@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>, <martin.petersen@oracle.com>,
        <john.garry@huawei.com>, <himanshu.madhani@cavium.com>,
        <felipe.balbi@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <uma.shankar@intel.com>, <anshuman.gupta@intel.com>,
        <animesh.manna@intel.com>, <linux-usb@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v2 1/5] seq_file: Introduce DEFINE_SHOW_STORE_ATTRIBUTE() helper macro
Date:   Fri, 30 Oct 2020 16:31:58 +0800
Message-ID: <1604046722-15531-2-git-send-email-luojiaxing@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604046722-15531-1-git-send-email-luojiaxing@huawei.com>
References: <1604046722-15531-1-git-send-email-luojiaxing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

We already own DEFINE_SHOW_ATTRIBUTE() helper macro for defining attribute
for read-only file, but we found many of drivers want a helper marco for
read-write file too.

So we try to make one to decrease code duplication.

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
---
 include/linux/seq_file.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index 813614d..8a474c8 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -191,6 +191,21 @@ static const struct proc_ops __name ## _proc_ops = {			\
 	.proc_release	= single_release,				\
 }
 
+#define DEFINE_SHOW_STORE_ATTRIBUTE(__name)					\
+static int __name ## _open(struct inode *inode, struct file *file)	\
+{									\
+	return single_open(file, __name ## _show, inode->i_private);	\
+}									\
+									\
+static const struct file_operations __name ## _fops = {			\
+	.owner		= THIS_MODULE,					\
+	.open		= __name ## _open,				\
+	.read		= seq_read,					\
+	.write		= __name ## _write,				\
+	.llseek		= seq_lseek,					\
+	.release	= single_release,				\
+}
+
 static inline struct user_namespace *seq_user_ns(struct seq_file *seq)
 {
 #ifdef CONFIG_USER_NS
-- 
2.7.4

