Return-Path: <linux-scsi+bounces-23322-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMsPG7+h7mn6wAAAu9opvQ
	(envelope-from <linux-scsi+bounces-23322-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 27 Apr 2026 01:37:35 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 516BD46B8B9
	for <lists+linux-scsi@lfdr.de>; Mon, 27 Apr 2026 01:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1E53C3001CE8
	for <lists+linux-scsi@lfdr.de>; Sun, 26 Apr 2026 23:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D702DF13A;
	Sun, 26 Apr 2026 23:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCi2qJu8"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0436197A7D;
	Sun, 26 Apr 2026 23:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777246648; cv=none; b=ZlSqBU0x7NTgp9QvjeNIHBXAdGUSBajvNY657JDx5X2KAcouKm+z0/+bMGTMlRxZNhTe3RdiDUJEvt1IN4Z/L4eXtG0ikTZbf5aKDiO9DQ8QYKuCYGQpRbOF9DkPIxZ+7Pu61ZbtobGXQMEKm436V4kvlKtOgkTCh1+nnoBK038=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777246648; c=relaxed/simple;
	bh=sMDyinNuAsv12Ena7vNmBzeiWqr1LDKhrZyHoDLKWko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZLc6p74ZIXWU9mFIlx66r4Jnx6ATH1ROC6yBOa9uJol39bjCH28WdRZPU5d4NVKpsOsQziDneyazhD+FTcrGvrqYtuKmLinLSGY/jh/UUnzgSyScc47KzLC+5HXvEiTKUIDNl0C/yb1GPqn970IoJ7pXUaD1Dlj0UbpCPglFQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCi2qJu8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76688C2BCAF;
	Sun, 26 Apr 2026 23:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777246648;
	bh=sMDyinNuAsv12Ena7vNmBzeiWqr1LDKhrZyHoDLKWko=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fCi2qJu8R30u7fRMNg4NM6h2T3nsxrc98gRXW1hPLdDTKUXMcve7Yof7NtrgV2m6j
	 DGhdxPRVDlirpU/FSbSeW5+w/DCUFeJLkWDJcvwMaVagLE2JSnmgE9GsVbRqie0x8K
	 f1Nr5Mx1JygqCmPcVXC2P0uHg6dFyf0B15my5LP33wS6FU7/4NiYOW0zbqXfyHc5Bi
	 uJPeYdcLAAYE19ifV3xsRjgdNvYI9fobYmWVU7N/cpe8oBbOl7W852yxYYNDJObs0c
	 XxihEXToJyNS6Oitv/e7mNrSNQYRP61ujBXCInuLITvHeE9Ise9B6Sc9Am0n3hyVms
	 1cd7QjCpNTyiA==
Message-ID: <b1875ef5-a898-47ed-8cd4-1915d6097bcf@kernel.org>
Date: Mon, 27 Apr 2026 08:37:20 +0900
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] scsi: scsi_devinfo: add COMPAQ PD-1 multi-LUN
 ATAPI device quirk
To: Phil Pemberton <philpem@philpem.me.uk>, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Hannes Reinecke <hare@suse.de>
References: <20260426190920.2051289-1-philpem@philpem.me.uk>
 <20260426190920.2051289-7-philpem@philpem.me.uk>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260426190920.2051289-7-philpem@philpem.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 516BD46B8B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23322-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[philpem.me.uk:email]

On 4/27/26 4:09 AM, Phil Pemberton wrote:
> The COMPAQ PD-1 (OEM Panasonic/Matsushita LF-1195C) is a PD/CD combo
> drive that exposes two ATAPI LUNs: LUN 0 is a CD-ROM (TYPE_ROM),
> LUN 1 is a 650 MB PD (TYPE_DISK).
> 
> Add it to the SCSI device list with:
>   - BLIST_FORCELUN: tells the SCSI layer to scan past LUN 0
>   - BLIST_SINGLELUN: serialises commands across the two LUNs, since
>     the drive has a single transport and cannot handle concurrent
>     operations on both
>   - BLIST_NO_LUN_1F: the drive returns PQ=0/PDT=0x1f for unpopulated
>     LUNs instead of PQ=3; this flag tells scsi_probe_and_add_lun()
>     to silently skip them
> 
> The INQUIRY strings as reported by the device are:
>   Vendor:  "COMPAQ  " (T10 format, space-padded)
>   Product: "PD-1"
> 
> Signed-off-by: Phil Pemberton <philpem@philpem.me.uk>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

