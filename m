Return-Path: <linux-scsi+bounces-25305-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SUNuMbn1Pmp7NgkAu9opvQ
	(envelope-from <linux-scsi+bounces-25305-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jun 2026 23:57:13 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBD16D0619
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jun 2026 23:57:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=iTq4AeQ4;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25305-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25305-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6DA83019835
	for <lists+linux-scsi@lfdr.de>; Fri, 26 Jun 2026 21:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5C63C0625;
	Fri, 26 Jun 2026 21:57:11 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009DF33BBBA
	for <linux-scsi@vger.kernel.org>; Fri, 26 Jun 2026 21:57:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782511030; cv=none; b=SHRfkwla/Dac+xE7sVq4SB8/heolUh4Ymr72r8XZbxzytRJlqimWwFvimEyxnpb2cMEWJr+Tt7TEU8Do2ixUohM4hDbYJZxtqEgSe/mt6LTvGD0oTYvWtpIR5u6wMfVRcQueawQC7qWXMC1lZBwmm0DQcyrEiiiqU+nUMfi1OcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782511030; c=relaxed/simple;
	bh=/r7fk9ade2lA1/AEyyxGFUoub79drY3ZZc1x2mRoqKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oHijBE2PhuDl4jxwI4sCQBVIYWoBmuQi2JxnsypGDGaLo4gIcHaG+ePQQnuoEQrydA+9tP4wP+GgguxS0Ds0IczTMMzBNNH/43SNGbZrlY2vNlhI6NmpsTXmDmSRRMDddAdNFzKwg77fw7PGSOvCYWQd34+rLAODFSI80ScE1U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTq4AeQ4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A6A1F000E9;
	Fri, 26 Jun 2026 21:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782511029;
	bh=j+0AwWNxSVHWsd/75D2iFe53ShMCUu1QE+uXSIYMGeI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iTq4AeQ4qPrOY82G2sUOm+e73/cGhKI71pZnWIvpG8FstjT+Pz7fJxgEbSXb8yM6I
	 4YMlqic79h95R4niDu1krdkFL52He4vh+yJ2ON7mqsAc+F9XAwDdFvxp744SoEmVAL
	 su0llMQFLjrbT0nKnIl4vIIQmKZrqMSixK+QoZlMNtQ/1vhZhHwTLOtmIUuiQaVqKi
	 Suk9SGsPL9z/jJ+XW01gqctk7zrVQP4ppCGNP0WqN0+kwTqkD+epPNAjgDC2PTJNgQ
	 WfDnEYzN8bwVwl8JCwTBCiOpyYc3gZoXTpVXJesPZxp+wRWf/tTbRoVXvUbtqfPf6U
	 VG63rzQM33lIA==
Message-ID: <c3c093ab-88c9-4a71-89dd-33ee69db1823@kernel.org>
Date: Sat, 27 Jun 2026 06:57:06 +0900
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] scsi: sd: fix special_vec mempool leak when
 scsi_alloc_sgtables() fails
To: Yang Xiuwei <yangxiuwei@kylinos.cn>, martin.petersen@oracle.com,
 James.Bottomley@HansenPartnership.com
Cc: hare@suse.de, tom.leiming@gmail.com, p.raghav@samsung.com,
 sw.prabhu6@gmail.com, linux-scsi@vger.kernel.org
References: <20260623100159.4018066-1-yangxiuwei@kylinos.cn>
 <20260623100159.4018066-4-yangxiuwei@kylinos.cn>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260623100159.4018066-4-yangxiuwei@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25305-lists,linux-scsi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yangxiuwei@kylinos.cn,m:martin.petersen@oracle.com,m:James.Bottomley@HansenPartnership.com,m:hare@suse.de,m:tom.leiming@gmail.com,m:p.raghav@samsung.com,m:sw.prabhu6@gmail.com,m:linux-scsi@vger.kernel.org,m:tomleiming@gmail.com,m:swprabhu6@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[suse.de,gmail.com,samsung.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1EBD16D0619

On 6/23/26 19:01, Yang Xiuwei wrote:
> sd_set_special_bvec() allocates a special payload page for UNMAP and
> WRITE SAME commands.  If scsi_alloc_sgtables() fails afterward in
> sd_setup_unmap_cmnd() or sd_setup_write_same{10,16}_cmnd(), the SCSI
> midlayer does not call uninit_command() because RQF_DONTPREP is not
> set yet, leaking the page.
> 
> Call sd_uninit_command() on error, and clear RQF_SPECIAL_PAYLOAD after
> freeing the page.
> 
> Signed-off-by: Yang Xiuwei <yangxiuwei@kylinos.cn>

This needs a Fixes tag I think.

But otherwise looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

