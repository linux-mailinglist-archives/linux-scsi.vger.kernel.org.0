Return-Path: <linux-scsi+bounces-25450-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xZ76IZPQRWqyFgsAu9opvQ
	(envelope-from <linux-scsi+bounces-25450-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 02 Jul 2026 04:44:35 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BB46F3167
	for <lists+linux-scsi@lfdr.de>; Thu, 02 Jul 2026 04:44:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=j92jm5p3;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25450-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25450-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAC293020113
	for <lists+linux-scsi@lfdr.de>; Thu,  2 Jul 2026 02:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CEE2DEA7B;
	Thu,  2 Jul 2026 02:44:32 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EF81FF5E3;
	Thu,  2 Jul 2026 02:44:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782960272; cv=none; b=dcK3ar6lCYPDZBX7ShC63m8lLqnaFWsqWBw2GTG4p+XKgKn+wyNXm2DEgS9ZE1aDtdl0nHTUXCWVN727KN7KbSCh8B29ncyu7EwEObCnlUhkG0ZD59x1azq81Ldu/avUJB/BJGKFMLX5Rvc9CfkkpjjwULDHA3px8/cTqrcGPW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782960272; c=relaxed/simple;
	bh=iaLiBAEXIAQC9OJt2+FV4879LBdJkr2JGxuJIUuXc68=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ka1M1RmQETxnM/Zc+HpCkmTbcQ1qieQA8AECTO2uydgz4KSLdJ0dQB6UH3Eqn5xy2WxhMdrxoRalkkCDD/F3I31T2/eCtIZyySgc6uN2mQ80eMcR+z35oDAGOW6XnPZacic4bDfiSxs1ak5u7wMDFF7Evq+89eIgAyw4rkR7G3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j92jm5p3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207401F000E9;
	Thu,  2 Jul 2026 02:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782960271;
	bh=k3gy6Cd83Qy4wDk4bfEyPNTCMUN0tEa2iENDgCHUu2U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j92jm5p3NHpRDcYGdVkDkmksl+LACFjTY1JGxLJDXPWtPIpZ5HQi/FrWY9pT7gEmU
	 F426Y1f8ldohuEogKvcoMayEGjeSXDJUgQ1+mFdpsYc8uWy/Boz/1OecZZCZt6B4wK
	 QhGJ6Oi24ePbB/VSq2kSwD8oLoCnVUSqvxsYensMKSkUv7kHteprfVrO1ire+WANgG
	 h9VdVZH3+ZomPg3KVlNSeElc6MBniXYiwiMr8drIBVKHjpj8VLqwgvS1s9x9SEelFA
	 tXaI3uCOy6IV5/E5XlYJao4aHMcuFo7w9nSAk7AHjcjWISz1Wkc79OVcjS6lKmEEX1
	 foIewdp6/6GRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] riscv: dts: spacemit: k3: Add UFS support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yixun Lan" <dlan@kernel.org>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <20260702-08-k3-ufs-support-v1-3-1a64a3ab128f@kernel.org>
References: <20260702-08-k3-ufs-support-v1-0-1a64a3ab128f@kernel.org>
 <20260702-08-k3-ufs-support-v1-3-1a64a3ab128f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 02:44:30 +0000
Message-Id: <20260702024431.207401F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-25450-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[smtp.kernel.org:mid,sashiko.dev:url,lists.linux.dev:replyto,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dlan@kernel.org,m:devicetree@vger.kernel.org,m:robh@kernel.org,m:conor+dt@kernel.org,m:linux-scsi@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: F1BB46F3167

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Low] Undeclared clock macro CLK_APMU_UFS_REFCLK will break device tree c=
ompilation.
- [Low] The `ufshc@c0e00000` node is placed out of order inside the `soc` b=
us node.
- [Low] Missing commas in the freq-table-hz array will cause dtbs_check sch=
ema validation to fail.
--

commit 065548f4228bb50038a171b531eac2901642579a
Author: Yixun Lan <dlan@kernel.org>

riscv: dts: spacemit: k3: Add UFS support

This commit adds UFS Host Controller support for the SpacemiT K3 SoC. It al=
so
enables it on both the Pico-ITX and CoM260-IFX boards.

[ ... ]

> diff --git a/arch/riscv/boot/dts/spacemit/k3.dtsi b/arch/riscv/boot/dts/s=
pacemit/k3.dtsi
> index 19fc9b49668ed..6c0b0598d5c86 100644
> --- a/arch/riscv/boot/dts/spacemit/k3.dtsi
> +++ b/arch/riscv/boot/dts/spacemit/k3.dtsi
> @@ -1186,5 +1186,18 @@ maplic: interrupt-controller@f1800000 {
>  			riscv,num-sources =3D <512>;
>  			status =3D "reserved";
>  		};
> +
> +		ufshc: ufshc@c0e00000 {

[Severity: Low]
Is this node placed in the correct order? The ufshc@c0e00000 node is append=
ed
at the end of the file, after interrupt-controller@f1800000. Should child n=
odes
of a bus be sorted in ascending order by their unit-address?

> +			compatible =3D "spacemit,k3-ufshc";
> +			reg =3D <0x0 0xc0e00000 0x0 0x40000>;
> +			clocks =3D <&syscon_apmu CLK_APMU_UFS_ACLK>,
> +				 <&syscon_apmu CLK_APMU_UFS_REFCLK>;

[Severity: Low]
Does this undeclared clock macro CLK_APMU_UFS_REFCLK cause the device tree
compilation (make dtbs) to fail with a syntax error?

> +			clock-names =3D "aclk", "ref_clk";
> +			resets =3D <&syscon_apmu RESET_APMU_UFS_ACLK>;
> +			interrupts =3D <135 IRQ_TYPE_LEVEL_HIGH>;
> +			freq-table-hz =3D <491520000 491520000 19200000 19200000>;

[Severity: Low]
Will the missing commas here cause dtbs_check schema validation to fail?

The ufs-common.yaml schema requires freq-table-hz to be a list of arrays
(min/max frequency tuples per clock). When written as a flat array without
separating commas, dtc processes it into a single array which the YAML sche=
ma
validator may reject since it expects exact 2-element inner tuples.

> +			lanes-per-direction =3D <2>;
> +			status =3D "disabled";
> +		};
>  	};
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-08-k3-ufs-=
support-v1-0-1a64a3ab128f@kernel.org?part=3D3

