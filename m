Return-Path: <linux-scsi+bounces-20566-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DqnGXnqd2nSmQEAu9opvQ
	(envelope-from <linux-scsi+bounces-20566-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 26 Jan 2026 23:28:09 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 125E18DEDC
	for <lists+linux-scsi@lfdr.de>; Mon, 26 Jan 2026 23:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB4153035249
	for <lists+linux-scsi@lfdr.de>; Mon, 26 Jan 2026 22:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C076306B3D;
	Mon, 26 Jan 2026 22:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="MhfJ+2Mp"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D385F306B1B
	for <linux-scsi@vger.kernel.org>; Mon, 26 Jan 2026 22:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769466474; cv=none; b=E0EOsQo3WPQTHrjaDpD8d4DaFqfLVNeynLij9wP4xHw1hTfyPF8d+7okPo3i632C/LRppX71IiU9Ekz5ng6ZWwr2yz1cY9np2/bwMBkELbsKqpvyophkgrzu2myeVI/DvNXjRUfmnfKPJpqkDCa967qVY3MtGEExl0JSsCvra6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769466474; c=relaxed/simple;
	bh=lFwO/XRKtNMnypPwC5IHo/imhAP9FHFENLVsrZ5m9B4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZMfkgK9wJT8eCJPgQDrzSVvjEGcp1OO4hnYQLxbyhiZY2TMNGw8hr+6ZUOXb/txhySlI4fkRMctZ4FnSbVK7JlQCjBIZ3UHH3J3xXlgn5/+fYcFPSgUnLUjsEcKU+z3EoX2408gAS2QR/I54G0cXEZnklsIewcg6XO3yVx98vK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=MhfJ+2Mp; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4f0NTN2hV4z1XLwWp;
	Mon, 26 Jan 2026 22:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1769466470; x=1772058471; bh=lFwO/XRKtNMnypPwC5IHo/im
	hAP9FHFENLVsrZ5m9B4=; b=MhfJ+2MpdmWxsG9J6GTCLD2+SxkUgBjQ/FGgLoEN
	oDmjTb3aWT2dT9PX5VTbuwHPyiac3RdPP9yzVmZe7R/NnDJHwkhK2v4kVq6Q2wjV
	Q7tuNtvaqreSdrwB5EPjXEqxhNa9ox+hXIY8YbqDy1R6kirh01W2xnnm75Dby/Lb
	dsnFoEX70M5W4kXD/uE7W6z61QGcor7KrE9UduyB7WhFqUr5BENY1eAeoXtMnmO9
	/UVcislAp2JorVA+FKaQPHCav9EWjl7cfU0iicCXm4XHnOLAUGzS8NrFOkMs3HZe
	fdziodFAlthmiOzaSxoSqspUMEHMlwDRJLp5gr9rTY0ypA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id URdYttsiJszn; Mon, 26 Jan 2026 22:27:50 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4f0NTK58XQz1XM5kD;
	Mon, 26 Jan 2026 22:27:49 +0000 (UTC)
Message-ID: <25f3e3af-5a38-4e86-97c4-80c8fa2a1f90@acm.org>
Date: Mon, 26 Jan 2026 14:27:48 -0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] ufs: Remove the clock gating code
To: =?UTF-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= <peter.wang@mediatek.com>,
 "mani@kernel.org" <mani@kernel.org>
Cc: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "nitin.rawat@oss.qualcomm.com" <nitin.rawat@oss.qualcomm.com>,
 "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>
References: <20260116182628.3255116-1-bvanassche@acm.org>
 <r3upegmcqg5fxo22u63dwtwrlc7qpwi57drlvujtw4jkbinx7f@xluie2klyr55>
 <cb72534c1eac0740e24eed7ca4207371f55bb273.camel@mediatek.com>
 <1ebc9a1e-c36e-4d9b-a695-a6153a32e0c0@acm.org>
 <2798fa37f745f9d91757f5097e158c61f72bc835.camel@mediatek.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <2798fa37f745f9d91757f5097e158c61f72bc835.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20566-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,acm.org:mid,acm.org:dkim]
X-Rspamd-Queue-Id: 125E18DEDC
X-Rspamd-Action: no action

On 1/25/26 7:44 PM, Peter Wang (=E7=8E=8B=E4=BF=A1=E5=8F=8B) wrote:
> This is true when it comes to power saving, but not when it comes to=20
> performance. UFS resume takes more time than simply turning the
> clock on.
Hi Peter,

It seems to me that there is insufficient consensus to proceed with the
current form of this patch series. I will look into moving the clock
gating code into the runtime suspend and resume callbacks without
affecting the behavior of the UFS driver.

Thanks,

Bart.


