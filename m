Return-Path: <linux-scsi+bounces-21599-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id atLlIW26rGmDtgEAu9opvQ
	(envelope-from <linux-scsi+bounces-21599-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Sun, 08 Mar 2026 00:53:17 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E43D622E063
	for <lists+linux-scsi@lfdr.de>; Sun, 08 Mar 2026 00:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 469F0301E953
	for <lists+linux-scsi@lfdr.de>; Sat,  7 Mar 2026 23:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAA430E838;
	Sat,  7 Mar 2026 23:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqLEieqh"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302AE2BD587;
	Sat,  7 Mar 2026 23:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772927592; cv=none; b=UHCv+BGL2oplhN/LfjlzWl89jQuK5p6UizzCF5eshcsBBMqrd42lVvtQKRwoq5WyOgUmd9cK54TP/Rh0piKEeSWtObtHg0Qq5Bqx0V31Y9+VW+yUH8j6bVJ7c3/0w2o5ar6ehJ+CH4m1KkRsEgyi2JcEznfQvrVv0zvCermDwmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772927592; c=relaxed/simple;
	bh=lAqThZtSWEcOEo5xRgQasYKljKR7R+NVI6ZAYUbxXlM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=hwTSNMvhQ1wqAqvlpFqnb59N+PieSizkgzQ9042kG5pjeJIZuxs0WxrqgWii+YKIvXHtWTfFVnOq/xohPac4M9h89W1ZswZtsJ5RMF4CdDlAIqTlFUXk2+3tQYd5Q75Asbr0BTalOT72STOuUi081oKUXjGeYJSL1wr08mIHfIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqLEieqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12561C19422;
	Sat,  7 Mar 2026 23:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772927592;
	bh=lAqThZtSWEcOEo5xRgQasYKljKR7R+NVI6ZAYUbxXlM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=dqLEieqhhoglKZsCza2EruFe6MhdpeJwU5850DNMltBBcKFl+KhUBJ4aMA3S+IbH9
	 zA/c1JkE+FrbZSP8mlws5ArIyshuc5oXe8YzOV+9ihniQSiWIjBS5ONZGRmYRvoLZ9
	 uhrx1QZDTwT2FUVjBpKNQhG4/f95Q6nJDSB+K4ShWMW41q/vgVvrO2l1hSAeQOJgJA
	 l7TbIvBYIaj3r97VPbO8REMXtURtIPCG1UKLE3WbAApM2c8kgm/rE7Bg+x3Qf+vAbt
	 eAcNW0dceBJ+qK+5IDQwdOTmq0D0/LkwxhPIRHp1OoBs0UmdXVihS4UEgW+ccbYMxK
	 SB8BTJt3O+d8w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA29E3808200;
	Sat,  7 Mar 2026 23:53:11 +0000 (UTC)
Subject: Re: [GIT PULL] SCSI fixes for 7.0-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <a07e33c269b4947f65174892bc3bc27daaba7fda.camel@HansenPartnership.com>
References: <a07e33c269b4947f65174892bc3bc27daaba7fda.camel@HansenPartnership.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <a07e33c269b4947f65174892bc3bc27daaba7fda.camel@HansenPartnership.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes
X-PR-Tracked-Commit-Id: 14d4ac19d1895397532eec407433c5d74d9da53b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3b5d535c635cbf88dbb63231cbae265b22e6a5f5
Message-Id: <177292759047.346695.5877616149585008521.pr-tracker-bot@kernel.org>
Date: Sat, 07 Mar 2026 23:53:10 +0000
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: E43D622E063
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21599-lists,linux-scsi=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.986];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

The pull request you sent on Sat, 07 Mar 2026 13:32:13 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3b5d535c635cbf88dbb63231cbae265b22e6a5f5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

