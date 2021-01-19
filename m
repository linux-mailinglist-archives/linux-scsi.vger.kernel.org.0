Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9535C2FC472
	for <lists+linux-scsi@lfdr.de>; Wed, 20 Jan 2021 00:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbhASXHp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 19 Jan 2021 18:07:45 -0500
Received: from mga17.intel.com ([192.55.52.151]:24148 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395362AbhASORN (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 19 Jan 2021 09:17:13 -0500
IronPort-SDR: ixBU8Yf13GVe5pq91mK1rwGw2J6AaxviXIb9RS1IW5HHGnu8d8t+NbvAglR6gIBAnu6VeE7IAy
 VsIV4wJpzwcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9868"; a="158704822"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="158704822"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 06:15:46 -0800
IronPort-SDR: kHn70fCHRz210oI0ff5AXSFSudSmV7LjJ71Y2RL6bvS1dboBfdCV4pAqCitKbcw9ObNvLjIwzN
 O+2IfuUfPskw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="347189938"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.149])
  by fmsmga007.fm.intel.com with ESMTP; 19 Jan 2021 06:15:44 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <huobean@gmail.com>, Can Guo <cang@codeaurora.org>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH 2/4] scsi: ufs: Add exception event definitions
Date:   Tue, 19 Jan 2021 16:15:40 +0200
Message-Id: <20210119141542.3808-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210119141542.3808-1-adrian.hunter@intel.com>
References: <20210119141542.3808-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

For readability and completeness, add exception event definitions.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/scsi/ufs/ufs.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/ufs/ufs.h b/drivers/scsi/ufs/ufs.h
index 09c7cc8a678d..5d4a2740a159 100644
--- a/drivers/scsi/ufs/ufs.h
+++ b/drivers/scsi/ufs/ufs.h
@@ -348,8 +348,14 @@ enum power_desc_param_offset {
 
 /* Exception event mask values */
 enum {
-	MASK_EE_STATUS		= 0xFFFF,
-	MASK_EE_URGENT_BKOPS	= (1 << 2),
+	MASK_EE_STATUS			= 0xFFFF,
+	MASK_EE_DYNCAP_EVENT		= BIT(0),
+	MASK_EE_SYSPOOL_EVENT		= BIT(1),
+	MASK_EE_URGENT_BKOPS		= BIT(2),
+	MASK_EE_TOO_HIGH_TEMP		= BIT(3),
+	MASK_EE_TOO_LOW_TEMP		= BIT(4),
+	MASK_EE_WRITEBOOSTER_EVENT	= BIT(5),
+	MASK_EE_PERFORMANCE_THROTTLING	= BIT(6),
 };
 
 /* Background operation status */
-- 
2.17.1

