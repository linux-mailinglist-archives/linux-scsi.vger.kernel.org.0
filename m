Return-Path: <linux-scsi+bounces-24329-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OapK1+vHWondAkAu9opvQ
	(envelope-from <linux-scsi+bounces-24329-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 01 Jun 2026 18:12:15 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1426225FB
	for <lists+linux-scsi@lfdr.de>; Mon, 01 Jun 2026 18:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D87C300F554
	for <lists+linux-scsi@lfdr.de>; Mon,  1 Jun 2026 16:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B76F2BEC2A;
	Mon,  1 Jun 2026 16:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="4Z3vlf5s"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13FC29BDB5
	for <linux-scsi@vger.kernel.org>; Mon,  1 Jun 2026 16:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780329935; cv=none; b=UnGl/S9p92+k7yTXPgopC5GoFAdrAHhj3hwOWp6D2t1+OLUH0IA7S33LoapThf7cTDREslz91zDhnS4/fmhQCvLa3T7lmQPewVwCCXSHJmCr8S+kbkbHiP8hJXwttG5P5/XGCvLSEjCoA3KVKirzwHkteLAYJ043tAJ/GIglTRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780329935; c=relaxed/simple;
	bh=o+7n7bW/BxHb73sHRoBR7/CewcPDfHU9MHV5df0kTbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MKISPXrcTUvk30II7QX5IdQfcVLnhgN3mJHWiCP7gKCfkK783jryUmLhewWvgPAWFQomyh8bBiSzeniq0GSPbAio3ahHqcNNEWlhz3qNsnIRxDNxhQxsfESnRVSIHXyd96NjZ3I6YKhpKhZ5ry1oZaC9qQ/pj44zWO6hH5WiL5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=4Z3vlf5s; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4gTf262cZdz1XM0p7;
	Mon,  1 Jun 2026 16:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1780329931; x=1782921932; bh=Lulvk3VmyfyW6mH6od8gYTnH
	eVY4P0vdtasEAihHeko=; b=4Z3vlf5seAUk5JupixEtPh0uihJkch0G4MydxUHm
	7xhWIpYCOn0rtAmDHWCBL8B+qxVz8pn5TYDAIElzlQHqzxW8Rlrl7GLI7H5/OIOr
	4cslpR+8olgSL56xNkZEbJvrfnb65AHojWMiEQ4j5nNcoSDZworQc7RWA1vXSmYw
	2TSkAh5dEmsXPd0m+arlDV8+MSx5fHb0o/gEx1GiqeEC8Y4kKmJutcJXI5lFsR3c
	DEGGEg9C4TNiiFQtYEI/7vDG34A1QmyfhVbJGKvV6h3Kz/UcQdzeKWedaQ+cLCGw
	Or9QPcTlAaOCVjWwvfCtBTQjtQxNrrKeqScJuJM/Gyx5wQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id vKkBbEgARojv; Mon,  1 Jun 2026 16:05:31 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4gTf221lVrz1XM0p2;
	Mon,  1 Jun 2026 16:05:29 +0000 (UTC)
Message-ID: <320f6fdc-eb9f-4c2f-af3e-29f112b4cee5@acm.org>
Date: Mon, 1 Jun 2026 09:05:29 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] scsi: Refresh INQUIRY data and reprobe on rescan
To: Brian Bunker <brian@purestorage.com>, linux-scsi@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
 hare@suse.de
References: <20260429224939.77082-1-brian@purestorage.com>
 <20260530002019.47109-1-brian@purestorage.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260530002019.47109-1-brian@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24329-lists,linux-scsi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,acm.org:mid,acm.org:dkim]
X-Rspamd-Queue-Id: 1B1426225FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/29/26 5:20 PM, Brian Bunker wrote:
> This series teaches the SCSI rescan path to refetch standard INQUIRY data
> and reprobe the device when the response has changed.  The motivating
> case is an ALUA target that transitions through the "unavailable" state
> and afterwards reports a different peripheral device type / qualifier;
> today the kernel keeps the stale INQUIRY data and the device's sysfs
> attributes diverge from what the target reports.
Please post a new version of a patch series as a new email thread
instead of as a reply to an older version. Many email clients use the
timestamp of the first email in an email thread when sorting emails.
Hence, when posting a new version of a patch series as a reply to an
older version, the new version appears at the bottom of a mailbox
instead of at the top.

Thanks,

Bart.

