Return-Path: <linux-scsi+bounces-11988-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC14EA26F6E
	for <lists+linux-scsi@lfdr.de>; Tue,  4 Feb 2025 11:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A11818873AE
	for <lists+linux-scsi@lfdr.de>; Tue,  4 Feb 2025 10:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B39620B1EF;
	Tue,  4 Feb 2025 10:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="I7lYGzHv"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77225CDF1
	for <linux-scsi@vger.kernel.org>; Tue,  4 Feb 2025 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738665782; cv=none; b=idTMZg84gk/ife7+i8mqQ4gDlQSmzFxa3IKetHs3tBl+4HwGixGPicNQeJvtG/KcxodOPpqQFEBzLM/Uv/v2B6tF/9BxkrqRo6W58+Xy8Q6Y5fOt/WAa/H09pOu9Ae3vsClRLFL7QUIdxljKxuVaP6Y+Xqj4JebzR80cbwlcSsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738665782; c=relaxed/simple;
	bh=O9fK3I1pzwKP4nLc6/iAkvLdftAlb3h+THZJIPaOcUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DIJYexXUq6JShPMmPhKMwp/8iCWH2Qa+G6GAJIxcE/1bctOkmnfslFk+OgWzlvfNU/FAJJvIwMHIYimEfYhO68P8+pXok/+2/nbq3ypTh2KSlitgEiECHrgTvthlZvi1Ab7mddYSikTIKITtCcmc54ULa6SI5/HDe+I42s5eA2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=I7lYGzHv; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5401be44b58so5752064e87.0
        for <linux-scsi@vger.kernel.org>; Tue, 04 Feb 2025 02:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1738665777; x=1739270577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lE2w/bQJpX8Ezf3hOPnZ8S+RoX8BTDVVvaDLT5mRYhc=;
        b=I7lYGzHvU0BIKzXN8+MYN6s/pBGNbsu18VNl0KVMsNRP/0bQJL0KbLWpSvTLgIL6fm
         xZcumAOfZcd1ZZM1Au5prZx3JuRGG36Uddc6zNG5mX1QqVr1FbQfMafvYZXC5fUyxEN3
         06zeMYaNVxPHWmxAVm4q9Ti5UiExaSR1/CSJLFFTfAjCc0HiNWwnTRWb8U2CRzz4v9ps
         6GqUzZj4enmv9KiMdaKU8d/rIq95qB91+dXwCcx0WsdxsmlWhJQK0F0DKap/fnuPAI38
         WbvBRHTiAy1yJb6bv6MqPpjRW6NncHqUQp3wjlw8d8nxjrklqtNTkb+rNH7Y61hLQJK7
         lw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738665777; x=1739270577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lE2w/bQJpX8Ezf3hOPnZ8S+RoX8BTDVVvaDLT5mRYhc=;
        b=VHsZRFN3A7SYN56N4pBwV8GSznKHvxuD7E3Ua9AhZRzOHfOof/af0MwUtFGnVWUbBN
         Tw+3+aZa/9ggJW3vqPwVK44/R/9Z7EXeeKuQIJM+RKYs4D393wrx9ZiRHp3A9wbCsJGc
         S9EKDzqckPGH4yM9HTSvoCKaGsOBeYS6tmXhdoSj6+JpLHJGSB1xRnalmYS8g3dG4qF9
         mFotfPl3ihXW7bA/NiKqpzmQr62AFFYtFU2jkT5TfxrVWyoIe4uojpM7v+lhYEa2cRSZ
         KN00HQDuGSLAu/NXENy2+KBxVDHnZov7VWn/T8tZn00a6IPj0KlxOuCU5k17r/btZoyz
         gTuA==
X-Forwarded-Encrypted: i=1; AJvYcCXtE/d68nXeLsw8WE8h1jIw6OFXSOxB8lB3ZLa+DYqioSxGmT+28dT0GzycNuIxXk405YxWmfq6HiUn@vger.kernel.org
X-Gm-Message-State: AOJu0YyNJvJwVGFjz93ODvL/4uJd9rtOKBrA03WQ7+YSNTc6bWZHImud
	PuttJV+CAUBQo0CCAscGG4uCDj02V1AZEYgRM/BfbwcmeKBl0+6W2nrMuAMlybwig5S2T0wc2Xq
	v7Rx1JJSTHQuyZHAWAiSIXCY7ILJixGMQRHGRow==
X-Gm-Gg: ASbGncviwl3j1ySyVW2pRb163QuG1CQvC3UvIoKTZ8OLlmgXq+/vnAUFcLOK1uRvx2M
	l7sarYTYIryDb4FbvNidZH0KYTxy5twhYnpoXOQUV+7AuQRxM5NJkh2CjO+X1X2C7ks6yaIBDB1
	oVqpqnTE6NSnQJEsBRFcZVipomVqJ0
X-Google-Smtp-Source: AGHT+IE5CYBdpn6DfP3V68IEBp+LNXJHRO3XMVbiHUUscPeksGzYuA8lgJODapvJJrdvbNiLHm9bcRL2vHNots0NUJA=
X-Received: by 2002:ac2:4f85:0:b0:542:2999:399c with SMTP id
 2adb3069b0e04-543e4c3cac2mr6409529e87.46.1738665776073; Tue, 04 Feb 2025
 02:42:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204060041.409950-1-ebiggers@kernel.org>
In-Reply-To: <20250204060041.409950-1-ebiggers@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 4 Feb 2025 11:42:45 +0100
X-Gm-Features: AWEUYZnKZTyWo8D9zkwZDMqGx-d60ikbe91VkAnSO7h5ypwW4ujvIIcv_3fYFsw
Message-ID: <CAMRc=Mf-iTgUM4K1c6NpsWL+dk9BP72rJsXKf6tCKUTB=SSizA@mail.gmail.com>
Subject: Re: [PATCH v11 0/7] Support for hardware-wrapped inline encryption keys
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	Gaurav Kashyap <quic_gaurkash@quicinc.com>, linux-fscrypt@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 7:03=E2=80=AFAM Eric Biggers <ebiggers@kernel.org> w=
rote:
>
> This patchset is based on v6.14-rc1 and is also available at:
>
>     git fetch https://git.kernel.org/pub/scm/fs/fscrypt/linux.git wrapped=
-keys-v11
>
> This patchset adds support for hardware-wrapped inline encryption keys,
> a security feature supported by some SoCs.  It adds the block and
> fscrypt framework for the feature as well as support for it with UFS on
> Qualcomm SoCs.
>
> This feature is described in full detail in the included Documentation
> changes.  But to summarize, hardware-wrapped keys are inline encryption
> keys that are wrapped (encrypted) by a key internal to the hardware so
> that they can only be unwrapped (decrypted) by the hardware.  Initially
> keys are wrapped with a permanent hardware key, but during actual use
> they are re-wrapped with a per-boot ephemeral key for improved security.
> The hardware supports importing keys as well as generating keys itself.
>
> This differs from the existing support for hardware-wrapped keys in the
> kernel crypto API (also called "hardware-bound keys" in some places) in
> the same way that the crypto API differs from blk-crypto: the crypto API
> is for general crypto operations, whereas blk-crypto is for inline
> storage encryption.
>
> This feature is already being used by Android downstream for several
> years
> (https://source.android.com/docs/security/features/encryption/hw-wrapped-=
keys),
> but on other platforms userspace support will be provided via fscryptctl
> and tests via xfstests.  The tests have been merged into xfstests, and
> they pass on the SM8650 HDK with the upstream kernel plus this patchset.
>
> This is targeting 6.15.  As per the suggestion from Jens
> (https://lore.kernel.org/linux-block/c3407d1c-6c5c-42ee-b446-ccbab1643a62=
@kernel.dk/),
> I'd like patches 1-3 to be queued up into a branch that gets pulled into
> the block tree.  I'll then take patches 4-7 through the fscrypt tree,
> also for 6.15.  If I end up with too many merge conflicts by trying to
> take patches 5-7 (given that this is a cross-subsystem feature), my
> fallback plan will be to wait until 6.16 to land patches 5-7, when they
> will finally be unblocked by the block patches having landed.
>
> Changed in v11:
>   - Rebased onto v6.14-rc1.  Dropped the patches that were upstreamed in
>     6.14, and put the block patches first in the series again.
>   - Significantly cleaned up the patch "soc: qcom: ice: add HWKM support
>     to the ICE driver".  Some of the notable changes were dropping the
>     unnecessary support for HWKM v1, and replacing qcom_ice_using_hwkm()
>     with qcom_ice_get_supported_key_type().
>   - Consistently used and documented the EBADMSG error code for invalid
>     hardware-wrapped keys.
>   - Other minor cleanups.
>

Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org> # sm8650

