Return-Path: <linux-scsi+bounces-24372-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T6TWI7nGHmr5UwAAu9opvQ
	(envelope-from <linux-scsi+bounces-24372-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 02 Jun 2026 14:04:09 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE7F62DCE5
	for <lists+linux-scsi@lfdr.de>; Tue, 02 Jun 2026 14:04:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=X89mYCAy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="8bUhL/MX";
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EvLfPknn;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3Ts8eAl7;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24372-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24372-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86372301AA7E
	for <lists+linux-scsi@lfdr.de>; Tue,  2 Jun 2026 11:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1E63939B5;
	Tue,  2 Jun 2026 11:59:04 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC52A378D74
	for <linux-scsi@vger.kernel.org>; Tue,  2 Jun 2026 11:59:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780401544; cv=none; b=iQjX3viWYFZoBdpEbLPOIDtIKpYm4rv2G4ss5Kr/3WpW7OqC8bywkarFwtu6weRwA3djNLb6P2lp3dvbGutqkdIWegVHQJ7wL8LTTyGGOpdKQ43cDpm8THvYmKTag7qxhpy3zWNmJ2YLZRTp+rQIzZN2rB8qR57gRhQwL9wmp5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780401544; c=relaxed/simple;
	bh=MM2qSn9gpWfxRLXOEVLvuOaUdZ7iwZYANO1cAWdPEoI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B2uUgjmLNLjenZQO4y9y1FuXDrMKGtgnejInZ8rMYfpm9TnyQQY8T3jldoGtCSs8KHwtzuGNVARBBrmkD4ZhfOV4BU8bgOdJs1yCT89eccdw93tY6F9IZGlAcffqOWfREAj36uuXg9y8U3g42eaO68XRd3HRaGquTxtcpwiGbuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X89mYCAy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8bUhL/MX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EvLfPknn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3Ts8eAl7; arc=none smtp.client-ip=195.135.223.131
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F12636814D;
	Tue,  2 Jun 2026 11:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780401540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AvUNf0GpbjtAaTVlupRs1LvbrUSj1uvZ3+UYsgsO3SQ=;
	b=X89mYCAyX9APqTCCHdtwfc2Zw/lKjhA0sBjdLWPJbkRNaRURBz9+jeVh5MjINw0H9G9cuW
	cOuuegqxQkgkTHaL+H499Hzzvc3/P/6/dkyrQdvntsICottHziYe1roC7WB/k0NJZ16C4r
	0afCTxKFC+EC+HuxuE5Xe/G8Esn/QXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780401540;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AvUNf0GpbjtAaTVlupRs1LvbrUSj1uvZ3+UYsgsO3SQ=;
	b=8bUhL/MXMotoMXZumSkG0kHdtBXsmPGwFmx80le66MYl/gpjJoRZzEW2k4xws4KT2yaZ/o
	5WeNOn6RK3ceMLBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780401538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AvUNf0GpbjtAaTVlupRs1LvbrUSj1uvZ3+UYsgsO3SQ=;
	b=EvLfPknnIoWm1yFLrNQNPKcFmwpqGUOcXCRh/Onol3U9GuJPHbK2aKJea8jCsS2yXSzQvy
	lXoZnkmJMBCE8kt8StFMvFNpoI/EM4nse2RWwQF7mgZYDH0uvIq7Te4dfBINPnsD9qBoL2
	IraRvYuLk0oeRvFO6HOfW5tbKac0TOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780401538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=AvUNf0GpbjtAaTVlupRs1LvbrUSj1uvZ3+UYsgsO3SQ=;
	b=3Ts8eAl72kumm5BPzllnlKwWb1Vapgd8CmEHsdeK/iHok4i1YqUNcLgtgpohq28QWkFnkZ
	4zR8XH/iab7cMhCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF260779A7;
	Tue,  2 Jun 2026 11:58:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gdfoIYHFHmpvYQAAD6G6ig
	(envelope-from <ddiss@suse.de>); Tue, 02 Jun 2026 11:58:57 +0000
From: David Disseldorp <ddiss@suse.de>
To: target-devel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Subject: [PATCH 0/2] scsi: target: fix CHAP_N handling
Date: Tue,  2 Jun 2026 21:43:56 +1000
Message-ID: <20260602115840.26490-1-ddiss@suse.de>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-24372-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:target-devel@vger.kernel.org,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[ddiss@suse.de,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ddiss@suse.de,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.de:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url,suse.de:mid,suse.de:from_mime,suse.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DCE7F62DCE5

The sashiko bot pointed out issues with CHAP_N handling recently, when
reviewing a patch for a separate issue:
https://sashiko.dev/#/patchset/20260521151121.808477-1-hossu.alexandru%40gmail.com
  Since extract_param() unconditionally strips '0x' or '0b' prefixes and
  alters the returned type, wouldn't a valid user with a name like '0xalice' or
  '0bob' have their username mutated to 'alice' or 'ob'?

I believe this behaviour is contrary to the iSCSI spec. I added some simple
libiscsi tests to cover prefix stripping:
https://github.com/sahlberg/libiscsi/pull/472

These patches attempt to fix CHAP_N handling.

----------------------------------------------------------------
David Disseldorp (2):
      scsi: target: add extract_param_str() helper
      scsi: target: fix auth when CHAP_N carries a hex/b64 prefix

 drivers/target/iscsi/iscsi_target_auth.c |  8 ++---
 drivers/target/iscsi/iscsi_target_nego.c | 37 ++++++++++++++++++++++++
 drivers/target/iscsi/iscsi_target_nego.h |  1 +
 3 files changed, 40 insertions(+), 6 deletions(-)


