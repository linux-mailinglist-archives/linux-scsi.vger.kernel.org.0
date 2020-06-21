Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886A52027FC
	for <lists+linux-scsi@lfdr.de>; Sun, 21 Jun 2020 04:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729156AbgFUCa3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 20 Jun 2020 22:30:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729075AbgFUCaZ (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 20 Jun 2020 22:30:25 -0400
Subject: Re: [GIT PULL] SCSI fixes for 5.8-rc1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592706625;
        bh=hLfUqQI5lELd+NHz2VwHyg7BiFEXisb95E4wFsQyJ7Y=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=MdPLfWo6fkSil8dNIVqFy8n4/1EqOxDe24+cOVLYN3YxMfnqtyN8TC5evA2eDpRwW
         hPy8ISoKsSqTgk69ISXz6KIRBlHDV/Ih99/OqZu3ANNzno5SPLpNmcJH1s5YVxH0cl
         MbshkFvUE7YvNKuSBo2EYpMqk41A9TiowlLu4EWQ=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1592674936.3583.20.camel@HansenPartnership.com>
References: <1592674936.3583.20.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1592674936.3583.20.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: b8f1d1e05817f5e5f7517911b55ea13d2c0438a0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 64677779e8962c20b580b471790fe42367750599
Message-Id: <159270662559.3975.895454316141668110.pr-tracker-bot@kernel.org>
Date:   Sun, 21 Jun 2020 02:30:25 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The pull request you sent on Sat, 20 Jun 2020 10:42:16 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/64677779e8962c20b580b471790fe42367750599

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
