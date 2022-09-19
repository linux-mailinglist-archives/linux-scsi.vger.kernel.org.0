Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEE05BC4BA
	for <lists+linux-scsi@lfdr.de>; Mon, 19 Sep 2022 10:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiISIvK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 19 Sep 2022 04:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiISIuw (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 19 Sep 2022 04:50:52 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB06F3C
        for <linux-scsi@vger.kernel.org>; Mon, 19 Sep 2022 01:50:10 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id n124so13799943oih.7
        for <linux-scsi@vger.kernel.org>; Mon, 19 Sep 2022 01:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=p/GjenA4acpFzjzPTc05Im9yYS9JK9BAY77jj+IqIW8=;
        b=Gn4bC9wQK2E3VLTxNwBvdUC/83jFSpVd+dkuVhwFAQ5wOcCLxbf0i1z6FRNHkbnEVU
         6BTTnCTJQR3PnHUNgNT/110Z/k2eXCCfePTVasgEr07qTh0LJFLZcIBFgKMEJ7hVC3oo
         Y4vhAJ3jk7dHieB3OsjtFOAMKpewS/QyNrMB+ypXv685W4y6eAAWmI1ROD0O1MRvrgz/
         qGvd1W0AZyZctJ4nym5mLL3jLD/aPgNHH7OIwqUKuDMeektUbHIHa61egg/Ko+Ds7gqa
         1y62Z4XiyXiA5616n5j2G43byJjKmJHAsJfW9GqLCw9xiQw/RK0wFKOVrH6tXHMwonXP
         bwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=p/GjenA4acpFzjzPTc05Im9yYS9JK9BAY77jj+IqIW8=;
        b=6c9W85IH2LPC8FRX4y48W1B9uKkJfw7K3qEaU/5W3rCk0AtxStb9kVZwTx9/ealOoo
         wSb9bNrwy79qfRUUn9+/1t9y2vaZELXF2vDUzKCetTH0ROyldaG48EKXNCdpnsQ910oj
         Wyh0hKGbu39Ox+Ouc9AcMTL8EhJmJQEp9xXQpOJCRYwM3Oyf7GZrQdejRbQNO1yo4sN6
         G91z/xU4WgFTOq9WWIP35hmzoLRAePhRzkVjifAOo1iUEGFF9gZHQn8uy1s5gUPa8xXh
         ijf8bGr/S6Ag0nFW6uSADEiPiIrKs4duno2QOOKpXUIuYpcrWlZGwFYL/HwzOx8ByoF1
         NqEw==
X-Gm-Message-State: ACrzQf1TAZ3LHLQIZcNruJVYk34Nx3zlkpYneJ59uueLpG4BiKuUx0ib
        xcnJYGw/BdmO5H7yxd/LAMgEh6jx14PC4DRZ8p8=
X-Google-Smtp-Source: AMsMyM68J5wp4hxiFZPLI0jvRj+gpx7kZIXD2i4oJKruRFn+/AeVUX2zZkleb9UMWeRC4A65yWxQHY2XIIUz3Hoi7i0=
X-Received: by 2002:a05:6808:5d3:b0:350:2b01:f318 with SMTP id
 d19-20020a05680805d300b003502b01f318mr7020822oij.284.1663577405343; Mon, 19
 Sep 2022 01:50:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:98ea:0:0:0:0:0 with HTTP; Mon, 19 Sep 2022 01:50:05
 -0700 (PDT)
Reply-To: emile.collet@hotmail.com
From:   Emile COLLET <jujumolat1@gmail.com>
Date:   Mon, 19 Sep 2022 10:50:05 +0200
Message-ID: <CADBxk_Hpiy3uGRwe6owB93zbeZvF2JQsBT9F0Fxf0jd9jwZ+tA@mail.gmail.com>
Subject: Mes salutations,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:241 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6216]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jujumolat1[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [jujumolat1[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--=20
Mes salutations,

Je suis un employ=C3=A9 de la Soci=C3=A9t=C3=A9 G=C3=A9n=C3=A9rale Banque.
Je vous contacte au sujet de la succession des fonds d'un client
d=C3=A9c=C3=A9d=C3=A9 depuis plusieurs ann=C3=A9es.
Consultez la pi=C3=A8ce jointe pour plus de d=C3=A9tails. Si vous ne parven=
ez
pas =C3=A0 ouvrir la pi=C3=A8ce jointe, envoyez-moi un mail et je vous enve=
rrai
tous les d=C3=A9tails.
Mon adresse e-mail personnelle: emile.collet@hotmail.com

Amicalement,
Mr. Emile COLLET
