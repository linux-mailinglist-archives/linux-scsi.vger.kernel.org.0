Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F133914F9
	for <lists+linux-scsi@lfdr.de>; Wed, 26 May 2021 12:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233915AbhEZKgg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 26 May 2021 06:36:36 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:60599 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233901AbhEZKgf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 26 May 2021 06:36:35 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Ua9lpea_1622025299;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0Ua9lpea_1622025299)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 26 May 2021 18:35:02 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     satishkh@cisco.com
Cc:     sebaddel@cisco.com, kartilak@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] scsi: fnic: Fix inconsistent indenting
Date:   Wed, 26 May 2021 18:34:52 +0800
Message-Id: <1622025292-46456-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Eliminate the follow smatch warning:

drivers/scsi/fnic/fnic_fcs.c:164 fnic_handle_link() warn: inconsistent
indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/scsi/fnic/fnic_fcs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/fnic/fnic_fcs.c b/drivers/scsi/fnic/fnic_fcs.c
index 1885218..183dfe4 100644
--- a/drivers/scsi/fnic/fnic_fcs.c
+++ b/drivers/scsi/fnic/fnic_fcs.c
@@ -157,10 +157,10 @@ void fnic_handle_link(struct work_struct *work)
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 		if (fnic->config.flags & VFCF_FIP_CAPABLE) {
 			/* start FCoE VLAN discovery */
-				fnic_fc_trace_set_data(
-				fnic->lport->host->host_no,
-				FNIC_FC_LE, "Link Status: DOWN_UP_VLAN",
-				strlen("Link Status: DOWN_UP_VLAN"));
+			fnic_fc_trace_set_data(fnic->lport->host->host_no,
+					       FNIC_FC_LE,
+					       "Link Status: DOWN_UP_VLAN",
+					       strlen("Link Status: DOWN_UP_VLAN"));
 			fnic_fcoe_send_vlan_req(fnic);
 			return;
 		}
-- 
1.8.3.1

