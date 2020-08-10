Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79714240706
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Aug 2020 15:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgHJN4S (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 10 Aug 2020 09:56:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:57142 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbgHJN4R (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 10 Aug 2020 09:56:17 -0400
IronPort-SDR: XvilRj2iXmnNwIUST0GTon9Kl1/icsf3a2vLMdwiJY6PqJZpERprDsccyhXiJnfVf2E6jjU1uK
 CDRDzQ3JMS6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9708"; a="217872756"
X-IronPort-AV: E=Sophos;i="5.75,457,1589266800"; 
   d="scan'208";a="217872756"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 06:56:17 -0700
IronPort-SDR: 1ehKgvCEhhWCVQg3p77Ejt+HJGi+3UlrMZjk/x1oa1PrZDOAiCiSTuW8hU3roy/hanBsgE81UW
 ZPAVfhzGMVZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,457,1589266800"; 
   d="scan'208";a="469052846"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by orsmga005.jf.intel.com with ESMTP; 10 Aug 2020 06:56:14 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Can Guo <cang@codeaurora.org>
Subject: [PATCH 1/2] scsi: ufs: Fix interrupt error message for shared interrupts
Date:   Mon, 10 Aug 2020 16:55:47 +0300
Message-Id: <20200810135548.28213-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The interrupt might be shared, in which case it is not an error for the
interrupt handler to be called when the interrupt status is zero, so
remove the message print and register dump.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Fixes: 9333d77573485 ("scsi: ufs: Fix irq return code")
---
 drivers/scsi/ufs/ufshcd.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index cdcf56679b41..d7522dba4dcf 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -5994,12 +5994,6 @@ static irqreturn_t ufshcd_intr(int irq, void *__hba)
 		intr_status = ufshcd_readl(hba, REG_INTERRUPT_STATUS);
 	} while (intr_status && --retries);
 
-	if (retval == IRQ_NONE) {
-		dev_err(hba->dev, "%s: Unhandled interrupt 0x%08x\n",
-					__func__, intr_status);
-		ufshcd_dump_regs(hba, 0, UFSHCI_REG_SPACE_SIZE, "host_regs: ");
-	}
-
 	spin_unlock(hba->host->host_lock);
 	return retval;
 }
-- 
2.17.1

