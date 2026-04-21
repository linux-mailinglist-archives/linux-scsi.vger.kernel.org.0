Return-Path: <linux-scsi+bounces-23170-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGEZO1Ol52kI+wEAu9opvQ
	(envelope-from <linux-scsi+bounces-23170-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 21 Apr 2026 18:26:59 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DFC43D549
	for <lists+linux-scsi@lfdr.de>; Tue, 21 Apr 2026 18:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 956E43026A9D
	for <lists+linux-scsi@lfdr.de>; Tue, 21 Apr 2026 16:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB53137BE8C;
	Tue, 21 Apr 2026 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sb+OHF/Z"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAAC364931;
	Tue, 21 Apr 2026 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776788747; cv=none; b=ByACw5OTnJc+rx5CGu6zJYjRPGc39PQ4QfVkrECN6IvYgLJAW578mzPDJi0SpF6c4uQuFEWJPDE+NP7AOIAXajzJs+qZNO6wL/KkSliYChrHCXpwSGkLAF36ZoxWIRZ06DcnqFag7YtnC2bpcTv7GmjbBySDaBNCcbxuJbN+Erc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776788747; c=relaxed/simple;
	bh=4ZY0/xDh8KLy0tRilZiUzu6c6zCfdfaJqfl5fsGl+Sg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=BwqOmgFYYsYSRL1MPaQJuWS3rkCW7miKluEIFABlvkfrERv0n3q9EelY0X9s9T+AWpiWemIFGuqC78QBxjNfTY1F+JcyWTn3yjMHRNTc6bcRTW3fTg6Ny6vxZm/cwtSYRGnNfAOTQYHWcjr1fig9g1DMj+42r/2uYrQxEq1qBV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sb+OHF/Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C67C2BCB0;
	Tue, 21 Apr 2026 16:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776788747;
	bh=4ZY0/xDh8KLy0tRilZiUzu6c6zCfdfaJqfl5fsGl+Sg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sb+OHF/Z0P6AHqSZjCc+VeaJkK1/Cua9Dn9HrejiwgCOUW7/mkMWNMMUyErdqgt/M
	 oidFgAySt8CrB3T6duQEJuAQmDPIefiOSyVoa0EpGEyzcdnpoA9NoO2YR9Ni3oBCLq
	 AE3uv6oUr5C99abtGN74MLgBJnEE9C2uCvRrtmtswJJqj4/APf63TAk/XSWb5PVu/d
	 Zw7UYV6iSvTXnYJRMw986rfsHZmCzXN7kT7n/I/98TmcZX+0tdmvpS32Kx7GszB25n
	 lMsGgySXeGxzb2X9RtEHOdtSGUSNkf8fmSWbJJad1dploI1Ea9KvD3kJhC9Ap7mua3
	 VXBapoo2zQ6gA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE2F39301AE;
	Tue, 21 Apr 2026 16:25:12 +0000 (UTC)
Subject: Re: [GIT PULL v2] SCSI updates for the 7.0+ merge window
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260421151345.9937-1-James.Bottomley@HansenPartnership.com>
References: <20260421151345.9937-1-James.Bottomley@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-scsi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260421151345.9937-1-James.Bottomley@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc
X-PR-Tracked-Commit-Id: 070ec6f691411f27e7a743841bdfb0bf604fbce2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a85d6ff99411eb21536a750ad02205e8a97894c6
Message-Id: <177678871070.2896080.1414872484261315034.pr-tracker-bot@kernel.org>
Date: Tue, 21 Apr 2026 16:25:10 +0000
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23170-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.232.135.74:from];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-scsi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-scsi];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[10.30.226.201:received,100.90.174.1:received];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 93DFC43D549
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The pull request you sent on Tue, 21 Apr 2026 11:13:43 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a85d6ff99411eb21536a750ad02205e8a97894c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

