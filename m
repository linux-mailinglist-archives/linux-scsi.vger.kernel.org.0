Return-Path: <linux-scsi+bounces-25449-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 92/RJCPPRWpoFgsAu9opvQ
	(envelope-from <linux-scsi+bounces-25449-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 02 Jul 2026 04:38:27 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF086F311B
	for <lists+linux-scsi@lfdr.de>; Thu, 02 Jul 2026 04:38:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=kNhoLGII;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25449-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25449-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAA663039579
	for <lists+linux-scsi@lfdr.de>; Thu,  2 Jul 2026 02:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8172DEA7B;
	Thu,  2 Jul 2026 02:38:19 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78731431E49;
	Thu,  2 Jul 2026 02:38:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782959899; cv=none; b=eofwL23NIdEl4Krg6Ofxe6jO/ifqmIIkHpb6dS93Oh3ssO/plwexzeH2Y34pYr+4GbMF+Mw67tKEzqU2/jFRLE7l6ssmmNlFvXB/zlEyc2BpbXdQiwfQ8w4NPrrxJ0xyZ4/Hstc7sqXAO+/Y6xuTdpFnxZOGlnADIP8QZWG+mOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782959899; c=relaxed/simple;
	bh=vh/jTv7R6a9TeyhyLanp45MTiX3GjgtJpLShHsPG7rM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YhhfWEq/SD3ZHr3rQL2W7FdO/mLugXLr6+MnwCRiLLp6MkUBm2NwQQkCgpcqBSJ6EycJEOqneudwD/fQcawRypkqN/W4uQ7xqbtukOb/69A0wl7cqj/4vWQXOO/OOkCIuhVBGIXSw21F5KoRGNL1pFJ7vFpNxsIRsdrSCREy5ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNhoLGII; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC27A1F000E9;
	Thu,  2 Jul 2026 02:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782959898;
	bh=b1GXHfFyvAN2Z7/b/Bgo7L2sJPaZrnifzqvI1I3y1/8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kNhoLGIIqxq6zV7xtvVBSfWwjXtyOfPAACYVp4GBeAPC0zAKNjZ2dOHXIqN3JDx2i
	 oobaSZLU1BFHqjdsLLBh8qhernMKaXaXJRkJJqR99Me8Ye3XHUimcZdcXil7Cxd815
	 782HMhRSyjdh1KRTSzHuV3AitmlGNGMvwnqOk14CqpoKnu5nsKkVnnVFrNOB6xU4MU
	 93Umsd6NGOl0F6u7RVNR/A+g698EcfNFKNLUE6BE96mQKkKEQlElisjyW7rH+bxZ3r
	 2e+VIa8TFyD4B4ljWjgD3WbYkkJqYAZ+VHNvT6JYWMu0voI1IKSvFPHssYQGnNnwsK
	 2BoThung9Yu5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] scsi: ufs: spacemit: dt-bindings: Add UFS
 controller for K3 SoC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yixun Lan" <dlan@kernel.org>
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20260702-08-k3-ufs-support-v1-1-1a64a3ab128f@kernel.org>
References: <20260702-08-k3-ufs-support-v1-0-1a64a3ab128f@kernel.org>
 <20260702-08-k3-ufs-support-v1-1-1a64a3ab128f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 02:38:17 +0000
Message-Id: <20260702023817.AC27A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25449-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sashiko.dev:url,lists.linux.dev:replyto,vger.kernel.org:from_smtp,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dlan@kernel.org,m:robh@kernel.org,m:devicetree@vger.kernel.org,m:conor+dt@kernel.org,m:linux-scsi@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4CF086F311B

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The example device tree node is missing the required `interrupts` p=
roperty, causing schema validation (`dt_binding_check`) to fail.
- [Low] The `freq-table-hz` property in the example uses an invalid flat ar=
ray syntax for a matrix property and relies on a deprecated binding.
--

commit 1206e23c10bdd35379971f48c29e246d5b43200d
Author: Yixun Lan <dlan@kernel.org>

scsi: ufs: spacemit: dt-bindings: Add UFS controller for K3 SoC

Document the compatible for UFS (Universal Flash Storage) Host Controller
which found in SpacemiT K3 SoC chip. This adds the YAML schema defining=20
features like MIPI UniPro v1.61 and M-PHY v3.0 compliance.

> diff --git a/Documentation/devicetree/bindings/ufs/spacemit,k3-ufshc.yaml=
 b/Documentation/devicetree/bindings/ufs/spacemit,k3-ufshc.yaml
> new file mode 100644
> index 0000000000000..e6cb6fb2496c8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ufs/spacemit,k3-ufshc.yaml

[ ... ]

> +examples:
> +  - |
> +    #include <dt-bindings/clock/spacemit,k3-clocks.h>
> +    #include <dt-bindings/reset/spacemit,k3-resets.h>
> +    ufs@c0e00000 {
> +        compatible =3D "spacemit,k3-ufshc";
> +        reg =3D <0xc0e00000 0x40000>;

[Severity: Low]
Does this example node miss the interrupts property? The included
ufs-common.yaml schema requires an interrupts property, which might cause
make dt_binding_check to fail validation here.

> +        clocks =3D <&syscon_apmu CLK_APMU_UFS_ACLK>,
> +        <&syscon_apmu CLK_APMU_UFS_REFCLK>;
> +        clock-names =3D "aclk", "ref_clk";
> +        resets =3D <&syscon_apmu RESET_APMU_UFS_ACLK>;
> +        freq-table-hz =3D <491520000 491520000 19200000 19200000>;

[Severity: Low]
Is this the correct formatting for freq-table-hz? This property expects a
multi-dimensional array, so writing it as a flat array (rather than
<A B>, <C D>) will likely cause dt-schema validation to fail.

Also, does this introduce a deprecated property to a new binding?

> +        lanes-per-direction =3D <2>;
> +    };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-08-k3-ufs-=
support-v1-0-1a64a3ab128f@kernel.org?part=3D1

