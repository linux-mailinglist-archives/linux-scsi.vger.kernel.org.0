Return-Path: <linux-scsi+bounces-15359-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DED3B0CFE8
	for <lists+linux-scsi@lfdr.de>; Tue, 22 Jul 2025 04:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04033B815D
	for <lists+linux-scsi@lfdr.de>; Tue, 22 Jul 2025 02:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813CC273801;
	Tue, 22 Jul 2025 02:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4vpAhgc"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423321E2853
	for <linux-scsi@vger.kernel.org>; Tue, 22 Jul 2025 02:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753153050; cv=none; b=BqtHMJl3EP0VaaUUych48s/PWfwaogmX9GsSmgcPGXSmZJSwUsEx6GG4bawdZaQBbiOudsYfyiaxYOiDEjGjmHZYUpkdEGRhUAwLSWuCL6LkHdpW4J5uKhofEk6v5+XgP6S4uPF8aoEpr9KLQTRRJ+JpA8j4HvBCns2V+n85lfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753153050; c=relaxed/simple;
	bh=obx46y8kX606Lhxat/qkPD+aU0Igt2JtC0PlKp3SXqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkKEE0lWQhNQOHnBuNWMGgapwOJN4AclH1gCTnw/wJj+WkrWuxbfiI3V4Tg2eEHvb2kYe+oWgrZclM1Fmr51yOUnAtofgQYb8gnOHf6cBbCaNzXcbWBhsFpwIVIo829f5grVLYk4chuiYzupWFcGX7Tg4O4CDrrOKZiP3qgyoVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4vpAhgc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97ACAC4CEED;
	Tue, 22 Jul 2025 02:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753153050;
	bh=obx46y8kX606Lhxat/qkPD+aU0Igt2JtC0PlKp3SXqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J4vpAhgcRQd44hbO5IXbGXyMfwwJbjnsEixMidJQONtxMlRFuas/fvnahR5bbZyrs
	 MC53Q0TZvqNXRFN/sGVr9Sko2rQ+TdEzwOKzRQZZR9wz8XE6A8+vcj3wuscTSDX0em
	 Pd1+xIs7e1Uy0CuotntCTKDMKeP5fwboKwtA/ScYE6HXULlJn/9uhXni93vpN36uIc
	 6tCadwvdt75THGaSqu5CQImW9YRQurT3TmMQCwq4pqfQqz/vrN/BOd7VMAH8OIiY90
	 syrc6YEn2edhkMqZUJXOn3/DM9MF9NMpYIGgXK4rxHgGM/miSYTDbxjqqRGkIjiUOe
	 lXUr9u4AvPRLA==
Date: Mon, 21 Jul 2025 20:57:27 -0600
From: Keith Busch <kbusch@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: John Meneghini <jmeneghi@redhat.com>, Bryan Gurney <bgurney@redhat.com>,
	linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	axboe@kernel.dk, james.smart@broadcom.com,
	dick.kennedy@broadcom.com, njavali@marvell.com,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH v8 7/8] nvme: sysfs: emit the marginal path state in
 show_state()
Message-ID: <aH7-F2WxrhoCiK7O@kbusch-mbp>
References: <20250709211919.49100-1-bgurney@redhat.com>
 <20250709211919.49100-8-bgurney@redhat.com>
 <aG7pSA6TOAANYrru@kbusch-mbp>
 <35738598-0733-408c-8597-20c3599a8973@redhat.com>
 <aHa0JpsASqGuHdOA@kbusch-mbp>
 <ccb69ee6-bd5e-4585-9ccc-0c49cb30f1a9@suse.de>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccb69ee6-bd5e-4585-9ccc-0c49cb30f1a9@suse.de>

On Wed, Jul 16, 2025 at 08:07:51AM +0200, Hannes Reinecke wrote:
> On 7/15/25 22:03, Keith Busch wrote:
> > 
> > What you're describing is a "path" state, not a controller state which
> > is why I'm suggesting the "ana_state" attribute since nothing else
> > represents the path fitness. If nvme can't describe this condition, then
> > maybe it should?
> > 
> We probably could, but that feels a bit cumbersome.
> Thing is, the FPIN LI (link integrity) message is just one a set of
> possible messages (congestion is another, but even more are defined).
> When adding a separate ANA state for that question would be raised
> how the other state would fit into that.
> From a conceptual side FPIN LI really is equivalent to a flaky
> path, which can happen at any time without any specific information
> anyway.
> Again making it questionable whether it should be specified in terms
> of ANA states.

I see. Re-reading ANA, it is more aligned to describing a controller as
active/passive or primary/secondary to the backing storage access rather
than the state of the host nexus, so I agree it's not well suited
for an ANA state. :(
 
> > Where does this 'FPIN LI' message originate from? The end point or
> > something inbetween? If it's the endpoint (or if both sides get the same
> > message?), then an ANA state to non-optimal should be possible, no? And
> > we already have the infrastructure to react to changing ANA states, so
> > you can transition to optimal if something gets repaired.
> 
> It's typically generated by the fabric/switch once it detects a link
> integrity problem on one of the links on a given path.
> 
> As mentioned above, it really is a attempt to codify the 'flaky path'
> scenario, where occasionaly errors are generated but I/O remains
> possible. So it really is an overlay over the ANA states, as _any_
> path might be affected.
> This discussion only centered around 'optimal' paths as our path
> selectors really only care about optimized paths; non-optimized
> paths are not considered here.
> Which might skew the view of this patchset somewhat.

Okay, but can we call it "degraded" instead of "marginal"? The latter
implies the poor quality is endemic to that path rather than a temporary
condition.

