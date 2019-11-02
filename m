Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEF3ECCC5
	for <lists+linux-scsi@lfdr.de>; Sat,  2 Nov 2019 02:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfKBBUl (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 1 Nov 2019 21:20:41 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:33230 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbfKBBUl (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 1 Nov 2019 21:20:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D4A7A6158A; Sat,  2 Nov 2019 01:20:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cang@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DA85561491;
        Sat,  2 Nov 2019 01:20:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DA85561491
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=pass (p=none dis=none) header.from=qti.qualcomm.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=pass smtp.mailfrom=cang@qti.qualcomm.com
From:   Can Guo <cang@qti.qualcomm.com>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        rnayak@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com,
        cang@codeaurora.org
Subject: [PATCH v3 0/5] UFS driver general fixes bundle 1
Date:   Fri,  1 Nov 2019 18:20:25 -0700
Message-Id: <1572657631-25749-1-git-send-email-cang@qti.qualcomm.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

From: Can Guo <cang@codeaurora.org>

This bundle includes 5 general fixes for UFS driver.

Changes since v2:
- Incorporated review comments from Mark Salyzyn

Changes since v1:
- Incorporated review comments from Bart Van Assche.

Can Guo (5):
  scsi: Adjust DBD setting in mode sense for caching mode page per LLD
  scsi: ufs: Set DBD setting in mode sense for caching mode page
  scsi: ufs: Release clock if DMA map fails
  scsi: ufs: Do not clear the DL layer timers
  scsi: ufs: Do not free irq in suspend

 drivers/scsi/sd.c         |  2 +-
 drivers/scsi/ufs/ufshcd.c | 40 ++++++++++++++++++++++++++--------------
 drivers/scsi/ufs/unipro.h | 11 +++++++++++
 include/scsi/scsi_host.h  |  6 ++++++
 4 files changed, 44 insertions(+), 15 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

