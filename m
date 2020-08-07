Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A90823E5A4
	for <lists+linux-scsi@lfdr.de>; Fri,  7 Aug 2020 03:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgHGBzM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 6 Aug 2020 21:55:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbgHGBzM (ORCPT <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 6 Aug 2020 21:55:12 -0400
Subject: Re: [GIT PULL] first round of SCSI updates for the 5.8+ merge window
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596765312;
        bh=ZQ3AZOQRls5Sk7BQCbwdqbcwdxOK2Rjt6f8/0mn/8CU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=XwTosu1GRkKt+QgS7nWWmkeUVopgJsT8mod50Bpo9FrC+fniw9bB7SNEFZKnP7VHd
         ySYV8ZHK4APP6G3TX3qAZkRya5hRenaWZhnetiKbdbBEabswTCU7gTMWn3vuEWs1bx
         nR0H2RvqNEM2BbVygO7TvFVCLdiy88sv1MWJnY7w=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1596747315.25458.50.camel@HansenPartnership.com>
References: <1596747315.25458.50.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <1596747315.25458.50.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc
X-PR-Tracked-Commit-Id: bf1a28f92a8b00ee8ce48cc11338980e31ddb7b3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dfdf16ecfd6abafc22b7f02364d9bb879ca8a5ee
Message-Id: <159676531190.30846.10031371483321725160.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Aug 2020 01:55:11 +0000
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The pull request you sent on Thu, 06 Aug 2020 13:55:15 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dfdf16ecfd6abafc22b7f02364d9bb879ca8a5ee

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
