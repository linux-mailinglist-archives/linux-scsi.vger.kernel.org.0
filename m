Return-Path: <linux-scsi+bounces-4489-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFABC8A1842
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Apr 2024 17:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24930B26627
	for <lists+linux-scsi@lfdr.de>; Thu, 11 Apr 2024 15:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D6A1171A;
	Thu, 11 Apr 2024 15:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCWsz4ut"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE9115E85;
	Thu, 11 Apr 2024 15:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712848212; cv=none; b=oW3/kfWF2EFiTgDxrPQlUYZ/67H8jtyAyhNvnKYTpFaQKQPIXKNg47nZFIQTwa2ae/ovn/NC2sHr6uBx6wdU7q0YAwiY1rP7TS0ywBX1ZcexSa4Q2JcvgbjqNitcC1LNYAi22rlRN4AJ/vK10aXTax0ZuevcKEhxuv04IJ40NfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712848212; c=relaxed/simple;
	bh=tH5GwggbPz305Kl6EbUr95HFBDOSgGMYA7QcHk6KzVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JujqfxPzhQbHH/3niTkScXfw/ym4qDDuKCnJbIUy125veS4LGYxrsUs8ESFi7C6naxNXER98j72J6m4Ly+qFH5tnwU3EiahUKN54VESobogM5jHJQ1G9G+hSLJC/eDyfYv1dViTJq8TPqA0qmxW6zXKfqWuG3JybU39R1Qh6uHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCWsz4ut; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3738EC113CD;
	Thu, 11 Apr 2024 15:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712848212;
	bh=tH5GwggbPz305Kl6EbUr95HFBDOSgGMYA7QcHk6KzVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vCWsz4utmYewzyojhx2V/JATN+mTcnX3uUCcUXBn8RrUxl3EcU+vM1rnGHeehzkDm
	 mEYEYcAKBiLAxdxoGhlEBppFtAMOcQ8ZFAQscjY1Iyq2SnjBAStAvFTu/bXLTPOGyG
	 RfdG2OhyIteF+eIpIrHZ2siXlHpxIXDOIq9mvakK9J+z/Z+eniQ3u/sXW0xNDx2c4x
	 id3FHIisD3k5kTlOIt1haLd1xpdfh5oyE6IkcdFCy/10pXwMSyd64Zcmny3e6gVI8j
	 FgPJBIgNIpYiPYWOtS8WKcMBO0Iln9LzSSqDADXyL3d9s80SKDkbSsV6dE3kGtqmy7
	 wGnwWa6PYObZQ==
Date: Thu, 11 Apr 2024 16:10:06 +0100
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-scsi@vger.kernel.org, alim.akhtar@samsung.com,
	avri.altman@wdc.com, bvanassche@acm.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	peter.wang@mediatek.com, chu.stanley@gmail.com, jejb@linux.ibm.com,
	martin.petersen@oracle.com, lgirdwood@gmail.com, broonie@kernel.org,
	matthias.bgg@gmail.com, stanley.chu@mediatek.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 7/8] dt-bindings: ufs: mediatek,ufs: Document
 additional clocks
Message-ID: <20240411-filth-trekker-8a8c185d589b@spud>
References: <20240411114300.169055-1-angelogioacchino.delregno@collabora.com>
 <20240411114300.169055-8-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="83ERy7+r+DSooO69"
Content-Disposition: inline
In-Reply-To: <20240411114300.169055-8-angelogioacchino.delregno@collabora.com>


--83ERy7+r+DSooO69
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 01:42:59PM +0200, AngeloGioacchino Del Regno wrote:
> Add additional clocks, used on all MediaTek SoCs' UFSHCI controllers:

I appreciate being told they're on all, rather than it being unsaid and
having to ask.

> some of these clocks are optional and used only for scaling purposes
> to save power, or to improve performance in the case of the crypt
> clocks.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  .../devicetree/bindings/ufs/mediatek,ufs.yaml      | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml b/Do=
cumentation/devicetree/bindings/ufs/mediatek,ufs.yaml
> index e2c276da3f2c..21b038db100c 100644
> --- a/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
> +++ b/Documentation/devicetree/bindings/ufs/mediatek,ufs.yaml
> @@ -26,11 +26,23 @@ properties:
>            - const: mediatek,mt8183-ufshci
> =20
>    clocks:
> -    maxItems: 1
> +    minItems: 1

Could you add an itemised list to the clocks property please?

> =20
>    clock-names:
> +    minItems: 1
>      items:
>        - const: ufs
> +      - const: ufs-aes


> +      - const: ufs-tick
> +      - const: unipro-sys
> +      - const: unipro-tick
> +      - const: ufs-sap
> +      - const: ufs-tx-symbol
> +      - const: ufs-rx-symbol
> +      - const: ufs-mem
> +      - const: crypt-mux
> +      - const: crypt-lp
> +      - const: crypt-perf
> =20
>    phys:
>      maxItems: 1
> --=20
> 2.44.0
>=20

--83ERy7+r+DSooO69
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhf9TgAKCRB4tDGHoIJi
0nPsAQDR9MO4nmtSmAMmQ8o43G0oFD2I4Ib5sc7/3XCMceiSbAD/ZQOJyUwxivM/
5IxvlYIjm4x83lwZ0N6c2CYnEQXh0QE=
=NwEY
-----END PGP SIGNATURE-----

--83ERy7+r+DSooO69--

