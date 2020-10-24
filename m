Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0C3297D05
	for <lists+linux-scsi@lfdr.de>; Sat, 24 Oct 2020 17:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760441AbgJXPGv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 24 Oct 2020 11:06:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760429AbgJXPGu (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 24 Oct 2020 11:06:50 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FCC920757;
        Sat, 24 Oct 2020 15:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603552010;
        bh=IqPOti2AVhOtcpidqC0x2uSNRGu2YHFlUB4t2pvldcc=;
        h=From:To:Cc:Subject:Date:From;
        b=JDwosvsOZagUL79j3cTaUZHZeRYqy4Od2EOaXk8rLEkxChgKEtr+Nf8DiatAxMHNQ
         DERFpj0UQePz/eeXLiAM885ZG59CtL71oxo55c7teLas6e0WSlySNbVBW5t3GbvYJm
         Qd4lWWyP009F+YIrM9Rcd/kkuBLyQ/rujjyeNGtk=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     cang@codeaurora.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org
Subject: [UFS v3] UFS fixes
Date:   Sat, 24 Oct 2020 08:06:41 -0700
Message-Id: <20201024150646.1790529-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Change log from v2:
 - use active_req-- instead of __ufshcd_release to avoid UFS timeout

Change log from v1:
 - remove clkgating_enable check in __ufshcd_release
 - use __uhfshcd_release instead of active_req.


