Return-Path: <linux-scsi+bounces-22794-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNxjHkrZ02nUnAcAu9opvQ
	(envelope-from <linux-scsi+bounces-22794-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Apr 2026 18:03:22 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 752B23A50D3
	for <lists+linux-scsi@lfdr.de>; Mon, 06 Apr 2026 18:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 95D4530074EF
	for <lists+linux-scsi@lfdr.de>; Mon,  6 Apr 2026 16:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6199A332EBB;
	Mon,  6 Apr 2026 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="lzvw7pwp"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13093446B0
	for <linux-scsi@vger.kernel.org>; Mon,  6 Apr 2026 16:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775491395; cv=none; b=loUcin1HSxigwdq9iIO2NM0d7qEqbp3wA+jXjc02PitmEJJKIA6NlTYjW3n0yuj4AXJK+GmjYDduYZMqLenkdp6VM7wbH9SF/2qcM7tutteZvP/G+ByYeKikASL0h7223ewH/F2zoLOXKdZFOd0/lrX0aaQtCai/P0w5TDh/IsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775491395; c=relaxed/simple;
	bh=mJlDBtTeKqrQ9h3u4VySl+p+8x7msIpWv/ppenA1xaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZCJGC1+HefNxylHxsgi3+2BsmlbynPDFo5UQBUZCfRE3KbW4jaMOYiYHWLf1Ntt/rWYouVdS9QXVcNWlLO6NE8bzg7C9F6kEdmhOcj6NEbiV3+QDzuupTJJ4gHwat4B25aoZZDlfu1kkdGa06Zgk7Qmay+U3pICG7u3Ob0+1HZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=lzvw7pwp; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fqDd748mkzlfgPZ;
	Mon,  6 Apr 2026 16:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1775491382; x=1778083383; bh=2YX6l5gPOTneaURa/iciaJz7
	zpAXjKfSGte17sq40CM=; b=lzvw7pwpbSAuP52DXvBzXROWIYojvTOZ1QWuaAtn
	xdn6AuMyWWdr2n5TWeq7VZcZ+gnNAtpi9bTZZEdTi40+IVyLoSmaT1+NoXHBXdlm
	asqVukBPvYM5l52WaYGFREZOwnm9hmQRTPO+Kd7n8ZsTvhJdAtOQ2GV88K3sUovV
	6f19GU9+rpescD89KyN+no884Z3mmFN9pUOOwlSILfVhR0aDprxbf+N/34gu7Q7j
	O0S6sPgph5fbJteQ1qRsHLSXpySMjSKdQLYQI1YfrBiGH4xeClsWIIco2xzdnKLL
	zyEKE4FiUnEMwdmIY8Govh7HCl3LlQPJjXj0xDYHJ5lnfQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id pncVTJuHuXI4; Mon,  6 Apr 2026 16:03:02 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fqDd12F6Yzlgy20;
	Mon,  6 Apr 2026 16:03:01 +0000 (UTC)
Message-ID: <7312936a-bd21-4c4d-a307-eb03c55af825@acm.org>
Date: Mon, 6 Apr 2026 09:02:59 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ufs: qcom: Reduce interrupt latency
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
 Nitin Rawat <quic_nitirawa@quicinc.com>, linux-scsi@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>
References: <20260330183311.1941942-1-bvanassche@acm.org>
 <20260330183311.1941942-4-bvanassche@acm.org>
 <fg4i4d3fjpjvwp5xe5zvzwjlhq5dlmiauchh62fka5lujmolcm@pzzbd7h3se3e>
 <99c8b626-4c06-411b-bc01-6324df5b3137@acm.org>
 <pvualeorhaopbphb7vvvw2qbxibsupddl642jzrxa43jveyxze@bs2ixsupmbuz>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <pvualeorhaopbphb7vvvw2qbxibsupddl642jzrxa43jveyxze@bs2ixsupmbuz>
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
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22794-lists,linux-scsi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,acm.org:dkim,acm.org:mid]
X-Rspamd-Queue-Id: 752B23A50D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/3/26 8:11 PM, Manivannan Sadhasivam wrote:
> I'm not too familiar with Android internals, but isn't that Android has some
> irqbalance or similar utilities that manage the UFS interrupts based on system
> load?

It seems to me that irqbalance or any similar software is not compatible
with the Android goal of saving energy. An important goal in Android on
systems with heterogeneous CPU cores is to wake up the larger CPU cores
as infrequently as possible since larger CPU cores use more power.
irqbalance might assign interrupts to a larger CPU core even if a little
core can handle the workload.

 > Managed interrupts work better if we want the interrupts to be 
managed> by the kernel, without user intervention. Not sure if that's 
what we really want
> for UFS.

All blk-mq drivers I'm familiar with use managed interrupts. Why should
the UFS driver use a different approach? When using managed interrupts,
if the number of completion queues is larger than or equal to the number
of CPU cores and if rq_affinity=2, the completion interrupt will be sent
to the CPU core that submitted the I/O. With this approach the number of
cache misses triggered by the I/O completion code is minimized. Data
that is needed by the completion handler, e.g. struct scsi_cmnd, is
most likely still present in the cache of the CPU core that handles the
completion when the completion is handled.

Thanks,

Bart.



