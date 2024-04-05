Return-Path: <linux-scsi+bounces-4201-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BF789A56E
	for <lists+linux-scsi@lfdr.de>; Fri,  5 Apr 2024 22:09:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D4C4282DC0
	for <lists+linux-scsi@lfdr.de>; Fri,  5 Apr 2024 20:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBAA173356;
	Fri,  5 Apr 2024 20:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="fs9T8bPU"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFDA5D905;
	Fri,  5 Apr 2024 20:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712347760; cv=none; b=hYturIqRP28KmquHvWQfHbwA5lNqokIMi03XI6WMty1eHs9v840o9t5gfGBifThjFaTC4jb1oOF+b48QeeFkjGh/2iC03l1Q8vP/Zw+tFkaDz+dWKCvUD4DrFT/wOk87coxIUPaTYVJiggnHcoaMEmp+uQSJhtWCZMOxWKdTakY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712347760; c=relaxed/simple;
	bh=Pf5hVeBCPXQE5mwDi3AN+qOMNB5RT09FSmucmQChsqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=odG4/pA2wgtzYajPDNm3hjjxz1tmXW6JHrmbXouzMW6tBbE1Bsq70QwwhV//zDIrkpY82pQYaFTIXY1YjKDAoxJwVJs6QX1JP2CmgW48FMNL6CI4NCdUY+Gi8IRsLN7CWujzb7easOIUxI3fJNLSW0SQd2ntXPE0g9l4u/20nQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=fs9T8bPU; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VB8hZ2fBSzll9bq;
	Fri,  5 Apr 2024 20:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1712347756; x=1714939757; bh=Pf5hVeBCPXQE5mwDi3AN+qOM
	NB5RT09FSmucmQChsqU=; b=fs9T8bPUClU8lCb+CrrnF/Ok1joLoaWk1nmqJX6z
	sIqfJEPaztR5kZwl6wYEgAJX49gMszGr9TQWxxhLqyTUPBrGy7fOnrAebFYy7Vew
	nRDsaMHoqskb+eWk4kAVrusY8Fjl3EDacCBE8atIOrnB5OQkxkX/GIhTekvpL9xe
	+XE8ZxCz/H/fxibb0KJMS1wMPdUOs5UFkD9n7866+eV9vSfUYPvsAA3dHs5+RC6Y
	+//HixGKHeh1eNeRDGQHBF04+VvNifeAn3UaxBKWqcTgTe4m00tirBjISi6Xl6ug
	h0M27jYicC3Ys3emW+fCa1VxKaHEswTSJ3MX7hiJiCKQUA==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id vQ2p2-5vNCAk; Fri,  5 Apr 2024 20:09:16 +0000 (UTC)
Received: from [100.96.154.173] (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VB8hT0bgZzll9bs;
	Fri,  5 Apr 2024 20:09:12 +0000 (UTC)
Message-ID: <1eb43f25-10ab-4d38-94d5-9557856c2933@acm.org>
Date: Fri, 5 Apr 2024 13:09:11 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/28] block: Introduce zone write plugging
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240405044207.1123462-1-dlemoal@kernel.org>
 <20240405044207.1123462-8-dlemoal@kernel.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240405044207.1123462-8-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks a lot for having implemented zone write plugging!

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

