Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333D7240708
	for <lists+linux-scsi@lfdr.de>; Mon, 10 Aug 2020 15:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgHJN4W (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 10 Aug 2020 09:56:22 -0400
Received: from mga07.intel.com ([134.134.136.100]:57142 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726584AbgHJN4U (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 10 Aug 2020 09:56:20 -0400
IronPort-SDR: WaNxmwxiwkySdttbO8SGW/kGdtEbQoe1uZDZD9H+v/db/8qrJ+FTURgUMUPMVwWBxsjIvkQF7f
 LtOTOlVaMnbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9708"; a="217872764"
X-IronPort-AV: E=Sophos;i="5.75,457,1589266800"; 
   d="scan'208";a="217872764"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 06:56:19 -0700
IronPort-SDR: 0t9M9lMXOzK3HPE+tIyyb47C/vDYHkaxh4iEG9ZHgOOKa+dI1zioTnfx8C3pc7Lm9uXZy5/6no
 hUzT16+SboCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,457,1589266800"; 
   d="scan'208";a="469052860"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.73])
  by orsmga005.jf.intel.com with ESMTP; 10 Aug 2020 06:56:17 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Can Guo <cang@codeaurora.org>
Subject: [PATCH 2/2] scsi: ufs: Improve interrupt handling for shared interrupts
Date:   Mon, 10 Aug 2020 16:55:48 +0300
Message-Id: <20200810135548.28213-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200810135548.28213-1-adrian.hunter@intel.com>
References: <20200810135548.28213-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

For shared interrupts, the interrupt status might be zero, so check that
first.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/scsi/ufs/ufshcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index d7522dba4dcf..fd006340f37a 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -5983,7 +5983,7 @@ static irqreturn_t ufshcd_intr(int irq, void *__hba)
 	 * read, make sure we handle them by checking the interrupt status
 	 * again in a loop until we process all of the reqs before returning.
 	 */
-	do {
+	while (intr_status && retries--) {
 		enabled_intr_status =
 			intr_status & ufshcd_readl(hba, REG_INTERRUPT_ENABLE);
 		if (intr_status)
@@ -5992,7 +5992,7 @@ static irqreturn_t ufshcd_intr(int irq, void *__hba)
 			retval |= ufshcd_sl_intr(hba, enabled_intr_status);
 
 		intr_status = ufshcd_readl(hba, REG_INTERRUPT_STATUS);
-	} while (intr_status && --retries);
+	}
 
 	spin_unlock(hba->host->host_lock);
 	return retval;
-- 
2.17.1

