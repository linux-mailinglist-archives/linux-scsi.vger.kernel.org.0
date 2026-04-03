Return-Path: <linux-scsi+bounces-22759-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOYBB2bGz2lH0QYAu9opvQ
	(envelope-from <linux-scsi+bounces-22759-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 03 Apr 2026 15:53:42 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F51394B8A
	for <lists+linux-scsi@lfdr.de>; Fri, 03 Apr 2026 15:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 477E7303456B
	for <lists+linux-scsi@lfdr.de>; Fri,  3 Apr 2026 13:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C912D12F3;
	Fri,  3 Apr 2026 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olgk4pjA"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E8D3242CF
	for <linux-scsi@vger.kernel.org>; Fri,  3 Apr 2026 13:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775224293; cv=none; b=eyfzBMAKjFmZ0UR6Ffr7bVt/q9ZFfMH52itQNqx+rDnJxssxiRy9ly8T3JLZNMfo8jZMCE6ThfLMBcgzDVb7Sp5oI9hh44pzQgvWChbOrSy3RzcxtaA8CrrNQ29+ptVD+kWAYbHtbRGGcJaDazuvuoX4HsV28mqGXBALMMDbGmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775224293; c=relaxed/simple;
	bh=ZUac92GPjEQgmONd7jpf7rHg2XaitqU6XgWriuw8/nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UQOYdCD405azbqpasaACAMiQZcZgCN7FLbd1oKKK/bTynMOZYMoiaOvNZWlKddTf6/JA1FSPjN3/XKO39Qj+XsDVAtZk0CkVvdnwyxBwWqzvZfOEaLBqvkbZQpyKyD2swFxncPI+hvtpui7U75i1vWZccHpRsf8SxD83oAVYnUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olgk4pjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21627C4CEF7;
	Fri,  3 Apr 2026 13:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775224292;
	bh=ZUac92GPjEQgmONd7jpf7rHg2XaitqU6XgWriuw8/nQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=olgk4pjAzJ08A6WfwBTRNCnqCA6KcxySVoveM72txfRl/Kv1tjNB4ZHnUzlQ55Ys5
	 fgjjCtSajjeHSgxaNuj0IXSORVSezh04V5HA+OF6XTee3ilAOkUCvlY5bEbzeHONSv
	 4VNpg3nz6jdSwvGkxnfJvgEh8zjPqKd2ssjJhhptsp/cJYH4Zsp5Uawt4+DPIwKnOB
	 vpp80i4wSI38yxSsTY+fHZO7EPSNjYr5G3JxVZIvzoI/ZtslSQHYLeWEP5eRHaAnPd
	 esyVQF+Z8i1hBGgH2eMyNzCeVjNl2MCalI8ePsjmiy5bRVX6l5NhSNAA+p+UX+NrnZ
	 YNZ8XbGReno8w==
Date: Fri, 3 Apr 2026 07:51:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Friedrich Weber <f.weber@proxmox.com>,
	Mira Limbeck <m.limbeck@proxmox.com>, hch@lst.de,
	martin.petersen@oracle.com,
	Sathya Prakash <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	Ranjan Kumar <ranjan.kumar@broadcom.com>,
	linux-scsi <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH v2] block: Increase BLK_DEF_MAX_SECTORS_CAP
Message-ID: <ac_F4nIj6vVm9c42@kbusch-mbp>
References: <20250618060045.37593-1-dlemoal@kernel.org>
 <291f78bf-4b4a-40dd-867d-053b36c564b3@proxmox.com>
 <ff5e2877-840b-4eb6-b449-bb64fb2e4097@kernel.org>
 <ac2256a0-25ce-4453-8c47-04cb7716d46a@proxmox.com>
 <7a0cfc66-3131-4b94-87f2-cbb96595ebb6@kernel.org>
 <9bf5286c-bac7-4cb7-9bfe-f47195e18b79@proxmox.com>
 <ac6FVPT3ZCDoVtb7@kbusch-mbp>
 <8198c919-1f4d-4d18-925b-f6c0e80d8b3e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8198c919-1f4d-4d18-925b-f6c0e80d8b3e@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-22759-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kbusch@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A2F51394B8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 08:25:04AM +0900, Damien Le Moal wrote:
> Thanks for this. But where do you see that the DMA pool size is 2M ?

It's not that the DMA pool size is 2M. NVMe PRP can describe 2M of data
with 4k worth of PRP entries.

I was thinking it's the "page_size", assuming it was 4k, but I misread
the argument order:

        ioc->pcie_sgl_dma_pool =
            dma_pool_create("PCIe SGL pool", &ioc->pdev->dev, sz,
            ioc->page_size, 0);

The dma element size is whatever "sz" is, and ioc->page_size is just the
alignment. It still doesn't seem like it's big enough, though.

The function _base_build_nvme_prp() takes a pointer to the pcie_sgl that
was allocated from that pool and writes the prp entries to it without
doing chaining PRP elements from the end of the list, so it looks like
it just overruns it if you have a large transfer.

> Looking at the code, it seems that ioc->pcie_sgl_dma_pool is created using
> _base_allocate_pcie_sgl_pool() with a size that is calculated as:
> 
>         /*
>          * The number of NVMe page sized blocks needed is:
>          *     (((sg_tablesize * 8) - 1) / (page_size - 8)) + 1
>          * ((sg_tablesize * 8) - 1) is the max PRP's minus the first PRP entry
>          * that is placed in the main message frame.  8 is the size of each PRP
>          * entry or PRP list pointer entry.  8 is subtracted from page_size
>          * because of the PRP list pointer entry at the end of a page, so this
>          * is not counted as a PRP entry.  The 1 added page is a round up.

This doesn't sound right because sg_tablesize refers to a scatterlist
that may contain multi-page entries, but nvme PRP's need a single entry
per page, so it's too low when you have contiguous memory.

