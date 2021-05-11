Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8737B37AE8D
	for <lists+linux-scsi@lfdr.de>; Tue, 11 May 2021 20:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbhEKSgV (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 11 May 2021 14:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbhEKSgU (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 11 May 2021 14:36:20 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781B5C061574
        for <linux-scsi@vger.kernel.org>; Tue, 11 May 2021 11:35:13 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id a2so19742753qkh.11
        for <linux-scsi@vger.kernel.org>; Tue, 11 May 2021 11:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:references:in-reply-to:mime-version:thread-index:date
         :message-id:subject:to:cc;
        bh=9sYkfV41XK4DYHYx8XL5n7fwXwYB77q+201F27M3QC8=;
        b=Isz5YMdkm6YxiSDPyU0YrExUVruAPH3ddZXmPeWSfTrBts3QZsvAErZEDHUwQwRsBF
         GfrB+TiIbOncRvZ0SIXx75FAm8TZzdQPC0pywmKnjIu67GxmyLDzhdixWlWsrHOF8u3N
         X7RRSnqdJySXR6MuRpRgr94ShGM9CQphXcSUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:references:in-reply-to:mime-version
         :thread-index:date:message-id:subject:to:cc;
        bh=9sYkfV41XK4DYHYx8XL5n7fwXwYB77q+201F27M3QC8=;
        b=QNfcKl9JiHYokSNy2dlFSCRGNU4lw7+/3LI/pfLy7JVS4D8WxqxNI9tSLn87h14xbF
         W8fhAZ7KCTkUGirK73MIff6TgeG0iJPpLh9HmRYgDZmJa7WrH9+EjXOmuUP4CLcY72US
         XAhMDlKoVEfJPOFloEpJ/f6DMw7DIxxq6bYXcUNj5WWaOl87Dn5hFYLHlSvBJ/GFPyGP
         ceR2hthxkPV/c6CtOco2V3ZtAFXyJ6A/7wwI8V3XLqSs0vbMlVvWj/YxP87ijgj9iipe
         oEgLlrfohbDgG1qeP/FvhNJ+YgOJVFmjD8gYqM6yU6YSfm12HoLTeFNycmwM65e5PA1E
         EcoA==
X-Gm-Message-State: AOAM530ZmA4FzEaIkjvi1nPISb64o/R8Di9occQnJlIN6wQ3MRLK9r4I
        EjX8N3fKLm1rhGfStwjZ5OCPjSH7PTR7tvcdMAquPA==
X-Google-Smtp-Source: ABdhPJyFXWTMYhM7hpuYPvwITtc7L2JP8YOK1C1prigCu6jJt9G+kxgYTEdaPZ0Ih4N23wiz091cn8YnkZUy79+A9os=
X-Received: by 2002:a05:620a:158c:: with SMTP id d12mr27023576qkk.127.1620758112556;
 Tue, 11 May 2021 11:35:12 -0700 (PDT)
From:   Kashyap Desai <kashyap.desai@broadcom.com>
References: <20210419110156.1786882-1-kashyap.desai@broadcom.com>
 <20210419110156.1786882-12-kashyap.desai@broadcom.com> <eef056dd-6666-a899-4e0f-a1d52563f430@suse.de>
In-Reply-To: <eef056dd-6666-a899-4e0f-a1d52563f430@suse.de>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQIA/XT3c415OaY1ygHMgGHDvdQMAAGVdBxzAtQ3gNuqZ+BRIA==
Date:   Wed, 12 May 2021 00:05:10 +0530
Message-ID: <cd9c675b6c2d07278405d074f313884b@mail.gmail.com>
Subject: RE: [PATCH v3 11/24] mpi3mr: print ioc info for debugging
To:     Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        Steve Hagan <steve.hagan@broadcom.com>,
        Peter Rivera <peter.rivera@broadcom.com>,
        mpi3mr-drvr-developers <mpi3mr-linuxdrv.pdl@broadcom.com>,
        Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000096b14b05c212273e"
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--00000000000096b14b05c212273e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(mpi3mr_protocols); i++) {
> > +		if (mrioc->facts.protocol_flags &
> > +		    mpi3mr_protocols[i].protocol) {
> > +			if (is_string_nonempty)
> > +				strcat(protocol, ",");
> > +			strcat(protocol, mpi3mr_protocols[i].name);
> > +			is_string_nonempty =3D true;
>
> Please check for string overflows here.

Hannes - This is fixed in V4. Please review V4. Planning to post V4 today.

>
> > +		}
> > +	}
> > +
> > +	is_string_nonempty =3D false;
> > +	for (i =3D 0; i < ARRAY_SIZE(mpi3mr_capabilities); i++) {
> > +		if (mrioc->facts.protocol_flags &
> > +		    mpi3mr_capabilities[i].capability) {
> > +			if (is_string_nonempty)
> > +				strcat(capabilities, ",");
> > +			strcat(capabilities, mpi3mr_capabilities[i].name);
> > +			is_string_nonempty =3D true;
>
> Same here.
>
> > +		}
> > +	}
> > +
> > +	ioc_info(mrioc, "Protocol=3D(%s), Capabilities=3D(%s)\n",
> > +	    protocol, capabilities);
> > +}
> >
> >  /**
> >   * mpi3mr_cleanup_resources - Free PCI resources @@ -2808,6 +2887,7
> > @@ int mpi3mr_init_ioc(struct mpi3mr_ioc *mrioc, u8 re_init)
> >  		}
> >
> >  	}
> > +	mpi3mr_print_ioc_info(mrioc);
> >
> >  	retval =3D mpi3mr_alloc_reply_sense_bufs(mrioc);
> >  	if (retval) {
> > diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c
> > b/drivers/scsi/mpi3mr/mpi3mr_os.c index d82581ec73e1..39928e2997ba
> > 100644
> > --- a/drivers/scsi/mpi3mr/mpi3mr_os.c
> > +++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
> > @@ -339,6 +339,7 @@ void mpi3mr_invalidate_devhandles(struct
> mpi3mr_ioc *mrioc)
> >   * mpi3mr_flush_scmd - Flush individual SCSI command
> >   * @rq: Block request
> >   * @data: Adapter instance reference
> > + * @reserved: N/A. Currently not used
> >   *
> >   * Return the SCSI command to the upper layers if it is in LLD
> >   * scope.
> >
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke		        Kernel Storage Architect
> hare@suse.de			               +49 911 74053 688
> SUSE Software Solutions Germany GmbH, 90409 N=C3=BCrnberg
> GF: F. Imend=C3=B6rffer, HRB 36809 (AG N=C3=BCrnberg)

--00000000000096b14b05c212273e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
P3lSxcw4Cg90iKHqfpwLnGNc9AGXHMxUCukpnAHRlivljilKHMx1ymb180BLmtF+ZLm6KrFLQWzB
4KeiUOMtKM13wJrQubqTeZgB1XA+89jeLYlxagVsMyksdwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRprYXNoeWFwLmRlc2FpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUkTOZp9jXE3yPj4ieKeDT
OiNyCtswDQYJKoZIhvcNAQELBQADggEBABG1KCh7cLjStywh4S37nKE1eE8KPyAxDzQCkhxYLBVj
gnnhaLmEOayEucPAsM1hCRAm/vR3RQ27lMXBGveCHaq9RZkzTjGSbzr8adOGK3CluPrasNf5StX3
GSk4HwCapA39BDUrhnc/qG5vHwLrgA1jwAvSy8e/vn4F4h+KPrPoFNd1OnCafedbuiEXTqTkn5Rk
vZ2AOTcSbxvmyKBMb/iu1vn7AAoui0d8GYCPoz8shf2iWMSUXVYJAMrtRHVJr47J5jlopF5F2ghC
MzNfx6QsmJhYiRByd8L9sUOjp/DMgkC6H93PyYpYMiBGapgNf6UMsLg/1kx5DATNwhPAJbkxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxwO04DXOeYbZtr
4mAwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIEIT6Gu4ILm3LIMKNlSs0iCwA94Z
8DqGQqg+NuE+oy3EMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIx
MDUxMTE4MzUxMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQAaouYhI096xi7S68aZkGdST3yHK631kFWD8qSLdiutwEol
ljPJ+VZfrW7E3YuRWVvlQeq0hi8gKue+cF7TFvVgM90nR9sv6KFcgQe2AT2LABKrW37+VrjckHKB
IwUpOv/9soPnTgdgNEWzEEeYPJH97B2MZ5T51dksw9D36ehCL7glKW4ERGdNhc4FHIUapjLktOtv
MPDI8SSbc/BQnCuKu55jb4wLd9+CjadsQyOYp8LhQtHTDKltUBMnSwdmGZy3LPm6wA3izvEf21yg
qc9b4cDH0OJ/Pr3ItyX7umR784HDvqE9k8WuASmj5jAf4e/cThzSqKobnbmza4EaU4CL
--00000000000096b14b05c212273e--
