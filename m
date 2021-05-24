Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3DF38E263
	for <lists+linux-scsi@lfdr.de>; Mon, 24 May 2021 10:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbhEXIi3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 May 2021 04:38:29 -0400
Received: from labrats.qualcomm.com ([199.106.110.90]:8039 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbhEXIi3 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 24 May 2021 04:38:29 -0400
IronPort-SDR: mzEmM0+0rwgj8Qb0ksSEl4KboA4x9pgJsPdu+EvDkOT73TPyCSGpUH92jZ00L85Aq+oDA6x8My
 NGMwykTkfVFVjhQN6O3n0v8HTA01huWSsMJYqcQ9yEehnvFFNrSF+MO51CC3ktzptrt1om77pc
 LjXJrvw1KPLMfZFv1HGWBh720F9K5h5WGsPVsf/282XIbRzUXSNZbmXrBtgKtXoyyBOQ9XsnkZ
 VaVbPa7rnPJ7mDmzq1wloubN6I04+uvhcqB2PsdPCloFLWAjrPuxVCMSn6vqDqZnPlQakLFmfq
 ugo=
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="47877514"
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by labrats.qualcomm.com with ESMTP; 24 May 2021 01:37:01 -0700
X-QCInternal: smtphost
Received: from wsp769891wss.qualcomm.com (HELO stor-presley.qualcomm.com) ([192.168.140.85])
  by ironmsg02-sd.qualcomm.com with ESMTP; 24 May 2021 01:37:00 -0700
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id D343721AD7; Mon, 24 May 2021 01:37:00 -0700 (PDT)
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, cang@codeaurora.org
Subject: [PATCH v1 0/3] Optimize host lock on TR send/compl paths and utilize UTRLCNR
Date:   Mon, 24 May 2021 01:36:55 -0700
Message-Id: <1621845419-14194-1-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

By optimizing host lock usage on TR send/compl paths and utilizing UTRLCNR,
we can get considerable gain in both random read and random write performance.

Can Guo (3):
  scsi: ufs: Remove a redundant command completion logic in error
    handler
  scsi: ufs: Optimize host lock on transfer requests send/compl paths
  scsi: ufs: Utilize Transfer Request List Completion Notification
    Register

 drivers/scsi/ufs/ufshcd.c | 309 +++++++++++++++++++++++-----------------------
 drivers/scsi/ufs/ufshcd.h |   7 +-
 drivers/scsi/ufs/ufshci.h |   1 +
 3 files changed, 162 insertions(+), 155 deletions(-)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

