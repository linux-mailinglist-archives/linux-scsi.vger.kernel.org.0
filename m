Return-Path: <linux-scsi+bounces-22673-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IBMWOTtAzWkkbAYAu9opvQ
	(envelope-from <linux-scsi+bounces-22673-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Apr 2026 17:56:43 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 927E937D880
	for <lists+linux-scsi@lfdr.de>; Wed, 01 Apr 2026 17:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8E193010613
	for <lists+linux-scsi@lfdr.de>; Wed,  1 Apr 2026 15:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AF631E838;
	Wed,  1 Apr 2026 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="gBO50yV2"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41B83D566D;
	Wed,  1 Apr 2026 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775058972; cv=none; b=sJ1qxMknbp5uud/wLEDeK+VCaMhC5tOkGupzFEf02M0UG8Lz58UnXwS2HisSfy3QtzLKJ120s4czbvEXFWh4HSP9rW/2jLZMi/Q/kOEmFXR9MNVHhDwmVqgIAodz5Ph7fGuOwMWO9f/af75OThoPs3PPTcWiDNlQYK4K5Ek3rmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775058972; c=relaxed/simple;
	bh=Nyoh+HfiRGymWn6IRSwvuq+bJzMVZ8NetVmR+Z7H8qA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H5VCsvSepFqws8qnzfn0C+/LKs+WLJ6WSH5muuVAiRxLf9Nk/9ofFk9ZDf/GmqWOJ03cSkpUwGXrYO8vT7vbPMROPYGvWlmDJNXk6yal/34+4X/MbsPhgStq3dwnTCke/f0wqiwIVd+tpZRVo/chbJbPseo/4etrYDL9+jP6C7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=gBO50yV2; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4fm8jR32slz1XM6J9;
	Wed,  1 Apr 2026 15:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1775058968; x=1777650969; bh=Nyoh+HfiRGymWn6IRSwvuq+b
	JzMVZ8NetVmR+Z7H8qA=; b=gBO50yV2rO0JDEqI8zqtf+7XXdmOrceTWHR0RSZ5
	Hc6aohUc+CNJkbnoJf/FT8lcZmkzAR0iTah5G82NcsVDp93D8AHOR8GS2+2Sb6Zk
	TW93U+OrQGy8ZoRd3H4ca9RvrwxGxODumLbl8h1a92gb4p2Yn1EJ718XSe/Unejr
	qfDosMommwuIFWkfKJ2D46ytb6RPlqulhmNdwnIqaJeUq0YhzXkAxvTB5raoEHGT
	U7Xl0Snz+rkb+Qbc8O63JDwHNZM7EZRGbrmvPRlxeO4D8Q5jejQH8jweayPbXg/0
	43w4FI1MVYhvQHV7z1oZTFRLCEdby2v1fqd8mWYI14dHIA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 0SZuz2kLQDX2; Wed,  1 Apr 2026 15:56:08 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4fm8jL5lwnz1XM5kW;
	Wed,  1 Apr 2026 15:56:06 +0000 (UTC)
Message-ID: <9c556370-5e85-4cb6-8f4d-c0361467b2f3@acm.org>
Date: Wed, 1 Apr 2026 08:56:05 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: LIO PERSISTENT RESERVE OUT PREEMPT spec compliance
To: Stefan Hajnoczi <stefanha@redhat.com>, target-devel@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260401124626.GA266484@fedora>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260401124626.GA266484@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22673-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.980];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,acm.org:dkim,acm.org:mid]
X-Rspamd-Queue-Id: 927E937D880
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/1/26 5:46 AM, Stefan Hajnoczi wrote:
> Thoughts?

There is a persistent reservation compliance test suite in libiscsi.
SCST passes that test suite if I remember correctly. It would be great
if LIO would pass the tests from that test suite too. See also
https://github.com/sahlberg/libiscsi

Thanks,

Bart.

