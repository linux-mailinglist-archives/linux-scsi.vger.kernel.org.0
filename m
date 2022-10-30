Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B037612A30
	for <lists+linux-scsi@lfdr.de>; Sun, 30 Oct 2022 11:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiJ3KmA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 30 Oct 2022 06:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJ3Kl7 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 30 Oct 2022 06:41:59 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFFB2BB
        for <linux-scsi@vger.kernel.org>; Sun, 30 Oct 2022 03:41:58 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id z24so13577146ljn.4
        for <linux-scsi@vger.kernel.org>; Sun, 30 Oct 2022 03:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6dBgz/q28xH3Bp37SdhXOjZvoWsAiKSfvAYZ3yNAsWk=;
        b=kDErJ79JhRNgdfskNaIPP5X3uFOvtGzgJ4K5Ufo/YeaFMfDoMu08tvpceI6GiYJc8I
         akPTHEuGsU6Hg6CpW+qKwjWJV7GkIfJiCYbRoFmMlU70Qk/RYXNd7THBjC1G5QhyhzFz
         rpjqzcWcEixL5e6zeiDWcpp3NZiMDfLyq5ThjZ+1aEicWr1RlCgbTsH4BNckgFn/DB4y
         j22qfdyL99ZqwWU0LNFInZjS8FfK5HBJyVOO2XQL2BbHGZEQGCHXcHky6MW02hjWIuq9
         FkFkw7QW4uQTnkRxvg0fcwlru8uxEtjHd5pBFgRUPs+abJkW+yKdcduEnwrBRUcsf2yR
         6Q4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6dBgz/q28xH3Bp37SdhXOjZvoWsAiKSfvAYZ3yNAsWk=;
        b=tdV7fu5oJ0vOvyQrmCsc0KUyAh0xeT5zX42DPr9GEc9uJ2xjnXezP7jii3rmD2Q2ey
         2SoYaEMZ6pWeBtXn8yuxDdDJFcHO4OZrF4LYjpkdV/DtThSZQDKTu7L8807OqPa/P4EY
         3ZJOubhml1vv+fHkSQsexhpw4OiV6wSC0XQUaG815umhWXcW8EsLqR2Kh9Y1MaXHBYWQ
         lIIBGEQIMC5CdCu55yUsLzJaiUOfABw5Yd+vB4W3LTO8TQgy7BiGv6BSs6/pPhldZpCZ
         3x4VVctBP0mHa8O/YPP8SmOHpWh2xhZXcBfgYQWM3iAAf9D92+EOCGp1KJJAMITq1eMT
         dy2Q==
X-Gm-Message-State: ACrzQf2nSpx+DIVXOdS3bh9SyIH0TtN8zpv5pfLmqg/ZUB9I4AFVm5dM
        iJ2RDeCsJTPYsRnS2aUy2N/iEdS/TTbwi4tTDyg=
X-Google-Smtp-Source: AMsMyM6OYMsCIBAgehZ6mYeBL42h6mtWFGBN495tAwFuQI4hlVSUg9FTNYmt3TRTE8SYZ2MCuM+bwYmA7bxKkXJkyuM=
X-Received: by 2002:a2e:94cf:0:b0:26c:5d14:6ec7 with SMTP id
 r15-20020a2e94cf000000b0026c5d146ec7mr3390826ljh.237.1667126516280; Sun, 30
 Oct 2022 03:41:56 -0700 (PDT)
MIME-Version: 1.0
Reply-To: alliommarrnbd@gmail.com
From:   Ali Omar <dianawilliams80000@gmail.com>
Date:   Sun, 30 Oct 2022 10:41:43 +0000
Message-ID: <CAOtucSvbz16=i5YqbH0rEg3cQpPogY0odojZ6tOo8K_uscEccw@mail.gmail.com>
Subject: Friede sei mit dir
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.9 required=5.0 tests=BAYES_95,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,HK_RANDOM_REPLYTO,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:230 listed in]
        [list.dnswl.org]
        *  3.0 BAYES_95 BODY: Bayes spam probability is 95 to 99%
        *      [score: 0.9761]
        *  1.0 HK_RANDOM_REPLYTO Reply-To username looks random
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [dianawilliams80000[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [dianawilliams80000[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--=20
Friede sei mit dir

Mein Name ist Ali Omar und ich bin Bankmanager hier in Dubai. Ich habe
Sie wegen Konten kontaktiert, die einem B=C3=BCrger Ihres Landes geh=C3=B6r=
en.
Dieser Mann starb vor 14 Jahren und es wird nicht erw=C3=A4hnt, wer den
Fonds erben wird. Die Bank bat mich, die Angeh=C3=B6rigen des verstorbenen
Kunden zu finden. Aber ich habe niemanden gefunden. Wenn niemand das
Guthaben beansprucht, wird das Konto eingefroren und in den
Admin-Ordner verschoben. Also beschloss ich, Ihnen die Bank
vorzustellen. Senden Sie mir eine E-Mail an meine pers=C3=B6nliche
E-Mail-Adresse, damit ich Ihnen Informationen senden und erkl=C3=A4ren
kann, wie ich Ihre Hilfe ben=C3=B6tige (alliommarrnbd@gmail.com).

Gr=C3=BC=C3=9Fe
Ali
