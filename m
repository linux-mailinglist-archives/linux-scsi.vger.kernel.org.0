Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336F339D201
	for <lists+linux-scsi@lfdr.de>; Mon,  7 Jun 2021 00:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhFFWty (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 6 Jun 2021 18:49:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:47630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231169AbhFFWtx (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 6 Jun 2021 18:49:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5E02D61421;
        Sun,  6 Jun 2021 22:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623019683;
        bh=CbWm9wR61dq+38EWFbQGYk/fjL3ALX06iOeMl5Dh6eU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LlJdaMuzHDkog9XfCSfgcf6+riLxLfcHq2xJbiOhdb3Ikj8nFakCnNS7/aVe5RP60
         bQZ/pGiMKjSvS2CLSSfpIB8GLAj2QSh55gQz7kUE5hxSfUywpT8ju2g85VXk0nNECQ
         uerWbMbScsR5x2VqAc3y8XfYmS3vef5jBwfU6rhabfVvLpJcZq7a07G/TyJD/dNEln
         CjmgtFyCRUz5YUSYI50EwwU02R6CA2r6IWJte3ChTlIVEGuh6L38YOq3tjekARui1/
         njPCoQRfE41UptLvpeDw0Fb9+7uhf51R6Rz2+tBnEVxR3gRFwXUS9rIvuaSw35nv3O
         4vlxmaAJNrHuQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 5327D60A53;
        Sun,  6 Jun 2021 22:48:03 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 5.13-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <22894c5d4fd4bcfa29bd945ce81112606d2fe5fc.camel@HansenPartnership.com>
References: <22894c5d4fd4bcfa29bd945ce81112606d2fe5fc.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <22894c5d4fd4bcfa29bd945ce81112606d2fe5fc.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: e57f5cd99ca60cddf40201b0f4ced9f1938e299c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 90d56a3d6e0bec69ab58910f4ef56f4ef98d073a
Message-Id: <162301968333.14999.10882643227847345691.pr-tracker-bot@kernel.org>
Date:   Sun, 06 Jun 2021 22:48:03 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The pull request you sent on Sun, 06 Jun 2021 08:49:10 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/90d56a3d6e0bec69ab58910f4ef56f4ef98d073a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
