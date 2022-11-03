Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D703F61833D
	for <lists+linux-scsi@lfdr.de>; Thu,  3 Nov 2022 16:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbiKCPri (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 3 Nov 2022 11:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232002AbiKCPrg (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 3 Nov 2022 11:47:36 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740A517409
        for <linux-scsi@vger.kernel.org>; Thu,  3 Nov 2022 08:47:35 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-367b8adf788so19386027b3.2
        for <linux-scsi@vger.kernel.org>; Thu, 03 Nov 2022 08:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pda/ir3/42gu/nV6jt1XuKeJNI/TI6DIbNvbhe+YGyI=;
        b=GFKP0W6PZ9cCV38TDiPXLcXYelX3lkv1d47Dpo456DZpHCAEAzFNZb67dvnCBphH/k
         GKZun8dRru1rp0wbihjweqW9z38fK/QeutbNbHBEDv+Jahq87DHBshqwTXRAgGcTCskC
         tesOmE3A7rKtsoOHp2MpG3shpJLvR9E7yoDerRCblWDF56+9LoWI7C0JwFcuNPmgw7QK
         B38nzVlX54U2e2m2A2g/lcG0EOHSn4RdPvPzNgCeuUkJW8zHFouz2HL3nEriWpVFZuyV
         D5o6yNXt7nAybiIuBNm1zipidc9x6WR4fV5sJjQtQZ6fy9+41KEN7wzE/y75Zfnhj+wP
         TEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pda/ir3/42gu/nV6jt1XuKeJNI/TI6DIbNvbhe+YGyI=;
        b=5t9o65wXnKr9ByNY9SolDtRvcWt2egabv3Ibw8SBRRXHTDLNwvmRZg1uDizWIYlJEF
         FnWtJ2JwZX0RDeqnWFOFUvyJeLGQM8wgCB8cWhZSe+xfo/qywUhIeKFq4+JYwKUzBTNI
         EFy2QOM+7g/kFUEyhu5iadvUdf/LJl13f1pKI4K83t4Q02oMWw7Vhc69upms9wUg0vM5
         Ag9fRTvBA2njZGyNzwcY2jqCfsV5EjeaSuU4B/5UuZh7z7ZPsHxfGbHXMFo6NjutXqL1
         szh0K7r2M2PZd2DkS7mXl/DEswFdhVLt+SinllNK4J1+q2tk3fxQM0VHNs3dBVxKLpkm
         iPtg==
X-Gm-Message-State: ACrzQf3tvBErxFSVheJxfdJPjFfUg+xFf5HZeI2/RBMAsmnFkkMbwB9i
        +yIExw2UJaRPTv/80DEUbvDOwmauVrSq+n063q8=
X-Google-Smtp-Source: AMsMyM5UpMwEOEYfvHcgIqFEUvunejFnDK5TFTWzvTmxNNuDDZIAo5ClU5CIv5IZUnfQO4rcU239aqLhhRPQK/URBKo=
X-Received: by 2002:a81:8883:0:b0:373:5319:bf0a with SMTP id
 y125-20020a818883000000b003735319bf0amr10021627ywf.201.1667490454554; Thu, 03
 Nov 2022 08:47:34 -0700 (PDT)
MIME-Version: 1.0
Sender: awardcommitee40@gmail.com
Received: by 2002:a05:7010:45c2:b0:313:ba7e:115 with HTTP; Thu, 3 Nov 2022
 08:47:33 -0700 (PDT)
From:   Mr Koffi Apo <mrkoffia5@gmail.com>
Date:   Thu, 3 Nov 2022 03:47:33 -1200
X-Google-Sender-Auth: Jfg4gra43glvZcxPy9AqHGxhc2o
Message-ID: <CANzwTXZX-AWBDtbnPhHSehbippVBwXAOV_y583AkWHrzUBFW9A@mail.gmail.com>
Subject: Get back to me urgently
To:     koffiapo0011@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.8 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DEAR_SOMETHING,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,RISK_FREE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1135 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5021]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrkoffia5[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [awardcommitee40[at]gmail.com]
        *  2.0 DEAR_SOMETHING BODY: Contains 'Dear (something)'
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 RISK_FREE No risk!
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

4 Ecowas Road
Lome Togo
+22896977586
3rd   Nov 2022

Dear sir

I know that this mail will come to you as a surprise hence we do not
know each other before communicating you with this piece of
information. I am a financial controller expert and a Business Broker
to a deceased Immigrant property Magnate. I hope that you will not
expose or betray this trust and confidence that I am about to repose
to you for the mutual benefit of both of us.

I have an important message to you concerning the death of a
relative/business mogul, and his fund valued at US$5 million he
left behind in a Security/Finance house here in my country (Togo), and all
the related transfer documents regard the fund are with me so I will
like you to contact me so that we can pull out the fund for our
personal use hence the Deceased has no relative left behind to claim
the fund

just ring or email me immediately you are in receipt of this
mail. Note, this transaction is 100% risk free, so you have nothing to
worry about

Regard
Koffi Apo
+22896977586
