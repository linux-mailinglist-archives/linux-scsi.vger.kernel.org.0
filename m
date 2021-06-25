Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1543B4ACC
	for <lists+linux-scsi@lfdr.de>; Sat, 26 Jun 2021 01:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhFYXIU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 25 Jun 2021 19:08:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229844AbhFYXIT (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 25 Jun 2021 19:08:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5E69761945;
        Fri, 25 Jun 2021 23:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624662358;
        bh=lcuTG6ZjgFiCKHUGCcKJQdJ2CR+vrhu/bH7yQ62d6oI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KldSj1c2wTzMWEfTKNZeq6GyvIkhgbxx9WmtXsf9nHPUaXiE9VTA9PgdBHS/6obdy
         DWF+dSETUTwFBTlqodEYYXzfC5pZ0i+PScHr6qAZI0EmqbKR3Kgm9nmAx0LAIRNfFk
         0Ulvrq2VanieepYPDy78q3CUAod//oUUy1+xlfXt69fzMcVLrAVf5r0dhHU4U2E5f7
         7RTauWkcLzTV2aV2t7M+VqhfFiEla8+eSuSsJMqX5WYSahg9FZvOpCckgpgt/a9hPn
         b/mYnpmwWZyJJHe2154KRn9Llzjfqp74tvNNvU0lsjIVxa1IGLAWWXgReSVKT5hdje
         2XOLsIb5rCJ3A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 4A40A60A3C;
        Fri, 25 Jun 2021 23:05:58 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 5.13-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <85a6f026d0ed9dddcdddcc03a59968c46b09b94f.camel@HansenPartnership.com>
References: <85a6f026d0ed9dddcdddcc03a59968c46b09b94f.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <85a6f026d0ed9dddcdddcc03a59968c46b09b94f.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: d1b7f92035c6fb42529ada531e2cbf3534544c82
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2f527b58e8115dae15ae344215accdd7a42e5ba
Message-Id: <162466235824.24705.11314261824838167773.pr-tracker-bot@kernel.org>
Date:   Fri, 25 Jun 2021 23:05:58 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The pull request you sent on Fri, 25 Jun 2021 15:06:51 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2f527b58e8115dae15ae344215accdd7a42e5ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
