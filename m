Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA583FEBFF
	for <lists+linux-scsi@lfdr.de>; Thu,  2 Sep 2021 12:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242697AbhIBKTA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 2 Sep 2021 06:19:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:50178 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233818AbhIBKS7 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 2 Sep 2021 06:18:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="280072777"
X-IronPort-AV: E=Sophos;i="5.84,372,1620716400"; 
   d="scan'208";a="280072777"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 03:17:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,372,1620716400"; 
   d="scan'208";a="542572507"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by fmsmga002.fm.intel.com with ESMTP; 02 Sep 2021 03:17:48 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Bean Huo <huobean@gmail.com>,
        Avri Altman <avri.altman@wdc.com>,
        Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 0/3] scsi: ufs: Let devices remain runtime suspended during system suspend
Date:   Thu,  2 Sep 2021 13:18:15 +0300
Message-Id: <20210902101818.4132-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <d5f5552d-257a-62ee-f0a3-55c00959e63b@intel.com>
References: <d5f5552d-257a-62ee-f0a3-55c00959e63b@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi

UFS devices can remain runtime suspended at system suspend time,
if the conditions are right.  Add support for that, first fixing
the impediments.


Adrian Hunter (3):
      scsi: ufs: Fix error handler clear ua deadlock
      scsi: ufs: Fix runtime PM dependencies getting broken
      scsi: ufs: Let devices remain runtime suspended during system suspend

 drivers/scsi/scsi_pm.c     | 16 +++++++---
 drivers/scsi/ufs/ufshcd.c  | 79 +++++++++++++++++++++++++++++++---------------
 drivers/scsi/ufs/ufshcd.h  | 11 ++++++-
 include/scsi/scsi_device.h |  1 +
 4 files changed, 75 insertions(+), 32 deletions(-)


Regards
Adrian
