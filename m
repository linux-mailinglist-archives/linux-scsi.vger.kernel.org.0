Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCBB2312058
	for <lists+linux-scsi@lfdr.de>; Sat,  6 Feb 2021 23:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhBFWqs (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 6 Feb 2021 17:46:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:47640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhBFWqr (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 6 Feb 2021 17:46:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 2064064E87;
        Sat,  6 Feb 2021 22:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612651567;
        bh=5j+LbVjGFw1oXzojch2FWai3yyYwLi04bWMHaNY6g48=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Cl8in0jPwgrhPLY8w79Jw5L650D4ava2fbXnvXpgzf595XSRRZaYZWvmrxHKPium9
         HfVGcnQ76N8aGisf3vZOwtfU5u2as5iXHoCCwyCQInbAAmeJD93zDakPPny3PLaSBR
         rxIf2j1FRVMg0tWdVVZ4YrApuOP5Fk7IfjZ7e35WFxhz9BID/pbXYHSpew0ZgA6/5L
         /hxa1MyfKzwuJHlSpWgWXpXiFbM8EhsHQpJ1yNCFI/jdM8nY84rvQwtVcEQhsCqZxN
         n1V43lNMcGMoBqzTFLGLxVfWg0lJdbbWS3Rj1n4yBGgsV2oIDPNV4d5+nbpVBrh+M0
         1gXFqEEWrlwYA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1B58060978;
        Sat,  6 Feb 2021 22:46:07 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 5.11-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4694bcc43696d52e6a81c915c2215bc8022918fc.camel@HansenPartnership.com>
References: <4694bcc43696d52e6a81c915c2215bc8022918fc.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <4694bcc43696d52e6a81c915c2215bc8022918fc.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 8c65830ae1629b03e5d65e9aafae7e2cf5f8b743
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 964d069f93c4468b220f7e15fac7a3f7bd6d13ec
Message-Id: <161265156710.9050.8382905942205973356.pr-tracker-bot@kernel.org>
Date:   Sat, 06 Feb 2021 22:46:07 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The pull request you sent on Sat, 06 Feb 2021 09:40:32 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/964d069f93c4468b220f7e15fac7a3f7bd6d13ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
