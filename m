Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A05279BD7
	for <lists+linux-scsi@lfdr.de>; Sat, 26 Sep 2020 20:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbgIZSXw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 26 Sep 2020 14:23:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730001AbgIZSXt (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 26 Sep 2020 14:23:49 -0400
Subject: Re: [GIT PULL] SCSI fixes for 5.9-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601144629;
        bh=BtFTUlpHvEKAXClVNFuA0aESnkk8fjXWXnbdyUd1E58=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JfLpwg5Yeo45uhmUIsckPkKe+c3yWJzJuKNDKABg++DxuVmGbFjTrH0ZH4IjmmJab
         izfOKfwgjQUF9EvjNmHddbV2JZh2ppq/WEBYYEJu3uYKv18mheoCjMRNA99EGy9dnC
         JcqK0tlT0K2JZEVJApz1tHXnEXB1R2eajYYQS0aE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <534da60ce3bf4c6e30071b721e9c08466e574f08.camel@HansenPartnership.com>
References: <534da60ce3bf4c6e30071b721e9c08466e574f08.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <534da60ce3bf4c6e30071b721e9c08466e574f08.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 6c5dee18756b4721ac8518c69b22ee8ac0c9c442
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1bffa48745afbb54cb4f873bba783b2ae8be042
Message-Id: <160114462919.21242.10046272585715495850.pr-tracker-bot@kernel.org>
Date:   Sat, 26 Sep 2020 18:23:49 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The pull request you sent on Sat, 26 Sep 2020 09:04:58 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1bffa48745afbb54cb4f873bba783b2ae8be042

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
