Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93621AF51B
	for <lists+linux-scsi@lfdr.de>; Sat, 18 Apr 2020 23:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgDRVPY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 18 Apr 2020 17:15:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726459AbgDRVPV (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 18 Apr 2020 17:15:21 -0400
Subject: Re: [GIT PULL] SCSI fixes for 5.7-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587244521;
        bh=xIaK/BViQ7a2I1TjAuY+cso2dtWt3+gb9K0xVBcET68=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=UvGvC1GsPNdBc+rt4zYxKwqhkNunGKAkQNlSh0hIsprIoOGZfGCzZhGfw6zMThGFL
         HZcFMLdxFjuVjswIwAkqdPw78tUPTM3HY2+FN+tkvm7YLaEI3ekiqiwQou0hqe3GTm
         Dxss3LQvcmbL2B2OyMDDhYtt4m+zXXsVFrp9UmHI=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1587240636.7897.11.camel@HansenPartnership.com>
References: <1587240636.7897.11.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1587240636.7897.11.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 849f8583e955dbe3a1806e03ecacd5e71cce0a08
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 50cc09c18985eacbbd666acfd7be2391394733f5
Message-Id: <158724452141.32136.9772790566639255244.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Apr 2020 21:15:21 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The pull request you sent on Sat, 18 Apr 2020 13:10:36 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/50cc09c18985eacbbd666acfd7be2391394733f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
