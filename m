Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A4631AE85
	for <lists+linux-scsi@lfdr.de>; Sun, 14 Feb 2021 00:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhBMXeV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 13 Feb 2021 18:34:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:58090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229690AbhBMXeU (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 13 Feb 2021 18:34:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 092B464E3B;
        Sat, 13 Feb 2021 23:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613259220;
        bh=XJjISp+RdUZke5A7nTfkSyCS6Z3yuYZsqWdNYMnLFAI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=agUTfKZTwc1zzKw8EyygJIpQrZOgpkhJ1n1hIEslqBw1BmbaQZkbKg82qvXL77l33
         ig+xZ4sPcn/Op9zk8cVCsAZ9CNDoal7rl5j1RoUFjXlPPuFO4MH3RHrBqNC4WHcD73
         QmHjJ5nJ1yQBVSIznnZjoiltqDQy5yyyFk7OSxMM9cWRRGgiAJQdDOxDhgE2sYcATL
         s3KTIKIOvfyh/Z59bo7yXAUjaWTUK+3SQ5p72n68TIf+EOw0zpDzpcDMMq3Edo9SDv
         QLYMABHnvBfWPTKtGkbQSAjNEjXoh2b1KGcOBJJjK7pSFdd8+ps7kDQFi9sdSuiMW2
         kfjUzAkdDixpg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id F169A60A2F;
        Sat, 13 Feb 2021 23:33:39 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 5.11-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <df6ab78e106c6b792322fddbd75db0f3e2da69e3.camel@HansenPartnership.com>
References: <df6ab78e106c6b792322fddbd75db0f3e2da69e3.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <df6ab78e106c6b792322fddbd75db0f3e2da69e3.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: f852c596f2ee6f0eb364ea8f28f89da6da0ae7b5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0001ec9b1418f01a6dd44a83a1caa4b4f3d11f29
Message-Id: <161325921992.6166.6855049371428951098.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Feb 2021 23:33:39 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The pull request you sent on Sat, 13 Feb 2021 13:07:30 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0001ec9b1418f01a6dd44a83a1caa4b4f3d11f29

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
