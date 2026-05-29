Return-Path: <linux-scsi+bounces-24231-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDYAOJPQGWoFzQgAu9opvQ
	(envelope-from <linux-scsi+bounces-24231-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 29 May 2026 19:44:51 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8831B606C5D
	for <lists+linux-scsi@lfdr.de>; Fri, 29 May 2026 19:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9928A3015C3D
	for <lists+linux-scsi@lfdr.de>; Fri, 29 May 2026 17:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8109138F659;
	Fri, 29 May 2026 17:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="lYarKYeu"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425BC36F8F9;
	Fri, 29 May 2026 17:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780076228; cv=none; b=SMAjJe2FwdwnY8BifC2X8Qn5lMWYIKwTxJUazIpBNXgtZF/yNnnDdrtz2brsDYieO/9wOGYoOWwNMwHtAap9y4tdPrLNes5N98u3P5ySACWbUhRIhkm9ubw+oOA4Ywv4V5xqwM+X6YWfpszs/HdTeXzns0j+E5e4ALhmhAtw82A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780076228; c=relaxed/simple;
	bh=VHOjMc89/pZ6MbuxPcF2o3gvLxLaseu0tOb49NYOWYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NBpIMSLC/n8Zke3Ouc/wqQAPkHXoxLugDw2rgFBEjYfQLDzb0PXOiIwHkAAgjXe19BebhsVsmZKmxKG4RP5MTu9OHDtybcrC+CxdIEDa56Ro+onMuSqcFJEZxBvq36CkbgydsS1ZDQs2CYonBF8XiEdkjonCMsDpKRjOHUNO3V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=lYarKYeu; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gRrC64b4fz1XM0pW;
	Fri, 29 May 2026 17:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1780076221; x=1782668222; bh=VHOjMc89/pZ6MbuxPcF2o3gv
	LxLaseu0tOb49NYOWYw=; b=lYarKYeuIcNbzIPqByZGFKlG1Bx/FosYGAWJBorK
	sqqw7CifRuqwe41ZogKJi1Xsjoar8qXD5YhLGrG/GNKMIE5ZfJeJBkVrMFhx5uDX
	YSlAQWzucRq2Zgwy9fm7VPpzbESfbQaD86eu3OcK/hRVM0t8JVIvchp1uzb/lM+q
	CHhcboVyDxsSBE/11vfmxXxML3tjvLQfn395sNqRqBVauNGTYAOmwMwAcfw8Uo42
	goR/10GAHG0e+1dODSCXo1B01pIXeSTE9nLVYtHubt8QF/eG0yBlljhwAvBi4lcW
	Ro2z57j14Ni9wYbzEvrFDRvMtTdTPkSiNki4yBlAKdfPGQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id PS4ahnFwvkRf; Fri, 29 May 2026 17:37:01 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gRrBx4YZvz1XM6Jm;
	Fri, 29 May 2026 17:36:57 +0000 (UTC)
Message-ID: <3aac3cb5-046f-442d-8f65-40d98c26345d@acm.org>
Date: Fri, 29 May 2026 10:36:56 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: ufs: Remove redundant vops NULL check and trivial
 wrapper
To: Chanwoo Lee <cw9316.lee@samsung.com>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Peter Wang <peter.wang@mediatek.com>, Bean Huo <beanhuo@micron.com>,
 Can Guo <can.guo@oss.qualcomm.com>, Adrian Hunter <adrian.hunter@intel.com>,
 "open list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER"
 <linux-scsi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <CGME20260529061727epcas1p495c499c91420790a225e66263f3fff52@epcas1p4.samsung.com>
 <20260529061623.301291-1-cw9316.lee@samsung.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260529061623.301291-1-cw9316.lee@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	TAGGED_FROM(0.00)[bounces-24231-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:email,acm.org:mid,acm.org:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8831B606C5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/28/26 11:16 PM, Chanwoo Lee wrote:
> ufshcd_variant_hba_init/exit() check 'if (!hba->vops)' before
> calling vops wrappers, but the wrappers already do NULL check
> internally. Remove the redundant checks. Also remove
> ufshcd_variant_hba_exit() entirely since it only wraps
> ufshcd_vops_exit() with no added value.

For future patches, please stick to the "one change per patch" rule.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

