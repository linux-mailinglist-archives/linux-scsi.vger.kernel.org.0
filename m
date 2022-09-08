Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01355B1416
	for <lists+linux-scsi@lfdr.de>; Thu,  8 Sep 2022 07:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiIHFfZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 8 Sep 2022 01:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiIHFfY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 8 Sep 2022 01:35:24 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E3A4DB5B
        for <linux-scsi@vger.kernel.org>; Wed,  7 Sep 2022 22:35:22 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bj12so35384498ejb.13
        for <linux-scsi@vger.kernel.org>; Wed, 07 Sep 2022 22:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=5N+aMihLorZXBHcklDfHgYNT/W4ZQvt0cLc1vwY1KVE=;
        b=FDYuhrjzupqDJY40NDtCR87PKWGjMuEV/iCUW7Vw71hTR5avkj5dgW+vUUZ2+zN00C
         LlMCFbLs+3J8c1CL4nKEY5SPVAMCRxSljqhAi8BIfhxPeaUIA4rcBZYAr154yczwNuI6
         q7+c0cdb79mU6cu41DBFT/enN+0EwDBEjGeAZLkMDNpcnBn16B9P2sDZPqa6FRYzX9gY
         osyHnvDo/d16MGYFAPIQYkRYcXHOsOqf5FET1iBVQun0F8mtkePo+oMRZ+UTnn9vmyYo
         g98rXHfgW52KSb4B3Bye1QzDsCwm53Bmn0c0j8dNjTbQ/azvO1ALlyZjNVU6BIbSWcC3
         ihxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5N+aMihLorZXBHcklDfHgYNT/W4ZQvt0cLc1vwY1KVE=;
        b=WvIm2//47bbWF4DuABbLDayV1f1y3b6uEHHkgsV4zsKbavBl2Kr0VECtuvkLcqviFv
         bK2OnHi7ZV8YGZLuzvCo6I4Z/yfCDgVyP719KjrZ/cs6qcjJ2qAP5HentuyxhhPAnwBg
         T7/eag5hkhhb5XOtgtMy4nK5p+fFviTynRICAdidlAvRxduK1xP2E/iyiOeZby2GUAbM
         9g2Ol/8JIDKdQRY3KrRKs88I9v00hXQFBJ3XVlsR8HhPC7wiqhskV4wqJ8hgZ7PEKtd4
         ahxqPz04LQAlus7NIt1e9mxhDuxF6PWpwdfA3TPxbKbiwsxUsso4kF/eA3hlnyyCoGrZ
         WOXQ==
X-Gm-Message-State: ACgBeo1gcjc2Rkm1SwDJCwzKRGjlTszQusOUIAIkAiYU02/us9z4VC/B
        bWAKwLfg2Jy4RGd2xr52JMaCEnIRp5KkjD5MRoQ=
X-Google-Smtp-Source: AA6agR6f9ganJGPnS3fCR9EUD6F+W17XWJLpchvokE0N3GHFTL+yU6BJqShw+38dQHdiM0dz0gaqHuc1cNPMmiIrUWc=
X-Received: by 2002:a17:907:a0c7:b0:76f:35bb:5795 with SMTP id
 hw7-20020a170907a0c700b0076f35bb5795mr4584556ejc.308.1662615320941; Wed, 07
 Sep 2022 22:35:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6f02:c88d:b0:22:d711:dd with HTTP; Wed, 7 Sep 2022
 22:35:20 -0700 (PDT)
Reply-To: jennifermbaya036@gmail.com
From:   "Mrs.Jennifer Mbaya" <taibaondikwa445@gmail.com>
Date:   Thu, 8 Sep 2022 06:35:20 +0100
Message-ID: <CAJvZ1T5nrs0eSC7OwLE2OqR8Aj_ufW0QO__UhXK5qSdDW_JBAg@mail.gmail.com>
Subject: Edunsaaja
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
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
