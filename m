Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15CFC19CDDC
	for <lists+linux-scsi@lfdr.de>; Fri,  3 Apr 2020 02:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390469AbgDCAkX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 2 Apr 2020 20:40:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390460AbgDCAkW (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 2 Apr 2020 20:40:22 -0400
Subject: Re: [GIT PULL] first round of SCSI updates for the 5.6+ merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585874422;
        bh=YaFclORjuPZW1dxJ3qN14gsQr29KJIcmOljdhCM2wvI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=IFgwl1rGl16z3FsJynrTtPHKHZuthqw+Mvt2qOVHMiMG5iieuewi8z1R5GljORISZ
         V7CDMNsbkl8UDyD8ILpuT3RtLiZECGIOqpvkXG98XJK7HdbNV6ZBsEHMERLg1gJERr
         iaUqHyrno4ZIPvLRol5Th55XtUrv7GXt2bpjJoI4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1585843596.9534.17.camel@HansenPartnership.com>
References: <1585843596.9534.17.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1585843596.9534.17.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc
X-PR-Tracked-Commit-Id: ff275db92c935858454b721f0d960fff421634d3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 79f51b7b9c4719303f758ae8406c4e5997ed6aa3
Message-Id: <158587442215.31624.18315350369310388562.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Apr 2020 00:40:22 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The pull request you sent on Thu, 02 Apr 2020 09:06:36 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/79f51b7b9c4719303f758ae8406c4e5997ed6aa3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
