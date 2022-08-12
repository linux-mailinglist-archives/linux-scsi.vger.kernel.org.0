Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44113590BEE
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Aug 2022 08:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236955AbiHLGXR (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 12 Aug 2022 02:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237024AbiHLGXQ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 12 Aug 2022 02:23:16 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE90EA50F4
        for <linux-scsi@vger.kernel.org>; Thu, 11 Aug 2022 23:23:14 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id r6so12874ilc.12
        for <linux-scsi@vger.kernel.org>; Thu, 11 Aug 2022 23:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=XD21JD+K+a8oVdMsdQOvvYNmKdGALvhGBN389+nvhDQ=;
        b=qQsu56UdKZ7tvA+rpWpdetB4faWHDJjYOa30nKYYWXJCLZWjPXZBv4D4fXdgmkSwwi
         iD77c+LxRdR0Ffc/VGFXi7A6AcU8VoNeCfd5Qbf15UO522DcoSLZXjRly/FJMaK3FB2v
         zaUrXbw+TGfEsAJajfl8EtOa7hHP75HP8QFal6aHb/kDY6te7F5fYyYfI6B9Cit4Onwr
         RauriGvb73GbQyASK0qvk81bTFoBBZDra1loRa7desBeWbfroMhZdMHiwwmidd2s7swq
         qdOMb3yAds1baMkUNVITXaifK3CBLZguNZXbAvTpNEBziUJUCmWzUImK8ZoTRTqx1Mli
         Nr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=XD21JD+K+a8oVdMsdQOvvYNmKdGALvhGBN389+nvhDQ=;
        b=fpMBFTGB/ZmK4hw/S59aN8VwKL9N+QPsDSW1x9/DVKT9eXyDIxspLmWRLFtpFQMmt4
         LJSkqQgx85Mxu7CRT5CN3XMgvhZjKOMY3dUAX3DbjeWnoXeVfcpRk2fClwW3I1Gj5OfK
         JfCDQjRsBoYQ8KTWxqTg91AEc46ojhTkHyiv18YYqao7sgdMqRmvC2oeSgGGXQSWzXu3
         ZL/NfwsJ5+xc6FPf0Sbb00YjdIvE+tW+sUfT9IOfPZc9bALFW45tux6iqhh1bRq2Q7Jh
         ErnouWdmn2nMORnht0MjhWCrTlNn/jQBPlPR4OKsxcy3h3A3a83yA/DqbUyAzsHn7q3+
         mkQw==
X-Gm-Message-State: ACgBeo0KfOEpyHpTKoEyfr+OUDbHRSUtk5hQeRgFqa/1c832qhhiQwz7
        XDri84pUac/WtMQ12cTzFgL0agVt0bEtCwCESks=
X-Google-Smtp-Source: AA6agR4qhC6zxykNT0/5NwI0UKwYpm7c2u+y58tRXMDsX7j4Y6qmojh+xZO50nLsd8FqaYJZeQNBfrNOVQUGaOPhMwA=
X-Received: by 2002:a92:c567:0:b0:2e0:c51b:6a13 with SMTP id
 b7-20020a92c567000000b002e0c51b6a13mr1209766ilj.27.1660285394147; Thu, 11 Aug
 2022 23:23:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6602:2d47:0:0:0:0 with HTTP; Thu, 11 Aug 2022 23:23:13
 -0700 (PDT)
Reply-To: warners@telkomsa.net
From:   Yours Faithfully <99onlinemasters2022@gmail.com>
Date:   Fri, 12 Aug 2022 07:23:13 +0100
Message-ID: <CAJ6qs-wWM8sNG6mmDHRwQAT1MGHMAq6WBt1QTggXe8x1boiQkQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.3 required=5.0 tests=ADVANCE_FEE_4_NEW,BAYES_80,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:142 listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8164]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [99onlinemasters2022[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [99onlinemasters2022[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.2 ADVANCE_FEE_4_NEW Appears to be advance fee fraud (Nigerian
        *      419)
        *  3.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

-- 
I have a proposition for you, this however is not mandatory nor will I
in any manner compel you to honor against your will. Let me start by
introducing myself. I am Dr. Smith Lee, Director of Operations of the
Hang Seng Bank Ltd, Sai Wan Ho Branch. I have a mutually beneficial
business suggestion for you.

1. Can you handle this project?

2. Can I give you this trust ?

Absolute confidentiality is required from you. Besides, i  will use my
connection to get some documents to back up the fund so that the fund
can not be questioned by any authority.

More information awaits you in my next response to your email message.

Treat as very urgent.

Yours Faithfully,
