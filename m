Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4308153DEF4
	for <lists+linux-scsi@lfdr.de>; Mon,  6 Jun 2022 01:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351814AbiFEXdd (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 5 Jun 2022 19:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351820AbiFEXdb (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 5 Jun 2022 19:33:31 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF41E27168
        for <linux-scsi@vger.kernel.org>; Sun,  5 Jun 2022 16:33:29 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h5so17740971wrb.0
        for <linux-scsi@vger.kernel.org>; Sun, 05 Jun 2022 16:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=hzqCG52SPEe4tQY/Tt070sXpLEE5srR/6HSZh6AwAPo=;
        b=kYqyTELNv74MY0+Xtsf1lfj7zVGpOEbEQXrg+C/90Mms9oiDDoR1tAGfsH8wjin1au
         YgEibdYFsC3ZX5fD3ZTrbFmbUnOpr2QIubv1+FRg642AmsgEU7LFuDOzvCU8SrQo9uVc
         ANsX9cHR3AzEewxi1sIvXUoaPTeYqv+2Rr+WwQ4SIg93A7YMlS/dL93POpl3GQL8wbq0
         PYcTfhT2s+YV+U+JG3Ased41N76s52gmJ8jiCBg7Ax2sUve8NNNgMFY+pegOkd1ur6+T
         LdPia7q6wNFPzAz/tX5zACpBCXsVxa66UTUf4H0pWTFHakZKiEbv0L32pINnRW88WSQ1
         6gmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=hzqCG52SPEe4tQY/Tt070sXpLEE5srR/6HSZh6AwAPo=;
        b=QWOSfVVRF/FcRWyIdtpATxx1ejxkc0xYpFwT52O9oyW9f4bXBDfqKxR9LCUTWz0YfE
         n6i5lhKkD/qesWM/jdzWZQi1HYZWcM2fpFMSQZ3gd3rIcU3eQzeC2ArB6blmAtmRokAF
         G7J7tfCmRNifmIvOEA83Rf7WqxSCX8kcvV4NFqWVTBwD298hRog8DPYY1vg3sfzPSCZa
         0tK4HfjiMMlk9NXNcNsstKSR9smQZ6byEsK0lps4CJUDVTq2QP7ublqD7gK1a5vvDepx
         FoOciG5B+oIjPEwCQ6ocmzTSnZHM9BZlxh2buct/lyLXuYKr2AT2v50iZFYBTlqalQ+T
         hUuw==
X-Gm-Message-State: AOAM533Bz/0qMSVcX28svELDthGSSQLl6+O7uw2eX0xjkdTzV1ApqU+O
        HQkXA+Ad4dGJAHYdoOot6VrI3oIllq/WK1L+5aY=
X-Google-Smtp-Source: ABdhPJx05vkg/25slKFEQFCOcyfbvjg4JjNZFII0Ku3f/Gnu+Tw5+Fxv0/0emaesTDl49gfm20FsSYTWpw96OZmltzk=
X-Received: by 2002:adf:dd52:0:b0:213:bb11:2fde with SMTP id
 u18-20020adfdd52000000b00213bb112fdemr14778741wrm.467.1654472008195; Sun, 05
 Jun 2022 16:33:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6020:5b8d:b0:19a:1ddd:b4f with HTTP; Sun, 5 Jun 2022
 16:33:27 -0700 (PDT)
Reply-To: mrmichaeldoku@hotmail.com
From:   mr michael <md22334d@gmail.com>
Date:   Sun, 5 Jun 2022 23:33:27 +0000
Message-ID: <CA+6A211ud5NH2G_+uu26KkANKe6w8HCvQ+uyrrd45zBvifEkSA@mail.gmail.com>
Subject: Hello Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:442 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5132]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [md22334d[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.6 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Greetings,

With due respect to your person, I need your cooperation in
transferring the sum of $11.3million to your private account where
this money can be shared between us. The money has been here in our
bank lying dormant for years without anybody coming for the claim.

By indicating your interest I will send you the full details on how
the business will be executed.

Best regards,
Mr. Michael Doku.
