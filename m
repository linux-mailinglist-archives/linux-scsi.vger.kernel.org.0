Return-Path: <linux-scsi+bounces-20657-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2M95EDD8f2k81AIAu9opvQ
	(envelope-from <linux-scsi+bounces-20657-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 02 Feb 2026 02:21:52 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E56AC7C0D
	for <lists+linux-scsi@lfdr.de>; Mon, 02 Feb 2026 02:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CDB9F300565A
	for <lists+linux-scsi@lfdr.de>; Mon,  2 Feb 2026 01:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C8B1DDC28;
	Mon,  2 Feb 2026 01:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klpxed5X"
X-Original-To: linux-scsi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA25F19D092;
	Mon,  2 Feb 2026 01:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769995305; cv=none; b=i32xnYWddGfXEQKDcPNSEyhZM2kHpU0aGo/qYqhL+InzZFnlnM0hj+C0V41LusmBY+c2ScybRfI7/tch/nOm+v7fGyhAqJzru0x/lq6vyQNFyfp2BMMy8fzurQ+7GeWn7FAtJBFdbsWiJU0BgIsInE06SPzWmD0x5mzl400h7o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769995305; c=relaxed/simple;
	bh=mCK4jAurctXneO9NLzv7RMZBD5H3BIpLk3Fp60fsWxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aZ8JkZbVTvDe0DO2rUakiAWDU2+0A0T10u//dWnmCoFtFjYZQZxowkbOpXuXlJ4PiZGpbs47jJWpvWqtWbIQYJL+ROvgwikX59zqNcVXV/9zCkzHUKbekEj3EImsZrski7NcPi5nHoQUYSu4AgfVlXnA0wDrg5nM6awwHoei6PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klpxed5X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02974C4CEF7;
	Mon,  2 Feb 2026 01:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769995305;
	bh=mCK4jAurctXneO9NLzv7RMZBD5H3BIpLk3Fp60fsWxU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=klpxed5Xdavgeds3eRzynfyHMTTTXl5f1xLv1v8zb9GyelRdFc08i/w9pCcdIjx2z
	 7catgkmMruYIG/r891AILjUrqgNDpRQzC65jF1eKMKeBP/LxrMzjI53yYc0i3SwQ3/
	 YK6OwpL9k54Aew/q1gmw0pH0BCxWOeGiu3UrE7bFpe5jkieVOT/VxsF0t9jvvnVGGF
	 ECrcix4VvT2lX/Ou3F9AHoROCAepiFYXI+6tM4iAokFwf8fcO8IlJj1Ri6bzgFY7Cg
	 N80FqHo4A94W2DwmOGIkoraFVD4YnoM4QsxQ8q81VsN/7GcjAe0hfx05apbtNlsorQ
	 mLVn+HWFzASgA==
Message-ID: <b4f3b1d7-45f7-49c4-ad16-e085d71e2d9b@kernel.org>
Date: Mon, 2 Feb 2026 10:21:43 +0900
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: libsas: Fix dev_list race conditions with proper
 locking
To: Chaohai Chen <wdhh6@aliyun.com>
Cc: john.g.garry@oracle.com, yanaijie@huawei.com,
 James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
 johannes.thumshirn@wdc.com, mingo@kernel.org, cassel@kernel.org,
 tglx@kernel.org, linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260129093859.1418749-1-wdhh6@aliyun.com>
 <aa5ca682-ea38-49f6-81a1-6b154f00239d@kernel.org>
 <aX3lV4erBYL068PT@LAPTOP-RK2E6KJ3.localdomain>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <aX3lV4erBYL068PT@LAPTOP-RK2E6KJ3.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20657-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[aliyun.com];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E56AC7C0D
X-Rspamd-Action: no action

On 1/31/26 20:19, Chaohai Chen wrote:
>>> +	 * We need to unlock before calling sas_unregister_dev() as it
>>> +	 * may sleep, but we hold a reference to prevent device removal.
>>
>> And why is that necessary ?
>>
> Because when unlocked, it is possible that the device has already been 
> released by another thread. If there is no reference count, it will lead
> to used after free.

Please clearly explain the problem path. Your statements about "another thread"
is too vague.

>>> +	 */
>>> +	spin_lock_irq(&port->dev_list_lock);
>>>  	list_for_each_entry_safe_reverse(dev, n, &port->dev_list, dev_list_node) {
>>>  		if (gone)
>>>  			set_bit(SAS_DEV_GONE, &dev->state);
>>> +		kref_get(&dev->kref);
>>> +		spin_unlock_irq(&port->dev_list_lock);
>>> +
>>>  		sas_unregister_dev(port, dev);
>>> +		sas_put_device(dev);
>>> +
>>> +		spin_lock_irq(&port->dev_list_lock);
>>>  	}
>>> +	spin_unlock_irq(&port->dev_list_lock);

-- 
Damien Le Moal
Western Digital Research

