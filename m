Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1D031AB0B8
	for <lists+linux-scsi@lfdr.de>; Wed, 15 Apr 2020 20:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441534AbgDOS3d (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 15 Apr 2020 14:29:33 -0400
Received: from sonic311-24.consmr.mail.ne1.yahoo.com ([66.163.188.205]:41836
        "EHLO sonic311-24.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2438068AbgDOS3b (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Wed, 15 Apr 2020 14:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1586975370; bh=q1Er/SdqxATomBDx27mJAnsQxxrJWpCL+Y8MaW3053A=; h=Date:From:Reply-To:Subject:References:From:Subject; b=dImB6k3ccmHwodx99e6lIi2+3UiEHJj6LIq9eVFcMP2AMsiuAx9CTD4R3Gf2Dp4NmOzOOQtiqlYWwvqaw3zazTEIB2384SgQil7/P656R3GMiKQzfRDfS1eiME9Xosz4Wewu/bNzMzYi5JcVxlrLcBm0aVBv0qQT4hCmBmrbXH5JRWhj7Uo8uOwJEnPy2uUApimMmDvNMfeob7od2cPKz36rQe6C2LaSsoFu9QtRMDgI6LQpmz/TgWx9zaAPW6dbMwWB3WsLWX3WOIgujZWeVV/uk2B4GwhpXNOdoejjb15vdgl5E61Jmgurd782qM2bKZ+dPSj8jW0T7L4fwMpE9Q==
X-YMail-OSG: lPCBFw0VM1mkNlJ28w3TFgpJ4IvWwDOw0b098SaaK.FPsDnv91vKs6H92mPwrL6
 PM_GK8ibnq.XbOUc1MbKF69xhBrhXyuisVct9cyF1XPuV1ydor6Bi1Di6vOAUR3k29JBDEEtaD7U
 H.q28jAOIC8km9TRTaAcQe4wN0Hkj6HzpHF4UH4GI7iSH.rUBJaeigZ9gTVoQM6LnJ2q9kMvo0_q
 wEIXVezF7x1D3lSJyojHNYt7TNLydrJ7Z2IIgEUq7_SSvwHPJ4He9vDINPF2rPDlmvhYuHX8Bqi4
 9MGq5UP5BYgTm8UD_ENOxjH5OYBX_OhVW1CIb1Wb8glvcYW8R62_lletVoTDP1QG543tYnbBMA0i
 6.qOfsrV3R5bTwaMhZjE7SKLTBXznN6xfHzNxrq_KA6GI8kozXrZMuSnzblyOpRuHCYgetBLxsed
 ZXVE8aZobxyKBdk6oudx0X2YpVJBpUOIhl1sdmAY0dah7Qe27n.g46hRqPugfml1lsQ8TfBGxxYh
 DhjbziR1IQPOe2yFcNrDSn4bxMjf_Yk8srLhBhm6sOVcCRtIxTx4D_.ZJCaIkXAxmIYEJ39g6h.O
 dnIAxEbphhSKA8xir_1srVXweROpm7saumJ7APx2qLW6wze90jbYPMcz.OsYUbawBzrNbd7k1.qF
 X55vJ25OAyKSUbLgZyWLORkp5OmfvMCaEBAGIin5.cWvaYbXCcOzM_OmCmcNUqrGSxwQErE_lDTF
 tJStg.GyqJfrmIwnw07389HhhmV0Uh8pYzpvrNR4PjA736BuqUPigoqoxgqkIap27MnDboSgphKm
 toq75Ynh2KMKV07Wn3CEa8_nMUMt6HFsCMRshuV1Q1EtdbUdVY04EnGujnyGkkHbvW..hvHQgdXH
 2G468GlzZ8wYqDt6IbJsF3LzVQKzaPzkQ0bz_ACeY4o8ubNJYz4uIvPrFcNp8MtuNelJWdY8cbzY
 44tLGZeQDfj_Ral969RO27WxGHje.Skm.k.42IgFeJ4I7mXdXEuI.MJcoa5iewNwY7c__QYMffdr
 pOIuL4fuheno9iG6ptQbfgTEKbEgXhvIRVu1sffLvgi9XoG4JcvqW_HD_ImtpEMD2COqOiSUjn7k
 xQ2aCNqeiwEYvFj8_iW5wo3mH2zeELF_ymfjAvivmZgFYPvJfk.5ZEHwHihXFR3b_kuA4hS7a_OT
 ljAb6ONGlY.Z0jYkSjMEPTvhMs7tfKub9duvgL4tBrXfx4_G6zSuQNZDUdy66ZTTA2KkL6067arv
 L9fu3ZHcEuxxLVTdEANzZlL8gB0BBJN.sfCsThEJ.Mwl8LTTweN1Tu_jwFExlWburQqP.B4KuHSk
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 15 Apr 2020 18:29:30 +0000
Date:   Wed, 15 Apr 2020 18:29:26 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <mrs.mainaabrunel126@gmail.com>
Reply-To: mrs.minaabrunel30@gmail.com
Message-ID: <1682919916.1098384.1586975366396@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1682919916.1098384.1586975366396.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15651 YMailNodin Mozilla/5.0 (Windows NT 6.1; WOW64; rv:47.0) Gecko/20100101 Firefox/47.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



My Dear in the lord


My name is Mrs. Mina A. Brunel I am a Norway Citizen who is living in Burki=
na Faso, I am married to Mr. Brunel Patrice, a politician who owns a small =
gold company in Burkina Faso; He died of Leprosy and Radesyge, in the year =
February 2010, During his lifetime he deposited the sum of =E2=82=AC 8.5 Mi=
llion Euro) Eight million, Five hundred thousand Euros in a bank in Rome th=
e capital city of Italy in Southern Europe. The money was from the sale of =
his company and death benefits payment and entitlements of my deceased husb=
and by his company.

I am sending you this message with heavy tears in my eyes and great sorrow =
in my heart, and also praying that it will reach you in good health because=
 I am not in good health, I sleep every night without knowing if I may be a=
live to see the next day. I am suffering from long time cancer and presentl=
y I am partially suffering from Leprosy, which has become difficult for me =
to move around. I was married to my late husband for more than 6 years with=
out having a child and my doctor confided that I have less chance to live, =
having to know when the cup of death will come, I decided to contact you to=
 claim the fund since I don't have any relation I grew up from an orphanage=
 home.

I have decided to donate this money for the support of helping Motherless b=
abies/Less privileged/Widows and churches also to build the house of God be=
cause I am dying and diagnosed with cancer for about 3 years ago. I have de=
cided to donate from what I have inherited from my late husband to you for =
the good work of Almighty God; I will be going in for an operation surgery =
soon.

Now I want you to stand as my next of kin to claim the funds for charity pu=
rposes. Because of this money remains unclaimed after my death, the bank ex=
ecutives or the government will take the money as unclaimed fund and maybe =
use it for selfishness and worthless ventures, I need a very honest person =
who can claim this money and use it for Charity works, for orphanages, wido=
ws and also build schools and churches for less privilege that will be name=
d after my late husband and my name.

I need your urgent answer to know if you will be able to execute this proje=
ct, and I will give you more information on how the fund will be transferre=
d to your bank account or online banking.

Thanks
Mrs. Mina A. Brunel
