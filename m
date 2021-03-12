Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F5833994E
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Mar 2021 22:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235371AbhCLVwh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 12 Mar 2021 16:52:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:48204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235347AbhCLVwb (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 12 Mar 2021 16:52:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 084CE64F73;
        Fri, 12 Mar 2021 21:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615585950;
        bh=DmeIx9BwxAyci4fTOWp6uYyGctOd9rLpAOz0oaNZw6w=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KLaCaGEuq2tvxoh4HCcQ/5MePyD8bfro3HVs0guIkI+6UXSI4OwxjSpDVmPwVHein
         uJiZFWNfK2sWGg4Eapruu1Q+J7v8TrBYe3y/Q2Q1RQAdQ/hi3M6u/Uit3ILEouofKp
         HX9LqXtFgsj3/RNnIegw7isg6KVbQ6OSxst/1rGPiTxfeuR2EIHBjfirybHz4gFAJe
         TfaF63bA99m0gpZdLZCQM4SbeTOqphls58RJzvyownKyn8KMgjqM/jinnnjWEnph6Z
         PJXS89Yge8ihPUjF0uc5xxCO42q2lLaOTQQYG9alzEFNBdlVSEVC1kw9i/2y5zTrUp
         iqpubiKb1VO3A==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id E2BC660A2D;
        Fri, 12 Mar 2021 21:52:29 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 5.12-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <a139e36ef462b5a9678edd0e97477ff187d6f1d9.camel@HansenPartnership.com>
References: <a139e36ef462b5a9678edd0e97477ff187d6f1d9.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <a139e36ef462b5a9678edd0e97477ff187d6f1d9.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 1112963427d6d186f8729cf36fefb70d5ca5a84a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9afc1163794707a304f107bf21b8b37e5c6c34f4
Message-Id: <161558594987.23578.431083380474158862.pr-tracker-bot@kernel.org>
Date:   Fri, 12 Mar 2021 21:52:29 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The pull request you sent on Fri, 12 Mar 2021 11:05:45 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9afc1163794707a304f107bf21b8b37e5c6c34f4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
