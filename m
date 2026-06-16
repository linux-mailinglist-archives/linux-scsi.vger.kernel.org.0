Return-Path: <linux-scsi+bounces-25021-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pdInNJRhMWpJiQUAu9opvQ
	(envelope-from <linux-scsi+bounces-25021-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 16:45:40 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 299AB690A32
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 16:45:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VMm5yA6o;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25021-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25021-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADE6730207D1
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 14:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2413B3890F7;
	Tue, 16 Jun 2026 14:41:11 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E4038E126;
	Tue, 16 Jun 2026 14:41:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781620870; cv=none; b=U+cRgDOGSimJox9MaSwW0PBOr2PZs4NPwS1DLEC4azX+a9pST3b+nEGvF17xcyReIc7UK1mCm7JJIs3ntN9Cy6qzmvYy69gg/Xqi9thqGGLmkIju77jMOe6pN5dX2cWurKOmKg1EdvvW47I8zCML7nmfmyflKz5O+GvvnlQl/Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781620870; c=relaxed/simple;
	bh=OjvWOd72oofwYk1RZDIhJiFu01Pylqt27dmk+xB+knM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oo25rveqwIJN+Aqro/PEI10p9J12qhWGDe5gFmv+Xe4zfiFlJQL1iPDCxUjBNVrFHTNPdV5w7Pc1xU0v1ljGvQhoO1lhhJ9GWLkcL9FmZXSuIhwEvdURJDXSQRHfBKmwZzpif+9rNeApYDWHG9WvrmYJM922I8BgI4M4A0jFsj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMm5yA6o; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF67A1F000E9;
	Tue, 16 Jun 2026 14:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781620869;
	bh=c9QTra+kbV8VYr3UBES6o1aA4Cc8/libaJin7AQVNQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VMm5yA6oJAvphvcK20Z9E9bgIdMOCWhAwm5IjBHMR766nO8TJdXGDJ/EWfkmkosz9
	 09n2ZZeHjSGIxLSJd6tIJ1kPpgfO6KBeyg2FjHSr99J8hvX2rzksMFJD8pmgvhZE7V
	 l+lSrT7oEaN8M8GXrl9oQEm5UoqMfSG5+0iwgQgxTjWghMDYv1MACoTbC9IfpgnEG2
	 6WCC0JtfPKr/JdBB2X72Cff5dqeZeKIEvRqIZfGxgEqnCRQEeEPLuSsK4eVZ1p3Fqc
	 v26tqKr19tvVQfyhNu59rwwx8LkwC6HGUHQy/Wtns0spynzVqK1UThAbZfIIqlMOdj
	 qlbpvcbgYI9Qg==
Date: Tue, 16 Jun 2026 16:41:04 +0200
From: Alexey Gladkov <legion@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: mptfusion: Fix array out of bounds error
Message-ID: <ajFggL0I9qDdzeY5@example.org>
References: <20260616124528.319527-1-legion@kernel.org>
 <20260616130423.A220B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260616130423.A220B1F000E9@smtp.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25021-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:linux-scsi@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[legion@kernel.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[legion@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 299AB690A32

On Tue, Jun 16, 2026 at 01:04:22PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Incomplete fix: Out-of-bounds array access in fusion sub-drivers due to unclamped ioc->facts.NumberOfPorts
> --
> 
> commit c993313579593bc432c039b88b1e748a26bc690c
> Author: Alexey Gladkov <legion@kernel.org>
> 
> scsi: mptfusion: Fix array out of bounds error
> 
> The driver retrieves the number of ports from the hardware. However, the
> driver can handle no more than two such ports. It uses a fixed array for
> them.
> 
> > diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
> > index 3a431ffd3e2eb..05bd556bb9383 100644
> > --- a/drivers/message/fusion/mptbase.c
> > +++ b/drivers/message/fusion/mptbase.c
> > @@ -3257,6 +3257,8 @@ GetPortFacts(MPT_ADAPTER *ioc, int portnum, int sleepFlag)
> >  		return -4;
> >  	}
> >  
> > +	BUG_ON(portnum < 0 || portnum >= ARRAY_SIZE(ioc->pfacts));
> > +
> >  	pfacts = &ioc->pfacts[portnum];
> 
> [ ... ]
> 
> > @@ -6701,6 +6703,7 @@ static int mpt_iocinfo_proc_show(struct seq_file *m, void *v)
> >  	char		 expVer[32];
> >  	int		 sz;
> >  	int		 p;
> > +	int		 numberOfPorts = MIN(ioc->facts.NumberOfPorts, ARRAY_SIZE(ioc->pfacts));
> >  
> >  	mpt_get_fw_exp_ver(expVer, ioc);
> >  
> > @@ -6755,7 +6758,7 @@ static int mpt_iocinfo_proc_show(struct seq_file *m, void *v)
> >  	seq_printf(m, "  MaxBuses = %d\n", ioc->facts.MaxBuses);
> >  
> >  	/* per-port info */
> > -	for (p=0; p < ioc->facts.NumberOfPorts; p++) {
> > +	for (p = 0; p < numberOfPorts; p++) {
> 
> [Severity: Critical]
> This is a pre-existing issue, but by only capping numberOfPorts locally here,
> does this leave the rest of the fusion sub-drivers vulnerable to out-of-bounds
> accesses?
> 
> The unclamped ioc->facts.NumberOfPorts is still used in several loops across
> the driver, where the bounds of statically sized arrays (like pfacts or
> fc_port_page1, both size 2) are exceeded if hardware reports more than 2
> ports.
> 
> For instance, in drivers/message/fusion/mptfc.c:mptfc_remove():
> 
> 	for (ii=0; ii<ioc->facts.NumberOfPorts; ii++) {
> 		if (ioc->fc_data.fc_port_page1[ii].data) {
> 			dma_free_coherent(&ioc->pcidev->dev,
> 					  ioc->fc_data.fc_port_page1[ii].pg_sz,
> 					  ioc->fc_data.fc_port_page1[ii].data,
> 					  ioc->fc_data.fc_port_page1[ii].dma);
> 
> Since fc_port_page1 is size 2, if NumberOfPorts is 8, could this read
> adjacent struct members of MPT_ADAPTER and pass them to dma_free_coherent(),
> leading to arbitrary invalid frees and a kernel panic?
> 
> Similar loops iterating over pfacts exist in mptfc_probe(), mptsas_probe(),
> mptspi_probe(), and mptlan_probe().
> 
> Would it be safer to clamp ioc->facts.NumberOfPorts directly after retrieving
> it from firmware, so all sub-drivers are protected?

Indeed. We could create a wrapper to retrieve MPT_ADAPTER that checks for
array index out-of-bounds errors. But there is one little catch here,
since we use NumberOfPorts to iterate over different arrays. We need to
synchronize their sizes.

> >  		seq_printf(m, "  PortNumber = %d (of %d)\n",
> >  				p+1,
> >  				ioc->facts.NumberOfPorts);
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260616124528.319527-1-legion@kernel.org?part=1
> 

-- 
Rgrds, legion


