Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB123214E55
	for <lists+linux-scsi@lfdr.de>; Sun,  5 Jul 2020 20:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgGESAO (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 5 Jul 2020 14:00:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727888AbgGESAG (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 5 Jul 2020 14:00:06 -0400
Subject: Re: [GIT PULL] SCSI fixes for 5.8-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593972006;
        bh=pTuOZtj5mw2loSYgTSMtBjZZCuKSkNSfSyEBosIcktU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=vaSKmZlxetsERSd2JIUwCJVp2gj15RlT1DaYKFpJ8WE/0/x5u2Yx2SBLJRFS46n7E
         sKtuJtn9PK2kqx2KFf2VU0E0H2kTXe69m1vMFnC3m+446qg12AdVtBw2A+Zrov2Ojw
         Q/O3PWJ2a00RExI3qHd4xqOfsKhUtDYcrP/TifY4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1593962570.4657.5.camel@HansenPartnership.com>
References: <1593962570.4657.5.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1593962570.4657.5.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 311950f8b8d80ba41aa09a26bcaf0c2231f8d264
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 19a61a753d0705fcb41e7aa130351e0a0a54c3bd
Message-Id: <159397200622.8921.480215273537054822.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Jul 2020 18:00:06 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The pull request you sent on Sun, 05 Jul 2020 08:22:50 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/19a61a753d0705fcb41e7aa130351e0a0a54c3bd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
