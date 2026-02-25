Return-Path: <linux-scsi+bounces-21155-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OfgDJgbn2kzZAQAu9opvQ
	(envelope-from <linux-scsi+bounces-21155-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 25 Feb 2026 16:56:08 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D11BA19A11C
	for <lists+linux-scsi@lfdr.de>; Wed, 25 Feb 2026 16:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA0593198A3E
	for <lists+linux-scsi@lfdr.de>; Wed, 25 Feb 2026 15:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E4F3E9F84;
	Wed, 25 Feb 2026 15:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pkUse5Px"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E823E9F7E;
	Wed, 25 Feb 2026 15:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772034543; cv=none; b=d7YAGYEWHSQKYupMMgR3285oABVR//4OlmFZ8vvObJ7OiQuvI77eF/0kFrzxjt5WD+8zggznFz633gApp4H7sAFdbM50BJ1gwrM6YzkKnIb/10ERAYVlRhFqfyeQfgpUAHRW5RJ5KqhDkJOCpHLjUjqC24IDmJQyLOdkIJcAXl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772034543; c=relaxed/simple;
	bh=RaSrwPLR4Sem1Lt2v4ifHKpxppPfAz8NYD3EMNdTsSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YR+GRI77ae20LzMzUyQqA48pffu1BrbR2ej80+PUn4SW/InQ6Iac0NzuDAVt49M2xOycs6Y2ZM1UvzM1rcVgLNtW/RWBDEw/wwk9GctndqXHRqGLOEi77mlD6FqfXvWMXEGZlQmBSsfRD+sGv9gV59WYoudlfkRrAln1tTXJJPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pkUse5Px; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F75C116D0;
	Wed, 25 Feb 2026 15:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772034543;
	bh=RaSrwPLR4Sem1Lt2v4ifHKpxppPfAz8NYD3EMNdTsSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pkUse5PxFcwbf+SRzZXiiIq59f4ai8efE59MRMV9mr0GHErIxXLI5+rMW8kVndVVj
	 8noe+BA0fs2ZXHP+5ZcU51l+/cRv1dw89FsVEt/v65bIcGtk/AMBpGjxSZpHYRg7uu
	 RWzoUg+kT0p9OPduwqpbY6u7QdautQJELpuQBoNLlQOLtdOAJ2Uc9c7NaTAGI2wEV1
	 Y7JkznoRxdkXMxy/V7BdsN2cbEI32FjlF8MjckA2cVKkW9MViDCSvTJ0OCyUqQPHUK
	 uWQsCnSxtuyGW1n6Kr+bUTwbqOPXHzqC2RGidm38wlJ639QPbgpAZ+K4j0bSSACY71
	 q6YPD4Fy5XpYw==
Date: Wed, 25 Feb 2026 08:49:00 -0700
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, sagi@grimberg.me, axboe@fb.com, martin.petersen@oracle.com,
	james.bottomley@hansenpartnership.com, hare@suse.com,
	jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, michael.christie@oracle.com,
	snitzer@kernel.org, bmarzins@redhat.com, dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/13] libmultipath: Add PR support
Message-ID: <aZ8Z7A4uOFfOTDeY@kbusch-mbp>
References: <20260225153225.1031169-1-john.g.garry@oracle.com>
 <20260225153225.1031169-10-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260225153225.1031169-10-john.g.garry@oracle.com>
X-Rspamd-Server: lfdr
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
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21155-lists,linux-scsi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kbusch@kernel.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D11BA19A11C
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 03:32:21PM +0000, John Garry wrote:
> +static int mpath_pr_register(struct block_device *bdev, u64 old_key,
> +			u64 new_key, unsigned int flags)
> +{
> +	struct mpath_disk *mpath_disk = dev_get_drvdata(&bdev->bd_device);
> +	struct mpath_head *mpath_head = mpath_disk->mpath_head;
> +	struct mpath_device *mpath_device;
> +	int srcu_idx, ret = -EWOULDBLOCK;
> +
> +	srcu_idx = srcu_read_lock(&mpath_head->srcu);
> +	mpath_device = mpath_find_path(mpath_head);
> +	if (mpath_device)
> +		ret = mpath_head->mpdt->pr_ops->pr_register(mpath_device,
> +				old_key, new_key, flags);
> +	srcu_read_unlock(&mpath_head->srcu, srcu_idx);

Instead of having the lower layer define new mp template functions, why
not use the existing pr_ops from mpath_device->disk->fops->pr_ops?

