Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB0F50DE90
	for <lists+linux-scsi@lfdr.de>; Mon, 25 Apr 2022 13:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbiDYLQi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 25 Apr 2022 07:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbiDYLQe (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 25 Apr 2022 07:16:34 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB43431DD0
        for <linux-scsi@vger.kernel.org>; Mon, 25 Apr 2022 04:13:30 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id t13so13123924pgn.8
        for <linux-scsi@vger.kernel.org>; Mon, 25 Apr 2022 04:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=mmd4qjxvG29M6kC9w1keSuqoCPTvZCriqLVPrV/8mEU=;
        b=lcmR3PyWthtOrhwlYBJMEDC6l2FtnmW2yxcUNu9dA0CvMJRzABonpDVahcWwSGV6+4
         5fphstfVBc6q1TZHniUnWwk5vZrUIu/bZyXS0fJWRYDnOw6lKZhY9jGH8k3NJlcdhizm
         OmbK1Pqh+0xrz/iGAPvJxZXzdzKa//9X8zf5H+qiPLBChdkHoH6o6+NL2jxgww8bJ5tz
         hf6NTesi7GxOc/vAwoNKQRJNz52c+Y1uBjwQ9Un1ZXLX4Yhi2coxzdly9azYzYOMtHWR
         JBAhzkBiBdjnRkUHNxo4rXGa9zIpjSr+BwZ8gkzs81D3aMepcLorDJYE+fNr+z+bbh6D
         vLMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=mmd4qjxvG29M6kC9w1keSuqoCPTvZCriqLVPrV/8mEU=;
        b=wcjZBBYU1Um28zD+AAPpGIU6tso4j4Bp6AvuliuD/yOP08F2osGZSN977+wRmKNGHI
         0qqrVBvMV83Hh2IzBCuJIAEt9g9djxJhBgTcqh1X8eMVTKYzKusXUq5EFBARx34Us0fK
         ywFr1Brh+FoUichlDJi9D3UvfzRMTzxHGMifISo33JFzCcasUGQMdzz0nqGOa//bXGDr
         ql0IUzk6ENQ+iAhAb54jISTi4afbwmIRnadT+bRR7+ccdNlreAsJ4aY++zT5Hp/HjsNh
         xATmgqanG0KhzvmIUUyj6AooMXNJQLSRfEfLLeRU7K3UjQhIz2Szr0KbmAqvMZEZDizW
         312g==
X-Gm-Message-State: AOAM533JFWTjkb1F0Mu8vrIbNRgZ1drQZ6HilFLm24RuQc98EEETjZo5
        5/2QUWzxU9hqo/Et15QUuEs1x+H0lalUT42tOMU=
X-Google-Smtp-Source: ABdhPJyGplvIeGICbQiAmJMTW0G228vud3m4TZb1f/U4U3mZNXtJUPNU/yMU29Hhq4dG7NmjOIJKOi3pu378IfQK+5I=
X-Received: by 2002:a05:6a00:23d2:b0:4fa:f262:719 with SMTP id
 g18-20020a056a0023d200b004faf2620719mr18428192pfc.4.1650885210486; Mon, 25
 Apr 2022 04:13:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:1252:0:0:0:0 with HTTP; Mon, 25 Apr 2022 04:13:29
 -0700 (PDT)
Reply-To: gb528796@gmail.com
From:   george brown <eddywilliam0002@gmail.com>
Date:   Mon, 25 Apr 2022 13:13:29 +0200
Message-ID: <CAP8JzxLUrzr1xg41D5CdJmRGBwO=KEN4T_RV+iz0QzUAtU64Rg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.9 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,REPTO_419_FRAUD_GM,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:52b listed in]
        [list.dnswl.org]
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3208]
        *  3.0 REPTO_419_FRAUD_GM Reply-To is known advance fee fraud
        *      collector mailbox
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [eddywilliam0002[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [gb528796[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [eddywilliam0002[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Ahoj

Jmenuji se George Brown, povol=C3=A1n=C3=ADm jsem pr=C3=A1vn=C3=ADk. Chci v=
=C3=A1m nab=C3=ADdnout
nejbli=C5=BE=C5=A1=C3=AD p=C5=99=C3=ADbuzn=C3=BD m=C3=A9ho klienta. Zd=C4=
=9Bd=C3=ADte =C4=8D=C3=A1stku (8,5 milionu $)
dolar=C5=AF, kter=C3=A9 m=C5=AFj klient nechal v bance p=C5=99ed svou smrt=
=C3=AD.

M=C5=AFj klient je ob=C4=8Dan va=C5=A1=C3=AD zem=C4=9B, kter=C3=BD zem=C5=
=99el p=C5=99i autonehod=C4=9B se svou =C5=BEenou
a jedin=C3=BD syn. Budu m=C3=ADt n=C3=A1rok na 50 % z celkov=C3=A9ho fondu,=
 zat=C3=ADmco 50 % ano
b=C3=BDt pro tebe.
Pro v=C3=ADce informac=C3=AD pros=C3=ADm kontaktujte m=C5=AFj soukrom=C3=BD=
 e-mail zde:gb528796@gmail.com

P=C5=99edem d=C4=9Bkuji,
pane George Brown,
