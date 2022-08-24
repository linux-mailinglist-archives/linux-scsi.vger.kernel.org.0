Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B046F59F8A9
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Aug 2022 13:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237083AbiHXLdP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 24 Aug 2022 07:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbiHXLdO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 24 Aug 2022 07:33:14 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA13B80376
        for <linux-scsi@vger.kernel.org>; Wed, 24 Aug 2022 04:33:13 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id r14-20020a17090a4dce00b001faa76931beso1298706pjl.1
        for <linux-scsi@vger.kernel.org>; Wed, 24 Aug 2022 04:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=AHlvfWwcWZjTu4ncIVy2BK3HgcJqLKX00ngl2RsEioY=;
        b=VgyX2UfdYGB+kTNkc8FtyZjKtCrQNEBZk4gJv1I06+pwyJwZNW7CV5qFfrJc5JEgj4
         IpxMN8WQHyPdm2uXbgrb5sd1hrruvINfxaPukVoghs+eWpqNA8beNdSciEAMAb8ffYXc
         WG4q1BVffgKDtZlQSdYf7/qTSRbGRQiqtIrhpxlcGSsczS3J96TF1oe4TzkIvnvo6Rxc
         fLNluOVUQ544YR9DZW9iZyU3oTRuoUHP/8PYnkBezG6we58Q54OFonRn10qLeN8/kXCa
         mQagWF2Tmrnkt4ICaGjh5LWJgiPsmBRmhbnTAk0/wvt/KC2U6QQn64gjCh5GXbRSK983
         iZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=AHlvfWwcWZjTu4ncIVy2BK3HgcJqLKX00ngl2RsEioY=;
        b=GBXwNNwQiu/nTW+m2l4YtradyFpiXkswj8+HVyD3JJBDwgjfbO2fmhVeO6/yV1yMDI
         hoSW5vgLLTH9Yud3rlBISSLwPpbAJIwK39jMW1XI6jMeoz/KtWwRZEYKz+NJ2LzF9VF2
         aMOyUJ9/u45F15qAXvLJ+rpPCua7LmZWCU5y47XBOBH8/rvTlPj52Ue+lNRJckR+y4QF
         hWxN+6NQiwaCsrY1B/zXZEUAu9CE4ZoTSdCcOg3YAQ/ya6z/Ugre+jfzqNZ6vVxwK4d+
         p3rc+8aKZtN0HN2aKlCBI4rQ5T7q7PiCYunxuohwPOnbwN0rBhQMVR4HCekOAyoLqb/m
         WPaw==
X-Gm-Message-State: ACgBeo1ZpWIsNbv8NaUCjdh85RiOE0yRFpB633ebSLSY1gdXlmjgaN5/
        FfVeGB7lnEqctVL1dXx7Grq9oXX80M3WD/+c5Rk=
X-Google-Smtp-Source: AA6agR6ZD/GJjp6A7GBvdD6lt8r6/kn+px7uNMX5v9JQLgCP6zlvqSeAC3XMGRjf250OonzHC5nPrGWq7y5X5WwJOKY=
X-Received: by 2002:a17:903:18a:b0:16f:e43:efdf with SMTP id
 z10-20020a170903018a00b0016f0e43efdfmr27752034plg.157.1661340793061; Wed, 24
 Aug 2022 04:33:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7022:23a1:b0:43:a2d1:f72f with HTTP; Wed, 24 Aug 2022
 04:33:12 -0700 (PDT)
Reply-To: felixdouglas212@gmail.com
From:   "Mr. Douglas Felix" <legalri168@gmail.com>
Date:   Wed, 24 Aug 2022 11:33:12 +0000
Message-ID: <CAEWy=dUv-4b31gxUr_U46ZgrbYcX=TUxBJ2W8vngcjSmNGxm0Q@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:102b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [legalri168[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [felixdouglas212[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [legalri168[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
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

-- 
A mail was sent to you sometime last week with the expectation of
having a return mail from you but to my surprise you never bothered to replied.
Kindly reply for further explanations.

Respectfully yours,
Barrister Douglas Felix.
