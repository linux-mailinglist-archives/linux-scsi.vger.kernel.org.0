Return-Path: <linux-scsi+bounces-20448-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AArmCr8kcWl8eQAAu9opvQ
	(envelope-from <linux-scsi+bounces-20448-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Wed, 21 Jan 2026 20:10:55 +0100
X-Original-To: lists+linux-scsi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF125BE19
	for <lists+linux-scsi@lfdr.de>; Wed, 21 Jan 2026 20:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D6A980EFE6
	for <lists+linux-scsi@lfdr.de>; Wed, 21 Jan 2026 17:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B95428484;
	Wed, 21 Jan 2026 17:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="sPbIBxyj"
X-Original-To: linux-scsi@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F0530B501
	for <linux-scsi@vger.kernel.org>; Wed, 21 Jan 2026 17:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769016458; cv=none; b=TKzV37b7doYhtqNlIEeYJT5YSXbbJz8DuhhMTHtlyE59Q5WQgANWIlWyziiWZ/GF9S7rD8EMuydKNFC8QQ1AwUmUKbMWYJ2ElKbQBzL7z8Pj71onqhf2JoCeX5z8Yw5WKmkecdO/Ki2YEj0CVhv1FBXEkL65snWykSynXeeXB7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769016458; c=relaxed/simple;
	bh=IBcqZcBYK1qV2my0CzndFJ9PW1LwQc/cWistZ3f0E7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I/AGM5tEOUQd8RHY7tIXnqir5zTsogCRsN6qrPZbBSzx4kfgGBpkAccNR6mjfLrY9sJV3nCUNntYSV5JbknwwE2TH44EkUbJqM6qJMgovq7lnRhFZyCYVFpJjjutQGpSlURV0rY55G5RDtLL01fFPkaz3agO8Gj9V1FucTnneMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=sPbIBxyj; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4dxB3572JjzlffvM;
	Wed, 21 Jan 2026 17:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1769016447; x=1771608448; bh=IBcqZcBYK1qV2my0CzndFJ9P
	W1LwQc/cWistZ3f0E7Q=; b=sPbIBxyjt4uDD83KO7gg1g8sNSaSUbBbkjYkcst7
	hkKHgUsYMObhmHB4UtXMK4ZWmNfJf0W1bcDCT+/pdjxwo7Ld466125diLdG76VFr
	+lk+J/ZREbFOYyTdHqGKRGq/KvN5fjbqSwtF/h/SUiD14MjZ3wVk1vr57uusgGRo
	5jtu+bOzQEyl1Tn6lc9gBKto+pNnWaXuY3KKw39TeOcrJnrgeVuyMURiTn4YvnvJ
	D+ky45mbBxwWDutAMNAA6exZD3Sb9ZPB/nSYGGbSQCrWKNQVg8pc6/p2U8usqEAg
	z9xCIP2hw9D8tHEv/pEv1RwwXN+zfqewHDARXKoeUi6bxQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 6URgXspDJZE8; Wed, 21 Jan 2026 17:27:27 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4dxB2z5FswzlfgS0;
	Wed, 21 Jan 2026 17:27:23 +0000 (UTC)
Message-ID: <617eb7b5-358e-4257-aacc-d64ed109e2a2@acm.org>
Date: Wed, 21 Jan 2026 09:27:22 -0800
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ufs: core: Use a host-wide tagset in SDB mode
To: =?UTF-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= <peter.wang@mediatek.com>,
 "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Cc: "beanhuo@micron.com" <beanhuo@micron.com>,
 "vamshigajjela@google.com" <vamshigajjela@google.com>,
 "alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>,
 "quic_cang@quicinc.com" <quic_cang@quicinc.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "chenyuan0y@gmail.com" <chenyuan0y@gmail.com>,
 "quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>,
 "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
 "ping.gao@samsung.com" <ping.gao@samsung.com>,
 "avri.altman@sandisk.com" <avri.altman@sandisk.com>,
 "mani@kernel.org" <mani@kernel.org>,
 "James.Bottomley@HansenPartnership.com"
 <James.Bottomley@HansenPartnership.com>
References: <20260116180800.3085233-1-bvanassche@acm.org>
 <a7db442bc069ffa32a3dfa5524eba0a2c6ffd28c.camel@mediatek.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <a7db442bc069ffa32a3dfa5524eba0a2c6ffd28c.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[micron.com,google.com,oracle.com,quicinc.com,vger.kernel.org,gmail.com,intel.com,samsung.com,sandisk.com,kernel.org,HansenPartnership.com];
	DMARC_POLICY_ALLOW(0.00)[acm.org,reject];
	DKIM_TRACE(0.00)[acm.org:+];
	TAGGED_FROM(0.00)[bounces-20448-lists,linux-scsi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-scsi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-scsi];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9BF125BE19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 1/20/26 11:21 PM, Peter Wang (=E7=8E=8B=E4=BF=A1=E5=8F=8B) wrote:
> On Fri, 2026-01-16 at 10:07 -0800, Bart Van Assche wrote:
>> In single-doorbell (SDB) mode there is only a single request queue.
>> Hence,
>> it doesn't matter whether or not the SCSI host tagset is configured
>> as
>> host-wide. Configure the host tagset as host-wide in SDB mode because
>> this enables a simplification of the hot path.
>=20
> Would this affect the performance of the SDB mode?

Hi Peter,

I reviewed all the blk_mq_is_shared_tags() calls in the block layer.
Based on that analysis I don't expect a measurable performance impact.

>> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
>> index 057678f4c50a..889da15a61f0 100644
>> --- a/drivers/ufs/core/ufshcd.c
>> +++ b/drivers/ufs/core/ufshcd.c
>> @@ -9320,6 +9320,7 @@ static const struct scsi_host_template
>> ufshcd_driver_template =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .max_segment_size=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 =3D PRDT_DATA_BYTE_COUNT_MAX,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .max_sectors=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D SZ_1M / SECTOR_SI=
ZE,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .max_host_blocked=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 =3D 1,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .host_tagset=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D true,
>=20
> Should be =3D 1?
.host_tagset is used as a boolean and the compiler converts 'true' into=20
'1' if used as an integer so I think 'true' is fine.

Thanks,

Bart.

