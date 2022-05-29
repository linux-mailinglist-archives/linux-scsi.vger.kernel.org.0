Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9948D5372D4
	for <lists+linux-scsi@lfdr.de>; Mon, 30 May 2022 00:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiE2Wqe (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 29 May 2022 18:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbiE2Wqc (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 29 May 2022 18:46:32 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7911E3EE
        for <linux-scsi@vger.kernel.org>; Sun, 29 May 2022 15:46:29 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d21so10437707qtj.5
        for <linux-scsi@vger.kernel.org>; Sun, 29 May 2022 15:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Hmv83JilRiKuRRxRo60MIn+sKLUYVV24um1FSjs0jNM=;
        b=Pa5n2V1QU+XB8C7lkSt8bJ0fv6llyYvi+pOhvIIp+j7pcnrCAeU/AvfAexs4odbK5S
         JrRuTcb6z/aQpadP/QwwsAFeeye8aaoJ7l/z/mX7TSitDT51qCwvD0FCsmyPYMyWAvvZ
         Yev9ho+DiXjcpRkfmizFptdpoYdU8XPlkGTJk/cjq7tPROLMpDBPCHYjo9RUSso3YIKv
         ait4UGYcZoFPmGInrKf6zfb/luA3OppsiAw90PmVf1UhZ3kHya6oRlD1CjV19XZ/6Pic
         dZTjXHL33NddkfnGIZdo2vsWr5ShjDKwmEgAm7zZkBrEyY0kYYwdMGytN/1MhfEzEeEc
         Yl1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=Hmv83JilRiKuRRxRo60MIn+sKLUYVV24um1FSjs0jNM=;
        b=20zUbqE2E8XFZply4ZSQ0Ib2Y63WJBhWmBZUVbM+hZey9Z3WLpEsEUnMLlT0mdpDXz
         pwR+Ji9TSZ/5awwWwhP92W0VAIa3DZQmug4Ncmj9BNBLz9+RWoPpOghKKq0bpFgNm3ay
         f5Q9c2XBBJsuZeakHH2yVeWNEyMXgC/fBVIDCRWLYRY/h2VPITWUNLarCVnnMk4J8fXm
         I/hsZqfRHuMLqOBzOt3EsfGho+PQu6usTA+2G7NEJ0bEnYgSh8CB/Ws1i4zMDil7tHZk
         F+scINfVkflS/EkX+O5A8O2dQWwCVx832BMgZOyTCppX/Ca9FgKNa/iwmqCc14z/snge
         Amvg==
X-Gm-Message-State: AOAM533j8OYYyEp3/VfQBT/JoJpaK34RRltmUrs0kdN87a0S0Ni0VBBX
        0J1zqqhJlfRsSfrzNydIeVIKLwmW25RnT4gqtBA=
X-Google-Smtp-Source: ABdhPJyiQOLa/az76WOjjqk0Ss4BsWKkg6TLbNTxrQuXJ2dX2MA37y0sUc931nr6Iq/ZRbIuhBlf0Z5pBGNWDgBQQsY=
X-Received: by 2002:a05:622a:508:b0:2f9:1cc0:2d50 with SMTP id
 l8-20020a05622a050800b002f91cc02d50mr37139949qtx.66.1653864388931; Sun, 29
 May 2022 15:46:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6214:400e:0:0:0:0 with HTTP; Sun, 29 May 2022 15:46:28
 -0700 (PDT)
Reply-To: si1470267@gmail.com
From:   Svetlana Ivanovna <carenwalker11@gmail.com>
Date:   Sun, 29 May 2022 15:46:28 -0700
Message-ID: <CALy_L2bWW-abN8hHyxyPCjnmkBFQy-KEF7XFCLuo0remtqqm8g@mail.gmail.com>
Subject: =?UTF-8?B?VGVydmVpc2nDpCw=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Terveisi=C3=A4,
Nimeni on Svetlana Ivanovna, ty=C3=B6skentelen Punaisen Ristin
humanitaarisen avun kanssa
toimisto Kiovassa Ukrainassa, haluan jakaa jotain, mik=C3=A4 ei kiinnosta
sinua. Ota yhteytt=C3=A4 saadaksesi lis=C3=A4tietoja.

Parhain terveisin
Svetlana Ivanovna
Osoite: Velyka Vasykivska St, 60, Kiova, Ukraina, 01004
