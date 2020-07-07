Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865B32166F8
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jul 2020 09:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbgGGHCw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 Jul 2020 03:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgGGHCw (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 Jul 2020 03:02:52 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7899C061755
        for <linux-scsi@vger.kernel.org>; Tue,  7 Jul 2020 00:02:51 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h22so41477846lji.9
        for <linux-scsi@vger.kernel.org>; Tue, 07 Jul 2020 00:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=/zhnxpk2dcaV2Z7RgZhMmVLscfiLb1Ab4yTT4bhzF0E=;
        b=RoSMxnh7Y+K9QsH5Val8BkexZYBj1aQzdodvlLDRmPm9syP/HUDgCe6disy7joGbNI
         MgS32VxECijhy1pawpvLI99Va1RziwN+C9cHD9HB72P1BmCVWz4Uxm0KxrgIoYssz20u
         NHrhzKfIhz21bHMw6x+rcOQmNTSQ1lOMlAOsrm4jF6xhcqsgC4dTTvoacc6dWgYka5i1
         VvXdwGEwJoe2CcAnmnegGYLLRRfcYKqHpIx4S8ns4sTUaN+08gAtO6BXGWWMXDUceRyI
         Z7rnH66xmg2GiuV4R87U4vGtLGBH2M1IXetx1gnWjQdNQsvHNeCmHlhHLvsOvHxpA9x3
         uD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=/zhnxpk2dcaV2Z7RgZhMmVLscfiLb1Ab4yTT4bhzF0E=;
        b=M17P6wzvzwLRt1y6h4/8Ttfr3rwApdeLNpx5vxGvKPlnUximPWKuH8j4rwdA0KPEBc
         j5JKLfiWdjI244DVRMCXU92/YhVccUNqjR1IewEWXkKI2GehNrIaE/4ouXZ9fBsJSI/o
         SaOU2T9A/Lm29qOT0SITNXS6SCHDi36uxTYOv48D+aHFVayXcVgQ74wQtd/Jk5Qk1Qid
         6Umvb5oAXUhRkL0Vt48IrKbdHi+HuvhqMZDvjxAZhSYCH4dacYYLPyTbyijZhpWLmGOY
         BC4M/YUqnWS8B5Q99hB0YvHc3sAzuP2+RBOfRwX4rx3ypoFBqVXVJkilerr19EgnZEww
         FXFQ==
X-Gm-Message-State: AOAM531f/1LlC37eJp5HV9xUTcrT1d36jvFsGdG6IyHy2WsA9qSJTM8G
        PDWt66Rt+udtwkPknoO7McWKWpAM9pLyavHm/EQ=
X-Google-Smtp-Source: ABdhPJyyYFmClQpg0REkgBk/QwfJcm1jLtuUewiYSA6uS/hCrvVe+XO46aRseponZCSby8Isg2amlN92ffwm1OJbqFc=
X-Received: by 2002:a2e:9855:: with SMTP id e21mr25934197ljj.424.1594105370207;
 Tue, 07 Jul 2020 00:02:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:5f4f:0:0:0:0:0 with HTTP; Tue, 7 Jul 2020 00:02:49 -0700 (PDT)
Reply-To: mrs.tyttikorhonen@gmail.com
From:   Mrs Tytti Korhonen <arckingsleyp@gmail.com>
Date:   Tue, 7 Jul 2020 08:02:49 +0100
Message-ID: <CAEXL3m_=eQeKzOncPppUsnfwA2GZTR12knHgUy_Fjz+JR1oG6w@mail.gmail.com>
Subject: =?UTF-8?Q?Gr=C3=BC=C3=9Fe_dich_sehr_geehrter?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Gr=C3=BC=C3=9Fe dich sehr geehrter,

Ich schreibe diese Mail mit Tr=C3=A4nen und Trauer und suche Ihre Hilfe
aufgrund meiner medizinischen Situation hier in London. Ich bin Frau
Tytti Korhonen, finnische Staatsb=C3=BCrgerin und 83 Jahre alt. Ich war
eine Waise, adoptiert von meinem verstorbenen Vater Engr. Pekka
Korhonen, Vorsitzender / CEO von Pekkakorhonen Oil and Gas Services.
Nach dem Tod meines Vaters =C3=BCbernahm ich seine Leitung und beschloss
auch, nicht zu heiraten, weil ich sein einziges Kind bin.

Seitdem leide ich an einer Erkrankung der Herzkranzgef=C3=A4=C3=9Fe, die mi=
ch
viel gekostet hat und aufgrund von Komplikationen jeden Teil meines
K=C3=B6rpers und meiner Gehirnzellen betroffen hat. Erst vor 5 Tagen sagten
mir die britischen =C3=84rzte, dass ich jederzeit sterben k=C3=B6nnte, weil=
 mein
Zustand ein kritisches und lebensbedrohliches Stadium erreicht hatte.
Nachdem ich meinen medizinischen kritischen Status gekannt hatte,
beschloss ich, Ihre dringende Hilfe / Zusammenarbeit zu nutzen, um
mein 14,5-Millionen-Dollar-Erbe zu nutzen und Waisenh=C3=A4user in
Erinnerung an mich zu bauen, wenn ich weg bin.

Ich habe diese mutige Entscheidung getroffen, weil ich keinen Ehemann,
keine Familie oder Kinder habe, die dieses Geld erben k=C3=B6nnen, wenn ich
weg bin. Wenn Sie interessiert sind, nehmen Sie 30% des Gesamtgeldes
f=C3=BCr Ihre Hilfe und bauen Sie mit dem Rest Waisenh=C3=A4user in Erinner=
ung
an mich. Wenn Sie interessiert sind, kontaktieren Sie mich bitte
dringend f=C3=BCr weitere Informationen Ich werde Ihnen die
Einzahlungsbescheinigung und die Sterbeurkunde meines Vaters zur
Best=C3=A4tigung ausstellen, bevor wir Sie als meinengesetzlichen
Beg=C3=BCnstigten f=C3=BCr den Erhalt des Geldes in meinem Namen identifizi=
eren.

Ich =C3=BCbersetze meine Nachricht nach Deutschland, um Ihnen das
Verst=C3=A4ndnis zu erleichtern. Sie k=C3=B6nnen mich auf Englisch oder noc=
h in
Deutschland zur=C3=BCckschreiben

Ich warte darauf, dringend von Ihnen zu h=C3=B6ren.

Sch=C3=B6ne Gr=C3=BC=C3=9Fe,
Frau Tytti Korhonen.
