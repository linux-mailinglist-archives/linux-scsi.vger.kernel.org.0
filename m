Return-Path: <linux-scsi+bounces-25934-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ggDZDDbiT2rbpgIAu9opvQ
	(envelope-from <linux-scsi+bounces-25934-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 09 Jul 2026 20:02:30 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4E273418B
	for <lists+linux-scsi@lfdr.de>; Thu, 09 Jul 2026 20:02:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ckiAO0CM;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25934-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25934-lists+linux-scsi=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 28E003022B58
	for <lists+linux-scsi@lfdr.de>; Thu,  9 Jul 2026 18:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0609B4195D9;
	Thu,  9 Jul 2026 18:02:27 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96312E7631;
	Thu,  9 Jul 2026 18:02:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783620146; cv=none; b=f8MBZQaaslBjF1O5YQ8WvaCRQU/vv0fxS731Ee/9hMtFWWADLZbcxSwSCGkSjkLNRkXgjVx2mZHoSsjbvQYaafHybgyKgiglcsUW7/ZJOc3xPLGX2BQPhAvXtspjmRp6XHXEtzuR5d5QzDSEibhAozEQoCnEoDUO0D8USkq2IYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783620146; c=relaxed/simple;
	bh=3JKMImIJOW7Hv8YZzxXH5eOwauiI5rKVkw77jtIHJVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVDy4F20CAKX6RDq2vHLM+XRmU1hkCKX+nA56ng/UCB0eBR2XOt4fNwB1mAL0dOMM0t2eaFzIALKQRGCBg/BWfxF/snEwCp6wOjDAl/M7Gagde4j++B7WcEypcuCuPydGKTjCbONBW/88wnbAvrF7gT6JZTvTrCUEDupCNlVou8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckiAO0CM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F75B1F000E9;
	Thu,  9 Jul 2026 18:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783620145;
	bh=3JKMImIJOW7Hv8YZzxXH5eOwauiI5rKVkw77jtIHJVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ckiAO0CMP2g2EJ8Og6NKviCbMatMGSyOlaete6+WyWklHu3SUujoF0HzW+A9v5AJe
	 W2qRSFEbngCKuKNTXG2pT26cqJBzu3XVl/Sn9K9QcsCbm9HV58zfHXSU+vA7QaTzlG
	 DSNYnajzJwiEktSLZ1ZCylHXsfAoS1ncco2GAV2889Coo0YwePN5sdT9TVlyq0N0ni
	 HUsbhC5MS0kkD5cfRWfOYVQ1BY+96lbBzuwNvXKxrKE9lXif12eNppfa4XbzA5t7Xe
	 r9chtn6Vr8w+fiRpzxYJSAIjSXxk+VbIr+sffJ0KMRnkANBtTiu268BsNl93EY4fL4
	 BhznfKQdi330Q==
Date: Thu, 9 Jul 2026 20:02:21 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
Subject: Re: [PATCH v1 1/2] ata: libata-scsi: terminate deferred commands on
 time out
Message-ID: <ak_iLVzMFBgqI7Av@fedora>
References: <20260709083934.1116862-1-dlemoal@kernel.org>
 <20260709083934.1116862-2-dlemoal@kernel.org>
 <20260709090006.F317F1F00A3A@smtp.kernel.org>
 <dcc4f558-7b6e-4193-a943-036255fc202f@kernel.org>
 <ak_gsY5YvMBC-0M_@fedora>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak_gsY5YvMBC-0M_@fedora>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dlemoal@kernel.org,m:sashiko-reviews@lists.linux.dev,m:linux-ide@vger.kernel.org,m:linux-scsi@vger.kernel.org,m:ipylypiv@google.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[cassel@kernel.org,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-25934-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassel@kernel.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,fedora:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8B4E273418B

On Thu, Jul 09, 2026 at 07:56:06PM +0200, Niklas Cassel wrote:
> If scmd != the deferred QC, continue to set DID_REQUEUE and return
> SCSI_EH_NOT_HANDLED.

Just to clarify:

If scmd != the deferred QC, continue to set DID_REQUEUE on the deferred QC,
and return SCSI_EH_NOT_HANDLED, since we did not touch scmd.


Kind regards,
Niklas

