Return-Path: <linux-scsi+bounces-23743-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFE3FluGA2ot6wEAu9opvQ
	(envelope-from <linux-scsi+bounces-23743-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 12 May 2026 21:58:19 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A05B9528E2D
	for <lists+linux-scsi@lfdr.de>; Tue, 12 May 2026 21:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D8F6303DD3C
	for <lists+linux-scsi@lfdr.de>; Tue, 12 May 2026 19:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBD938E8A6;
	Tue, 12 May 2026 19:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="zKdDE0io"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1170438758A
	for <linux-scsi@vger.kernel.org>; Tue, 12 May 2026 19:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778615895; cv=none; b=P7AUGeliNDpWQfCFzRSEMvY8ZQSDbX4GUgDL+fL7erE2bLgW/nW7pywEMQMDvVGrnS1UnVjsUNEoGNTAXLHo43UAdzT7S0FdplrPsXCLVVLjGG7qgWOzD8gkAIChrYvpx0HRpFxDAEkTZuzBazrOVJQRyKro8EVv2RCyWJrPdMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778615895; c=relaxed/simple;
	bh=N3N5ilA67KFrNT1T7qr62a5WqRYoGbe0pCV7+4fJiS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=N/Hx0bhLKP/dkS+nAWnVb3CiR4Ktfh63d3R9Im7mVQVES/MmUFJwUPhCMPHrOlgn7v8W+8MmzH/9ozLqEij8a/eNMczxwBHHdhsXjuD7TCncCSr2lMQZvS0hIVKLKlGQeLZFTd31VeE9foImOSvdOBe0rFvIoLxyA2U+KGXZlHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=zKdDE0io; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gFS7n06yNz1XM5kD;
	Tue, 12 May 2026 19:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1778615890; x=1781207891; bh=N3N5ilA67KFrNT1T7qr62a5W
	qRYoGbe0pCV7+4fJiS8=; b=zKdDE0io63EFvL06AiEvNOsVnBrXdfrFDaKwfZbK
	vVUEwjpSZo9L+IYlrAIIUszVQH4g69OTAd0XaWJezoBKj6rnthlKnFPwkpjhSU9B
	cSqRuxHQVT4JaTLZ6aGXCpTjnpekg3yHAkfVLjh1zrhi/lh1k98vuDSaaP0Vldyl
	coqPacPKZ4UL5QRGQQKo6/d97AZijVgibEWr9+CzR6f8oCQ3ttc2w83Pg9AtNCDk
	K6o3318N6P+HVfMvHFAyKIxkURDD4XIx3M/uK2hV+rQrhmym3iqmQu2F8PvAhbBD
	DSH1hvaiUBWrQkeZ40Sxx12qOFXagddOR+EK0QGk6r1kSA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id LuCDPvYJaR3S; Tue, 12 May 2026 19:58:10 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gFS7j5jFpz1XM5jn;
	Tue, 12 May 2026 19:58:09 +0000 (UTC)
Message-ID: <8eb6dbf6-4da7-4a5e-aed2-f9319721b6ee@acm.org>
Date: Tue, 12 May 2026 12:58:09 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] scsi: Fix return code handling in sd_spinup_disk
To: Mike Christie <michael.christie@oracle.com>, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
 error27@gmail.com
References: <20260511175317.114007-1-michael.christie@oracle.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260511175317.114007-1-michael.christie@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A05B9528E2D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23743-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[oracle.com,vger.kernel.org,hansenpartnership.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:email,acm.org:mid,acm.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/11/26 10:53 AM, Mike Christie wrote:
> As found by smatch-ci scsi_execute_cmd can return negative or positve
> values so we should use a int instead of unsigned int.
Reviewed-by: Bart Van Assche <bvanassche@acm.org>

