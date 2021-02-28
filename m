Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A997332745D
	for <lists+linux-scsi@lfdr.de>; Sun, 28 Feb 2021 21:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbhB1UO5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 28 Feb 2021 15:14:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:56770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231267AbhB1UOv (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 28 Feb 2021 15:14:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id C0CA564E56;
        Sun, 28 Feb 2021 20:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614543250;
        bh=bwpYvoUG/R82rdcLyck3wdoPaIEwaWZYM2zpDbKq7v4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uHWJWODvIczAezm8DZ7l5xuVealg5rJbFI13cabPGfJP1+V1bdFeOzQ7L68apKPuy
         J9rDkF0sEWIBWzK55MovQgRM/Yt5jfGFrgyD6g10iQmNvusYTPC3zxB1rPuUWQ1wMf
         +fFjlItY58x0kIXphRyOr0xAXFOpzAkV/OBEFxSssuSdBekV8veL3OzCkhYF9JbsXw
         AxivRTkBoCIVOlO6MVESEhrWL4EjZL35L2JfdL65DgByd8ZrzIQ2UingdEHsQ4FKPZ
         Yf2obwa2on8W/mcytsyeQ7mEBpUzxDQQ5asNY6W2TUIqgazJEwQ0vT5WB9FugCn5zv
         +cy4a0q2LH0Yg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BBA3360A2E;
        Sun, 28 Feb 2021 20:14:10 +0000 (UTC)
Subject: Re: [GIT PULL] final round of SCSI updates for the 5.11+ merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <eadc15d02e4b01ed41de5bf0a8ea2594cfa288a8.camel@HansenPartnership.com>
References: <eadc15d02e4b01ed41de5bf0a8ea2594cfa288a8.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <eadc15d02e4b01ed41de5bf0a8ea2594cfa288a8.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc
X-PR-Tracked-Commit-Id: f749d8b7a9896bc6e5ffe104cc64345037e0b152
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0b311e34d5033fdcca4c9b5f2d9165b3604704d3
Message-Id: <161454325076.2182.5109609372922700337.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Feb 2021 20:14:10 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The pull request you sent on Sun, 28 Feb 2021 08:52:19 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0b311e34d5033fdcca4c9b5f2d9165b3604704d3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
