Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFAB25A0B3
	for <lists+linux-scsi@lfdr.de>; Tue,  1 Sep 2020 23:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbgIAVOL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 1 Sep 2020 17:14:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728845AbgIAVOL (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 1 Sep 2020 17:14:11 -0400
Subject: Re: [GIT PULL] SCSI fixes for 5.8-rc3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598994850;
        bh=VSFO8KirRqvb0Q1S1fwg0uY80jMI5CBPnTWxPURcims=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=ER5jKiFTVB8bUL5Z8KygVQMr2b/Z8Xr1JmXNOluapUdAWG/8z8rkg2NAC1pkOh7jM
         RphDrBu57oZ3plGBLXjw3SElhDRK40C9zfFdMp8DFJiCFD9YcGsv8eOZAh/lxmYDgL
         ud6s96vep3zYQ4khwsny/7BXJHiTtfGEnHkl035I=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1598994296.4238.30.camel@HansenPartnership.com>
References: <1598994296.4238.30.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <1598994296.4238.30.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 75d46c6d15efabc5176a5e2694ee236f02ee72ef
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b765a32a2e9170702467747e290614be072c4f76
Message-Id: <159899485063.20509.14496931103911439818.pr-tracker-bot@kernel.org>
Date:   Tue, 01 Sep 2020 21:14:10 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The pull request you sent on Tue, 01 Sep 2020 14:04:56 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b765a32a2e9170702467747e290614be072c4f76

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
