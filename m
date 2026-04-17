Return-Path: <linux-scsi+bounces-23055-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AIJNWRg4mnI5QAAu9opvQ
	(envelope-from <linux-scsi+bounces-23055-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 17 Apr 2026 18:31:32 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A8B41D238
	for <lists+linux-scsi@lfdr.de>; Fri, 17 Apr 2026 18:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 071E63007F7D
	for <lists+linux-scsi@lfdr.de>; Fri, 17 Apr 2026 16:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA014274658;
	Fri, 17 Apr 2026 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="JoypwH+U"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203B634D91C
	for <linux-scsi@vger.kernel.org>; Fri, 17 Apr 2026 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776443333; cv=none; b=lObLuv6F5f94S1CdfR3s50GBdRDOq6T86Cciz47Zgbdi27uIOc0h5208uUImR1v9A7R/2BdlcU+XcdWzJqNhU/yYMsH1Ou6KIK3G/tlULGo1S59LfVoa0LAVECknwsmiLTQ8HcRGIIAue0Jh9qYkXO27J7poeINIxKjnboh+Ez4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776443333; c=relaxed/simple;
	bh=b79gdJKXp8ykXUYuSvgGKlNkS6oyZ1Gl360uWFQttU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ofzujNq/Nnf0ILQ80ON2D5kSJysYN5EE5yzVB+yzFyt0t9yrgXcNw286sBz78b2Se4RUYF3Jejb8YEyO8AeRuOb7e2hHRlmV28wQGVeCqPwDvllSoxj6J4nOqBZ2Xl+qT/gK1nOKI447rZKSx1Y/mr0mxdih06VdoR87dkmszY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=JoypwH+U; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4fy0gl3PVGzlffvg;
	Fri, 17 Apr 2026 16:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1776443325; x=1779035326; bh=b79gdJKXp8ykXUYuSvgGKlNk
	S6oyZ1Gl360uWFQttU0=; b=JoypwH+UTJ35BwGoavH+Ng2mxhxn3BGOdldivpHH
	FB+W07SFm5S9y+R8vssZOQ8+syCsXWtW829LgkkZZwe3J8sd4qaBWBqPeD2eNymL
	AwsAJ4ql/U0yRtkLQ0tX11ELUw7s+di5CfM35KyIAtQibFLIr9LB8OVcnFQPUhVV
	sjBFE5Ai1EPydWI+Ou7ierqieIPW2/pN9D1DavjXbrH+1vFRXV/XCb79siBY1T62
	Ur07EIppcRiiKL50lRJRDlJzz0HG6VqDgSna/5o6y0iYM2x/ivF1NG7BbZzrMzmK
	syjh39kYi49Xo4amIV7UJEoHjWN/l2UcZLIDlx5xzsK0HQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id omr2MPoCY_BS; Fri, 17 Apr 2026 16:28:45 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4fy0gY56Hjzlfl6F;
	Fri, 17 Apr 2026 16:28:41 +0000 (UTC)
Message-ID: <e737fb26-d70b-4d04-b2f0-1c904e1d44e9@acm.org>
Date: Fri, 17 Apr 2026 09:28:40 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ( was Re: linux-scsi project on GitHub & SCSI user space
 utilities maintenance) sg v4
To: Xose Vazquez Perez <xose.vazquez@gmail.com>,
 Martin Wilck <mwilck@suse.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, Doug Gilbert <dgilbert@interlog.com>,
 Douglas Gilbert <gilbertdl@gmail.com>
Cc: Paul Evans <pevans@redhat.com>, =?UTF-8?B?VG9tw6HFoSBCxb5hdGVr?=
 <tbzatek@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Lee Duncan <lduncan@suse.com>, Martin Wilck <martin.wilck@suse.com>,
 Mike Christie <michael.christie@oracle.com>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 Chris Hofstaedtler <ze1ha@debian.org>, Daniel Horak <dhorak@redhat.com>
References: <e99744196d8a0ca2bffec1d13109eea071c99096.camel@suse.com>
 <9aec9557-b619-437b-a11a-bf65a238b69e@gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <9aec9557-b619-437b-a11a-bf65a238b69e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23055-lists,linux-scsi=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,suse.com,oracle.com,vger.kernel.org,interlog.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	DKIM_TRACE(0.00)[acm.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,acm.org:dkim,acm.org:mid,interlog.com:email]
X-Rspamd-Queue-Id: 54A8B41D238
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/17/26 8:42 AM, Xose Vazquez Perez wrote:
> I=E2=80=99d like to bring up the current status of sg v4.
>=20
> Douglas was working on the first of two stages: "[PATCH v25 00/44]=C2=A0=
 sg:=20
> add v4 interface"
> https://lore.kernel.org/linux-scsi/20221024032058.14077-1-=20
> dgilbert@interlog.com/
>=20
> However, it seems no one has taken over this task since October 2022.

SG/IO is working fine as far as I know. Rewriting it involves a risk of
introducing bugs.

Thanks,

Bart.

