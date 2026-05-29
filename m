Return-Path: <linux-scsi+bounces-24229-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJPyDLjVGWpmzQgAu9opvQ
	(envelope-from <linux-scsi+bounces-24229-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 29 May 2026 20:06:48 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF691607099
	for <lists+linux-scsi@lfdr.de>; Fri, 29 May 2026 20:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85BB032FE425
	for <lists+linux-scsi@lfdr.de>; Fri, 29 May 2026 17:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CC438D41F;
	Fri, 29 May 2026 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="ur8xms30"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8623138F626;
	Fri, 29 May 2026 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780076099; cv=none; b=eClwR35p77hWdQzyVKjAq+vAbmZK8bxexGuyfEKdBhpBISIxQ8uO+sHNXf3OdY482ASLNVCr1T/c2orlFePE6XRCsO/ORyFQcVHB0ZByrmLTwroMqhBm0VLwNBwIbrlMrNB4uBL8NfMgsEs4BHc8S4OaqWLx0JHYVX8SyS3eoQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780076099; c=relaxed/simple;
	bh=WMk3aPSN5jhhBmNXLYJZ4Gz+/snI/h6rjQXNjS9JVdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mVRhJDO1d1iZMv8BPFxi+eFWN7WHzsv3TblcmeSonlnZgw52424OU+gBcVR97iqldlkohJIQ3e0qUBQ+oRORdHBtK7U3YDATfwLLvhGRZ7HLS14OcOxC66/1Bawqae8cFN8s6S5FeOnGD5jvc5/Mj7wOKhkafh+2G27/S8glORY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=ur8xms30; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gRr8X2T34zlh2gG;
	Fri, 29 May 2026 17:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1780076087; x=1782668088; bh=U5BYMx4zAStPRR36x0y6uE05
	65WUCRFyP1aAJEmtYbY=; b=ur8xms30Oxud6H0iLJifx5ly+juftAyDcRiAPg5n
	VCPGGFHyKb8PwL3+DFBTJGIqoHkUtJ/Z7nbf2ny5YEOaB+w2Ts76w+5n3qMB4/qf
	FxJ1bJAvHz3f2A3NtEftuMvdnvvdzuYzoh8qY+/Kng7jNicDPRVoJEoT0qMeEfPd
	WX7m+r4zu4wi6EcCCjB/Dbbzw/l50TVzCupJyENLUePCqF1jd8uPf1065C+yr1m5
	XT0LhsCbtooBaHYPHamns1SMPMqpICKMmxI039DgfX0kkHQanCgghWzjYXTkzmDe
	5eOqE6Z8hEUpRXZicxrRZ+nZl5cLnyd6/ACwZIhNRbSrVA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id NxEpmRFbPrmR; Fri, 29 May 2026 17:34:47 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gRr8L3bcRzlh2rW;
	Fri, 29 May 2026 17:34:42 +0000 (UTC)
Message-ID: <1d48e5e2-f0a6-434e-9ad8-84beed1a9918@acm.org>
Date: Fri, 29 May 2026 10:34:41 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scsi: ufs: core: Fix NULL pointer dereference in
 scsi_cmd_priv() calls
To: Chanwoo Lee <cw9316.lee@samsung.com>, alim.akhtar@samsung.com,
 avri.altman@wdc.com, James.Bottomley@HansenPartnership.com,
 martin.petersen@oracle.com, peter.wang@mediatek.com,
 vamshigajjela@google.com, alok.a.tiwari@oracle.com, beanhuo@micron.com,
 can.guo@oss.qualcomm.com, adrian.hunter@intel.com,
 linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20260529010749epcas1p2bf38209e55149f0681550c220e541e92@epcas1p2.samsung.com>
 <20260529010739.295391-1-cw9316.lee@samsung.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260529010739.295391-1-cw9316.lee@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24229-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,acm.org:email,acm.org:mid,acm.org:dkim]
X-Rspamd-Queue-Id: CF691607099
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/28/26 6:07 PM, Chanwoo Lee wrote:
> ufshcd_tag_to_cmd() may return NULL if no command is associated with
> the given tag. However, several callers dereference the returned cmd
> pointer via scsi_cmd_priv() without checking for NULL first, leading
> to a potential NULL pointer dereference.
> 
> Fix this by adding NULL checks for cmd before calling scsi_cmd_priv()
> and moving the lrbp initialization after the NULL check.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

