Return-Path: <linux-scsi+bounces-16270-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A63B2ADBA
	for <lists+linux-scsi@lfdr.de>; Mon, 18 Aug 2025 18:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D697E3BB7C9
	for <lists+linux-scsi@lfdr.de>; Mon, 18 Aug 2025 16:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B0933EAFD;
	Mon, 18 Aug 2025 16:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="GOge265F"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746298632B
	for <linux-scsi@vger.kernel.org>; Mon, 18 Aug 2025 16:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755532879; cv=none; b=E5RaLykLfgdiHxomKbv3TivVFPk3tZPXdopsPpq6b2wiGVJR0eqsxWQILAPq0gn9uGm5oygaJ4Z4Uv+H2C4mZa5d5LThPAf9tW/a+73GLOd5xQ3iTzkihuhCTRqt7CUlW+6EsLrriId14E7/YJiRXxcRmzffrz7InDCcfcxUEk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755532879; c=relaxed/simple;
	bh=T5ayIGWjyspNBM4I80tYz4b/DsdIFCCZzSx5WSnRS4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ut5D/ssxQSGDQbeUST4SQa1uW5qff3vkzJOodyMTXK0lL9w4KwhQ3MWT7AuuPpDszLo7HB6TRY4QuE8S5F1SSWIkWewTsYudk/55KsRcADcpW6jv9VWy8evoqoXifMhxm1p5/Y/ooU02xPas+QDjGgSWFmUF0ibyHJWKAMoOkfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=GOge265F; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4c5HWd3qqfzlgqTq;
	Mon, 18 Aug 2025 16:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1755532876; x=1758124877; bh=T5ayIGWjyspNBM4I80tYz4b/
	DsdIFCCZzSx5WSnRS4w=; b=GOge265F7jJMjlPc2VFKWAbSHNjFEQxhfqLQaQ3R
	sP7byeZjigg3re5qRLcME1BvLscrZwoXvvbrzD/cpurWUV1XyMl0DI5sukw64ZIZ
	VEM2uJ7GrPypd9Ay0uwtEBmPDo77Q22k4y5sAAlYip6vG71ilHJdMK4QfRi4k2CA
	/+p87e37O/Ci3f/Q0piEYjxnVEm/nmhFt+bSwILA6H404Tq/KPITsdnuV1+SCs2W
	OUZzId0N7ufHeVml8/ulkS687AeRBCV1KLWQCRc1yc5ND0sqBMwfofBv/kfJK0eA
	c0rJOsjbuMwmFqTYj20/hWjd97ZOO1BeBk9EDVpEoXu8yQ==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id xdhksKj1J1MP; Mon, 18 Aug 2025 16:01:16 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4c5HWW3JgKzlgqxq;
	Mon, 18 Aug 2025 16:01:09 +0000 (UTC)
Message-ID: <b9a825ca-605b-42f8-9776-2256a0c67ec8@acm.org>
Date: Mon, 18 Aug 2025 09:01:08 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/30] scsi: core: Do not allocate a budget token for
 reserved commands
To: Hannes Reinecke <hare@suse.de>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, John Garry <john.g.garry@oracle.com>,
 Ming Lei <ming.lei@redhat.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
References: <20250811173634.514041-1-bvanassche@acm.org>
 <20250811173634.514041-4-bvanassche@acm.org>
 <f2d65247-ad6b-44ea-a687-808d8c398afc@suse.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <f2d65247-ad6b-44ea-a687-808d8c398afc@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/18/25 5:23 AM, Hannes Reinecke wrote:
> Good idea, but we should document that somewhere that 'INT_MAX' now has
> a distinct meaning.

I think the comment added by this patch is sufficient. Any comment that
would be added in or above the struct scsi_cmnd definition is so far
away from the above code that it probably wouldn't be updated the next
time the SCSI budget management functions are updated.

Thanks,

Bart.

