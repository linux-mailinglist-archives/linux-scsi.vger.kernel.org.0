Return-Path: <linux-scsi+bounces-3804-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 268E5892645
	for <lists+linux-scsi@lfdr.de>; Fri, 29 Mar 2024 22:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20431F2360D
	for <lists+linux-scsi@lfdr.de>; Fri, 29 Mar 2024 21:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6777B13C3D3;
	Fri, 29 Mar 2024 21:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="cBBrQzdd"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36E813BC2C;
	Fri, 29 Mar 2024 21:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711748620; cv=none; b=lwaI3xvOzT6jFb+U4z9sfCWCjYNFP7eZ6381XkdCA36uB6Sw0kSZRqgvYk4hkRIE8qdFw8vRWw2GtnYV9Idtjvv1CBnWWkA5J/Pnr5DadX4KgEOovh8Gd2T28Acbu2IwuLeXZxp6aJz1dC3tuUQ3ErPSUHMo2YBhs+kSJwESfgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711748620; c=relaxed/simple;
	bh=FRIggP1YvWWV3rj+5WU1Cj2nMoZrQOSbDSPE/2jMC40=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dLAEJRT/pcIs3FY0qLV3CWRCSHNwjvvGrFufa/I7D3pM/XAD68ICCXfxKyvdKFc3g5eGTVVLc9QXzuSiGP8VmATzDdREklrxfBMl/KcwjFQiKjauJoWbdbm1yGdinvvdA+0c6qK/M4zg1VgOX123+MprFVmGudzb/q8k4ShOZ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=cBBrQzdd; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4V5v6f01dWz6Cnk8t;
	Fri, 29 Mar 2024 21:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711748615; x=1714340616; bh=FRIggP1YvWWV3rj+5WU1Cj2n
	MoZrQOSbDSPE/2jMC40=; b=cBBrQzddoy8TX+qFDQlHOVqU61+r5AQqLhRoqOS4
	miWbUxy0HthAKqpGkllUlupJnhERp7h3bTX8PFv85rdoibMp5QSDpmHGrY3uLBVs
	jDWIuAt2PGIyvzMIWiSzd/p6uXy4/NoBtp9YIRhfn8Y25fe4TXixfW6advVfsSwu
	l3jZh6+shqxyCPbfXru9AVaG7RX1ehFY/pbbEZ1wyvtcv74x57ZRu6BP4en9jGxV
	Gb+reBvzc6LF9zV/lSPPtWYjTdy7ERdz4TEEDQpK6OYHqWhy9i8HsFFJ/NpvSjVL
	3SInO8pa+lpqnmZJVtUL81S/jUSdJmN3fIqGVglUTOFgug==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id eQxSU5qBAoXl; Fri, 29 Mar 2024 21:43:35 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4V5v6X4tdsz6Cnk8m;
	Fri, 29 Mar 2024 21:43:32 +0000 (UTC)
Message-ID: <d46b3533-af4b-45ac-a762-e1f8a0cd8aa8@acm.org>
Date: Fri, 29 Mar 2024 14:43:30 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 23/30] block: mq-deadline: Remove support for zone
 write locking
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <20240328004409.594888-24-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240328004409.594888-24-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

