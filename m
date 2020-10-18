Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB902917E3
	for <lists+linux-scsi@lfdr.de>; Sun, 18 Oct 2020 16:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbgJROdy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 18 Oct 2020 10:33:54 -0400
Received: from sonic308-1.consmr.mail.bf2.yahoo.com ([74.6.130.40]:41691 "EHLO
        sonic308-1.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726519AbgJROdy (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Sun, 18 Oct 2020 10:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1603031632; bh=Q/AmPmR0e9CXxQBYbB2SR9aRfA51ls0ZhJJ5ujjkgjM=; h=Date:From:Reply-To:Subject:References:From:Subject; b=PqGcOZ0rKJvSRCTnivMHdgwlMQkRrGKpx4miZ6nPJ73xvQYqjKeqAH2PwStwcyFLiy7l6ZfEyTXVHZLRGxazptcJ6zSd5R7gqJFlof4VLxCX8F+ExvkC5CtDwVntLebKiIPRG6hz29y0MK3s25rjjzDiEOaM7LjDidCgLTkwJp8UhJKZrXIXo+7xVUnAUwcrNKaQc3oHNKogKyPoSba+/4SqgBzjlIei84BuK7B5BLK5Qx1qrEP3k++QXd5x+Uj2v2xU3M4WCy+XxGIThJ/wYBsSvyGD57rNjGnK3x1D8PgHXgvixretVcYnOn15Vw7EAvBMQ2t/SbmfwBpbqWLwkg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1603031632; bh=cZOaYebzwup1cRw7uYhkASwqmlMRFHI/duI4124bEvp=; h=Date:From:Subject; b=SaUct65kityI7bACeiy9GEw3WVptWwJdQNM+Rn5olWz32mD0Vcw/Cq47ddG6V/mcXp3TNXvbTwHzPX2yNdMD7kI7CtjE/spZvJC9/4JZlu7Ea15dVJ/iTA5/4J91gFEy9bEnzt0OKTCOsz5QueYg5CpSOVjDrXOVKTsKkiF8L+AY6ErWojJONjBRe+1asMFLNLWvWlaYQRRGyAaHBTl7h8YBJQ1R76QxSt9f1sCWw5vPdHhlLZaqB/hnQ9ru8rJ7VlRo6/a+jagG4Vh87JZ9GiP5Yf7Rv6Y38jXKhnPr3nkmcJlDA8EeYm39CQGm/QCs5dC+BQgO1XcsjCiBdhDWRQ==
X-YMail-OSG: Bb60kcAVM1mPc2zq.cXN4re.jS3qHKXEp7AJwCqNz8P5OqWFcmDEbpwKzGOqeYY
 TYE_0etggmmfaOfFu_YYvfdsfTxF1dTCIUWaX5lXBJPaBXmkHkPMyBwvu6_.ielPSKoW7A794bMA
 dtmMOF0_4EPGz1xHSo216hG5827NU7wYiXxv9C.A7YOCSo89ERcd5Yf075jbivMMpMXEwOLOFyU1
 CFU.9gw3K72DnA7AoHlf28gwNEoJ3mcYnHX1wYUg_sEhTT1UKKZIQYs7Fmsmjak51Oh3_O5RSst6
 1RvPpV1ybjmrO2Z6CRIsBY1lV.XrZTObaP848YBV5yhzTTGarI24M3xBkM_B4eGnzpqG_AjggwrX
 eKecWaqe0rLUJJJO1CzseZrozNIzQ3ljj1mKJldI1_90.ONyYoWeSYCsiulu3Pk87H4PTO2.YzWm
 3pPMpgXEB2.aAVoMKAyfJdE_rnZEnwaQ47KW5lXMsD02tuWqEP5h1dDGrQsyf1BocCWWHzse_A59
 _KhIaMTkK0dUOnRwwQU7Dl9ahBWS0lRVcTwvGLIUio1YV.hLPVeSfVEZWGPVf.5s0i2TsiM3N1mb
 msWkYtOmjJDloJY25_IZqPEP.9W.8LJUbrxiFHLwJkfPbUI9EFrVb50XwPy3n84XdGoUBCh.Wt6M
 f8eLWHl4i3Aj72jSAIpzEcywgMB0VzkG2F8prSkUC3f2yUwZqYMA1Udx.HUw_Qnyc5afR81SfPX7
 yrne819t2YTd4_oEL5ZY12CcjS7b2aMPSiDF1yilaNLQHW16GM.Q0UEX0HcRLzwuyvcGWDalqvUg
 UeOb.tsIEuYNKrHIXdnoJFy5uO_1b_U29B2xL8vrluH3A32GVlPkraNfFsgFDwztcC2pJ5f2bJrc
 GSGfZsrdRdCip6bXmfZhK9rusNGcNr1l_fLEmR3tizJFnxLs5Wq5O6kLdKB0NuSihayFdsiH4f2L
 Wps0ocS_5MC1zcAhhPonlNb.FYKez4bYL2eJp3A5xb0HqXRMoWiSqbqBOLNi4M2trk7OT51fEGI.
 A.UQQRQU5AVbv0l1qjbEEFvzBMYkwMK1jTF.Mx3l8q8nxIjXagF9lLP514fIjoDByti3nvYDayQW
 usD4RSBFm8OsNgzvCAViNwz2iPJYSkO0NjLcgWK5nY8NHdtAKovJh8bPHLM9NGTVpIxkgDl1BDvF
 sM2ZOgym2T4RNnZBjfS4bSCpe.KTKa1EW4bSFrpDiFKvMVRQO69v0zu_YHCJ70E95x0Ghi8kE9Vq
 J3bHIoAO1pPx3UvQW1SzIKfZjN3b.KI483gg6lZZF5HCMo8iFZO6jZlSN8YDm2N47ZeN1McY75wz
 lUmFMHK_9KQK2cJlVLL36ndG4Y3Rdf.Yrj3F8fW4ud.MU311yFklcBFhfgc3YhKfi1nfIyMaRplq
 LxNZmQVl4H1D9Wnx1p7Not1vu2clWcKmNBMoAa7KzaDUDjClxWHw-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Sun, 18 Oct 2020 14:33:52 +0000
Date:   Sun, 18 Oct 2020 14:33:49 +0000 (UTC)
From:   Mrs Aisha Al-Qaddafi <mrsashaalqaddfi147@gmail.com>
Reply-To: mrsashaalqaddfi147@gmail.com
Message-ID: <1613684402.501962.1603031629393@mail.yahoo.com>
Subject: Dear I Need An Investment Partner
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1613684402.501962.1603031629393.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16868 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



Dear I Need An Investment Partner

Assalamu Alaikum Wa Rahmatullahi Wa Barakatuh

Dear Friend,

I came across your e-mail contact prior to a private search while in need of your assistance. I am Aisha Al-Qaddafi, the only biological Daughter of Former President of Libya Col. Muammar Al-Qaddafi. Am a single Mother and a Widow with three Children.

I have investment funds worth Twenty Seven Million Five Hundred Thousand United State Dollar ($27.500.000.00 ) and i need a trusted investment Manager/Partner because of my current refugee status,
however, I am interested in you for investment project assistance in your country, may be from there, we can build business relationship in the nearest future. I am willing to negotiate an investment/business profit sharing ratio with you based on the future investment earning profits.

If you are willing to handle this project on my behalf kindly reply urgently to enable me to provide you more information about the investment funds. Your Urgent Reply Will Be Appreciated

Best Regards
Mrs Aisha Al-Qaddafi
