Return-Path: <linux-scsi+bounces-25346-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PYlgIR9wQ2qyYQoAu9opvQ
	(envelope-from <linux-scsi+bounces-25346-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2026 09:28:31 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4F36E124A
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2026 09:28:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=A+VYfc7a;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-25346-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-scsi+bounces-25346-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9F66D300A24C
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2026 07:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF01839D6DA;
	Tue, 30 Jun 2026 07:28:23 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA74A78F2F;
	Tue, 30 Jun 2026 07:28:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782804503; cv=none; b=ewIil6PnNe1ljcIsmxB4yEOnms9HB4mtA+fQUMgSaThW+J8OSPWyFV5hWMd5SM2vlksrKnwSEHJNLubF7Dz3mR4//Hxb9QAMTrJ8igny9DgJekttjtTtoLuK69EtjcUekZeundfxDJw0GcWq7rYt3y4nefFSutASflrinJIuY+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782804503; c=relaxed/simple;
	bh=QXsMlIJFgIaZkb+e81eZ8/ZujmTrQ3d/KPlPA13+lgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ocHNq7SFZXGYw2Zgy7TGsKWVNhXkeIRqPBsFgX2j0AKGTFvI0jSbOIkGHHkjkYk1RDE152ZjSjjcKF/STslbTNwtVlPTpMnKM3Drf27ah63feZwoujwy+9VYP0YHfUevEH/R+m3j7hMKT0R7FoJCKXvkN0mo1CrmIGwVv6CgPR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+VYfc7a; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFBC1F000E9;
	Tue, 30 Jun 2026 07:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782804502;
	bh=ZZ79yflPqq3Spvk4qgRCr72BY3mK+jqs5+5msARrrV0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=A+VYfc7aJqYtdH4yr1Q/cuz5a+NkQAkJdcDcHNxjOxU3OplH8tFqQixGpeqnkrSuu
	 YKIZy77HB/G3zQ/ACvIMn72aU0t+vkttIrqDbW/oODAMFZEskar10yFPbcYN2xd93C
	 VFcgi/whXgD355X/7Fo3Glx82sMdoe7zE+S/oIbdBtbQz7dXz10Ap5enAkXDit3hXU
	 xhshfd0TM0mim+VjdEJbhqSnB6WH5DgCoKnGClcFpOWBYyue9nv+w8KTeua1soUAAO
	 KzxoZ1C7wXRL+muliCrfPQti9l91jlK6NzKOef6eQoGTp80Zn5Lzsep4k/vQwpj7ys
	 jBCfYzgxpEFqA==
Message-ID: <17d381fb-1f91-461c-8315-1508ad0c1efe@kernel.org>
Date: Tue, 30 Jun 2026 16:28:19 +0900
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: st: use kzalloc_array
To: Rosen Penev <rosenp@gmail.com>, linux-scsi@vger.kernel.org
Cc: =?UTF-8?Q?Kai_M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be|_ptr)?b"
 <linux-hardening@vger.kernel.org>
References: <20260630012101.1461335-1-rosenp@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260630012101.1461335-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:linux-scsi@vger.kernel.org,m:Kai.Makisara@kolumbus.fi,m:James.Bottomley@HansenPartnership.com,m:martin.petersen@oracle.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-25346-lists,linux-scsi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-scsi];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C4F36E124A

On 6/30/26 10:21, Rosen Penev wrote:
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

No commit message ? Please explain your reasonning, because I find this patch
incorrect. See below.

> ---
>  drivers/scsi/st.c | 12 +++---------
>  drivers/scsi/st.h |  3 ++-
>  2 files changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
> index f1c3c4946637..31ae189b18e7 100644
> --- a/drivers/scsi/st.c
> +++ b/drivers/scsi/st.c
> @@ -149,7 +149,7 @@ static struct st_dev_parm {
>     mode counts */
>  static const char *st_formats[] = {
>  	"",  "r", "k", "s", "l", "t", "o", "u",
> -	"m", "v", "p", "x", "a", "y", "q", "z"}; 
> +	"m", "v", "p", "x", "a", "y", "q", "z"};
>  
>  /* The default definitions have been moved to st_options.h */
>  
> @@ -3973,21 +3973,15 @@ static struct st_buffer *new_tape_buffer(int max_sg)
>  {
>  	struct st_buffer *tb;
>  
> -	tb = kzalloc_obj(struct st_buffer);
> +	tb = kzalloc_flex(*tb, reserved_pages, max_sg);
>  	if (!tb) {
>  		printk(KERN_NOTICE "st: Can't allocate new tape buffer.\n");
>  		return NULL;
>  	}
> -	tb->frp_segs = 0;
>  	tb->use_sg = max_sg;
> +	tb->frp_segs = 0;
>  	tb->buffer_size = 0;
>  
> -	tb->reserved_pages = kzalloc_objs(struct page *, max_sg);

reserve_pages is in the middle of struct st_buffer so you cannot use a flex array.

> -	if (!tb->reserved_pages) {
> -		kfree(tb);
> -		return NULL;
> -	}
> -
>  	return tb;
>  }
>  
> diff --git a/drivers/scsi/st.h b/drivers/scsi/st.h
> index 0d7c4b8c2c8a..759f4c43d563 100644
> --- a/drivers/scsi/st.h
> +++ b/drivers/scsi/st.h
> @@ -45,7 +45,6 @@ struct st_buffer {
>  	int syscall_result;
>  	struct st_request *last_SRpnt;
>  	struct st_cmdstatus cmdstat;
> -	struct page **reserved_pages;
>  	int reserved_page_order;
>  	struct page **mapped_pages;
>  	struct rq_map_data map_data;
> @@ -53,6 +52,8 @@ struct st_buffer {
>  	unsigned short use_sg;	/* zero or max number of s/g segments for this adapter */
>  	unsigned short sg_segs;		/* number of segments in s/g list */
>  	unsigned short frp_segs;	/* number of buffer segments */
> +
> +	struct page *reserved_pages[] __counted_by(use_sg);
>  };
>  
>  /* The tape mode definition */


-- 
Damien Le Moal
Western Digital Research

