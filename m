Return-Path: <linux-scsi+bounces-3728-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C34F890C8E
	for <lists+linux-scsi@lfdr.de>; Thu, 28 Mar 2024 22:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DD7D1C2777D
	for <lists+linux-scsi@lfdr.de>; Thu, 28 Mar 2024 21:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DAD13AD21;
	Thu, 28 Mar 2024 21:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ZSz9BCw5"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003171384AB;
	Thu, 28 Mar 2024 21:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711661557; cv=none; b=VVYm+vgzibPKNmHtPfH+auBRxSD3Wrk6FNDuG0ikA/4unIaVSBcpuFehQUPvmHs3xP5V4tqZcKwJ3xyulxmduXoK/gVkmim7nvF1TvfIMhqxFHcwF6ThqAF8ADTXGJFoGsE0rI9O8A8iajdBfjOOKvlGJPCYWKTiJRl/Hw6hTck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711661557; c=relaxed/simple;
	bh=/FzxR3EQc4bUd0qSMda+6BBxhFru4bnbB4Icj8JXxb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=spOGMSrKgOpOc+poTRjyO+0j3HTxPfswGw0X6Fauqmjizaw8jkmUuSskosbK4IflMckXRBHC+ctaf+V8am22138zDI8f4eLdn4Hid+uG/J0LiR2pYMWA5TqVq6v0IojQwqEoiUj56F2bD8+Ox7qWYgP7nJk1FDFzl8KzRUHKxBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ZSz9BCw5; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4V5GwM1q6Hz6Cnk8t;
	Thu, 28 Mar 2024 21:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711661552; x=1714253553; bh=/FzxR3EQc4bUd0qSMda+6BBx
	hFru4bnbB4Icj8JXxb4=; b=ZSz9BCw5QdTAh2NXrcz+D2utETF/kvLRO+rYKpyQ
	hoYHSB3q4krTYXDuhkayArIz5h0H2uRsTTKhzSu2JzwDgZjkzQqIgYO1bcNSDnXd
	2WH56+PkiWMoOGHg/HHcTETw0WIELxYRTnOm8ADsnTjvcoiqF647MlvhfKnnyU1R
	DhlEmOKiWJWgoVNEyMMkAiqtIBHXR1Sh7af/nupqLtt2VoTvUA6h/gpACaRICf4x
	2WQ1abfJi4ubKLt71JOWGqG3rYPtuqxKsCS7jXs8bWRjelzDC829b/ihFbaa1AH2
	SBI8kz4q527FEYS8PBotqznnh/k9R41/UbHLDjhpSsNdXQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id GxUt2PxOL9LG; Thu, 28 Mar 2024 21:32:32 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4V5GwG62Ggz6Cnk8m;
	Thu, 28 Mar 2024 21:32:30 +0000 (UTC)
Message-ID: <0bcd3fee-fc80-4efa-bb2b-eb9e141dbfd6@acm.org>
Date: Thu, 28 Mar 2024 14:32:29 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/30] block: Introduce bio_straddles_zones() and
 bio_offset_from_zone_start()
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <20240328004409.594888-6-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240328004409.594888-6-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/27/24 5:43 PM, Damien Le Moal wrote:
> Implement the inline helper functions bio_straddles_zones() and
> bio_offset_from_zone_start() to respectively test if a BIO crosses a
> zone boundary (the start sector and last sector belong to different
> zones) and to obtain the offset of a BIO from the start sector of its
> target zone.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


