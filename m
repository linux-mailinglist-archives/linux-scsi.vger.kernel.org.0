Return-Path: <linux-scsi+bounces-24472-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7MRUNAhnImqVWgEAu9opvQ
	(envelope-from <linux-scsi+bounces-24472-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 05 Jun 2026 08:04:56 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4317F645644
	for <lists+linux-scsi@lfdr.de>; Fri, 05 Jun 2026 08:04:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=kolumbus.fi header.s=elisa1 header.b="h87oJ/il";
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24472-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24472-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=kolumbus.fi (policy=quarantine);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25F473042F1C
	for <lists+linux-scsi@lfdr.de>; Fri,  5 Jun 2026 06:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7556E3F0AB8;
	Fri,  5 Jun 2026 06:00:03 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from fgw22-4.mail.saunalahti.fi (fgw22-4.mail.saunalahti.fi [62.142.5.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C960B3672A2
	for <linux-scsi@vger.kernel.org>; Fri,  5 Jun 2026 05:59:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780639202; cv=none; b=Y2NWnINHyxjHqsy9R0mNqsq1JtvTBlzp1wkPUAKywQqaHhtz4bxyVPkesZHrGuiTBjObMvKm1pyjFof8JnV1El2OltOYeBS6VsOqsLuOOQZD5pMcXo5myzlx4K6CWxTNMurH+XKWxFHdBS0fHA/vGksOnZrRjPx/FApRyrxy0tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780639202; c=relaxed/simple;
	bh=wIt2BIIvEZYEQNyARMvbAAeSVcMVm+CWy2lcBwf10eg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GhkxT4eSGfZd1xCrdu+nNW22D8SvB15pPOp13SF3AxEFgW0cc20Uhfh5KrU+7buiTDA0IjOTfPM3MPw6c2mttzrWE3SxTRURCr8hoaAZaDgI8W/t56QrztCw3IUhApKRQCfkgyWW5B+1XwGveEiHi+zjg+uQHjF+mL15tMc8uWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kolumbus.fi; spf=pass smtp.mailfrom=kolumbus.fi; dkim=pass (2048-bit key) header.d=kolumbus.fi header.i=@kolumbus.fi header.b=h87oJ/il; arc=none smtp.client-ip=62.142.5.109
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kolumbus.fi; s=elisa1;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from:to:cc:reply-to:subject:date:in-reply-to:
	 references:list-archive:list-subscribe:list-unsubscribe:content-type:
	 content-transfer-encoding:message-id;
	bh=Dd62zMhOx1L1LDLnprRZRcjVyhtsaKK1HG4aQQ+k9gs=;
	b=h87oJ/ilW0KNBI9Rifh/EHLpExCvrv7VWhDLoSwh3mCiD6+wWv0WCErNhCy8mQ4p1Q597TsuNWCXa
	 RI9kmOs1+Ck/PCPg3P8k/2fI3fMGjSVIak9Mbnma+hiEc9Cv6L/q9mpEGj45Y97aj27no4JLA1AQeg
	 yIGmmyEBg7ZHVpiqBUpwRVh11h/Q9MBKRTsNg0DlCdWQPUwKLn1R7QKnM2zNBxP2AICk5h4o78Ad1e
	 s4KHcgiY8tfDVq7W8JfQ2AFuajFG1AHrE7go9NxscSNIVIJj8HJOeBlSymjsmOkeKSvYls4HhC5r4y
	 hC4MNebNyxxbu5NMbf/40gNVcGnvLGQ==
Received: from smtpclient.apple (91-158-174-119.elisa-laajakaista.fi [91.158.174.119])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTPSA
	id c58cb440-60a3-11f1-8e05-005056bdf889;
	Fri, 05 Jun 2026 08:59:55 +0300 (EEST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH v3] scsi: scsi_debug: fix one-partition tape setup bounds
From: =?utf-8?B?IkthaSBNw6RraXNhcmEgKEtvbHVtYnVzKSI=?= <kai.makisara@kolumbus.fi>
In-Reply-To: <20260604234724.1936118-1-sam.moelius@trailofbits.com>
Date: Fri, 5 Jun 2026 08:59:43 +0300
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "open list:SCSI SUBSYSTEM" <linux-scsi@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A287E87F-0A9B-46CA-94AF-6ABF1FAE44B9@kolumbus.fi>
References: <20260604234724.1936118-1-sam.moelius@trailofbits.com>
To: Samuel Moelius <sam.moelius@trailofbits.com>
X-Mailer: Apple Mail (2.3864.600.51.1.1)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[kolumbus.fi : SPF not aligned (relaxed),quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[kolumbus.fi:s=elisa1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-24472-lists,linux-scsi=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kai.makisara@kolumbus.fi,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sam.moelius@trailofbits.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kolumbus.fi:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kolumbus.fi:mid,kolumbus.fi:from_mime,kolumbus.fi:email,trailofbits.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4317F645644



> On 5. Jun 2026, at 2.43, Samuel Moelius <sam.moelius@trailofbits.com> =
wrote:
>=20
> The tape setup path uses one tape_block entry as the end-of-data =
marker
> after the usable tape blocks. For the one-partition layout, partition =
0
> uses all TAPE_UNITS data slots and partition 1's marker is written at
> tape_blocks[0] + TAPE_UNITS.
>=20
> Only TAPE_UNITS entries are allocated, so that marker write is one
> element past the allocation during device initialization before any
> command is issued.
>=20
> Allocate one extra tape_block entry for the marker. This keeps the
> existing partitioning paths unchanged while providing backing storage =
for
> the sentinel.
>=20
> Assisted-by: Codex:gpt-5.5-cyber-preview
> Signed-off-by: Samuel Moelius <sam.moelius@trailofbits.com>
> ---
> Changes in v3
>  - Use TAPE_UNITS + 1 approach

Reviewed-by: Kai M=C3=A4kisara <Kai.Makisara@kolumbus.fi =
<mailto:Kai.Makisara@kolumbus.fi>>

Thanks, Kai


