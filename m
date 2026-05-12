Return-Path: <linux-scsi+bounces-23745-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALDEEv6HA2r46wEAu9opvQ
	(envelope-from <linux-scsi+bounces-23745-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 12 May 2026 22:05:18 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A10F8528F07
	for <lists+linux-scsi@lfdr.de>; Tue, 12 May 2026 22:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27BC83047E48
	for <lists+linux-scsi@lfdr.de>; Tue, 12 May 2026 20:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5983A9629;
	Tue, 12 May 2026 20:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="y4VDnTpI"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD4E3A872A;
	Tue, 12 May 2026 20:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778616313; cv=none; b=F5ngcCkxh/HQKZEQty1JUfuzqUpHkomGMnBeoZPaRXPyYjoa4CMUIcYu54BHy+RPTxviECRE99THa65j+DQtYo2afNVjEqXcUgjk+znyyUHV9gYaOVdOHdVcWDWASjcQ5QnSm5Zd1qymHS2T8E47SDsAw2dAmScCmGQfOxagji8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778616313; c=relaxed/simple;
	bh=AZU0ALXZvR8kX9UqFA4Rrpt3xx5uJ2HBs+CvGxfX2y0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SznKEBO/z4I7NBR5I26ILiACZS8NTJUktDzFjNQqCTYqMflPPZdycc024i7NXqTgXEgJ7DeHSyyrE2d39FZ0NxTKeQrEBPcH1x0gt7faVjc51pPkrxVvaTkHMS8ZY9zCiwgxDAOo4sfGGcHlyW9Jg7H7ANxqZ3vnHqlDEhCGkpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=y4VDnTpI; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4gFSHq07zhzlfl89;
	Tue, 12 May 2026 20:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1778616306; x=1781208307; bh=3QPl8pMWeY141ZF1RwbgGUbx
	9yPxM3yZBIJcDTiuygk=; b=y4VDnTpIUJQ8XKktrEFb8JONSi7rf2L5SsNAeVIJ
	NGvKB9fkoXN0QwBKGM/n4/Fn4+6BzfXM3HWmvLxBzlIdbrKsRyfSDV0jZ2MnuaJt
	RFD4xqm3c2PHONkSkVTJgZnx9De5l+2s4MaLKmLqvlZc5SS8LgNmu+7fK1b8uXJJ
	iLxQrMEq/cmBVG4GNlPLqal+hHCXsyJIjc89mFazT00ONwhag2dG1i9/fLio5+Dq
	6Qi1Ab6aX/39TXzJuiS12qIXFFkR6UfO/On/8FFToBsX0zrujyeiunoRvntNu1NN
	2D9tjgIJwM5IuxluyNpFeKkEQWo1mjS5pJB+b57NVuENlw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id p2PYJdvoaVCq; Tue, 12 May 2026 20:05:06 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gFSHg6zwXzlfvq4;
	Tue, 12 May 2026 20:05:03 +0000 (UTC)
Message-ID: <73fa5a46-bd2d-44cf-8bf5-3ce74e60e324@acm.org>
Date: Tue, 12 May 2026 13:05:02 -0700
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ufs: ufshcd-pci: Use PCI_VDEVICE and named
 initializers for pci array
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
 Peter Wang <peter.wang@mediatek.com>, Bean Huo <beanhuo@micron.com>,
 Can Guo <can.guo@oss.qualcomm.com>, Archana Patni <archana.patni@intel.com>,
 Markus Schneider-Pargmann <msp@baylibre.com>, linux-scsi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1777968942.git.u.kleine-koenig@baylibre.com>
 <6cac1c22381f7026edad9854d70833381d14929a.1777968942.git.u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <6cac1c22381f7026edad9854d70833381d14929a.1777968942.git.u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A10F8528F07
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[acm.org:+];
	TAGGED_FROM(0.00)[bounces-23745-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/5/26 1:28 AM, Uwe Kleine-K=C3=B6nig (The Capable Hub) wrote:
> The pci_device_id array uses a mixture of ways to initialize
> ufshcd_pci_tbl[]. List initializers are hard to read unless you memoize=
d
                                                                   ^^^^^^
                                                                memorized

Otherwise this patch looks good to me.

Thanks,

Bart.

