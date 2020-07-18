Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A1A224DE5
	for <lists+linux-scsi@lfdr.de>; Sat, 18 Jul 2020 22:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgGRUuF (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 18 Jul 2020 16:50:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727042AbgGRUuF (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 18 Jul 2020 16:50:05 -0400
Subject: Re: [GIT PULL] SCSI fixes for 5.8-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595105404;
        bh=ensr+QF4vF+1IENAu/9s6Tg89R0KxicvKcKLUvk13LI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=opdKXhygtg7WREDxJRBhB+pHVUzp6C8FZHaDJDevZDdfefge+0nFNVlUI2MIjbRSv
         BskvDKXeJoHJZXfsfR2aC539v5VCV7thaLn4yTKHHZuQQutvzNrB6BnJdjJkKZdcoq
         sxfAjKKsYMOcHcljiYBkWHARQ1RrDl7VgPIrNVV4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1595091880.3281.5.camel@HansenPartnership.com>
References: <1595091880.3281.5.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1595091880.3281.5.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 07d3f04550023395bbf34b99ec7e00fc50d9859f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f932d58abc38c898d7d3fe635ecb2b821a256f54
Message-Id: <159510540487.20690.14668578420886526340.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Jul 2020 20:50:04 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The pull request you sent on Sat, 18 Jul 2020 10:04:40 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f932d58abc38c898d7d3fe635ecb2b821a256f54

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
