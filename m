Return-Path: <linux-scsi+bounces-23200-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJBrGmvy6GkdRwIAu9opvQ
	(envelope-from <linux-scsi+bounces-23200-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Apr 2026 18:08:11 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C44D74483FD
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Apr 2026 18:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C203B302296D
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Apr 2026 16:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E0C322DB7;
	Wed, 22 Apr 2026 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qk/CmxwQ"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86916223DE7;
	Wed, 22 Apr 2026 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874081; cv=none; b=uaf1tUiGhODVjUMUamV0AM/vqBvZrUcBDb4TSZZT15HzlL034OMsfqS3i2pvgMTGvzd88ZBvCwUqxltwdgvRAsJC2ol5lLUkOOLRfyAWou93EpUiW0Y5Tdltnve0O1IHZCV5+80lxmq9DCMx3dgxEukxwVCOV/9Rc3spoIwhWO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874081; c=relaxed/simple;
	bh=VqHvIq4YLcnoBaLcjXcjBeQp30kEHXPChjhpfAKdOpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d0skVJJuR/kUYPy2GUW4JLjxIvmDePIVJHrfjGare/92axqp0Nsby16YPdqmSMUHM6KsppqnLCfyTqG5eKbm4z/hTYoMbqX8egXq1JELAxamm8IshrrgQJodrJMiA104NuWUsafXj9C7sUqmSKKGoZFmDmHKqk8PJMdDp2WHAm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qk/CmxwQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180D6C19425;
	Wed, 22 Apr 2026 16:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776874081;
	bh=VqHvIq4YLcnoBaLcjXcjBeQp30kEHXPChjhpfAKdOpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qk/CmxwQPVGiJz1nPNeqAAVdGUCrrg55svk0uUKzNz12MNEG7/AZR68ZsAxrz0RiB
	 xG/nfHSm74Q/VYtx0CLU4+SBmQOR1F1PO8SghTolQ5+jvMJRu/dTLKrSDgQMHNWewL
	 ihvmMrCftQxTPCMDJa+1gxxwZfyWbYWpBvUTx/WIQAXq0netbqr7Y8iorqMt4VIvPg
	 sz4GBtm+oO0Ho5ifi+tJgkaF+at7qZRr03bF0cJce59cIyl/7nRao1jnYY5u0db6Si
	 kh6fQTaR7zgka3vpi7gIHETOxDLimqqVNmgYF9xGgDUvdPQucADsXyO3xnIH6Mn2Nw
	 8yMgeKJ0H8Idg==
Date: Wed, 22 Apr 2026 17:07:55 +0100
From: Conor Dooley <conor@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	Ajay Neeli <ajay.neeli@amd.com>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Pedro Sousa <pedrom.sousa@synopsys.com>,
	Arnd Bergmann <arnd@arndb.de>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 1/3] scsi: ufs: dt-bindings: starfive: Add UFS Host
 Controller for JHB100 soc
Message-ID: <20260422-tighten-baritone-bc216c670275@spud>
References: <20260421091215.120632-1-minda.chen@starfivetech.com>
 <20260421091215.120632-2-minda.chen@starfivetech.com>
 <20260421-appetite-vowel-ce0837f5625b@spud>
 <SH0PR01MB08588CCE01874CEC5FBEF0D4E62D2@SH0PR01MB0858.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sJ5MKeWHqe7LrEf3"
Content-Disposition: inline
In-Reply-To: <SH0PR01MB08588CCE01874CEC5FBEF0D4E62D2@SH0PR01MB0858.CHNPR01.prod.partner.outlook.cn>
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23200-lists,linux-scsi=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,starfivetech.com:server fail];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.234.253.10:query timed out];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,starfivetech.com:email]
X-Rspamd-Queue-Id: C44D74483FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--sJ5MKeWHqe7LrEf3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 11:04:22AM +0000, Minda Chen wrote:
>=20
>=20
> >=20
> > On Tue, Apr 21, 2026 at 05:12:13PM +0800, Minda Chen wrote:
> > > Add devicetree document for UFS Host Controller StarFive JHB100 SoC.
> > > The UFS controller is based on the Synopsys DesignWare UFS controller.
> > >
> > > Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> > > ---
> > >  .../devicetree/bindings/ufs/starfive,ufs.yaml | 76 +++++++++++++++++=
++
> > >  MAINTAINERS                                   |  5 ++
> > >  2 files changed, 81 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/ufs/starfive,ufs.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/ufs/starfive,ufs.yaml
> > > b/Documentation/devicetree/bindings/ufs/starfive,ufs.yaml
> > > new file mode 100644
> > > index 000000000000..c408973dd0ce
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/ufs/starfive,ufs.yaml
> >=20
> > Filename should be starfive,jhb100-ufs.
> >=20
> Thanks. Conor. I see some vendors's dt-binding doc without IC name
> because ufs host controller registers are standard. So I think if we(Star=
Five) change
> IP vendor will still using the same driver files and dt doc. =20

Other than lack of oversight or age of the bindings, there's no real
reason for filenames not matching the compatible. UFS isn't special
here.

> If the scsi UFS maintainer no comments to this I will change this.

--sJ5MKeWHqe7LrEf3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaejyWwAKCRB4tDGHoIJi
0q6KAQDwVEx/MZiyLnbXpok/zxt7rCs8XfVvQ1CedHhQZeaJNAEAgyQyONAgAn8q
S3A/nD16WM25/6QTLE//peQCSZPA+wg=
=Ge0L
-----END PGP SIGNATURE-----

--sJ5MKeWHqe7LrEf3--

