Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 957B01C9C72
	for <lists+linux-scsi@lfdr.de>; Thu,  7 May 2020 22:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgEGUdQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 7 May 2020 16:33:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41576 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbgEGUdP (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 7 May 2020 16:33:15 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jWnAl-00078f-F3; Thu, 07 May 2020 20:31:11 +0000
From:   Colin King <colin.king@canonical.com>
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: lpfc: remove redundant initialization to variable rc
Date:   Thu,  7 May 2020 21:31:11 +0100
Message-Id: <20200507203111.64709-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable rc is being initialized with a value that is never read
and it is being updated later with a new value.  The initialization is
redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/scsi/lpfc/lpfc_attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index 1354c141d614..87ac8ac0f72a 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -4877,7 +4877,7 @@ lpfc_request_firmware_upgrade_store(struct device *dev,
 	struct Scsi_Host *shost = class_to_shost(dev);
 	struct lpfc_vport *vport = (struct lpfc_vport *)shost->hostdata;
 	struct lpfc_hba *phba = vport->phba;
-	int val = 0, rc = -EINVAL;
+	int val = 0, rc;
 
 	/* Sanity check on user data */
 	if (!isdigit(buf[0]))
-- 
2.25.1

