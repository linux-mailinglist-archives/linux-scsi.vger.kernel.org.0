Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15048626BFF
	for <lists+linux-scsi@lfdr.de>; Sat, 12 Nov 2022 22:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbiKLVmH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 12 Nov 2022 16:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbiKLVmG (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 12 Nov 2022 16:42:06 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2BE13F9D
        for <linux-scsi@vger.kernel.org>; Sat, 12 Nov 2022 13:42:05 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id p4so8151843vsa.11
        for <linux-scsi@vger.kernel.org>; Sat, 12 Nov 2022 13:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DcIP7sVO2A0wryRpupzUPWQywPt7sc4xyWCvZop1t1s=;
        b=qd47u2S7ouyqL6LSWlM7XHpxaqNDS576rQHpcLc7ml8gVia/F1UNUUwuO5VZ2YcMXQ
         LVoIz239vCHOeV5zn7oyubJzM8HGvnlQW+8r7pKBawTylkXqJzigOb45ABQuyqyGmheX
         7fRXj2CcyMwvkhoqrqQAF+FkbvqBuNafJiQRGpyfOiB9/e8orkXfLIqghDI6Mr155hUu
         t6G+Ky4pvOZp7uljEQOZu0zUgPjtVrQIJxBUG2KDrLKOCyh8mq2L6ofuGPDneZIgyxW5
         DT47/pY/llWWWwar79QTUgqO91h0c+pbUpoB9JbLtnKA561mPQgO+qlDij3DTGTA8weI
         2HQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DcIP7sVO2A0wryRpupzUPWQywPt7sc4xyWCvZop1t1s=;
        b=tJ7aDrB/BFagmYTq9EJx2JQWxiHTXWG6uTUZxn1lft125fs5f8fhj4oxY88itUa8c/
         asR7nXaefeTQuxft58z6eJ4111dG2QMaw5/1035BrC0jodKCNuD6m3yEhiVslyW5RNVM
         sVZIroMrDG+2if1tauxoU5jWK7hE0pl1Mx/j6MGsHBOK07Mp0aLxGvCRavHDqniO47Pr
         2CVE/c32z1+/MKoFNtTbupS9FZMOunwa6faiQUtEdtecoEpCsX4WkzzMvsA71Iaa/SIZ
         K5PLz1Ttwphi5VtJ6Bx/IdGOvPvvFO4GLvA/OGy0Zg7KwmQUGPys+7IAGeTL3cGmsxAz
         b+uw==
X-Gm-Message-State: ANoB5pl2I2+YiPhnJjaLRRw8O96OjowWsUi9rDgWrlIOhvUqOT98Zoxx
        avp2Pq+e698XQc0iNiP6qMn1eXTxZWpcx37wQUE=
X-Google-Smtp-Source: AA0mqf5Vn++ciWmujfS8Ww5tiUrOu+90c0kHFXy40QaLwAbIuwXm3DRf1Y4cM32mJMsD5XfSCNNRnOoRMR5cWkLuIoM=
X-Received: by 2002:a67:ebd4:0:b0:3ad:cd34:a28f with SMTP id
 y20-20020a67ebd4000000b003adcd34a28fmr3516709vso.76.1668289325006; Sat, 12
 Nov 2022 13:42:05 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a59:d6d0:0:b0:323:7ec7:69c6 with HTTP; Sat, 12 Nov 2022
 13:42:04 -0800 (PST)
Reply-To: ch4781.r@proton.me
From:   Mrs chanta B <123456432d543@gmail.com>
Date:   Sat, 12 Nov 2022 21:42:04 +0000
Message-ID: <CAGwDaqiLfjwrQdftHUcL8ZSbfX+fZ4v6wWe+H5Y1bf7jsBRM9Q@mail.gmail.com>
Subject: Greetings, I am Mrs. Chantal. I got your contact information from a
 reputable business/professional directory.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.5 required=5.0 tests=ADVANCE_FEE_3_NEW_MONEY,
        BAYES_50,DEAR_FRIEND,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_HEX,
        FROM_STARTS_WITH_NUMS,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e2f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5297]
        *  0.7 FROM_STARTS_WITH_NUMS From: starts with several numbers
        *  0.0 FROM_LOCAL_HEX From: localpart has long hexadecimal sequence
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [123456432d543[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [123456432d543[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 ADVANCE_FEE_3_NEW_MONEY Advance Fee fraud and lots of money
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Dear friend

I have a business proposal worth the sum of 6 million dollars, Kindly
notify me if interested.

Thanks
Mrs Chantel
