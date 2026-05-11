Return-Path: <linux-scsi+bounces-23725-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CC7oBDk9AmrmpAEAu9opvQ
	(envelope-from <linux-scsi+bounces-23725-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 11 May 2026 22:34:01 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6592C515E7C
	for <lists+linux-scsi@lfdr.de>; Mon, 11 May 2026 22:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A436830416FF
	for <lists+linux-scsi@lfdr.de>; Mon, 11 May 2026 20:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F24383C64;
	Mon, 11 May 2026 20:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="SmRTOKVQ"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133E9382F0F;
	Mon, 11 May 2026 20:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778531358; cv=none; b=OFvPYh8lCH01myfqr01iZliEY6bYdGMrkaJ9N/lOIHduXuoyqfR3xbQR3MZb1Lh+eIQT+W0ujut3BZ3Bt3LkAO/0BXt26BPomQOre3tBbX66RQRZ+bChWLM6yFLXWDIw2AscHlvEP9Gq2N1/0f8hu49FYcB2ZQOpD7Ui7VdPycE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778531358; c=relaxed/simple;
	bh=ALX1DcuAGZICnqHSwIebe0EVk0XeNlG5pPBY5+BWxLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RpTOm4OnupVtdzJIFL25iriGsx9eR8rQ+QMZ6006VEbWaoAdjVATlmxcIHIOG1u664XIZ/eRVV2gEyrZQt0N6+6oAP1KBwH4VadtApKADjjYHxEOXilRBXMQzCuQbOBYefTmdTN3fp4FLOmT9e2H+Au37FQVJ67TtDPJQeP9oUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=SmRTOKVQ; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gDrt444QMz1XM6JN;
	Mon, 11 May 2026 20:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1778531354; x=1781123355; bh=ixyrTw49jB4fOP5+j7x5MU7x
	MLFh4Xqiye4S2vngAuo=; b=SmRTOKVQE0AYblQAzq+DU4WKVLDbmS3Gg3K1cd34
	unqMSEG+Q3UHIrvQKT+rzZDYkF5L+1F7v3c2UsWAKX+yNyoo6PC35SXEu1h93PMM
	/7Yfy8w0ON+XroWAGXOctWiR0nQQ+a+btl8epWrqgd7MD2YsJJgpH0W6Tv1BcBGx
	hbrFme9eWqblBth7NSAO3MLhtf3+fjhamNs1ZF7QPgW75ZgFvODVAow0s0GiQkHw
	ioN8kju6312bC6kPOOkLHt9nY1e3OveAgZjLHmNmBvxNtbffg0DV658TV6H4YULl
	KhBcJBJ4I+F5KHUTjERw1HTmJu+YnZtX7akkrHSQjmSWWA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id igrNeGht7vYO; Mon, 11 May 2026 20:29:14 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gDrt10p9Lz1XM5kW;
	Mon, 11 May 2026 20:29:12 +0000 (UTC)
Message-ID: <2f5230a3-63c5-4513-ad2e-34c2f1b49527@acm.org>
Date: Mon, 11 May 2026 13:29:12 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scsi: scsi_scan: Fix typo in comment
To: Md Shofiqul Islam <shofiqtest@gmail.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com
References: <20260506094504.2235-1-shofiqtest@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260506094504.2235-1-shofiqtest@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6592C515E7C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23725-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,acm.org:email,acm.org:mid,acm.org:dkim]
X-Rspamd-Action: no action

On 5/6/26 2:45 AM, Md Shofiqul Islam wrote:
> Fix spelling mistake in comment:
>   - initialze -> initialize

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


