Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7953D291027
	for <lists+linux-scsi@lfdr.de>; Sat, 17 Oct 2020 08:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436965AbgJQG3g (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 17 Oct 2020 02:29:36 -0400
Received: from sonic301-20.consmr.mail.ir2.yahoo.com ([77.238.176.97]:32986
        "EHLO sonic301-20.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436749AbgJQG3g (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Sat, 17 Oct 2020 02:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1602916173; bh=815eJ56VHnklTDk+DCOG4XAfdC9czamW+ZJP9hVvUQw=; h=Date:From:Reply-To:Subject:References:From:Subject; b=XOxGgUQGfj2XdVwCLN5nugU08oZunnhLgHdc0jf2EzqSuu3KSaRWKWOcmiHOyFWs1gzRBvkDJlAKekvCJHC1wmJ/x/h/V3CSJ8e53pCvQROfJdWMFghNZj865akb9mb4DW1TEvzidFDZexhOfZLU5lU7BbA37zGpvls/dUKkAJCEsIhHmy/RMIaq2PwEX47Zd/UJZ3fkPfUAhAN2GjkATC/NyIbfWQSdKaUOantfKXDqxPcbuHfPl5oDXYIviLzRCM2Ux+fSAf1HNe1Pj2vPkvIc/Z6msICetLe62moUDNDl++GrE+9aP7R5guLwo1vubP7HKeLqy62jCFkl1RHHLw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1602916173; bh=rXIfuoqmzca0eMbNYity36C0RVhAg70w5i2D9cdPJh9=; h=Date:From:Subject; b=gG6RpCRU+q0QR5KFWAdWoiOsxZ3w6TWl+3jumio/EdLnTmJ2a1QlMduzl0CEnlHrkNL6pHrqY4fW7vevnQVVJsW0GENLJZHfpglhXjORTBnoFxhq+Wat7If39JJhJOn2Ng5jhCyPzwmHLPMC3MdUiU4Js3rlltvXU/I/yq5S8Nv0jvWxmMwVEHr5lKMAVpWlJYEpKkiLIWcuJ9s4uUAYmflitBSYfQxYf9GGWM57ddWWF/HgdmbDxBRSyC0/nnLHT/rjOGWZrgIr4EOBTb+/CkESL/i/aM8NCgpQH8jeURagack/WLB5EbYn36jU5vUycqFKQP1Xqgo/ESB9MloN2A==
X-YMail-OSG: 5iAH3fAVM1ntzZsZ0ZXT9dAEWQeOOFwNZw8v7GAVvtrqxkL7TWBUBhDngGqpWYN
 yXrWFPsdrRjSzPsCNQtSpizfRzHvZBv2LGxZ7glEXvlu.HHgUMR6PH0xITZcC7TE_8bopMs0tD8Y
 TvsLLB6CKdw3Wjbbk6E52cZ9rF9mehvlVtGNw412oEqyA_YgRpw8r1WO1ZgzGdOWk8.Nq16hwf5P
 iqZ.depmqn7HRPc7C9SrVkR52LjcpCkPvD5.ddINJ364Sk.ay.qTEdo9YLLAQtGEqdKHds2RuS8A
 imuu_bwB0iVMHHaharOgtA_AKEeiACNOx69r9TMWmyBnhcOIWqYOzoe0XO024JZ65WPmTAIBjKIh
 VH_Pm6u55P_3WgfgaJHo6UTqE5MfKZAQk_qCP9UhYaWTFd4r7w11cRTm7_yHoRr1lSD8bjJ5SDCt
 hAMk4YtSqJmNR5jupmKHCHR9CJZkmy48r0AyB6TPcsZT9.mMvibTGQheMe9dwArJbruGrBBaIxJq
 XDfrmHSrSusndFapxog35QeQNR7w8zNhls3Jt4nXpBHpc.BlfQRWx2WIDUUJPGI9Fn3e777xr6pi
 zt61J0aFMImMH_X4ZonrUO8p79aiE6exrvPgyl35yB2ov2u4DUqwBbe3JU4HzQ9RyP08_vD5yUvV
 AhoXPR5HM1JH0j3FOC9bHUqfd6xodpzsSztNxvu7QcB63DSogg7YoGiOdiOJhWFzC8x4nmcZOr2l
 4Hui3MLHc1hZYyo0ZpAFlZusSgrs05CAHCPjkrkMJ_xTDGAFycjDGNQjrZ22qLero027YSj4K10i
 nJSYoAoiiFND4pgri4XF95LIhsaFhTDAB3UZR9O7S5cRIpaDZmWC302Wk2H9ZM9DM9sw13g9l1tF
 5FXgW97ei3WdR9QcN8m_51HVF10N9HVvURSIXywPmf_H1aSyfnreuGKLNj4vfzHr.EvN41psWa3t
 zDomAqvJK.JlNT2eiVYrKQC5NfJgVTWUnPt8jP66UBHQvrd8jZjWdYbBOEPsJlki4tEk2UOgR2zc
 4mDuso00pNy5RpX8fnvhQH5vyz4eFhFf9P6fLz_2Vy1iC5vQPK8fablHnCQkju0LDYsCzHPbyJqG
 go7gt6k7MDJdoigegd2hLqMgPPu_OkmScV7Hr.lda5iJyzfDym6UXCQ1wGSF47PLBw7XlB7PJcCe
 skhMUCfII6qmY34rkUT_8CYWf5fE1WUEfbD2scetyKi9xjnkUrE3LLmrCUlvEAM.JSYSzUsLcVpd
 YVVpegkVVW0ODlXPKNVwHktLin7uylDu.qmzvc2l.sis5sOOcqQf8QFgDM33YN2zgmB.WKnvWm6n
 15LCYahvaFM3fEchjbVCsbQe.JKl_wd67K2Wmh0yvKJ5iS1wUjrPuJ_2.eTx1DcKyL84PqoxHKKZ
 2odVNjWGdgcRS0cIMiW90D8yIr3HdzTnx4lr6vMz_
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Sat, 17 Oct 2020 06:29:33 +0000
Date:   Sat, 17 Oct 2020 06:29:32 +0000 (UTC)
From:   "Mrs. Barbara Roth." <mrsemailcontact1@aol.com>
Reply-To: mrsemailcontact1@aol.com
Message-ID: <857866243.602427.1602916172816@mail.yahoo.com>
Subject: Dearest beloved in the Lord,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <857866243.602427.1602916172816.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16868 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.121 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org





Dearest beloved in the Lord,

Mine names are Mrs. Barbara Roth, I am a 66 years old woman. My beloved lat=
e husband is from United Kingdom England, while I am of a Dutch nationality=
 by birth .I was born an orphan and GOD blessed me and mine late beloved hu=
sband with abundantly with riches but no children. I am not a happy woman b=
ecause i have no husband or children, my husband died 21 years ago. Right n=
ow I am affected with cancer of the lung and breast i also have partial str=
oke which has affected my speeches. I can no longer talk well and half of m=
y body is paralyzed, i send this email to you with the help of my private f=
emale nurse who is typing my request at China cancer research facility.

My condition is really deteriorating and is quite obvious that i may not li=
ve more than 3 weeks, because the cancer stage has gotten to its 3rd stage.=
 After my Doctor Notice, i have decided to divide part of my fortune by con=
tributing to the Charities & Motherless. I don't know you but i am contacti=
ng you with the hope that, you will be able to carry out my wish for the sa=
ke of humanity.

I am willing to donate the sum of =EF=BF=A110,500,000.00, Ten Million Five =
Hundred Thousand, Great Britain Pound to the poor through you. I have also =
made some cash donations to orphanage children in Somalia, Syria, Ethiopian=
, Cambodia, Philippines, South Sudan and some in South Africa and Europe.

If you are willing and able to do this task for the sake of humanity then s=
end me below information for more details to receive the funds.
1. Name...................................................
2. Phone number...............................
3. Address.............................................
May GOD guide you.

Mrs. Barbara Roth.
