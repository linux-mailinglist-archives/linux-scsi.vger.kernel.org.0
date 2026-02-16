Return-Path: <linux-scsi+bounces-20911-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDxJMLygk2mj7AEAu9opvQ
	(envelope-from <linux-scsi+bounces-20911-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Feb 2026 23:57:00 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6215E148013
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Feb 2026 23:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 619EA300F9C7
	for <lists+linux-scsi@lfdr.de>; Mon, 16 Feb 2026 22:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8752D8378;
	Mon, 16 Feb 2026 22:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XP1W6LTm"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F5E2D46D6;
	Mon, 16 Feb 2026 22:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771282611; cv=none; b=YQqW5E1KZ3CNBp5u7aILDUomhBFYPNxrNOM9rShXuvoMs7tVlRCtsc/k2b34KX8K2P806uZarPgF5YK9QmH9B9AcqKHjdiDtzbjYN4rDxTty/cnB9dLaG7jCCKOiawGk+bWi14Q4HP5Aw7ri8I95HH/VFHN5gQgx3IFVp3g5lJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771282611; c=relaxed/simple;
	bh=Q3hTDIQmXTkhOttplif8kX12ETjsQ+CTBDN52FiCC2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J4/yKPRNQpBd2nIMr3YT0VMLWraRaw8ErKt/ZG7ZEHRdw7uTLke5k2/R9rq5I5vSxUdOH3M6laMYf9+3WFgdilLu67XWPKeIAL24oNSjGCk1JmVeyN292b/qPNJcBfb673q0xgRvRBQ5rUgZV5vs9BQ4sR43XjLWzQRRavc8jwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XP1W6LTm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74656C116C6;
	Mon, 16 Feb 2026 22:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771282610;
	bh=Q3hTDIQmXTkhOttplif8kX12ETjsQ+CTBDN52FiCC2A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XP1W6LTmohmqGqeAoP94Lgluv1y4ndBAQXs5RzJnH8Bu+RigVp8sxaBVN112y3rk9
	 lQQuE0054jM3VIKb2KgaNCFtNywoDwiOlPUdreMDL/TQM4L7m1Q0gim2RbMeZWdMMu
	 pee2WVGErz1PBEzr0BA9PdlsOto/Q0RQ+wm1EV8PKboX2/NzFppqYyo/oIzARqXdKM
	 SH+1X7DLvAWuL0nIyy7o0WCoD0h3MuRiyffhPJyY9+H+XowqSLs/RRU/HpEd6eKjDx
	 wdER8Fw03JPuGgU1zsQK0iC5Yqk/l1am2ZqxCQFysHdgjoQaizXJOKXS2Q+q8q+7Gb
	 A7Bxq2Yf9Adaw==
Message-ID: <061bb993-f394-4f44-9b6f-4f7ba723d8bc@kernel.org>
Date: Tue, 17 Feb 2026 07:56:42 +0900
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] scsi: sd: enable sector size > PAGE_SIZE in scsi
 sd driver
To: sw.prabhu6@gmail.com, James.Bottomley@HansenPartnership.com,
 martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, mcgrof@kernel.org, pankaj.raghav@linux.dev,
 bvanassche@acm.org, Swarna Prabhu <s.prabhu@samsung.com>,
 Pankaj Raghav <p.raghav@samsung.com>
References: <20260214011829.508272-1-sw.prabhu6@gmail.com>
 <20260214011829.508272-2-sw.prabhu6@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260214011829.508272-2-sw.prabhu6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20911-lists,linux-scsi=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,HansenPartnership.com,oracle.com,vger.kernel.org];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6215E148013
X-Rspamd-Action: no action

On 2/14/26 10:18, sw.prabhu6@gmail.com wrote:
> From: Swarna Prabhu <sw.prabhu6@gmail.com>
> 
> The WRITE SAME(16) and WRITE SAME(10) scsi commands uses
> a page from a dedicated mempool('sd_page_pool') for its
> payload. This pool was initialized to allocate single
> pages, which was sufficient as long as the device sector
> size did not exceed the PAGE_SIZE.
> 
> Given that block layer now supports block size upto
> 64K ie beyond PAGE_SIZE, initialize large page pool in
> 'sd_probe()' if a higher sector device is attached ensuring
> atomicity. Adapt 'sd_set_special_bvec()' to use large page
> pool when a higher sector size device is attached. Hence
> enable sector sizes > PAGE_SIZE in scsi sd driver.
> 
> Signed-off-by: Swarna Prabhu <s.prabhu@samsung.com>
> Co-developed-by: Pankaj Raghav <p.raghav@samsung.com>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

One nit below. With that fixed, feel free to add:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  drivers/scsi/sd.c | 80 ++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 68 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
> index d76996d6cbc9..ae6ccfed79b9 100644
> --- a/drivers/scsi/sd.c
> +++ b/drivers/scsi/sd.c
> @@ -107,8 +107,11 @@ static void sd_config_write_same(struct scsi_disk *sdkp,
>  static void  sd_revalidate_disk(struct gendisk *);
>  
>  static DEFINE_IDA(sd_index_ida);
> +static DEFINE_MUTEX(sd_mutex_lock);
>  
>  static mempool_t *sd_page_pool;
> +static mempool_t *sd_large_page_pool;
> +static atomic_t sd_large_page_pool_users = ATOMIC_INIT(0);
>  static struct lock_class_key sd_bio_compl_lkclass;
>  
>  static const char *sd_cache_types[] = {
> @@ -116,6 +119,33 @@ static const char *sd_cache_types[] = {
>  	"write back, no read (daft)"
>  };
>  
> +static int sd_large_pool_create_lock(void)

I do not see the point of the "_lock" suffix since you do not have a "no lock"
variant of this function. So let's drop that suffix.

> +static void sd_large_pool_destroy_lock(void)

Same here.

-- 
Damien Le Moal
Western Digital Research

