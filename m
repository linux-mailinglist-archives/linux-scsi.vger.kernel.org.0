Return-Path: <linux-scsi+bounces-23806-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLAuCoL3BWpVdwIAu9opvQ
	(envelope-from <linux-scsi+bounces-23806-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Thu, 14 May 2026 18:25:38 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D54544A4B
	for <lists+linux-scsi@lfdr.de>; Thu, 14 May 2026 18:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C74C3019C9F
	for <lists+linux-scsi@lfdr.de>; Thu, 14 May 2026 16:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D21E3358CA;
	Thu, 14 May 2026 16:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="V86cVgdp"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BF3282F3A
	for <linux-scsi@vger.kernel.org>; Thu, 14 May 2026 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778775790; cv=none; b=DAQTEboatkm2x2nxozvNFN7J7BoSP6trfgcUblMwFE7G6LZuzyzCzxcz0OgOHtv7FtTgts7e+xQwIpTQk4NY5gqk39N7xDvWoxquB9ORaoC/w6dZ9TTr+EMwLCDedDya36aHRulQ6/FLucmitEDvrOvBn8KZoAiPiqW76Y9Gkbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778775790; c=relaxed/simple;
	bh=RAUmrHg0Y1L3PBuTDoVsJvtHBZTneKNe6YaH0hHH8SE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qA8ffblXVClDFi54RFUYlZGrqWky2ZPy3ztBXvh9X+hQI4Jq0RDxLsK1d9zHW2z8A9Id+Xv5qTZwbEizNkcjJ0hooy4jcop+izzKYx48gTFQSOK0iTDxVdMr8fAya12AAo4t0Tr+FIeJyOnkiPtWVRMyKrX7FYS99H7WneB8a8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=V86cVgdp; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gGbGh3sdPzlgy27;
	Thu, 14 May 2026 16:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1778775781; x=1781367782; bh=swS16nnIbpByZs7OpRIN4lF8
	yu7slWPN+Qu1EPsvXms=; b=V86cVgdpdUjmZfuK5xfIZaWfL/D0YtlbkLAV+lO3
	eM10N88ARsPt9rSnVRTWMWr2gSFy6RIa+BOpOYQ/PudepMAbdDyB4dvsYZNeEGqV
	emehd18P3wsK32w2M+c+R3bkfNOyTuwj2R+NOQsf6OnSiX3MW0J1YhXje6LAvBS6
	x0pGNR2+KzGXUQmexoT5ALnrQVVJavHxSWV08YIvafl1FAgs4AtaUld0fYZCjeJt
	8XsUTaRXK9As5bpye6ugKEZjZdUzBL+khGirqRLyNTTE/p4xMXNlkKVsW5/Uw9lV
	sLPVgjAaFjOUMHskGc5OstDi+8WMNkCVvfsgZqZRujAQKw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id NEgB9YlGvc2u; Thu, 14 May 2026 16:23:01 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gGbGR50XTzlgy4t;
	Thu, 14 May 2026 16:22:55 +0000 (UTC)
Message-ID: <382f6d79-c877-4dc8-813b-ee91ac5489f9@acm.org>
Date: Thu, 14 May 2026 09:22:54 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ufs: core: decouple CQE processing from spinlock
 critical section
To: peter.wang@mediatek.com, linux-scsi@vger.kernel.org,
 martin.petersen@oracle.com, avri.altman@sandisk.com,
 alim.akhtar@samsung.com, jejb@linux.ibm.com
Cc: wsd_upstream@mediatek.com, linux-mediatek@lists.infradead.org,
 chun-hung.wu@mediatek.com, alice.chao@mediatek.com, cc.chou@mediatek.com,
 chaotian.jing@mediatek.com, tun-yu.yu@mediatek.com,
 eddie.huang@mediatek.com, naomi.chu@mediatek.com, ed.tsai@mediatek.com,
 quic_cang@guicinc.com, quic_asutoshd@guicinc.com, light.hsieh@mediatek.com
References: <20260514082906.58593-1-peter.wang@mediatek.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260514082906.58593-1-peter.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A3D54544A4B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[acm.org:+];
	TAGGED_FROM(0.00)[bounces-23806-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/14/26 1:26 AM, peter.wang@mediatek.com wrote:
> 4. In both ufshcd_mcq_compl_all_cqes_lock() and
>     ufshcd_mcq_poll_cqe_lock(), snapshot the starting CQE pointer before
>     advancing the head slot under the spinlock, then process the collected
>     CQEs after releasing the lock using the new helper.

This can't work reliably. ufshcd_mcq_poll_cqe_lock() may be called
concurrently from different CPU cores, e.g. from a UFS completion
interrupt and from ufshcd_poll(). Processing CQEs without holding
hwq->cq_lock may lead to overwriting of CQEs before these have been
processed.

Thanks,

Bart.

