Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB8658E6C0
	for <lists+linux-scsi@lfdr.de>; Wed, 10 Aug 2022 07:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiHJF2J (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 10 Aug 2022 01:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiHJF2I (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 10 Aug 2022 01:28:08 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C9A7D1C2
        for <linux-scsi@vger.kernel.org>; Tue,  9 Aug 2022 22:28:05 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id tl27so25774350ejc.1
        for <linux-scsi@vger.kernel.org>; Tue, 09 Aug 2022 22:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=0j2fNWlhqHDdR8vDkqVbAvzs/vaD31QYk8D65F418vw=;
        b=JoKX8IaZcsoId1sQFiaxaitZaMIYfi9gQtybxqHLlj5Lp+yNibDlD3083oO+MOqE+C
         BigmRxXN0rTJpbur1jL9zrx9n5OZOFBsrX+TBB4g2bTjfCYbb7dKE60mAmnwETydE1SQ
         u7XGihDMMRF3ARUTsdxXTWnfckpwEYMP19jew297mGO7IwBG38qyI5L43u/NQ87BfSyd
         9AUbtkpIi1GI6yfXuye0nN2m6EtcCNuXNkHtETCL9nQJvZrydkV+vrOggqZf9hCgcjoN
         eBeX2Vbxs/tZIfuus9y6bnaWxq6dnnShQS00xmO0jrG8ehdtt7Rl4O7DmR6QTFI9CV24
         2E1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=0j2fNWlhqHDdR8vDkqVbAvzs/vaD31QYk8D65F418vw=;
        b=JPUM9JZjB1l2WAe/0b2tibYMF4NfO6W/rWQjkHqhdI8rn+trWu0Wt/PvKnmFG6q5x6
         HIkCesO3iQgsualJvuJuwEE712s9IDdVp0nBol1xdaZw9UKvNTVK6iDEaCav/1acTo2G
         LrY7l+jsYdHV15mWHdarP1nk6G0RHLSUjBXhZ007R7NhRyCGiz1aFBWoJlIFEbZ15HOh
         mmv6/hIv6zALs2YEwiZEGZthRcykflSkPrygEAMTuQRTy6Tc3tMhWcQrsq5CJTvDyIMt
         BzPMBooo8vLZHhaEKvzcJ/kNPCMSlBAb2zFcerMlgnuDrxMNZLiLtSy53nlhI2GqWz08
         WyWA==
X-Gm-Message-State: ACgBeo3CldeJi0dvWWTf7/kqtcrHc2R83PLf2mZnVBo+eOIr3vUYHBQM
        zdlLvi4bENujeaQyMS9CW5bpsxTC5gJcFP5stiQ=
X-Google-Smtp-Source: AA6agR7Raqg6DoVl06YzXGahRvt3mdtDRZBFJ/ZhXhGiyy7rjBiJOtd1BkZM6j6nifyVxrALR5rFgxjaOBVo+GpFvHk=
X-Received: by 2002:a17:907:c0e:b0:731:614:e507 with SMTP id
 ga14-20020a1709070c0e00b007310614e507mr15392397ejc.529.1660109284429; Tue, 09
 Aug 2022 22:28:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:3402:0:0:0:0:0 with HTTP; Tue, 9 Aug 2022 22:28:03 -0700 (PDT)
Reply-To: ausmann@inbox.lt
From:   Abu Usman <effionga401@gmail.com>
Date:   Wed, 10 Aug 2022 06:28:03 +0100
Message-ID: <CAOGQbUrWzmFU9W3jevOsG=zZmEBmBA6Ooba-gwhhJ4mKVq=TLw@mail.gmail.com>
Subject: Hello Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.6 required=5.0 tests=ADVANCE_FEE_4_NEW,BAYES_50,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY,URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:629 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [effionga401[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [effionga401[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.6 URG_BIZ Contains urgent matter
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_FILL_THIS_FORM_SHORT Fill in a short form with personal
        *      information
        *  2.2 ADVANCE_FEE_4_NEW Appears to be advance fee fraud (Nigerian
        *      419)
        *  3.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Greeting,

I am indeed glad to be in contact with you even though this medium of
communication (internet) has been grossly abused by criminal minded
people making it difficult for people with genuine intention to
correspond and exchange views without skepticism.

This is a private effort to introduce a partnership intention and
proposal to you, I decided to write to you. I have decided that I seek
your assistance in a matter that requires your urgent attention

I'm Abu Usman from Afghanistan, and I am contacting you due to the
ongoing takeover by the Taliban in my country.

I need your urgent response to help me receive some funds for me.If
this is something you can do, I will appreciate your early response,
so that I can provide more and appropriate details of the entire
proposal, given the fact that this is only a skeletal introduction.

I will appreciate if you could let me have the following information

1. Your Name
2. Address
3. Your cell Phone Number.
4. Occupation

Your positive response will be highly appreciated. As soon as I
receive your response I will get back to you Asap.

Sincerely,

Abu Usman
