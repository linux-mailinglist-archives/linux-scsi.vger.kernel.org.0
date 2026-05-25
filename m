Return-Path: <linux-scsi+bounces-24073-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNIlAdjkE2rhHAcAu9opvQ
	(envelope-from <linux-scsi+bounces-24073-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 25 May 2026 07:57:44 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8645C61C1
	for <lists+linux-scsi@lfdr.de>; Mon, 25 May 2026 07:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B35183001A7C
	for <lists+linux-scsi@lfdr.de>; Mon, 25 May 2026 05:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE6135E1DB;
	Mon, 25 May 2026 05:57:37 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC18535E1DE
	for <linux-scsi@vger.kernel.org>; Mon, 25 May 2026 05:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779688657; cv=none; b=PdafSAqmE1pksqqG12sZqh4voA8wHoHLuWwORSeaC/9n2jZfgJTmNhEzakknKFUp17roDvKUshF041oB5o40JDsx3QfpcAliqlrPY1dL7WyUmwcy6pAsqFNtR3GVUdRFvyYPfaeEEiCpu3d5odmF4OURVwrKOt3Lo+yCkDtA3Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779688657; c=relaxed/simple;
	bh=DqaOJmKrURUeKk5FxaQDkBJ+9Kvab9nxgpLSrmIZZJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2iX5Gl7WfL2Bn26LPiWV5bUdfA9GvFPdXKHpIq1cSGErscI+5jpr9UL1eITANovmbUG3OEDQzdCLPBJTyqmq+nCsKxv9GIHdnBPPGbRPy44/I9L3H6D3yjdhVKftQDuOn2WrdR9g3IqRub+7ByhIEjejrra5LR2PAJVpLseUHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3BC8B68B05; Mon, 25 May 2026 07:57:33 +0200 (CEST)
Date: Mon, 25 May 2026 07:57:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Martin Wilck <mwilck@suse.com>
Cc: Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Christoph Hellwig <hch@lst.de>, Don Brace <don.brace@microchip.com>,
	ranjan.kumar@broadcom.com, linux-scsi@vger.kernel.org,
	Lee Duncan <lduncan@suse.com>, mpi3mr-linuxdrv.pdl@broadcom.com,
	storagedev@microchip.com,
	Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	MPT-FusionLinux.pdl@broadcom.com
Subject: Re: [PATCH v3 2/2] Revert "scsi: Fix sas_user_scan() to handle
 wildcard and multi-channel scans"
Message-ID: <20260525055733.GB3293@lst.de>
References: <20260513174236.430465-1-mwilck@suse.com> <20260513174236.430465-3-mwilck@suse.com> <9c6e8497-5e92-4d2b-ac87-3c941e6890a1@suse.de> <cf115b6142522889a62419c6ef9dc6b11837ccd3.camel@suse.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf115b6142522889a62419c6ef9dc6b11837ccd3.camel@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-scsi@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lst.de:mid];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24073-lists,linux-scsi=lfdr.de];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 0F8645C61C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 06:32:28PM +0200, Martin Wilck wrote:
> Frankly, no. There isn't much to test. Reverting 37c4e72b0651 restores
> the pre-6.17 state. Which means that the wildcard scan for NVMe devices
> on mpt3sas and mpi3mr, which was implemented by that commit, will not
> work any more. As written before, I propose the revert because this
> commit has severe side effects for wild-card scanning on other drivers.

And that's a good thing.  We should never have added this crap in the
first place, and Broadcom should have never done this stupid think
of hiding NVMe devices behind their HBA instead of just exposing it
through a real or fake PCIe switch.


