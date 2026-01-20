Return-Path: <linux-scsi+bounces-20430-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEb1DMJPcGlvXQAAu9opvQ
	(envelope-from <linux-scsi+bounces-20430-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 21 Jan 2026 05:02:10 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BB02C50C1E
	for <lists+linux-scsi@lfdr.de>; Wed, 21 Jan 2026 05:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5287D74C419
	for <lists+linux-scsi@lfdr.de>; Tue, 20 Jan 2026 13:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F782426EAF;
	Tue, 20 Jan 2026 13:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfBvL6Z0"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF4A33F36E;
	Tue, 20 Jan 2026 13:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768914696; cv=none; b=GMAbreVZlLi+JjnbwBP7MX0p7Eau5zFsJdgtWkG0z+++5pzYae3O6Bolt4Q9rXcgZPDEoQoQFxS8oZ20qhMstjduhMx0HbPcX7dqhJd+LbfIgaPnrldWOjVhMDq7zYliKtdqSnXd88Y7XKId7kpBJN4Ier88+9KmNNP5hw9LSLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768914696; c=relaxed/simple;
	bh=wNUhyMD6goK687xUqdP074iKnGrjkbgmwK13qo7KA+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pm8TrSuKKVXSJjqHmoi+bl33KqUA9FhymitZ7sdJFTSYhUqq6GeQhSyOwNtyjSSY5vMJP/0RS4/FW3lAIvjgtFnaJrJWU3CMhSWFp2/vnga2YfFp3Chwm2mlytzorI8rr8NdYEBwAYNAbZV4hQlLpXOR5F3eJoPuN9FYRKF1GZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfBvL6Z0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E74C16AAE;
	Tue, 20 Jan 2026 13:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768914695;
	bh=wNUhyMD6goK687xUqdP074iKnGrjkbgmwK13qo7KA+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VfBvL6Z0qnfuD1GwyQlodp/yIF/YSCI/0yuMKMz2pOAthxJq8AerY9HlFP7LdKO/x
	 wvPTts4ZFNNezVYg7ipYcY2m3peKBJuAcYp28tTh2zsCacOQJ8OscqW9YgPRzFnXWo
	 C10v7ySPGJo9mAI4PsIP3OJopmJLdtFnrkrA809ZOfJb2ZcQWxt9OqmVoKod7kV7Lv
	 FhuTUmncaXSPGb9I5ENVBiSWPySLJkPI7QTjabJjNTldMtR/TYTp64wj/Jmd9EJfIR
	 8rnAAt+uLy0PkHhlMoX+qaHYgNEFNOFhbSn0wK6q6aLRB36kj7U220Ut9vG36BSPxq
	 7Ttes8r8RvXVQ==
Date: Tue, 20 Jan 2026 21:11:31 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
	Greg KH <gregkh@linuxfoundation.org>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: core: Don't free dev_name() manually
Message-ID: <aW9_A22PyeYEgJOv@tzungbi-laptop>
References: <20260117193221.152540-1-tzungbi@kernel.org>
 <de7b19fe19ccb117cad8cd32d9c51796ee81b752.camel@HansenPartnership.com>
 <aW4_fbfNUMTDTAN1@tzungbi-laptop>
 <9308e357ecff18971b216c5e037b89b66acf7606.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9308e357ecff18971b216c5e037b89b66acf7606.camel@HansenPartnership.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20430-lists,linux-scsi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tzungbi@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: BB02C50C1E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Jan 19, 2026 at 11:02:55AM -0500, James Bottomley wrote:
> On Mon, 2026-01-19 at 22:28 +0800, Tzung-Bi Shih wrote:
> > On Sun, Jan 18, 2026 at 09:45:26AM -0500, James Bottomley wrote:
> > > On Sun, 2026-01-18 at 03:32 +0800, Tzung-Bi Shih wrote:
> [...]
> > > > >  
> > > > >  static struct class shost_class = {
> > > > > @@ -279,11 +278,9 @@ int scsi_add_host_with_dma(struct
> > > > > Scsi_Host
> > > > > *shost, struct device *dev,
> > > > >   goto out_disable_runtime_pm;
> > > > >  
> > > > >   scsi_host_set_state(shost, SHOST_RUNNING);
> > > > > - get_device(shost->shost_gendev.parent);
> > > 
> > > We need a reference to the parent to prevent surprise removal ...
> > > where else is the reference held?
> > 
> > It looks to me the same question as above.  IIUC, device_add() holds
> > a reference count to its parent[3].  Drivers don't need to do it
> > explicitly.
> 
> That's not good enough for SCSI: we have a rather complicated state
> model for hosts.  device_add() doesn't occur until the host moves out
> of the SHOST_CREATED state, which can be quite a time after device
> _initialize() so something has to pin the resources until then, which
> is why these references are taken.   You're certainly free to suggest a
> different way of doing this, but you can't just get rid of the existing
> mechanism without replacing it with something else.

I may misunderstand: isn't the initial reference count from
device_initialize() held for the purpose (i.e., pin the resource)?  The
driver calls scsi_host_put() to drop the reference count when the underlying
chip is removing.

The proposed code to remove the get_device() just right before device_add()
in scsi_add_host_with_dma().  I don't see what else resources it can pin.

