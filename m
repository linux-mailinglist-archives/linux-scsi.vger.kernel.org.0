Return-Path: <linux-scsi+bounces-20467-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMcuBpBkcmnfjQAAu9opvQ
	(envelope-from <linux-scsi+bounces-20467-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 22 Jan 2026 18:55:28 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D96B6BC81
	for <lists+linux-scsi@lfdr.de>; Thu, 22 Jan 2026 18:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92B15303433D
	for <lists+linux-scsi@lfdr.de>; Thu, 22 Jan 2026 17:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3ED344D82;
	Thu, 22 Jan 2026 17:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F38KOQLm"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D115F258CD9
	for <linux-scsi@vger.kernel.org>; Thu, 22 Jan 2026 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769103019; cv=none; b=RM+LAgOvFfxbGERkrUn9tRisOBQ9l7ABLzvvveH45j93ugqLF/TP5ys7//z+yQUTM+/8vsxhMJKPi3wpH/dmM4eGlZMHYfqt8um3PIbHPK5K9Nji+l+Rzm0/x9lk91oKWkOG0i9X9oXl5Mt7bkIUQzO0tFYuxH1ZMuIY5LD4iHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769103019; c=relaxed/simple;
	bh=8QNBzMPghCOM7ZYUHPaPh/rur2a5RCd1YipM1oEp4NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBz2v5fGLl4yyUAAlImqmjTdTITmA6x1QchDMEePZ3y0Enu2bBO+G5LcGEkfed3WYLZt+hl62F5iULaUwmica7LWj2ZAXNr41lBcT3LuQNnZ62XSeRl6AMKdpO6oGSv45+T7+PlsuxcuTDJFQnQVMSAtlF81/eZyIGWA8/rhOzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F38KOQLm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AFFC116C6;
	Thu, 22 Jan 2026 17:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769103018;
	bh=8QNBzMPghCOM7ZYUHPaPh/rur2a5RCd1YipM1oEp4NY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F38KOQLmd8FUJO3draQHdnfJlcR5LUiDQyO8P6YVyaheYyGA6j2vmYC4lmfXA3npN
	 PX5EVXtBRltI0CYfd0xKxH/iIVYZ0cmJj0Uw1zDhWdDlue4kTVih8SqNfyphwyLxqu
	 v+u+mWpqBfPjY/jfBsbgqi5839OZLS1NXhuRkwhyI2UO0GkZtsJtw/qwB2YmzlxfYE
	 W7hhmRoY93PNrveWvZK+cNOc8H1yc0IEpJnpHLuGlwYexbzos24b+hSixnsUJ4ZPES
	 D770d7PyjggVZh9ad61yFQLMN1cnMOG9k24w5JMTSSSVPZwouqV5ZwdUJKpeV2mh4I
	 ECBA2L2PfV11w==
Date: Thu, 22 Jan 2026 23:00:12 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, 
	linux-scsi@vger.kernel.org, Nitin Rawat <nitin.rawat@oss.qualcomm.com>, 
	peter.wang@mediatek.com, alim.akhtar@samsung.com
Subject: Re: [PATCH 0/7] ufs: Remove the clock gating code
Message-ID: <r3upegmcqg5fxo22u63dwtwrlc7qpwi57drlvujtw4jkbinx7f@xluie2klyr55>
References: <20260116182628.3255116-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260116182628.3255116-1-bvanassche@acm.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20467-lists,linux-scsi=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mani@kernel.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9D96B6BC81
X-Rspamd-Action: no action

+ Nitin, Peter, Alim

On Fri, Jan 16, 2026 at 10:26:02AM -0800, Bart Van Assche wrote:
> Hi Martin,
> 
> There is some duplicate code in the UFS driver: both the runtime power
> management (RPM) code and the clock gating code switch between the same
> low-power and fully-powered state. Since the RPM code is more efficient,
> this patch series remove the clock gating code. This change has been
> realized without modifying the driver behavior and without breaking the UFS
> driver sysfs interface.
> 
> Please consider this patch series for the next merge window.
> 

Hi Bart,

Thanks for the work! I did try to get rid of the clock gating feature a couple
of years ago as I also thought that it duplicates the behavior of the runtime PM
framework.

But when I discussed this change with Qcom UFS folks, I was told that getting
rid of clock gating will have a negative impact on the runtime power consumption
on Qcom platforms as most of the power hungry resources are gated by the clock
and there will be added latency with going through the runtime PM framework.

Nitin is working on measuring the power impact of this series on Qcom
platforms to verify whether the above concern is really valid or not. So I'd
request to hold off this series until he gets back with the analysis, since this
series is very critical for us.

It'd be good if other vendors like Mediatek and Samsung also carry out the power
impact analysis on their platforms.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

