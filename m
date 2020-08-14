Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD6F245009
	for <lists+linux-scsi@lfdr.de>; Sat, 15 Aug 2020 01:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgHNXFN (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 14 Aug 2020 19:05:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726213AbgHNXFN (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 14 Aug 2020 19:05:13 -0400
Subject: Re: [GIT PULL] final round of SCSI updates for the 5.8+ merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597446313;
        bh=WxUD7skxwfs6pijT07oPf/FOHZs1nsZk33KJXyl/49c=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=v2xbTRNcvQhgaSsjJ3NAQCp1pwWXJ11Ugbecmu11T9nbgNjnkklAXC6JdFNZe+85M
         88By6dEFtUgjmDMdPLO+GgYnwcco3KPmNHRvPY/uhreJ2OUTYzK0dgr6MD3CR84kak
         083Gw8xqiu5s53TJTciPGAadu6KAZKGw6aJLR3yQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1597423176.3916.19.camel@HansenPartnership.com>
References: <1597423176.3916.19.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <1597423176.3916.19.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc
X-PR-Tracked-Commit-Id: 7e0e8be3a1fd1399373224e22d77487e63566704
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c9c9735c46f589b9877b7fc00c89ef1b61a31e18
Message-Id: <159744631344.12327.3111654910189380288.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Aug 2020 23:05:13 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The pull request you sent on Fri, 14 Aug 2020 09:39:36 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c9c9735c46f589b9877b7fc00c89ef1b61a31e18

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
