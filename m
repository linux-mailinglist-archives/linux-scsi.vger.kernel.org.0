Return-Path: <linux-scsi+bounces-23663-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0H64IP0G+2mbVQMAu9opvQ
	(envelope-from <linux-scsi+bounces-23663-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 06 May 2026 11:16:45 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4194D8762
	for <lists+linux-scsi@lfdr.de>; Wed, 06 May 2026 11:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38F853042982
	for <lists+linux-scsi@lfdr.de>; Wed,  6 May 2026 09:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D36439B971;
	Wed,  6 May 2026 09:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Mi756IgV"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9043195EF;
	Wed,  6 May 2026 09:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778058979; cv=none; b=tqnBbH7ziQxDHvCYRpihHw9STeRXjkveOQ8CYcTg0JdvSvY8fPzaN5Omi31JvCmNQw+A+/yRmGgwQfHUCb1NNF9HKXqegEr8PjbxOxh5mfOdSpF8X+mdbap8lOzKbcocY7fQ/WD3l04xvzGtqb29yt23NIubmYsN2tmJ09cC+t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778058979; c=relaxed/simple;
	bh=CqeUJ4e4wXK+NNjvcvu0HObuHo9vYKXj++I/hmCqZY8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bnGXvHiR4pfJ2jOrFJabxcaK5c1nCgeAYZOQqAoEyFK9+xbXqW4X4A0rAlpYkX1G7YQzVhYkF5n1j5PqnR25LTjaQc7FQPOYOCyY2tLCNvLUaSeKxjDLdc/HczATPq1V1NhySUUfcQ/ZYv7wUqjFnTe5xtw4RaO197OXHVeeHDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Mi756IgV; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4g9V9r6cWcz1XM5kD;
	Wed,  6 May 2026 09:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1778058972; x=1780650973; bh=BEp8bycJfKIhXeD3khBYPDNx
	LORY1+2TYw8Jeae/OBw=; b=Mi756IgVprp9S6jbUB5v970+FJ8b+5M/VufPY22e
	ZJfMK0YJkGZm1/hJSDpcLDy1/nDkCmcD++GchKzK4JuRUU2/lwVcc64ZW06dh0F3
	xgtMCGW5HoxUU1nm+/tevuq+8TPj2CZHPRSlfMHxI7r1Wpbr1DNV8uPQkaY6cHhD
	fklJfBF/PoY7SDdAkphRDxE5fF9aeYFAkm13SEm833urD/xWgvA0KTIiZvDVcIhK
	eXcRsCxYMDd83ufYK4oEJ6fyYONEJrN52yqFNmOKUUCk3wM59dvoqyojNg6cSd1P
	+fYoibi3HETpjMeN1dwbTD3Mq5bzwQ+G0MEuvf5bYknLgQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 2dahMG_jDLO4; Wed,  6 May 2026 09:16:12 +0000 (UTC)
Received: from [10.211.9.52] (unknown [213.147.98.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4g9V9h6qVWz1XM5jn;
	Wed,  6 May 2026 09:16:08 +0000 (UTC)
Message-ID: <619d81fe-1db1-41b6-b9b2-a2546a030881@acm.org>
Date: Wed, 6 May 2026 11:16:06 +0200
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] scsi: ufs: core: call hibern8 notify when hibern8 cmd
 failed
To: Bean Huo <beanhuo@iokpp.de>, =?UTF-8?B?RmFuZyBIb25namllKOaWuea0quadsCk=?=
 <hongjiefang@asrmicro.com>, "alim.akhtar@samsung.com"
 <alim.akhtar@samsung.com>, "avri.altman@wdc.com" <avri.altman@wdc.com>,
 "James.Bottomley@HansenPartnership.com"
 <James.Bottomley@HansenPartnership.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260502143012.2859480-1-hongjiefang@asrmicro.com>
 <897db8bf4c82af97cd7bbb2b908bb9e2654b3103.camel@iokpp.de>
 <67965bf50abc4300ac9bd3aced2f18d8@exch02.asrmicro.com>
 <a349ab70dbed9355785bec38c7e05658f3c948a6.camel@iokpp.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <a349ab70dbed9355785bec38c7e05658f3c948a6.camel@iokpp.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EC4194D8762
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23663-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:dkim,acm.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On 5/6/26 10:47 AM, Bean Huo wrote:
> Thanks for the explanation. However, the kernel development practice is to not
> merge infrastructure without at least one in-tree user. Please resubmit this
> patch together with your platform driver (or at least the hibern8_notify
> callback that handles ROLLBACK_CHANGE) so reviewers can verify the design is
> correct and actually works as intended.
> 
> @Bart, any idea?

Everyone who works on Android smartphones has to deal with the following:
- The upstream-first policy.
- Not disclosing any aspect of the phone under development until it has
   been announced publicly.

Typically two years elapse between the start of testing kernel code for
a new phone and public announcement. Another 1 - 4 years elapse after
a phone has been announced until all kernel code for a smartphone is
upstream. Insisting on not merging any code upstream until a user for
the code is upstream makes the job of smartphone kernel developers
harder than necessary.

This is why I'm fine with deviating from the rule explained in your
email for small changes.

Thanks,

Bart.

