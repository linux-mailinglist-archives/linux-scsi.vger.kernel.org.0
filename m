Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3FE641582
	for <lists+linux-scsi@lfdr.de>; Sat,  3 Dec 2022 11:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiLCKCL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 3 Dec 2022 05:02:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiLCKCK (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 3 Dec 2022 05:02:10 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9847BC03
        for <linux-scsi@vger.kernel.org>; Sat,  3 Dec 2022 02:02:09 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id x24so949471qkf.5
        for <linux-scsi@vger.kernel.org>; Sat, 03 Dec 2022 02:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FocuR5aXn3z28LzYD0rCmA/t4By4lcIW0G986gs+i74=;
        b=HQhlVFk2YL8DEOtAs+wl51N1wLzOM3Bi1aUi+mo8EMh0H0AsL3fZnmgsL1lIlcFKYK
         tfGFeV+0N5q3eFmLWT5iLN3ZuGbfBvYx5wWJiV4GQ7hY9C6l0amzld+/K2iYVKO2K9T0
         ZUT7Mad0bnHIKV6ag+8AGD9itag5JMnoAq/d+sLfn/qLyFyHH0AzjmIQKt8ama7/mQsi
         DlioRDvJjWx2ldq8X/pvpe3UlsPIi5UxcFGq1KK6H8MvcVteXKWRrglJp50d4oR9lQKg
         QHTpYPawDXrxUXQRIn4BiUXlsU2eG7IjKdkRqL8DaqJwl03sMtJfdjRF2blKi1VPgEHO
         Romw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FocuR5aXn3z28LzYD0rCmA/t4By4lcIW0G986gs+i74=;
        b=wzeSRt8s9X/04BFozKITYWrE0X0T5zjwH6zvscdE0cU4E5tUlhjvdhS7Rus4g8L2+V
         wwmD5CM2y3ijPmS2vtE+RVFGLpHSG+VXkg64W3/Yyfo3EY0gLGdqcNyCvjEpa+qCsxRF
         z/q/lOF93DqPubvu2jgcmW8kj1Ca8SX4odu+UBgqu7I7oB2jCxWP3wjvb6m01Fpmw7Ij
         nq7mfL+SgKn7l1L/Hf44UHoVReXa38xGLi1y5I9lmbRrmuGIDzykNRfxU1AvZ7bPKWk6
         4wHdNCjfeSuxMdCcEPV5aDyrDpNjkO6taRuI75mV5PS3TtQbo8jqvuvDfpBGbblsSVsj
         o6YA==
X-Gm-Message-State: ANoB5pmT8PuxjyF9N9rWepgeFMbqjrmGXJznYc5PXnBQrmIh1quTgA2G
        G+CNWTU8lHEtyk5yxcS2RTpln0mHISc6vsA2nHs=
X-Google-Smtp-Source: AA0mqf7fln5B+ETKtOwLPLWOnv0z944CBiAX/7Ykq1pV+d/Xkao4AXsRtWewbX7s24BVgxOhiH5A5PHY5GI5fGZtlFU=
X-Received: by 2002:a37:2dc7:0:b0:6ce:2d77:92d0 with SMTP id
 t190-20020a372dc7000000b006ce2d7792d0mr65947733qkh.713.1670061728134; Sat, 03
 Dec 2022 02:02:08 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:622a:5d2:0:0:0:0 with HTTP; Sat, 3 Dec 2022 02:02:07
 -0800 (PST)
Reply-To: khalil588577@gmail.com
From:   Abdul Latif <zouweiratouyahya016@gmail.com>
Date:   Sat, 3 Dec 2022 10:02:07 +0000
Message-ID: <CA+1ejC7fyNp84VXD5sERRgudD4V7spW+nbgzJWc82+osAsyo3w@mail.gmail.com>
Subject: GET BACK TO ME
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:744 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4871]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [zouweiratouyahya016[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [zouweiratouyahya016[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [khalil588577[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  2.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

I am Mr.Abdul Latif i have something to discuss with you
