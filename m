Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9CE223760
	for <lists+linux-scsi@lfdr.de>; Fri, 17 Jul 2020 10:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgGQIvR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 17 Jul 2020 04:51:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:54168 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725970AbgGQIvR (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 17 Jul 2020 04:51:17 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 937D9A3AC8D0FF4393C1;
        Fri, 17 Jul 2020 16:51:14 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Fri, 17 Jul 2020 16:51:03 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <john.garry@huawei.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <guohanjun@huawei.com>, <wangxiongfeng2@huawei.com>
Subject: [PATCH v2] scsi: scsi_transport_sas: add missing newline when printing 'enable' by sysfs
Date:   Fri, 17 Jul 2020 16:44:32 +0800
Message-ID: <1594975472-12486-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

When I cat sysfs file 'enable' below 'sas_phy', it displays as follows.
It's better to add a newline for easy reading.

[root@localhost ~]# cat /sys/devices/pci0000:00/0000:00:0d.0/0000:0f:00.0/host3/phy-3:2/sas_phy/phy-3:2/enable
1[root@localhost ~]#

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Reviewed-by: John Garry <john.garry@huawei.com>

---
v1 -> v2:
	modify commit subject.
	add Reviewed-by tag.
---
 drivers/scsi/scsi_transport_sas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
index 182fd25..e443dee 100644
--- a/drivers/scsi/scsi_transport_sas.c
+++ b/drivers/scsi/scsi_transport_sas.c
@@ -563,7 +563,7 @@ static ssize_t do_sas_phy_enable(struct device *dev,
 {
 	struct sas_phy *phy = transport_class_to_phy(dev);
 
-	return snprintf(buf, 20, "%d", phy->enabled);
+	return snprintf(buf, 20, "%d\n", phy->enabled);
 }
 
 static DEVICE_ATTR(enable, S_IRUGO | S_IWUSR, show_sas_phy_enable,
-- 
1.7.12.4

