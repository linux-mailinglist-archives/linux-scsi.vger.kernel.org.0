Return-Path: <linux-scsi+bounces-20636-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAa4FghqfGn+MQIAu9opvQ
	(envelope-from <linux-scsi+bounces-20636-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 30 Jan 2026 09:21:28 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B26D0B848C
	for <lists+linux-scsi@lfdr.de>; Fri, 30 Jan 2026 09:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99BE2303CA63
	for <lists+linux-scsi@lfdr.de>; Fri, 30 Jan 2026 08:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED34352C47;
	Fri, 30 Jan 2026 08:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B21SdwEk"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1168F352F96
	for <linux-scsi@vger.kernel.org>; Fri, 30 Jan 2026 08:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769761224; cv=none; b=J/i1neltEOhCCczZPDvbMrasqxK4PrrnZdDPWMtKsGV0t2xjRJCFd14ZxJkwx/c3heIoRU6WcdiCmBFI6NlKLD95weq+AhbFMc2sw9nJehmrJP2sB1zoiul4KLUh9jlxJxqhPb2wKayTFwx2BpKQj9X+EaeAsmLseSIKIr7NEQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769761224; c=relaxed/simple;
	bh=wsB60SsaB/aPvZrKLMCQ5mnLRzC2S/En0vBPvRfcRK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uYayArLH3pe7dSeqALOn/+GkJTAyCQ0A5/ng0bn8AqF2dcBezLS32RvHNhlcqXVrISAxOkRSf+4+zdAvgtyNGkvyI1DoLit4HexVj8tjFbQ+ImYoLIHw6KAWrTazNYqvK/rYcmucebjTxjyz7ebhe4pyVlV+u9lfbFi9n2PkCW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B21SdwEk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99824C2BC86;
	Fri, 30 Jan 2026 08:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769761223;
	bh=wsB60SsaB/aPvZrKLMCQ5mnLRzC2S/En0vBPvRfcRK8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B21SdwEkErwDxdDE2njNng0qzcnZgL7uaWhYo+hoFsz0jWzNBHP+OdL4ViJ6Az7MF
	 mid65saBIFLJGTZGEJ3ETHbzRl8IcIVuLa/NZbEww1xt1rHhxfcP9UE2IV7C5z72RL
	 rVA8qcY4K9wzb6fhjP9zqm709qPeEK0DGfUYdJL2j8FGgICWVk0hC9ZdL02icxkzGK
	 HOrvuvJFYOqXXyWmyK0qTtwOhutLScAXNlKtEt6chQgEbxQzLFHkRVWTxgtj1/eRaP
	 NCcBulFIR3EjrRmPSvWJUOijNMjvys8jM7LnfZfF1os3FnN+duhdm/QEfZ7hdHg4kF
	 jB4Xw3f4AyBAg==
Message-ID: <0d646281-f3c4-422b-ada3-56b81775bce3@kernel.org>
Date: Fri, 30 Jan 2026 17:20:21 +0900
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: mpi3mr: Make driver probing asynchronously
To: Guixin Liu <kanie@linux.alibaba.com>,
 Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
 Kashyap Desai <kashyap.desai@broadcom.com>,
 Sumit Saxena <sumit.saxena@broadcom.com>,
 Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org
References: <20260130080207.90053-1-kanie@linux.alibaba.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260130080207.90053-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20636-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B26D0B848C
X-Rspamd-Action: no action

On 1/30/26 17:02, Guixin Liu wrote:
> Speed up the boot process by using the asynchronous probing feature
> supported by the kernel.
> 
> Set the PROBE_PREFER_ASYNCHRONOUS flag in the device_driver
> structure so that the driver core probes in parallel.
> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>



-- 
Damien Le Moal
Western Digital Research

