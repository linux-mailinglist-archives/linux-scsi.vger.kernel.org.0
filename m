Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B71E1A3139
	for <lists+linux-scsi@lfdr.de>; Thu,  9 Apr 2020 10:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgDIIu5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 9 Apr 2020 04:50:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12626 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726702AbgDIIu4 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 9 Apr 2020 04:50:56 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0F84898B1BD6B12F272A;
        Thu,  9 Apr 2020 16:50:49 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Thu, 9 Apr 2020
 16:50:38 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <mdr@sgi.com>, <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] scsi: qla1280: make qla1280_firmware_mutex and qla1280_fw_tbl static
Date:   Thu, 9 Apr 2020 16:49:10 +0800
Message-ID: <20200409084910.44336-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix the following sparse warning:

drivers/scsi/qla1280.c:529:1: warning: symbol 'qla1280_firmware_mutex'
was not declared. Should it be static?
drivers/scsi/qla1280.c:538:15: warning: symbol 'qla1280_fw_tbl' was not
declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/qla1280.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla1280.c b/drivers/scsi/qla1280.c
index 3337cd341d21..441a45349349 100644
--- a/drivers/scsi/qla1280.c
+++ b/drivers/scsi/qla1280.c
@@ -526,7 +526,7 @@ static struct pci_device_id qla1280_pci_tbl[] = {
 };
 MODULE_DEVICE_TABLE(pci, qla1280_pci_tbl);
 
-DEFINE_MUTEX(qla1280_firmware_mutex);
+static DEFINE_MUTEX(qla1280_firmware_mutex);
 
 struct qla_fw {
 	char *fwname;
@@ -535,7 +535,7 @@ struct qla_fw {
 
 #define QL_NUM_FW_IMAGES 3
 
-struct qla_fw qla1280_fw_tbl[QL_NUM_FW_IMAGES] = {
+static struct qla_fw qla1280_fw_tbl[QL_NUM_FW_IMAGES] = {
 	{"qlogic/1040.bin",  NULL},	/* image 0 */
 	{"qlogic/1280.bin",  NULL},	/* image 1 */
 	{"qlogic/12160.bin", NULL},	/* image 2 */
-- 
2.17.2

