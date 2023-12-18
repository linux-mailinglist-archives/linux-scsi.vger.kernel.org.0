Return-Path: <linux-scsi+bounces-1104-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9C5817AF2
	for <lists+linux-scsi@lfdr.de>; Mon, 18 Dec 2023 20:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C06D41F2387A
	for <lists+linux-scsi@lfdr.de>; Mon, 18 Dec 2023 19:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D28B740B7;
	Mon, 18 Dec 2023 19:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sW8ZSIw7"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC18740A3;
	Mon, 18 Dec 2023 19:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2D38C433C8;
	Mon, 18 Dec 2023 19:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702927485;
	bh=ENkpfPXDdBZ+VUxIprVp/9qDIkZLr31qOCwg3TYmvQU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sW8ZSIw7EB5+kPx5DHaRsHSK7DOBHjo21b677JmbmzC0GMInEfJ4QwGMI44vnnqxG
	 o3NzyuFhlfuKUKIBR9qG4rLaawhsOMlZ0vNKa6S5KSB548iyjy8rx1ZVzddEv7NFet
	 8z4Ei1jLQw9bjadoGCXCEXCeK2a+T1pklTDT8PynfeGFzFZzk7Dk1XHYXGbkO80v4a
	 rcNBX2vy/vRRdUlyRVA2fmhxkl5x5quraSOf/S9n+YijEmF+CoyQTm8+Vl6+9UwbA0
	 JvLvK9KJfXq9AlxEaYQILkBbn4Q1YgtRNReHJJFsv/a1Fw+OqR726feLDhUQoMrx2D
	 hwZIGyzuuLGYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 91F61D8C98B;
	Mon, 18 Dec 2023 19:24:45 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.7-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <6edb005530947b752d1a84c9ea69df0da6c85cf5.camel@HansenPartnership.com>
References: <6edb005530947b752d1a84c9ea69df0da6c85cf5.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <6edb005530947b752d1a84c9ea69df0da6c85cf5.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 77a67255609606164e1042f3bf7452a568a700e4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2cf4f94d8e8646803f8fb0facf134b0cd7fb691a
Message-Id: <170292748559.30314.10609090538239587335.pr-tracker-bot@kernel.org>
Date: Mon, 18 Dec 2023 19:24:45 +0000
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 18 Dec 2023 13:43:54 -0500:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2cf4f94d8e8646803f8fb0facf134b0cd7fb691a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

