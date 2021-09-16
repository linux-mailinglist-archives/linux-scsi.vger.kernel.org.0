Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BAF40E5EB
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Sep 2021 19:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244423AbhIPRQT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 16 Sep 2021 13:16:19 -0400
Received: from mga18.intel.com ([134.134.136.126]:62668 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345741AbhIPRLv (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 16 Sep 2021 13:11:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10109"; a="209703316"
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="209703316"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2021 10:01:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="583723726"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by orsmga004.jf.intel.com with ESMTP; 16 Sep 2021 10:01:48 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Bean Huo <huobean@gmail.com>,
        Avri Altman <avri.altman@wdc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Wei Li <liwei213@huawei.com>, linux-scsi@vger.kernel.org
Subject: [PATCH V4 0/3] scsi: ufs: Let devices remain runtime suspended during system suspend
Date:   Thu, 16 Sep 2021 20:02:08 +0300
Message-Id: <20210916170211.8564-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi

UFS devices can remain runtime suspended at system suspend time,
if the conditions are right.  Add support for that, first fixing
the impediments.


Changes in V4:

      scsi: ufs: Fix error handler clear ua deadlock

	Do request-sense directly

Changes in V3:

      scsi: ufs: Fix error handler clear ua deadlock

	Correct commit message.
	Amend stable tags to add dependent cherry picks

Changes in V2:

    scsi: ufs: Let devices remain runtime suspended during system suspend

	The ufs-hisi driver uses different RPM and SPM, but it is made
	explicit by a new parameter to suspend prepare.


Adrian Hunter (3):
      scsi: ufs: Fix error handler clear ua deadlock
      scsi: ufs: Fix runtime PM dependencies getting broken
      scsi: ufs: Let devices remain runtime suspended during system suspend

 drivers/scsi/scsi_pm.c      |  16 ++-
 drivers/scsi/ufs/ufs-hisi.c |   8 +-
 drivers/scsi/ufs/ufs.h      |   3 +-
 drivers/scsi/ufs/ufshcd.c   | 255 ++++++++++++++++++++++++++++++++------------
 drivers/scsi/ufs/ufshcd.h   |  21 +++-
 include/scsi/scsi_device.h  |   1 +
 include/trace/events/ufs.h  |   5 +-
 7 files changed, 231 insertions(+), 78 deletions(-)


Regards
Adrian
