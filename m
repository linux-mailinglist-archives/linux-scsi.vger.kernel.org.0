Return-Path: <linux-scsi+bounces-11297-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C634A05880
	for <lists+linux-scsi@lfdr.de>; Wed,  8 Jan 2025 11:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E68093A632F
	for <lists+linux-scsi@lfdr.de>; Wed,  8 Jan 2025 10:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AB31F7580;
	Wed,  8 Jan 2025 10:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZwvNOTsu"
X-Original-To: linux-scsi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A71E1F3D53
	for <linux-scsi@vger.kernel.org>; Wed,  8 Jan 2025 10:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736333075; cv=none; b=ViHIGXTarV6H1GAVEX1G+YlFcMta3sz6gEYmQL9uQ5GBN8Q+VO72xINN/fhcomnuie9HKwm3+N07Sl+PGL0VesQHb83jGzLYefBH1jCXkmeqhLGVeGoTTbGZeI3vP3pgRlgRyS7iqVyS2ZIl+OGmC+Kc0Yglf85tmnc/298RRkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736333075; c=relaxed/simple;
	bh=ZUA9hXAvTO402Lqp6o9aZpjzmmWea7t6GMMUlrpj06I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrb1RId3w5FBvCt3JF6J/2eAglSngccaus9IboKqabGFljQmbxsm+N0dgUa8y+sV0KRWCXaH3yVf2KAuHELWHFhCYOtt92V4OFW8ffHmYk+skyKMh18QSepjl1QDWKLOmfsfxKXVRmlQ3IEGUoacoOmGUMR0NuuZphswCOK1HjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZwvNOTsu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736333073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B8+WjPvgGIbhzkcemmv78w2LxK9mcyjSw5bhvDUQPa8=;
	b=ZwvNOTsupawKXckwXxlCA9yDsCPJy/Zuy4UI6lBiyS2QG13LGucNjQqDe1rtSCFZHafiQD
	lBbHzPqYcNLR6unAwm6PzRYT70oGvV8FV4DKm11ukN5rWUVts8chCVijMOJIj9bApZa90n
	PdXfXvyuy7CztV7M+ItP0aUSVPRvbcs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-w-R51ZUcOOKsnr9FUL6S7Q-1; Wed,
 08 Jan 2025 05:44:30 -0500
X-MC-Unique: w-R51ZUcOOKsnr9FUL6S7Q-1
X-Mimecast-MFC-AGG-ID: w-R51ZUcOOKsnr9FUL6S7Q
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 52C9A1944B2E;
	Wed,  8 Jan 2025 10:44:28 +0000 (UTC)
Received: from fedora (unknown [10.72.116.74])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78259195608D;
	Wed,  8 Jan 2025 10:44:22 +0000 (UTC)
Date: Wed, 8 Jan 2025 18:44:14 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <dlemoal@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, nbd@other.debian.org,
	linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH 10/10] loop: fix queue freeze vs limits lock order
Message-ID: <Z35W_iLqwXKUKr75@fedora>
References: <20250108092520.1325324-1-hch@lst.de>
 <20250108092520.1325324-11-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250108092520.1325324-11-hch@lst.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Wed, Jan 08, 2025 at 10:25:07AM +0100, Christoph Hellwig wrote:
> Match the locking order used by the core block code by only freezing
> the queue after taking the limits lock using the
> queue_limits_commit_update_frozen helper and document the callers that
> do not freeze the queue at all.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks,
Ming


