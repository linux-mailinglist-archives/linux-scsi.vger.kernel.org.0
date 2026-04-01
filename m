Return-Path: <linux-scsi+bounces-22655-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIhBGHUSzWmMZwYAu9opvQ
	(envelope-from <linux-scsi+bounces-22655-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Apr 2026 14:41:25 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C89637A991
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Apr 2026 14:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D79C3138024
	for <lists+linux-scsi@lfdr.de>; Wed,  1 Apr 2026 12:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517C940757F;
	Wed,  1 Apr 2026 12:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8A3xcAp"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139663F7E93;
	Wed,  1 Apr 2026 12:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775046549; cv=none; b=XnLd6OjYZG9rUMgXXxLblD8f/vbcod8qPGXLTE98exnLI5BJ90jm4R6KnQh9bPBpZQIYmONiMi1rT5OqNvZjWJBIaQ7DfJ1bu9Tmh1jNu0BzK91roxZsfrI+raAkGgeul+efIXMzQWzg95CvmJllFW67tc+N2KzNear+JpTy2KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775046549; c=relaxed/simple;
	bh=NvgNkEMAN52LEQ4N0hlij8TYcV+8I2cZgNeTB7K/fJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxQ5KWvO3vQOpnx+XmSwt3ZLpW5OIHhhXFkRXNrj5XZb6lYRabRkaw+HdB+cDlOiXZn5imsmcpFXpBc5BZn2jsKygEyMbZhDUnM++3l9xJKov3Ni3AfVD6poD1Dmt1d+YGkrAlt9bVsoMqez+qS+feF/mzI4CBMau8/goZtCrVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8A3xcAp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36036C4CEF7;
	Wed,  1 Apr 2026 12:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775046548;
	bh=NvgNkEMAN52LEQ4N0hlij8TYcV+8I2cZgNeTB7K/fJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I8A3xcAp19J7C3Xq7hDDhs29w1fBgvrJxUzMTiATHfo83y6qixx/OtOlIz4gsNNlV
	 t9kI+WT9osbrw3iPmqkHIYOCwn/ebzfsLhlrfPaXFUn/oW1KSUjkxUVeOTPwtsTlPw
	 2UiLE0tfsSfbsVQMNC2mVZ0cMMZlOUdj2onG7DfhFbvSs0MloXFTNnQ/h8pXwmWWIl
	 8ZJvkdtZeh06N9R1OUQd0tcEy5NNXfT8OoW+0al4pVaDhuqanGENKddGYG4ezBf0cm
	 FgOOEyWAJ3f4fUF9T/4v1o1FeLGvElNCB5BPc0ucot+PO53jgRnUu0PWDVz/oNzGE9
	 idVNg2ikk+cYQ==
Date: Wed, 1 Apr 2026 17:59:01 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>, linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org, 
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] scsi: ufs: ufs-qcom: Fix spelling mistake "retore"
 -> "restore"
Message-ID: <sfyaonr2izg2xynwuwh7xvxvn4jmml7talyp2ntx3asv3eoujq@ryi6p6sliwam>
References: <20260331153049.1344957-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260331153049.1344957-1-colin.i.king@gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22655-lists,linux-scsi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C89637A991
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 04:30:49PM +0100, Colin Ian King wrote:
> There is a spelling mistake in a dev_err message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/ufs/host/ufs-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index 5a58ffef3d27..bc037db46624 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -2810,7 +2810,7 @@ static int ufs_qcom_get_rx_fom(struct ufs_hba *hba,
>  	/* Restore Power Mode. */
>  	ret = ufshcd_change_power_mode(hba, &old_pwr_info, UFSHCD_PMC_POLICY_FORCE);
>  	if (ret) {
> -		dev_err(hba->dev, "%s: Failed to retore power mode to HS-G%u: %d\n",
> +		dev_err(hba->dev, "%s: Failed to restore power mode to HS-G%u: %d\n",
>  			__func__, old_pwr_info.gear_tx, ret);
>  		return ret;
>  	}
> -- 
> 2.53.0
> 

-- 
மணிவண்ணன் சதாசிவம்

