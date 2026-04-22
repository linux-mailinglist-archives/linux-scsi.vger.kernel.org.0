Return-Path: <linux-scsi+bounces-23221-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBxgMI896WmEWQIAu9opvQ
	(envelope-from <linux-scsi+bounces-23221-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Apr 2026 23:28:47 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C388244AEAF
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Apr 2026 23:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 992ED300B28A
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Apr 2026 21:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519A335C18C;
	Wed, 22 Apr 2026 21:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="daA1nv4E"
X-Original-To: linux-scsi@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1B2286D57
	for <linux-scsi@vger.kernel.org>; Wed, 22 Apr 2026 21:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776893317; cv=none; b=CwA8m1ZGtXblRjtCKtQjcNIoRHZLWRX2Ne7wYj/DfyEl7VWyGrSc5SCG5/tzp6ZlpLpuSp0APqiUDIBHcXHwpVl9U9PQY5201L5TtDY74d8Yvf9dWs9MvSFoEEtg8T8ej5gXjSX8hwtjqMqj4BA9m+Cvu9p6RuWLrQVoiphJj7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776893317; c=relaxed/simple;
	bh=CquhhgFGSv6ftFYUJJC2CdtpiGXTjxEJ9Q/L2qjH8iU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Md4OA1RCKAvkiAaMfMRcN9eYxVrh/C5HJxnTnhNUr+LuDmd/SGoa+pnuoWn+r/JSaGCvsjbMzLNakI/lU6bnF1qzuG4fYGtOoo2VZpbfYBzGTCUb8rLuiLMIWBThzJ136DtxKw9BlUoI9ZlfX3051fOB0TKUU2kYVHmzLgFI7qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=daA1nv4E; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776893313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cgpza/ygVqVA9S3quWs8Q35TCmfB+GLC9CQWXkpoesk=;
	b=daA1nv4EjYnSQLIE7dEMjIdoIMZC+orNAQvKRf1ByycCi4bPaBGaW2hGTdZwDfyOdXa2qb
	0glFoOF2Dq6n0hpicGLRRDEUCYyZl+PTLFy5IJHVTiLMpzuAZq8Q2iKR/VLZKTaJzprZpO
	1cwVSZV6Ayy/jV1maIfiGf0YJyB+YWs=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: LSF/MM/BPF: 2026: Call for Proposals
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
In-Reply-To: <81033e57-99e5-43f1-a6c3-c363e96f9c9f@acm.org>
Date: Wed, 22 Apr 2026 14:28:17 -0700
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 bpf@vger.kernel.org, lsf-pc@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
Message-Id: <32CD853E-921D-4EEA-B1D0-4E4A7537861A@linux.dev>
References: <81033e57-99e5-43f1-a6c3-c363e96f9c9f@acm.org>
To: Bart Van Assche <bvanassche@acm.org>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-23221-lists,linux-scsi=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roman.gushchin@linux.dev,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C388244AEAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I suggest LSFMMBPFLLM :)

> On Apr 22, 2026, at 1:30=E2=80=AFPM, Bart Van Assche <bvanassche@acm.org> w=
rote:
>=20
> =EF=BB=BFOn 1/10/26 5:24 AM, Christian Brauner wrote:
>> The annual Linux Storage, Filesystem, Memory Management, and BPF
>> (LSF/MM/BPF) Summit for 2026 will be held May 4=E2=80=936, 2026 in Zagreb=
,
>> Croatia.
>> LSF/MM/BPF is an invitation-only technical workshop to map out
>> improvements to the Linux storage, filesystem, BPF, and memory
>> management subsystems that will make their way into the mainline
>> kernel within the coming years.
>> LSF/MM/BPF 2026 will be a three-day, stand-alone conference with four
>> subsystem-specific tracks, cross-track discussions, as well as BoF and
>> hacking sessions. Please check out:
>>           https://events.linuxfoundation.org/lsfmmbpf/
>> for further details on the venue and hotels.
>=20
> Thank you Christian for being one of the organizers of the
> LSF/MM/BPF summit. Will a schedule be made available before the summit
> starts? A link to the 2024 schedule is available at
> https://lore.kernel.org/all/20240510212132.83346-1-sj@kernel.org/.
>=20
> Thanks,
>=20
> Bart.
>=20
>=20

