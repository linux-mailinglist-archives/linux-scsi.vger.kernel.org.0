Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25A82ABDE0
	for <lists+linux-scsi@lfdr.de>; Fri,  6 Sep 2019 18:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391839AbfIFQju (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 6 Sep 2019 12:39:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52842 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389180AbfIFQju (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 6 Sep 2019 12:39:50 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1i6HH0-0000Yh-0p; Fri, 06 Sep 2019 16:39:46 +0000
From:   Colin King <colin.king@canonical.com>
To:     Satish Kharat <satishkh@cisco.com>,
        Sesidhar Baddela <sebaddel@cisco.com>,
        Karan Tilak Kumar <kartilak@cisco.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: fnic: make array dev_cmd_err static const, makes object smaller
Date:   Fri,  6 Sep 2019 17:39:45 +0100
Message-Id: <20190906163945.3889-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the array dev_cmd_err on the stack but instead make it
static const. Makes the object code smaller by 80 bytes.

Before:
   text	   data	    bss	    dec	    hex	filename
  21461	   1564	      0	  23025	   59f1	drivers/scsi/fnic/vnic_dev.o

After:
   text	   data	    bss	    dec	    hex	filename
  21318	   1628	      0	  22946	   59a2	drivers/scsi/fnic/vnic_dev.o

(gcc version 9.2.1, amd64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/fnic/vnic_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/fnic/vnic_dev.c b/drivers/scsi/fnic/vnic_dev.c
index 78af9cc2009b..f7f445c6b4fc 100644
--- a/drivers/scsi/fnic/vnic_dev.c
+++ b/drivers/scsi/fnic/vnic_dev.c
@@ -259,7 +259,7 @@ int vnic_dev_cmd1(struct vnic_dev *vdev, enum vnic_devcmd_cmd cmd, int wait)
 	struct vnic_devcmd __iomem *devcmd = vdev->devcmd;
 	int delay;
 	u32 status;
-	int dev_cmd_err[] = {
+	static const int dev_cmd_err[] = {
 		/* convert from fw's version of error.h to host's version */
 		0,	/* ERR_SUCCESS */
 		EINVAL,	/* ERR_EINVAL */
-- 
2.20.1

