Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DEA361D5A
	for <lists+linux-scsi@lfdr.de>; Fri, 16 Apr 2021 12:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238871AbhDPJrm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 16 Apr 2021 05:47:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:60368 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbhDPJrm (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 16 Apr 2021 05:47:42 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lXL4E-0001F6-51; Fri, 16 Apr 2021 09:47:14 +0000
From:   Colin King <colin.king@canonical.com>
To:     Adam Radford <aradford@gmail.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: 3w-9xxx: Move * operator to clean up code style warning
Date:   Fri, 16 Apr 2021 10:47:13 +0100
Message-Id: <20210416094713.2033212-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Checkpatch is warning that char* text sould be char *text to match
the coding style. Fix this.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/3w-9xxx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/3w-9xxx.h b/drivers/scsi/3w-9xxx.h
index d3f479324527..30109ae96ce5 100644
--- a/drivers/scsi/3w-9xxx.h
+++ b/drivers/scsi/3w-9xxx.h
@@ -50,7 +50,7 @@
 /* AEN string type */
 typedef struct TAG_twa_message_type {
 	unsigned int   code;
-	char*	       text;
+	char           *text;
 } twa_message_type;
 
 /* AEN strings */
-- 
2.30.2

