Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DADEC3AA247
	for <lists+linux-scsi@lfdr.de>; Wed, 16 Jun 2021 19:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhFPRSc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 16 Jun 2021 13:18:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48832 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbhFPRSb (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 16 Jun 2021 13:18:31 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1ltZ9J-0007JM-HA; Wed, 16 Jun 2021 17:16:21 +0000
From:   Colin King <colin.king@canonical.com>
To:     James Smart <james.smart@broadcom.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] scsi: elx: efct: remove redundant initialization of variable lun
Date:   Wed, 16 Jun 2021 18:16:21 +0100
Message-Id: <20210616171621.16176-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable lun is being initialized with a value that is never
read, it is being updated later on. The assignment is redundant and
can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/elx/efct/efct_unsol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/elx/efct/efct_unsol.c b/drivers/scsi/elx/efct/efct_unsol.c
index a9384c9acfde..e6addab66a60 100644
--- a/drivers/scsi/elx/efct/efct_unsol.c
+++ b/drivers/scsi/elx/efct/efct_unsol.c
@@ -342,7 +342,7 @@ efct_dispatch_fcp_cmd(struct efct_node *node, struct efc_hw_sequence *seq)
 	struct fc_frame_header *fchdr = seq->header->dma.virt;
 	struct fcp_cmnd	*cmnd = NULL;
 	struct efct_io *io = NULL;
-	u32 lun = U32_MAX;
+	u32 lun;
 
 	if (!seq->payload) {
 		efc_log_err(efct, "Sequence payload is NULL.\n");
-- 
2.31.1

