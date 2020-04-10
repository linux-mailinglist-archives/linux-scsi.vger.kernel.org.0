Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B30DC1A4B4C
	for <lists+linux-scsi@lfdr.de>; Fri, 10 Apr 2020 22:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgDJUkd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 10 Apr 2020 16:40:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:47864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbgDJUkc (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 10 Apr 2020 16:40:32 -0400
Subject: Re: [GIT PULL] final round of SCSI updates for the 5.6+ merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586551232;
        bh=UKehqYH0jwSXHXbwhE6DMiYSwP6eu4/Bu+uliwUKjH8=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=NACs1Fz6UBNHGWye6MdhTCnBqTZuJxvG7vNvPE4UAVwuLXpmCKOQIuwt1pR9kzf63
         tA/POr66+KAvoANWnjb7WhLa4ObSiJ/h69bKkXquiwrJCUraSy6hpBp5PlEmpYr/K5
         WhgiG/viuOeoqxZ8zsN+QYi8f9y7VOvs1ppsYUh4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1586542752.4129.55.camel@HansenPartnership.com>
References: <1586542752.4129.55.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1586542752.4129.55.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc
X-PR-Tracked-Commit-Id: 1b55940b9bcc64acb7336224b0e49203ff7987c6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 93f3321f650c5e700478ee8ed2e118d8255095cd
Message-Id: <158655123244.24997.6752350097309620095.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Apr 2020 20:40:32 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The pull request you sent on Fri, 10 Apr 2020 11:19:12 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/93f3321f650c5e700478ee8ed2e118d8255095cd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
