Return-Path: <linux-scsi+bounces-21024-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGn3LSy4nWmQRQQAu9opvQ
	(envelope-from <linux-scsi+bounces-21024-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Feb 2026 15:39:40 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DFF1887EC
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Feb 2026 15:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A13630612B4
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Feb 2026 14:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18D43803DE;
	Tue, 24 Feb 2026 14:39:38 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8158378806
	for <linux-scsi@vger.kernel.org>; Tue, 24 Feb 2026 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771943978; cv=none; b=dTsfOaGmGKolHnZniQCQHBD5GGEIxss+Y4BZWe5KL7J8/166LDxTdRNVlcc318bG8pzfOXeloVArlIqLOmQEojFY1JLaDiwyWcgyaKRP285JyqGSiZ75G8LA0XUSvuvImgGH4NmEtJfU8nqlgWor/jPtkFvlt8jjxPO9GwKY2as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771943978; c=relaxed/simple;
	bh=1orXDs7XaAUTK7dIA6tofH7Rrv1ucjLAJOFaGuE797s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVOuJnCSRdU37HbNeWdt865XKxrhMC2+9gCcbmgjE9l+NZVuHaQUOBWUOhxb8Qb4yVbKv1NGGzrgaKnIk9uolyVZnUD+vLGA+cjhMU9FerJhtRWBbqOe8P8TWJqpEUCK4twSkgEsY91amcDhf/f86SsH2w0IvuSLZwOPdIChwwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 79F6E68D07; Tue, 24 Feb 2026 15:39:33 +0100 (CET)
Date: Tue, 24 Feb 2026 15:39:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de, chaitanyak@nvidia.com,
	bvanassche@acm.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	James.Bottomley@HansenPartnership.com, mlombard@arkamax.eu,
	jmeneghi@redhat.com, emilne@redhat.com, bgurney@redhat.com
Subject: Re: [PATCH V2 3/3] scsi: Convert async scanning to use the
 completion chain helper
Message-ID: <20260224143933.GC12308@lst.de>
References: <20260224122505.52401-1-mlombard@redhat.com> <20260224122505.52401-4-mlombard@redhat.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224122505.52401-4-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-scsi@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:mid];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21024-lists,linux-scsi=lfdr.de];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 73DFF1887EC
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 01:25:05PM +0100, Maurizio Lombardi wrote:
> diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
> index 7a193cc04e5b..d8a157bc9078 100644
> --- a/drivers/scsi/scsi_priv.h
> +++ b/drivers/scsi/scsi_priv.h
> @@ -132,7 +132,7 @@ extern void scsi_exit_procfs(void);
>  
>  /* scsi_scan.c */
>  void scsi_enable_async_suspend(struct device *dev);
> -extern int scsi_complete_async_scans(void);
> +extern void scsi_complete_async_scans(void);

No need for the extern here.

> +DEFINE_COMPL_CHAIN(scanning_hosts);

This looks like it should be marked static.


