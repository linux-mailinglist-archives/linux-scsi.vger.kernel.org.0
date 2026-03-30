Return-Path: <linux-scsi+bounces-22611-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBHcA6vCymmL/wUAu9opvQ
	(envelope-from <linux-scsi+bounces-22611-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 30 Mar 2026 20:36:27 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F01B435FCAD
	for <lists+linux-scsi@lfdr.de>; Mon, 30 Mar 2026 20:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2D14C300ADBB
	for <lists+linux-scsi@lfdr.de>; Mon, 30 Mar 2026 18:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70652C21D0;
	Mon, 30 Mar 2026 18:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="NkTvntXg"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F763939BC
	for <linux-scsi@vger.kernel.org>; Mon, 30 Mar 2026 18:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774895777; cv=none; b=fYPyeHzmLdnd+s7UjzhgbJRZPGB7AvYUFg967bI6Dfpcl18yUHjZQwQ7IcQrEkzZc8Ni3w6eIh9ccY7XrIwhL3oPIJ4VnKV3jZTxex6ePqxZs3zzWKIi6Hp7dbg1O5hvBhjnGW3Vi1CL+0WfcM0JqCw1/zoxsP33qWeK61xZsMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774895777; c=relaxed/simple;
	bh=lgib4MVY0OxsSKpynPS6NBXpGVHsWS9utAyHudJ9twY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L9iOsWlWs8eRD7SRGwTWB+n7zEagzcPaUyIBp5fWBZMF4VrUEZmxrN8+d5Yn9j4jtyEbskq6kQIV5hNZKfH6dNPc67H0zEysVge0fKyKlMvLIEiCzLoNhySfHSQ8ylGiD3xYlIvpx+nZR+RltgfpU9Vq3SRiJxTjyPy6sPaNxGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=NkTvntXg; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fl0M4018tz1XM0p7;
	Mon, 30 Mar 2026 18:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1774895773; x=1777487774; bh=ZJRuEQ/SUIvray92e8k+eeuZ
	vJ5+9YIIB2v66QMo1WQ=; b=NkTvntXg2fOth+yqFwk5B6GvAjb3pXK2M1V0RoT4
	xUxrUStpQydFNqZ7+5jAz/Gog+HtkKudmluSzVZKUekavtlGmJLr+qrF+s3iFCJT
	cAgjGiQtuZQfioubWKWrUCd9mX09K8ouDcNi4de2ji85fII9uM0Km1Yb16bSuuJH
	GUfnE5swntBLBRQsNLQZRP/RgEEhuYZpQC8G6SMg+zJoYyEtAAChAScIjvVbFYOt
	/JGCpV3De79qnorADfYVutS0ldj/SImNBbck6eG8uQlZWMNhFPRWRPQ3rKwAgQ/8
	sWJuoP7Sf1HMK3fD3c+kJBhUHD+Z9vcWDGncx5K5xQh+Uw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id QVeIE-IWGo8J; Mon, 30 Mar 2026 18:36:13 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fl0M10sf7z1XM5kt;
	Mon, 30 Mar 2026 18:36:12 +0000 (UTC)
Message-ID: <6e4ce34a-23e6-4dca-837a-b89feb504e41@acm.org>
Date: Mon, 30 Mar 2026 11:36:12 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Reduce interrupt latency
To: Can Guo <quic_cang@quicinc.com>
Cc: linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20260330183311.1941942-1-bvanassche@acm.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260330183311.1941942-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22611-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:dkim,acm.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F01B435FCAD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/30/26 11:33 AM, Bart Van Assche wrote:
> On Android systems it is important to keep the time spent in interrupts short.
> This keeps the user interface responsive and prevents audio stuttering. Hence
> this patch series to reduce the time spent in the UFS interrupt handler. Please
> consider this patch series for the next merge window.
(replying to my own email)

Hi,

Can anyone help me to test this patch series on an MCQ Qualcomm system? 
I do not have access to such a setup.

Thanks,

Bart.

