Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAD334BE77
	for <lists+linux-scsi@lfdr.de>; Sun, 28 Mar 2021 21:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbhC1TLo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 28 Mar 2021 15:11:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229655AbhC1TL0 (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 28 Mar 2021 15:11:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 958AB61958;
        Sun, 28 Mar 2021 19:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616958686;
        bh=PMA4oqqReBmtAX2ZAQmQ/Ij1yc01H45ZOkLzxC2sfBA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ekkDR4P1dxkrDgGLnDZ2l+RhaE+WWWaha+FwLK1qJIy1XrBmm2MniuKfJXSHpi12h
         JDwdME/E+8oAi+TwBYLINg4OzojiI+15srN7NmqXkM6EQEc+6IXuNo5oxFV/tyGmGQ
         gMm4hF8SiAgmnXjPFrFa2oP1wNx5+rW3SDOFJ4gXxMubn5ZWApMQjJlvFMtoWPDFol
         IthyQ5M5VoXVMFWUDj2gsErqXi4ZqNDy8vvJ6ZOnZuNvhXsdQnpGTAvkBz4lLBSDln
         Tu+eBs6W7VMPumoi+lB2lwhwsD0Io7oHuMiAFa/0t0IbBJTPMM9JDfjD/58UuCtiyk
         aLLMYUZikpZoA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 7F5F3609E8;
        Sun, 28 Mar 2021 19:11:26 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 5.12-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <466055c2bdf8d6e61b616bc9e1f7393516365bcf.camel@HansenPartnership.com>
References: <466055c2bdf8d6e61b616bc9e1f7393516365bcf.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <466055c2bdf8d6e61b616bc9e1f7393516365bcf.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 36fa766faa0c822c860e636fe82b1affcd022974
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8cfe8fa22b6c3d12595f68fde6ef10121795267
Message-Id: <161695868646.24587.12820068379331819503.pr-tracker-bot@kernel.org>
Date:   Sun, 28 Mar 2021 19:11:26 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The pull request you sent on Sat, 27 Mar 2021 18:04:06 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8cfe8fa22b6c3d12595f68fde6ef10121795267

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
