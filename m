Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790BA6958D5
	for <lists+linux-scsi@lfdr.de>; Tue, 14 Feb 2023 07:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBNGJ3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 14 Feb 2023 01:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjBNGJO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 14 Feb 2023 01:09:14 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323E51D901
        for <linux-scsi@vger.kernel.org>; Mon, 13 Feb 2023 22:08:59 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id w3so16461669qts.7
        for <linux-scsi@vger.kernel.org>; Mon, 13 Feb 2023 22:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xfZMVES2NNic9Jkjf3HEK2MlWoMjoBiu+bgEGDURcO0=;
        b=Dq1eOe6A2qvbORsBM0fzDh9V7Sy4doNScZ2zhhqYjoYK5sxugpq29ongwCpA2q3KLf
         H6Tqj3yU7HFb/Vq3rjRtbEo/ThiO93SKqFIYakKJ8cgT+oB5Op0Wtnp3LfczywxA4IE/
         62qR9awqkWlKZVCyYqXQ2JKOAUZ4+HyBtxozg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xfZMVES2NNic9Jkjf3HEK2MlWoMjoBiu+bgEGDURcO0=;
        b=jmH7AC0EecKUONHgmSzTLv/+9zrzHFth9KVgDrFC9y43z7DSmzxzGJHGEE6XjoYCRS
         5/0AEC/NhaX5wiJyYfw81MhBqM9bEmTiCF97rIjTXipEPYkNcS4hK1SJB1zJ1Rc5KnRY
         NQ2Ef7S4VDPqgGa5v+MU9335+YynfrJOZ/p4WbEzzyFHMCCyHvJQL/PlWJ0vtPlppNA6
         SFsFgnrjXAwHdQHzDo+reMRUsj7hWFFjMYhtJ1u1sTQ8EqFe0CPGOoRXOqKDGNomK5r/
         mT6sBfy1joccxDTM1a0KEtYJ695MKyfHVFjAvZpBh3uPhh3+IaxABh1ELBYwyYNBrIX2
         O6dw==
X-Gm-Message-State: AO0yUKXhtYveItl48SkXxoWySOKX6M2VzMhY5xWbgGHarDiXnOF/eyAq
        gLfv3XsKkgH1Gr8lHu2N/Tr1Sc0fTCVDrp63k4yKV1Y5NPEJyDOmgCigwgTkaNCYPrA/fnPmNFM
        QhIn/mW8PKFYiT4mIVOU4/xQK6IH2DscAFEQ=
X-Google-Smtp-Source: AK7set95RylQxLub6PkHdmlMXLzudxdYSsqyJTiDh9TK17Gb2e6RYaxV8m6hbf7UzGsE1jFl0CdTxg6gFOw1lJ7vV/Y=
X-Received: by 2002:ac8:5949:0:b0:3bc:f109:83be with SMTP id
 9-20020ac85949000000b003bcf10983bemr87733qtz.43.1676354936812; Mon, 13 Feb
 2023 22:08:56 -0800 (PST)
MIME-Version: 1.0
References: <20230214005019.1897251-1-shinichiro.kawasaki@wdc.com> <20230214005019.1897251-2-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20230214005019.1897251-2-shinichiro.kawasaki@wdc.com>
From:   Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Date:   Mon, 13 Feb 2023 23:08:39 -0700
Message-ID: <CAFdVvOw7-t=cXj4SzNMvwBbZKYR_HYRMBy4EGCD2Btej4D4mXA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] scsi: mpi3mr: fix issues in mpi3mr_get_all_tgt_info
To:     "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc:     linux-scsi@vger.kernel.org, mpi3mr-linuxdrv.pdl@broadcom.com,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000008e223005f4a2cc1c"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--0000000000008e223005f4a2cc1c
Content-Type: text/plain; charset="UTF-8"

On Mon, Feb 13, 2023 at 5:50 PM Shin'ichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> The function mpi3mr_get_all_tgt_info has four issues as follow.
>
> 1) It calculates valid entry length in alltgt_info assuming the header
>    part of the struct mpi3mr_device_map_info would equal to sizeof(u32).
>    The correct size is sizeof(u64).
> 2) When it calculates the valid entry length kern_entrylen, it excludes
>    one entry by subtracting 1 from num_devices.
> 3) It copies num_device by calling memcpy. Substitution is enough.
> 4) It does not specify the calculated length to sg_copy_from_buffer().
>    Instead, it specifies the payload length which is larger than the
>    alltgt_info size. It causes "BUG: KASAN: slab-out-of-bounds".
>
> Fix the issues by using the correct header size, removing the subtract
> from num_devices, replacing the memcpy with substitution and specifying
> the correct length to sg_copy_from_buffer.
>
> Fixes: f5e6d5a34376 ("scsi: mpi3mr: Add support for driver commands")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Acked-by: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>

>
> ---
>  drivers/scsi/mpi3mr/mpi3mr_app.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/scsi/mpi3mr/mpi3mr_app.c b/drivers/scsi/mpi3mr/mpi3mr_app.c
> index 9baac224b213..72054e3a26cb 100644
> --- a/drivers/scsi/mpi3mr/mpi3mr_app.c
> +++ b/drivers/scsi/mpi3mr/mpi3mr_app.c
> @@ -312,7 +312,7 @@ static long mpi3mr_get_all_tgt_info(struct mpi3mr_ioc *mrioc,
>                 num_devices++;
>         spin_unlock_irqrestore(&mrioc->tgtdev_lock, flags);
>
> -       if ((job->request_payload.payload_len == sizeof(u32)) ||
> +       if ((job->request_payload.payload_len <= sizeof(u64)) ||
>                 list_empty(&mrioc->tgtdev_list)) {
>                 sg_copy_from_buffer(job->request_payload.sg_list,
>                                     job->request_payload.sg_cnt,
> @@ -320,14 +320,14 @@ static long mpi3mr_get_all_tgt_info(struct mpi3mr_ioc *mrioc,
>                 return 0;
>         }
>
> -       kern_entrylen = (num_devices - 1) * sizeof(*devmap_info);
> -       size = sizeof(*alltgt_info) + kern_entrylen;
> +       kern_entrylen = num_devices * sizeof(*devmap_info);
> +       size = sizeof(u64) + kern_entrylen;
>         alltgt_info = kzalloc(size, GFP_KERNEL);
>         if (!alltgt_info)
>                 return -ENOMEM;
>
>         devmap_info = alltgt_info->dmi;
> -       memset((u8 *)devmap_info, 0xFF, (kern_entrylen + sizeof(*devmap_info)));
> +       memset((u8 *)devmap_info, 0xFF, kern_entrylen);
>         spin_lock_irqsave(&mrioc->tgtdev_lock, flags);
>         list_for_each_entry(tgtdev, &mrioc->tgtdev_list, list) {
>                 if (i < num_devices) {
> @@ -344,9 +344,10 @@ static long mpi3mr_get_all_tgt_info(struct mpi3mr_ioc *mrioc,
>         num_devices = i;
>         spin_unlock_irqrestore(&mrioc->tgtdev_lock, flags);
>
> -       memcpy(&alltgt_info->num_devices, &num_devices, sizeof(num_devices));
> +       alltgt_info->num_devices = num_devices;
>
> -       usr_entrylen = (job->request_payload.payload_len - sizeof(u32)) / sizeof(*devmap_info);
> +       usr_entrylen = (job->request_payload.payload_len - sizeof(u64)) /
> +               sizeof(*devmap_info);
>         usr_entrylen *= sizeof(*devmap_info);
>         min_entrylen = min(usr_entrylen, kern_entrylen);
>         if (min_entrylen && (!memcpy(&alltgt_info->dmi, devmap_info, min_entrylen))) {
> @@ -358,7 +359,7 @@ static long mpi3mr_get_all_tgt_info(struct mpi3mr_ioc *mrioc,
>
>         sg_copy_from_buffer(job->request_payload.sg_list,
>                             job->request_payload.sg_cnt,
> -                           alltgt_info, job->request_payload.payload_len);
> +                           alltgt_info, (min_entrylen + sizeof(u64)));
>         rval = 0;
>  out:
>         kfree(alltgt_info);
> --
> 2.38.1
>

-- 
This electronic communication and the information and any files transmitted 
with it, or attached to it, are confidential and are intended solely for 
the use of the individual or entity to whom it is addressed and may contain 
information that is confidential, legally privileged, protected by privacy 
laws, or otherwise restricted from disclosure to anyone else. If you are 
not the intended recipient or the person responsible for delivering the 
e-mail to the intended recipient, you are hereby notified that any use, 
copying, distributing, dissemination, forwarding, printing, or copying of 
this e-mail is strictly prohibited. If you received this e-mail in error, 
please return the e-mail to the sender, delete it from your computer, and 
destroy any printed copy of it.

--0000000000008e223005f4a2cc1c
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
MDIwAgx2rp2oPFt1hdtt8l8wDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOKwf2UI
kdRdYHQ/xZfkSTOP9oDgyeTV+LKqdxQjo5xWMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTIzMDIxNDA2MDg1N1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASow
CwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZI
hvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBQ45a+D453PlpyPfUZ9zNyz9Pv
dbUP35JIa2BFmaRLyfGRLdfmTJGdeldcdvhnKNxM+t88M65jJXc3mGR9L4tIz1odB62U2UE0i/TQ
m+QN0GVHpboVSIn1FV9xLQfMLI+ltOYz/Qtn1mzZfTtj6W9W0Sv0rw54rkQCc/LsaPBu1LGktude
zqU9NDu2VJw+m0rgoE1BEc4QRrkXd8DCC4YCWqtU8UOzmrvTC9HhDhveuzjoVAny/VtE7QEzLVPF
8A7tIhvIhNNbzbW59lgz2Qb3fwHWWqa7meosX5R8TPbgQIu9KfgOCodsYsOc0nwoE60/XJzHFNoS
W0giSp/czAUS
--0000000000008e223005f4a2cc1c--
