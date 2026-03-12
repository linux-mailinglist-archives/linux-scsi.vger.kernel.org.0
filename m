Return-Path: <linux-scsi+bounces-21917-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCktIi//smmQRQAAu9opvQ
	(envelope-from <linux-scsi+bounces-21917-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Mar 2026 19:00:15 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D1D276EE3
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Mar 2026 19:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53AD6319B679
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Mar 2026 17:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F513FEB05;
	Thu, 12 Mar 2026 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hE8pKgrb"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A8E3FE66E;
	Thu, 12 Mar 2026 17:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773338222; cv=none; b=S9jkeltGSYeBBOqf8WFl/0bhH4/aQy4D1X4mZajfhEkv2CZaHwEe4YBqv+PGacmA8C/KT+giGtNQ+dPP9UAhAd72Dy/RvxT9huI6GPW8hY7iYmmJ6p6mvjUXmmiXDS2xOguU2++c4JefNbIYAzdDFY6kyQBGTUXoAWB5BDK/fIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773338222; c=relaxed/simple;
	bh=n8tbDoaegI9nZrcwUj1qP9UTA3xZzlsGFevGXWPREIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6e7ab81VmRM8iAZXrljC/2tlBPnMcUbi13G2o0dDfbQoyaCjIKM0oz/8HO1dJXTNSrfSh9tDekOtRU2OhghE4pzY270SLISUBGvPRxgLz/iZrX+FmB/av5DFQt8Do9WlfxRS1YbdSyn7v/Fqv7wJ07vGHsKWiCzABHVnbJGixg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hE8pKgrb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69BC5C4CEF7;
	Thu, 12 Mar 2026 17:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773338221;
	bh=n8tbDoaegI9nZrcwUj1qP9UTA3xZzlsGFevGXWPREIA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hE8pKgrbVvgKUy70OM/dwNRdNFcsAr3w1fRIFXZJ+nYRusrZLimTHtDcUUr4tPP6L
	 7BiWK20rDWZBFgEFkctsfFypMVlvIo3FlDhLUCEhOxkW2h0CHmvXhjhT7dXRXemXki
	 CAd3rRNRGPwElaVvy2ximO9No3pNC1PVtsN6HRmJ6d94jA6inS6ppmADy5pbbxiJDx
	 zrKvP68qJneVUbU+Kyprtj95f4aqy/rOhCy6yqKWpdeQYI8fOOhBN/yHeaP4J1AnvE
	 Vh67CZq+Utw4srWPEFVustMuQDdGVeOr6DTRWxQua69Fmcrje56nB7LRK2iFw59dxe
	 v4SbyaDhezx/g==
Date: Thu, 12 Mar 2026 17:56:57 +0000
From: Conor Dooley <conor@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] scsi: ufs: drockchip,rk3576-ufshc: dt-bindings: Add
 new mphy reset item
Message-ID: <20260312-twister-going-dffa25440fe8@spud>
References: <1773276707-24857-1-git-send-email-shawn.lin@rock-chips.com>
 <b9024d90-6df7-4a2c-85fe-7f5178e7d1cf@acm.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tHJwJyPGKV9Baxma"
Content-Disposition: inline
In-Reply-To: <b9024d90-6df7-4a2c-85fe-7f5178e7d1cf@acm.org>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21917-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi,dt];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E5D1D276EE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--tHJwJyPGKV9Baxma
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 07:27:37AM -0700, Bart Van Assche wrote:
>=20
> On 3/11/26 5:51 PM, Shawn Lin wrote:
> > Add the mphy reset property to the devicetree bindings for the Rockchip
> > RK3576 UFS host controller. The mphy reset signal is used to reset the
> > physical adapter. Resetting other components while leaving the mphy
> > unreset may occasionally prevent the UFS controller from successfully
> > linking up with the device.
>=20
> I see "drockchip" in the patch subject instead of "rockchip". Is that
> perhaps a typo?
>=20
The whole $subject is a bit of a mess I feel. "scsi: ufs: dt-bindings"
is fine, a few subsystems use that instead of "dt-bindings: scsi: ufs",
but putting the compatible/filename before "dt-bindings:" is not right.


--tHJwJyPGKV9Baxma
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCabL+aQAKCRB4tDGHoIJi
0trDAQDpMPE/2K3nkbJwA4CqqvVfyBPfDW2OEaSNZpABGF442wD/arcdxkDxcf48
URc8etfB/a+yIM/265RQOAyx87Qrowo=
=Owlm
-----END PGP SIGNATURE-----

--tHJwJyPGKV9Baxma--

