Return-Path: <linux-scsi+bounces-22006-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KaEFRuOtGnBpgAAu9opvQ
	(envelope-from <linux-scsi+bounces-22006-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Mar 2026 23:22:19 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3FA28A5D8
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Mar 2026 23:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AF1A312E52C
	for <lists+linux-scsi@lfdr.de>; Fri, 13 Mar 2026 22:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0226376463;
	Fri, 13 Mar 2026 22:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="wKIFvt98"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BAD26A08A;
	Fri, 13 Mar 2026 22:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773440514; cv=none; b=RBJN+RhVpBJiLV5ITzkx4a1a+MctUm0LORCWsomXWxrNGklUhzsevX4+Niwv6Gfi73z8wNzB8ibMHwXFTEEgq4uERtSWfU5Xo+KqpMS4i4rrl+ZothqR3VAeYuU9p/p271VJ40+KSjFP2jcPVIEHTY6ySnE8IfgXZhBxic2oOL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773440514; c=relaxed/simple;
	bh=ollpBLc81hIYUYxH/7aX8gsUaO2zYBcA6eKTdeqdB9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=El4HOf2SpexA+PnTKdM8aD8/23TDAqGON4sEFLxwEzlAUU0Ovv4SNBWDvMYDFWmWAE3TN6WlySLFXgI43L+ZAB5IuKpwUUviB7lsLVqLx11Sp+pBy5W2hzcZ2HAxVK9FRAdNDBHW35+fORHNGdzp1uWunuugMVbyLGkbMf/RJ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=wKIFvt98; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fXf9F2d4rz1XM6JB;
	Fri, 13 Mar 2026 22:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1773440509; x=1776032510; bh=ollpBLc81hIYUYxH/7aX8gsU
	aO2zYBcA6eKTdeqdB9I=; b=wKIFvt98+kIBAQHuGYcErrSz/wsAZqBV7Pky/GNB
	B4r/jHUr06gAnQGCliNgqeflfCmv18YNncB1DfGafuQrlZ+TCzhQGnmfELXH623E
	iDyDS9GrwqnE4kUlwBsUQBbkS65Cbc+fuh2Hd15kWviEeGFvORWSUHji5gpwTbQR
	RgdcN5UiRcgpJenFYg7c3XBertnLDCKKhYLj19zS9oRgsJs2WjatD1pURAydQPjN
	vN0RM7xXYPbm7IISNad8kr9TPUME888GAlImUVJYc/L2Ay+3AMlSyCly4vlpmb/z
	Ub9pfq4dM206Ipr7xncm7+QoAoig7L6vIydAGDVwqxcHYA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id haPGQphG-PBY; Fri, 13 Mar 2026 22:21:49 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fXf974qkbz1XM5jn;
	Fri, 13 Mar 2026 22:21:47 +0000 (UTC)
Message-ID: <6367d46b-c5e5-4e3d-8ebb-3b08365401cd@acm.org>
Date: Fri, 13 Mar 2026 15:21:46 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/12] scsi: ufs: core: Add debugfs entries for TX
 Equalization params
To: Can Guo <can.guo@oss.qualcomm.com>, avri.altman@wdc.com,
 beanhuo@micron.com, martin.petersen@oracle.com, mani@kernel.org
Cc: linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20260308151409.3779137-1-can.guo@oss.qualcomm.com>
 <20260308151409.3779137-6-can.guo@oss.qualcomm.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260308151409.3779137-6-can.guo@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[acm.org:+];
	TAGGED_FROM(0.00)[bounces-22006-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,acm.org:dkim,acm.org:email,acm.org:mid]
X-Rspamd-Queue-Id: AE3FA28A5D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/8/26 8:14 AM, Can Guo wrote:
> Add debugfs support for UFS TX Equalization and UFS TX Equalization
> Training (EQTR) to facilitate runtime inspection of link quality. These
> entries allow developers to monitor and optimize TX Equalization
> parameters and EQTR records during live operation.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

