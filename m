Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B4951E0C2
	for <lists+linux-scsi@lfdr.de>; Fri,  6 May 2022 23:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444292AbiEFVMy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 6 May 2022 17:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444282AbiEFVMw (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 6 May 2022 17:12:52 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C126F48D
        for <linux-scsi@vger.kernel.org>; Fri,  6 May 2022 14:09:08 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t11-20020a17090ad50b00b001d95bf21996so11866146pju.2
        for <linux-scsi@vger.kernel.org>; Fri, 06 May 2022 14:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=VSSUIwdzgxQxnEkB7+u7pnweyPajIQMP3nQqWYs8VX0=;
        b=dRDKXprhlGbd1zHlYa/B+PvUTpdWL8YAmnaH4jigMFOTXdvn+Z3dBXD3WbRIhK4qMt
         ChVmQ7di1vbvMY97AcQtrr1UKudk8k9dmk/Z0AmfrMeQVKrL7yFwSIzlP3Tn+TxIhKMr
         Nsj2mVlY0ODbA+5kk6nn8otnIB0vbElitdZOdWwQfWvo/Q+S294F7AxfI2Ek7OccrEVM
         Mnrj3r6nNZdO4vV8MZdKDEgV5fRtoAzuK6s5t9+IQv97F8jftlkQ2++YRclffzAMlAi9
         kuCtFBHM61ab/EaFzHd5dGTi9QvMsrNHdPxC6xNs3UCEKoyi1yv313nFhsagBchAHr9i
         GpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=VSSUIwdzgxQxnEkB7+u7pnweyPajIQMP3nQqWYs8VX0=;
        b=dRCNWFFs+6mLGIQ/YLin9Lifq21Fy8rLbzJRxCl1PqEZq8FFkxZPPhaq6NzAlg6A6R
         mExZKpFqKbFbDykYeUK8W59Otkg5AymLnJ5pHenn+qBmh4GNJLiRK/en45rCFq0jnyle
         wyGbtSkXrYjCaLcR10OiLRFkukgM65GOKLTj0ss+x2Ze5EnN5KqEwRkz+zooNwS90Zyy
         j2FuxJDjt0XjmPy1BFOdsZhH6sVrhUCLLiq7TUvpEeuSIwOR2NEMJ+vKFjDuA9JJ+D+1
         OV0yTC0YY7ch+iuunK6X3VZ7fE+5/ymwNzD9Y80rp20hvsu8hKOzDs4bCXxZKgHQYIJn
         r9Iw==
X-Gm-Message-State: AOAM530tgF07Kz4eeTb7QpvjDrg07OD9w0Hkc7f8sl5Ks3+M98il3SdP
        Fr1FPYFqfRXlf460P5HgTVHqEEk+0gv8WLT5eA==
X-Google-Smtp-Source: ABdhPJwMKgJBXMjhN20uF8yhf6Mue5+3eAmiRBptNZlvlrSOFxeAzVJVQyuXlAKHHa5EmliuLWK7uSzxfB2MTwb7ajc=
X-Received: by 2002:a17:903:32c6:b0:15e:c1cc:2400 with SMTP id
 i6-20020a17090332c600b0015ec1cc2400mr5592118plr.153.1651871348442; Fri, 06
 May 2022 14:09:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac4:9906:0:b0:4ba:807b:b8f3 with HTTP; Fri, 6 May 2022
 14:09:07 -0700 (PDT)
Reply-To: warren001buffett@gmail.com
In-Reply-To: <CAD_xG_pvNZK6BFCW+28Xv4DE=_5rbDZXDok2BYNn9xw6Ma7iow@mail.gmail.com>
References: <CAD_xG_pvNZK6BFCW+28Xv4DE=_5rbDZXDok2BYNn9xw6Ma7iow@mail.gmail.com>
From:   Warren Buffett <guidayema@gmail.com>
Date:   Fri, 6 May 2022 21:09:07 +0000
Message-ID: <CAD_xG_rq7Wy-0XZWX43Z7+9iCoaSZDkqEBOA7UBXiiQE6duuhA@mail.gmail.com>
Subject: Fwd: My name is Warren Buffett, an American businessman.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1042 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4891]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [guidayema[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

My name is Warren Buffett, an American businessman and investor I have
something important to discuss with you.

Mr. Warren Buffett
warren001buffett@gmail.com
Chief Executive Officer: Berkshire Hathaway
aphy/Warren-Edward-Buffett
