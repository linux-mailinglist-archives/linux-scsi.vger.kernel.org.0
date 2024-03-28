Return-Path: <linux-scsi+bounces-3127-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6809F876B36
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Mar 2024 20:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DE9B1F21C35
	for <lists+linux-scsi@lfdr.de>; Fri,  8 Mar 2024 19:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D8C5A7A2;
	Fri,  8 Mar 2024 19:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiTGaLQa"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8A025774;
	Fri,  8 Mar 2024 19:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709926192; cv=none; b=Uy3sjCS3iHrwsghQfGUjLYPxAa4X5GOn2ywf7NY09HslNjzGzcZryQ8/pEveYMBwcKk0HajtD65gMbDrwDJSZT8TeD+NJrDOY389vgxikmmTJlCber5rEfx7SHBxAizBucdE6tPhZIOf9kRD6vJkhZIT+iAGifdoyB9bPTPyIsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709926192; c=relaxed/simple;
	bh=RMRgdsBHJyxDqGQTUczfYvV37B+xx0l9E6N+68thdNY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WMiG96OSEVTlkpqvZQupof84iNc3O43SJsQiQtdXBU72d3rcHZtzV83iYwvWXa5jVmsXURWr4Zv/HlS0/Onhy/yZW11WQw5VF2XMzF5YInkBSqujMeUh99DV+gjAbQOiHGtXv7aK3Nox0qZTLq8AW5mWrV9GcdZa8s01kZXgWyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MiTGaLQa; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-512e4f4e463so3462218e87.1;
        Fri, 08 Mar 2024 11:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709926189; x=1710530989; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RMRgdsBHJyxDqGQTUczfYvV37B+xx0l9E6N+68thdNY=;
        b=MiTGaLQa4KrmbzMlJuO6wq8VWco0tlfoBcIffti/+5BKbgJJAF8no4woKo0nj/7jBV
         0CpgN2mltylnweWKiTWdKxZIxype3RU+922YbwZSaf46VugfrRjNWFGnO/YxuANMyQy4
         NKkZaHsriChlXRQsNu4hG5j42y/5h6l43RpVnb1efXMdPLncI1Ol0hJHmnpwsVARI/pe
         log8Dv2Jo/+PFgZaDUd5Vn+o9t8LhFeB+q8iphUMhq1Uuor0/qabiyZxAraxY8wxcfAT
         PgvxEW5wl3G4Q5EILe1AzzE/imLpXvIKIjHOB0MVC8KiXC5hmlAJPI7EZZODp9pzCYK9
         An9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709926189; x=1710530989;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RMRgdsBHJyxDqGQTUczfYvV37B+xx0l9E6N+68thdNY=;
        b=JgO2Wa9cVp//+6++TGznWQZT5w49/Z3Lor6U+v6UQf75FEGPek/dLlBuu+szKry8GS
         1Q3ii3h/ghna9z8Gbr1kS2fWG8r3KW3SlYu3WpQTl78TT4jOIW6e8lD72KgAS0XWnJ3e
         owjVSzIrLGdc1UXs7UwRpRr87X/xcFgtAwdMMWVZrNwLAXW9jf/B6y7xsOwdky15lZzF
         nXtAHRhRfhzc3wjZFv1usg32wI2zUDtyHREJHRWF/BpEb7wGvE+ehI/jd43JasNA7RaL
         8f5ZyF1dWihSr26g7LlatAyNgMMQDBAo3S8GBG6/z79+T1DbK51jR4kBoBUMgzcx/eeN
         jhNg==
X-Forwarded-Encrypted: i=1; AJvYcCVO8ki3eGoNKjoZDCOQvoKcULDNzeDQvZzPsP5bVUz6vwb+mYtuFTZTLdgFho/+xcVEFV2nhe0kx9Ztj0NNLmMByv/I/A5Qjrk7JjWrKgIln80GbWEYD0HNFYwZMXIG1z7QRqSXVcSrXA==
X-Gm-Message-State: AOJu0YxTDMU+XKekAK4bgR5bBKY9SqzB+8bZuFwDwGl39LPbR2F9JTrf
	gIN7Wx7ntRw+4EHRgHHTX9ldxUmQYPicQPlCEWlFH/n8IqVV5Y0b
X-Google-Smtp-Source: AGHT+IH17VTWtbb/T2JbzXCWcrj4STjOoGKe2CYFs7brPVKMcgV7JeYRxZlNDF7KQXU8nix1zfLaeg==
X-Received: by 2002:a19:691c:0:b0:513:2b10:cc28 with SMTP id e28-20020a19691c000000b005132b10cc28mr18935lfc.9.1709926188993;
        Fri, 08 Mar 2024 11:29:48 -0800 (PST)
Received: from p200300c58728637afaa070da676dcf95.dip0.t-ipconnect.de (p200300c58728637afaa070da676dcf95.dip0.t-ipconnect.de. [2003:c5:8728:637a:faa0:70da:676d:cf95])
        by smtp.gmail.com with ESMTPSA id ws7-20020a170907704700b00a42f6d17123sm98411ejb.46.2024.03.08.11.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 11:29:48 -0800 (PST)
Message-ID: <e96bd7b0b5b6abbde6a5e2396bc5a291e4c9ddad.camel@gmail.com>
Subject: Re: [PATCH v2 2/4] scsi: ufs: Re-use exec_dev_cmd
From: Bean Huo <huobean@gmail.com>
To: Avri Altman <Avri.Altman@wdc.com>, "James E . J . Bottomley"
 <jejb@linux.vnet.ibm.com>, "Martin K . Petersen"
 <martin.petersen@oracle.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Bean Huo <beanhuo@micron.com>, 
	"linux-scsi@vger.kernel.org"
	 <linux-scsi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Fri, 08 Mar 2024 20:29:47 +0100
In-Reply-To: <DM6PR04MB6575A5D43DF0589B480A4EA9FC202@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20240305210051.10847-1-avri.altman@wdc.com>
	 <20240305210051.10847-3-avri.altman@wdc.com>
	 <6c75ce4cc05c6983137e954043d5ae7323a96172.camel@gmail.com>
	 <DM6PR04MB6575A5D43DF0589B480A4EA9FC202@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-03-07 at 19:28 +0000, Avri Altman wrote:
> > On Tue, 2024-03-05 at 23:00 +0200, Avri Altman wrote:
> > > Move out the actual command issue from exec_dev_cmd so it can be
> > > used
> > > elsewhere.=C2=A0 While at it, remove a redundant "lrbp->cmd =3D NULL"
> > > assignment.=C2=A0 Also, as a free bonus, call the upiu trace if it
> > > doesn't.
> >=20
> >=20
> > This statement is a bit strange, what it is "if it doesn't"?
> >=20
> > from the change, the patch refactors command issue for broader
> > usage
> > and enhance UPIU tracing, isolate the command issuance logic from
> > `ufshcd_exec_dev_cmd` to allow reuse across different contexts.
> What I meant is, that I see no downside for including the bsg path in
> the upiu trace event.
> Do you object to that?

Avri,=20

no, I meant your commit message is not clearer. and then understood
after reading your patch.

Kind regards,
Bean

