Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1192D1F851E
	for <lists+linux-scsi@lfdr.de>; Sat, 13 Jun 2020 22:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgFMUZi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 13 Jun 2020 16:25:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:38352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbgFMUZc (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 13 Jun 2020 16:25:32 -0400
Subject: Re: [GIT PULL] final round of SCSI updates for the 5.6+ merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592079931;
        bh=qnXZ9j/PE+79qpE4PZlbXRkhmQvuIoG0ehSmax2kTgw=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=faT35WpYsh79YZZIwSq7o8mcbTHGucV/s/pe9DZkaPMv87hCCRDnpYvvIOg/MkIb5
         z7wYIxCKGetybl7q9wkuM0acUm7/WVS7IZDy+rLSaszYiIGucgSNXLEyVZrmc/qU7y
         2Lv1i9XcA/HZFdPH2CPutgYco0oNgKeTsfAo2Nmc=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1592061311.5201.7.camel@HansenPartnership.com>
References: <1592061311.5201.7.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1592061311.5201.7.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc
X-PR-Tracked-Commit-Id: 42c76c9848e13dbe0538d7ae0147a269dfa859cb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3df83e164f1f39c614a3f31e39164756945ae2ea
Message-Id: <159207993187.31508.18077930451687352551.pr-tracker-bot@kernel.org>
Date:   Sat, 13 Jun 2020 20:25:31 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The pull request you sent on Sat, 13 Jun 2020 08:15:11 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3df83e164f1f39c614a3f31e39164756945ae2ea

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
