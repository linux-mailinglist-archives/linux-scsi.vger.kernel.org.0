Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24093EC7A2
	for <lists+linux-scsi@lfdr.de>; Sun, 15 Aug 2021 08:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhHOGF4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 15 Aug 2021 02:05:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229740AbhHOGF4 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 15 Aug 2021 02:05:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id DDB776103D;
        Sun, 15 Aug 2021 06:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629007526;
        bh=MN+plv6+gGhPsoZVDLKKERLyfcmQBwEHpQyaKx5MkSU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=szc0DYTn2KSf0FFlKu1k6C/iRn1Hk6zDvIBLt6isqIZTCDdRbvBbtfz9mfsaVrMGx
         9DRVjudnbSIdW6tshwbd/64VBFvECIVgRL0To7ii/FLbBeb4VvQtargYInp4M1277x
         eVt55GlS7cWa5+qMyHc40ud5p66FEgH+9splcCvVEc50+byrdFhCwNshjbMH3lGBOw
         U0VAhyqD6IRAMgodzhAiHStw+IyEqfPNQDNChp0Cn1L5BGtIBw1My8x6aYlH5vgpVm
         Cl0znfTo2nDXeDMZsU7lIMzJ9RsOaQ0A+XzGgzBJvGDu15AP4EphVNcEFH4aCN1vte
         rpEyorNXJww+A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id D461D60BC9;
        Sun, 15 Aug 2021 06:05:26 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 5.14-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <9672767623d4ca908c9405c0e7242b6e3131df7d.camel@HansenPartnership.com>
References: <9672767623d4ca908c9405c0e7242b6e3131df7d.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <9672767623d4ca908c9405c0e7242b6e3131df7d.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 40d32727931cee82cdc5aaca25ce725d1f3ac864
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0aa78d17099b04fd9d36fe338af48ad6fe2d7fca
Message-Id: <162900752686.24719.13046607633911361998.pr-tracker-bot@kernel.org>
Date:   Sun, 15 Aug 2021 06:05:26 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The pull request you sent on Sat, 14 Aug 2021 23:12:55 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0aa78d17099b04fd9d36fe338af48ad6fe2d7fca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
