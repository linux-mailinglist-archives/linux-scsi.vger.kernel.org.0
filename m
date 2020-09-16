Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9D926C8F7
	for <lists+linux-scsi@lfdr.de>; Wed, 16 Sep 2020 21:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgIPTBG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 16 Sep 2020 15:01:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727624AbgIPTA1 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 16 Sep 2020 15:00:27 -0400
Subject: Re: [GIT PULL] SCSI fixes for 5.9-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600282826;
        bh=8ImylTo/soYrwL1IcTLaRF2TXLAs3QRQk9PlHUZbRbI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NkN4UmDk/JqFq+KiyN8P4PcCshyAq8oLOFmzBd7lrTygpfESOq9glD633LBO4uUYj
         9F9Vx0hrnzFUVZW0FIxoDJ3+btdojFmNHRFpGsKtmLiiRrrC3MF0AIVwKzs5Oazh1D
         7g/EGavublD61Rw+bWFfhu3U+MJbDGVAs4slo3kA=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1600209754.5092.24.camel@HansenPartnership.com>
References: <1600209754.5092.24.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <1600209754.5092.24.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 244359c99fd90f1c61c3944f93250f8219435c75
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9803ab172228d8509c72b34c703b9fe67cb94ddc
Message-Id: <160028282685.10613.7235793399589231133.pr-tracker-bot@kernel.org>
Date:   Wed, 16 Sep 2020 19:00:26 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The pull request you sent on Tue, 15 Sep 2020 15:42:34 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9803ab172228d8509c72b34c703b9fe67cb94ddc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
