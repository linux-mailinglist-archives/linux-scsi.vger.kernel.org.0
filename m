Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE013E5A73
	for <lists+linux-scsi@lfdr.de>; Tue, 10 Aug 2021 14:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240979AbhHJMwr (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 10 Aug 2021 08:52:47 -0400
Received: from smtpbg128.qq.com ([106.55.201.39]:17151 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240972AbhHJMwn (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 10 Aug 2021 08:52:43 -0400
X-QQ-mid: bizesmtp51t1628599930trr9uv5n
Received: from localhost.localdomain (unknown [171.223.97.227])
        by esmtp6.qq.com (ESMTP) with 
        id ; Tue, 10 Aug 2021 20:52:09 +0800 (CST)
X-QQ-SSF: 01000000004000B0C000B00A0000000
X-QQ-FEAT: E35I0CyQR8NTDqra8cpQsKIoPvZEwJuujZ6PEF4l2z0rujXRbY7o2Mc+8bUvy
        mGRklwR0UZP0+leIWv5LuVQzUap1vMMRIECXW9/YXDM0Fhng3UVMEvlkRWbtqLzHZemqDnd
        q5btwZUgq64GmG/v/9QAdHvx5/QHndrsfFtlrArUzALLUhXHtDx3eqWr/TX60mHj6+sgefV
        DjjeHlzmQqc9F6SeqxeOq4o0ZB8nDTXUsagskV+v4fFUg6bXSdMAHinl3isZinzKmhE4wlX
        X018yZ7wzdgUhYYmXa3ZkQN4ah2VYMUL4xCfQxNVV/3+fTLRP94cYJkE48t71BfXhx8vz22
        hhoop7odWEGxyvkCML4nMXqXhuYtw==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     martin.petersen@oracle.com
Cc:     jejb@linux.ibm.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] scsi: pmcraid: Remove unneeded semicolon
Date:   Tue, 10 Aug 2021 20:52:07 +0800
Message-Id: <20210810125207.84739-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam5
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The semicolon after a code block bracket is unneeded in C. Thus, we can
remove the redundant semicolon from the code safely.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/scsi/pmcraid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/pmcraid.c b/drivers/scsi/pmcraid.c
index bffd9a9349e7..887c8a1c02bd 100644
--- a/drivers/scsi/pmcraid.c
+++ b/drivers/scsi/pmcraid.c
@@ -5085,7 +5085,7 @@ static int pmcraid_init_instance(struct pci_dev *pdev, struct Scsi_Host *host,
 			mapped_pci_addr + chip_cfg->ioa_host_mask_clr;
 		pint_regs->global_interrupt_mask_reg =
 			mapped_pci_addr + chip_cfg->global_intr_mask;
-	};
+	}
 
 	pinstance->ioa_reset_attempts = 0;
 	init_waitqueue_head(&pinstance->reset_wait_q);
-- 
2.32.0

