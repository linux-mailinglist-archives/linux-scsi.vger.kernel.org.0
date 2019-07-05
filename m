Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD525FB18
	for <lists+linux-scsi@lfdr.de>; Thu,  4 Jul 2019 17:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfGDPkk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 4 Jul 2019 11:40:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46178 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727454AbfGDPkk (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 4 Jul 2019 11:40:40 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hj3qd-0002R9-PK; Thu, 04 Jul 2019 15:40:35 +0000
From:   Colin King <colin.king@canonical.com>
To:     QLogic-Storage-Upstream@qlogic.com,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: bnx2fc: remove redundant assignment to variable rc
Date:   Thu,  4 Jul 2019 16:40:35 +0100
Message-Id: <20190704154035.15233-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable rc is being initialized with a value that is never
read and it is being updated later with a new value. The
initialization is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/bnx2fc/bnx2fc_fcoe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
index 7796799bf04a..4eb3fe9ed189 100644
--- a/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
+++ b/drivers/scsi/bnx2fc/bnx2fc_fcoe.c
@@ -1893,7 +1893,7 @@ static void bnx2fc_stop(struct bnx2fc_interface *interface)
 static int bnx2fc_fw_init(struct bnx2fc_hba *hba)
 {
 #define BNX2FC_INIT_POLL_TIME		(1000 / HZ)
-	int rc = -1;
+	int rc;
 	int i = HZ;
 
 	rc = bnx2fc_bind_adapter_devices(hba);
-- 
2.20.1

