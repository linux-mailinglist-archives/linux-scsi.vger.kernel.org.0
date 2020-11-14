Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF6F2B30BE
	for <lists+linux-scsi@lfdr.de>; Sat, 14 Nov 2020 21:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgKNUvL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 14 Nov 2020 15:51:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:35078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgKNUvL (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 14 Nov 2020 15:51:11 -0500
Subject: Re: [GIT PULL] SCSI fixes for 5.10-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605387070;
        bh=7m8xNhtGjkjWPUEfXbeoGZcvGAuC+jPU2z7/UOdN3B8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ishXo/DXUS59s1Y2lBIhxYerieYDZneQMXJOKo9sCSNitDSNWrTcNeMp/EcMCVFQE
         avx6n9kTvy7EwxeWLebKCa+rYTExp2yRgKz3EvtDrb4kghhSrkagfaxGn7GZp07l9S
         bihmx0F2O7eRMOFRaPT15zA4+F6Q9gJyLgjvUw8M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <595dbda885e4d8f0666fe49aaf52a54f2b0c8c73.camel@HansenPartnership.com>
References: <595dbda885e4d8f0666fe49aaf52a54f2b0c8c73.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <595dbda885e4d8f0666fe49aaf52a54f2b0c8c73.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 2e6f11a797a24d1e2141a214a6dd6dfbe709f55d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0c0451112b629946c93ed2102b7ae47d4d1dc0bc
Message-Id: <160538707067.24878.9576594385078780770.pr-tracker-bot@kernel.org>
Date:   Sat, 14 Nov 2020 20:51:10 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The pull request you sent on Fri, 13 Nov 2020 16:20:13 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0c0451112b629946c93ed2102b7ae47d4d1dc0bc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
