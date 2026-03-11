Return-Path: <linux-scsi+bounces-21850-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OI15JXxrsWnsugIAu9opvQ
	(envelope-from <linux-scsi+bounces-21850-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 11 Mar 2026 14:17:48 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2B62644AA
	for <lists+linux-scsi@lfdr.de>; Wed, 11 Mar 2026 14:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0B57D301C8CD
	for <lists+linux-scsi@lfdr.de>; Wed, 11 Mar 2026 13:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710412E4257;
	Wed, 11 Mar 2026 13:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXrDLokL"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34811234984;
	Wed, 11 Mar 2026 13:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773234648; cv=none; b=DF4fYK6tQZppJS99NZwAggIEjpmslf62fqsS4Bv8Jwtj5bu4ObstWfJku8Gzo06RVic2muVu2/frNfe4V09VMg2I2wX5ULPq5iKS6DcvqIwLAWsaIUWVLjVHljeNrdjlqfTaesPpPnAgxxPYNFd9p28Tu0ZelHwTmxuosczHBYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773234648; c=relaxed/simple;
	bh=I1WbPQA5NEIo1AGI5Oi8bYm76YQx+F1VeHq/ntSHCZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwQOcKpwjyVO3l6xcE2lXFgD8pQcUvXrv+TmpeRrtuGe/ivcEjEqWOYP8F35voQur+BtuLwmvNPoXR2LZ5ELk4zJIVoiJqIXpyISAcRkoH2sxpq49t+1h3kl/ZVp2xhbhXqo7YIB62G7GvUeIyy2q+ND/xCYmTHgUHp/GB12ES4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXrDLokL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA1FC4CEF7;
	Wed, 11 Mar 2026 13:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773234647;
	bh=I1WbPQA5NEIo1AGI5Oi8bYm76YQx+F1VeHq/ntSHCZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gXrDLokLmDYfK9g+e3VHMWaQdVmejzQpJg5uErLMgOSalsrGXf9T7mbaRXkwXrJjL
	 2O9SoczvAdFdUA6tJ0Fbi8BL4/KI+y4Pg7daOEb4X60iUw8yUMLHCpUzigu69mnPBQ
	 UBCqCWvQqtsu6m8BOwpT53MnLbFI3lAN4s4oG43unJnFL2BWdxyz5M7nCaHJYD0Pkr
	 yufuUq72l0UBqiGt8eU2/JpnPeCnT4Gvr8fdNgWNDwGZQX7dOvdw4PrDim0OepWkoX
	 C3DJ+QTs9VxiPiPmJHDkkaaOU4joVE21dvMHYjg+pB6NaDNzUShxiM4rHR+N8iPYY+
	 B0981YH066GgA==
Date: Wed, 11 Mar 2026 14:10:45 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 1/2] scsi: ufs: drockchip,rk3576-ufshc: dt-bindings: Add
 new mphy reset item
Message-ID: <20260311-ultraviolet-shrew-of-management-ca536b@quoll>
References: <1773193218-215988-1-git-send-email-shawn.lin@rock-chips.com>
 <1773193218-215988-2-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1773193218-215988-2-git-send-email-shawn.lin@rock-chips.com>
X-Rspamd-Queue-Id: 6C2B62644AA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21850-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,rock-chips.com:email]
X-Rspamd-Action: no action

On Wed, Mar 11, 2026 at 09:40:17AM +0800, Shawn Lin wrote:
> Add the mphy reset property to the devicetree bindings for the Rockchip
> RK3576 UFS host controller. The mphy reset signal is used to reset the
> physical adapter. Resetting other components while leaving the mphy
> unreset may occasionally prevent the UFS controller from successfully
> linking up with the device.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  Documentation/devicetree/bindings/ufs/rockchip,rk3576-ufshc.yaml | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/rockchip,rk3576-ufshc.yaml b/Documentation/devicetree/bindings/ufs/rockchip,rk3576-ufshc.yaml
> index c7d17cf4..e738153 100644
> --- a/Documentation/devicetree/bindings/ufs/rockchip,rk3576-ufshc.yaml
> +++ b/Documentation/devicetree/bindings/ufs/rockchip,rk3576-ufshc.yaml
> @@ -41,7 +41,7 @@ properties:
>      maxItems: 1
>  
>    resets:
> -    maxItems: 4
> +    maxItems: 5
>  
>    reset-names:
>      items:
> @@ -49,6 +49,7 @@ properties:
>        - const: sys
>        - const: ufs
>        - const: grf
> +      - const: mphy

ABI break here and in the driver. Considering this was merged year ago,
so for sure it was tested and was working. Otherwise commit msg would
explain the actual bug affecting users.

Best regards,
Krzysztof


