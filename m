Return-Path: <linux-scsi+bounces-16678-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF04B39F13
	for <lists+linux-scsi@lfdr.de>; Thu, 28 Aug 2025 15:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08871885D4D
	for <lists+linux-scsi@lfdr.de>; Thu, 28 Aug 2025 13:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD35220F2A;
	Thu, 28 Aug 2025 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="MSDxVgj9"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 003.mia.mailroute.net (003.mia.mailroute.net [199.89.3.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1647D13C9C4;
	Thu, 28 Aug 2025 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756388167; cv=none; b=LP18QB/FoTbGhRUNJyDhzm1SIQFjd/xf8ZEulQ/O/ChYcgl/oY7RhpvYr77lF3v6JRzd3p/wyZymGV/O8WbLcd4A+LElSrStmWd2sVcjw9+M35Vz2iYM/n/mDypSruEZ9XsXveFPYcbrL86IY3RJMJCnJ0eguwEUriGZ7uDvKAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756388167; c=relaxed/simple;
	bh=pMJGVdHzw82RWoCc7SXHdGTgGvXvAd4aIAO5C8iissU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kh/00mcw2OxdfIJFy/vNSnXLYxGOz9h4/zULisLT/6akhQh84u5hRmAUYrOUm2x5JV9yHp3eIw5J2C4UASllc1DUz1rd3o6cNq5Qt0wIosOMxf6Nb3DBTUvv0iBJuYgR/jxoiJx094gBCKy0uMgEiDoGuV5VzlBi/5jJGNmASiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=MSDxVgj9; arc=none smtp.client-ip=199.89.3.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 003.mia.mailroute.net (Postfix) with ESMTP id 4cCMqT1WhbzlgqVV;
	Thu, 28 Aug 2025 13:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1756388162; x=1758980163; bh=sqV1scMIAszcnmCOhrVrNpOW
	dX3EsLB6kvfYWi/fNHk=; b=MSDxVgj9nIhZvrnKCZWsf6hc48bZmFnudklPkxDQ
	J5H0jMEJVRrOZDc+8XHIor1L3DeKNmpEFx9A99bqNe/VUiTHxkl7P6fGTaCN0U0s
	kBSGl/E28At3yC3FytdKeKteJUEkhm91sm7rhQTvGty2S95rn/0YwX6ULgjqka8g
	Gzxux9/9Zj9YDIcWYw2Psk4UybI4LjFFbQM5uywgl9iILoUOV6XKm2I3tub5UtEq
	yHMky2H8JklcRwyjGmdlQOD27oETiWF57w1cDUXTu706PQ1HQO1KX+OOEwJhLv3E
	vtP1qcAYVvG26UFN7LJQlSbAVEI6brHDJeH5GWDvYIIpBQ==
X-Virus-Scanned: by MailRoute
Received: from 003.mia.mailroute.net ([127.0.0.1])
 by localhost (003.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id pohtwsPELwlf; Thu, 28 Aug 2025 13:36:02 +0000 (UTC)
Received: from [172.20.6.188] (unknown [208.98.210.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 003.mia.mailroute.net (Postfix) with ESMTPSA id 4cCMqH1f14zlgn8k;
	Thu, 28 Aug 2025 13:35:53 +0000 (UTC)
Message-ID: <f8672cb8-f6ec-4eed-9c0b-4f4806cca79b@acm.org>
Date: Thu, 28 Aug 2025 06:35:53 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: ufs: exynos: fsd: Gate ref_clk and put UFS device
 in reset on suspend
To: Bharat Uppal <bharat.uppal@samsung.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com,
 martin.petersen@oracle.com, alim.akhtar@samsung.com, avri.altman@wdc.com,
 linux-samsung-soc@vger.kernel.org
Cc: pankaj.dubey@samsung.com, aswani.reddy@samsung.com,
 Nimesh Sati <nimesh.sati@samsung.com>
References: <CGME20250821053938epcas5p290f78790250d8cb09df2f35e45624359@epcas5p2.samsung.com>
 <20250821053923.69411-1-bharat.uppal@samsung.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20250821053923.69411-1-bharat.uppal@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/25 10:39 PM, Bharat Uppal wrote:
> On FSD platform, gating the reference clock (ref_clk) and putting the
> UFS device in reset by asserting the reset signal during UFS suspend,
> improves the power savings and ensures the PHY is fully turned off.
> 
> These operations are added as FSD specific suspend hook to avoid
> unintended side effects on other SoCs supported by this driver.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


