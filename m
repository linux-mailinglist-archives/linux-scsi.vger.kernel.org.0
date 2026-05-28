Return-Path: <linux-scsi+bounces-24200-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPI7BhVxGGq4kAgAu9opvQ
	(envelope-from <linux-scsi+bounces-24200-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 28 May 2026 18:45:09 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 319855F52FA
	for <lists+linux-scsi@lfdr.de>; Thu, 28 May 2026 18:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 712C53129DEA
	for <lists+linux-scsi@lfdr.de>; Thu, 28 May 2026 16:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073963F39C2;
	Thu, 28 May 2026 16:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="J8l1W+/S"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907BF3B9604;
	Thu, 28 May 2026 16:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779986018; cv=none; b=kiR+rK9o3g/Qya2eGcSvq9I8uKexDz/X9rez9J/mhSefDWaKXupeOOZrUjk1w+JSZbn27CipqGNXdr8A2GqIhB3l4S/JoL0Ye2VXfr2A5DaS0DiNM26saiD0hmup/luH7Da2tnZ/Lh/3yjYiSztEvjr3wmsFH3DwFBDYKFMUB9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779986018; c=relaxed/simple;
	bh=AupKSlotFddJl3ywN8vVvitmEIST7jZJmQ/HcbsVS5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fcPTjHea16i7vqG8Se9Wp00Elu2OSoA/VMbMPp9p8U2B4DoqfZKun8IsteWa1PmsphyY5bdevNItawgSQbi3z0NoqbWjMz06XDIa7LKWnYbsY+0EPdq4Klb0anjT8PGNI9MKmMLKFkSVW4pIijhjE94Ele6/lJA9fZtugdbedNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=J8l1W+/S; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gRBrC2fYsz1XM0pY;
	Thu, 28 May 2026 16:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1779986005; x=1782578006; bh=AupKSlotFddJl3ywN8vVvitm
	EIST7jZJmQ/HcbsVS5Y=; b=J8l1W+/S7aHDx05H2gTC6HHbGHW8bJdci6BRQ7sS
	28J3uRI99osbSs4dMu1j6sa01LiZFXNchWDBKd/RdYerGjvpH3gNiy3g9bC1Vhcx
	UdngzX4OEavhwsFZwtzO+lJfvg9kH6l3WV/6/eVPGeUzcHMVmu3k0NWzP0jNWXaP
	I9OFFOK0p4MsFRruhaEfQIt1xrrExXyBrNhZ9q5xR/w5R6HSu2nMMcE8dTpI8RzJ
	DLOuJ3nwPYKUdQ9rkZ17R/l6EjhSiOuDL5vjuLjqZGXLQWpBOKY8RifK+oq+Pluh
	JDj73feAgM4GZXnyUCMgPn1yaTNt0VRU+strx6cQ77ZG5Q==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id K8wESRK4LClM; Thu, 28 May 2026 16:33:25 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gRBr20v9Qz1XM5kW;
	Thu, 28 May 2026 16:33:21 +0000 (UTC)
Message-ID: <4b126897-8df5-4537-9fc6-93006564baab@acm.org>
Date: Thu, 28 May 2026 09:33:20 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: ufs: core: Fix NULL pointer dereference in
 scsi_cmd_priv() calls
To: Chanwoo Lee <cw9316.lee@samsung.com>
Cc: James.Bottomley@HansenPartnership.com, adrian.hunter@intel.com,
 alim.akhtar@samsung.com, alok.a.tiwari@oracle.comm, beanhuo@micron.com,
 can.guo@oss.qualcomm.com, linux-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
 peter.wang@mediatek.com, ulf.hansson@linaro.org, vamshigajjela@google.com
References: <20260527072228.271542-1-cw9316.lee@samsung.com>
 <CGME20260528004352epcas1p4474702b6aae3232afefc3b7b528523ee@epcas1p4.samsung.com>
 <20260528004349.281467-1-cw9316.lee@samsung.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260528004349.281467-1-cw9316.lee@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-24200-lists,linux-scsi=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 319855F52FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/27/26 5:43 PM, Chanwoo Lee wrote:
> Could you let me know if you think the remaining changes are
> acceptable, or if you consider the entire patch unnecessary?
> I'd like to clarify this before sending v2.

The remaining changes look good to me.

Thanks,

Bart.

