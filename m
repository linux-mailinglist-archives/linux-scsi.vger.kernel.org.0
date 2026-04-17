Return-Path: <linux-scsi+bounces-23052-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kL6ZJoBN4mnx4QAAu9opvQ
	(envelope-from <linux-scsi+bounces-23052-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Fri, 17 Apr 2026 17:10:56 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DBC41C65C
	for <lists+linux-scsi@lfdr.de>; Fri, 17 Apr 2026 17:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D849F301077B
	for <lists+linux-scsi@lfdr.de>; Fri, 17 Apr 2026 15:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7490D3C2799;
	Fri, 17 Apr 2026 15:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="I5e94ITk"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D402238F64A
	for <linux-scsi@vger.kernel.org>; Fri, 17 Apr 2026 15:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776438650; cv=pass; b=nVHEQxeptfUSHG/9PJCKVwEs4FJdxbDXrzZWYX7YBbKBoND+H1FsFrJN297VA4iJlYzPZYYb4Y8o1PqXMT1U1Ix2+onP/Jx5dtI0fw/ZGJlHppUxcTanKXXrvHKSiPKlV8Ylc6CMM3LhYsJhAQB+IlBWilEghqtmXbT4amRXxbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776438650; c=relaxed/simple;
	bh=xFLTiMMKAFunIyu7ceKg8SWDzKCETKZieFq4JIwHgN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=urusbRKDEYZEC0Q94s4cpISyX9DaHvfyalJ7aT4wshBS5BwDX3y/BJJL3ESkK0RUz/tUAbg1bxh8SiGLy8visWT4l4+ur5FpgKztQlZrFdp3ufZJEoostbPkpRF/V+BYvLQ/oqgIGQAtJGUSGt60bR4a5ldNavB86FymuAuO3bs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=I5e94ITk; arc=pass smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-41574fa6a87so165678fac.3
        for <linux-scsi@vger.kernel.org>; Fri, 17 Apr 2026 08:10:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776438648; cv=none;
        d=google.com; s=arc-20240605;
        b=DLMzmC8Kkl4IKkfw+tNgD8gMZeEdKg9BvzUTJoO9BId7s/FOWH+AVXTLD2D/9E3Rxt
         u3oT7URDJF2XLmdFBIhnPqaUXGkKZhyVZJzOz3r1he2JVip8Oy0bfB1Mvken9E5+T7B7
         iU41K070w4aGgZk7F63smB3HoCbg6VyqAmG0EZk7+b0FyV0p1OefpNm5SDOuoOx8Er15
         Y54yjYSwhNExdvJFoPIcRG9uYK37tn919qtNgPs61titDDXee6+eFVokDpZhA6aY37W3
         NkoGXcNCG+RuLOw5QSH9QEI8HHMjJWwhVhdfdlxaKpM0N6ylfmb6zevF4SJtDlZxGEB0
         Rm6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xFLTiMMKAFunIyu7ceKg8SWDzKCETKZieFq4JIwHgN4=;
        fh=eibWm1r/UvBnE+y+cLsXIFp/W8ZQX5sJSs4zAgO/ELQ=;
        b=OL7lxST80i+dI9+qDu826YTfYaSUFv60RFPlLJXqATlxbEh1es4wKtOONPV29KI0FU
         wfwyzcZHemEB8JP3KDYWrdGO61w80yHkeCioaTzc5q2jg4yvMS8o1c0432/Z0Lb7PAAp
         a5E73XBOCCQq7EaN0xaB2dg6lmp7lguO6xSRzql5xh4eidClqYyjdWJP0m9m5odwa0PC
         vVz9ZJ9sc2VuTU8PnDRm7XxuWCvMF1Zd0sXs5lDOPHuqg8+JeFvXI3/RyGsxOXx56Q8D
         LDq4QfcrX2fKNxUx6aOlq+4HTg8XGPNeqKLqHo5jTWoES+KdD9MfQYGmQj3crbH1pIRY
         2tjg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776438648; x=1777043448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFLTiMMKAFunIyu7ceKg8SWDzKCETKZieFq4JIwHgN4=;
        b=I5e94ITkR+Rsbq/S115qpU2rTYR/eDDXeEmS5iqWvxOgurzgpA+yyiBQCLMkGRgswB
         pTbDLRPJZABeuIzYjUeXlp/3CY03MjF6Xr1qxD3TsqJI+dRwDE53mS/qVGSV9/fAB07r
         Ilq9aXE24kBk7q/iqp6WO0tys59b/4kMXV8b1MNoGVd0mZkoqGMXykJkK3JbK/4BQ2v4
         WXjmidAMNDJQ0s34JYVyR08iKNIQecaoGW+CWmJSLba4dv73wk7GvoZh5T1/zFmxmd/w
         sJpbpjQJwRcRpgSZsJzGCGzsw4iLBB6/ja6ybbuJVOH7UdYQjTQzRITL7sG7DPhN2RHG
         F0fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776438648; x=1777043448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xFLTiMMKAFunIyu7ceKg8SWDzKCETKZieFq4JIwHgN4=;
        b=euLO/4k+sBN/YTcN7bjbRpD7LJp+GRxFudtf6uxb9oK0m0nYbHqVgoFogcOSNzqDBy
         rYhlvpfcQJe8jZtSaI0pG3+m7RkoZMS602SS8QlMsOB3rlGq3fdetD3U2XY+WbSCbM6t
         dnou8kpjLPpZDDb93ebLzxS4SQeWhr4gKMPzUrYiUyFziw754CF9NxXwJl73C6BMIebx
         YU4/uTHOwYwALDcaNRAIBDTg/RCUOL0ehDzRfR0zX8z/0iNlHQfWQT0xw0Vx9gkPjt/v
         mUzM8xfUW13xJv9uCmgXqBHpvvqwv3oWi01x7CvU0i9r/kLcrrBaNTL5n22jzHasAPgr
         8M+g==
X-Forwarded-Encrypted: i=1; AFNElJ8HBEyDjXkuRHvr8iE0KfqkOyBbFK/FY2f8QATVzzZuu70TBCEE8ZqSmKTxTA7zdFW5Dflu/UQo8lzS@vger.kernel.org
X-Gm-Message-State: AOJu0YyCBTMiLvQ8KV5pGbkJpDB7teCXpL+tIsrbynejiiflMzPaZqk/
	UsRevmjjLlwhQzdLjxatzue0qYCOUasI/2PKe+aKxyPapJIytnVfNlpNWFGed0/8oiRW7Hd5Ehe
	6uBK+sXIAWPwLKVtWzvmYwvlMcg2nvYuN/qw9dbZy6Q==
X-Gm-Gg: AeBDieuV+CXgPcCADwsyfNd5IUIV4dNKBRLBhV/F+iSCufY+roN5dK4DGQ81Qs/UHRy
	0d8JNVDFekvbspbtPgNWGjhKeWoj5GulRiSrjkAaYmmp87Otwwx6qGCMEth5uf9JMOpeqA2LcZv
	d+5uyNkSfC1RWwH0vqOyLIMStqH3+jn5Z1fGKfxwqNX70/k9fz8jisMdqWfKwOIzFQMSlLy+qon
	TuFA2YfBasW8z8Fvulm1UetO8v3buD6hY3NiHZWGYFzvPwbumV6ILVQkyhuVzmpit+WARb1Sy0C
	SLt/vFFX6oJxBCVy5R6VwyO66mkJ8Q==
X-Received: by 2002:a05:6870:8888:b0:417:a04:483 with SMTP id
 586e51a60fabf-42abf22006cmr1173721fac.1.1776438647695; Fri, 17 Apr 2026
 08:10:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417015732.2692434-1-csander@purestorage.com> <yq18qams3re.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq18qams3re.fsf@ca-mkp.ca.oracle.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Fri, 17 Apr 2026 08:10:35 -0700
X-Gm-Features: AQROBzAgZnPY6pX5OSwcczY9YUvRnJkbRQ4Ptv6iv7u-Y7bsDv654h6ccq-SxOo
Message-ID: <CADUfDZrwzUTi2TOj6M-+FtBK6u5evMsWSBqRDwJsLb8yLbOGvw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] block: fix integrity offset/length conversions
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23052-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[purestorage.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[csander@purestorage.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-scsi];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,purestorage.com:dkim,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A2DBC41C65C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 8:26=E2=80=AFPM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Hi Caleb!
>
> > The block layer's integrity code currently sets the seed (initial
> > reference tag) in units of 512-byte sectors but increments it in units
> > of integrity intervals
>
> I don't necessarily agree with the premise that the seed needs to be
> expressed in any particular unit. The seed is a start value, nothing
> more.

NVM Command Set specification 1.1 section 5.3.3 requires the reference
tag to increment by 1 per logical block, so that seems to determine
the increment unit:

> If the Reference Tag Check bit of the PRCHK field is set to =E2=80=981=E2=
=80=99 and the namespace is
> formatted for Type 1 or Type 2 protection, then the controller compares t=
he Logical Block
> Reference Tag to the computed reference tag. The computed reference tag d=
epends on
> the Protection Type:
> =E2=96=AA If the namespace is formatted for Type 1 protection, the value =
of the computed
> reference tag for the first logical block of the command is the value con=
tained in
> the Initial Logical Block Reference Tag (ILBRT) or Expected Initial Logic=
al Block
> Reference Tag (EILBRT) field in the command, and the computed reference t=
ag is
> incremented for each subsequent logical block. The controller shall compl=
ete the
> command with a status of Invalid Protection Information if the ILBRT fiel=
d or the
> EILBRT field does not match the value of the least significant bits of th=
e SLBA field
> sized to the number of bits in the Logical Block Reference Tag (refer to =
section
> 5.3.1.4).
> Note: Unlike SCSI Protection Information Type 1 protection which implicit=
ly uses
> the least significant four bytes of the LBA, the controller always uses t=
he ILBRT or
> EILBRT field and requires the host to initialize the ILBRT or EILBRT fiel=
d to the
> least significant bits of the LBA sized to the number of bits in the Logi=
cal Block
> Reference Tag when Type 1 protection is used.
> =E2=96=AA If the namespace is formatted for Type 2 protection, the value =
of the computed
> reference tag for the first logical block of the command is the value con=
tained in
> the Initial Logical Block Reference Tag (ILBRT) or Expected Initial Logic=
al Block
> Reference Tag (EILBRT) field in the command, and the computed reference t=
ag is
> incremented for each subsequent logical block.

The ref tag used for a particular block needs to be consistent. And
since reftag(block N) can be computed as the reftag(M) + N - M if
block N is accessed as part of an I/O that begins at block M, the
function must be of the form reftag(block N) =3D N + c for some constant
c. Thus, the ref tag seed needs to be computed in units of logical
blocks (integrity intervals); no other unit (e.g. 512-byte sectors)
works.
To see the issue with the current approach, consider an example
accessing LBA 1 on a device with a 4 KB block size. If the block is
written as part of a write that begins at LBA 0, its ref tag in the
generated PI will be 1 (sector 0 + 1 integrity interval). If it's
later read by a read starting at LBA 1, its expected ref tag will be 8
(sector 8 + 0 integrity intervals), and the auto-integrity code will
fail the read due to a reftag mismatch. This seems completely
unworkable for a block storage device.

>
> We happen to set it to the block number in the block layer since we need
> to be able to know what to compare against on completion (for Type 1 +
> the restrictive Linux implementation of Type 2). But that does not imply
> that the seed needs to be specified in any particular unit. Submitters
> set the seed to whichever value makes sense to them (i.e. it could be
> the offset within a file as opposed to the eventual LBA on the backend

I agree, the seed doesn't need to match the final LBA, but it does
need to be in *units* of logical blocks, plus some constant offset.

> device). And then that seed is incremented by 1 for each integrity
> interval of data in the PI sent to/received from the device. The
> conversion between the submitter's view of what the first ref tag should
> be (i.e. seed) and what is required by the hardware (for instance lower
> 32 bits of device LBA) is the reason we perform remapping. The seed is
> intentionally different in the submitter's protection envelope compared
> to the device's protection envelope.
>
> Using the block layer block number as seed was just a convenience since
> that provided a predictable value for any I/O that had its PI
> autogenerated. I never intended for the actual LBA to be used as seed
> value on a 4Kn device. Initially we just used 0 as the seed. Leveraging
> the block number just added a bit of additional protection.
>
> I confess I haven't tested 4Kn in a while since things sort of converged
> on 512e. But I used to run nightly tests on a SCSI storage with 4Kn
> blocks just fine.
>
> > This looks to be a longstanding bug affecting block devices that
> > support integrity with block sizes > 512 bytes; I'm surprised it
> > wasn't noticed before.
>
> Are you seeing this with NVMe or SCSI?

With a ublk device. It should affect any block device that supports
integrity and has a logical block size > 512.

Best,
Caleb

