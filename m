Return-Path: <linux-scsi+bounces-5871-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6218C90A8FA
	for <lists+linux-scsi@lfdr.de>; Mon, 17 Jun 2024 11:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0191D288E2A
	for <lists+linux-scsi@lfdr.de>; Mon, 17 Jun 2024 09:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BAD2190699;
	Mon, 17 Jun 2024 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="bCqx80rO"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9636919048D
	for <linux-scsi@vger.kernel.org>; Mon, 17 Jun 2024 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615067; cv=none; b=deLerX2zFw046SfMdzxgEzVw4D3wYqtLIXOe+Ea7Ipsr+ztv/i/Vn3s4qXS4VYv4zgIqs8aFKdaaixn4Gr4JZmwgn4Tb6HPocCTQOjQyp/l7AD9MJTePFrLyob0+QNXGXgKau3S2cEbG6vM4jazFlUopLq0y4z/35uVfWAAuB04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615067; c=relaxed/simple;
	bh=nB8QMBkw+Gs0pg1mPKXuIZhWT23WrRcc+RsQ7FIMqTA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LCjAOVoy8FcZJOdfRSXdc/iTHkSnFx5BcrP3gDN5/RCO8SZZnEjW4tYzBsFWYdWzWOiLANaYUww0ph/q7QWeWYmG1MPDX4LVhdb370HAkrnzHZRd/Bf03/3ndmh5whOWdTjI6/ikzmapXn9WzzKhHZW1a4+xJcisKQhKngrXTss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=bCqx80rO; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7041ed475acso3158719b3a.2
        for <linux-scsi@vger.kernel.org>; Mon, 17 Jun 2024 02:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1718615065; x=1719219865; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDNdx/ptahIqYIH0Pj0xId5ttxu/lCJrKg2rnZynRFw=;
        b=bCqx80rOQEmMk/OrLIHztKAk2yBaw3B8k8gdujZlZ0/XB9ZCncWp1/mOtP474lm45a
         ckFDNWlW83z+0ko2mVf43CIV9vr8pfQMrxCEC7ujhanK4o28x7nmrBiw7NaC00P2QPZ7
         fYIOX12Uh+nZGrhd4CHDHriM0SA7goVvj8SFx8CnxtIVNnZJSMdHMbxXki5aFdUtuxte
         neAKfzCwzQwimlwm0LMxGzJsGJsXVOW8oYvheD4wHmLgdMqMONmteW0LZt6a0FPnGJDx
         +SX7FxCW91eaL7ef82wJ9l1zNbaZVK06Dt12Du/kX/u39Zxm72sy1hCzTSHLamyRShee
         v3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718615065; x=1719219865;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDNdx/ptahIqYIH0Pj0xId5ttxu/lCJrKg2rnZynRFw=;
        b=T5pc0OYCeANt7/Ozva26QHzi3xB04RlSYwKyr8qsfcrT3TimQE/lpSLHx8y3RZ1xTk
         Ce6JGHT9qdHz1+7/JnMTzJX/3232zZfmwuHzs4YlyianjngFEBTdXcfZ9LrbrLRrh1JA
         NHgQjYE81WqIwZ3kOtk2zNpwUHMsYMCAe7WWObRBI6uPmbZpPJnMp3Wa7UWPmWe49gH3
         X77fab6TFtJmhWTIl2V6PM+nZQX6p8b+eFjn4Ay5L7XxDbFNeB/+pjbArPS2N6IlVH7r
         EH1tANMdTEosqD6LxaUQ7UUMZlgthhPRwVyzOK7xaCGqtOXZJ6LbJQk0O6SHBr11K3zT
         2ELQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc8WppwdQ5mcdso1gjEvElMrotnEtLksW6M3b3cZU5g8DFR2blMECflkvM/fzFfp+2OtMCaZ5E4f8kDOnBMDtTw3gqpyn3K3ZSZA==
X-Gm-Message-State: AOJu0YwbH/RjF0dCDS1RckVYmxtQQilOOb1ly6fZwFYtO7GlfM5+N0/g
	lhyEOladBE/V6XQmMy0JH0QdXolZIKyBxpv6GNFv5uhBazIzlpqD9lrbFUh3Z6I=
X-Google-Smtp-Source: AGHT+IEDEYvsQFAV2nhL5ZUWWemj9+e+hkrHEf7KS5m4pscR4w+OIJ9fKBbGrCAPGePwWrdXt6A7SQ==
X-Received: by 2002:a05:6a00:2d6:b0:705:f680:7571 with SMTP id d2e1a72fcca58-705f68086e0mr3754934b3a.16.1718615064616;
        Mon, 17 Jun 2024 02:04:24 -0700 (PDT)
Received: from smtpclient.apple (vps-bd302c4a.vps.ovh.ca. [2402:1f00:8000:800::34b0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb718easm7229294b3a.177.2024.06.17.02.04.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2024 02:04:24 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH] scsi: sd: Keep the discard mode stable
From: Li Feng <fengli@smartx.com>
In-Reply-To: <Zm_U_ZA96u2K6a6S@infradead.org>
Date: Mon, 17 Jun 2024 17:03:03 +0800
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <44BCFE4F-AB66-4E6A-A181-E7D93847EF98@smartx.com>
References: <20240614160350.180490-1-fengli@smartx.com>
 <Zm_U_ZA96u2K6a6S@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
X-Mailer: Apple Mail (2.3731.300.101.1.3)



> 2024=E5=B9=B46=E6=9C=8817=E6=97=A5 14:17=EF=BC=8CChristoph Hellwig =
<hch@infradead.org> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Sat, Jun 15, 2024 at 12:03:47AM +0800, Li Feng wrote:
>> + /*
>> + * When the discard mode has been set to UNMAP, it should not be set =
to
>=20
> Overly long line here.
OK.

>=20
>> + * WRITE SAME with UNMAP.
>> + */
>> + if (!sdkp->max_unmap_blocks)
>> + sd_config_discard(sdkp, SD_LBP_WS16);
>=20
> But more importantly this doesn't really scale to all the variations
> of reported / guessed at probe time vs overriden.  I think you just
> need an explicit override flag that skips the discard settings.
>=20
I think we only need to prevent the temporary change of discard mode=20
from UNMAP to WS16, and this patch should be enough.

Maybe it is a good idea to remove the call to sd_config_discard=20
from read_capacity_16 . Because the unmap_alignment/ unmap_granularity
used by sd_config_discard are assigned in sd_read_block_limits.=20

sd_read_block_limits is enough to negotiate the discard parameter.=20
It is redundant for read_capacity to modify the discard parameter.  In =
this way,=20
when the SCSI probe sends read_capacity first and then read block =
limits,=20
it avoids the change of discard from DISABLE to WS16 to UNMAP.

Thanks,
Li=

