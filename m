Return-Path: <linux-scsi+bounces-21041-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJ8aBvDwnWkWSwQAu9opvQ
	(envelope-from <linux-scsi+bounces-21041-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Feb 2026 19:41:52 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8350818B85A
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Feb 2026 19:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74B14304F5F6
	for <lists+linux-scsi@lfdr.de>; Tue, 24 Feb 2026 18:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658D83AA1A4;
	Tue, 24 Feb 2026 18:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nqx9Cmpd"
X-Original-To: linux-scsi@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC2B3A1E81
	for <linux-scsi@vger.kernel.org>; Tue, 24 Feb 2026 18:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771958508; cv=none; b=QXZvR+goB+KxL+TgqdgXbru2lSwqpe3Q8y+coHtBAPjr2ed6jGRq0L9jENvRrlwmgWc8gzjQoAHvwIdvBaLf5av72ShFTWyprHkGS5gY1pnbeoojrSx97bPSthJ0qSySl6Oj5LykrwJ0ZKEqVoaxaiWC2gUk43R+ZSTaWrXlAtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771958508; c=relaxed/simple;
	bh=6e0NpjfZmhRjRAKCvu6kZMdRasBBe4nxdRq2eaU1gX8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LZOdbLKwcaEy7D9W3S9GuTnsvEugGyXB1Byq50WEM/GA5emo7ttzZ0/934Qi/1IIudA1t+/GioCeCuF5iFeei1qDxyzuq/D14Qs0KbQzizL/Rutn0wQWjbBzSQHNOx5DZFf4g69vBlyM2kd6bt0qh2w7lsBQ3NbPIufG9WeI6d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nqx9Cmpd; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771958503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=di2K+/lkPw2iD/htfmgecsUtim9xgXXLLRhFeUvIFxg=;
	b=nqx9CmpdnaGagCWHaAfhAbjfxXfSUlhGRn1Bve9H420ioOD99sGvNfs3BohcoQAeyMgYDo
	THsD+hYnQnGr+iJrv34WJHWuIvG1vfnWBXAzSxVT3JBm+cnXrhG7qogHIpvRREQW1kmSK2
	fcxBbiTSj3B7PfGVacyLY3hHlkMlojg=
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH RESEND] platform/surface: Replace deprecated strcpy +
 strcat in blogic_rdconfig
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <yq1qzqa80xx.fsf@ca-mkp.ca.oracle.com>
Date: Tue, 24 Feb 2026 19:41:10 +0100
Cc: Khalid Aziz <khalid@gonehiking.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <27B1DB11-A0CE-48CE-9A98-F38E9ACD58D9@linux.dev>
References: <20260224144828.585577-1-thorsten.blum@linux.dev>
 <yq1qzqa80xx.fsf@ca-mkp.ca.oracle.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21041-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8350818B85A
X-Rspamd-Action: no action

On 24. Feb 2026, at 19:15, Martin K. Petersen wrote:
>> diff --git a/drivers/scsi/BusLogic.c b/drivers/scsi/BusLogic.c
> 
> ...and yet tagged as "platform/surface:" in Subject. I fixed it up.

Sorry Martin, no idea how that happened. Thanks for fixing it.

Best,
Thorsten


