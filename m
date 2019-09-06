Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6116ABDF6
	for <lists+linux-scsi@lfdr.de>; Fri,  6 Sep 2019 18:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391095AbfIFQpn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 6 Sep 2019 12:45:43 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53137 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbfIFQpn (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 6 Sep 2019 12:45:43 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1i6HMQ-00012b-Cv; Fri, 06 Sep 2019 16:45:22 +0000
From:   Colin King <colin.king@canonical.com>
To:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: ips: make array 'options' static const, makes object smaller
Date:   Fri,  6 Sep 2019 17:45:22 +0100
Message-Id: <20190906164522.5644-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the array 'options' on the stack but instead make it
static const. Makes the object code smaller by 143 bytes.

Before:
   text	   data	    bss	    dec	    hex	filename
  94483	  11272	   1184	 106939	  1a1bb	drivers/scsi/ips.o

After:
   text	   data	    bss	    dec	    hex	filename
  94244	  11368	   1184	 106796	  1a12c	drivers/scsi/ips.o

(gcc version 9.2.1, amd64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/ips.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ips.c b/drivers/scsi/ips.c
index e8bc8d328bab..f25672982c5f 100644
--- a/drivers/scsi/ips.c
+++ b/drivers/scsi/ips.c
@@ -498,7 +498,7 @@ ips_setup(char *ips_str)
 	int i;
 	char *key;
 	char *value;
-	IPS_OPTION options[] = {
+	static const IPS_OPTION options[] = {
 		{"noi2o", &ips_force_i2o, 0},
 		{"nommap", &ips_force_memio, 0},
 		{"ioctlsize", &ips_ioctlsize, IPS_IOCTL_SIZE},
-- 
2.20.1

