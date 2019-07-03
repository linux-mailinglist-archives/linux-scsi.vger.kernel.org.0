Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF255CC82
	for <lists+linux-scsi@lfdr.de>; Tue,  2 Jul 2019 11:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfGBJSj (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 2 Jul 2019 05:18:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46472 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfGBJSj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 2 Jul 2019 05:18:39 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hiEvr-0003N0-Um; Tue, 02 Jul 2019 09:18:36 +0000
From:   Colin King <colin.king@canonical.com>
To:     Hannes Reinecke <hare@suse.de>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: libfc: fix null pointer dereference on a null lport
Date:   Tue,  2 Jul 2019 10:18:35 +0100
Message-Id: <20190702091835.13629-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently if lport is null then the null lport pointer is dereference
when printing out debug via the FC_LPORT_DB macro. Fix this by using
the more generic FC_LIBFC_DBG debug macro instead that does not use
lport.

Addresses-Coverity: ("Dereference after null check")
Fixes: 7414705ea4ae ("libfc: Add runtime debugging with debug_logging module parameter")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/libfc/fc_exch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/libfc/fc_exch.c b/drivers/scsi/libfc/fc_exch.c
index 025cd2ff9f65..c477fadbf504 100644
--- a/drivers/scsi/libfc/fc_exch.c
+++ b/drivers/scsi/libfc/fc_exch.c
@@ -2591,8 +2591,8 @@ void fc_exch_recv(struct fc_lport *lport, struct fc_frame *fp)
 
 	/* lport lock ? */
 	if (!lport || lport->state == LPORT_ST_DISABLED) {
-		FC_LPORT_DBG(lport, "Receiving frames for an lport that "
-			     "has not been initialized correctly\n");
+		FC_LIBFC_DBG("Receiving frames for an lport that "
+			     "has not been initialized correctly\n");
 		fc_frame_free(fp);
 		return;
 	}
-- 
2.20.1

