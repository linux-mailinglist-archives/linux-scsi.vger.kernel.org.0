Return-Path: <linux-scsi+bounces-25184-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Uli4OJ4rOmoB3QcAu9opvQ
	(envelope-from <linux-scsi+bounces-25184-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 08:45:50 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC156B49FD
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 08:45:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hiriFdP5;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25184-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25184-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C660B301981D
	for <lists+linux-scsi@lfdr.de>; Tue, 23 Jun 2026 06:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D541730ACF2;
	Tue, 23 Jun 2026 06:45:43 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CBE1DA57;
	Tue, 23 Jun 2026 06:45:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782197143; cv=none; b=UFmQHMRIiNgiSGvWQq3FcB50COZdai5a8F9Bp5NxRYybtiwmfA967pPhB2XmlKGIV2bUR1sJz5OHdWs3Uaruz1OQYeiXiqpG8UUtCp37qYCXvDmu98mWD72F/1o9igRRw95s0SaDuSXnWWn0mL+0QHXvFYjXizwAJsIT/aOFiQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782197143; c=relaxed/simple;
	bh=cx4lcSQCH1SQOC5NyMWZyBbALhu4wCrhziOel62QF68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmThSdI/2TSgKGqpXIsuA7Tgys3mozuqmBIgCzllaefRzAWiDUYGaA7Gq1Rlb15h1t8Fdc4DzBYpK1cPrMbUTgelHmf+bzWstvIu2kuDdzp7B7r1gIdkGE7TyBX31wdK5GjTvl8D/uPBTusfd2K2xY1q4l7M2epLcwky190nRY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiriFdP5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20641F000E9;
	Tue, 23 Jun 2026 06:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782197142;
	bh=UFnD8PCeihUYtE6Qu/iYrMyPqsWAAgq7VlluAslLLI8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hiriFdP5Rc6DfzB/guIUAIT0HYs4i2uxpvckTyXb40lUQLgxROXT4/CnckP9sKeW0
	 5/i75sYKo0o7YjlFeoS5sdpvA/F9Z+pkbLLiDgJoQFyB5iPuf49aWwkWaCtRGhHJ4f
	 VIze7fDGLOY6jR0siRG8pU9mH+fANN0MCexJqT5R5sBcyGkHlmfAtnGglLaTEUCUw1
	 Oi+ARluSIyaTteG8urptD0V2zVIf/GlRGIky+r3BM2O+hxd98flZ0mo5X9k1hfiV7A
	 vO2h0+b7ifLT6imNOX4Ja4EjrnqJn//nviXRpigXsmveT4N1+TPtcHfXjowtnLpcwj
	 BOOR+9PSxnyzQ==
Date: Tue, 23 Jun 2026 08:45:33 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Can Guo <can.guo@oss.qualcomm.com>
Cc: bvanassche@acm.org, beanhuo@micron.com, peter.wang@mediatek.com, 
	martin.petersen@oracle.com, linux-scsi@vger.kernel.org, 
	Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] scsi: ufs: core: Always run tx_eqtr POST_CHANGE
 notify
Message-ID: <la3brhtgvj6xa7yrzidxhsjjypun2nk64dy6bbf5akmqq4i5lz@sfdmdjhfxgkh>
References: <20260620080322.3765210-1-can.guo@oss.qualcomm.com>
 <20260620080322.3765210-4-can.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260620080322.3765210-4-can.guo@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:can.guo@oss.qualcomm.com,m:bvanassche@acm.org,m:beanhuo@micron.com,m:peter.wang@mediatek.com,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:alim.akhtar@samsung.com,m:avri.altman@wdc.com,m:James.Bottomley@hansenpartnership.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mani@kernel.org,linux-scsi@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-25184-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-scsi];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4CC156B49FD

On Sat, Jun 20, 2026 at 01:03:22AM -0700, Can Guo wrote:
> ufshcd_tx_eqtr() skips POST_CHANGE notify when __ufshcd_tx_eqtr()
> fails. That can leave variant cleanup incomplete when PRE_CHANGE saved
> temporary state that POST_CHANGE is expected to restore.
> 
> Always call POST_CHANGE once PRE_CHANGE has succeeded. Keep the TX EQTR
> result as the primary return value, and only propagate POST_CHANGE
> failure when TX EQTR itself succeeded.
> 
> Log PRE_CHANGE and POST_CHANGE notify failures to make variant callback
> failures visible in TX EQTR error paths.
> 
> Signed-off-by: Can Guo <can.guo@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/ufs/core/ufs-txeq.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ufs/core/ufs-txeq.c b/drivers/ufs/core/ufs-txeq.c
> index 23a12e221d31..c39a623b4fe1 100644
> --- a/drivers/ufs/core/ufs-txeq.c
> +++ b/drivers/ufs/core/ufs-txeq.c
> @@ -1224,6 +1224,7 @@ static int ufshcd_tx_eqtr(struct ufs_hba *hba,
>  {
>  	struct ufs_pa_layer_attr old_pwr_info;
>  	unsigned int noio_flag;
> +	int notify_ret;
>  	int ret;
>  
>  	/*
> @@ -1253,14 +1254,19 @@ static int ufshcd_tx_eqtr(struct ufs_hba *hba,
>  	}
>  
>  	ret = ufshcd_vops_tx_eqtr_notify(hba, PRE_CHANGE, pwr_mode);
> -	if (ret)
> +	if (ret) {
> +		dev_err(hba->dev, "TX EQTR PRE_CHANGE notify failed: %d\n", ret);
>  		goto out;
> +	}
>  
>  	ret = __ufshcd_tx_eqtr(hba, params, pwr_mode);
> -	if (ret)
> -		goto out;
>  
> -	ret = ufshcd_vops_tx_eqtr_notify(hba, POST_CHANGE, pwr_mode);
> +	notify_ret = ufshcd_vops_tx_eqtr_notify(hba, POST_CHANGE, pwr_mode);
> +	if (notify_ret)
> +		dev_err(hba->dev, "TX EQTR POST_CHANGE notify failed: %d\n", notify_ret);
> +
> +	if (!ret)
> +		ret = notify_ret;
>  
>  out:
>  	if (ret)
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

