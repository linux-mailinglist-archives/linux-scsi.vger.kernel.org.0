Return-Path: <linux-scsi+bounces-24170-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMiWFMxvF2pDFAgAu9opvQ
	(envelope-from <linux-scsi+bounces-24170-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 28 May 2026 00:27:24 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A89DE5EAA8E
	for <lists+linux-scsi@lfdr.de>; Thu, 28 May 2026 00:27:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 930013055EBD
	for <lists+linux-scsi@lfdr.de>; Wed, 27 May 2026 22:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01B639891E;
	Wed, 27 May 2026 22:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=wtlc.com.tw header.i=@wtlc.com.tw header.b="I6b19uEZ"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail.wtlc.com.tw (mail.wtlc.com.tw [220.130.222.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B2336728F
	for <linux-scsi@vger.kernel.org>; Wed, 27 May 2026 22:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.222.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779920409; cv=none; b=tNbcc1f7xdUtNu2csp2Jrakg+qddsbpqgZ3jiU+Tc8q24vj0QWjU2kkJkHDtddkuyQREUcHF9YiSGMly+CPORcgsQsQbEUpEyj24w8EDM4CeyNpOwRlPNknnPUYsf70w7SjuGDbMsNZkE/AbRTN2ayIYdtg1mWxviEK8YnacGN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779920409; c=relaxed/simple;
	bh=LgxS7OWn5hlGE+z98YMrYTONUnz3nA6U816PuhUy1hA=;
	h=MIME-Version:Date:Message-ID:Content-Type:Subject:From:To; b=okaiw2peS6VWCr/2bFjgClekHuY945vun4i/he62+6jkinSEdirIH6u3p8bFgwfhQc9ei6hvqm9bn9TXTkFHd4AUi/NoXpenil5ikdZADtrRZ92Tgp9A/HUzkNNAVgUBLzzdIg6V6U22JUhM5fhMk9sAUDMf573KSB2OPATOsaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wtlc.com.tw; spf=pass smtp.mailfrom=wtlc.com.tw; dkim=fail (0-bit key) header.d=wtlc.com.tw header.i=@wtlc.com.tw header.b=I6b19uEZ reason="key not found in DNS"; arc=none smtp.client-ip=220.130.222.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wtlc.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wtlc.com.tw
Received: from localhost (localhost [127.0.0.1])
	by mail.wtlc.com.tw (Postfix) with ESMTP id 9E3A81A1BD1
	for <linux-scsi@vger.kernel.org>; Thu, 28 May 2026 06:14:11 +0800 (CST)
Received: from mail.wtlc.com.tw ([127.0.0.1])
	by localhost (mail.wtlc.com.tw [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id YdKbpx3sGinR for <linux-scsi@vger.kernel.org>;
	Thu, 28 May 2026 06:14:11 +0800 (CST)
Received: from localhost (localhost [127.0.0.1])
	by mail.wtlc.com.tw (Postfix) with ESMTP id 377CF1A1BCF
	for <linux-scsi@vger.kernel.org>; Thu, 28 May 2026 06:14:11 +0800 (CST)
DKIM-Filter: OpenDKIM Filter v2.9.2 mail.wtlc.com.tw 377CF1A1BCF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wtlc.com.tw;
	s=default; t=1779920051;
	bh=LgxS7OWn5hlGE+z98YMrYTONUnz3nA6U816PuhUy1hA=;
	h=MIME-Version:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:Subject:From:Reply-To:To;
	b=I6b19uEZarIVIw3ntUONt8BSwwoL2tyHnrptqhg1tHz+s4Xg8nJWtEarEa/7Zf5I+
	 7VXLBH5vogJMEc4azfUkIul4fqKASoOmiPYqK96dnyxOZMMGGBUM1PKzbwunNYpcah
	 tLCzPbDw3M2vlJwhbgm1l/P4q+g+MqsRo48oEWvE=
X-Virus-Scanned: amavisd-new at wtlc.com.tw
Received: from mail.wtlc.com.tw ([127.0.0.1])
	by localhost (mail.wtlc.com.tw [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id A4ieYLr98Hoa for <linux-scsi@vger.kernel.org>;
	Thu, 28 May 2026 06:14:11 +0800 (CST)
Received: from DESKTOP-F55A126 (unknown [154.160.53.5])
	by mail.wtlc.com.tw (Postfix) with ESMTPSA id A7E201A1BCC
	for <linux-scsi@vger.kernel.org>; Thu, 28 May 2026 06:14:10 +0800 (CST)
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 27 May 2026 22:15:11 +0000
Message-ID: <4A05F7E076B3F839DDA45868379D5CCDCF62833C@DESKTOP0F55A126>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Priority: 3 (Normal)
Subject: Ich bin Dr. Noah.
From: "Dr. Noah Jang" <cccjohn@wtlc.com.tw>
Reply-To: drnoahjang@hotmail.com
To: linux-scsi@vger.kernel.org
X-Spamd-Result: default: False [5.81 / 15.00];
	FREEMAIL_REPLYTO_NEQ_FROM(2.00)[];
	REPLYTO_EMAIL_HAS_TITLE(2.00)[];
	R_MIXED_CHARSET(1.67)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FROM_NAME_HAS_TITLE(1.00)[dr];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[wtlc.com.tw : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24170-lists,linux-scsi=lfdr.de];
	HAS_X_PRIO_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_SPAM(0.00)[0.558];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_REPLYTO(0.00)[hotmail.com];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[wtlc.com.tw:~];
	R_DKIM_PERMFAIL(0.00)[wtlc.com.tw:s=default];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cccjohn@wtlc.com.tw,linux-scsi@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	SINGLE_SHORT_PART(0.00)[];
	HAS_REPLYTO(0.00)[drnoahjang@hotmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: A89DE5EAA8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Wir m=C3=BCssen reden.

