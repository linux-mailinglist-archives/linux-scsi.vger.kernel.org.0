Return-Path: <linux-scsi+bounces-24999-lists+linux-scsi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-scsi@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MTSMLwYJMWqYagUAu9opvQ
	(envelope-from <linux-scsi+bounces-24999-lists+linux-scsi=lfdr.de@vger.kernel.org>)
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 10:27:50 +0200
X-Original-To: lists+linux-scsi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FFB68D25C
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 10:27:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=iqDvHQsz;
	spf=pass (mail.lfdr.de: domain of "linux-scsi+bounces-24999-lists+linux-scsi=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-scsi+bounces-24999-lists+linux-scsi=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81627301B176
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2026 08:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F94340E8EF;
	Tue, 16 Jun 2026 08:27:49 +0000 (UTC)
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555D2413D8E
	for <linux-scsi@vger.kernel.org>; Tue, 16 Jun 2026 08:27:45 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781598469; cv=pass; b=GhhdVn7GLFQKpLRSZX1GI+r4eGuAUBKjNs1775y/hQs7E8PEuR9PaY3UgjbQeakA8vtT1P18Eyai0u9Gy4z6dRgkM0A0hKyvDbn3Fi5bU8hL+5vAmtgDlt/NdjA2WBQkMg56k5lNPWBiw9/L4EINPcBSLTaviF4erfGxCJhBEAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781598469; c=relaxed/simple;
	bh=8JifQUbXrrAMq1t9n4ZDQyXptIlhkJd5r1PPBLZL1Co=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qeUZ25Ayvd1IPByXcNnZ7a66EAafKzhYvMEH0mnwQK/bwbQLgTqICW/ha7XVo3ILftAiKGcjBk0kieye8rmKrJAkXXsdKfBaMag76H9FQ3hr7JoddDoMkxEO8ESDmRi3al25G5EufcP7sLTe1J0m+q72VBzq7sTsdHZUJ0S0ASI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iqDvHQsz; arc=pass smtp.client-ip=209.85.167.44
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aa67ddcf56so3757e87.1
        for <linux-scsi@vger.kernel.org>; Tue, 16 Jun 2026 01:27:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781598463; cv=none;
        d=google.com; s=arc-20240605;
        b=MI4/X/hVGE7/lYqCoxeGyWt0q1GqnUx3ef7lGQ41PRZefhQntdAySHNuY/4h26nauy
         LQmTeXa+g6vfnl8pufpCUP8JDhx7RQ56595BWY4Xq+7Tib9pX9Ui2uAq2RS84A9USc3G
         jVx1IgNlHG80H5FVXrx+o1XTYEajyfGmNiHwffWxB+9tJ8kS5hYEEMufYgzCaYM/94eC
         QzHqVFX2m1lWiXlpQqxvWzbUjnrXEQpqHqkgs+weDEp3an0eynrUjBOWF3NribjJIyfN
         9FHqTOlBDxZkP/F66wH4ZQ4jtkSiVVi9r4wNn8e/XCuiX2H03oyhAKsX8MXA1fWTuiSd
         Vghw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GKRTLd9j4cB5XswwDjP9t/j/lbwbXU+z4hJ9WHGCvcI=;
        fh=aF6hWWyhhEJWrI22vmLwtYp6Z1m0Gzl8owDR2sVAdl0=;
        b=hEKt1b1pVoEwT2LcxMwMJow0sL9LLRR4JxTJI3GpSXE/xDh9qxziYdnmzsEyX2ZvyZ
         oDIxa1A11PPsJTTaW2SV7WqPCSPFSMklBAAAHk+bW5a7eMNqlJQCpUxWkHofpm4fsnk1
         u8Xxq7OEVu9AHa0LtZG0A7n7xVkws2Gae7dZu01JCU0ycCau4gqfrjZGYskrVEbFR4QB
         jmFu6+m+CzuM4mFmBTru/s/SysDLcZNW6x4OyUztjf47eA7RQT1phwvaXskwXEm+2uTr
         HmH7OGHqKsHhfhHzSuL7/l3JTrEok5so4EgLEaofFtmKRYBtSliMdrhZVGz1pjr8eA+r
         ofgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781598463; x=1782203263; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKRTLd9j4cB5XswwDjP9t/j/lbwbXU+z4hJ9WHGCvcI=;
        b=iqDvHQsz+KRcEdn9ukLBkIG6q71ZCAX+2Ed0IeZyTczVjMWrYT33H2DTKwjaMeRZeZ
         v30rXnYCppeJaCofrKtYnk3qgq4x4T9/Rbo8ifijkQTJPicwDeFXa+u+rt/wJ2S/ZRk1
         u7bVP+ZWgtMy8yHTF7BNo1ZbEeu0aWe6Kc6kzz9k/3qPIgwl+52qo2RAUZ8BrtGjZsW2
         CCFw7C0OHpclcHWNve2SLE8iFVURz/5NCgBBlXlZ/QLqvauEntvd4HucaED2YXrF5hKm
         mZNk75yV/SvO65gqjEPXmXaxlGmFIjaKTZ/3qGk0d3rjQpFY5MyQfLiNJAZ7LT9jF/K6
         CnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781598463; x=1782203263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GKRTLd9j4cB5XswwDjP9t/j/lbwbXU+z4hJ9WHGCvcI=;
        b=ltt3TwWt/gp8wblQZ6fHy2Airbz70dqfm1tdEJd7a+UtxVAP0K7XJxy0H7uvbkCrji
         MuBbPXJDm/tjCaCOz2YJjuJ0QK3U0o/U5BwlRQ800Bl3GpW8Qj9CXQulCLd+0d2NBWtY
         WGhj9vcj9+9n3D/Ap4WmjgzwN2NZQJXZynjv+5sB4uZ7ji8NWmdK6WNdo7m8vrSaHSjz
         2swBUWMf08HG2CnDhIXtfzo2Q0KhvHZ9ZtOtgJwg+SEXnhHcgppJErAs9/Ovh5Zr0fHX
         ykC2z3xynAUBlq0e3YPr7LexTLVZPn2v3MVZIyCAMuRTQzBL33qWmaFi+2jT6Dwg7C6b
         Oo/Q==
X-Forwarded-Encrypted: i=1; AFNElJ8CE31bZYtz8wXyIQV7W1n3/mZil2CVQhC1HFnzL3yoF/SrUzjGUBNt6t4Hr7PEjuoyuxGcEKlUv2ik@vger.kernel.org
X-Gm-Message-State: AOJu0YymYXeykNcP9iyvofN5mZGZ3Vnasnkf2dD5LXnrrj7atpbQOsLM
	dfe3ORkHVpZVOXir5ga2v/nj9zxKouVvx6BgE4bQDyLzt6RSQcp/qQzqW6AWQ8N2xV96CevlaoC
	b5UU4gWfbUgqWPGDRyZTXnuPK3OMYHEI0siFnWvrI
X-Gm-Gg: Acq92OGLvHxFVVGiq7/KrOZpF6Vg+CVArTjJ0CczUcwMrpLSvFYvhaR0Tdx+lgk0D+D
	+jNNQ0CTzx+nFTegxv30eVNGaHr6QNXCNnr8PGRzp/bZbq9zZfGAwFtNTbFCC66T1fEM3JoFy/1
	iyKsWyqUCVL4nd6ElLPFHglxs+YGuF04TkEBXRy7kuAm7kpqDgEIpe9dsjvTR2heldWkSuttdR5
	9/QSeRIUFPAHW9DaTBoLzPPiJIK82fkzbM96Lgbh3gqI/HEjaEVRVLWAdXnAzFYxHZ+sMq7C0hD
	qp4lLA0Mpi8hCDeqr0QiyTLSMu6G5qOFqkpDPz9qnd2dhmhL
X-Received: by 2002:a05:6512:8048:10b0:5a2:9b28:d64a with SMTP id
 2adb3069b0e04-5ad43782cc6mr101111e87.8.1781598463014; Tue, 16 Jun 2026
 01:27:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260615142605.2795757-1-himanshubatra@google.com> <CAMTSyjpR455jn8pMFe43ozp1b0Jj9Vy9dKuD8LrcbMCY-cT+zA@mail.gmail.com>
In-Reply-To: <CAMTSyjpR455jn8pMFe43ozp1b0Jj9Vy9dKuD8LrcbMCY-cT+zA@mail.gmail.com>
From: Himanshu Batra <himanshubatra@google.com>
Date: Tue, 16 Jun 2026 13:57:30 +0530
X-Gm-Features: AVVi8CdhPQ_5i34nIM5msjTqKwtTvRRuxkAH8xClyhd-SFYz2UvOydZuSNPql-4
Message-ID: <CAEif7DR3KUdhPww-q_Fn6gR6L=V5nrD3EyLn3vi+hWLmS3eU6g@mail.gmail.com>
Subject: Re: [PATCH] ufs: Add HS_GEAR6 string in power_info/gear sysfs output
To: VAMSHI GAJJELA <vamshigajjela@google.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	manugautam@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24999-lists,linux-scsi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[himanshubatra@google.com,linux-scsi@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:vamshigajjela@google.com,m:alim.akhtar@samsung.com,m:avri.altman@wdc.com,m:bvanassche@acm.org,m:James.Bottomley@hansenpartnership.com,m:martin.petersen@oracle.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-serial@vger.kernel.org,m:manugautam@google.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[himanshubatra@google.com,linux-scsi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-scsi];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 78FFB68D25C

On Tue, Jun 16, 2026 at 9:52=E2=80=AFAM VAMSHI GAJJELA <vamshigajjela@googl=
e.com> wrote:
>
> scsi: ufs: sysfs: Add ....
>

Done in v2

> On Mon, Jun 15, 2026 at 7:56=E2=80=AFPM himanshubatra <himanshubatra@goog=
le.com> wrote:
> >
> > In power_info/gear sysfs, currently it supports output only till gear 5=
.
> > If operating mode is gear 6, it is giving output as "UNKNOWN".
> it outputs "UNKNOWN"

Done in v2

> > Add support for HS_GEAR6 string in sysfs output when operating mode
> > is gear 6.
> >
> > Signed-off-by: himanshubatra <himanshubatra@google.com>
> > ---
> >  drivers/ufs/core/ufs-sysfs.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/ufs/core/ufs-sysfs.c b/drivers/ufs/core/ufs-sysfs.=
c
> > index 99af3c73f1af..d1f5041fc3c8 100644
> > --- a/drivers/ufs/core/ufs-sysfs.c
> > +++ b/drivers/ufs/core/ufs-sysfs.c
> > @@ -54,6 +54,7 @@ static const char *ufs_hs_gear_to_string(enum ufs_hs_=
gear_tag gear)
> >         case UFS_HS_G3: return "HS_GEAR3";
> >         case UFS_HS_G4: return "HS_GEAR4";
> >         case UFS_HS_G5: return "HS_GEAR5";
> > +       case UFS_HS_G6: return "HS_GEAR6";
> >         default:        return "UNKNOWN";
> >         }
> >  }
> > --
> > 2.54.0.1189.g8c84645362-goog
> >

