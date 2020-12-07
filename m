Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62382D0BC5
	for <lists+linux-scsi@lfdr.de>; Mon,  7 Dec 2020 09:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgLGIca (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 7 Dec 2020 03:32:30 -0500
Received: from mga18.intel.com ([134.134.136.126]:13251 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgLGIca (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Mon, 7 Dec 2020 03:32:30 -0500
IronPort-SDR: 8swD6XsMDxoaWwAy8PlG6lcpsvZI6ayw2crMqXvwlRIRc3/QM3qsVrCCTPjWiltJ5ypILWdqN4
 Eu/9ixfunDJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9827"; a="161432200"
X-IronPort-AV: E=Sophos;i="5.78,399,1599548400"; 
   d="scan'208";a="161432200"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 00:31:49 -0800
IronPort-SDR: abB4wQ+hJ2eoixeG+RWzuMYOZpuRP6UNpXnn7CNdXsLTJCtKhO3nCXCaLTSIbL6lJLCrYTkhnJ
 i8JB3zSrGRRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,399,1599548400"; 
   d="scan'208";a="332024900"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.94])
  by orsmga003.jf.intel.com with ESMTP; 07 Dec 2020 00:31:46 -0800
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <huobean@gmail.com>, Can Guo <cang@codeaurora.org>,
        Stanley Chu <stanley.chu@mediatek.com>
Subject: [PATCH 0/4] scsi: ufs-pci: Fixes for Intel controllers
Date:   Mon,  7 Dec 2020 10:31:16 +0200
Message-Id: <20201207083120.26732-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi

Here are some small fixes / amendments.

Adrian Hunter (4):
      scsi: ufs-pci: Fix restore from S4 for Intel controllers
      scsi: ufs-pci: Ensure UFS device is in PowerDown mode for suspend-to-disk ->poweroff()
      scsi: ufs-pci: Fix recovery from hibernate exit errors for Intel controllers
      scsi: ufs-pci: Enable UFSHCD_CAP_RPM_AUTOSUSPEND for Intel controllers

 drivers/scsi/ufs/ufshcd-pci.c | 73 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 2 deletions(-)

Regards
Adrian
