Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10312CFE4C
	for <lists+linux-scsi@lfdr.de>; Sat,  5 Dec 2020 20:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgLETWe (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 5 Dec 2020 14:22:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:50848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbgLETWP (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 5 Dec 2020 14:22:15 -0500
Subject: Re: [GIT PULL] SCSI fixes for 5.10-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607196095;
        bh=BZq3IxDKpmbn2jySF9xqrVNMvGyLS/bo+Ze2k+bkKLY=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Jfuq/OaTxNoVq0/SLvIgYIBDm+swLLV4PX6nD5jwK4XGi5hvW6a1A7hBc95fyaKjc
         LyUoHeOnrNoiBXSrP4NHXGas4Q7FmoUjmB0IqqPrzmtdKbBJ7eX3LYRpjUarDjxV0Z
         zUK01y+rsOeVdwwkaeu1CUQ/2AXhWX9blMlm5BXJOWZSVly26CA2Tlmsp4uFW9GrrE
         ld9GKPkzfhtZM7DY4GDtq0qa71SeWrbOo3QSwOnCaUlc7g4snagRA483j+wItlaiSd
         4FrSwY+p0cFxSpV5jeo6yBoYag+O4JIUPBwjHzaAR1bdZJAVSvDm+Ojt/LGD7kBvEN
         MfrUsgANWR/YQ==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <6241da59ba45eeb525203201095d1f5ee76fbceb.camel@HansenPartnership.com>
References: <6241da59ba45eeb525203201095d1f5ee76fbceb.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <6241da59ba45eeb525203201095d1f5ee76fbceb.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 85dad327d9b58b4c9ce08189a2707167de392d23
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 312b0bcd402a003053914e13d962e82be906cf41
Message-Id: <160719609530.18711.6749077510215679363.pr-tracker-bot@kernel.org>
Date:   Sat, 05 Dec 2020 19:21:35 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The pull request you sent on Sat, 05 Dec 2020 09:30:29 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/312b0bcd402a003053914e13d962e82be906cf41

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
