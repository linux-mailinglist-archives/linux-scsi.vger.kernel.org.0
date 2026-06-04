Return-Path: <linux-scsi+bounces-24439-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H+9+JEqWIWq9JQEAu9opvQ
	(envelope-from <linux-scsi+bounces-24439-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 04 Jun 2026 17:14:18 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D30536414C3
	for <lists+linux-scsi@lfdr.de>; Thu, 04 Jun 2026 17:14:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=kolumbus.fi header.s=elisa1 header.b=C0whtHZV;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24439-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24439-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=kolumbus.fi (policy=quarantine);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD52C302E7A6
	for <lists+linux-scsi@lfdr.de>; Thu,  4 Jun 2026 14:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1EA2F1FD7;
	Thu,  4 Jun 2026 14:52:26 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from fgw22-4.mail.saunalahti.fi (fgw22-4.mail.saunalahti.fi [62.142.5.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4914D24E4C6
	for <linux-scsi@vger.kernel.org>; Thu,  4 Jun 2026 14:52:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780584745; cv=none; b=g0qOSZGq4vjkqj38e7MOJEMT5E2vMiK6SesOGb3Ta+sx8LJmCSJ13bl1AaER4l7X+wUyBuESPQm/oSCNkANZFw99SgaRkcpUj0AKSy7U2oS4SfIIgEOWWhGRMXXDwWUo8WTlujp6OCAkWCHT8G+26qNbWT41sp+sNhaALMwusCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780584745; c=relaxed/simple;
	bh=N69ZInEW9MnggYul11YXRqPBun7ZUJrTTxxCh7PtnuY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ZOPJ+G/fh2vnqr0BR7nQi3Tg4QvrizMxnx51QNtwGT7ugZjvDP0+Hj3bUkZC/7yE3GT3pgHr0w3/DGY2SZKpv0XT0D3CbpK4DS8iGGy7eY6BtdVwfDgteibB4RzjdizjATRHEeeIy/5srOeN7hazYKdVcOFaZWPHpySAzcv+R3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kolumbus.fi; spf=pass smtp.mailfrom=kolumbus.fi; dkim=pass (2048-bit key) header.d=kolumbus.fi header.i=@kolumbus.fi header.b=C0whtHZV; arc=none smtp.client-ip=62.142.5.109
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kolumbus.fi; s=elisa1;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from:to:cc:reply-to:subject:date:in-reply-to:
	 references:list-archive:list-subscribe:list-unsubscribe:content-type:
	 content-transfer-encoding:message-id;
	bh=rmca71mPYSJni2uXkB76ddDE8aYug8m2xcThobYjFmc=;
	b=C0whtHZVBcr6yfqyeAb+kxZruIXSSO4ncU1zYZu2VAZnGh5cYRoLQuZ2aZH9TwYLX43vnay8p6zxF
	 3pwvX6JV9WBshMj0NYH8wab5ZEAVkeHRegC1JF9cGNuRaWcxitaU6S6GzNHGdUepHmMWAIB09mOtx9
	 lvpmlskiYXUiBb2eT6lEWHN4lkcBvD70kxRjpfNKW0JWs95Q8a2EkLSNbXAlMzSwKyBtEQld9BQvDJ
	 gKf00zZxZDi3V5S3bNavxK56jUbVJVO8lg4PrDekOTPnwuid0Q/mwqstUnQAfxYjUSGo36HTp4j+jx
	 ttCPd15dUGSX8oynJG+rkXm9zs5FtJg==
Received: from smtpclient.apple (91-158-174-119.elisa-laajakaista.fi [91.158.174.119])
	by fgw21.mail.saunalahti.fi (Halon) with ESMTPSA
	id f75f473a-6024-11f1-aabd-005056bdd08f;
	Thu, 04 Jun 2026 17:52:12 +0300 (EEST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v2] scsi: scsi_debug: fix one-partition tape setup bounds
From: =?utf-8?B?IkthaSBNw6RraXNhcmEgKEtvbHVtYnVzKSI=?= <kai.makisara@kolumbus.fi>
In-Reply-To: <6d2e78e6a5840f5892e7eb081657b23aa62bc50d.camel@HansenPartnership.com>
Date: Thu, 4 Jun 2026 17:52:00 +0300
Cc: Samuel Moelius <sam.moelius@trailofbits.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8D712AEA-D91F-4A75-A7B3-FCF44F5823BF@kolumbus.fi>
References: <20260603235616.124535-1-sam.moelius@trailofbits.com>
 <6d2e78e6a5840f5892e7eb081657b23aa62bc50d.camel@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[kolumbus.fi : SPF not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[kolumbus.fi:s=elisa1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-24439-lists,linux-scsi=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kai.makisara@kolumbus.fi,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sam.moelius@trailofbits.com,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:James.Bottomley@HansenPartnership.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kolumbus.fi:-];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kai.makisara@kolumbus.fi,linux-scsi@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,hansenpartnership.com:email,kolumbus.fi:from_mime,kolumbus.fi:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D30536414C3



> On 4. Jun 2026, at 16.38, James Bottomley =
<James.Bottomley@HansenPartnership.com> wrote:
>=20
> On Wed, 2026-06-03 at 23:55 +0000, Samuel Moelius wrote:
>> The tape setup path writes partition metadata one element past the
>> allocated tape_blocks array when a one-partition configuration is
>> selected.
>>=20
>> That corrupts adjacent state during device initialization before any
>> command is issued.
>=20
> I still don't get what the actual problem is.  For a single partition
> tape I can't see where scsi_debug would actually do anything with
> tape_blocks[1].  What is it that you're seeing when using scsi_debug
> that motivates this?
>=20
The code marks partition 1 as EOD and does not corrupt anything. The =
tape has partitions
until either EOD partition is encountered or TAPE_MAX_PARTITIONS is =
reached. I would
be very hesitant to remove this initialization.

Thanks,
Kai


