Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3683050A5
	for <lists+linux-scsi@lfdr.de>; Wed, 27 Jan 2021 05:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343657AbhA0EVh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 26 Jan 2021 23:21:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:45046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728325AbhAZVOK (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 26 Jan 2021 16:14:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D91BF221EF;
        Tue, 26 Jan 2021 21:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611695572;
        bh=dCL2AuuUtM5dPRsG6o+bpmbCzvVA4DZcIH0XNZ24YV4=;
        h=From:To:Cc:Subject:Date:From;
        b=eLFJiOW1a0PI35bnD7RigcQwKmXffd8RVbZ7WO3is5wSdFYCDhgrwRj7rmUP9mF0u
         pOMIV1QM2i7CP6Pc6xK0IR3xKE/9JroLQfeYV3QKE5MnYghLjI0Z0W0HzYQs5LXw3R
         Ur7gVb9oRNCCX5e2/PbQn9JIj1cq/NUw9Y9pN5XdCCmBlzgPCfxsn7DODVWmLV8aal
         km0R+bjqdY1lUf3fFRzqTqLokE4Z0EjvSD3rCPACJUZ/j93ylVuA7st4W1DRFqgMsx
         cQHosxzZUAcX1KzoEkbt4wuGJhSJnyOaid7/ikH+Lnfa1FRH07RM+tySBMEuAaYnM+
         YSN68jPrJjjRQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] scsi: lpfc: Fix 'physical' typos
Date:   Tue, 26 Jan 2021 15:12:48 -0600
Message-Id: <20210126211248.2920028-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Fix misspellings of "physical".

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/scsi/lpfc/lpfc_els.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 96c087b8b474..78af645f6c5f 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -732,7 +732,7 @@ lpfc_cmpl_els_flogi_fabric(struct lpfc_vport *vport, struct lpfc_nodelist *ndlp,
 			spin_unlock_irq(&phba->hbalock);
 		} else {
 			/* Because we asked f/w for NPIV it still expects us
-			to call reg_vnpid atleast for the physcial host */
+			to call reg_vnpid at least for the physical host */
 			lpfc_printf_vlog(vport, KERN_WARNING,
 					 LOG_ELS | LOG_VPORT,
 					 "1817 Fabric does not support NPIV "
-- 
2.25.1

