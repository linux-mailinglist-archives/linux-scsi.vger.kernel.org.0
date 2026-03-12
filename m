Return-Path: <linux-scsi+bounces-21918-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UChGCjgUs2mDSAAAu9opvQ
	(envelope-from <linux-scsi+bounces-21918-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Mar 2026 20:30:00 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7FC277F15
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Mar 2026 20:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ECC873024292
	for <lists+linux-scsi@lfdr.de>; Thu, 12 Mar 2026 19:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1092337B00A;
	Thu, 12 Mar 2026 19:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="KrgowKUF"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F1F282F0D;
	Thu, 12 Mar 2026 19:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773343796; cv=none; b=E9+ypTd78iQW1URpgPOVFbNssge7GYyMBVETxMW6QrQw4Gcw3Pml6IqsW/iRd4pKEjJ0D5v1Awh2MVx1NPczyeF5dRpkHLaFcuAVJpBBZNnfXWT3fNCx8UNhlqxra8pZKxuOHdRvZx3jpA7w/SuHGgyVeiY8+Fk4ANBuo+RKzQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773343796; c=relaxed/simple;
	bh=Atdv+nKaVv5bnq8b8E94YBFgB56c1lpVIf2/AVjA3MI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JxvY+WcRXkHqwE6KLVS8Yvuy3X2o0xJ0LoY1gP12TkPYKCNgl+869MaIPveD8aK6thWlkmdF4UDguDfuOtCbvk4miCQy/CouxI/SBeJVSDGcGuEp81ZbIOc3aBze0p/ZN/AKBVav6eVJAsPrRSXdStH2wIYdB3a7dqrTms4pg+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=KrgowKUF; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fWyPG67b4z1XM0nn;
	Thu, 12 Mar 2026 19:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1773343790; x=1775935791; bh=oLVQN6f85szCUFzcTrIEVs8Y
	h2E/2cez0U0xXuby44k=; b=KrgowKUF8xZInrtZOpQfOjK8Z+xBfUb5ytpsh5Zs
	8p4rgarzc1Ucsj+Wefwd53nlO5jXeddEFWKoCGT6JuxK9LPEXbzCCjuhDxuvqh9L
	CpQQhkU1H3+wRpUvVlu2cfKHwj1C5StP37siRVkJ+UTS9AtU/pES2RWtywN/qMNx
	D4m3cFXtpkce6LhSO+YSvXBqPaZfu92I52Ymf9R3ECZGVHNBT/GtI3ZXOlNHWKx8
	XvgTE+fn+FNJIdZ0dBRHqrHr5n02KM3uEgWhd65AYUGh8vwIMFM4GM6cXrkPd+6T
	3lQL+g1qewf40btyn6c06De2bTlbj5ZoJw0Y+3DoPeKLjg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id c9m32iRkHB03; Thu, 12 Mar 2026 19:29:50 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fWyP904dfz1XM31H;
	Thu, 12 Mar 2026 19:29:48 +0000 (UTC)
Message-ID: <574620fd-903b-4fd3-8cbb-22a3cefda645@acm.org>
Date: Thu, 12 Mar 2026 12:29:48 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/3] bsg: add bsg_uring_cmd uapi structure
To: Yang Xiuwei <yangxiuwei@kylinos.cn>, axboe@kernel.dk,
 fujita.tomonori@lab.ntt.co.jp, James.Bottomley@HansenPartnership.com,
 martin.petersen@oracle.com
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20260312092237.2464560-1-yangxiuwei@kylinos.cn>
 <20260312092237.2464560-2-yangxiuwei@kylinos.cn>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260312092237.2464560-2-yangxiuwei@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	TAGGED_FROM(0.00)[bounces-21918-lists,linux-scsi=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,acm.org:dkim,acm.org:mid]
X-Rspamd-Queue-Id: 2D7FC277F15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/26 2:22 AM, Yang Xiuwei wrote:
> +struct bsg_uring_cmd {
> +	__u64 request;		/* [i], [*i] command descriptor address */
> +	__u32 request_len;	/* [i] command descriptor length in bytes */
> +	__u32 protocol;		/* [i] protocol type (BSG_PROTOCOL_*) */
> +	__u32 subprotocol;	/* [i] subprotocol type (BSG_SUB_PROTOCOL_*) */
> +	__u32 max_response_len;	/* [i] response buffer size in bytes */
> +
> +	__u64 response;		/* [i], [*o] response data address */
> +	__u64 dout_xferp;	/* [i], [*i] */
> +	__u32 dout_xfer_len;	/* [i] bytes to be transferred to device */
> +	__u32 dout_iovec_count;	/* [i] 0 -> "flat" dout transfer else
> +				 * dout_xferp points to array of iovec
> +				 */
> +	__u64 din_xferp;	/* [i], [*o] */
> +	__u32 din_xfer_len;	/* [i] bytes to be transferred from device */
> +	__u32 din_iovec_count;	/* [i] 0 -> "flat" din transfer */
> +
> +	__u32 timeout_ms;	/* [i] timeout in milliseconds */
> +	__u8  reserved[12];	/* reserved for future extension */
> +};

Please consider adding a static_assert() statement that verifies the
size of this data structure at compile time. Such a statement is useful
to document the size of the data structure, helps with verifying that
the size is the same on all architectures and helps with verifying that
the size doesn't change if a reserved byte is taken in use.

> +#define BSG_SCSI_RES2_DEVICE_STATUS(res2)   ((__u8)((__u64)(res2) & 0xff))
> +#define BSG_SCSI_RES2_DRIVER_STATUS(res2)   ((__u8)((__u64)(res2) >> 8))
> +#define BSG_SCSI_RES2_HOST_STATUS(res2)     ((__u8)((__u64)(res2) >> 16))
> +#define BSG_SCSI_RES2_SENSE_LEN(res2)       ((__u8)((__u64)(res2) >> 24))
> +#define BSG_SCSI_RES2_RESID_LEN(res2)       ((__u32)((__u64)(res2) >> 32))
> +
> +#define BSG_SCSI_RES2_BUILD(device_status, driver_status, host_status,   \
> +			    sense_len_wr, resid_len)			\
> +	(((__u64)(__u32)(resid_len) << 32) |				\
> +	 ((__u64)(__u8)(sense_len_wr) << 24) |				\
> +	 ((__u64)(__u8)(host_status) << 16) |				\
> +	 ((__u64)(__u8)(driver_status) << 8) |				\
> +	 ((__u64)(__u8)(device_status)))

Please convert all the above macros into inline functions because that
will result in removal of most of the typecasts. I think that inline
functions are allowed in uapi headers:

$ git grep 'static.*inline' include/uapi | wc -l
354

Thanks,

Bart.

