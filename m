Return-Path: <linux-scsi+bounces-23169-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGQQNmma52kV+QEAu9opvQ
	(envelope-from <linux-scsi+bounces-23169-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 21 Apr 2026 17:40:25 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B73443CDB2
	for <lists+linux-scsi@lfdr.de>; Tue, 21 Apr 2026 17:40:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8D35E30302BE
	for <lists+linux-scsi@lfdr.de>; Tue, 21 Apr 2026 15:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262AE29ACCD;
	Tue, 21 Apr 2026 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HDHHASWi"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FFE26ED3A
	for <linux-scsi@vger.kernel.org>; Tue, 21 Apr 2026 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776785606; cv=none; b=K7JipHidwE/O5A22aolBlNsBBDE7ZR95Wp7lZesh1lcwyKsASA1ahhdpfrR7IqqprAqn3rVzV2N76rmp5EPNhIYQgxCU19KmGiQ2IUr8WdxDZVWXTQhaLZaGX9DdM6rrZ71+7wRLpKt5ppOZsnVgVd/pP2gBTGnHnBcUx4ELU1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776785606; c=relaxed/simple;
	bh=sUvygOpbWFlKSRD3KLPLrwQqxxHjtoJCC8Ayb9Wlt1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KM/IAEwoY9hd4+xyE/2+WAqHbyemMMpGEMqeJN29VbmDKEy7X84bb3XCNmC1sbbi1pk3HKo8tzNjqEjYRB8jXr7uyEZWoY4ky5T7rS6/IWD2/+75Kby9oFg2OqA5516aoR6O700W3+EPnOXE4/CRCpL4MpCf6/ZpSVrJUpSMSl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HDHHASWi; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b9c3a9fe80fso593303266b.3
        for <linux-scsi@vger.kernel.org>; Tue, 21 Apr 2026 08:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1776785603; x=1777390403; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/hHO0X3JWIBpCRWC6h+avsgn7Tyfk0d/8fddGUiTx4U=;
        b=HDHHASWiZLTJ1U4haIpYorK6w/+/snaDQnLPHMghDWaVQzIMRjfWTAyoUsLhVLxdtg
         AHoNCArwcBecJWEab1iapqZiuJbcZrSZJUtMDDJl9L0QMeckAJxRU0gV/OECk1tYIKEu
         Hjf/K8qyL0fQJkMe5erSi8+LJqMtzRevNMBfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776785603; x=1777390403;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/hHO0X3JWIBpCRWC6h+avsgn7Tyfk0d/8fddGUiTx4U=;
        b=oG7epn3wDO+vGQnE8YIg7k1yg70hkIa06a0wp7QAGPcdGXb1ovOxeY/pFmB3QzPk77
         G3yDZKQfkUgppKk3qG/UmTuZy15wfcG1qzNQDI6y/N0HURtoIgO+l3gcTpwmTMGnLKWr
         I5yX+uneKYhjlxsGyifWTHBBTspRM1N3tLL3yZmIQWxWEL1ae/+yOi4PAlrIYQ3z4A9Z
         o6K1E1M9KpLIBlEvo3LnYPmhd1VFoC+KVVtohzRDP6gGNAzGhDTgjVKrz1N3yEubryi2
         aADhVLUkyOVVLdSY2W//EI/gBKbT7L4t4CEFaX4kRQkXICqfLX3OQAXdbx3G0odqQPc7
         swvQ==
X-Forwarded-Encrypted: i=1; AFNElJ+hDeSc+lV/5UC06VBWU4jA5hXUbtn1QDJmf1jKER1awGPbFkHBQNaY/6jR0SP6QgRh5pu+lgpcQeTt@vger.kernel.org
X-Gm-Message-State: AOJu0YySpbCY0BXZ0em1y7qhMYWRMPkpHZrjLMvfz6nXwtaxPwhJKbXI
	O5R2TpS+l07QH3/qrtBaeA+//btuft8jxKO0JDaLqdGSXn7DPfuPrp8/5vnifqJS4SCr6Vacr5j
	P4eoDkxw=
X-Gm-Gg: AeBDietrlAlDiFtZxdY+84SnFYj4lZTgYs50oBa7L488pB4paUuPjmc5Zmlq639DJUL
	86x2Q7UMa5/1Zb66eSRZCNzXNI2hfAqhGzgX25QKYLC8UzTFfkfGht/B4J3zaC0ZzobKEkLDBip
	tSiLA4d6RwrGs3ux4SrGZ0cz36K3h6wUXn3zJ5hihTStThvmwCHq8U/tQe0w8NeCztbWLapCWnd
	CkZfvqUZqQJF+Eb2rA6VGED8e2GDOldbpGW+P8BoBRuSqx5Mg1lEdXQhF+Jsz4J4cCinBIh5cr4
	d10a9RMP09kcR/TFP4QpwvA2pxndf5QnCnMzH+xAgCxCTrOM+YJl2nAc5OpZCmxT2pym8yFWWtg
	5m0YRU9YcQxjIcBACpj6T7IzP/E+/4sGJRTfh2mUewNmUmEGPpj6VVAaeiwneIMrXF//ga6wIXY
	eKuT2NLKXSj8OahPAYOxZXegV1NQ1UpBwkOPtbN2KFopBKyOi8/kF8LkEjQ1OOSJ1WsbFA1s756
	uE6Fp5HPHk=
X-Received: by 2002:a17:907:709:b0:baa:7828:c581 with SMTP id a640c23a62f3a-baa7828c608mr44923766b.16.1776785603359;
        Tue, 21 Apr 2026 08:33:23 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba4512113a3sm468180566b.4.2026.04.21.08.33.22
        for <linux-scsi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 08:33:22 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ba7a1cc0380so468708866b.2
        for <linux-scsi@vger.kernel.org>; Tue, 21 Apr 2026 08:33:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ901XDxU75TX9GM4RoPret8WzWHHQ/fBPu94rPClxtGpzPE1wICpwwrgHkC/YfOKJNQajmW0biUA8ws@vger.kernel.org
X-Received: by 2002:a17:907:2d0d:b0:ba5:dfa6:1e8e with SMTP id
 a640c23a62f3a-ba5dfa624e3mr728792766b.5.1776785602649; Tue, 21 Apr 2026
 08:33:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421151345.9937-1-James.Bottomley@HansenPartnership.com> <CAHk-=wh6ujpfmEufVOW928pW6xb00_tew5+9L88LL_xyZpBpJA@mail.gmail.com>
In-Reply-To: <CAHk-=wh6ujpfmEufVOW928pW6xb00_tew5+9L88LL_xyZpBpJA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 21 Apr 2026 08:33:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgMDrpwf7kbytzW6t6c8wNo_TPJkQQXEqXzteWXNSvYOQ@mail.gmail.com>
X-Gm-Features: AQROBzAknNlAC-L0yDz-heZKbDd2Un-NJiy6UWHePgOQkubyTNouHUlkKSORm28
Message-ID: <CAHk-=wgMDrpwf7kbytzW6t6c8wNo_TPJkQQXEqXzteWXNSvYOQ@mail.gmail.com>
Subject: Re: [GIT PULL v2] SCSI updates for the 7.0+ merge window
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	TAGGED_FROM(0.00)[bounces-23169-lists,linux-scsi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-scsi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-scsi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux-foundation.org:dkim,linux-foundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5B73443CDB2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 21 Apr 2026 at 08:26, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I do note that you've used your own script forever, but it ends up
> mattering exactly for the "oh, something went wrong" kinds of
> situations [..]

The real git request-pull also ends up warning about the situation
where the remote doesn't actually contain what it is supposed to have
according to the pull request.

To be fair, while it is *supposed* to avoid the problem of forgotten
pushes, it doesn't seem to actually work all that reliably.

Because the warning message is often overlooked.

              Linus

