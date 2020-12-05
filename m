Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D125D2CF901
	for <lists+linux-scsi@lfdr.de>; Sat,  5 Dec 2020 03:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgLECkb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 4 Dec 2020 21:40:31 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:53958 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725300AbgLECk1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 4 Dec 2020 21:40:27 -0500
X-UUID: 70cd198581f44444950f03ccd8f8c3ae-20201205
X-UUID: 70cd198581f44444950f03ccd8f8c3ae-20201205
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 24090389; Sat, 05 Dec 2020 10:39:42 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 5 Dec 2020 10:39:37 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 5 Dec 2020 10:39:36 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <martin.petersen@oracle.com>,
        <avri.altman@wdc.com>, <alim.akhtar@samsung.com>,
        <jejb@linux.ibm.com>
CC:     <beanhuo@micron.com>, <asutoshd@codeaurora.org>,
        <cang@codeaurora.org>, <matthias.bgg@gmail.com>,
        <bvanassche@acm.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kuohong.wang@mediatek.com>,
        <peter.wang@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <andy.teng@mediatek.com>, <chaotian.jing@mediatek.com>,
        <cc.chou@mediatek.com>, <jiajie.hao@mediatek.com>,
        <alice.chao@mediatek.com>, <huadian.liu@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH v4 8/8] scsi: ufs-mediatek: Introduce event_notify implementation
Date:   Sat, 5 Dec 2020 10:39:38 +0800
Message-ID: <20201205023938.13848-9-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201205023938.13848-1-stanley.chu@mediatek.com>
References: <20201205023938.13848-1-stanley.chu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Introduce event_notify implementation on MediaTek UFS platform.

A vendor-specific tracepoint is added that could be used
for debugging purpose.

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/scsi/ufs/ufs-mediatek-trace.h | 37 +++++++++++++++++++++++++++
 drivers/scsi/ufs/ufs-mediatek.c       | 12 +++++++++
 2 files changed, 49 insertions(+)
 create mode 100644 drivers/scsi/ufs/ufs-mediatek-trace.h

diff --git a/drivers/scsi/ufs/ufs-mediatek-trace.h b/drivers/scsi/ufs/ufs-mediatek-trace.h
new file mode 100644
index 000000000000..8c47f54f3e6b
--- /dev/null
+++ b/drivers/scsi/ufs/ufs-mediatek-trace.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 MediaTek Inc.
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM ufs_mtk
+
+#if !defined(_TRACE_EVENT_UFS_MEDIATEK_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_EVENT_UFS_MEDIATEK_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(ufs_mtk_event,
+	TP_PROTO(unsigned int type, unsigned int data),
+	TP_ARGS(type, data),
+
+	TP_STRUCT__entry(
+		__field(unsigned int, type)
+		__field(unsigned int, data)
+	),
+
+	TP_fast_assign(
+		__entry->type = type;
+		__entry->data = data;
+	),
+
+	TP_printk("ufs:event=%u data=%u",
+		  __entry->type, __entry->data)
+	);
+#endif
+
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE ufs-mediatek-trace
+#include <trace/define_trace.h>
+
diff --git a/drivers/scsi/ufs/ufs-mediatek.c b/drivers/scsi/ufs/ufs-mediatek.c
index 1d3c5cd4592e..3522458db3bb 100644
--- a/drivers/scsi/ufs/ufs-mediatek.c
+++ b/drivers/scsi/ufs/ufs-mediatek.c
@@ -24,6 +24,9 @@
 #include "unipro.h"
 #include "ufs-mediatek.h"
 
+#define CREATE_TRACE_POINTS
+#include "ufs-mediatek-trace.h"
+
 #define ufs_mtk_smc(cmd, val, res) \
 	arm_smccc_smc(MTK_SIP_UFS_CONTROL, \
 		      cmd, val, 0, 0, 0, 0, 0, &(res))
@@ -1002,6 +1005,14 @@ static void ufs_mtk_fixup_dev_quirks(struct ufs_hba *hba)
 	ufshcd_fixup_dev_quirks(hba, ufs_mtk_dev_fixups);
 }
 
+static void ufs_mtk_event_notify(struct ufs_hba *hba,
+				 enum ufs_event_type evt, void *data)
+{
+	unsigned int val = *(u32 *)data;
+
+	trace_ufs_mtk_event(evt, val);
+}
+
 /*
  * struct ufs_hba_mtk_vops - UFS MTK specific variant operations
  *
@@ -1021,6 +1032,7 @@ static const struct ufs_hba_variant_ops ufs_hba_mtk_vops = {
 	.resume              = ufs_mtk_resume,
 	.dbg_register_dump   = ufs_mtk_dbg_register_dump,
 	.device_reset        = ufs_mtk_device_reset,
+	.event_notify        = ufs_mtk_event_notify,
 };
 
 /**
-- 
2.18.0

