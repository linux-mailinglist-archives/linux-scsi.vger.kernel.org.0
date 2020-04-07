Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 703711A0A20
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Apr 2020 11:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgDGJaJ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 Apr 2020 05:30:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12619 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726637AbgDGJaJ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 7 Apr 2020 05:30:09 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 597CA9DB787C0BBBCC12;
        Tue,  7 Apr 2020 17:30:03 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Tue, 7 Apr 2020
 17:29:54 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <kashyap.desai@broadcom.com>, <sumit.saxena@broadcom.com>,
        <shivasharan.srikanteshwara@broadcom.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <megaraidlinux.pdl@broadcom.com>,
        <linux-scsi@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH 1/4] scsi: megaraid: make two symbols static in megaraid_mbox.c
Date:   Tue, 7 Apr 2020 17:28:24 +0800
Message-ID: <20200407092827.18074-2-yanaijie@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200407092827.18074-1-yanaijie@huawei.com>
References: <20200407092827.18074-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix the following sparse warning:

drivers/scsi/megaraid/megaraid_mbox.c:305:5: warning: symbol
'dev_attr_megaraid_mbox_app_hndl' was not declared. Should it be static?
drivers/scsi/megaraid/megaraid_mbox.c:315:5: warning: symbol
'dev_attr_megaraid_mbox_ld' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/megaraid/megaraid_mbox.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_mbox.c b/drivers/scsi/megaraid/megaraid_mbox.c
index 8443f2f35be2..8f918df631bf 100644
--- a/drivers/scsi/megaraid/megaraid_mbox.c
+++ b/drivers/scsi/megaraid/megaraid_mbox.c
@@ -302,8 +302,8 @@ static struct pci_driver megaraid_pci_driver = {
 // definitions for the device attributes for exporting logical drive number
 // for a scsi address (Host, Channel, Id, Lun)
 
-DEVICE_ATTR(megaraid_mbox_app_hndl, S_IRUSR, megaraid_sysfs_show_app_hndl,
-		NULL);
+static DEVICE_ATTR(megaraid_mbox_app_hndl, S_IRUSR, megaraid_sysfs_show_app_hndl,
+		   NULL);
 
 // Host template initializer for megaraid mbox sysfs device attributes
 static struct device_attribute *megaraid_shost_attrs[] = {
@@ -312,7 +312,7 @@ static struct device_attribute *megaraid_shost_attrs[] = {
 };
 
 
-DEVICE_ATTR(megaraid_mbox_ld, S_IRUSR, megaraid_sysfs_show_ldnum, NULL);
+static DEVICE_ATTR(megaraid_mbox_ld, S_IRUSR, megaraid_sysfs_show_ldnum, NULL);
 
 // Host template initializer for megaraid mbox sysfs device attributes
 static struct device_attribute *megaraid_sdev_attrs[] = {
-- 
2.17.2

