Return-Path: <linux-scsi+bounces-21851-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yL5XOh9qsWnsugIAu9opvQ
	(envelope-from <linux-scsi+bounces-21851-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 11 Mar 2026 14:11:59 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 842DE264343
	for <lists+linux-scsi@lfdr.de>; Wed, 11 Mar 2026 14:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 405623025E1F
	for <lists+linux-scsi@lfdr.de>; Wed, 11 Mar 2026 13:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F93A3016E3;
	Wed, 11 Mar 2026 13:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ttt/97pI"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E627D2E4257;
	Wed, 11 Mar 2026 13:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773234710; cv=none; b=CRZkrIbtI6FYrq5HZMrstVlC8ZbptnA1S/D4GKM/85uOiw/Y1tPnrCur8GFC3yqcts5clqCeSsOlE7NDOhMLkPyxdDj0/97dNyBtR2iVeoOsByA8wmzlcl9J+QuAfc5i0/1jCsEz+EwudA+2C9PAy2MInomk7e9pvqjMSYFS6Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773234710; c=relaxed/simple;
	bh=qPtMt/NDDpi3DbxzDPM6BCFcXuiXe2i5KCuPaNa5B+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5lusMxOxN0eDMoItQ3cBn+s+5sCnXHBJwGi5B4gj12feKD/PDL0D9oaUno+rptL7sbfJUCwUFH08T9wLdlco9No6wczJxSVvrkY5W0Qybq3zyn21vXK9b21n1n6kGhBtBfZZopTBrsd/o7r96lESb7i483FIeqeV8wEI9JXiLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ttt/97pI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DCFC4CEF7;
	Wed, 11 Mar 2026 13:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773234709;
	bh=qPtMt/NDDpi3DbxzDPM6BCFcXuiXe2i5KCuPaNa5B+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ttt/97pIEHQaV+021Sj8MuKvLia3b+6j+4auauCOYe8HSyBPTANWY33nHQgKMrGNJ
	 5dYc/d2nLfWHl5KNNYHUZu/WrO4MkwjLxdF/WyUzscd8+CIvl7OpkHPjuKbZqLEEIB
	 kSy/MBMn1XguE5oeSxYuQp23H6ER7Iwo4P/ltjDV3qo6HDUGAuLOnEkGLDZygFqB+r
	 wLgj0akn7WwzZ+q6mjKxU8U3epB9+K4T3pxU1Yn/PUSS323hjRR3zSbmZl88S3zqHK
	 oCC3cThbkYGdCpZHgADo9k2y2nBoZNrbREynxN7ASO7rhG0SK75ZMqi+q1GGEnBDR0
	 Jmig8zVnL5BxA==
Date: Wed, 11 Mar 2026 14:11:46 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add mphy reset to ufshc node
Message-ID: <20260311-rich-colorful-vicugna-abb4f7@quoll>
References: <1773193218-215988-1-git-send-email-shawn.lin@rock-chips.com>
 <1773193218-215988-3-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1773193218-215988-3-git-send-email-shawn.lin@rock-chips.com>
X-Rspamd-Queue-Id: 842DE264343
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21851-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rock-chips.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 11, 2026 at 09:40:18AM +0800, Shawn Lin wrote:
> Add mphy reset to ufshc node to fully reset the whole UFS blocks
> if needed. Otherwise, it may occasionally prevent the UFS controller
> from successfully linking up with the device.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 

You must not combine DTS changes with patchset targetting SCSI/UFS,
because they apply entire set and this DTS CANNOT go there.

NAK

Best regards,
Krzysztof


