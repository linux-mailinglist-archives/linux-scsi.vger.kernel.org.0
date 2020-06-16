Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13BAB1FB5FA
	for <lists+linux-scsi@lfdr.de>; Tue, 16 Jun 2020 17:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbgFPPV5 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 16 Jun 2020 11:21:57 -0400
Received: from sonic301-31.consmr.mail.ne1.yahoo.com ([66.163.184.200]:45610
        "EHLO sonic301-31.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728809AbgFPPV5 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 16 Jun 2020 11:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1592320916; bh=+NKq2YP/4c3bLm2HmGhxa/KCZOXr0NIUKHs/ECuC0yk=; h=Date:From:Reply-To:Subject:References:From:Subject; b=aymRjPg3PeNLTGIAno02I/WarFLs7D4WiilXkq12YhRaPJZnfPmKHHOE1sZD8sYleBAgDF0ka7s1exogGR38jl7Q7hXL3cpZDXnIHxV7Tc46Nb44UtCX/a7b+5Qw3dbCzG4uLcNWSShRFzlkCsT6zvxmkHoBDECfjYrXJDdnI14ihaYucC4YQiQ+pq2Ovy6Xis2WZMX3TNcTM6Q+OiXBmiGvPtNHxwZb3rk+MRQ5vKixTxKWkKELPXDRU9w7HuEpz0rQCJLDgkSYwIXs8yXZZGu70MYH/uZaoUYKacWLx6vwVtEVmtQ3LcWvG+WRspuJcEAjrQaxG3/kUvUrguGHiw==
X-YMail-OSG: IiCeQA0VM1nRlcQuSCu92URqXFp_QwVquW1cdz_oG4ub7gbyhxNVi3M3W5rUAM_
 2IQOXYaZK21WsETPbS8E9_HGxD9TC78TtsYKchtskFxmde0hMX4S6Mbo58iK_grX6qRWMR1sDSFv
 XtIVKqDXCb7WVjY6zsJ1WomBAWkfCjMhdva6ql_9CCvmBDr4LeNqaMoN_fsBd1XV04.PY0QpGVVU
 5ycz2ySjSaNrGsVBZTdu08kemKNKGdOoBPYgifbzf88wIGyk_UtqwHm1.DWfq8xiYDwSDbB5jDDc
 D8JNUK1HkhvmdI4oVQRuUusrJWdy.uN4GbvmvTEg2YqU88y9xCd4S514hB0EwerldxeleSsjVgf7
 gSBaWvYpPV9opv_8nUxizvFElmnm2gyUgHJIZDkfNWr.kCiIxpfhH__riDQlhNHJAP9JoIxHksEj
 xdfcqP0C_84PzMApZbNJEkBZnbAFg1IXwkkC2muxJ51jqn8vUvjJmIRqj5uO.Cn34LFdDPRibliz
 EXINiGz4EF.Nhdt7t_7QT1sLcj3XwMPz5XMDQh4c0KKH6v40nFD8.FC2UstTq2U0EdtV106ADLTs
 Yk6WFrHoetOhOWSSECw0t1tduk3XwJ457QFFdjetu.h929zRdp0yVjQG4L5dyYWmsvgAt6sGom9o
 17UFGNoDb0hP3iqF7.JB6Zj8nq0cO1yHXf8Wlv9TOOlqwbLh_L8QIcqc6i.HF0HaIjrHbAa0bZbe
 .jV2S1hBiQ7C1RouvwSTb98dI7WL6d0qRfungR8XjA1jV.hRchKtkJ_.cyhhbPnFRdPFw71QUbyJ
 wyzz2lgaoyESTKIRjJdJFMc1q5Xy5PaFnZuOA5uYpO9J_gjDS6Uug0GUf7FeME7TFcyn4cQ6ggsQ
 _8t5242LRVf6Hd4DUWB3tA4WoIqFcjJm_sA8DMt7zD3wzU_Jds.EncMTXQDOv7ep8ZPwkMZzVSvn
 5eEN567IpsGX8kaTlngkTHW6S7cYUntIQv.MEYSLMbRMXKOBixsMCiMfTGYoLGfX8xE9iCKaK7Bf
 FFuFXUU66X7ypQLm9Z4Mw5lXcqKwIYnPJleYYiH.Ps3TfVV4V_.YCqfqr0C6.eZ6x.VbLbpKp0rY
 RyyFh16LwWNnuC5nby4JsvIAHKbfhspc4ourt_p9Y4V1KFx3qy3rbEcNz4Mey63zp6M1LF74IW_G
 jtkNHAdNyNiJx_GgZuwwWKdTiBPOrTdIzIz3WX6Yn12XR6isieP64FqwKp7Qd4YRRkDBWmbZNg7E
 32C3Mrh6Tryo9i2WvfQIMG0MH.Rv_LjurDuYryZML.0mCc8J4PXOvvBZy3tPCfJmQCxRHXg2j
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Tue, 16 Jun 2020 15:21:56 +0000
Date:   Tue, 16 Jun 2020 15:21:54 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <mrsminaabrunel224@gmail.com>
Reply-To: mrs.minaabrunel2021@aol.com
Message-ID: <1988505819.1652546.1592320914939@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1988505819.1652546.1592320914939.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16119 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:77.0) Gecko/20100101 Firefox/77.0
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
llion Euro) Eight million, Five hundred thousand Euros in a bank in Ouagado=
ugou the capital city of Burkina Faso in West Africa. The money was from th=
e sale of his company and death benefits payment and entitlements of my dec=
eased husband by his company.

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
