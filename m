Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4B346F5002
	for <lists+linux-scsi@lfdr.de>; Wed,  3 May 2023 08:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjECGU1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 3 May 2023 02:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjECGUZ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 3 May 2023 02:20:25 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE022680
        for <linux-scsi@vger.kernel.org>; Tue,  2 May 2023 23:20:24 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-192adab8f0eso75240fac.2
        for <linux-scsi@vger.kernel.org>; Tue, 02 May 2023 23:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683094823; x=1685686823;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nHhH2clqN/moR+BtPwqo9RJEjJKqZSsX5yPmJcGuU/4=;
        b=Qm23IJ3qwDu2GYHmte3rmr/BwmR1sLshT4bpO+8HkDufXbff5NxEl1qQpfmhKnIJYI
         3Ukaw4Mz4uqK95sK6Mx5stQhQr6jUxP/g2duYrtSeToW/p/5XaBIeHn+B36zaY9XSYSK
         SPllXwfuUQZiIpV5MZN+lGiSvMvIW8h7qkuZIo2oj0xJCyJbqb/5hZFutQOdoAVRyK7w
         mPYEC9ikwEEUnzu+cn7/cpkljdi6vMXsS/IQswya2wBwBb6oVSCjcA/1VNMDLxD/IwtA
         h2Gia4mkWfvxwj79Jj4OAr1WtCfYO+neB8jUp8/hoR9KzusebxdzqaM5EKH6k24TacoM
         TaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683094823; x=1685686823;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nHhH2clqN/moR+BtPwqo9RJEjJKqZSsX5yPmJcGuU/4=;
        b=AopFifwupPxLHXItNKyILkrKhWlh5ADfUYwRF/lkt3CGugmBFsRpfjW52XExxXeF1T
         sg+m6TgG0s30K1z+eJ6TErXzH53fhbchrED2N1GMTR8R/u2yriPLHex6d1N5zqh8e71/
         Pmzo8ifo2R6kGw2pb7H85XV5Ny2EMqBqS8sEFJbJ4uIKjFEAi8cMTkZ5KBlDdTFzzOiQ
         rK3MxYdSnitEMdwZRFmYnrkdWjqlUpGCteb7OyMZ6GGs1i6fqPGbvJxizOQ7jQHFs6rq
         DmxIMYFQldd3+TJFeyTEgyBJg/pkpAZcpHA6Si7VVrT8mn7NT46rDnYp00WxSIvSP6xb
         +WGA==
X-Gm-Message-State: AC+VfDyYL5aJ1vRI/zhH0ua9Bc/ykfP+coSNgUwJMkMa6D4BRfHOSqFb
        QMRMoDBMERpng7etURTFvP9hcsFUP0IIiSsikAU=
X-Google-Smtp-Source: ACHHUZ4pi4LSU/sM9203YQp7lAK8IMxN6yS2IO19MPnb45VQmNVsDbq94Wl/y4WRXOzKEK0PX2WjGnk6MY1w9veUMHA=
X-Received: by 2002:a05:6808:4249:b0:390:5e63:8146 with SMTP id
 dp9-20020a056808424900b003905e638146mr9275448oib.42.1683094823053; Tue, 02
 May 2023 23:20:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:7516:0:b0:4bb:a83f:27ab with HTTP; Tue, 2 May 2023
 23:20:22 -0700 (PDT)
Reply-To: jennifermbaya036@gmail.com
From:   "Mrs.Jennifer Mbaya" <promiseokemini1@gmail.com>
Date:   Wed, 3 May 2023 07:20:22 +0100
Message-ID: <CA+Pj5bSgizWpYmDx9fiDRwMZEAy5b7Tvnqid=gvxRja66phjiQ@mail.gmail.com>
Subject: =?UTF-8?B?UHLDrWplbWNh?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        HK_NAME_FM_MR_MRS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:2a listed in]
        [list.dnswl.org]
        * -0.5 BAYES_05 BODY: Bayes spam probability is 1 to 5%
        *      [score: 0.0123]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [promiseokemini1[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [jennifermbaya036[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [promiseokemini1[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  1.5 HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Pr=C3=ADjemca
Dostali ste sa na ocenenie od Organiz=C3=A1cie Spojen=C3=BDch n=C3=A1rodov =
pridru=C5=BEenej k
medzin=C3=A1rodn=C3=BD menov=C3=BD fond, v ktorom bola va=C5=A1a e-mailov=
=C3=A1 adresa a fond
n=C3=A1m boli uvolnen=C3=A9 na v=C3=A1=C5=A1 prevod, preto po=C5=A1lite svo=
je =C3=BAdaje na prevod.

Dostali sme pokyn, aby sme v=C5=A1etky neuhraden=C3=A9 transakcie previedli=
 v
r=C3=A1mci nasleduj=C3=BAceho
48 hod=C3=ADn, alebo ste u=C5=BE dostali svoj fond, ak okam=C5=BEite nevyho=
viete. Pozn=C3=A1mka:
Potrebujeme va=C5=A1u naliehav=C3=BA odpoved, toto nie je jeden z t=C3=BDch
internetov=C3=BDch podvodn=C3=ADkov
tam vonku, je to =C3=BAlava od COVID-19.

Thanks
Jennifer Mbaya
