Return-Path: <linux-scsi+bounces-20697-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMg7JT3dg2lfvAMAu9opvQ
	(envelope-from <linux-scsi+bounces-20697-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 05 Feb 2026 00:58:53 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2780ED5E6
	for <lists+linux-scsi@lfdr.de>; Thu, 05 Feb 2026 00:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 210CA301952B
	for <lists+linux-scsi@lfdr.de>; Wed,  4 Feb 2026 23:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303A83A0E86;
	Wed,  4 Feb 2026 23:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsA0d1ix"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46B23A0B3C;
	Wed,  4 Feb 2026 23:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770249504; cv=none; b=QsBwbnosdYQyMag9HXyzkpIQFIGRT/bDPE1L7l20h8quYR/Bj3mCXHRnpjn6OQne+ZPz/dIXkLsmzy8l9G97Tatn7JAIkc4pqQTlIMfeQMFrq5hkGYHQhP4biTjL8gc4UuLKeKsO0pNJzHw7UP2xsZm6ByJ1+iUOVhtOtrG77BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770249504; c=relaxed/simple;
	bh=2cV4UVjiC81EBWIuek7KsBae1DF6Y5C0da9AAPdyTq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmrJDfyBlVOg3dT9u4euQ2lBZ4UEaSgT1OJ0t7HUHu7ZLAxePhyz4mQ4Rs9RdbxM7fFVgjNS/LtJmjhLhGYtrO5jGLymbiupkq5Lub5gJY/AoBXtikGWdmGwRMY3Rgumg04uxXftkjcdfh7PmgJ4FPQ4WiyCU89WSr6+WmS5ctQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsA0d1ix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309FDC19423;
	Wed,  4 Feb 2026 23:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770249503;
	bh=2cV4UVjiC81EBWIuek7KsBae1DF6Y5C0da9AAPdyTq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EsA0d1ixdQtdwzh2FlT0UUVw7EubhQmyvqGdpi3JfJj4St22XKtFkf9+FrDZYBSJU
	 Kp0hvNsFz7h6B4lLwEW/TOsb4k1IUdSEw/VYb7PctxhcYQKBOTdXp50FGtLWVXtcHu
	 2SCPd9DbkX9O/e25wXFaU4ldSb764sIahmurnuNNH7bthLuLKfYQNmhlky/dvAujW+
	 r682F6sOL8GXg3DevxUAH9UnxXvLQvgkhxRTSSK9uuespZHfW2yQcJUfWUooNtxaT3
	 gIVEkRafjzcY6bnHUg7tTiPhw4fYAdELq/gyCUX8z59KXrnAm2bezVzuNwQO2Q3YlZ
	 2OaNjbpmgmSlQ==
Date: Wed, 4 Feb 2026 16:58:21 -0700
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	lsf-pc@lists.linux-foundation.org, Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Block storage copy offloading
Message-ID: <aYPdHYvuLeIevwUJ@kbusch-mbp>
References: <0cfe6fe2-3865-4dc2-92a7-74b1240f7b63@acm.org>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cfe6fe2-3865-4dc2-92a7-74b1240f7b63@acm.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20697-lists,linux-scsi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kbusch@kernel.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-scsi];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F2780ED5E6
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 02:19:44PM -0800, Bart Van Assche wrote:
> Adoption of zoned storage is increasing in mobile devices. Log-
> structured filesystems are better suited for zoned storage than
> traditional filesystems. These filesystems perform garbage collection.
> Garbage collection involves copying data on the storage medium.
> Offloading the copying operation to the storage device reduces energy
> consumption. Hence the proposal to discuss integration of copy
> offloading in the Linux kernel block, SCSI and NVMe layers.
> 
> Other use-cases for copy offloading include reducing network traffic in
> NVMeOF setups while copying data and also increasing throughput while
> copying data.

I'm interested in the topic. I'm just not sure about the approach. If it
doesn't support vectored sector sources, then it's much less
interesting. From the host point of view, I'd like to be able to submit
arbitrarily large bio's to the block layer that can be split and merged
for optimal alignment to hardware limits. The two-bio approach looks
overly complicated with respect to that.

