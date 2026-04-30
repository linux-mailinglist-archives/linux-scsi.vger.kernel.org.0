Return-Path: <linux-scsi+bounces-23498-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mD9sGxKQ82ky5AEAu9opvQ
	(envelope-from <linux-scsi+bounces-23498-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 19:23:30 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 530EE4A64D2
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 19:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 991913013AA7
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Apr 2026 17:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D1640FDAA;
	Thu, 30 Apr 2026 17:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="1Al0mWbM"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832B144D688
	for <linux-scsi@vger.kernel.org>; Thu, 30 Apr 2026 17:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777569682; cv=none; b=ECVvBFenyK4DbEad7pMsSMvMgEHJXp4Aj9ZGqG0vL9ZwfQNypwalpqPlOeli1/LMc86cxa10+AYyuKXlV8f92V73+AJOTbGUrZS7rroq+3zfmJeEMSWJGF6XDIJ9X++wPP8UIHxcqrbaAtD0rGGFEMvNIyHsz63Ra/FEJUBdhC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777569682; c=relaxed/simple;
	bh=cOKf9wg+dHTe/sW/U5QPpnyj/u09SViEqFs4zyvDacU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q+CtDpbJj+fDKZ3sPQOHCc/6RZl/eEQ2xh4NliSH45JHE7zS+PufyK3+24aPQnOWVwjwI2jGkbVuEgBoszXBRK+oaLqimO9Qy9jnqO6MNTrb/P2//SWvigbPtAqxqNwA3MqGm3Sw580N+QlEDnn49WoAliTfhvupG6SkPJkqA6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=1Al0mWbM; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4g61DK0bHSzlhH0x;
	Thu, 30 Apr 2026 17:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1777569679; x=1780161680; bh=TvaQF8DTSAsMmPCuumAQv0gL
	93NZD2EWeVFvGf2DBgI=; b=1Al0mWbM4/Df5sDaSHXy8kYU8tx0/nNWrbX4D53U
	6PguwYLzPtI90Qe2b7qBmDE6dWzboBDJ80wb9Y5s13tv/JH1b1TN0hl/VZSndZ84
	SE55KGkii9dxD07QB47n+hRjB/3PDPuJfnEThI6bNbR+UqiuuKtnqBF/R+/SDByE
	GaYYxMHg3f7AYJOQO1F/jqKXg/SJksxBbSLa6HWKH7CxrtHb2daLy0Hrtjz7hDXZ
	lcIMtxrYhD6IHIJxKHVkmbQeCyt4vKHKVAJILxSrtkFkYn8k8hzohiGCu7HS2KV+
	pM0ITcOEMJsI31ZsY98lGgkdlg4IRdwGVYQxJ9IGtkxUVw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id SztfFeUX3XXn; Thu, 30 Apr 2026 17:21:19 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4g61DH1YC3zlgyGx;
	Thu, 30 Apr 2026 17:21:18 +0000 (UTC)
Message-ID: <6a44785c-5b64-47fe-ba5b-39f800bbe76f@acm.org>
Date: Thu, 30 Apr 2026 10:21:18 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] ufs-qcom: Reduce interrupt latency
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
References: <20260402171404.3008494-1-bvanassche@acm.org>
 <yq1lde4e7yg.fsf@ca-mkp.ca.oracle.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <yq1lde4e7yg.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 530EE4A64D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23498-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[acm.org:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 4/30/26 9:21 AM, Martin K. Petersen wrote:
>> On Android systems it is important to keep the time spent in
>> interrupts short. This keeps the user interface responsive and
>> prevents audio stuttering. Hence this patch series to reduce the time
>> spent in the UFS interrupt handler. Please consider this patch series
>> for the next merge window after test results have been shared by
>> Qualcomm.
> 
> https://sashiko.dev/#/patchset/20260402171404.3008494-1-bvanassche%40acm.org

Right, the threaded interrupt handler needs more work.

PS: I asked the Sashiko owner to enable Sashiko for the SCSI and block
mailing lists.

Thanks,

Bart.



