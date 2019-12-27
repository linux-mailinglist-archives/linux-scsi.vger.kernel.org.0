Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5959312BAB1
	for <lists+linux-scsi@lfdr.de>; Fri, 27 Dec 2019 19:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfL0SwW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 27 Dec 2019 13:52:22 -0500
Received: from sonic311-14.consmr.mail.bf2.yahoo.com ([74.6.131.124]:39864
        "EHLO sonic311-14.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726379AbfL0SwW (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 27 Dec 2019 13:52:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1577472740; bh=HQ3z5tGds5I8UDOuzw6gLX/0GqSgFm6dnAgm9mfhuxA=; h=Date:From:Reply-To:Subject:References:From:Subject; b=XKCxZMN/24u4om5nwm68z+gRhlqjv4otxLKJkDpEsM5QT5Fz7Na1/t/2oT9MNs7CCRyL2zfrfyHfT7SUpNPzDWEAS6J3mqnBFcTSOz8Q828Cz72VcXffeCXv0G3SaaVKguYTxyAnXKsQf+ptg1cc4/F59SqOKTALN9CD1jHueTwq3wtyaphY7ohXykaX0Q5bEFci+vBrDWLh+B2ZtnUX/0QO/moxB8V/EJLvOTdtSBKr3pFtdW8au5K9EjMN+zwNlPhgfGXJaUmxdudfEhU6tSucg7hTscHnVI6vRhZkigZg0vpO/q78q1AMNkPudXgushLcWYG2AbMzcW7kN7zZGg==
X-YMail-OSG: OHJTgRYVM1mgGyNGgLuUq2Wl2d_CoWQU7E0IqQTZHJigVUapPycqRF63ezHvaX.
 UmIzXSRn9zptqZEaHbTEVdNtSVJmgrG3wx2c_Qj_r25O.oK9PW8n.wV8L4aLVr24Y6qk8d_zUrZx
 RGW_TBC2eKdFYnChNJqRcLAcBsVVi8X1gQ1EKr5S_UV03_fmsn.jUT4vpnDB2KzQtEvW08oPBSop
 syYF_WGdnhB7Qa_KZuQa.oYKerhgz4zkD5jYJ_0CPSWiBcMEK..0xdDruIpS83qb8JNzJBmUjmlY
 stnEQ5MfPidkg0u3Z.B.cZlvbPL58rjFxL394z9iv1VfpnEGeb4nBqp60icB_CGoocVYjto3eibr
 NVCO_AghWmGeVlSWUvGgMogw_rqwqmd1IJz0_.O3N591g2lbWyC1tK228rkk1LiZQ2.h0gzSAUlv
 U9v9ZHzNgDW5RDE1KxCjXnCkJ5MpgSz8IW3Utp5dnCOGIEnZ4TpA_FoowTGNAkfBAVjfhwTWPseq
 P77PF8nEJH1WCUca7Dd9eLsilbu0JmIv85PfVr_h5eVYItinJSHsmmijY4sgDsU2D9ZdgSBM0ZDA
 2Tt1o7yZs_m4xA8CdX0FrwIpmbTH1zqmj4k.U1FczmpefYFINJ7P9FXrUq3KIncvJTKr5cZcGTvV
 .bX63XHPwdAZ80hnaifaHNDYOpzndRWuQDmMbLINLyoJcSUZ28SqKFHA98A4kjEeSl7ZQfPZ4Epi
 VyUFa4vzoRF5hZQzN.m_gQqAOas6pHJBAFjSpsi43RAqEI4Imb5EAbROM6r.fxx2.jaMJJRGcSIi
 SeKlOiMsCeICNyLXAk3JwA1Kbdk367Fj81Aucp68Mrl0xc11jE83w0Cj1KRoBAbIiqsLWerElnMX
 pXDimfe8aUnRAe5573_9GEdb2C6Lemk0txhV6IgpsMz9HH36ktzVw6tD__fcmlJL8ku8EBhYE6iT
 GySt1P.ouceMJa_o7QdFFApXTB5NL4e2f0xPCXWNeGoitSDcdIqCZUwiRghcjdvQw97WCi8hdlym
 kRQc5.SmgS.PBG6XPJ9e2BzAlSLj6ZAP2hskd3r27BS8pj3aXQ57GdNqUIHar8wcQr_7s5Jr4Nyb
 SIZSIOjo5.NSZOvtPc4dtxQ3HBvgJ_loHrsNep8m_ab7K6MGQHJTaqIaOZwHckNw8yhMGupX1qzx
 wpHI3R7_YJSA_gVA3w0PMvQlnDzccpFHX4pE.KApIK0xjM5I_A3Zv8PTm.P3FntAybz7iRK63kvu
 Hvw5sl990hYf8BbambZ1gvYvcl6ELXj3RrpCZW_LJw_vSp4XcI6xIE2p5Gbvx6mW80.gYuGLuJlb
 TwppPg_1_AWpB4qfnNTgO8KQ4V5_nAqVmSuEG0A--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Fri, 27 Dec 2019 18:52:20 +0000
Date:   Fri, 27 Dec 2019 18:52:15 +0000 (UTC)
From:   Rebecca Williams <reb.williamsfamily@gmail.com>
Reply-To: rebeccawiliams505@gmail.com
Message-ID: <973272801.2684845.1577472735507@mail.yahoo.com>
Subject: RE: Greetings from Mrs. Rebecca Williams.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <973272801.2684845.1577472735507.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.14873 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:69.0) Gecko/20100101 Firefox/69.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Greetings from Mrs. Rebecca Williams.
Please excuse this humble email if it offends your sensibilities, but I hav=
e no other means to contact you. I cannot talk on the telephone, so I did a=
 search for your email address, which I found on the international business=
 directorate email data search. I am Mrs. Rebecca Williams,59 years old wom=
an, A Christian widow who is dying of Esophageal Cancers. Recently, My Doct=
or told me that I would not last for the period of Seven Months due to canc=
er problem, Yes I have been touched by God to donate an amount of money Inh=
erited from my late husband Mr.David Williams to you for the good work of G=
od on Charity" People in the Street and Helping the Orphanage which my husb=
and derived this money from his vast Estates and Investment in capital mark=
et, I decided to WILL/donate the sum of USD$3.2 Million United States Dolla=
rs to you, 30 Percent of the total money is for your personal use While 70%=
 of the money will go to charity" people in the street and helping the orph=
anage. I will give you the contact of the Bank Manager where my late husban=
d deposited the funds for the releasing of the specific amount, I will appr=
eciate your utmost honest in this matter until the task is accomplished as =
I don't want anything that will jeopardize my last wish.I nedd your urgent =
response from you as soon you received this message for more informations. =
Please contact me in this email address:  rebeccawiliams505@gmail.com
With Regards,
Mrs Rebecca Williams.

