Return-Path: <linux-scsi+bounces-23845-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CD0oLg52B2pL4QIAu9opvQ
	(envelope-from <linux-scsi+bounces-23845-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 15 May 2026 21:37:50 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3E4556F88
	for <lists+linux-scsi@lfdr.de>; Fri, 15 May 2026 21:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 216C4302257A
	for <lists+linux-scsi@lfdr.de>; Fri, 15 May 2026 19:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40F138CFEF;
	Fri, 15 May 2026 19:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="isujH0tD"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2023638AC79;
	Fri, 15 May 2026 19:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872923; cv=none; b=uPuVrBopEYtaKecoudwYAemQKxmvLzGc1t/VGOMOhbdn8KqlBcDaPQMboXkP6d4iiCCsy7076pHUdQQQFqdblT6Hp492NNU/dG9BE8BP2HLEJqypg+EmVgbU2wFE7uNjXsCOKLvFSmGWQbPtjjzFt4lxPJWQ5nYJjfEvHUAU+2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872923; c=relaxed/simple;
	bh=etq7coVtQM47GMB6/iYdcAHANfQZ4Fdv0veJgHeW0RU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iVW0dWBikWFHOI1v5hgv1rwbUNW7uu103/Qq9PaiztrjJt9JWMQqN9Uu/KYZg17GslOcVSUf3q1/PCbhY80wbX4gcDl/tcjJ59zeHEQUk0zNCh/RdZY0mPbamLBV4eg+89u2Zla9JPqhcYOZug4wfNkgQoltVEm7vobn13FSfnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=isujH0tD; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gHHBd4JTxzlh2ff;
	Fri, 15 May 2026 19:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1778872917; x=1781464918; bh=U0jH4D19p47Ke7XI7nOgdEzt
	aSYBOtp7vlQaiq3oa54=; b=isujH0tDYwDwVq8Lk52K6qCd0J2zJsHGriOcXnYo
	YZvT6cFpZA0+eRZ1qHvZe13VbdLGKLgS61qu01jrd1uU/x6YSFzdB+1aA2Crmg+s
	i4ZQFwp7e11g/iB+MrO0uzLX4dKzgpcMV3WinYteUrL8sJAKpGB6xujXUaSMH79z
	FSdFSwx81vNmgC+1kQh4Q/s33V9eq82NYCCIaCARrqj7kI26Sg03xhVFnhmYxxTL
	Aj7e8YqlH++Z4PJ0MYWqY0a6WpUPwT9pxX/zshBMPt1ay1Kddmk+RyivleCnf60z
	pqJt3w1V5UlMQ+v4jxhI2vokL7e+FU8cs7MqTsYGlERtIA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 6NfCh0c8gDXP; Fri, 15 May 2026 19:21:57 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gHHBW4y2RzlfvpG;
	Fri, 15 May 2026 19:21:55 +0000 (UTC)
Message-ID: <ebdc020e-419d-458a-9211-36f22af0c1d9@acm.org>
Date: Fri, 15 May 2026 12:21:46 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/11] scsi: ufs: Use trace_call__##name() at guarded
 tracepoint call sites
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>
References: <20260515135946.2238888-1-vineeth@bitbyteword.org>
 <9fde73e7-0108-48d7-a1a0-ccc9776beb5c@acm.org>
 <20260515145048.1c021bc9@gandalf.local.home>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260515145048.1c021bc9@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CE3E4556F88
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	TAGGED_FROM(0.00)[bounces-23845-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/15/26 11:50 AM, Steven Rostedt wrote:
> On Fri, 15 May 2026 08:27:27 -0700
> Bart Van Assche <bvanassche@acm.org> wrote:
> 
>> On 5/15/26 6:59 AM, Vineeth Pillai (Google) wrote:
>>>    static void ufshcd_add_query_upiu_trace(struct ufs_hba *hba,
>>> @@ -432,8 +432,8 @@ static void ufshcd_add_query_upiu_trace(struct ufs_hba *hba,
>>>    	if (!trace_ufshcd_upiu_enabled())
>>>    		return;
>>>    
>>> -	trace_ufshcd_upiu(hba, str_t, &rq_rsp->header,
>>> -			  &rq_rsp->qr, UFS_TSF_OSF);
>>> +	trace_call__ufshcd_upiu(hba, str_t, &rq_rsp->header,
>>> +			       &rq_rsp->qr, UFS_TSF_OSF);
>>>    }
>>
>> Instead of making this change, please remove the
>> trace_ufshcd_upiu_enabled() call because it is redundant.
> 
> You mean to remove the ufshcd_add_query_upiu_trace() function and just use
> a tracepoint where it is called?

That would be even better.

>>>    static void ufshcd_add_tm_upiu_trace(struct ufs_hba *hba, unsigned int tag,
>>> @@ -445,15 +445,15 @@ static void ufshcd_add_tm_upiu_trace(struct ufs_hba *hba, unsigned int tag,
>>>    		return;
>>>    
>>>    	if (str_t == UFS_TM_SEND)
>>> -		trace_ufshcd_upiu(hba, str_t,
>>> -				  &descp->upiu_req.req_header,
>>> -				  &descp->upiu_req.input_param1,
>>> -				  UFS_TSF_TM_INPUT);
>>> +		trace_call__ufshcd_upiu(hba, str_t,
>>> +					&descp->upiu_req.req_header,
>>> +					&descp->upiu_req.input_param1,
>>> +					UFS_TSF_TM_INPUT);
>>>    	else
>>> -		trace_ufshcd_upiu(hba, str_t,
>>> -				  &descp->upiu_rsp.rsp_header,
>>> -				  &descp->upiu_rsp.output_param1,
>>> -				  UFS_TSF_TM_OUTPUT);
>>> +		trace_call__ufshcd_upiu(hba, str_t,
>>> +					&descp->upiu_rsp.rsp_header,
>>> +					&descp->upiu_rsp.output_param1,
>>> +					UFS_TSF_TM_OUTPUT);
>>>    }
>>
>> Same comment here: I think it would be better to remove the
>> trace_ufshcd_upiu_enabled() call rather than
>> changing trace_ufshcd_upiu() into trace_call__ufshcd_upiu().
> 
> Well, removing it here would mean placing the if (str == UFS_TM_SEND) into
> the code and processing it even when tracing is disabled. With the
> trace_*_enabled() helper, it's all a nop.

The ufshcd_add_tm_upiu_trace() function is only called from the UFS
error handler and hence is not performance sensitive. The execution of
an additional if-test in this function is not a concern at all.

Thanks,

Bart.

