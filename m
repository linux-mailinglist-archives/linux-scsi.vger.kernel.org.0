Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D52DF141996
	for <lists+linux-scsi@lfdr.de>; Sat, 18 Jan 2020 21:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgARUUL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 18 Jan 2020 15:20:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:42336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728779AbgARUUE (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 18 Jan 2020 15:20:04 -0500
Subject: Re: [GIT PULL] more SCSI fixes for 5.5-rc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579378804;
        bh=e0X0dZ+XoYgoAzup3hBksKQHzomqscFqr+DmTJaCguQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=hOIeE/9D/N/P2C8F9KR5IiNie6yqegCXKTOjL1UP+g2G3nZMU9XUXlAkQW+oneHfy
         zikXxty3ev0NFgGf3gdrh3TuYQppaLp+awF9aJiXeHZonfRyiGYsmLGKVxdtG+cM98
         76p6PkNwpV7xj9ltM4kNI6y4Lpup5d4CxaT3gcUo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1579372445.3421.26.camel@HansenPartnership.com>
References: <1579372445.3421.26.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1579372445.3421.26.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 28d76df18f0ad5bcf5fa48510b225f0ed262a99b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8965de70cbafec673417eed423bd5e0e9c244079
Message-Id: <157937880416.12197.13080896970388822007.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Jan 2020 20:20:04 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The pull request you sent on Sat, 18 Jan 2020 10:34:05 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8965de70cbafec673417eed423bd5e0e9c244079

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
