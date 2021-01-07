Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32222ECB09
	for <lists+linux-scsi@lfdr.de>; Thu,  7 Jan 2021 08:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbhAGHry (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 7 Jan 2021 02:47:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:56616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbhAGHry (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 7 Jan 2021 02:47:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A3B9723120;
        Thu,  7 Jan 2021 07:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610005633;
        bh=Jaq4XZo719KMPzUzdpBDNzJfPIMbvkUESlswoNkAPHg=;
        h=From:To:Cc:Subject:Date:From;
        b=VmVvlpeYV96U1wJPMheR27uRA3K6fUfGu6bTscz1DKCibRuJdS5965uho3p+Emmc6
         SbGiJKvB8dwJEj2+brVJapwmkznqyovKxnumWZ8TRx0BmHRrh18ef1brmkZv8qZlas
         ng8zorPUeqMwzNZ2mHN96h5MbjE2RHrpxj13hR8ZzsE0rh8/bLRBwWwYtr+2EiT6K3
         CFZoDhb8HE4PvmnH3cQ6p50SGYneCY0Au1wYbZgyBd9sepeSwL70QB39gQ+Uh/2R+s
         9aHIumS7wZ8si51n2Cy2Hq4P4XgMWMxk0pqhJpMYJ20/q/zVJK3FRaeYlm9+uu0/Mg
         fAEwBs3/CCJtQ==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        kernel-team@android.com
Cc:     cang@codeaurora.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org, martin.petersen@oracle.com,
        stanley.chu@mediatek.com
Subject: [PATCH v4 0/2] UFS bug fixes
Date:   Wed,  6 Jan 2021 23:47:08 -0800
Message-Id: <20210107074710.549309-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Change log from v3:
 - move ufshcd_clear_ua_wluns() after ufshcd_scsi_add_wlus()
 - remove BLK_MQ_REQ_RESERVED for tm tag
 - move IO wait to cover all the non-fatal errors


