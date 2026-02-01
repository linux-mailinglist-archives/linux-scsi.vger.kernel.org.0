Return-Path: <linux-scsi+bounces-20656-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IH2sJOWtf2kbvwIAu9opvQ
	(envelope-from <linux-scsi+bounces-20656-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Sun, 01 Feb 2026 20:47:49 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FC5C719B
	for <lists+linux-scsi@lfdr.de>; Sun, 01 Feb 2026 20:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38BB83025D35
	for <lists+linux-scsi@lfdr.de>; Sun,  1 Feb 2026 19:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F762D1913;
	Sun,  1 Feb 2026 19:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbmgbIPt"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080FF3EBF06;
	Sun,  1 Feb 2026 19:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769975172; cv=none; b=sAxDzF+80knNxI0og1mg1ehwO/0ow4x1NKTLeTO+tTiBdlQpKanfkNKUzi4Hb7t9OvJcdBBvNFmMFME2mi+cfdq0m1BeXS4xTnif6O1JHN0jv53gu+AzqqMI/Zc8UsqK/BImLVX7cjeMpaC0OBdV3Fwe+vsuSYGadcIGIzhQtyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769975172; c=relaxed/simple;
	bh=QWQx87bdRp0fMdtY3I9qM1h8cHhdKdrMqaYD+4NiyvU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=s+KE54y5kseCCLoXtI8lyvzZLTIEC3uFmLAz75IIx6o75f31G5XkvwVQN3Q1ZAjT/ZrtjjcuLcjUnVayl/HJLlPKy1lV6dY1UrNdk/okmjVmGoP8E0eshxcj3PQ5dm4Ow4n4lymsMUuMGp1b33Yepf5mxzzMPy0tLlXGWcB+Wc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbmgbIPt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB91C4CEF7;
	Sun,  1 Feb 2026 19:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769975171;
	bh=QWQx87bdRp0fMdtY3I9qM1h8cHhdKdrMqaYD+4NiyvU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=nbmgbIPtBS6OKwlM/vyIvKFHpkP1yqiXW/VSDTdmsDD595occ999EUjk9FAbbFTpy
	 1Nmv/BXbDpJotLn8gJiD8D7RhJiHcxNtubN2KGH6DqOCqPsYjdRyUHUibUcY0s9RJo
	 aVLwPp7k5ZWmCqgqXoDyV7/71VEeoGNgJAR2i2hkatMYGTwKU3IXyG7E0mbEldSK5K
	 6UyR378ezUdqHTcd8YGC5l0CxAzTTgRQpYveaISOBJaEDJOn4/NEJDUsxtm7LwpQe9
	 uvQYE7DnRtRIze0uvlA21iN9H1qvYHIKM1jHrHUBhYxuH0WTy8JbYejWIT5HBGI5R6
	 KEiq5Yzzf2KCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 911D13804CB0;
	Sun,  1 Feb 2026 19:46:10 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 6.19-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <c6f1dc6f9354596c40c5bb310c915e500832ca66.camel@HansenPartnership.com>
References: <c6f1dc6f9354596c40c5bb310c915e500832ca66.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <c6f1dc6f9354596c40c5bb310c915e500832ca66.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 0444568edbf87c1da76b61c798ce0f1c1e478467
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9f2693489ef8558240d9e80bfad103650daed0af
Message-Id: <176997516922.3041.5718209622601344802.pr-tracker-bot@kernel.org>
Date: Sun, 01 Feb 2026 19:46:09 +0000
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20656-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-scsi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 09FC5C719B
X-Rspamd-Action: no action

The pull request you sent on Sun, 01 Feb 2026 15:10:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9f2693489ef8558240d9e80bfad103650daed0af

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

