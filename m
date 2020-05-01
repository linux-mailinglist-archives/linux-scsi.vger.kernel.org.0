Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7FF41C1D43
	for <lists+linux-scsi@lfdr.de>; Fri,  1 May 2020 20:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbgEASfL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 1 May 2020 14:35:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729671AbgEASfL (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 1 May 2020 14:35:11 -0400
Subject: Re: [GIT PULL] SCSI fixes for 5.7-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588358110;
        bh=5ZOFxY1l89hJ+h4heApKnaHEWKqMZcqZ0twj5qMIxYk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XPqwk1Ws4yxa/RECnS32gTIV5O4yTqzP+AntbCNiikKUlVnfPx6er6FRYIkCUDpsj
         3YA5XlQ+LsEObPhrp0dqTaSvmP2q0ihuhWNDq+ynBJqZzTZMDx82qQBjwddXME+Z2V
         RsxEZVJH5ovTE8Zlsxh1tNQeW/Hdr8K5SbPrOKpE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1588299335.6654.7.camel@HansenPartnership.com>
References: <1588299335.6654.7.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1588299335.6654.7.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 1d2ff149b263c9325875726a7804a0c75ef7112e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cebcff3a1c42d9ddd29175ad3669245f4573938b
Message-Id: <158835811072.18489.3871559340832068878.pr-tracker-bot@kernel.org>
Date:   Fri, 01 May 2020 18:35:10 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The pull request you sent on Thu, 30 Apr 2020 19:15:35 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cebcff3a1c42d9ddd29175ad3669245f4573938b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
