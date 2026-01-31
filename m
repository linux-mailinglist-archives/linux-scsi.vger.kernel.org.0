Return-Path: <linux-scsi+bounces-20649-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDUeHbPdfWmlUAIAu9opvQ
	(envelope-from <linux-scsi+bounces-20649-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Sat, 31 Jan 2026 11:47:15 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC040C19A6
	for <lists+linux-scsi@lfdr.de>; Sat, 31 Jan 2026 11:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95391300A3A0
	for <lists+linux-scsi@lfdr.de>; Sat, 31 Jan 2026 10:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C9A25D216;
	Sat, 31 Jan 2026 10:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b="LYccEN8u"
X-Original-To: linux-scsi@vger.kernel.org
Received: from out30-71.freemail.mail.aliyun.com (out30-71.freemail.mail.aliyun.com [115.124.30.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972C72AD20;
	Sat, 31 Jan 2026 10:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769856430; cv=none; b=aEseR1a8I/Hjf8CE7xSMBkbgLoo/Vp0KWc5pZ2otYshpFz17GudmAbj1DCITsnYkWeE0eGZMumU1EzGTEFTCh1xwLBUdwIMSWDSFPZBR57KQn/y7R/rNFryxj0TpmWOlPijLL7Ehm3Zx6Wd925slqXuN3NHrmx8PlMeiWKVMDf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769856430; c=relaxed/simple;
	bh=YrNXlgG9itNtlTe98c5WuYPHZjs2coYzNe4Uwg5FRII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/OALJYiCsuVDsZKeh2hT9yyNrsbl6qHb2zWpY6lBTexzAcoz+Y2ntaOqFPOrJ1M8mDivJTF/D1SXk4ao3QSncyqkMBM9H1e/o/5Rus6Hg77bzKGF98x+e60Q2Qqx9YDpWOWZ2iSxLA1/5UVrOE/xNv9gxU7kLZmNPlu9RnlwpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com; spf=pass smtp.mailfrom=aliyun.com; dkim=pass (1024-bit key) header.d=aliyun.com header.i=@aliyun.com header.b=LYccEN8u; arc=none smtp.client-ip=115.124.30.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=aliyun.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliyun.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=aliyun.com; s=s1024;
	t=1769856426; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=v7en+wdUXpgRn8EvkLYpJKw6maDD0Rvto5ETIPT3RKM=;
	b=LYccEN8ugLZm+pdYVc1FFT9vUbh+gskQHoZZ+2jrQAKTYulR/tR/uaRl7wg9AAwrRPGjFpf8hvHxTQmNxiq8ZMT63XoKaNgCiQkN+I+u1EmnsyR3a4ZqychdsBbUg6Kwj9x28xpbv1go6PcR2GXxSXjdJfTjDhcWUQQFRIJ8WAM=
Received: from LAPTOP-RK2E6KJ3.localdomain(mailfrom:wdhh6@aliyun.com fp:SMTPD_---0WyDRtut_1769856422 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 31 Jan 2026 18:47:04 +0800
Date: Sat, 31 Jan 2026 18:47:02 +0800
From: Chaohai Chen <wdhh6@aliyun.com>
To: Jason Yan <yanaijie@huawei.com>
Cc: john.g.garry@oracle.com, James.Bottomley@hansenpartnership.com,
	martin.petersen@oracle.com, dlemoal@kernel.org,
	johannes.thumshirn@wdc.com, mingo@kernel.org, cassel@kernel.org,
	tglx@kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: libsas: Fix dev_list race conditions with proper
 locking
Message-ID: <aX3dpqtLmgNVaQEg@LAPTOP-RK2E6KJ3.localdomain>
References: <20260129093859.1418749-1-wdhh6@aliyun.com>
 <e59ff23b-81d3-41b7-ac25-ab886a3379bf@huawei.com>
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e59ff23b-81d3-41b7-ac25-ab886a3379bf@huawei.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[aliyun.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[aliyun.com:s=s1024];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20649-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[aliyun.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[aliyun.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wdhh6@aliyun.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aliyun.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,LAPTOP-RK2E6KJ3.localdomain:mid]
X-Rspamd-Queue-Id: CC040C19A6
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 04:27:11PM +0800, Jason Yan wrote:
> Hi,
> 
> 在 2026/1/29 17:38, Chaohai Chen 写道:
> > Multiple functions in libsas were accessing port->dev_list without
> > proper locking, leading to potential race conditions that could cause:
> > - Use-after-free when devices are removed during list traversal
> > - List corruption from concurrent modifications
> > - System crashes from accessing freed memory
> 
> libsas events are processed in orderd workqueue. Do you have a crash log?
No crash log. I noticed the missing locks while watching the code. But
there are tow queues, event_q and disco_q which may cause conflicts.
And I think the dev_ist_lock is designed to prevent conflicts.
> 
> Thanks,
> 祝一切顺利

--
Chaohai Chen

