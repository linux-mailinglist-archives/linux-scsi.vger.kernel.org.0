Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942DF281DE7
	for <lists+linux-scsi@lfdr.de>; Fri,  2 Oct 2020 23:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbgJBVyU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 2 Oct 2020 17:54:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:57262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgJBVyS (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 2 Oct 2020 17:54:18 -0400
Subject: Re: [GIT PULL] SCSI fixes for 5.9-rc7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601675657;
        bh=Oae/0q5EzDwaXRlROT4j61wW2juiOq8Wo+2CtbtFKLs=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=YHHuTnfYxoUWmcbEhPROi0uXgswQU6dlALTaBuWLWKkt2lqQVYB5YJ1phOVU8ahWk
         Ya6RVV1KeJwHjuH8FbbiMV9YZAEzsBE6r4nwZKIDbXfLCLH3qWiworK+Uy8R4kqEUE
         OMfUXQwrh2rm/ddv+8/3WNvI6ahTBPAobWLr6s7o=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <32aab084a6bf83b48b7e609c35e3822ee0f778df.camel@HansenPartnership.com>
References: <32aab084a6bf83b48b7e609c35e3822ee0f778df.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <32aab084a6bf83b48b7e609c35e3822ee0f778df.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: bcf3a2953d36bbfb9bd44ccb3db0897d935cc485
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cb6f55af1fb28655c9f3843bc12c0a48856c1d09
Message-Id: <160167565743.8763.5887435040064383804.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Oct 2020 21:54:17 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The pull request you sent on Fri, 02 Oct 2020 12:28:04 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cb6f55af1fb28655c9f3843bc12c0a48856c1d09

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
