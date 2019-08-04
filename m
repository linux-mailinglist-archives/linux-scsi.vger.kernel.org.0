Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABCD80A6F
	for <lists+linux-scsi@lfdr.de>; Sun,  4 Aug 2019 12:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfHDKd6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 4 Aug 2019 06:33:58 -0400
Received: from sonic310-42.consmr.mail.bf2.yahoo.com ([74.6.135.216]:38554
        "EHLO sonic310-42.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725941AbfHDKd6 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 4 Aug 2019 06:33:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1564914836; bh=HXEhLH7CRxfsXKJ1sRQ+Gpa5M9xjOa2TrkLDufu5AVE=; h=Date:From:Reply-To:Subject:From:Subject; b=YA14iKnFkjQgkVHbeuvvqqocrCh8C9f236Fqflnot93jfnXxuKSARjg94UWIQsvTuXsAOwCOUkalUgC2V1hUvYJtoLECdPcMR5v/ohcinsMOEDXxt8vgV7WJfxTKw54y0HMqNgczuQCd6PTNDTACW0uA+T+sxDNTD96iwldH1LepiPjpTzhkCLlOXz0i0/hTDmOrnHFOLGmH9aLXH3aprid1LxvGqt3+wba0UoYFnrbw0tha62qj7vbDKh5h6qFtcUYjB9R3JtSGXoUbhOqeXfXioSgbd4mDw0X4QpilcdCqlcCQmWj9/xDybKs1gX5Y8uCcAf2TkRcmx/fjxMMiCA==
X-YMail-OSG: pOTfQHQVM1mgO1kw5_oEXtSFavDFzhdyWxXBJ8rlPlIkU.9OrxwwCYXTQo4GQRq
 lGNYkQpb5mJiiy.gBS3WRKflt7jyjgdt5EKFSUd9QobIu0JMFCxse3Hu9Qj7yL_cSL5lvzJgISLz
 LBw6.F3i3n9FTx3iNLXl81UnSEB0vXUg5TYOymVqE4jIEhFgEfKcf.yjT_vmVnZz7v5noEzsgHtT
 zKtZXzdZtkrOlAhVb0yykFlfxK.4NHAdxct9dXP8USpK8xYddepNsriG5XHR3U6kjwyrkMuks7ik
 AlZOPL4rOOaSeDPo.0fctdda0tJbh9BboKmTSLwcOALu5NiWBzD32ybos_gJ1qitRo7YjbI0356D
 14U94Z.MIRtKW2SU1cssO_7N2IyDi9r_astZ2c7V.6g.XPY1CiYTN6osz4jBj7lFzyJBainY.7Zu
 MKeNJ68Ytez6K68IrfVk0IM4dlXfXJJ0_Mnuhl4gpxCqtIzUVImDL5fJ_Wif4VGQpNrJlu9n0Vat
 _HIro1bAvW_yWs6Ujz3NBsTJb64Lj4YYwp58VuOJeNIqzy9w8ApMAd.FOFuVXM1UA0_RcbqGATz1
 bixtsuS_gMVBXkXaN53HORM9Q.mp.Y0nBy5egUBQLPD_perMk6KzXX5eSFHBb5cuJ__r.i_9RqBu
 qw2Y7lX.hA5kL1lj40Hauh4VWWoR89R5bGCTefNh13DSyvPVBbhLKUUAK3TJNkAS2P0N7LGCxWZM
 jcR..DNSOCAgu_5nxksapRs1nyXuN.ZblPrq731ZkHfiALOgNyY3JYg5KNeaNYLnHert9FODdzXp
 eC2gAvdDbncLxWlgnAYT3E9DkBO0Sf9FVfLSEsZLepZJ9UVEOXcGB.3D_OjGYqgJtKV7gGsemG_4
 HyRzea0w7wQQYNcH9ScsekVZA2rumub2weYMLA1izlxfCnOBVyXjaaxrXwb65sAt3r7DncxUJ458
 6eSeYj6KOnsvSoO.VHwrF7tuWJV8ZHDluZ25fA.S4DaxJv3NXwrZkrtkj7wm2jE7Pnb5.OvPIbjM
 RpZZ7tTmmWebEcaE_ltRFplAhLn61FKWoWom2KdVfHQeyyiHTbIuuJDsU0SDq7PmXEe8JfT0g6DF
 fRiwfE93BbgnOVlbMNpq1sIEudKLDo.41.3nB7KxOb1D2ktoz0EgsG0tJvjsyndXnWRnuTDaiXIF
 wL4jGrxQglXibqBlPQXkzoz8xQFPZnvOxykX8BPF2TZ04pgNvfIxz11nHnUZJOVYfihruA7vENx2
 VDs3_qWRAeYFXRP0Lp47ePg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Sun, 4 Aug 2019 10:33:56 +0000
Date:   Sun, 4 Aug 2019 10:31:55 +0000 (UTC)
From:   "Mrs. Lorita Thomas" <lvthomas@posteo.net>
Reply-To: lth63409@gmail.com
Message-ID: <327733550.836657.1564914715688@mail.yahoo.com>
Subject: Hoffe, ich kann dir vertrauen
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



Hallo Herr,

Gerne schreibe ich Ihnen nach Abw=C3=A4gung Ihres Profils Mein Name
ist Frau Lorita Thomas eine Staatsangeh=C3=B6rigkeit von Kuwait. Ich bin ve=
rheiratet mit Herrn Vincent Thomas, der neun Jahre f=C3=BCr die malaysische=
 =C3=96lgesellschaft gearbeitet hat bevor er im Jahr 2012 starb. Wir waren =
viele Jahre verheiratet ohne Kind starb er nach einer kurzen Krankheit, die=
 nur von Dauer war vier Tage. Vor seinem Tod wurden wir beide wiedergeboren=
, aber keine Christen Diskriminierung jeglicher Religion.

Als mein verstorbener Ehemann noch lebte, haben wir 8,3 Millionen Dollar ei=
ngezahlt (Acht Millionen dreihunderttausend US-Dollar) mit einer BANK,
Derzeit ist dieses Geld noch bei der Bank. K=C3=BCrzlich hat mein Arzt erz=
=C3=A4hlt
mir, dass ich wegen Krebs die n=C3=A4chsten drei Monate nicht durchhalten w=
=C3=BCrde
Problem. Was mich am meisten st=C3=B6rt, ist mein Schlaganfall. Nachdem ich=
 meine gekannt habe Voraussetzung Ich m=C3=B6chte diesen Fonds der Kirche o=
der besser noch einer spenden Christen, Muslime oder jeder, der damit umgeh=
en kann Person, die dieses Geld so einsetzt, wie ich es anweisen werde
hierin. Ich m=C3=B6chte eine muslimische oder christliche Kirche, die diese=
n Fonds nutzt an: Kirchen, Waisenh=C3=A4user, Fl=C3=BCchtlinge, Forschungsz=
entren und Witwen das Wort Gottes zu verbreiten und sicherzustellen, dass d=
as Haus Gottes ist gepflegt.

Wer dem Herrn dienen will, muss ihm im Geiste dienen und
Wahrheit. Bitte bete immer dein ganzes Leben lang. Jede Verz=C3=B6gerung in
Ihre Antwort gibt mir Raum bei der Beschaffung f=C3=BCr eine Kirche, Christ=
ian oder Muslim oder eine gute Person f=C3=BCr diesen gleichen Zweck. Bitte=
 versichere es mir dass du dementsprechend handelst, wie ich hier in angege=
ben habe.

Ich hoffe, bald von Ihnen zu h=C3=B6ren.
Sei gesegnet.
Dein,
Frau Lorita Vincent Thomas
