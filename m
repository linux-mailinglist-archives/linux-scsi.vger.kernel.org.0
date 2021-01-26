Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7ABA3046E8
	for <lists+linux-scsi@lfdr.de>; Tue, 26 Jan 2021 19:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390631AbhAZRTe (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 26 Jan 2021 12:19:34 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:47112 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390422AbhAZInk (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 26 Jan 2021 03:43:40 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=abaci-bugfix@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UMy60v3_1611650556;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:abaci-bugfix@linux.alibaba.com fp:SMTPD_---0UMy60v3_1611650556)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 Jan 2021 16:42:40 +0800
From:   Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
To:     njavali@marvell.com
Cc:     GR-QLogic-Storage-Upstream@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
Subject: [PATCH] scsi: qla2xxx: Simplify the calculation of variables
Date:   Tue, 26 Jan 2021 16:42:34 +0800
Message-Id: <1611650554-33019-1-git-send-email-abaci-bugfix@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fix the following coccicheck warnings:

./drivers/scsi/qla2xxx/qla_nvme.c:288:24-26: WARNING !A || A && B is
equivalent to !A || B.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>
---
 drivers/scsi/qla2xxx/qla_nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index eab559b..38196b2 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -285,7 +285,7 @@ static int qla_nvme_ls_req(struct nvme_fc_local_port *lport,
 	srb_t           *sp;
 
 
-	if (!fcport || (fcport && fcport->deleted))
+	if (!fcport || fcport->deleted)
 		return rval;
 
 	vha = fcport->vha;
-- 
1.8.3.1

