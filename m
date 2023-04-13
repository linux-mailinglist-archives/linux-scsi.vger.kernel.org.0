Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6551C6E08B8
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Apr 2023 10:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjDMIPs (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 13 Apr 2023 04:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjDMIPr (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 13 Apr 2023 04:15:47 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713AD902B
        for <linux-scsi@vger.kernel.org>; Thu, 13 Apr 2023 01:15:26 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id hg14-20020a17090b300e00b002471efa7a8fso797225pjb.0
        for <linux-scsi@vger.kernel.org>; Thu, 13 Apr 2023 01:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681373726; x=1683965726;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9jdV+oxR7hymkmAcO25PV9p0v0m+J7g6fYMaGnJuArE=;
        b=Er2WaIqMyZjIjpf+TH6izzg0XCUhIXP7M3Uj9gCkht3wC+J1bmcGYWSnLWJB8Du7uN
         5/kZtEccHiq7Ang1R9XdgE6sKhCNARUI7HUi7hS35SJOBRYHd0Al1wueyLelzJjhbqOB
         8RH79ycDV9dPN4Df12GEa03qfjmU2xbVJu23dX3D82rOGQvFxyWUsVkScbJtR1vIG9hJ
         kvzhCdb1iPyBhz1DWhOByNP/R1Bwv9pYV4Rn6JJFu5O5UYT95HDOjRFWvnlZnYZckLcP
         tjenyd24JL6WNH07O7O6/wa8TF4DX2/r5GtYcndtnLHkzBMHTu4xh3I4+kb3ys1lIxst
         BY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681373726; x=1683965726;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9jdV+oxR7hymkmAcO25PV9p0v0m+J7g6fYMaGnJuArE=;
        b=VOX3EjYQbAAXzUq/rPWihSiFSc0A9n2d+JE3vRRNlKePMtkID8+RP3lziHMa8mJAlU
         uJGwBpNlBVM8qMbrMBipEmqb0r99V9cyjd/5iA5KmBWkgdB1XTw1WY6mibfACFiUBvRf
         0j25Gh9EfSUi9HmnklONXxCIe4VhTWTaS3V3mUSXXHPRwOV+YdMaYJwNGpIaIA+3dOIk
         FjjJRXLDFVfOq+OC90EbBrBpLBhq0zV8fgeXknhP08qms2H4dpZoJozi6jYiN2Les4ax
         wOb+3J/nF19UKRIiGtDBHVOjN61/JzTkNemvsnUXUdpQDF/mGucdFGCuhwIJHSR1oEHy
         JGPg==
X-Gm-Message-State: AAQBX9ekm8x1nw2OmtaRojrQf9j41LHIKenfLZFvtje9oQ8uBErgLYF0
        hUfHMpOovRs21Vb/qn9Wl6eYd8EsuvoyKhJHb4A=
X-Google-Smtp-Source: AKy350bgnF5aLj4SJMSBycuBsDyU4NLTjYSGBqHRp7G1f7/1qgAG9+Fxm4oZ6vrJBVGcMebK1o4eR/nBOsP/rRh0q7I=
X-Received: by 2002:a17:90a:558f:b0:244:ae2c:d5d with SMTP id
 c15-20020a17090a558f00b00244ae2c0d5dmr265793pji.4.1681373725623; Thu, 13 Apr
 2023 01:15:25 -0700 (PDT)
MIME-Version: 1.0
Sender: rubenlorusso106@gmail.com
Received: by 2002:a05:6a10:24c7:b0:3bc:b7f6:8a30 with HTTP; Thu, 13 Apr 2023
 01:15:25 -0700 (PDT)
From:   Sophia Erick <sdltdkggl3455@gmail.com>
Date:   Thu, 13 Apr 2023 10:15:25 +0200
X-Google-Sender-Auth: jhc1WakEStWAzRq3h-hTG2h9XBQ
Message-ID: <CAGDc9RTDohNYsJN8ifir=Md_nct01LTJ=jAf1qa_4K3UPhNjXw@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.8 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
        HK_RANDOM_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

May the peace of God be with you ,

   This letter might be a surprise to you, But I believe that you will
be honest to fulfill my final wish. I bring peace and love to you. It
is by the grace of god, I had no choice than to do what is lawful and
right in the sight of God for eternal life and in the sight of man for
witness of god=E2=80=99s mercy and glory upon my life. My dear, I sent this
mail praying it will find you in a good condition, since I myself am
in a very critical health condition in which I sleep every night
without knowing if I may be alive to see the next day. I am Mrs.Sophia
Erick, a widow suffering from a long time illness. I have some funds I
inherited from my late husband, the sum of (Eleven Million Dollars) my
Doctor told me recently that I have serious sickness which is a cancer
problem. What disturbs me most is my stroke sickness. Having known my
condition, I decided to donate this fund to a good person that will
utilize it the way I am going to instruct herein. I need a very honest
and God fearing person who can claim this money and use it for Charity
works, for orphanages and gives justice and help to the poor, needy
and widows says The Lord." Jeremiah 22:15-16.and also build schools
for less privilege that will be named after my late husband if
possible and to promote the word of god and the effort that the house
of god is maintained.

 I do not want a situation where this money will be used in an ungodly
manner. That's why I'm taking this decision. I'm not afraid of death,
so I know where I'm going. I accept this decision because I do not
have any child who will inherit this money after I die. Please I want
your sincere and urgent answer to know if you will be able to execute
this project, and I will give you more information on how the fund
will be transferred to your bank account. May the grace, peace, love
and the truth in the Word of god be with you and all those that you
love and  care for.

Mrs. Sophia Erick.
