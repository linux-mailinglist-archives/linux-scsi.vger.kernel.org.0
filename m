Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D4936AA8B
	for <lists+linux-scsi@lfdr.de>; Mon, 26 Apr 2021 04:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbhDZC1W (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 25 Apr 2021 22:27:22 -0400
Received: from labrats.qualcomm.com ([199.106.110.90]:8422 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhDZC1W (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 25 Apr 2021 22:27:22 -0400
IronPort-SDR: 5CRMzgAUFv4a6E2c9lhEBZyI4pw1gjQdKKe/m/tqAbKZRVdTUXSZSPl64mb5bGOREFUR0IenOX
 oJ1obtqkNurtc5uD1eKuaieJ9JBcCfiH/UpRCwH6qSOaZXJ0XdagiQGvnCJiR+gya/GkctsZ80
 x1ft8eL7KNMn7K1LK93B6prLvU2S62Fyo+VgLBCVQoZ68NVfaS/qyRS/BTm5UzZFY03qyP2MPM
 fV94G8Cjn7mJlIhJW/++BSMXrPon5GXyd9GxkzrKe4s4PmDF6+/zoiE1DpTRgjnoyAlyi8jKC0
 ODQ=
X-IronPort-AV: E=Sophos;i="5.82,251,1613462400"; 
   d="scan'208";a="29759454"
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by labrats.qualcomm.com with ESMTP; 25 Apr 2021 19:26:42 -0700
X-QCInternal: smtphost
Received: from stor-presley.qualcomm.com ([192.168.140.85])
  by ironmsg04-sd.qualcomm.com with ESMTP; 25 Apr 2021 19:26:41 -0700
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id E83D02113E; Sun, 25 Apr 2021 19:26:40 -0700 (PDT)
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, ziqichen@codeaurora.org,
        nguyenb@codeaurora.org, hongwus@codeaurora.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        cang@codeaurora.org
Subject: [PATCH v1 0/3] Three minor fixes w.r.t suspend/resume
Date:   Sun, 25 Apr 2021 19:24:34 -0700
Message-Id: <1619403878-28330-1-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

1st change can fix a possible OCP issue.
2nd and 3rd change can fix race conditions btw suspend/resume and other contexts.

Can Guo (3):
  scsi: ufs: Do not put UFS power into LPM if link is broken
  scsi: ufs: Cancel rpm_dev_flush_recheck_work during system suspend
  scsi: ufs: Narrow down fast pass in system suspend path

 drivers/scsi/ufs/ufshcd.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

