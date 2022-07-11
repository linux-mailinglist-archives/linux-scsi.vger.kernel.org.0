Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8716B570201
	for <lists+linux-scsi@lfdr.de>; Mon, 11 Jul 2022 14:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiGKM2G (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 11 Jul 2022 08:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGKM2A (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 11 Jul 2022 08:28:00 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3B54A833
        for <linux-scsi@vger.kernel.org>; Mon, 11 Jul 2022 05:28:00 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 136so8433010ybl.5
        for <linux-scsi@vger.kernel.org>; Mon, 11 Jul 2022 05:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=5cJHSClaSNSC6CADWeDtciJpzEgHDP3Cx3FDxh15jpg=;
        b=dgFPoBIent78fG06v6q2l3E5bzLT2DHVVNf0ovSsw7s5Yr0a8mEKV6x5hA7g8vEtSs
         cSB0wNtM0tRNopE4NuJ9LS1RMlBbJFa/T0ZXnPtxKzTEfwi2Ekbt+3tMitruuCipn/I0
         9c9U5HTnWYEwKmHknB2JANMreXa5KWTc5u3nrftwnxEpFtN0H2nWiakn1+5FtRTDlQDO
         +Wf8Mn76so3Mc+E/S1evHVdeqKpWq49Hdvz06VZWhu4FGLX0BpuxbZ1+9U43MvqfLvuz
         CvGGQYU/hiaAGhtxR14NXtUqks4ysuzVKcLvrFfXt4EvsXNc5qyGr+IZ3sr8xTQwwyfW
         26bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=5cJHSClaSNSC6CADWeDtciJpzEgHDP3Cx3FDxh15jpg=;
        b=m8gbbP/DBGTGY+K6NYsqL7Yz0VWdJFipMXir0EIBGmswO8Kkpl2hyAB7OmOiC7+Rgr
         X7ijzdEzLQWj8NjI60CKRFoxXJ8zLa/5N5NTrrBBGu6PVH7XFqVSIcEcPQYOAHU+XaxB
         P1EFbNJJ05gZDK93ghu4ZOFmqpK99dgKM6Ugq+dk8pwR92fRnoS0Cjf+xZ2q54XV0mSK
         g4P8DV8tlX9o4elONeY8U8PShCwjS2vdUW8UDU/MtVD1lDOoIanRbkihFeWR1KA7yJB7
         fj943xJ1k5zaGe7OxN2XJxi6HZ50pOR6d6m/IfTjUDfFu4X95LiERmFBBi7MwY8dMCam
         216g==
X-Gm-Message-State: AJIora8Qayq/l0d2xT4Bm9DvvaFujNgLl0LWzHRql9HhEQwMetEaBj/J
        AhhhF5EoY5UpQgcaj4k5XfAW2gr3TzzOnJAuFco=
X-Google-Smtp-Source: AGRyM1v6B5Rksf0Mx+SPwgEHpoBYYVCf2fN91YeYIydtmyhTKLJMmNaAA27q5t0zYsJN/ek9H4zDTeWoZkqLN1Q0Thg=
X-Received: by 2002:a25:3383:0:b0:66b:6205:1583 with SMTP id
 z125-20020a253383000000b0066b62051583mr15991268ybz.387.1657542479371; Mon, 11
 Jul 2022 05:27:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:a60f:b0:2da:3756:6112 with HTTP; Mon, 11 Jul 2022
 05:27:59 -0700 (PDT)
Reply-To: mr.abraham022@gmail.com
From:   Mr Abraham <mr.abraham2021@gmail.com>
Date:   Mon, 11 Jul 2022 12:27:59 +0000
Message-ID: <CAJ2UK+bWv06gHgFocZmAQcekF0OP5NEVamV5CLOE+Vp4jRXipg@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b34 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4795]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mr.abraham2021[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mr.abraham2021[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mr.abraham022[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

My Greeting, Did you receive the letter i sent to you. Please answer me.
Best Regard,Mr.Abraham.
