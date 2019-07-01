Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9DB3953B
	for <lists+linux-scsi@lfdr.de>; Fri,  7 Jun 2019 21:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbfFGTDp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 7 Jun 2019 15:03:45 -0400
Received: from gateway30.websitewelcome.com ([192.185.194.16]:18088 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729841AbfFGTDo (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 7 Jun 2019 15:03:44 -0400
X-Greylist: delayed 1367 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Jun 2019 15:03:44 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 6E4D6427A
        for <linux-scsi@vger.kernel.org>; Fri,  7 Jun 2019 13:40:56 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id ZJnMhaiMP90onZJnMhc2GP; Fri, 07 Jun 2019 13:40:56 -0500
X-Authority-Reason: nr=8
Received: from [189.250.134.24] (port=46982 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hZJnL-002Ree-1F; Fri, 07 Jun 2019 13:40:55 -0500
Date:   Fri, 7 Jun 2019 13:40:53 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] scsi: megaraid_sas: Use struct_size() helper
Message-ID: <20190607184053.GA11513@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.134.24
X-Source-L: No
X-Exim-ID: 1hZJnL-002Ree-1F
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.134.24]:46982
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct MR_PD_CFG_SEQ_NUM_SYNC {
	...
        struct MR_PD_CFG_SEQ seq[1];
} __packed;

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

So, replace the following form:

sizeof(struct MR_PD_CFG_SEQ_NUM_SYNC) + (sizeof(struct MR_PD_CFG_SEQ) * (MAX_PHYSICAL_DEVICES - 1))

with:

struct_size(pd_sync, seq, MAX_PHYSICAL_DEVICES - 1)

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index a25b6b4b6548..56bd524dddbf 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -1191,7 +1191,7 @@ megasas_ioc_init_fusion(struct megasas_instance *instance)
 int
 megasas_sync_pd_seq_num(struct megasas_instance *instance, bool pend) {
 	int ret = 0;
-	u32 pd_seq_map_sz;
+	size_t pd_seq_map_sz;
 	struct megasas_cmd *cmd;
 	struct megasas_dcmd_frame *dcmd;
 	struct fusion_context *fusion = instance->ctrl_context;
@@ -1200,9 +1200,7 @@ megasas_sync_pd_seq_num(struct megasas_instance *instance, bool pend) {
 
 	pd_sync = (void *)fusion->pd_seq_sync[(instance->pd_seq_map_id & 1)];
 	pd_seq_h = fusion->pd_seq_phys[(instance->pd_seq_map_id & 1)];
-	pd_seq_map_sz = sizeof(struct MR_PD_CFG_SEQ_NUM_SYNC) +
-			(sizeof(struct MR_PD_CFG_SEQ) *
-			(MAX_PHYSICAL_DEVICES - 1));
+	pd_seq_map_sz = struct_size(pd_sync, seq, MAX_PHYSICAL_DEVICES - 1);
 
 	cmd = megasas_get_cmd(instance);
 	if (!cmd) {
-- 
2.21.0

