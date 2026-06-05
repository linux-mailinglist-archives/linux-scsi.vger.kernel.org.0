Return-Path: <linux-scsi+bounces-24478-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e0FsOkHBImrtdAEAu9opvQ
	(envelope-from <linux-scsi+bounces-24478-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 05 Jun 2026 14:29:53 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0780364825D
	for <lists+linux-scsi@lfdr.de>; Fri, 05 Jun 2026 14:29:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yCehv5LN;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wEFuP1Xr;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="mh4pn/PK";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7vX3p03a;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24478-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24478-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=suse.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A6713066799
	for <lists+linux-scsi@lfdr.de>; Fri,  5 Jun 2026 12:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB9E4DBD8A;
	Fri,  5 Jun 2026 12:20:42 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C588F4DBD7E
	for <linux-scsi@vger.kernel.org>; Fri,  5 Jun 2026 12:20:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780662042; cv=none; b=BoDtraYhrJsa5xYsomsoq5Qc/27bH7RzyJDlJ+WcHd+CGcih83cFxxvwI08mFacjPhyS355rur22e3/PergcqheMtzWPwK+b9hG3xQIqJnF4nTuDzcL6uRTDHL1iyR0cTCGGtcGeDg698Z+6LCabCCJHv9xWDoPdYhf0WvyVGtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780662042; c=relaxed/simple;
	bh=s8X7fJfPvizaaVh2vOxC+h8NT8FVP31inxzVhmh4jJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ve3BSRUZbDzPNN7MLDWUTl68Yo1tSV9VtSv2RUu/UH/ESmJjWpZ+o/X4P1+umOi52c9z1p0ZJdeCWFP+12HSa5DjeNzMaNRJCzYMltnam/k7NvPz17U7T9d4NTljMQcK/sf3XvqD886DDMy8m4zwjhz7ckD4eOEyEXCPkRtw2Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yCehv5LN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wEFuP1Xr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mh4pn/PK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7vX3p03a; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E404F6B352;
	Fri,  5 Jun 2026 12:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780662039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tQmlwYZpK/2REB82M47t3qVpY2ASY84RmO8x/TiRH3o=;
	b=yCehv5LN1qr7JfW1xSp+Av5mRYsQZZr/6NlrZCIv9UXv33Wtf57Rbq6M0N+Gl7BDGvOgMO
	e/ymlaInrGe9L9XDLi7hUUOlfSsljjqtLOfgTSW6vuT/pbqAewQRSjYSmr/Q1aQyEXdecM
	nWFI7hqbIehTiRLfjPK3Eny1653u/3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780662039;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tQmlwYZpK/2REB82M47t3qVpY2ASY84RmO8x/TiRH3o=;
	b=wEFuP1Xr9Vb/xErQKVKdO3UwlFV25gf+eJ1DWIucxkBcPEH2AtnPLz1vqTsyxmho00Jlyy
	D4JUtTvcXmpibACQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780662037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tQmlwYZpK/2REB82M47t3qVpY2ASY84RmO8x/TiRH3o=;
	b=mh4pn/PKaH7R4T0EQWGmlVEf0cbZXY3ZzRcabqt8REJrwxrxgFWzdqblEWXsxti2aTRHZm
	/JkQCduDwBqjw7YsBjUFOGR5wphdDLmd3lLIjD/27IQVieijc990+5+mom1jwZG2ds7LCq
	mu4OYQT3UWdxV9oJBbkLxxCd/iH1HqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780662037;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tQmlwYZpK/2REB82M47t3qVpY2ASY84RmO8x/TiRH3o=;
	b=7vX3p03ad+AkMGKZcaOzegppj00KHAxFUoIxJrfmgdEWnsYC5+gY0NpwkfC86hanHkxGji
	MbdZdArA9nnJ2dCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA818779A8;
	Fri,  5 Jun 2026 12:20:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y0CfHBS/Imr3TwAAD6G6ig
	(envelope-from <ddiss@suse.de>); Fri, 05 Jun 2026 12:20:36 +0000
From: David Disseldorp <ddiss@suse.de>
To: target-devel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Subject: [PATCH 0/2] scsi: target: minor CHAP fixes
Date: Fri,  5 Jun 2026 22:16:46 +1000
Message-ID: <20260605122019.24146-1-ddiss@suse.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-24478-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:from_mime,suse.de:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0780364825D

These patches resolve a couple of other issues pointed out by the
sashiko bot when reviewing a separate CHAP change:
https://sashiko.dev/#/patchset/20260521151121.808477-1-hossu.alexandru%40gmail.com

Hexadecimal CHAP_I handling appears to have been broken for over a
decade, so another option might be to pull out support for such encoded
values.

----------------------------------------------------------------
David Disseldorp (2):
      scsi: target: fix hexadecimal CHAP_I handling
      scsi: target: use constant-time crypto_memneq for CHAP digests

 drivers/target/iscsi/iscsi_target_auth.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

