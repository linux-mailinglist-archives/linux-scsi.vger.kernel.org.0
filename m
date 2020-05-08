Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54791CA9D8
	for <lists+linux-scsi@lfdr.de>; Fri,  8 May 2020 13:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgEHLnl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 8 May 2020 07:43:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39370 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726792AbgEHLnl (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 8 May 2020 07:43:41 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 258A3EEF90EE3F204B53;
        Fri,  8 May 2020 19:43:39 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Fri, 8 May 2020 19:43:30 +0800
From:   Samuel Zou <zou_wei@huawei.com>
To:     <sathya.prakash@broadcom.com>,
        <suganath-prabu.subramani@broadcom.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>
CC:     <MPT-FusionLinux.pdl@broadcom.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Samuel Zou <zou_wei@huawei.com>
Subject: [PATCH -next] scsi: mpt3sas: Remove unused including <linux/version.h>
Date:   Fri, 8 May 2020 19:49:33 +0800
Message-ID: <1588938573-57847-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix the following versioncheck warning:

drivers/scsi/mpt3sas/mpt3sas_debugfs.c:16:1: unused including <linux/version.h>

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Samuel Zou <zou_wei@huawei.com>
---
 drivers/scsi/mpt3sas/mpt3sas_debugfs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_debugfs.c b/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
index 48095d8..a6ab1db 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_debugfs.c
@@ -13,7 +13,6 @@
  *
  **/
 
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <linux/pci.h>
-- 
2.6.2

