Return-Path: <linux-scsi+bounces-21175-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wG/GHdGEn2mYcgQAu9opvQ
	(envelope-from <linux-scsi+bounces-21175-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 26 Feb 2026 00:25:05 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C676F19ED03
	for <lists+linux-scsi@lfdr.de>; Thu, 26 Feb 2026 00:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65F2E306147A
	for <lists+linux-scsi@lfdr.de>; Wed, 25 Feb 2026 23:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E5D14BF97;
	Wed, 25 Feb 2026 23:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLkEhw4S"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527843815C1
	for <linux-scsi@vger.kernel.org>; Wed, 25 Feb 2026 23:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772061902; cv=none; b=h3S6DiPtwkZuAaajQbAoqPJCTIyIqRj7EozB+2kXwlDoJdBbZf3yhw30VJ5zuCVLcmRCtlBrvk7spgibzUybYbouDs6C1pFhjF0dw6MfApmdx/DNHKeYL566x320ai4MzmVj76KF8J7TIno3tncG5DhDijl0qv84UamxHTULf7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772061902; c=relaxed/simple;
	bh=pH1wrBe6e3TbwjVTT/McQkMfe3V+nWAcRZW7nEViai8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KtzVFFaB/onel9XrKFD1X0n1R6TsIi3DXiMbF5zWazRZMx4ehkqdlkt/MM1HE9zGb0g2ueiYSoBFJa8hJsrgMYVTMmfmyaHVxqoGTgxBnGWklTLDPlDKxfMHbgpP6+PKyO3acZaLSWpwIeMelQsao5rV4/mxguABROmO33usWR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLkEhw4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E84B9C19423
	for <linux-scsi@vger.kernel.org>; Wed, 25 Feb 2026 23:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772061901;
	bh=pH1wrBe6e3TbwjVTT/McQkMfe3V+nWAcRZW7nEViai8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bLkEhw4S8YbJPfggy97y8arrViEQN3gfeuIV//+JEWRHw56HMmzTyK6pUlWCySErA
	 zG/nA1SfaZ+HpaDVPIP3wMHAChMJAOw4n8+ytud5JltS3LAQGdr9757ipIom6byuva
	 iBVQFDZ5oSomnE3as09j0VXr1KxzD/5Roy7Af9DQSW8OOVmUuejdsUQ+Am2BmkHAXz
	 fPPGE2s1T2rdkz5JcA1lK3HN6YQnSu/37zLjR+5DeSJtIN2EU9zA9XeRkGoVWlMHBR
	 kwUZTVnzmnKQueW7JqUnZWtPeGsFuEfxv6hTBQZ0rX90swU885+kxWjru89jXgOHuf
	 bV1oZKhqBTczw==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E00DBC3279F; Wed, 25 Feb 2026 23:25:01 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-scsi@vger.kernel.org
Subject: [Bug 216696] Linux unusable upon plugging encrypted SanDisk Extreme
 55AE USB 3.0 SSD, causes xHCI controller crash and drops USB keyboard/mouse
Date: Wed, 25 Feb 2026 23:25:01 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: IO/Storage
X-Bugzilla-Component: SCSI
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: blocking
X-Bugzilla-Who: kylek389@gmail.com
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: linux-scsi@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-216696-11613-1X1SF2MZc4@https.bugzilla.kernel.org/>
In-Reply-To: <bug-216696-11613@https.bugzilla.kernel.org/>
References: <bug-216696-11613@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21175-lists,linux-scsi=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[bugzilla-daemon@kernel.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_ONE(0.00)[1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C676F19ED03
X-Rspamd-Action: no action

https://bugzilla.kernel.org/show_bug.cgi?id=3D216696

--- Comment #8 from Kamil Kaminski (kylek389@gmail.com) ---
Created attachment 309463
  --> https://bugzilla.kernel.org/attachment.cgi?id=3D309463&action=3Dedit
0000-cover-letter.patch

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=

