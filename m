Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D955EBC15
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Nov 2019 03:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfKACwQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 31 Oct 2019 22:52:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41266 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbfKACwQ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 31 Oct 2019 22:52:16 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 01B9160397; Fri,  1 Nov 2019 02:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572576736;
        bh=PafpH8raq2BVeOW8H1HkdavjFVFw9FdEuJrOwfZe300=;
        h=From:To:Subject:Date:From;
        b=U73fqy8lysJE0OoNOFTRPlOQ8LQBTCSDFFJZ8P/+qPeJ19cd+V1kDUPr899s0TdFR
         tTrDa5nWC60wY7zKx68p2V3Q1X6ZFIdeSlesY6uUyMqstn8CbLTFNRpjHxBTy9O/MJ
         kslN38rw8Rr8yLO+ZFez0Zr21nOGDd7pVRzF5QmU=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from pacamara-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cang@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 223D860913;
        Fri,  1 Nov 2019 02:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572576735;
        bh=PafpH8raq2BVeOW8H1HkdavjFVFw9FdEuJrOwfZe300=;
        h=From:To:Subject:Date:From;
        b=Atx0zrDhuO5hNJVx3NgZqX+CZtI8D0idWABYCYv+zYf1LVBGYBkhhQgBajvv/V+sI
         /Qa71IOCGcPXJ4UeucOnctRU45IO42cJc8nD+lhPxkMWYKgJTwc/EqUrF2YlV3DO8u
         4UZU8girmHI85udo4DB0F6rXzLN+NpFf/Uz/42a0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 223D860913
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=cang@codeaurora.org
From:   Can Guo <cang@codeaurora.org>
To:     asutoshd@codeaurora.org, nguyenb@codeaurora.org,
        rnayak@codeaurora.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com, saravanak@google.com, salyzyn@google.com,
        cang@codeaurora.org
Subject: [PATCH v2 0/2] UFS driver general fixes bundle 2
Date:   Thu, 31 Oct 2019 19:52:03 -0700
Message-Id: <1572576725-31092-1-git-send-email-cang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This bundle includes 2 general fixes for UFS driver.

Can Guo (1):
  scsi: ufs: Do not rely on prefetched data

Subhash Jadavani (1):
  scsi: ufs: Fix up clock scaling

 drivers/scsi/ufs/ufshcd.c | 104 ++++++++++++++++++++++++++++------------------
 drivers/scsi/ufs/ufshcd.h |  13 ------
 2 files changed, 64 insertions(+), 53 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

