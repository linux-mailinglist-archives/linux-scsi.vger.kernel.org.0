Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFCF4273A51
	for <lists+linux-scsi@lfdr.de>; Tue, 22 Sep 2020 07:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbgIVFkI (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 22 Sep 2020 01:40:08 -0400
Received: from labrats.qualcomm.com ([199.106.110.90]:30433 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbgIVFkI (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 22 Sep 2020 01:40:08 -0400
IronPort-SDR: iDm7nQrTkg5DuFhWfDQ/XsqGaAb5Wco1sNeCb3f4H2nfBZF5YSe1CkTkbV5LApO52EIunxcp6i
 vUxRA5Ge6A+pqYLvT9sr7OM5/Vx1f8xTSzZHoMNqrdUqUXvSCY3rR9dyCHH+TLlU9f8pE1BUj/
 umzjIeqRqa8IwPKbeIBVKLzxovRrmC8JH5z+706ew7FQ9w2cRvv4Vncg8wj+wbbU7EkysN5oqf
 5pgvGNYlXtdnxytC1iiVUdI3LG9nuH1dvXJCpOCc+mf6qUAmzXpDKD1BAx4bJZLQNoDlgHtJfV
 9zM=
X-IronPort-AV: E=Sophos;i="5.77,289,1596524400"; 
   d="scan'208";a="29170827"
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by labrats.qualcomm.com with ESMTP; 21 Sep 2020 22:32:29 -0700
Received: from wsp769891wss.qualcomm.com (HELO stor-presley.qualcomm.com) ([192.168.140.85])
  by ironmsg02-sd.qualcomm.com with ESMTP; 21 Sep 2020 22:32:29 -0700
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id 186A121547; Mon, 21 Sep 2020 22:32:29 -0700 (PDT)
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, rnayak@codeaurora.org,
        linux-scsi@vger.kernel.org, kernel-team@android.com,
        saravanak@google.com, salyzyn@google.com, cang@codeaurora.org
Subject: [PATCH v1 0/2] Fix some racing problems btw err_handler and paths like system PM ops and the task abort callback
Date:   Mon, 21 Sep 2020 22:32:24 -0700
Message-Id: <1600752747-31881-1-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This series mainly fixes racing problems btw err_handler and paths like
system PM ops, async scan and task abort callback. 

This series has been tested with error/fault injections to system PM
operations, async scan and task abort to the UFS device W-LU.

Can Guo (2):
  scsi: ufs: Serialize eh_work with system PM events and async scan
  scsi: ufs: Fix a racing problem between ufshcd_abort and eh_work

 drivers/scsi/ufs/ufshcd.c | 122 ++++++++++++++++++++++++++++++++--------------
 drivers/scsi/ufs/ufshcd.h |   3 ++
 2 files changed, 89 insertions(+), 36 deletions(-)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

