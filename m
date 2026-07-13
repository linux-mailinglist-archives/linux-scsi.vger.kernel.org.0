Return-Path: <linux-scsi+bounces-26068-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pQj2FmUJVWrwjAAAu9opvQ
	(envelope-from <linux-scsi+bounces-26068-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jul 2026 17:51:01 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CE78B74D457
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jul 2026 17:51:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=purestorage.com header.s=google2022 header.b=gsEOBe+w;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-26068-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-scsi+bounces-26068-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=purestorage.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 63B38300D343
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jul 2026 15:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3612C1586;
	Mon, 13 Jul 2026 15:50:54 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5BC2BEFEE
	for <linux-scsi@vger.kernel.org>; Mon, 13 Jul 2026 15:50:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957854; cv=pass; b=ED2/pbCZKrSb45jTfa5ki3/rLkIb6KI4PlHifuVRa1FTRh6mTOL03uxQ/Sae2SynHSRJSj/eKv0wQUjuy7X2PLcq0XzyTi7mg0hdD7zrdf/sjVXei+Zy6lxiEs1y1xz0V6epfWv5W67LFsdKvTY1fHVy+Mh9/h46NoJnN4vA+4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957854; c=relaxed/simple;
	bh=3mECq0JgKQxu+65FqIfg6qBb9bwB9oI7Lmlwod5ymao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OkmdvrowkS3xDsLF+LrLnAoJ4/eHWCN9ASxweSXj7Xohk8Tl7AVQABXXSCOKOmJ/lTXmQ/p4XtcIhqrQEA0fXkTRt0ACkcMI6g5IqokOhE/E3JhMuu9FzMDpcXom0oJchz4Xo+e9pIrDfkOYsEf4ghDukzOmqHoNv3EbAoZrbjg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=gsEOBe+w; arc=pass smtp.client-ip=209.85.210.50
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e9fc323873so498571a34.0
        for <linux-scsi@vger.kernel.org>; Mon, 13 Jul 2026 08:50:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783957851; cv=none;
        d=google.com; s=arc-20260327;
        b=XrVGskZxSx5JJOYp0L7KY3ukizrQw1UWHygMoD/krVuvul06Bq9F5wLzyHITY4aouR
         dnsUCNN1bOflCLTArGoNrd+1YOR7FcEFb/WFrRFhc141c0jTBIlZzkRJbhdJ9adHhhN4
         7AhhHbV3ODso2mg036ZnbTQYt8XVSLN+qamgevcFFvgXgVkf8H3IulnvNWGuv73Ia9dA
         1kNKY9uyJWRifk00C15R+kzChnlgpoxlHmpcw68qJ14UBjeM9Js0GFHBYP31Whw0azj6
         mvnBgS0njXCoSm+VdIlROZRD9ZtTPI7bndnvgRFy5n33PznTZwgAgCNikel1pnUgZyOl
         Vomw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3mECq0JgKQxu+65FqIfg6qBb9bwB9oI7Lmlwod5ymao=;
        fh=KiZM1ZDRJQC3toeaRbDYwvAPYRv6+yQFQN6TFW0ofgY=;
        b=kEQBXffXVcsA791xIG9BNN9hBxAO+k9Hy/ACG/QIqbNlCoHzXsDXe5o76rwb+p4o0a
         smBNqn6KWCXusmMRWmucSC7A6GuqkrHxsq+msD+2f9Zp+rzswPbnMSG7LPZhDCfSVqnl
         UF9N3q3jM3Zotr6cCyyTDpSRxblcr5/2REftQFOgDwLD/1rdP/CEe3iTT1lEss5K7miJ
         GNHHUXBwklLlppgfDOf2dADSWqVKfA/zEKscR0iYc+aupmsfSuXlh8Rv1xvg/HpFeXqD
         pgxakDYi40CaaNbxzkBdtefxFcz2Nx28JrsmmULhI/nbqmiC7bYZ/zW+Sw9zvHvWIJF/
         Q0VQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1783957851; x=1784562651; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3mECq0JgKQxu+65FqIfg6qBb9bwB9oI7Lmlwod5ymao=;
        b=gsEOBe+wIyNi+N+Y3DYT3ewaeUbTGU/25iTY6t5gwTvo50Ha/Pppkph49XdFrYJ9/j
         jIIJn03KaJkTEPGJVUu4eJyLpQLoMZ9GzNknaqAxnwAidNb97l7VJlDZYEicBkYY7wm/
         8qjIZ3oM8ZbdfHr/XzyAtJRg3yjryLMaaQdsRQ0OF0LjAExZ17hXX7vbTHJDPrAslyiS
         cFzlfTyAyYqNgRevkCO5Wwx8jW8oYZ0YHAwh7ucG7Es2qWa03W8PdM406LBbEnVRWy9v
         0Pf6nIDpPfFtHXrDnazsbvgsW+RqhkyJVppRz/fA3HW7qwnX4kquonwZFL9xynJ2x/R5
         Ne0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783957851; x=1784562651;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3mECq0JgKQxu+65FqIfg6qBb9bwB9oI7Lmlwod5ymao=;
        b=I7HfFQ1ZS4XlrOSp9z0TdciRYgDrekS1IEJGAiN3p/fFgsTypU55MolhHtd7U3a/ND
         nCAcGlct/mOScOxx1NEnV2Rxi4JsDkP6taM1P8N7Ung/rOm+mJHDcrkKUAn7bYO55FH4
         dJcqoCvsGIRbpjBHbTI+/S2pF61C8hm3q5zokWRbwddOjXbZ7kCNVT5hTm+VWR1zQHbn
         1VmwvWTf+n9UldNYCNIUs1itb3TEV3getmBH0TSsgwW9cJsUYpP2Au1vRBhXaUASnOaG
         yTkN3UJvAtPKpTdcGOAClOcnpodSbVeJyS4gS2+7KchBbW+5+ZENyxPpzxk1X0tU2Zxm
         uzSA==
X-Forwarded-Encrypted: i=1; AFNElJ/sANAXP+MoNQWAZv5HmHdKUe7zltUZc3kRfMGnozcEdcxHKbcbUVD4bznyqit7tqIUW0Sv8eD6MzVr@vger.kernel.org
X-Gm-Message-State: AOJu0YzjoIeHMOyw3bBbLj1ecl4EBu7aksByfdmh5lj5ZiEOKrLbJgwr
	J9vsqol4Uvgbatqa7b0akKqBTQVr1mV6cPgrET2ZBpe1dyBlfJtgHZ16w+GVk87tzUKQqc0FkRl
	lRvHwkwCUWSyg00CZJbOCEU0y3nftH3g4ksqlO3xm1w==
X-Gm-Gg: AfdE7clxJIn/yudDbDW0RStnmwcqLy+jZJyTFX3FvTEDVJNZeEWs9E56AlLcmxTUrkT
	xwR9/dMmvD4MEJDF6SmP9wv3Dm+deTQxOkjX4rY9QAdhn7tsnWsfSMCqxiLT9GUhKeRnv6njNT6
	5nTNefE8mThg/AtDJt5+FISKv4gd3sx90Akx+DAnmL+Ubo/I8hHao2DWQuHzg1Mb/bj5Wsbo4Eh
	O1W/UFJjzz411XI7M7tQIQlXeVO/wXv5I9dy13XVXV0rOvbCKX2T580qRuiYyHyAhsIY3cfpw==
X-Received: by 2002:a05:6830:650f:b0:7e9:e702:a9d1 with SMTP id
 46e09a7af769-7ec097b58famr3955386a34.4.1783957851185; Mon, 13 Jul 2026
 08:50:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260627054220.2174166-1-csander@purestorage.com> <yq1cxwrdgmx.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1cxwrdgmx.fsf@ca-mkp.ca.oracle.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 13 Jul 2026 08:50:39 -0700
X-Gm-Features: AUfX_mwkxpGgZJY4pVFOcqA7Ferj1yZzrVgo2oA_tVNxLSUmFMmyocci83-Ncfw
Message-ID: <CADUfDZoGyu-EWxT5tN41K24oFwu8p4mmxFRsHcDpLBoAY6Y0Yw@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] block: use integrity interval instead of sector as seed
To: "Martin K. Petersen" <martin.petersen@oracle.com>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-26068-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[csander@purestorage.com,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:martin.petersen@oracle.com,m:hch@lst.de,m:axboe@kernel.dk,m:sagi@grimberg.me,m:kch@nvidia.com,m:anuj20.g@samsung.com,m:linux-block@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:linux-scsi@vger.kernel.org,m:target-devel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[purestorage.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[csander@purestorage.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CE78B74D457

On Sun, Jul 12, 2026 at 4:09=E2=80=AFPM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Caleb,
>
> > The block integrity layer currently sets the integrity seed (initial
> > reference tag) in units of 512-byte sectors.
>
> ... because that is the fundamental addressing unit in the block layer.
>
> > However, Type 1 and Type 2 ref tags are actually in units of integrity
> > intervals.
>
> They are not in units of anything until they reach their final
> protection envelope.
>
> > On devices with integrity interval size > 512 bytes, ref tags are
> > seeded incorrectly.
>
> The bip seed is whatever the caller decides it should be. The integrity
> interval size is irrelevant. As is the destination LBA.
>
> > But REQ_OP_ZONE_APPEND operations don't have their ref tags remapped,
> > so the ref tags using units of sectors will be stored to the device.
>
> Then there's a problem with how we handle REQ_OP_ZONE_APPEND. For NVMe,
> the PIREMAP flag should address this issue by remapping the written ref
> tags based on their ultimate destination LBA.

Yes, it looks like PIREMAP should allow this to work. But Christoph
reported that ref tags weren't working correctly with
REQ_OP_ZONE_APPEND:
https://lore.kernel.org/linux-block/20260624080014.1998650-3-hch@lst.de/T/#=
u

Christoph, were you testing with an NVMe ZNS device?

Thanks,
Caleb

