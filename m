Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E72938BB01
	for <lists+linux-scsi@lfdr.de>; Fri, 21 May 2021 02:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbhEUAuG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 20 May 2021 20:50:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233409AbhEUAuF (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 20 May 2021 20:50:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id A3E2E60200;
        Fri, 21 May 2021 00:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621558123;
        bh=cLlXaJiGjJkng1QsV20Wq+rS1r6PdIvKOloeujH2y0c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JHmN/4iTpMrFFyCdBQPWsjPv0Sg/UAT5XPPGfS123CYbchrZ/IKB2pSA+Ec9vGh97
         zaEIpL7hoO7f/HEswKGWXsMFw74cVRH2l2akT42E5RLfYft0DZzbQw53QYjr5s0b9y
         gukmS9h8HbWejkOXgpzzGCVzAL7aAoq1btnKgU5dY2+75NdvN+uygivn6c3kQIc+6I
         59Du2Tyaf5GYOLjsmEDZT4IQ0w9+WpMFYPDHJ1UXjyUoATyTnqMbO2eAgFGqQNVXfW
         1L2CBXsFGKxLMDj6pR4Chvf3bWui34StygKA+szOXpuCWoJL1EeLPg6OVCkfP0hS7Q
         zyPNZ2vcpEyqg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 915CB60967;
        Fri, 21 May 2021 00:48:43 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 5.13-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <376a0bde564e90d69378434a402eace5a298d6c4.camel@HansenPartnership.com>
References: <376a0bde564e90d69378434a402eace5a298d6c4.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <376a0bde564e90d69378434a402eace5a298d6c4.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: d1acd81bd6eb685aa9fef25624fb36d297f6404e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a0d8b0eda3107f5dda4a56623164ced833574ead
Message-Id: <162155812352.12405.6481527465030301624.pr-tracker-bot@kernel.org>
Date:   Fri, 21 May 2021 00:48:43 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The pull request you sent on Thu, 20 May 2021 15:01:28 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a0d8b0eda3107f5dda4a56623164ced833574ead

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
