Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95FD37BA91
	for <lists+linux-scsi@lfdr.de>; Wed, 31 Jul 2019 09:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfGaHSH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 31 Jul 2019 03:18:07 -0400
Received: from smtp180.sjtu.edu.cn ([202.120.2.180]:46254 "EHLO
        smtp180.sjtu.edu.cn" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbfGaHSG (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 31 Jul 2019 03:18:06 -0400
Received: from proxy01.sjtu.edu.cn (unknown [202.112.26.54])
        by smtp180.sjtu.edu.cn (Postfix) with ESMTPS id BC6571008CBC3;
        Wed, 31 Jul 2019 15:18:04 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
        by proxy01.sjtu.edu.cn (Postfix) with ESMTP id A517820424204;
        Wed, 31 Jul 2019 15:18:04 +0800 (CST)
X-Virus-Scanned: amavisd-new at proxy01.sjtu.edu.cn
Received: from proxy01.sjtu.edu.cn ([127.0.0.1])
        by localhost (proxy01.sjtu.edu.cn [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RqUIkwXbpvC9; Wed, 31 Jul 2019 15:18:04 +0800 (CST)
Received: from xywang-pc.ipads-lab.se.sjtu.edu.cn (unknown [202.120.40.82])
        (Authenticated sender: xywang.sjtu@sjtu.edu.cn)
        by proxy01.sjtu.edu.cn (Postfix) with ESMTPA id 6EC9720424202;
        Wed, 31 Jul 2019 15:18:04 +0800 (CST)
From:   Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
Cc:     sathya.prakash@broadcom.com, chaitra.basappa@broadcom.com,
        suganath-prabu.subramani@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, MPT-FusionLinux.pdl@broadcom.com,
        linux-scsi@vger.kernel.org, Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
Subject: [PATCH] scsi/mpt3sas: force the string buffer NULL-terminated
Date:   Wed, 31 Jul 2019 15:17:57 +0800
Message-Id: <20190731071757.24708-1-xywang.sjtu@sjtu.edu.cn>
X-Mailer: git-send-email 2.11.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

strncpy() does not ensure NULL-termination when the input string
size equals to the destination buffer size 16.
The output string desc is passed to a print-like function
which relies on the NULL-termination.

Use strlcpy() instead.

This issue is detected by a Coccinelle script.

Signed-off-by: Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 684662888792..36d4c0aed18f 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -4296,7 +4296,7 @@ _base_display_ioc_capabilities(struct MPT3SAS_ADAPTER *ioc)
 	u32 bios_version;
 
 	bios_version = le32_to_cpu(ioc->bios_pg3.BiosVersion);
-	strncpy(desc, ioc->manu_pg0.ChipName, 16);
+	strlcpy(desc, ioc->manu_pg0.ChipName, 16);
 	ioc_info(ioc, "%s: FWVersion(%02d.%02d.%02d.%02d), ChipRevision(0x%02x), BiosVersion(%02d.%02d.%02d.%02d)\n",
 		 desc,
 		 (ioc->facts.FWVersion.Word & 0xFF000000) >> 24,
-- 
2.11.0

