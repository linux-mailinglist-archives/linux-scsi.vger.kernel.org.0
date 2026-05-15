Return-Path: <linux-scsi+bounces-23843-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NZcEe1lB2oF1wIAu9opvQ
	(envelope-from <linux-scsi+bounces-23843-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 15 May 2026 20:29:01 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C093556386
	for <lists+linux-scsi@lfdr.de>; Fri, 15 May 2026 20:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 748D030D0E79
	for <lists+linux-scsi@lfdr.de>; Fri, 15 May 2026 18:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF833DE43D;
	Fri, 15 May 2026 18:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="PMuJmiIV"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FDD3F39CE
	for <linux-scsi@vger.kernel.org>; Fri, 15 May 2026 18:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778869251; cv=none; b=Tzau0Bu1kXRikqRMmsY61s7/UvWakZo7Ym6G+zbbPZzx91nTzLc4S6+anIg6kOCPEx5EHI+GyjVxUKg7eQzhc+UKx0tqoVAFiOxOQ6oB/LWBEXhnGD+o91mmhUvlOKMsDjYSKvaGGzxn/I8ZbxDbLOKSax6vaIJpRM+zsZFp1zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778869251; c=relaxed/simple;
	bh=qq37aSrrvO74eOeW8bUGRQ9g9PzDz8LFM3pZc9T9Slc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AU3PW55hdlN8xtcRMoF3+8yinJxbCzQ4B8CMcxTDMuZJ2+Z9AU6LOd0nqQZ3KafwYLdlvXqduWW8KrxsFRAxpdnSFizP7Cqz3Pybnbsas04P2aqMr2Y88iQNT4Oer0fiM/LjWLc2QIiANHFwIpSoI2Ez0Lm5HXHh9S+ji2fiEnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=PMuJmiIV; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gHFr16f60zlh1T8;
	Fri, 15 May 2026 18:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1778869247; x=1781461248; bh=89AUR64Uo70BRyWSwW5e2YKj
	5SyWbJj2f0k7/w4r/BQ=; b=PMuJmiIV4AoXsYYjGJoww5NsJIPETIkfSU+m0FEi
	MmrxMzF/+55wA/u58ImgU77SGvx5dcFfdaDltRlKLsejLtUi4WUB8y8+EsjQa+on
	wQs9Rjn38Ww3KmkbsXmcoGAo1+mHbGd7YtTmwLF5JndPSmDMJrF/X+aekegcZdvV
	3ioonrdDjLj3VAKCRliYa8V4xF+gkvqd9tiF09OyIYI/rX1ZmY1nwLpHWhmV0Uii
	5tIUU072R0VUknFQPoYgIJmkp3Uds7a0b41RVKO+q0CR+2iXOflE6luTZ4atK9HU
	5t9VoFNlwOGjuXW+a2eqK7Sml+ZBylmHM9zREU26nFmcYA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id wqZiDdO19JBQ; Fri, 15 May 2026 18:20:47 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gHFqy6k4NzlgwMq;
	Fri, 15 May 2026 18:20:46 +0000 (UTC)
Message-ID: <ed7a4268-4ad7-4dbb-a1d9-421ede3538c2@acm.org>
Date: Fri, 15 May 2026 11:20:45 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: core: run queues for all non-SDEV_DEL devices from
 scsi_run_host_queues
To: David Jeffery <djeffery@redhat.com>
Cc: linux-scsi@vger.kernel.org,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20260513173552.9222-1-djeffery@redhat.com>
 <65a4ac0a-ea6f-4a83-958c-169d4e2a62e8@acm.org>
 <CA+-xHTHvYtDX+qg_HLhCgnTdrr0q-btGVoY9gb3kwHY_Q4CQTQ@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CA+-xHTHvYtDX+qg_HLhCgnTdrr0q-btGVoY9gb3kwHY_Q4CQTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3C093556386
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23843-lists,linux-scsi=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,acm.org:email,acm.org:mid,acm.org:dkim]
X-Rspamd-Action: no action

On 5/14/26 10:27 AM, David Jeffery wrote:
> On Wed, May 13, 2026 at 5:58=E2=80=AFPM Bart Van Assche <bvanassche@acm=
.org> wrote:
>>
>> On 5/13/26 10:35 AM, David Jeffery wrote:
>>> +             if (sdev->sdev_state =3D=3D SDEV_DEL ||
>>> +                 !get_device(&sdev->sdev_gendev))
>>> +                     continue;
>> A comment would be welcome above this statement that explains that
>> get_device() is called instead of scsi_device_get() because the latter
>> skips devices that are in the state SDEV_CANCEL state.
>>
>=20
> Would the wording:
>                  /*
>                   * Only skip devices so deep into removal they will ne=
ver need
>                   * another kick to their queues. Thus scsi_device_get =
cannot
>                   * be used as it would skip devices in SDEV_CANCEL sta=
te which
>                   * may need a queue kick.
>                   */
>=20
> work for you? Thanks for the feedback.

How about adding that other similar loops use scsi_device_get() and
changing "scsi_device_get" into "scsi_device_get()"?

Thanks,

Bart.

