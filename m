Return-Path: <linux-scsi+bounces-21022-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mO8sBXK4nWnERQQAu9opvQ
	(envelope-from <linux-scsi+bounces-21022-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Feb 2026 15:40:50 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE66518880A
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Feb 2026 15:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 977B8315C5EE
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Feb 2026 14:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32403A0B02;
	Tue, 24 Feb 2026 14:35:57 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DE83A0B09
	for <linux-scsi@vger.kernel.org>; Tue, 24 Feb 2026 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771943757; cv=none; b=cOe31+lqjMNLSnYxt5yvD7VOj02GW9g9wDujg8ldWqQ+LHoiGBbJGsyZYc/yEoszZyhHZoWvFbWkodmA1rnPRn29i+mtzJM3manRtZUXJCiz3tRFeLl4/3LpnKAX6F9dvz+Hgx5NwiYwIqHElfEwFww12wVMWOjvX9ygF1npr1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771943757; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUYBLrDcme+UpdZYuYQtkZVXqqx3wXqhC+qkia8KHceItWcutGS+aiQ2bbf6ONGGlOYfcXqXOjRm3VWkPmZFyE1ojWC5kVmWjxVMGGalo7ctSb7CP8vQFJzTqbVzl4e1p4kNHyuImEhwgAJrT+i0njR03hG/15ZHtiizIXBTeUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D61B768C7B; Tue, 24 Feb 2026 15:35:53 +0100 (CET)
Date: Tue, 24 Feb 2026 15:35:53 +0100
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de, chaitanyak@nvidia.com,
	bvanassche@acm.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	James.Bottomley@HansenPartnership.com, mlombard@arkamax.eu,
	jmeneghi@redhat.com, emilne@redhat.com, bgurney@redhat.com
Subject: Re: [PATCH V2 1/3] lib: Introduce completion chain helper
Message-ID: <20260224143553.GA12308@lst.de>
References: <20260224122505.52401-1-mlombard@redhat.com> <20260224122505.52401-2-mlombard@redhat.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224122505.52401-2-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-scsi@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:mid,lst.de:email];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21022-lists,linux-scsi=lfdr.de];
	R_DKIM_NA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: AE66518880A
X-Rspamd-Action: no action

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


