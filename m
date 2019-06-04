Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C304353D3
	for <lists+linux-scsi@lfdr.de>; Wed,  5 Jun 2019 01:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbfFDX2e (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 4 Jun 2019 19:28:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727675AbfFDXYm (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 4 Jun 2019 19:24:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58A5E20859;
        Tue,  4 Jun 2019 23:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559690680;
        bh=IQJeIejqo+8BehU8kDZiJMpfLq9ssOxdqkCIO3ZfyNI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d+FeTrEyEvnvWNQWlj5i3VSMBYMJE40hHtWxQPKdQelmlg994xeHZJfhtksK9w5yb
         cnqGA51EiVHr7R42Oxed2GrLBH7FBnuyrLrHr64J37vNmTol5ATOdvJWPkq463ZEBQ
         l2ByCdzAjkhGib5ESPeYvfLTz4KzU2ON2/kFdXV4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     YueHaibing <yuehaibing@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 11/24] scsi: qedi: remove memset/memcpy to nfunc and use func instead
Date:   Tue,  4 Jun 2019 19:24:02 -0400
Message-Id: <20190604232416.7479-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190604232416.7479-1-sashal@kernel.org>
References: <20190604232416.7479-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

[ Upstream commit c09581a52765a85f19fc35340127396d5e3379cc ]

KASAN reports this:

BUG: KASAN: global-out-of-bounds in qedi_dbg_err+0xda/0x330 [qedi]
Read of size 31 at addr ffffffffc12b0ae0 by task syz-executor.0/2429

CPU: 0 PID: 2429 Comm: syz-executor.0 Not tainted 5.0.0-rc7+ #45
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xfa/0x1ce lib/dump_stack.c:113
 print_address_description+0x1c4/0x270 mm/kasan/report.c:187
 kasan_report+0x149/0x18d mm/kasan/report.c:317
 memcpy+0x1f/0x50 mm/kasan/common.c:130
 qedi_dbg_err+0xda/0x330 [qedi]
 ? 0xffffffffc12d0000
 qedi_init+0x118/0x1000 [qedi]
 ? 0xffffffffc12d0000
 ? 0xffffffffc12d0000
 ? 0xffffffffc12d0000
 do_one_initcall+0xfa/0x5ca init/main.c:887
 do_init_module+0x204/0x5f6 kernel/module.c:3460
 load_module+0x66b2/0x8570 kernel/module.c:3808
 __do_sys_finit_module+0x238/0x2a0 kernel/module.c:3902
 do_syscall_64+0x147/0x600 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x462e99
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f2d57e55c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 000000000073bfa0 RCX: 0000000000462e99
RDX: 0000000000000000 RSI: 00000000200003c0 RDI: 0000000000000003
RBP: 00007f2d57e55c70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f2d57e566bc
R13: 00000000004bcefb R14: 00000000006f7030 R15: 0000000000000004

The buggy address belongs to the variable:
 __func__.67584+0x0/0xffffffffffffd520 [qedi]

Memory state around the buggy address:
 ffffffffc12b0980: fa fa fa fa 00 04 fa fa fa fa fa fa 00 00 05 fa
 ffffffffc12b0a00: fa fa fa fa 00 00 04 fa fa fa fa fa 00 05 fa fa
> ffffffffc12b0a80: fa fa fa fa 00 06 fa fa fa fa fa fa 00 02 fa fa
                                                          ^
 ffffffffc12b0b00: fa fa fa fa 00 00 04 fa fa fa fa fa 00 00 03 fa
 ffffffffc12b0b80: fa fa fa fa 00 00 02 fa fa fa fa fa 00 00 04 fa

Currently the qedi_dbg_* family of functions can overrun the end of the
source string if it is less than the destination buffer length because of
the use of a fixed sized memcpy. Remove the memset/memcpy calls to nfunc
and just use func instead as it is always a null terminated string.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: ace7f46ba5fd ("scsi: qedi: Add QLogic FastLinQ offload iSCSI driver framework.")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/qedi/qedi_dbg.c | 32 ++++++++------------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/scsi/qedi/qedi_dbg.c b/drivers/scsi/qedi/qedi_dbg.c
index 8fd28b056f73..3383314a3882 100644
--- a/drivers/scsi/qedi/qedi_dbg.c
+++ b/drivers/scsi/qedi/qedi_dbg.c
@@ -16,10 +16,6 @@ qedi_dbg_err(struct qedi_dbg_ctx *qedi, const char *func, u32 line,
 {
 	va_list va;
 	struct va_format vaf;
-	char nfunc[32];
-
-	memset(nfunc, 0, sizeof(nfunc));
-	memcpy(nfunc, func, sizeof(nfunc) - 1);
 
 	va_start(va, fmt);
 
@@ -28,9 +24,9 @@ qedi_dbg_err(struct qedi_dbg_ctx *qedi, const char *func, u32 line,
 
 	if (likely(qedi) && likely(qedi->pdev))
 		pr_err("[%s]:[%s:%d]:%d: %pV", dev_name(&qedi->pdev->dev),
-		       nfunc, line, qedi->host_no, &vaf);
+		       func, line, qedi->host_no, &vaf);
 	else
-		pr_err("[0000:00:00.0]:[%s:%d]: %pV", nfunc, line, &vaf);
+		pr_err("[0000:00:00.0]:[%s:%d]: %pV", func, line, &vaf);
 
 	va_end(va);
 }
@@ -41,10 +37,6 @@ qedi_dbg_warn(struct qedi_dbg_ctx *qedi, const char *func, u32 line,
 {
 	va_list va;
 	struct va_format vaf;
-	char nfunc[32];
-
-	memset(nfunc, 0, sizeof(nfunc));
-	memcpy(nfunc, func, sizeof(nfunc) - 1);
 
 	va_start(va, fmt);
 
@@ -56,9 +48,9 @@ qedi_dbg_warn(struct qedi_dbg_ctx *qedi, const char *func, u32 line,
 
 	if (likely(qedi) && likely(qedi->pdev))
 		pr_warn("[%s]:[%s:%d]:%d: %pV", dev_name(&qedi->pdev->dev),
-			nfunc, line, qedi->host_no, &vaf);
+			func, line, qedi->host_no, &vaf);
 	else
-		pr_warn("[0000:00:00.0]:[%s:%d]: %pV", nfunc, line, &vaf);
+		pr_warn("[0000:00:00.0]:[%s:%d]: %pV", func, line, &vaf);
 
 ret:
 	va_end(va);
@@ -70,10 +62,6 @@ qedi_dbg_notice(struct qedi_dbg_ctx *qedi, const char *func, u32 line,
 {
 	va_list va;
 	struct va_format vaf;
-	char nfunc[32];
-
-	memset(nfunc, 0, sizeof(nfunc));
-	memcpy(nfunc, func, sizeof(nfunc) - 1);
 
 	va_start(va, fmt);
 
@@ -85,10 +73,10 @@ qedi_dbg_notice(struct qedi_dbg_ctx *qedi, const char *func, u32 line,
 
 	if (likely(qedi) && likely(qedi->pdev))
 		pr_notice("[%s]:[%s:%d]:%d: %pV",
-			  dev_name(&qedi->pdev->dev), nfunc, line,
+			  dev_name(&qedi->pdev->dev), func, line,
 			  qedi->host_no, &vaf);
 	else
-		pr_notice("[0000:00:00.0]:[%s:%d]: %pV", nfunc, line, &vaf);
+		pr_notice("[0000:00:00.0]:[%s:%d]: %pV", func, line, &vaf);
 
 ret:
 	va_end(va);
@@ -100,10 +88,6 @@ qedi_dbg_info(struct qedi_dbg_ctx *qedi, const char *func, u32 line,
 {
 	va_list va;
 	struct va_format vaf;
-	char nfunc[32];
-
-	memset(nfunc, 0, sizeof(nfunc));
-	memcpy(nfunc, func, sizeof(nfunc) - 1);
 
 	va_start(va, fmt);
 
@@ -115,9 +99,9 @@ qedi_dbg_info(struct qedi_dbg_ctx *qedi, const char *func, u32 line,
 
 	if (likely(qedi) && likely(qedi->pdev))
 		pr_info("[%s]:[%s:%d]:%d: %pV", dev_name(&qedi->pdev->dev),
-			nfunc, line, qedi->host_no, &vaf);
+			func, line, qedi->host_no, &vaf);
 	else
-		pr_info("[0000:00:00.0]:[%s:%d]: %pV", nfunc, line, &vaf);
+		pr_info("[0000:00:00.0]:[%s:%d]: %pV", func, line, &vaf);
 
 ret:
 	va_end(va);
-- 
2.20.1

