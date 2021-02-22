Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09E5132116E
	for <lists+linux-scsi@lfdr.de>; Mon, 22 Feb 2021 08:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhBVHfM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 22 Feb 2021 02:35:12 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:53089 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229915AbhBVHfM (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 22 Feb 2021 02:35:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UPCfR2._1613979267;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0UPCfR2._1613979267)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 22 Feb 2021 15:34:28 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     skashyap@marvell.com
Cc:     jhasan@marvell.com, GR-QLogic-Storage-Upstream@marvell.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH] scsi: qedf: Switch to using the new API kobj_to_dev()
Date:   Mon, 22 Feb 2021 15:34:26 +0800
Message-Id: <1613979266-13667-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

fixed the following coccicheck:
./drivers/scsi/qedf/qedf_attr.c:105:26-27: WARNING opportunity for
kobj_to_dev()
./drivers/scsi/qedf/qedf_attr.c:134:24-25: WARNING opportunity for
kobj_to_dev()

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/scsi/qedf/qedf_attr.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/qedf/qedf_attr.c b/drivers/scsi/qedf/qedf_attr.c
index d995f72..33d2281 100644
--- a/drivers/scsi/qedf/qedf_attr.c
+++ b/drivers/scsi/qedf/qedf_attr.c
@@ -101,8 +101,7 @@ void qedf_capture_grc_dump(struct qedf_ctx *qedf)
 			size_t count)
 {
 	ssize_t ret = 0;
-	struct fc_lport *lport = shost_priv(dev_to_shost(container_of(kobj,
-							struct device, kobj)));
+	struct fc_lport *lport = shost_priv(dev_to_shost(kobj_to_dev(kobj)));
 	struct qedf_ctx *qedf = lport_priv(lport);
 
 	if (test_bit(QEDF_GRCDUMP_CAPTURE, &qedf->flags)) {
@@ -130,8 +129,7 @@ void qedf_capture_grc_dump(struct qedf_ctx *qedf)
 		return ret;
 
 
-	lport = shost_priv(dev_to_shost(container_of(kobj,
-	    struct device, kobj)));
+	lport = shost_priv(dev_to_shost(kobj_to_dev(kobj)));
 	qedf = lport_priv(lport);
 
 	buf[1] = 0;
-- 
1.8.3.1

