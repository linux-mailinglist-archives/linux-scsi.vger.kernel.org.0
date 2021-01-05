Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F892EA3D3
	for <lists+linux-scsi@lfdr.de>; Tue,  5 Jan 2021 04:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbhAEDQk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 4 Jan 2021 22:16:40 -0500
Received: from labrats.qualcomm.com ([199.106.110.90]:18288 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728194AbhAEDQk (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 4 Jan 2021 22:16:40 -0500
IronPort-SDR: YC+cg6Yh5O7BaIuEoljuMv+B6WY/oti26UU1iwI9l89wvbgJgVDxoO4mIzqKFbGmYcDBm+DhQc
 tQ2GGD+DfjsANsVSR1mOLYmPs1H89GqRQgct58hDNSvxGOQ0jHRuQzEKR/eEZ77pBDbCX0zEpU
 unLeYnm6X8l+fa8Hj31tUif7AqtsU8mGZ/5ZdIC+Wf7BLYVA9Ih05bCRcEF+NonFoy8GbTuZMC
 2R+bCGxGrse6Egc+909FgVFIo62r5dnbzOyNj3UND4otf5QwGuZAJmD8ho60sX/PboDhlEO1pj
 vrk=
X-IronPort-AV: E=Sophos;i="5.78,475,1599548400"; 
   d="scan'208";a="29488170"
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by labrats.qualcomm.com with ESMTP; 04 Jan 2021 19:16:00 -0800
X-QCInternal: smtphost
Received: from wsp769891wss.qualcomm.com (HELO stor-presley.qualcomm.com) ([192.168.140.85])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP; 04 Jan 2021 19:15:59 -0800
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id 5D7812184B; Mon,  4 Jan 2021 19:15:59 -0800 (PST)
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, rnayak@codeaurora.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        saravanak@google.com, salyzyn@google.com, cang@codeaurora.org
Subject: [PATCH v1 0/2] Introduce a vops to get info of command completion
Date:   Mon,  4 Jan 2021 19:15:49 -0800
Message-Id: <1609816552-16442-1-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Since we have setup_xfer_req() vops, now introduce a paired vops compl_xfer_req()
so that vendor driver can use the two to do various stuffs like tracing, debugging
, profiling and so on...

Can Guo (2):
  scsi: ufs: Introduce a vops to get info of command completion
  scsi: ufs-qcom: Add one sysfs node to monitor performance

 drivers/scsi/ufs/ufs-qcom.c | 189 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/scsi/ufs/ufs-qcom.h |  19 +++++
 drivers/scsi/ufs/ufshcd.c   |   1 +
 drivers/scsi/ufs/ufshcd.h   |  10 ++-
 4 files changed, 218 insertions(+), 1 deletion(-)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

