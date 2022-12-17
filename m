Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7808E64F982
	for <lists+linux-scsi@lfdr.de>; Sat, 17 Dec 2022 15:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiLQOzc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 17 Dec 2022 09:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiLQOza (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 17 Dec 2022 09:55:30 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88CA14008
        for <linux-scsi@vger.kernel.org>; Sat, 17 Dec 2022 06:55:29 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id m6-20020a9d7e86000000b0066ec505ae93so3021811otp.9
        for <linux-scsi@vger.kernel.org>; Sat, 17 Dec 2022 06:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kxYdS7HXFgPwD0CbUOPTSoYIdNu/3BBiNK57EJjVBfg=;
        b=BzYY+K73IEppIH9vs+0kHKJI4dPNPL+EndYT6fxgGnA4NHnhAfnGVZoWgrc3XhgKlI
         SzhSJfetZ0x+41SZ6kzyDqTL51qNKj95q30NjTsccG3/8buip/MGLyNTmDeVyJE6v895
         2T2ZxVMuKej6BvUJwoudemEmgRnN7uq3ECbyQ0cW+IzUkycGLviLPl10n6aV6TOAR27y
         4RwG1JtmBxsMHTLpLGob6xVVhTE/L4YYN9jjqtHWK2nrwwoBujXG5iTmxwoOOsb0EJtV
         dtSkVo4d9fDWhqfMmr58pJJrD1fO4Xpa25cg7l9jVYDN7xnOhKeJEm0mpoAd2IZ0syQT
         jYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kxYdS7HXFgPwD0CbUOPTSoYIdNu/3BBiNK57EJjVBfg=;
        b=cwzoUsnZ9y4wpOE2XiW9Q1KmxmTpB3NBwNTmu4legbmz9G4lEaWmE/KPy3FZ1T+7Tw
         n79oc0O1NGxk7w36Y1rbOvX0Tnkfa7qn4E6cFsSnAGusJPUdHeHbqxsxRuTWw3qa6fp3
         G0hTSFX1Z98Dn96Tk0gFsUmLvEGVmBRo4KXsgdHJFut8Nu+rVGRZq6IO2YuvTvW72GuU
         W05sSSwKDJpl0/BbyfzVC13OpiDTyZDZ7Vg9e61eAALpXOCuIPOw841rua+M0nW/45h0
         5GPlKU98ARyMWK9m0sz/qnWn0wg+Qf4Wb6gYBCoVu8jfLTbxr9YApbpZ6pQWRvW4sAjb
         LMyw==
X-Gm-Message-State: ANoB5plBng4l052IGn2Y47rWZxblsDMEWqc38Y+hi7QNafAzHCVBDQCu
        yKtf5R5ycjUztCC4ZLK6yQCYLpyh2r9YRrgtJEo=
X-Google-Smtp-Source: AA0mqf7SC1GYReDnfk97aC/SZ6myZqHORw5BS4WUzsMP7w8iT3JcbS1zwpU5pj3xo2I1O5e+Nvu1pwQ/Kmqe8sUm4ZU=
X-Received: by 2002:a05:6830:6408:b0:66e:6b6b:f7a5 with SMTP id
 cj8-20020a056830640800b0066e6b6bf7a5mr20244264otb.153.1671288929224; Sat, 17
 Dec 2022 06:55:29 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6840:6697:b0:faf:e552:8c5b with HTTP; Sat, 17 Dec 2022
 06:55:28 -0800 (PST)
Reply-To: ab8111977@gmail.com
From:   MS NADAGE LASSOU <hunhdd123@gmail.com>
Date:   Sat, 17 Dec 2022 15:55:28 +0100
Message-ID: <CA+9ouuqMTT-8GiLsJEyfCam0BUQpa665D2wCnuXNZ=MeqcfP4Q@mail.gmail.com>
Subject: REPLY TO HAVE DETAILS.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:342 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4991]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [hunhdd123[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [ab8111977[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [hunhdd123[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Greetings.

I am Ms Nadage Lassou,I have important discussIon with you for your
benefit and others.
Thanks for your time and =C2=A0Attention.
Regards.
Ms Nadage Lassou
