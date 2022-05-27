Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA653535E52
	for <lists+linux-scsi@lfdr.de>; Fri, 27 May 2022 12:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350986AbiE0Ka4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 27 May 2022 06:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237635AbiE0Kax (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 27 May 2022 06:30:53 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E92129EFC
        for <linux-scsi@vger.kernel.org>; Fri, 27 May 2022 03:30:52 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id x137so7192858ybg.5
        for <linux-scsi@vger.kernel.org>; Fri, 27 May 2022 03:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=gMRL2ChFV1c1fJH6+lzMvi+AnpLvf8Jv1voAqTadcaU=;
        b=A4niVho5VDja4oggBTHYDBpSXs/UU9FUrj/W5Ex5x0gO33pX55qJjyD94+CyTXpNjt
         ZIvKeAm2NQdlpLpoMptA733lJbEme/LpV+SxhZBwTTs9K7lKmO9rnWqK2+1QFTVqthgi
         BaTkxWSGAYlT8Ufj3NUnO4qsXbP/bDTaLvW8BR1CSqle8MLiNWlHZjNsXsTCvaBQ597u
         XvSkVQwAj2DPYSX3ElShzIGf6zXFevAHffZBa6ACHcK1aeKAZxSvmACdEHNa/pJ2mer/
         mL1jNyxi1X0ngTFM1WYOke0KkyPHJSKBYSJoNOmCeZEzCPYEwrrUJ842shz8PB/K/Uh9
         BTvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=gMRL2ChFV1c1fJH6+lzMvi+AnpLvf8Jv1voAqTadcaU=;
        b=oJmBSnKrAiwRBoLs3wYucdIKQrhKzy/kLF9as/bACGT5bFMzfEdIJPYYVtAk7p6WEr
         6io/7eq9Mfme/eXpshxV4JJRzhy7AHWwuMrWCPCeP/xx6G7h7Y34ZAeP0hjx9KhP24Pc
         xSQ2AW4N7uyd1B5VDw7LRXdn1qpTP+OdyU4Gr7mjl/Jb0+g9ypvPyyple0RLBBnj3rud
         MRa9ghfChgVmMOpKJXxcz3VLPeX/yX45Edp6ZlD2G/g/ZfqVGW4+VAlGpwlYBapdipFQ
         tEHin4wPLtk8fqo22RJgxYzEP/QsCO8eWLXtXlbg5seWXhQsdlsIj4eGXpkoM3md11GJ
         2Isw==
X-Gm-Message-State: AOAM530fTkDXpIgFiFHLwuTpGkdTK5xj4XmyK9Vj/OENDUfIWjuZ70Lt
        zU+2oNDyv3+nDUKEDVgW0pYbnIvW48a/GlXMusg=
X-Google-Smtp-Source: ABdhPJyK0an4l1OR+LbV9VWFw2gsmfR9uPk5PxYqWh96KFOwvug1R/FSn3N4sYn8pyy6DQvnnUOzA8ukDxGxSxwuj1I=
X-Received: by 2002:a25:6645:0:b0:659:10b9:2281 with SMTP id
 z5-20020a256645000000b0065910b92281mr4180551ybm.249.1653647451603; Fri, 27
 May 2022 03:30:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6902:114d:0:0:0:0 with HTTP; Fri, 27 May 2022 03:30:51
 -0700 (PDT)
Reply-To: donaldcurtis3000@gmail.com
From:   Donald Curtis <91474711amele@gmail.com>
Date:   Fri, 27 May 2022 11:30:51 +0100
Message-ID: <CAC=gNW2QuJTu3yu1WMD4VKLiRaJUrgCUQrcMeso_iORE9hqdiw@mail.gmail.com>
Subject: Donald
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b32 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5019]
        *  0.7 FROM_STARTS_WITH_NUMS From: starts with several numbers
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [91474711amele[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [donaldcurtis3000[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hello,
I called to know if you received my previous email, reply to me asap.
Donald

Hallo,
Ich habe angerufen, um zu wissen, ob Sie meine vorherige E-Mail
erhalten haben. Antworten Sie mir so schnell wie m=C3=B6glich.
Donald
