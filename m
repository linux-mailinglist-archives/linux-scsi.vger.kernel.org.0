Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47EE4FE787
	for <lists+linux-scsi@lfdr.de>; Tue, 12 Apr 2022 19:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347679AbiDLSAv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 12 Apr 2022 14:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244075AbiDLSAu (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 12 Apr 2022 14:00:50 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9965B5A167
        for <linux-scsi@vger.kernel.org>; Tue, 12 Apr 2022 10:58:31 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id i27so38872359ejd.9
        for <linux-scsi@vger.kernel.org>; Tue, 12 Apr 2022 10:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mmL4vs8ftWX+CyNMXa1yb01w8x8Mfk+3syxw44HPFDk=;
        b=IAn9f/81JWmI7zAmW95gFJ7SC9HG4dQArs9KMToO3oj6e7DkPWIg/Jbek1+1unhTkq
         Sa8bU7aiSOYZ8I1xGP11S7fZNCi0KJLFiC23OmfWNQbwurwSsltKnql5XinEVEQMXra1
         c+dsJ6xa4PqEY+kDitFFjZ3eQtxaZLtcx4KnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mmL4vs8ftWX+CyNMXa1yb01w8x8Mfk+3syxw44HPFDk=;
        b=dmHrN5tWPhTIpnktfDMOoT2Uud4B021KN2s6BksVkxcjUQLLb0xTPM72cqLmeJ3psh
         VjsYJUxWoKDAqH8ZUWxE02n6XMYxIHYvOHH6cOGz5ng8l5EUZcnt/039C0f3sG2fWzsG
         HjDSuhPVo4mfbzkG0GZLtkOMAFLsmjJYKqR2NXcWPMwjZfe7izneQTC2hZ25XJrC15Ur
         qTRB1NKifTClg5y+2v3MiAMp+wbBQ3WtRJyyhYwURnBA/bnaboQO/7HyfQ+axnzn89cs
         wZkVh0Cj7auSmubTeR3rYGHJoovMl8tcjz2XMauGFsyctddeKpDdSk64ZFfLtlfuVN1d
         Ex2Q==
X-Gm-Message-State: AOAM533QgvtpK4X46INDhp2c2VMy+9k9G9ni1EBr+2paNT6TgZ83ERR3
        HEDrCmpp6FNvAWdaryZYDJgnJZ98Vd85in9CHw9LgOQqvBM3lSQscAZwT454GTR2APr5iYQXHpv
        sL916vv/1sHnItPeMLjfi9VmRX9A=
X-Google-Smtp-Source: ABdhPJyhNJo6CZgtb2oVqRdxL6W93DjAkmgh+YNhODAi9NSDqrqRc21OEqreBHnW4uvIfzh1y0tHiZuFB54FgmxXu8o=
X-Received: by 2002:a17:906:eb42:b0:6e8:9197:f0e0 with SMTP id
 mc2-20020a170906eb4200b006e89197f0e0mr10583318ejb.550.1649786310059; Tue, 12
 Apr 2022 10:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220409134926.331728-1-zheyuma97@gmail.com>
In-Reply-To: <20220409134926.331728-1-zheyuma97@gmail.com>
From:   Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>
Date:   Tue, 12 Apr 2022 11:58:12 -0600
Message-ID: <CAFdVvOzx7t99Btf4Jv5+5=6es0i8AKx_1Bwj5gQd-Oqnqi+tPA@mail.gmail.com>
Subject: Re: [PATCH] scsi: mpi3mr: Fix an error code when probing the driver
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        jejb@linux.ibm.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        mpi3mr-drvr-developers <mpi3mr-linuxdrv.pdl@broadcom.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000fbc3b805dc78ce88"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--000000000000fbc3b805dc78ce88
Content-Type: text/plain; charset="UTF-8"

On Sat, Apr 9, 2022 at 7:49 AM Zheyu Ma <zheyuma97@gmail.com> wrote:
>
> During the process of driver probing, probe function should return < 0
> for failure, otherwise kernel will treat value >= 0 as success.
>
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
>  drivers/scsi/mpi3mr/mpi3mr_os.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/mpi3mr/mpi3mr_os.c b/drivers/scsi/mpi3mr/mpi3mr_os.c
> index f7cd70a15ea6..240bfdf9788b 100644
> --- a/drivers/scsi/mpi3mr/mpi3mr_os.c
> +++ b/drivers/scsi/mpi3mr/mpi3mr_os.c
> @@ -4222,9 +4222,10 @@ mpi3mr_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>         struct Scsi_Host *shost = NULL;
>         int retval = 0, i;
>
> -       if (osintfc_mrioc_security_status(pdev)) {
> +       retval = osintfc_mrioc_security_status(pdev);
> +       if (retval) {
>                 warn_non_secure_ctlr = 1;
> -               return 1; /* For Invalid and Tampered device */
> +               return retval; /* For Invalid and Tampered device */
>         }
NAK. The driver has to return 1 when invalid/tampered controllers are
detected just to say the controller is held by the mpi3mr driver
without any actual operation.
>
>         shost = scsi_host_alloc(&mpi3mr_driver_template,
> --
> 2.25.1
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

--000000000000fbc3b805dc78ce88
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
AYPMVSim4+pTItuq9IB5a3B4lXktI8GoZ4icvNq/tDUC+UQBkiyx41thyEA3MCL+kgpIDnw1yNbe
DuhEcmBxC3E4cziK/swLRngmgXt+5vyInAJZt7HlQxtmx5IEZ4mXQ9lv/ZbRm6xdAgMBAAGjggHc
MIIB2DAOBgNVHQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRw
Oi8vc2VjdXJlLmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MC5jcnQwQQYIKwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJz
b25hbHNpZ24yY2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZo
dHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRC
MEAwPqA8oDqGOGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3JsMCYGA1UdEQQfMB2BG3NhdGh5YS5wcmFrYXNoQGJyb2FkY29tLmNvbTATBgNVHSUE
DDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU
pgsVbwKDpO1jbwtH74jMrhpldKgwDQYJKoZIhvcNAQELBQADggEBAAs3g9+OH401HDPcsiK943D1
29CLPOuPWwMLezDdRvDcSqXw/gHia/3hEqnSZiSNEHi7WJ+bhd7c/kLupVhlae5tQwGMchue4U6R
/3Ck8BQ5wivGrL3n0hksKHrXs+pPI96sat0kZCX/OVLJ6KfZoNBnl4lgXkgjfrWs/2U+gcMU2lmw
zhujPHSNF2UIyRNtvcw0NozAtiov/KGLHocfrD39IAsX9SpKaqH6W0lFtOeevTeAg7Y0yXo7HXKY
t+RqMzkDTXFXS6MXhqwXQHf6laWJkR9smRePlZ7BHSurIjHbpKhVaYCd6aKI4gUlq2t/zr+ct4Ls
WZg6a7glbWLB4YExggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxT
aWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAy
MDIwAgx1ZyicYAvHT9A0GRQwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIFAnjN8Y
svRthHfEnLcTMjtEMxcBug6YUWsC141KwMSPMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTIyMDQxMjE3NTgzMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASow
CwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZI
hvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCpJczeK0ESOHBwA/0eeBZTWZpd
gPyaTAErpjLcmDIO8clLWQKVwz8Rk9AC3kAuj9XV5viiD+xAL2E2L654pIBZKMrMXa3TLdGWG2CQ
Ba87SmO0nGGK6dBt6Dfg6kmlbBjf/Te1nfDm/6ECbikUvitOmeIVQejpgLPzqwadD4ZBOEoOyPbi
LZMk3fwyczBgP8ktaXiwac89gJrMmBLVaChedY9NoUCU5b6XpjD6QmId80qSMZWr3RKr3YcCJU+Y
iJwOEmhK0K/msUTiaoGH/jwH0pCytTZtAuYGnCcbMZGZrfY3mAro7hVFC8bpDZr2GB3ce8UeUAxI
q8kl+LAwp/Fn
--000000000000fbc3b805dc78ce88--
