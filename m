Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3DC9B091
	for <lists+linux-scsi@lfdr.de>; Fri, 23 Aug 2019 15:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387979AbfHWNQk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 23 Aug 2019 09:16:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5645 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731783AbfHWNQj (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 23 Aug 2019 09:16:39 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C1DD0127EAAAA3D52496;
        Fri, 23 Aug 2019 21:16:33 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 23 Aug 2019
 21:16:22 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <QLogic-Storage-Upstream@qlogic.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH 1/3] scsi: bnx2fc: remove set but not used variable 'fh'
Date:   Fri, 23 Aug 2019 21:22:51 +0800
Message-ID: <1566566573-49300-2-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566566573-49300-1-git-send-email-zhengbin13@huawei.com>
References: <1566566573-49300-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/scsi/bnx2fc/bnx2fc_fcoe.c: In function bnx2fc_rcv:
drivers/scsi/bnx2fc/bnx2fc_fcoe.c:431:26: warning: variable fh set but not used [-Wunused-but-set-variable]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
index 7796799..ab721ab 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -428,7 +428,6 @@ static int bnx2fc_rcv(struct sk_buff *skb, struct net_device *dev,
 	struct fc_lport *lport;
 	struct bnx2fc_interface *interface;
 	struct fcoe_ctlr *ctlr;
-	struct fc_frame_header *fh;
 	struct fcoe_rcv_info *fr;
 	struct fcoe_percpu_s *bg;
 	struct sk_buff *tmp_skb;
@@ -463,7 +462,6 @@ static int bnx2fc_rcv(struct sk_buff *skb, struct net_device *dev,
 		goto err;

 	skb_set_transport_header(skb, sizeof(struct fcoe_hdr));
-	fh = (struct fc_frame_header *) skb_transport_header(skb);

 	fr = fcoe_dev_from_skb(skb);
 	fr->fr_dev = lport;
--
2.7.4

