Return-Path: <linux-scsi+bounces-501-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30558032FB
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Dec 2023 13:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2FDE1C209F9
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Dec 2023 12:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394F7241FE
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Dec 2023 12:37:39 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917CBC0;
	Mon,  4 Dec 2023 04:32:34 -0800 (PST)
Received: from dggpemd100001.china.huawei.com (unknown [172.30.72.54])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SkNHz6LXWz1P9HV;
	Mon,  4 Dec 2023 20:28:47 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 dggpemd100001.china.huawei.com (7.185.36.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Mon, 4 Dec 2023 20:32:32 +0800
From: Xingui Yang <yangxingui@huawei.com>
To: <john.g.garry@oracle.com>, <yanaijie@huawei.com>, <jejb@linux.ibm.com>,
	<martin.petersen@oracle.com>, <damien.lemoal@opensource.wdc.com>
CC: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>,
	<chenxiang66@hisilicon.com>, <kangfenglong@huawei.com>
Subject: [PATCH v5 1/3] scsi: libsas: Add helper for port add ex_phy
Date: Mon, 4 Dec 2023 12:29:30 +0000
Message-ID: <20231204122932.55741-2-yangxingui@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231204122932.55741-1-yangxingui@huawei.com>
References: <20231204122932.55741-1-yangxingui@huawei.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemd100001.china.huawei.com (7.185.36.94)
X-CFilter-Loop: Reflected

This moves the process of adding ex_phy to a port into a new helper.

Signed-off-by: Xingui Yang <yangxingui@huawei.com>
---
 drivers/scsi/libsas/sas_expander.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index a2204674b680..1257f90130fb 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -26,6 +26,13 @@ static int sas_configure_phy(struct domain_device *dev, int phy_id,
 			     u8 *sas_addr, int include);
 static int sas_disable_routing(struct domain_device *dev,  u8 *sas_addr);
 
+static void sas_port_add_ex_phy(struct sas_port *port, struct ex_phy *ex_phy)
+{
+	sas_port_add_phy(port, ex_phy->phy);
+	ex_phy->port = port;
+	ex_phy->phy_state = PHY_DEVICE_DISCOVERED;
+}
+
 /* ---------- SMP task management ---------- */
 
 /* Give it some long enough timeout. In seconds. */
@@ -857,9 +864,7 @@ static bool sas_ex_join_wide_port(struct domain_device *parent, int phy_id)
 
 		if (!memcmp(phy->attached_sas_addr, ephy->attached_sas_addr,
 			    SAS_ADDR_SIZE) && ephy->port) {
-			sas_port_add_phy(ephy->port, phy->phy);
-			phy->port = ephy->port;
-			phy->phy_state = PHY_DEVICE_DISCOVERED;
+			sas_port_add_ex_phy(ephy->port, phy);
 			return true;
 		}
 	}
-- 
2.17.1


