Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A026561A9
	for <lists+linux-scsi@lfdr.de>; Mon, 26 Dec 2022 10:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiLZJtC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 26 Dec 2022 04:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiLZJsw (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 26 Dec 2022 04:48:52 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD9C1B3
        for <linux-scsi@vger.kernel.org>; Mon, 26 Dec 2022 01:48:50 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id gh17so25218559ejb.6
        for <linux-scsi@vger.kernel.org>; Mon, 26 Dec 2022 01:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7XukgsAlfYiKI+yuvdwyFpb/FGCy9p+ybfvm0wRi4Y=;
        b=osMoQwk/1Lp4fBDvSmCbGfdmNOIPr0moJVz6VEUxLvYVDsOs+fTRyb4kaquh3zT1jD
         LUqjgzuVDBpUdv7qe8Afw4A5YEw6wkLVaPPvNoF8Zu9yVLkGOFh067Zyem/dDRguh1Ff
         xr3MlTElAdsZPPcMvtTC3VCToXDAhYIRPz3/18bhGbQ7xL84z7QA26He1VCu2p72P3nD
         GZIRviFJztCWAHVrMGwPmf5umprs9+yTfJVIRm1aZbBqN+x8f6tqrKzD12UNZiQ/OjUB
         FVrsy/MFvYfL1gJgwCdXddNK0q7M8KIKZ/Bwzv6GD6s2iv8Wc1QSmpmIl8hex8zFS2Iu
         lKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y7XukgsAlfYiKI+yuvdwyFpb/FGCy9p+ybfvm0wRi4Y=;
        b=24ZR+fxLvscYnxgdLRiglriTCLIfOEpMM/QRHKHmbCj739IPIm6vuEKyX1FxzwmPjC
         rJae6tO94o5ionHal+xf05He5JQiZRi6KIAANuwMOtSsdr+vcbQadnOhdi41h/TF4HoG
         CM0uy+NWQHWx0nOg6zgtam6lmcWMiBv3irN7DeNx2//guz1V4ch0Af5+IhQwhJSgdQNj
         pS0m76Qkk8Xdpuw9qMJCDT94DKjmp2i4mMwSfyHO3tOwfw3Z/XzeOrp88lYoCwZTW804
         FMthytO91G8EqWckwJ50gDNq08BCf99GFMKzSEUNOA4byQbG59tYXdkk0AQ38YPuG+tv
         mnvg==
X-Gm-Message-State: AFqh2kozW1jiMpY8rMFzBD/FOAS9VeW4QKA5Wolgi4lhDKHX5l4eCUHy
        4JsM02u4tYiCZg16bctMc+cNynk6/iZIKA5pX90=
X-Google-Smtp-Source: AMrXdXvU8tQcszOplhZkH/2iyLmZ4NlMON73tdUK88ArMVTkZllFp25d5+qMYFmBDS5UmRi0ZVq4z4sHirfoLMAesD8=
X-Received: by 2002:a17:906:8282:b0:7c1:9c6:aaa1 with SMTP id
 h2-20020a170906828200b007c109c6aaa1mr1783078ejx.583.1672048129269; Mon, 26
 Dec 2022 01:48:49 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6408:1548:b0:1c8:b720:2cce with HTTP; Mon, 26 Dec 2022
 01:48:48 -0800 (PST)
Reply-To: privatemails254@gmail.com
From:   MS NADAGE LASSOU <mohammedibrahim08084@gmail.com>
Date:   Mon, 26 Dec 2022 10:48:48 +0100
Message-ID: <CADeLEaHvAx8B=xaa16zGdLtGy0EhbnVdQvL-_fPHt6ogue8g2w@mail.gmail.com>
Subject: YOUR ATTENTON PLS.
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
        *      [2a00:1450:4864:20:0:0:0:630 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mohammedibrahim08084[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [privatemails254[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mohammedibrahim08084[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
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

I am Ms Nadage Lassou,I have important business discussIon with you
for our benefit.
Thanks for your time and =C2=A0Attention.
Regards.
Ms Nadage Lassou
