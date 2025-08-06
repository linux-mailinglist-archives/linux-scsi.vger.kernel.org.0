Return-Path: <linux-scsi+bounces-15841-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF595B1C677
	for <lists+linux-scsi@lfdr.de>; Wed,  6 Aug 2025 14:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D316F3AB807
	for <lists+linux-scsi@lfdr.de>; Wed,  6 Aug 2025 12:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E928A28C2B6;
	Wed,  6 Aug 2025 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZCb5exV"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8886928C03D;
	Wed,  6 Aug 2025 12:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754484989; cv=none; b=agKhoHWYU3DwxGAOEGSZ9/Afr3m4swKzVxwWefj3se98FYMxWwsEaThOsiq9S6Zc2otA6TeQ0d1+twMEqteZXAy5sFpVYMW6m6mxHY/loyvulexp8H7eBZKYOEDTPZVYWKglixxori500iK6G0zyFo+Qp+9sAxJIbuXLpMZ9aW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754484989; c=relaxed/simple;
	bh=NGBQakqL1Tn0hH+z/aiFuKBNcVrQ9w40aZsRxvHUQSI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=lcNAOPAdj6VqaqxuxOirq2x+rdTKWklSTBb1eYMBd/3zXhQdl9N9geSwAnPxhK7i1DnpJoFD1xgnknPIcnzk3RuCeErsfVbzKq2rialcuRAerAduO0STlf04/HlouR9LFOZBCTajBwWCFzOFUVs1NdyQSl6sLCLHdUXcNmOgQMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZCb5exV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54C89C4CEE7;
	Wed,  6 Aug 2025 12:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754484989;
	bh=NGBQakqL1Tn0hH+z/aiFuKBNcVrQ9w40aZsRxvHUQSI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=FZCb5exV9ZJThkmXVGQsegNq+nKXqChqP+l/SbEnKmbpZelZI7TBSjpjIlPsd+JfY
	 x/RftEPey40qxzbAK0E7gQIQ82JWG74NuWov0+1Kes6wUWDb5JmxTRF6xQuwtmf6LF
	 kTlfeA1PvJSz0mhb/3GA6UnfKa4d7BBHXMEq3DjEfbNX3cJnHWglTbaLhngoLMFU6b
	 5tqll/T6lOE07ODqDe2AW4feBgwq+1giDpSXOkvsITC05Yvf1u3bgkHmf21DMFHxix
	 BvwhSdJa8SAB446dUeKhrT6s/n45p4PYfqMWYnmBWC4ix/0pX4oTKasZwAF/jZPOUx
	 oXhm0fzti7cRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FFE383BF63;
	Wed,  6 Aug 2025 12:56:44 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI updates for the 6.16+ merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <2201f60c4fff85f8ded863fdf574219463190ccb.camel@HansenPartnership.com>
References: <2201f60c4fff85f8ded863fdf574219463190ccb.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <2201f60c4fff85f8ded863fdf574219463190ccb.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc
X-PR-Tracked-Commit-Id: 7038db703317617ef3691fbbb7259d4cdf208cf2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d7edcc7c9109f165efcf5d767fed21578c37c46c
Message-Id: <175448500307.2781538.16343362644721777038.pr-tracker-bot@kernel.org>
Date: Wed, 06 Aug 2025 12:56:43 +0000
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 06 Aug 2025 13:13:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d7edcc7c9109f165efcf5d767fed21578c37c46c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

