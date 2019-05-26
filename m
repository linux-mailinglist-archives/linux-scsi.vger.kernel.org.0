Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21B852AA89
	for <lists+linux-scsi@lfdr.de>; Sun, 26 May 2019 17:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfEZPuc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 26 May 2019 11:50:32 -0400
Received: from sonic303-21.consmr.mail.ne1.yahoo.com ([66.163.188.147]:38568
        "EHLO sonic303-21.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727833AbfEZPuc (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 26 May 2019 11:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1558885831; bh=FCjWGTqDRXQUUN8ivg02MDhbiDKrvltOcpc7W52q/3U=; h=Date:From:Reply-To:Subject:References:From:Subject; b=T9SiYVE/+e684xrir1uAD5huInVTIu3noskssfivURKoyFmwqMTyqVEFdiuNfcHvbYzGwIXxQAXTOE25lp0rivBjyTWaWoO18h42EL0uYf8M5z4seCGb+cBJSCQk0qVr/tljWCD2Ie8TLwcHrLDfSLYRO/QEeQQZRrndA1WZfHBvx7pMWSoOhk12K2xk8iDBrRD+ZuTqLu3VwT57HLQsWghN74CGt6zgbgt2FswHR5iPhgfMSwTHGA2thKY6wDN5vVmh/rAHc2YDYo4cEJVpoUZl5amzStXdcEIar/uA4Nahmr/4IJLrO5SzVrr++V4ij2CUS6EshjS0lTbXvfZQtg==
X-YMail-OSG: dCBqoPAVM1mviHuKBikZ.YFEr9tbFl1IrkSsAOtOy751U.PzEq88xcnfsAgxCA4
 Lm2psNrQAMKjajzlrhtjLTMD1CSkzYtrI8AMZ0iGfZt2n9Gm47R0vCTSbzZj5foXIGWMU4eYQ4SW
 90a8T_IpvxHZEj4wBL7zG_zu_TWWxikjim33nRJ_l1VI58fSKGsVKse26pWjzy0fHMtPsUKuFFFt
 8C62rmZn0OKUin60cnkcQ3kYwsAzaHBHqlH1p_kcpc_Wld4zdeRVR2WoMgEPysHJKGDaRtd6DxNq
 eUqgKlA4ACeFihnEYugwAsnZODKBbUTyQs895asalRaTKBdvpV1.5OiOnBIX9MwSAlJyw01TBl5Q
 GSQ2IWOroer_rQOei2Jagci7SYduKGAirH3SXkv3v7Ox6Kts2cHQZyCAUAOVuzLxHkkYrEohQ_SV
 shxUhKQFefksEKqvH63BcLD99_qrITceQN7cGQADbZGIgNeEOyEMIo5rAFY1hzUsXlkXmHrZJ70X
 IqIGLPhFl7BnjF4iroo7Q1AZ_.o._hwNaDpPJuc5dx4T13fxZOvHWidjNmPJ9eG3yFjoh8IipEP4
 E.sUhH_sfYppkjX3MfWV6FsMibpg0Y7FgdhEhNWgZwWvc8OlhWhXU5mKz6pxqkWL_Yop4dOcdl1s
 gLdpcEvGGf9agBGSOeup8TgIyaj.s05RaQ5C6YTDGMt_ZQ.7KBp9Rt5tP2p21gd7a9h5VDx4SU3d
 PYicbllrRBkcVaFw4yeqIebJ_3YfLWi8rJU8TO396MucqIVIrs1HTEBYUFBLmvu3tzOCi6dAqVv8
 iPNIee3ougxopT.DARMMp3BTqLZoPIKh0D2vwbl8_0GeQ.jb2axrTzbGU2Muqe.xNiLS1ULNjGq2
 DJcQMb_iKn4Zyg4p2Hp_LAqEEqOxYwTtLphH2eSBqOjy8liUJJCort_MrFA5t0QNc8g52IGdhOIc
 A43w2Epj.ZRKcAjfmwGJi4BK6WoO8xawVglkdM7.FL5VW8dJ4SIbXZlRLdAgOTtkaOjGl1iY3xhR
 39xf693Z99epwAncXbMDHPcAEHforPLQEifwC6U8v9yLQVGhFyQAmFkD3js7vuxC7P.EIqWz.otw
 XUgJRF8TTLEVZGFSlqhlZTEj.l6.RseBZ7L_aqBrnffAk12rC12DV.TFIgEJbAdRSaxuOsxxxs2m
 J4zcnKqx9qng4dCOP636scNwNnD5kJQIxsW13OAzJaEIVipM5UTEo3H0-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Sun, 26 May 2019 15:50:31 +0000
Date:   Sun, 26 May 2019 15:50:27 +0000 (UTC)
From:   Ms Lisa Hugh <lisa.hugh101@gmail.com>
Reply-To: Ms Lisa Hugh <ms.lisahugh000@gmail.com>
Message-ID: <184186040.7829528.1558885827206@mail.yahoo.com>
Subject: URGENT REPLY FOR THIS BUSINESS...
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <184186040.7829528.1558885827206.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.13634 YahooMailBasic Mozilla/5.0 (Windows NT 6.2; Win64; x64; rv:66.0) Gecko/20100101 Firefox/66.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



Dear Friend,

I am  Ms Lisa Hugh work with the department of Audit and accounting manager here in the Bank,

There is this fund that was keep in my custody years ago,please i need your assistance for the transferring of thIs fund to your bank account for both of us benefit for life time investment and the amount is  (US$4.5M DOLLARS).

I have every inquiry details to make the bank believe you and release the fund in within 5 banking working days with your full co-operation with me after success.

Note/ 50% for you why 50% for me after success of the transfer to your bank account.

Below information is what i need from you so will can be reaching each other .

1)Full name ...
2)Private telephone number...
3)Age...
4)Nationality...
5)Occupation ...


Thanks.


Ms Lisa Hugh
