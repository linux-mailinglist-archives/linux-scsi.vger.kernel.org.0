Return-Path: <linux-scsi+bounces-24188-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KD4hGVP7F2oWXwgAu9opvQ
	(envelope-from <linux-scsi+bounces-24188-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 28 May 2026 10:22:43 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EA75EE7B7
	for <lists+linux-scsi@lfdr.de>; Thu, 28 May 2026 10:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7308300F95B
	for <lists+linux-scsi@lfdr.de>; Thu, 28 May 2026 08:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3F6374E76;
	Thu, 28 May 2026 08:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A3gGywBh"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C68376A1E;
	Thu, 28 May 2026 08:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779956214; cv=none; b=MChVG2kMl66TgP0Ki18WdVKvm0zoKHBRcPLqo+7PKoqBAYEJM4zq5WWqCdGjrm3gJxIay37LNmIvjP0l/RVFQCIfcDe+4lo0QXD/nsbS5HhJPoVoVdVPbRc2S9C4rZcQCfJyIaZNjBFkS+PtWL1yd3ssvf+ApOa7MAdnMXLobs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779956214; c=relaxed/simple;
	bh=ocv/f7kFeHxsadYJuWOGoRWF0y3soTlGsjUEpPX1kWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=taoVURfokLqhMYcppQtnDqPKEUZ3R6QQ2nkRVl0HyvPKfFUqrtKCmeZvjajH9UvWeAWiCvkiX690ifhxlNFhdnWpb46JhHrVF7fwWKwL8K6cQo3+hu0IVU4TYgOSZPVBe/Nt0brpGrUt6+X9XOBQauQ+L0Aq+2I2mnojUus3ZK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A3gGywBh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218941F00A3A;
	Thu, 28 May 2026 08:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779956210;
	bh=qAe96fNQZ7PMNWOOZmxs4+RE59Dia/wcBPkWgj9s4S4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A3gGywBh5Jz0r3GgLhl6IBA41779sa2FB+rw1veo9nRE0TFKrIjzDAWS84mdF2gCs
	 fczhvdXIUxxhk9Zhp/0UJriYp4G86XTUqR9NarMbYQPapgfuERHyj3dw67AKbm2jtd
	 xy8ipIiLtMdpJbzYDenVHqI4rJAMKnehQ68yd8r3xNlcLIcFAde4vq8JKoUgA1Vnjm
	 k70kr+4EGo2st1zT3UsiHerBRp2Bdowal0ASfSSye0x11DlrG9b9SrNoTavnXZAOMy
	 L8WdVHzJYrcX5iQRvFANwJHGy/d+I3pm4KjkQwIBhQlhmbZSlx8AGe+IOcxlnUvshp
	 iI65qk45mN9Yg==
Date: Thu, 28 May 2026 10:16:45 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Can Guo <can.guo@oss.qualcomm.com>
Cc: bvanassche@acm.org, beanhuo@micron.com, peter.wang@mediatek.com, 
	martin.petersen@oracle.com, linux-scsi@vger.kernel.org, 
	Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>, 
	Nitin Rawat <quic_nitirawa@quicinc.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] scsi: ufs: core: Add support for static TX
 Equalization settings
Message-ID: <35rqdgvdtf2jjjjdfajhhansmzzem2gllbw5olcopdmcdfdd3k@rqwlcht5uzsw>
References: <20260527144055.2758170-1-can.guo@oss.qualcomm.com>
 <20260527144055.2758170-3-can.guo@oss.qualcomm.com>
 <mt2asdx4vnuxo3eodrc7dlfdtv3b5bpjfvxxglmncny36otfav@htri3l5q4ba3>
 <d57a0e9b-74f6-4472-842f-6479c7449cd8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d57a0e9b-74f6-4472-842f-6479c7449cd8@oss.qualcomm.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24188-lists,linux-scsi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:email]
X-Rspamd-Queue-Id: E6EA75EE7B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 03:24:37PM +0800, Can Guo wrote:
> 
> 
> On 5/28/2026 2:13 PM, Manivannan Sadhasivam wrote:
> > On Wed, May 27, 2026 at 07:40:55AM -0700, Can Guo wrote:
> > > Static TX Equalization settings and TX Precode enable indication from DT
> > > properties txeq-preshoot-g[1-6], txeq-deemphasis-g[1-6], and
> > > tx-precode-enable-g6 are board-specific baseline values. Values are
> > > provided as per-lane tuples:
> > > 
> > > <Host_Lane0 Device_Lane0>, [<Host_Lane1 Device_Lane1>]
> > > 
> > > Parse DT u32 properties with explicit range checks by using
> > > of_property_count_u32_elems()/of_property_read_u32_array().
> > > 
> > > When adaptive TX Equalization is used, these static settings are not final:
> > > 
> > > - If valid settings are retrieved from qTxEQGnSettings/wTxEQGnSettingsExt,
> > >    those retrieved settings override static DT settings.
> > > - If retrieval is not available/valid, TX EQTR runs and trained settings
> > >    override static DT settings.
> > > 
> > > So static DT settings are a fallback and are intended for cases where
> > > adaptive TX Equalization is not enabled/used. Adaptive TX Equalization
> > > remains the primary path when enabled.
> > > 
> > > No behavior changes for platforms that do not provide these properties.
> > > 
> > > Signed-off-by: Can Guo <can.guo@oss.qualcomm.com>
> > > ---
> > >   drivers/ufs/core/ufs-txeq.c      |   4 +-
> > >   drivers/ufs/host/ufshcd-pltfrm.c | 128 +++++++++++++++++++++++++++++++
> > >   include/ufs/ufshcd.h             |   2 +
> > >   3 files changed, 133 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/ufs/core/ufs-txeq.c b/drivers/ufs/core/ufs-txeq.c
> > > index 4b264adfdf49..634ec039e129 100644
> > > --- a/drivers/ufs/core/ufs-txeq.c
> > > +++ b/drivers/ufs/core/ufs-txeq.c
> > > @@ -1297,7 +1297,7 @@ int ufshcd_config_tx_eq_settings(struct ufs_hba *hba,
> > >   	}
> > >   	params = &hba->tx_eq_params[gear - 1];
> > > -	if (!params->is_valid || force_tx_eqtr) {
> > > +	if (!params->is_valid || params->is_static || force_tx_eqtr) {
> > >   		int ret;
> > >   		ret = ufshcd_tx_eqtr(hba, params, pwr_mode);
> > > @@ -1310,6 +1310,7 @@ int ufshcd_config_tx_eq_settings(struct ufs_hba *hba,
> > >   		/* Mark TX Equalization settings as valid */
> > >   		params->is_valid = true;
> > >   		params->is_trained = true;
> > > +		params->is_static = false;
> > >   		params->is_applied = false;
> > >   	}
> > > @@ -1495,6 +1496,7 @@ static void ufshcd_extract_tx_eq_settings_attrs(struct ufs_hba *hba, u8 gear)
> > >   	}
> > >   	params->is_valid = true;
> > > +	params->is_static = false;
> > Maybe it's me, but I'm not able to understand how you want to apply these static
> > EQ settings. In commit message you said, the static values should be used as a
> > fallback, but you just check for 'params->is_static' while triggering
> > ufshcd_tx_eqtr() which is supposed to perform adaptive TX EQ training. IMO, you
> > don't need any check at all for applying static setting. If '(!params->is_valid
> > || force_tx_eqtr)' condition is not satisfied, then the static setting should be
> > used.
> Thanks for the review.
> 
> The distinction is between two different sources that can pre-populate
> txeq_params with
> is_valid set to true before ufshcd_config_tx_eq_settings() is called:
> 
> 1. DT properties — parsed by ufshcd_pltfrm_parse_tx_eq_settings(),
>     sets is_valid = true, is_static = true.
> 2. UFS Attributes (qTxEQGnSettings/wTxEQGnSettingsExt) — retrieved by
>     ufshcd_retrieve_tx_eq_settings() (introduced in the 2nd series),
>     sets is_valid = true, is_static = false.
> 
> Since both sources set is_valid = true, the is_valid flag alone cannot tell
> them apart.
> The is_static flag is the discriminator:
> 
> - is_valid && is_static -> settings came from DT; they are a board-level
> baseline.
>   TX EQTR should still run to find optimal settings, which will then
> overwrite the static ones.
> - is_valid && !is_static -> settings came from UFS Attributes; they are
> previously trained

You use '&&' here, but '||' in the code. When you use '||', then I see no point
for 'is_static' check.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

