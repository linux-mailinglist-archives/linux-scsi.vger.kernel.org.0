Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5731157A29B
	for <lists+linux-scsi@lfdr.de>; Tue, 19 Jul 2022 17:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237070AbiGSPF1 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 19 Jul 2022 11:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238879AbiGSPFL (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 19 Jul 2022 11:05:11 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16AF25F8
        for <linux-scsi@vger.kernel.org>; Tue, 19 Jul 2022 08:05:10 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c6so12210055pla.6
        for <linux-scsi@vger.kernel.org>; Tue, 19 Jul 2022 08:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Y0glaxE2SB/+meGH7t/RcrFWo2y6tmV7j8nBVmezP9c=;
        b=YuxEtXnDOf9y9y7RXWaFFecaUb6ECgdeTspoKM76cz+5GfJuTytBS/fJCn2VbLAEu2
         dbEUd2oCeRkV2QdXONeM3qdEsbTC2u78EQVgAs986xu/Nj2hsgj00/0gyU8s6dLGpens
         spARFbciYMoNRgfCPDsNGZXVWS2lw37ay/6oft1ZzaMJS9vIsNiIoD7Ke8pPR5ommnP+
         +YhGmNoTRca9Dy8Xre06aqhSa1+t1E55EEnKDe6VqHZpeCuW5Tu/18f+IkZI2GNAK56j
         35Uae9I53n27CZxJHiYPYfE8L7su9VxQHQ1ehpXOKO7r1RlemXjpKMcL98p1yPAK9v/w
         RRfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Y0glaxE2SB/+meGH7t/RcrFWo2y6tmV7j8nBVmezP9c=;
        b=EAEItnqymNzVn8iU/KCWbWgVw0Eaqjj5oFNCGS0qktD7gP87aMtgZlqm2vatnuU/ix
         HT+0Db4+fuE4M1onIbMMOtwIIU8sOov8U+zOe0U87BRAL27cwaRe0swV4+O86hVhaBGD
         yS4JZISdmOECFAwBBY2bIx1ls5d21RFZy0oH/h3fYz2fYgA4sv6aZecDeU3Stxpp2B33
         E5Rs3AyNhPiK43zl/RAC64ckDRnS7Hk4hhYpwhzp0amD61F+k7818hL/2WFTMz2UmaPv
         1GGawD2xtEHQK76BB1/9uwCAjetdphj7d7adPnd4ylYN2Pbp/5vxbeUj5asCR/tXvJGM
         RUdw==
X-Gm-Message-State: AJIora+huBXZq/vuMsy2EHf5/8GhsgH4zVIo80XuFJYAm30DiRS9Uri2
        n+ceneHDgRSfXfxcSLitAqiMH0RgWfpAt4nayZs=
X-Google-Smtp-Source: AGRyM1uf3yk1eHH/WqIdHQN2mpR0UON62IKR4QlzicmCwbKBUX2L64S2LzlxxGQ0jUceBtmqyeAmRiHxXrhtxtSve9U=
X-Received: by 2002:a17:902:8647:b0:16c:e60e:570a with SMTP id
 y7-20020a170902864700b0016ce60e570amr14675363plt.77.1658243110031; Tue, 19
 Jul 2022 08:05:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90b:3503:0:0:0:0 with HTTP; Tue, 19 Jul 2022 08:05:09
 -0700 (PDT)
From:   "uchennailobitenone@gmail.com" <robertandersongood25@gmail.com>
Date:   Tue, 19 Jul 2022 16:05:09 +0100
Message-ID: <CAAgv-EJ0+msOOm5FTWO7o2=BdV+Sy=qVNJV5UOF+v2fpfjeK6A@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,LOTS_OF_MONEY,MONEY_FORM_SHORT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Herzliche Gl=C3=BCckw=C3=BCnsche!

Die Vereinten Nationen haben beschlossen, die Auszahlung eines
Entsch=C3=A4digungsfonds in H=C3=B6he von sechs Millionen US-Dollar
(6.000.000,00 $) an gl=C3=BCckliche Beg=C3=BCnstigte weltweit durch die
Unterst=C3=BCtzung des designierten Pr=C3=A4sidenten im Gefolge der
COVID-19-Krankheit (Coronavirus) zu genehmigen, die zu
wirtschaftlichen Sch=C3=A4den gef=C3=BChrt hat Zusammenbruch im Laufe des J=
ahres
in verschiedenen L=C3=A4ndern und die globale Bedrohung so vieler
Menschenleben.

 Die Vereinten Nationen haben die Schweizerische Weltbank beauftragt,
Zahlungen aus dem Entsch=C3=A4digungsfonds in Zusammenarbeit mit der IBE
Bank im Vereinigten K=C3=B6nigreich freizugeben.

Die Zahlung wird auf eine ATM-Visa-Karte ausgestellt und an den
gl=C3=BCcklichen Empf=C3=A4nger gesendet, der sie =C3=BCber die IBE Bank im
Vereinigten K=C3=B6nigreich =C3=BCber ein diplomatisches Kurierunternehmen =
in
der N=C3=A4he des Empf=C3=A4ngerlandes anfordert.

Dies sind die Informationen, die von der britischen Regierung ben=C3=B6tigt
werden, um die Zahlung des Entsch=C3=A4digungsfonds an das Empf=C3=A4ngerla=
nd zu
liefern.

1. Ihr Name:
2. Wohnadresse:
3. Stadt:
4. Land:
5. Beruf:
6. Geschlecht:
7. Familienstand:
8. Alter:
9. Reisepass / Personalausweis / F=C3=BChrerschein
10. Telefonnummer:
Kontaktieren Sie unseren E-Mail-Vertreter:
der Name Solomo Brandy

EMIL-ADRESSE (solomonbrandyfiveone@gmail.com) f=C3=BCr Ihre unverz=C3=BCgli=
che Zahlung,

Aufrichtig
Frau Mary J Robertson.
