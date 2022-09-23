Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCE25E737F
	for <lists+linux-scsi@lfdr.de>; Fri, 23 Sep 2022 07:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiIWFqt (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 23 Sep 2022 01:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiIWFqs (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 23 Sep 2022 01:46:48 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A9B11E5C4
        for <linux-scsi@vger.kernel.org>; Thu, 22 Sep 2022 22:46:47 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-346cd4c3d7aso121453577b3.8
        for <linux-scsi@vger.kernel.org>; Thu, 22 Sep 2022 22:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=5N+aMihLorZXBHcklDfHgYNT/W4ZQvt0cLc1vwY1KVE=;
        b=IAjYaCdARxeBpnLFVCHEt+ImVGi/i9rDR10xzlsH+lQaSTM1WIIuHBCBFSMD+Q1Sra
         Kj9KGn79PO6pQOL49s6uED+PcAgqtM4CMsN2vikUS08sQ1OlbdVwgFMumzzLd3SjQaVc
         ZqoXAVi6EsiENuxThNhxrqGzCYwLcB6paDRQFVtLLI/zD0pqBaJYdzGUikk1UolhgFUd
         XsvNHMlzD2AAhQz/CulYiLcz9Rmu/5d0bWDiInQZDQWUkW2vawOnjLg3IcQ3wmx0LnQe
         TxOT5TredSkin9EJe/HBx4Q3yj9XooQ/VdgN2C2nVIseR6M16+Zmt+Wc7C+aufT2edHW
         rgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5N+aMihLorZXBHcklDfHgYNT/W4ZQvt0cLc1vwY1KVE=;
        b=mx2XSFzi/T6ah5mHt4SIaJq/gxvbDNY1dgZkB73z+DzAjbrGcRj2lfI7WiQ55q61rY
         U1sJ7bYKyFcvwXlXVflvLoxrzAui3Lv5vVNaBYeJvtKUapWci44wzcBFlYxz9xQjtO6s
         Pqz3F3cbQ+dcsnJirCs/dvGuKjn/jFTlX8nC/TqbbK3K0cPoLH/fxDQwWlwz4YdFzu1f
         +lyUAVFRu/RYUZhzKN7/B761tLc5Rsry50bx57JgzHmgEJR6oJUVQcOCG93qcEjZmT7h
         orO+0zhfr0XoHbsZRuWoj0/VjTY/oTwl0383nySX/Dp4ujDva6kxuaJL4YScX8cfpM8z
         vDQg==
X-Gm-Message-State: ACrzQf2mLvCws/CmTnWju53PbLpv62tRpfsdEuefu4AxNmdRkgMN9A1E
        vS7kLKE1u++cI+4/YyKZxI8UEhfswjB9B8Y/qR8=
X-Google-Smtp-Source: AMsMyM77/pE/0GEuNTJgf1+rM7a3IYtnotQQycy4TgadqjWXPz1pdUz4vu/04Tvl5D4YrDyi64wO/xTvXpxI19FxgEc=
X-Received: by 2002:a81:67d4:0:b0:34d:835f:4ccf with SMTP id
 b203-20020a8167d4000000b0034d835f4ccfmr6181125ywc.518.1663912006798; Thu, 22
 Sep 2022 22:46:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:6c2:b0:3bb:bdee:dfc5 with HTTP; Thu, 22 Sep 2022
 22:46:46 -0700 (PDT)
Reply-To: jennifermbaya036@gmail.com
From:   "Mrs.Jennifer Mbaya" <issakak65@gmail.com>
Date:   Fri, 23 Sep 2022 06:46:46 +0100
Message-ID: <CAMwbs2C7aUwDq2mHBNbDY75EbM3dFpv0jJ8kCObxepZrsB5R1g@mail.gmail.com>
Subject: Edunsaaja
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Edunsaaja

Nimess=C3=A4si on palkinto Yhdistyneilt=C3=A4 Kansakunnilta ja Maailman
terveysj=C3=A4rjest=C3=B6lt=C3=A4, joka on osa kansainv=C3=A4list=C3=A4 val=
uuttarahastoa, johon
s=C3=A4hk=C3=B6postisi, osoite ja raha on luovutettu meille siirtoa varten,
vahvista yst=C3=A4v=C3=A4llisesti tietosi siirtoa varten.
Meit=C3=A4 kehotettiin siirt=C3=A4m=C3=A4=C3=A4n kaikki vireill=C3=A4 oleva=
t tapahtumat
seuraavien kahden aikana, mutta jos olet vastaanottanut rahasi, j=C3=A4t=C3=
=A4
t=C3=A4m=C3=A4 viesti huomioimatta, jos et toimi heti.
Tarvitsemme kiireellist=C3=A4 vastausta t=C3=A4h=C3=A4n viestiin, t=C3=A4m=
=C3=A4 ei ole yksi
niist=C3=A4 Internet-huijareista, se on pandemiaapu.
Jennifer
