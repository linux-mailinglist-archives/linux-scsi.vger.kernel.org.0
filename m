Return-Path: <linux-scsi+bounces-23354-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBF9MYhi72mHAwEAu9opvQ
	(envelope-from <linux-scsi+bounces-23354-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 27 Apr 2026 15:20:08 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E07C4734B0
	for <lists+linux-scsi@lfdr.de>; Mon, 27 Apr 2026 15:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01A27304C972
	for <lists+linux-scsi@lfdr.de>; Mon, 27 Apr 2026 13:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4203B6C09;
	Mon, 27 Apr 2026 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joHAxW4W"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38E7157487;
	Mon, 27 Apr 2026 13:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777295832; cv=none; b=tC9jpLE1spCTvm1TjSwbus7U6LI72Qs4RRma9JVX+CSFExXkYTcwePWnmC1M1TzRtpprpYO9LXt1V73xkiabhvQk5gK8kWUmemMyxC7nWVcpkRx7rloQgYF+JV34ptbsrvsl6Mgm+STsWFTtsozffSagccE6uWiBJq0U3WaY0BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777295832; c=relaxed/simple;
	bh=OxafrRHzBlPNg8L9aC86C2nZBeO46Wx/rGN16ZEm95E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HxLL4n63l6QcNEfL1iByN11E4M80veVaubRQY2vF/LJ6gJjxv2Rz8OUkgaH19suw/aT0gKUM9R0Znak5hQgjDbzsGrYLX2lXQd4zeQE6e7l8NCZM6iAcNYvpw6Q7Bsk0JIeTyQ9aA+gIb/QCcjFpi3EKV9f/LfyHFowjS6mW9cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joHAxW4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A37C2BCB4;
	Mon, 27 Apr 2026 13:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777295832;
	bh=OxafrRHzBlPNg8L9aC86C2nZBeO46Wx/rGN16ZEm95E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=joHAxW4W7TJYVeIFRL1HLqxVMbeuZxpvi9RqpPO16iTp52nKY89iJ7AiqYKVqfIGF
	 h8YCysKIRgb729mI4wyvryaPMr1NrFjaDxkliw2KF1ucD5edS4pcKr5p+LDgKZ0GO6
	 H/ncIWx2KTh4YtaMp1oWC2Ny26PoPgI4d8QqC/X3gB0oDXB9OlBdF97nGDoKP0BmAE
	 /94nxkoJgTcBlkfIFekgavX6x2+FdCOIXOCwN+bJUyBZEqCEYBZfmaVl/Tc9etXffx
	 ww/BXHr9aGsiGB4hUMGGBmauOBgHNJ3rnbvKtWQkdDOLPHlo2VNQI4JPh9/zJG0S0e
	 73jRtYH5GUk3A==
Date: Mon, 27 Apr 2026 15:17:08 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Xingui Yang <yangxingui@huawei.com>
Cc: dlemoal@kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, liuyonglong@huawei.com,
	kangfenglong@huawei.com
Subject: Re: [PATCH] ata: libata-sata: retry hardreset when device detected
 but PHY not established
Message-ID: <ae9h1PD38ydo_Dp4@ryzen>
References: <20260425060447.1312763-1-yangxingui@huawei.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260425060447.1312763-1-yangxingui@huawei.com>
X-Rspamd-Queue-Id: 4E07C4734B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23354-lists,linux-scsi=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cassel@kernel.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huawei.com:email]

On Sat, Apr 25, 2026 at 02:04:47PM +0800, Xingui Yang wrote:
> When sata_link_hardreset() detects that the link is offline, it currently
> returns immediately without distinguishing the reason. According to SATA
> specification, the SStatus register's det filed (bits 0-3) indicates:
>   - 0x0: No device detected, PHY not communicating
>   - 0x1: Device detected but PHY communication not established
>   - 0x3: Device detected and PHY communication established
> 
> This patch helps improve device detection reliability and adds a check
> when the link is offline but det filed shows 0x1, return -EAGAIN to
> trigger retry, rather than giving up immediately.
> 
> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
> ---
>  drivers/ata/libata-sata.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
> index b9d635088f5f..e5bb92c38e38 100644
> --- a/drivers/ata/libata-sata.c
> +++ b/drivers/ata/libata-sata.c
> @@ -667,8 +667,18 @@ int sata_link_hardreset(struct ata_link *link, const unsigned int *timing,
>  	if (rc)
>  		goto out;
>  	/* if link is offline nothing more to do */
> -	if (ata_phys_link_offline(link))
> +	if (ata_phys_link_offline(link)) {
> +		u32 sstatus;
> +
> +		if (sata_scr_read(link, SCR_STATUS, &sstatus) == 0 &&
> +		    (sstatus & 0xf) == 0x1) {
> +			ata_link_warn(link, "device detected but PHY not ready (SStatus %X), retrying\n",
> +				      sstatus);
> +			rc = -EAGAIN;
> +		}
> +

This looks like you are more or less duplicating the function
ata_eh_link_established(), untrouced in commit 4371fe1ba400 ("ata:
libata-eh: Avoid unnecessary resets when revalidating devices").

Could you perhaps try to reuse this function?

(It is currently private, so you would need to make it public.)


Kind regards,
Niklas

