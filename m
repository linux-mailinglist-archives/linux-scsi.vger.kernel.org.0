Return-Path: <linux-scsi+bounces-10305-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35339D8E00
	for <lists+linux-scsi@lfdr.de>; Mon, 25 Nov 2024 22:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9FB0285FD8
	for <lists+linux-scsi@lfdr.de>; Mon, 25 Nov 2024 21:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8E118F2FC;
	Mon, 25 Nov 2024 21:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="TyOhH2PV"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E215E1C8FD6;
	Mon, 25 Nov 2024 21:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732570212; cv=none; b=PiCFwzoYtWYhKySPXRPEyJfiqfDwJ59xLHi97lrX7zGyrYjfBBjBsaoKhun2EAXeLDzzXmkiuFMKeS1WUlTPAb+mix7hY18xRlukkmG/zf88Yj+dR4H+6gc//AclA/NJ2HjxQDIIhM9/4PXpFYs1dDCCimhn8LKys2Py+lQGayc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732570212; c=relaxed/simple;
	bh=KEjWI5aMAvTOzoZGjP7fWUZEtwZUZ2RPsZndJxqZ+YQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jTJoHALBuGUlDVzlPaL7sqohlomY3X94O/t17NHAKrmXuZ+YbCjiWnyR/Aw5ISJRb49h6A353Yxw08SUaYiKSPo8vy6m1ZZGcs2OLq8D5qQ2669bvfbCXFGS/M1KGmpOhFl2Jrv9LwYyqqbvz2RwE4Vi3HNlARu04i2KMDzZ44A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=TyOhH2PV; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XxzPs1tcyz6CmR09;
	Mon, 25 Nov 2024 21:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1732570206; x=1735162207; bh=KEjWI5aMAvTOzoZGjP7fWUZE
	twZUZ2RPsZndJxqZ+YQ=; b=TyOhH2PVwpyi3/PW2dei5q/TYypcmda5bc0CmDRo
	mGfzfWPEDUCTIIU9TPeTkZAAGghsASrBXLglmTgVPxZDpeR1nsqKW/zVDUBgnYqi
	ETNps9xOoYXhA20CdCcdntAayxdgMhtyAauhgEYVcHIQ/qXf1RH+XFCpgYJe7pt/
	MqWwsnmzAvsNVLZ1/KaJ93JNj70w2VvijbQZdTzL1MkAUqZE11fHnSygvquxB9BS
	Ip1QmGblZGMgXfOriGGpPneS9pImj9K3WEM3ZVhgqp0M3LviBUU/rkfP434jrUu4
	aCqRDN38CJcNlv8HWjpqDt6Wl15XrLrSKpPb8540ZsKLhw==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id w_05MqEmtXlc; Mon, 25 Nov 2024 21:30:06 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XxzPn1YrVz6CmQyl;
	Mon, 25 Nov 2024 21:30:04 +0000 (UTC)
Message-ID: <10852ef3-18de-4942-a36c-0d24e6495fcd@acm.org>
Date: Mon, 25 Nov 2024 13:30:02 -0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] scsi: ufs: core: Prepare to introduce a new
 clock_gating lock
To: Avri Altman <avri.altman@wdc.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bean Huo <beanhuo@micron.com>
References: <20241124070808.194860-1-avri.altman@wdc.com>
 <20241124070808.194860-3-avri.altman@wdc.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20241124070808.194860-3-avri.altman@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/23/24 11:08 PM, Avri Altman wrote:
> Removed hba->clk_gating.active_reqs check from ufshcd_is_ufs_dev_busy
> function to separate clock gating logic from general device busy checks.

Patch descriptions should use the imperative mood. If this series
is reposted, please change "removed" into "remove". Since otherwise
this patch looks good to me:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


