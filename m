Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF45D34F81A
	for <lists+linux-scsi@lfdr.de>; Wed, 31 Mar 2021 06:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbhCaEuq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 31 Mar 2021 00:50:46 -0400
Received: from labrats.qualcomm.com ([199.106.110.90]:31529 "EHLO
        labrats.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhCaEug (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 31 Mar 2021 00:50:36 -0400
IronPort-SDR: HEPC+vDl19ia/rGrCbOK7+ncDG7VIL3+6pHsjyhKcqjYqyMz0xpC5vnrzJ1o9no738xQ2RAal6
 awg85wDHQNTzAczojCQlLl/n0U2IPO7T1jlMdPZjo8HLjRDj5tkPxJBjNsNtiMNz53JpBN5MH2
 UrIxxVqUjjArlAoL5TwNOWNkAGhNgaFAD/WaKnMD9jBEBiqQ43I7fAdEHhimajs90xgcNjGZi7
 bN0GdSawZrMdEZcOOCeHz9TybKERPru3zN1b+XLWl1INQEbZCy18tsxafeOnZAE24w9zczENDk
 Ux4=
X-IronPort-AV: E=Sophos;i="5.81,291,1610438400"; 
   d="scan'208";a="47836049"
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by labrats.qualcomm.com with ESMTP; 30 Mar 2021 21:50:37 -0700
X-QCInternal: smtphost
Received: from stor-presley.qualcomm.com ([192.168.140.85])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP; 30 Mar 2021 21:50:36 -0700
Received: by stor-presley.qualcomm.com (Postfix, from userid 359480)
        id 6540B21093; Tue, 30 Mar 2021 21:50:36 -0700 (PDT)
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        hongwus@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, cang@codeaurora.org
Subject: [PATCH v4 0/2] Two fixes for task management request implementation
Date:   Tue, 30 Mar 2021 21:50:33 -0700
Message-Id: <1617166236-39908-1-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

These fixes are based on Jaegeuk's change - https://git.kernel.org/mkp/scsi/c/eeb1b55b6e25

Change since v3:
- Deleted the 2nd change
- Incorporated Bart's comments

Change since v2:
- Split one change into 3 changes

Change since v1:
- Typo fixed

Can Guo (2):
  scsi: ufs: Fix task management request completion timeout
  scsi: ufs: Fix wrong Task Tag used in task management request UPIUs

 drivers/scsi/ufs/ufshcd.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

