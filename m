Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13BBB302528
	for <lists+linux-scsi@lfdr.de>; Mon, 25 Jan 2021 13:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbhAYMuI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 25 Jan 2021 07:50:08 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:11872 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbhAYMth (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 25 Jan 2021 07:49:37 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DPTWv4Q50z7Ts8;
        Mon, 25 Jan 2021 20:22:19 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Mon, 25 Jan 2021 20:23:20 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <achim_leubner@adaptec.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] scsi: gdth: Remove unused including <linux/version.h>
Date:   Mon, 25 Jan 2021 20:34:22 +0800
Message-ID: <1611578062-42802-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix the following versioncheck warning:

drivers/scsi/gdth.c:85:1: unused including <linux/version.h>

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 drivers/scsi/gdth.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/gdth.c b/drivers/scsi/gdth.c
index f43bd53..f949001 100644
--- a/drivers/scsi/gdth.c
+++ b/drivers/scsi/gdth.c
@@ -82,7 +82,6 @@
 
 #include <linux/module.h>
 
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/pci.h>
-- 
2.6.2

