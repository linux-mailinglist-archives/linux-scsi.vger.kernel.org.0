Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 744F3351D2C
	for <lists+linux-scsi@lfdr.de>; Thu,  1 Apr 2021 20:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbhDAS1Z (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 1 Apr 2021 14:27:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15586 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238485AbhDASOh (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 1 Apr 2021 14:14:37 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FB3n44Fsyz1BFh0;
        Thu,  1 Apr 2021 21:24:24 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Thu, 1 Apr 2021 21:26:29 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>
Subject: [PATCH] scsi: qedf: remove unused including <linux/version.h>
Date:   Thu, 1 Apr 2021 21:26:58 +0800
Message-ID: <1617283618-19346-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Remove including <linux/version.h> that don't need it.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Signed-off-by: Zhiqi Song <songzhiqi1@huawei.com>
---
 drivers/scsi/qedf/qedf.h     | 2 --
 drivers/scsi/qedf/qedf_dbg.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/scsi/qedf/qedf.h b/drivers/scsi/qedf/qedf.h
index 88a592d..0583b07 100644
--- a/drivers/scsi/qedf/qedf.h
+++ b/drivers/scsi/qedf/qedf.h
@@ -11,8 +11,6 @@
 #include <scsi/fc/fc_fip.h>
 #include <scsi/fc/fc_fc2.h>
 #include <scsi/scsi_tcq.h>
-#include <linux/version.h>
-
 
 /* qedf_hsi.h needs to before included any qed includes */
 #include "qedf_hsi.h"
diff --git a/drivers/scsi/qedf/qedf_dbg.h b/drivers/scsi/qedf/qedf_dbg.h
index 2386bfb..f4d8112 100644
--- a/drivers/scsi/qedf/qedf_dbg.h
+++ b/drivers/scsi/qedf/qedf_dbg.h
@@ -10,7 +10,6 @@
 #include <linux/kernel.h>
 #include <linux/compiler.h>
 #include <linux/string.h>
-#include <linux/version.h>
 #include <linux/pci.h>
 #include <linux/delay.h>
 #include <scsi/scsi_transport.h>
-- 
2.7.4

