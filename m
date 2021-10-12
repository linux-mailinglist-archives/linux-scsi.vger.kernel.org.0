Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D3142A474
	for <lists+linux-scsi@lfdr.de>; Tue, 12 Oct 2021 14:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236475AbhJLMdn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 12 Oct 2021 08:33:43 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3970 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236474AbhJLMdk (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 12 Oct 2021 08:33:40 -0400
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HTFMJ3mW0z687PR;
        Tue, 12 Oct 2021 20:28:44 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 12 Oct 2021 14:31:37 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 12 Oct 2021 13:31:34 +0100
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <yanaijie@huawei.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        Luo Jiaxing <luojiaxing@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 3/4] scsi: libsas: Export sas_phy_enable()
Date:   Tue, 12 Oct 2021 20:26:27 +0800
Message-ID: <1634041588-74824-4-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1634041588-74824-1-git-send-email-john.garry@huawei.com>
References: <1634041588-74824-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Luo Jiaxing <luojiaxing@huawei.com>

Export sas_phy_enable(), so LLDDs can directly use it to control
remote phys.

We already do this for companion function sas_phy_reset().

Signed-off-by: Luo Jiaxing <luojiaxing@huawei.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/scsi/libsas/sas_init.c | 3 ++-
 include/scsi/libsas.h          | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/libsas/sas_init.c b/drivers/scsi/libsas/sas_init.c
index 37cc92837fdf..b640e09af6a4 100644
--- a/drivers/scsi/libsas/sas_init.c
+++ b/drivers/scsi/libsas/sas_init.c
@@ -254,7 +254,7 @@ static int transport_sas_phy_reset(struct sas_phy *phy, int hard_reset)
 	}
 }
 
-static int sas_phy_enable(struct sas_phy *phy, int enable)
+int sas_phy_enable(struct sas_phy *phy, int enable)
 {
 	int ret;
 	enum phy_func cmd;
@@ -286,6 +286,7 @@ static int sas_phy_enable(struct sas_phy *phy, int enable)
 	}
 	return ret;
 }
+EXPORT_SYMBOL_GPL(sas_phy_enable);
 
 int sas_phy_reset(struct sas_phy *phy, int hard_reset)
 {
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 6fe125a71b60..79e4903bd414 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -664,6 +664,7 @@ extern void sas_suspend_ha(struct sas_ha_struct *sas_ha);
 
 int sas_set_phy_speed(struct sas_phy *phy, struct sas_phy_linkrates *rates);
 int sas_phy_reset(struct sas_phy *phy, int hard_reset);
+int sas_phy_enable(struct sas_phy *phy, int enable);
 extern int sas_queuecommand(struct Scsi_Host *, struct scsi_cmnd *);
 extern int sas_target_alloc(struct scsi_target *);
 extern int sas_slave_configure(struct scsi_device *);
-- 
2.26.2

