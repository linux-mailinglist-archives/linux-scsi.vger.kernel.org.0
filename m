Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06EA02C6DEF
	for <lists+linux-scsi@lfdr.de>; Sat, 28 Nov 2020 01:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731567AbgK0Xac (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 27 Nov 2020 18:30:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:38654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729680AbgK0XaC (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 27 Nov 2020 18:30:02 -0500
Subject: Re: [GIT PULL] SCSI fixes for 5.10-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606519795;
        bh=MNPScZmsDoQ0QFjhBUeBawpjowMRQtBWCMi7VAqfbZo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=LZSQYvQEzFxRDPLmE3Z9FhAvfFTpOInpOT5W6Ml8eD2jKpgSwYBGH3zFYEPxwtN0k
         f7ryv85VBE/s0q5UeJJTcPNBoAGDb5H+VufRxpReE/CeUmDiud4+mdLLkHStWY2TcZ
         UzgknFSHihzHI7+TlO0WL9C7bV5CfXw/mUyG218Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4340233ae5e105c5617401f84a5ed13c341f5ecf.camel@HansenPartnership.com>
References: <4340233ae5e105c5617401f84a5ed13c341f5ecf.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <4340233ae5e105c5617401f84a5ed13c341f5ecf.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: e92643db514803c2c87d72caf5950b4c0a8faf4a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 80e1e1761d1a9eefda4d1545f8b6c0a2e46d4e3f
Message-Id: <160651979499.32137.13667838574805022439.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Nov 2020 23:29:54 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The pull request you sent on Fri, 27 Nov 2020 13:56:30 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/80e1e1761d1a9eefda4d1545f8b6c0a2e46d4e3f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
