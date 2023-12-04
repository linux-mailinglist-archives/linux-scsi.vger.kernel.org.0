Return-Path: <linux-scsi+bounces-518-lists+linux-scsi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE1D804030
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Dec 2023 21:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 258391F21342
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Dec 2023 20:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95818341BE
	for <lists+linux-scsi@lfdr.de>; Mon,  4 Dec 2023 20:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IVMfsoX8"
X-Original-To: linux-scsi@vger.kernel.org
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E760D125
	for <linux-scsi@vger.kernel.org>; Mon,  4 Dec 2023 10:41:14 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c9f572c4c5so30164641fa.2
        for <linux-scsi@vger.kernel.org>; Mon, 04 Dec 2023 10:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701715273; x=1702320073; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MBOmen5BKJLJzpqKzypUh7LonInw+vuMHMvPU1qS3N4=;
        b=IVMfsoX8cUgbP8MGHNl3C9ysuQs0HuWH1NprHMaWRmqT81Ze8iQSq3f7qk1/8Pn9cN
         9+fo1WsOTGwqGcx4OAg4Spfyw7/EPqZqyFXN7Uw0Zj42CIORPNFFCQg+g3ZDZT1hgXB9
         nel46bdL9fl8NFmIUeVT526/BJ2iLHIzBSNWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701715273; x=1702320073;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MBOmen5BKJLJzpqKzypUh7LonInw+vuMHMvPU1qS3N4=;
        b=Ba65lV65uE8urSFc2SeJkTiBZfQCWM61eb33cpMeu3k/3nM05SjV9zUyvt26fnkiKY
         E/ntFj6O4hs2uQpSu5UdC2Ot3doqZCf2LYTr1BKbQ5I2ujuzdBufLKI4vwtG54XeXO1e
         BYI/559Tgm6ox1/LpoJpBp+VVIJYRWK51eQcgvEAUESezx61H0ju3NaP5n4geGTDZM8h
         Ugw2kDJF4JKr83jnV+J9gLNuecnuq2jGbKS3sM/L4K3hGd/kffQ/O3EXhTZWM8isGNWL
         dDiwIYTmD+RYsSNY/ECIocShvbqxZzX8oapfrUrEExOUkdam/58bpXT/bnTuKgqb8npD
         U96g==
X-Gm-Message-State: AOJu0YwAHsiVMJ1M/TDAhFiAq6dddVwrUsN7acMkm9vkvfs7q8IJ9D7P
	bYTxYXGsWSbJ21Td+yow2ZCgJOCJGx/abOi8mTc3br//xjXGCpU=
X-Google-Smtp-Source: AGHT+IHnrO9mNiL2x6jEDY6qDMaw2DVBtfyrqJvDYf7t4UuwKhFmGPTtiH0Eh804UEj3ntdPe9Ee+5ahOSFqaKTmUDE=
X-Received: by 2002:a2e:3019:0:b0:2c9:fc43:2b6c with SMTP id
 w25-20020a2e3019000000b002c9fc432b6cmr1318632ljw.104.1701715273132; Mon, 04
 Dec 2023 10:41:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-scsi@vger.kernel.org
List-Id: <linux-scsi.vger.kernel.org>
List-Subscribe: <mailto:linux-scsi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-scsi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129120626.4118089-1-arnd@kernel.org>
In-Reply-To: <20231129120626.4118089-1-arnd@kernel.org>
From: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Date: Mon, 4 Dec 2023 11:40:55 -0700
Message-ID: <CAFdVvOxH4UQjww4124E2ttuTgknzkHoPxVSFOQgLfoV_dkANwQ@mail.gmail.com>
Subject: Re: [PATCH] scsi: mpi3mr: reduce stack usage in mpi3mr_refresh_sas_ports()
To: Arnd Bergmann <arnd@kernel.org>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>, Sumit Saxena <sumit.saxena@broadcom.com>, 
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Ranjan Kumar <ranjan.kumar@broadcom.com>, Tomas Henzl <thenzl@redhat.com>, 
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, mpi3mr-linuxdrv.pdl@broadcom.com, 
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006293c9060bb37611"

--0000000000006293c9060bb37611
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 5:06=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Toubling the number of PHYs also doubled the stack usage of this function=
,
> exceeding the 32-bit limit of 1024 bytes:
>
> drivers/scsi/mpi3mr/mpi3mr_transport.c: In function 'mpi3mr_refresh_sas_p=
orts':
> drivers/scsi/mpi3mr/mpi3mr_transport.c:1818:1: error: the frame size of 1=
636 bytes is larger than 1024 bytes [-Werror=3Dframe-larger-than=3D]
>
> Since the sas_io_unit_pg0 structure is already allocated dynamically, use
> the same method here. The size of the allocation can be smaller based on =
the
> actual number of phys now, so use this as an upper bound.
>
> Fixes: cb5b60894602 ("scsi: mpi3mr: Increase maximum number of PHYs to 64=
 from 32")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/scsi/mpi3mr/mpi3mr_transport.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/mpi3mr/mpi3mr_transport.c b/drivers/scsi/mpi3mr=
/mpi3mr_transport.c
> index c0c8ab586957..ab04596dbdf5 100644
> --- a/drivers/scsi/mpi3mr/mpi3mr_transport.c
> +++ b/drivers/scsi/mpi3mr/mpi3mr_transport.c
> @@ -1671,7 +1671,7 @@ mpi3mr_update_mr_sas_port(struct mpi3mr_ioc *mrioc,=
 struct host_port *h_port,
>  void
>  mpi3mr_refresh_sas_ports(struct mpi3mr_ioc *mrioc)
>  {
> -       struct host_port h_port[64];
> +       struct host_port *h_port =3D NULL;
>         int i, j, found, host_port_count =3D 0, port_idx;
>         u16 sz, attached_handle, ioc_status;
>         struct mpi3_sas_io_unit_page0 *sas_io_unit_pg0 =3D NULL;
> @@ -1685,6 +1685,11 @@ mpi3mr_refresh_sas_ports(struct mpi3mr_ioc *mrioc)
>         sas_io_unit_pg0 =3D kzalloc(sz, GFP_KERNEL);
>         if (!sas_io_unit_pg0)
>                 return;
> +       h_port =3D kcalloc(mrioc->sas_hba.num_phys, sizeof(struct host_po=
rt),
> +                        GFP_KERNEL);
>> We need more than sas_hba.num_phys, so can you please use 64 instead of =
sas_hba.num_phys. Otherwise looks good.
> +       if (!h_port)
> +               goto out;
> +
>         if (mpi3mr_cfg_get_sas_io_unit_pg0(mrioc, sas_io_unit_pg0, sz)) {
>                 ioc_err(mrioc, "failure at %s:%d/%s()!\n",
>                     __FILE__, __LINE__, __func__);
> @@ -1814,6 +1819,7 @@ mpi3mr_refresh_sas_ports(struct mpi3mr_ioc *mrioc)
>                 }
>         }
>  out:
> +       kfree(h_port);
>         kfree(sas_io_unit_pg0);
>  }
>
> --
> 2.39.2
>

--0000000000006293c9060bb37611
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
v82E+npLwqC8bSHh1m6BJewfpawx72uKM9aFs6SVpLPtN6a5369OCwVeEwkk2FeFU9tZXWBnI4Wu
d1Q4a3vhOColD6PdTWv74Ez2I3ahCkmpeEQ1YMt61TUH3W8NUJJeYN2xkR6OGsA1AgMBAAGjggHc
MIIB2DAOBgNVHQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRw
Oi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MC5jcnQwQQYIKwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJz
b25hbHNpZ24yY2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZo
dHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRC
MEAwPqA8oDqGOGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3JsMCYGA1UdEQQfMB2BG3NhdGh5YS5wcmFrYXNoQGJyb2FkY29tLmNvbTATBgNVHSUE
DDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU
VyBc/F5XGkYNCP9Rb96mru8lU4AwDQYJKoZIhvcNAQELBQADggEBACiysbqj0ggjcc9uzOpBkt1Q
nGtvHhd9pbNmshJRUoNL11pQEzupSsUkDoAa6hPrOaJVobIO+yC84D4GXQc13Jk0QZQhRJJRYLwk
vdq704JPh4ULIwofTWqwsiZ1OvINzX9h9KEw/+h+Mc3YUCO7tvKBGLJTUaUhrjxyjLQdEK1Xp/8B
kYd5quZssxYPJ3nl37Moy/U9ZM2F0Ivv4U3wyP5y5cdmBUBAGOd94rH60fVDVogEo5F9gXrZhT/4
jKzCG3LclOOzLinCkK2J5GYngIUHSmnqk909QPG6jkx5RJWwkpTzm+AAVbJ9a+1F/8iR3FiDddEK
8wQJuWG84jqd/9wxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxT
aWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAy
MDIwAgx2rp2oPFt1hdtt8l8wDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIEDQYueU
XSFoQc+W0+YDVXbfI9npusQNWblKaIUkaxdrMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTIzMTIwNDE4NDExM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASow
CwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZI
hvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAK0DfeZCQ5V7Z6ro8X9Cwf3SKw
jv/UMsmwkTCcC0ce7dceqZlUFqVpRRHrn02POVxtfD3ID+smPgs/TFVa5YFnn3L6r2UO8/8IhSa7
BGawOfW6jZLpDc8UDMEof0AcwMfbPWEjCUO9c6zbcuMP4Uuymws5TwRWAAie8v3iuwxyosjyVswI
ybwzDXXRu43V+XktuQf4wovxZoDkPJGf+7Q/Nkzq85/JPuH3e10ZFeDZJWjidH1CU3H/e9cw2tI2
En9wr86MQupHgL4YCyCIUEdFgfOZf+VEgbCbduze43HH+Kg8UMOqmI2v/Vhmj/fInn5Czk+xZS5t
5k/dD7z7XbXp
--0000000000006293c9060bb37611--

