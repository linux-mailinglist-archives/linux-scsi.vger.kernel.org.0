Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0742E85B3
	for <lists+linux-scsi@lfdr.de>; Fri,  1 Jan 2021 22:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbhAAV0B (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 1 Jan 2021 16:26:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:54278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727284AbhAAV0A (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 1 Jan 2021 16:26:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 6DD4020758;
        Fri,  1 Jan 2021 21:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609536320;
        bh=HBbiKIomw2V/Zs8PqLPF7pcGJXJfqe5NrGe5i96DocQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=S7qFwlceCWO9t6nT0KpKKwl3PqTf2lfNkAH1siLjSXVIX2cH+Quhe+RE2DZlQlgzi
         CT6fRmwU/Ps2hpbo/KSfCoJfdtzsuB70owfaOOK40srdWxHGzQMWSns+FGdIIEkEe6
         QCURnpo0fdNiYFX2sM3LneGfieTzkg+iufB+eMELopifZOP4eHBsBMjzamBlsOx2lH
         0ptdk/TJ0BQ3Xh0BnaoC23BVIz8hxgao9tOVn+xAb3D2uvAEzrxjqZ5++uMyZ2iBw4
         ffsKe2sE5Xn/VBQcz3yU9wNzlUB27QUZ43AY79osTOSzLNII89mnIA7YqI+DDQyffp
         Kkx4aKjcZUf3A==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 5AFDC60190;
        Fri,  1 Jan 2021 21:25:20 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 5.11-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <dd63a06d53c45f9511307085797086351784b1a3.camel@HansenPartnership.com>
References: <dd63a06d53c45f9511307085797086351784b1a3.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <dd63a06d53c45f9511307085797086351784b1a3.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: cb5253198f10a4cd79b7523c581e6173c7d49ddb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eda809aef53426d044b519405d25d9da55319b76
Message-Id: <160953632030.8778.11137709644108968089.pr-tracker-bot@kernel.org>
Date:   Fri, 01 Jan 2021 21:25:20 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The pull request you sent on Fri, 01 Jan 2021 12:19:11 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eda809aef53426d044b519405d25d9da55319b76

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
