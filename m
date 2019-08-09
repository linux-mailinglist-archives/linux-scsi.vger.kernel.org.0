Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A066C881DA
	for <lists+linux-scsi@lfdr.de>; Fri,  9 Aug 2019 19:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437183AbfHIR7j (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 9 Aug 2019 13:59:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39987 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436920AbfHIR7j (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 9 Aug 2019 13:59:39 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hw9Aq-0002U0-C0; Fri, 09 Aug 2019 17:59:32 +0000
From:   Colin King <colin.king@canonical.com>
To:     Matthew Wilcox <willy@infradead.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: sym53c8xx_2: remove redundant assignment to retv
Date:   Fri,  9 Aug 2019 18:59:32 +0100
Message-Id: <20190809175932.10197-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable retv is initialized to a value that is never read and it
is re-assigned later. The initialization is redundant and can be
removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/sym53c8xx_2/sym_nvram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/sym53c8xx_2/sym_nvram.c b/drivers/scsi/sym53c8xx_2/sym_nvram.c
index dd3f07b31612..9dc17f1288f9 100644
--- a/drivers/scsi/sym53c8xx_2/sym_nvram.c
+++ b/drivers/scsi/sym53c8xx_2/sym_nvram.c
@@ -648,7 +648,7 @@ static int sym_read_T93C46_nvram(struct sym_device *np, Tekram_nvram *nvram)
 {
 	u_char gpcntl, gpreg;
 	u_char old_gpcntl, old_gpreg;
-	int retv = 1;
+	int retv;
 
 	/* save current state of GPCNTL and GPREG */
 	old_gpreg	= INB(np, nc_gpreg);
-- 
2.20.1

