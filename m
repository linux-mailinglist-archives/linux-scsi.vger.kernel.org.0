Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0677A3ABF9E
	for <lists+linux-scsi@lfdr.de>; Fri, 18 Jun 2021 01:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhFQXkS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 17 Jun 2021 19:40:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230447AbhFQXkS (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 17 Jun 2021 19:40:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2566C61184;
        Thu, 17 Jun 2021 23:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623973089;
        bh=KiD+BfJ+qYLwA/lIAGT2/IP2dL1kIspW0vUrVZZ4zyE=;
        h=From:To:Cc:Subject:Date:From;
        b=B8l5pCGD0pgflCpjM0LQSOHGF2jPusPjl3MDXtyy3XTjEG3IAOKddf95MPxHkEO0t
         CFJCTIixeMzjx40hNYKt2oLZZx+sOFN65yO2ELfby6qpZlra056DM/dzsIKBgraz1z
         322TYvS9iUUTeNKLphmx2Qhr/Eg2O4fjDdG0uMsrL6jlxxTmJok+p8hwnvyGO46gKM
         Vh23tBoPHfAr4/pBtO1ZdAgcJf/iBUqQAin3xHAeesZEO57mhR/9SIH/rp+SJEbQsk
         zTkaZEXwq/KLnrEaFJuTGO4E4SlQLJqddPovESsHxod8V5CJGLpXwazQCrsklOsDG8
         BDBiOfyfBx6GA==
From:   Nathan Chancellor <nathan@kernel.org>
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Gaurav Srivastava <gaurav.srivastava@broadcom.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] scsi: lpfc: Reduce scope of uuid in lpfc_queuecommand()
Date:   Thu, 17 Jun 2021 16:37:59 -0700
Message-Id: <20210617233759.2355447-1-nathan@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

When CONFIG_SCSI_LPFC_DEBUG_FS is unset, uuid's declaration is not
present, resulting in a compiler error:

drivers/scsi/lpfc/lpfc_scsi.c:5595:3: error: use of undeclared
identifier 'uuid'
                uuid = lpfc_is_command_vm_io(cmnd);
                ^

uuid is only used in the if statement so reduce its scope to solve the
build error. Additionally, uuid is a char *, instead of u8 *.

Fixes: 33c79741deaf ("scsi: lpfc: vmid: Introduce VMID in I/O path")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/scsi/lpfc/lpfc_scsi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index 46bfe251c2fe..e8af51e38614 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -5457,7 +5457,6 @@ lpfc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *cmnd)
 	int err, idx;
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	uint64_t start = 0L;
-	u8 *uuid = NULL;
 
 	if (phba->ktime_on)
 		start = ktime_get_ns();
@@ -5592,7 +5591,7 @@ lpfc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *cmnd)
 	     LPFC_VMID_PRIO_TAG_ALL_TARGETS)) {
 		/* is the I/O generated by a VM, get the associated virtual */
 		/* entity id */
-		uuid = lpfc_is_command_vm_io(cmnd);
+		char *uuid = lpfc_is_command_vm_io(cmnd);
 
 		if (uuid) {
 			err = lpfc_vmid_get_appid(vport, uuid, cmnd,

base-commit: ebc076b3eddc807729bd81f7bc48e798a3ddc477
-- 
2.32.0.93.g670b81a890

