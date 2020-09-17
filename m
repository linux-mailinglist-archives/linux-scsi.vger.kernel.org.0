Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F044A26E37E
	for <lists+linux-scsi@lfdr.de>; Thu, 17 Sep 2020 20:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgIQS0G (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 17 Sep 2020 14:26:06 -0400
Received: from sonic310-24.consmr.mail.ne1.yahoo.com ([66.163.186.205]:45750
        "EHLO sonic310-24.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726489AbgIQSZt (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 17 Sep 2020 14:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1600367148; bh=GzHQZhZRIsgl8MOTKujcKIKEI3cAMRVvPTGBZUZQRCc=; h=Date:From:Reply-To:Subject:References:From:Subject; b=WTowMEhlHbKmwx961KrFqttslY5XgHGBOuLVkIYGnKWkS1xP6h2vMnbq1PkBMYpzWvkm+ti9f+vziyTvEKwE1rn85fJD7lHJS5jxnQSxTQLwvdxYV9/J+w7cmom5SlV3a64bIC+tfyW4iD1yeiwgyPSYbfC1ke2YQtoZaglM374TGIwL5f01OkkPs9J6EwaUmNJzIXEMKQONfwhei38ziBfH02ePVAd6n9N+3PJh26QpvcZ+GLRw8SQM3iFXeCkyPofqro2QoceaFM6dUkQ4ZHMuIEEBh90X7BetZTTpchRw5s80mdOV8BxTG6n5y0L1UYQ2JeMrkMJCYy+a3VLb+g==
X-YMail-OSG: V8GkspEVM1mMV27pO6qRlcpN6qJv_YWqimF4b4qgDzTu89wF7uNZu0WlARvnHJG
 ypO1znUX4pLfBvL4lPkCrb3fCT2_99hTM83tSku_Huyj0wtc9kdAtgKJcJRxm.S4hr1n7NwBh5vR
 UZ4oSxdW_DtI3.l6_el.BpQZOk8.UA5tm_dtmYSnV8e4GU2ZubpJbQkMmQWmtvshgmbZQNsSqIMZ
 5ECz1IYIUQBwOE3oG9GRSHUvEh7WA.8_5nFXfRsjH0ehoX4u8Z5k1eQ5VmpRQS1kT2jCy6XAwu3P
 R6fdgJM8C0YM38u2tJauF0LD_m81F9xb_WQ1YjOUqkGhUaziGAaNpZwVdV38UKshR4EXjiXuZgF9
 hayBVqr4_64mXCthKU1DV3O778DCOHYrDlNc4s4hT8meLbk6rXj_bWkiKvf3kNQ8zhJRGIuyt1hj
 Xoha28X_nMM6Ehb9cb.BcZ_GIuwfxMC4co5OmEFjQ4G96LQLskqYCWWUZLhHwzjtA_ecOrgBN.Re
 C2GCTncDc_ww2sm3NH9n39o6gPsITgnYy0zf009ICIZjsVNNR68txNvqOq8L_yy9RGVxLX5sXQ6P
 UH0x3NQ80jCsKZvdts8d3RERRCOUvIjf09Au_k2XRNNLS7y16CCSRdLEsABc0xyhouZlRJLoRxpl
 0t1N_cnaPzf8wJnf3GV5vGJ9G9RXYgojv2ANChB4x04poMYHqbFEtw6ypgwMwmAHubjHJLfW1Png
 WV_8jV0s.uKm5RSvqbVM2bj5Fc0uva3wr6VKyH6hBfhFw9Byvu_Jp.ngYcqeMf8OtDkWtAcCDPGo
 eLk8HNiHKreVt.MXDH15L7nLnvunnSr.TcveZLxWiMyjLLxm.lf5mCCwPQJKYtz7UekGoOw7iTZa
 SOMgwwR8Fa5Fq8g6BVX7W58pmHdGZlpz29CZL8JIdPSgdW.9g3Gq.tH0wHZyphAxNrZBZ51mNNj5
 gSHRtyP_qoKZPensnKYNzhRHlLFrue.Lpgm1tqBR3SLqzxIlB29IWoh9lqnFrVsopqXvYFYTFuxu
 3avCuAKDZe0p13AodilC8MOB9BAPZul2siXTBCmAeHftQh2ZrLgEv8eaDDx_vtQuqOhZhIDoPF.q
 rQNV6kO_io4FvM3ExSgEmUqytPpORbHvnxFJ00bLJ3JONLv01LlPwdCFx.xCVq.4Zlngxvi89NI9
 a.5Yst4s3Ngc3hOfnlBfGeEPiAO65YPYlsWvA6YFkoKSsu6gHhVm1U0S8MiiM49Z4BArLA8McuuN
 D.upsrfhz6cjonUDKnZt3gTmm3Fg17eEypHc6GT3Op_CaTKI0VpcUDkFxfxgd.XYRTmvZ_dGfADA
 7o8IQaz4qjHs2yXQEa8K.iTLrSCzzBDAaL4GLXSr3SOlvI6Nwk0mxcXCRD_qhU_4387KrXSyc8mx
 5vYrD8a5rzfAFNYgunEJ5yAvc4nti6OPvG4mJEwrSuNPkrxFHhuRY1Pz7lRnRbUJLoFlnYum1seE
 IrdOZYhsGZ8jKDH_V0VTfIw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Thu, 17 Sep 2020 18:25:48 +0000
Date:   Thu, 17 Sep 2020 18:25:48 +0000 (UTC)
From:   Ali Shareef Al-Emadi <alishareefalemadi465@gmail.com>
Reply-To: alishareefalemadi465@gmail.com
Message-ID: <1846803491.3562174.1600367148183@mail.yahoo.com>
Subject: Investment from Qatar
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1846803491.3562174.1600367148183.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16583 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:80.0) Gecko/20100101 Firefox/80.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



QATAR PETROLEUM
P.O.Box 3212, Doha, Qatar

Greetings.

I am Mr. H.E. Ali Shareef Al-Emadi, Finance and Account, Qatar Petroleum. I have $30m for Investment. Contact me if you are interested; I have all it will take to move the fund to any of your account designate as a Contract Fund to avoid every query by the authority in your Country.

I sent this message from my private Email; I will give you more details through my official
Email upon the receipt of your response to prove myself and office to
you.

Office Email Address: alishareefalemadi465@gmail.com

Regards.

Mr. H.E. Ali Shareef Al-Emadi,
Minister Of Finance.
Qatar Petroleum
