Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5AE73A5A49
	for <lists+linux-scsi@lfdr.de>; Sun, 13 Jun 2021 22:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbhFMUTw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 13 Jun 2021 16:19:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231788AbhFMUTu (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 13 Jun 2021 16:19:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id DE36761040;
        Sun, 13 Jun 2021 20:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623615468;
        bh=qvKzYaPtv6Eces/OL4DglaCR6tqM+10HGfogEHH7FYE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cMdmS/yxMJSG2+qPiJdfbuAg/opdRYh2FKdYQU0K9pSbjYzAa2XtD+fzgw8QvYmSb
         T/YioEv/nxJUUylgCFy76iwjIhvYScvgQTudGRaba94Wbc0taUnIATjGxcxWdlAuxQ
         DpScBZUQMVg4X+CyguqalIjsbXCsENItknMIiEqbR+7uiA9E9rfS1BFRBDjYcvedo4
         EA6NWvh+b+xWZCi4VtV9qLnKB67CnRg4Oi83PHQDTqAnnBnepDlwRBqNAylEgs7qxF
         3nFgJEyiTq7K+eLTPrKlP8ltMKntsjobAttd8u5NWp332PZX9K7v3MSDOgperxryOL
         BMt8vekQ4Xdvw==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id CB2C4608FA;
        Sun, 13 Jun 2021 20:17:47 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 5.13-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <3eba0f658b27558cd0e023d58912443886bc723e.camel@HansenPartnership.com>
References: <3eba0f658b27558cd0e023d58912443886bc723e.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <3eba0f658b27558cd0e023d58912443886bc723e.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 1e0d4e6225996f05271de1ebcb1a7c9381af0b27
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 331a6edb30af2b06fcc7f2bf734c6f4984b48a31
Message-Id: <162361546777.15542.8510931793075326886.pr-tracker-bot@kernel.org>
Date:   Sun, 13 Jun 2021 20:17:47 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The pull request you sent on Sun, 13 Jun 2021 09:15:13 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/331a6edb30af2b06fcc7f2bf734c6f4984b48a31

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
