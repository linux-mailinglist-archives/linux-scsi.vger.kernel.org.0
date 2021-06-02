Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69C6E397F74
	for <lists+linux-scsi@lfdr.de>; Wed,  2 Jun 2021 05:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhFBD2e (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 1 Jun 2021 23:28:34 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6131 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbhFBD2e (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 1 Jun 2021 23:28:34 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FvvWp0wMLzYpw3;
        Wed,  2 Jun 2021 11:24:06 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 11:26:50 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 11:26:49 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "megaraidlinux . pdl" <megaraidlinux.pdl@broadcom.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] scsi: megaraid_mbox: use DEVICE_ATTR_ADMIN_RO macro
Date:   Wed, 2 Jun 2021 11:25:41 +0800
Message-ID: <20210602032541.10852-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Use DEVICE_ATTR_ADMIN_RO macro helper instead of plain DEVICE_ATTR, which
makes the code a bit shorter and easier to read.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/scsi/megaraid/megaraid_mbox.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_mbox.c b/drivers/scsi/megaraid/megaraid_mbox.c
index d3fac99db786256..d20c2e4ee7934c9 100644
--- a/drivers/scsi/megaraid/megaraid_mbox.c
+++ b/drivers/scsi/megaraid/megaraid_mbox.c
@@ -121,8 +121,8 @@ static irqreturn_t megaraid_isr(int, void *);
 
 static void megaraid_mbox_dpc(unsigned long);
 
-static ssize_t megaraid_sysfs_show_app_hndl(struct device *, struct device_attribute *attr, char *);
-static ssize_t megaraid_sysfs_show_ldnum(struct device *, struct device_attribute *attr, char *);
+static ssize_t megaraid_mbox_app_hndl_show(struct device *, struct device_attribute *attr, char *);
+static ssize_t megaraid_mbox_ld_show(struct device *, struct device_attribute *attr, char *);
 
 static int megaraid_cmm_register(adapter_t *);
 static int megaraid_cmm_unregister(adapter_t *);
@@ -302,8 +302,7 @@ static struct pci_driver megaraid_pci_driver = {
 // definitions for the device attributes for exporting logical drive number
 // for a scsi address (Host, Channel, Id, Lun)
 
-static DEVICE_ATTR(megaraid_mbox_app_hndl, S_IRUSR, megaraid_sysfs_show_app_hndl,
-		   NULL);
+static DEVICE_ATTR_ADMIN_RO(megaraid_mbox_app_hndl);
 
 // Host template initializer for megaraid mbox sysfs device attributes
 static struct device_attribute *megaraid_shost_attrs[] = {
@@ -312,7 +311,7 @@ static struct device_attribute *megaraid_shost_attrs[] = {
 };
 
 
-static DEVICE_ATTR(megaraid_mbox_ld, S_IRUSR, megaraid_sysfs_show_ldnum, NULL);
+static DEVICE_ATTR_ADMIN_RO(megaraid_mbox_ld);
 
 // Host template initializer for megaraid mbox sysfs device attributes
 static struct device_attribute *megaraid_sdev_attrs[] = {
@@ -3961,7 +3960,7 @@ megaraid_sysfs_get_ldmap(adapter_t *adapter)
 
 
 /**
- * megaraid_sysfs_show_app_hndl - display application handle for this adapter
+ * megaraid_mbox_app_hndl_show - display application handle for this adapter
  * @dev		: class device object representation for the host
  * @attr	: device attribute (unused)
  * @buf		: buffer to send data to
@@ -3971,8 +3970,7 @@ megaraid_sysfs_get_ldmap(adapter_t *adapter)
  * handle, since we do not interface with applications directly.
  */
 static ssize_t
-megaraid_sysfs_show_app_hndl(struct device *dev, struct device_attribute *attr,
-			     char *buf)
+megaraid_mbox_app_hndl_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct Scsi_Host *shost = class_to_shost(dev);
 	adapter_t	*adapter = (adapter_t *)SCSIHOST2ADAP(shost);
@@ -3985,7 +3983,7 @@ megaraid_sysfs_show_app_hndl(struct device *dev, struct device_attribute *attr,
 
 
 /**
- * megaraid_sysfs_show_ldnum - display the logical drive number for this device
+ * megaraid_mbox_ld_show - display the logical drive number for this device
  * @dev		: device object representation for the scsi device
  * @attr	: device attribute to show
  * @buf		: buffer to send data to
@@ -4000,7 +3998,7 @@ megaraid_sysfs_show_app_hndl(struct device *dev, struct device_attribute *attr,
  *   <int>     <int>       <int>            <int>
  */
 static ssize_t
-megaraid_sysfs_show_ldnum(struct device *dev, struct device_attribute *attr, char *buf)
+megaraid_mbox_ld_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct scsi_device *sdev = to_scsi_device(dev);
 	adapter_t	*adapter = (adapter_t *)SCSIHOST2ADAP(sdev->host);
-- 
2.26.0.106.g9fadedd


