Return-Path: <linux-scsi+bounces-25605-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dA+yFZvmSGp6vAAAu9opvQ
	(envelope-from <linux-scsi+bounces-25605-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Sat, 04 Jul 2026 12:55:23 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 552857075ED
	for <lists+linux-scsi@lfdr.de>; Sat, 04 Jul 2026 12:55:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=kolumbus.fi header.s=elisa1 header.b=grArjoOX;
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=kolumbus.fi (policy=quarantine);
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25605-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25605-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=reject ("signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAFBB301572E
	for <lists+linux-scsi@lfdr.de>; Sat,  4 Jul 2026 10:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B745385D84;
	Sat,  4 Jul 2026 10:55:20 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from fgw23-4.mail.saunalahti.fi (fgw23-4.mail.saunalahti.fi [62.142.5.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBF6433E8C
	for <linux-scsi@vger.kernel.org>; Sat,  4 Jul 2026 10:55:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783162520; cv=none; b=cA+YA/j6IoaIlNEnGDGG3NvF4FrHF1xR9N6YStLp/lFoU3Z366EmszN+9M5yaCPiJ7EcLn3mlGZQxUrgkkQ4QLoNA2N+IFuVhLXRTEiS3UXCJLzY6/kmA8y19alLtOVVlE08hjjRcuonxehIH2MG1b1Kb8viLBDCul79mS5Uy6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783162520; c=relaxed/simple;
	bh=lj1D6n0ntrOE6DtRg8V0l8lmR0uUIhq5alUYbQxjFns=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BtwRkUP/4n/ecY+Y2LgDndfkLmqh4nV9rNIblItzCF41kxeN7UXlWt3sl6fLXrAOjLGDS1oAqDLjgNGWI0OyuUfXkBG5KnaQW2/1g95aJ7p0qhUEUemQPANMqvIFzdHyiP8Af80U/m2eySwBAJH3lINFju+/IY5U/i+m+r2np4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kolumbus.fi; spf=pass smtp.mailfrom=kolumbus.fi; dkim=pass (2048-bit key) header.d=kolumbus.fi header.i=@kolumbus.fi header.b=grArjoOX; arc=none smtp.client-ip=62.142.5.110
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kolumbus.fi; s=elisa1;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:feedback-id:from:to:cc:reply-to:subject:date:
	 in-reply-to:references:list-archive:list-subscribe:list-unsubscribe:
	 content-type:content-transfer-encoding:message-id;
	bh=lj1D6n0ntrOE6DtRg8V0l8lmR0uUIhq5alUYbQxjFns=;
	b=grArjoOXgyTcxVKM6ghIrm79456jRCtDUUpaJCBa5gbjF8bShCvUT7LVNLGM/jPPIlnUId3dIRRFT
	 hmIsAvVVHi2S4+Lgi/fpo7ARrLQCFff69/PeNDKmI1d81rYQwOMC+NOFyAIkXMXonjRwK6CFd/YEUp
	 l8Mu/SIxqMtz/i88oVbX0d6Ty08lI9jiTNRyY56X0OS/OF3rgJ1PA940T60exUlQp1bHXiotpC2G/N
	 nWXYQO8DeZzv4Qndgn6xvXHof+8G+1CoUg2qJ0CwucPYKdlY+FNQts+ZH1hX2U9vlrneGsHiT7eIN4
	 wEuW1pf7MhtKYA73dczUZIaFTDNBB1w==
Feedback-ID: 5c3835a5:3ccff4:smtpa:elisa
Received: from smtpclient.apple (91-158-174-119.elisa-laajakaista.fi [91.158.174.119])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTPSA
	id d0c312a2-7796-11f1-952d-005056bd6ce9;
	Sat, 04 Jul 2026 13:55:06 +0300 (EEST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCHv2] scsi: st: use kzalloc_array()
From: =?utf-8?B?IkthaSBNw6RraXNhcmEgKEtvbHVtYnVzKSI=?= <kai.makisara@kolumbus.fi>
In-Reply-To: <20260703215345.253901-1-rosenp@gmail.com>
Date: Sat, 4 Jul 2026 13:54:55 +0300
Cc: linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other  areas):Keyword:b__counted_by(_le|_be|_ptr)?b <linux-hardening"@vger.kernel.org (ope>)
Content-Transfer-Encoding: quoted-printable
Message-Id: <129AD05F-52C8-4A24-9813-51A7BA4E7043@kolumbus.fi>
References: <20260703215345.253901-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[kolumbus.fi : SPF not aligned (relaxed),quarantine];
	R_DKIM_REJECT(1.00)[kolumbus.fi:s=elisa1];
	ARC_REJECT(1.00)[signature check failed: fail, {[1] = sig:subspace.kernel.org:reject}];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-25605-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[kai.makisara@kolumbus.fi,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-hardening@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:linux-kernel@vger.kernel.org,m:@vger.kernel.org ,m:rosenp@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kolumbus.fi:-];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kai.makisara@kolumbus.fi,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 552857075ED

On 4. Jul 2026, at 0.53, Rosen Penev <rosenp@gmail.com> wrote:
>=20
> Merge allocations to simpily memory management with kzalloc_array(). =
No
> need to kfree separately.
>=20
I fail to see what is the real problem this patch fixes? I am not in =
favor of rewiritng working code
just because it can be done.


