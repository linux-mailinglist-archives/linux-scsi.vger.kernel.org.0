Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C6A596644
	for <lists+linux-scsi@lfdr.de>; Wed, 17 Aug 2022 02:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237925AbiHQAQw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 16 Aug 2022 20:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235882AbiHQAQv (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 16 Aug 2022 20:16:51 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA0E77E92
        for <linux-scsi@vger.kernel.org>; Tue, 16 Aug 2022 17:16:49 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id q190so11758230vsb.7
        for <linux-scsi@vger.kernel.org>; Tue, 16 Aug 2022 17:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc;
        bh=JGVA8ow+41ufcftofk11IjTHPwqJ/qWfBP8UJLikGMI=;
        b=Uzf4E5UjSXRjUQ0OHR+jsx/JTF/hBeabgCps2qCOBamlCjPk30yIl1vBE06CzdGF+K
         N4pXduWizp8jE6acfNCA6KG+pOo+8vLoygcLosRHK5ZmRFvOrLZybr9vuO0V8kqv8P8Q
         yJogH4F5U20Xym+HUmUq+u0eUtuc4mSjJ4uMRVhibGenrVZDpwWupBt7rBjeUq+3r8zX
         3uQmhKzkJO7QuoqFMzO1rCl3QiyXOxI+baHu4V8S4GwnyMfIsf6dxu4D3FdFu9JGAkUf
         iJycbF4Vtr4SCDeJnH0xbjCQIQ3W6EJEdVKa3yGDxG5blQ2A7JgzMQWHK5+35lJDrDqX
         z+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=JGVA8ow+41ufcftofk11IjTHPwqJ/qWfBP8UJLikGMI=;
        b=4BGIH4cP0zODsuLLaQ/ib/8UshTI7NzO3UexIimbaDreZY+3MkcR58H+OpHchLci79
         Uj7UMFIqCV7BThoPGw8lxn0+Blnr1lPezTC8+KM/8WIvtrKZA7STCh79CRfFLI6mCT3c
         gHs5pJb878+JNsns3n2Ord93Nx8q1CwEcC3UHk7Ii8mWsuzxarhWcI5FLj3+7JcgfX3I
         AXv1DDTWD+54sa6KkHrC5fRVPwbjnSWQpRe5ObeK/RQiwd1mBWKtANuPy00HGY3oJZ00
         s3t8mjmLTKrhq1zWeKDxb/KWjwlmmFpiCiXwkJ2ic4ZfHDDOD7n66IJHYQBEjYOlC7F1
         3KZQ==
X-Gm-Message-State: ACgBeo0cY6tXq/4pEbBCLGPbDt/4TBIS5LL4snU/5rPaqisq4P3NB2Vt
        lA+yMAdn76rml/skor2tn9BjEl+WtkuEqaEL3fs=
X-Google-Smtp-Source: AA6agR7CPanbomMgfw7ZJykzWm0cYtGTKUvklH+YxlojSlYve4aC9lcxeoQMbCb5hztvt6izYuSTsHmEwX33S9vy+nA=
X-Received: by 2002:a67:73c6:0:b0:38a:e49f:d144 with SMTP id
 o189-20020a6773c6000000b0038ae49fd144mr3458859vsc.53.1660695408257; Tue, 16
 Aug 2022 17:16:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:9b82:0:b0:2d7:362c:4d87 with HTTP; Tue, 16 Aug 2022
 17:16:47 -0700 (PDT)
Reply-To: denismalo41@gmail.com
From:   Denis Malo <judybonville1@gmail.com>
Date:   Wed, 17 Aug 2022 00:16:47 +0000
Message-ID: <CA+h4AKozeyLi_tVuXAayTcw4a4qK2SREs1gvZU9=ShPABarPKw@mail.gmail.com>
Subject: .
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e41 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5951]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [judybonville1[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [judybonville1[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [denismalo41[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--=20
Hallo,
Bitte nehmen Sie meine Entschuldigung an. Ich m=C3=B6chte nicht in Ihre
Privatsph=C3=A4re eindringen, ich bin Denis Malo, Rechtsanwalt von Beruf.
Ich habe Ihnen eine fr=C3=BChere Mail geschrieben, aber ohne Antwort, und
in meiner ersten Mail habe ich Ihnen von meinem verstorbenen Mandanten
erz=C3=A4hlt, der den gleichen Nachnamen tr=C3=A4gt wie Sie. Seit seinem To=
d
habe ich mehrere Briefe von seiner Bank erhalten, in denen er vor
seinem Tod eine Einzahlung get=C3=A4tigt hat. Die Bank hat mich gebeten,
seine n=C3=A4chsten Angeh=C3=B6rigen oder einen seiner Verwandten anzugeben=
, die
Anspruch auf sein Geld erheben k=C3=B6nnen, oder es wird beschlagnahmt und
seitdem Ich konnte keinen seiner Verwandten ausfindig machen. Ich
beschloss, Sie wegen dieser Behauptung zu kontaktieren, daher haben
Sie denselben Nachnamen wie er. kontaktieren sie mich dringend f=C3=BCr
weitere details.
Aufrichtig,
Rechtsanwalt Denis Malo
