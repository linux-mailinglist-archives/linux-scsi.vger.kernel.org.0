Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1613A241BA2
	for <lists+linux-scsi@lfdr.de>; Tue, 11 Aug 2020 15:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgHKNkH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 11 Aug 2020 09:40:07 -0400
Received: from mga06.intel.com ([134.134.136.31]:31275 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728672AbgHKNkG (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 11 Aug 2020 09:40:06 -0400
IronPort-SDR: zdKtDCR1xJwaILTZxya/RKb5v0G3x9guXvDyVk4EEtdLDcKafpv7FGnGhtoUlWY9kBDYvTnEyY
 KYG6irJjNHPw==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="215248822"
X-IronPort-AV: E=Sophos;i="5.75,461,1589266800"; 
   d="scan'208";a="215248822"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 06:40:06 -0700
IronPort-SDR: iCeibHRehNfaIjhB8D+vlQQyJdqQ049xecga7ERReYHFKNXY2v9kXLjdj8rv8C4Wg7R8KGa+xD
 vwk4x0Wge9UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,461,1589266800"; 
   d="scan'208";a="334576492"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by orsmga007.jf.intel.com with ESMTP; 11 Aug 2020 06:40:03 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Can Guo <cang@codeaurora.org>
Subject: [PATCH V2 1/2] scsi: ufs: Fix interrupt error message for shared interrupts
Date:   Tue, 11 Aug 2020 16:39:35 +0300
Message-Id: <20200811133936.19171-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The interrupt might be shared, in which case it is not an error for the
interrupt handler to be called when the interrupt status is zero, so
don't print the message unless there was enabled interrupt status.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: 9333d77573485 ("scsi: ufs: Fix irq return code")
---
 drivers/scsi/ufs/ufshcd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index cdcf56679b41..bb2543010af9 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -5994,7 +5994,7 @@ static irqreturn_t ufshcd_intr(int irq, void *__hba)
 		intr_status = ufshcd_readl(hba, REG_INTERRUPT_STATUS);
 	} while (intr_status && --retries);
 
-	if (retval == IRQ_NONE) {
+	if (enabled_intr_status && retval == IRQ_NONE) {
 		dev_err(hba->dev, "%s: Unhandled interrupt 0x%08x\n",
 					__func__, intr_status);
 		ufshcd_dump_regs(hba, 0, UFSHCI_REG_SPACE_SIZE, "host_regs: ");
-- 
2.17.1

