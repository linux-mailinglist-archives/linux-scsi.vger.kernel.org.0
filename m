Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7C6C3099FA
	for <lists+linux-scsi@lfdr.de>; Sun, 31 Jan 2021 03:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhAaCR7 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 30 Jan 2021 21:17:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:55462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230517AbhAaCR6 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 30 Jan 2021 21:17:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 22A8B64E17;
        Sun, 31 Jan 2021 02:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612059438;
        bh=rxuCpH8f1XXoWTY+VpJnyc63RcPBQ6Gj/LYRimICNnI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qDm1aDU3TuDp+xM9yKo/EBS9LMONizWSpuKKxrE1Jo5OuVfYDUZicslAwpo7IfsqE
         yMGBXu14+J+cck64Zz7QLaz8rKZQ56VBYXt9ONN4aCWV2R+4CXXZY04i7fM4ImkhGk
         2v2TgHEASc1fSCvMchQn2ntooYKyUFnGrV8MmU34Wh8m23YeWa4izX4/wxCfgkauDZ
         HUQoO3yINGQqA4ll+1RyAFkTV0MnJ4Iwtgw4S//lGh+gUHpe4IEiBgZ21GOs+Jlq8O
         VEjCqLNiAqUsp2fLTrYv0ri9EQyQON7Ba8ttL52sOZGhvcWFWXM2HV4F1qDmUfOqsd
         ZKxNsOYa5/OBw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 1061760984;
        Sun, 31 Jan 2021 02:17:18 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 5.11-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <563ef7e0fbd1a5ac6edf5957cc57aa4af17e4417.camel@HansenPartnership.com>
References: <563ef7e0fbd1a5ac6edf5957cc57aa4af17e4417.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <563ef7e0fbd1a5ac6edf5957cc57aa4af17e4417.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: aa2c24e7f415e9c13635cee22ff4e15a80215551
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ad8b3c1e637cf7b827d26917034fa686af74896b
Message-Id: <161205943800.4129.12804639174728798706.pr-tracker-bot@kernel.org>
Date:   Sun, 31 Jan 2021 02:17:18 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The pull request you sent on Sat, 30 Jan 2021 10:38:05 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ad8b3c1e637cf7b827d26917034fa686af74896b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
