Return-Path: <linux-scsi+bounces-23839-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMKrMYQ7B2ottwIAu9opvQ
	(envelope-from <linux-scsi+bounces-23839-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 15 May 2026 17:28:04 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C57CC5521F8
	for <lists+linux-scsi@lfdr.de>; Fri, 15 May 2026 17:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 17A3D3007B10
	for <lists+linux-scsi@lfdr.de>; Fri, 15 May 2026 15:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5184963B7;
	Fri, 15 May 2026 15:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Ju1zWl5J"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5814249552D;
	Fri, 15 May 2026 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778858865; cv=none; b=G6WF8AsjEVmGvu2/jjm1R8r8UMkIE3X5OOyaf3bkI1ueZW+kSfBr85kQCG+y6uPa4Up3rNPWJCVNZbuQ0MIegzg17FYap3hid0J38DaLLqW/V1xdDCrDqC+RPfRscsNGnm2WVrJGNBsm6c82D9FKa2P1tOfUuOrldxk+CVpgNuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778858865; c=relaxed/simple;
	bh=dx8k3BK8KQImG9hsFL//BzOwDd524UUThJswDm6HbmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MlKJhvjSkC+d4QXydhkVoXnAXfr5/mdzm3kJxCAXry1dcLe/iq1BOb18cvAzMKz7YC1SSw5y/bcpIRNUUTIsfLvGnH+X5P6LSGBmXqoCKE+KbtIYSlEsZWOLzJD0MNzLOpVJsqV4qOJlbNPOkW8j381+32ZtzFNqdivqVVNTsoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Ju1zWl5J; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gHB083bDJz1XM6Jl;
	Fri, 15 May 2026 15:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1778858852; x=1781450853; bh=OG2WY8/5i/n3+u6CBSE3CYVE
	vqJAu+jfD7jrcYXWIA4=; b=Ju1zWl5JvPolg0DvFeoBKeCHTswSZqsoWCmwnwOe
	ujMBT5txoyZDt4S1pwxpX/vl+7FolU2XdH9lGADnRTzOvio+H3P1mwIWM6iYSDXK
	npK7fQCfI1gJb0XjT14UnUDxSnmunZzS/yg1XZ5m4cNVRCYkAAiXBqgu9+M11JvI
	BKQZdG47hGWNYqvZ4We2a6mkVTYqm7gzGQnJHGzfbfmFiaYwgHFBYJ6WLGysS+Zs
	xKw34IlD1h0KBXt/uxzNmYPfmHY+D9yXksOwgH7ZlPiMqn+1TyUxfAlsSc1DpzqJ
	ukaNBCiP/nJfqCKhi1An+b9lSAbNSCzjJT1M6VvwHPecqg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id YeEnYe6cy7iZ; Fri, 15 May 2026 15:27:32 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gHB011xXTz1XM5kt;
	Fri, 15 May 2026 15:27:28 +0000 (UTC)
Message-ID: <9fde73e7-0108-48d7-a1a0-ccc9776beb5c@acm.org>
Date: Fri, 15 May 2026 08:27:27 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/11] scsi: ufs: Use trace_call__##name() at guarded
 tracepoint call sites
To: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
References: <20260515135946.2238888-1-vineeth@bitbyteword.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260515135946.2238888-1-vineeth@bitbyteword.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C57CC5521F8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	TAGGED_FROM(0.00)[bounces-23839-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:mid,acm.org:dkim]
X-Rspamd-Action: no action


On 5/15/26 6:59 AM, Vineeth Pillai (Google) wrote:
>   static void ufshcd_add_query_upiu_trace(struct ufs_hba *hba,
> @@ -432,8 +432,8 @@ static void ufshcd_add_query_upiu_trace(struct ufs_hba *hba,
>   	if (!trace_ufshcd_upiu_enabled())
>   		return;
>   
> -	trace_ufshcd_upiu(hba, str_t, &rq_rsp->header,
> -			  &rq_rsp->qr, UFS_TSF_OSF);
> +	trace_call__ufshcd_upiu(hba, str_t, &rq_rsp->header,
> +			       &rq_rsp->qr, UFS_TSF_OSF);
>   }

Instead of making this change, please remove the 
trace_ufshcd_upiu_enabled() call because it is redundant.

>   static void ufshcd_add_tm_upiu_trace(struct ufs_hba *hba, unsigned int tag,
> @@ -445,15 +445,15 @@ static void ufshcd_add_tm_upiu_trace(struct ufs_hba *hba, unsigned int tag,
>   		return;
>   
>   	if (str_t == UFS_TM_SEND)
> -		trace_ufshcd_upiu(hba, str_t,
> -				  &descp->upiu_req.req_header,
> -				  &descp->upiu_req.input_param1,
> -				  UFS_TSF_TM_INPUT);
> +		trace_call__ufshcd_upiu(hba, str_t,
> +					&descp->upiu_req.req_header,
> +					&descp->upiu_req.input_param1,
> +					UFS_TSF_TM_INPUT);
>   	else
> -		trace_ufshcd_upiu(hba, str_t,
> -				  &descp->upiu_rsp.rsp_header,
> -				  &descp->upiu_rsp.output_param1,
> -				  UFS_TSF_TM_OUTPUT);
> +		trace_call__ufshcd_upiu(hba, str_t,
> +					&descp->upiu_rsp.rsp_header,
> +					&descp->upiu_rsp.output_param1,
> +					UFS_TSF_TM_OUTPUT);
>   }

Same comment here: I think it would be better to remove the 
trace_ufshcd_upiu_enabled() call rather than
changing trace_ufshcd_upiu() into trace_call__ufshcd_upiu().

Thanks,

Bart.

