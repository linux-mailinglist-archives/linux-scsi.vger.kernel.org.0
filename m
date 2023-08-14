Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D4477CA9C
	for <lists+linux-scsi@lfdr.de>; Tue, 15 Aug 2023 11:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjHOJk3 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 15 Aug 2023 05:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236143AbjHOJkL (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 15 Aug 2023 05:40:11 -0400
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Aug 2023 02:40:08 PDT
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309E8113
        for <linux-scsi@vger.kernel.org>; Tue, 15 Aug 2023 02:40:07 -0700 (PDT)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <lnx-linux-scsi@m.gmane-mx.org>)
        id 1qVqS6-0009Uv-K7
        for linux-scsi@vger.kernel.org; Tue, 15 Aug 2023 11:35:02 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-scsi@vger.kernel.org
From:   deloptes <emanoil.kotsev@deloptes.org>
Subject: Re: SSD SATA 3.3 and Broadcom / LSI SAS1068E PCI-Express Fusion-MPT SAS
Followup-To: gmane.linux.kernel.pci
Date:   Tue, 15 Aug 2023 01:35:35 +0200
Lines:  470
Message-ID: <ubedo7$151n$1@ciao.gmane.io>
References: <uba6vj$10n6$1@ciao.gmane.io> <20230814162028.GA176555@bhelgaas>
Reply-To: emanoil.kotsev@deloptes.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart5399117.uRT4B2qXSz"
Content-Transfer-Encoding: 7Bit
User-Agent: KNode/0.10.9
X-Face: &bB+dG6r\D$gd^NFeYm<f{n8m&2W,Lr'h>#MNOHtI/(z<->Su~)mL1rYXAE7W:U2d;tQAEP  ?3('tC@:iV_x)~3Kq.-X\\j1HU;i6/u\An"y=\gO%d`v#QdRgaw9JySH|xOp&6giT2q+z3j<t`[9@b  _&-<C%rE*@-)n9uI5?P_u9`8x.@SeM*h,'bBR~v^^XiU[Y&\/L6(jEpen8eNtlhu!p)GYOW6Iny
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


--nextPart5399117.uRT4B2qXSz
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8Bit

Bjorn Helgaas wrote:

> I don't know why that would be.  Are there any hints in the dmesg log?
> Can you collect the complete dmesg log with the old drives and again
> with the new SSDs so we can compare them?  I assume you have good
> cables?  I assume the same cables worked at 3.0 Gb/s with the old
> drives.
> 
> I would *expect* that SATA r3.3 would be completely backwards
> compatible, so since mptsas worked just fine at 3.0 Gb/s with the old
> SATA r3.0 drives, it should also work just fine at 3.0 Gb/s with the
> new SATA r3.3 drives.  But I have no actual knowledge about that.

Thank you for your answer. I am also confused and couldn't think of any
meaningful reason. This is why I allowed myself to bother you.

I did not change anything - wiring or such. The server has 12 disk bays on
the front. Old disks were pulled out and new disks were inserted into the
bays.

You (probably much knowable in this matters than me) also assume negotiation
should result in 3.0Gb/s. And if I understand correctly it should be not a
driver issue.

The only difference I could find out for now is that Rev3.3 introduced PWDIS
on Pin 3. To check if the cables provide wiring on P3 I should disassemble
the server, but I can do this in September :/ and it is a lot of effort.

I am attaching a portion of the log and dmesg with the relevant information.
I see that ASPM is disabled by default (could it be related to P3?).

Thank you all in advance
BR

-- 
FCD6 3719 0FFB F1BF 38EA 4727 5348 5F1F DCFE BCB0

--nextPart5399117.uRT4B2qXSz
Content-Type: application/gzip; name="dmesg.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dmesg.gz"

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
cfsBozHdOJK7AAA=

--nextPart5399117.uRT4B2qXSz
Content-Type: application/gzip; name="syslog.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="syslog.txt.gz"

H4sICGas2mQAA3N5c2xvZy50eHQAxF1tb+O2lv5+fwWB/dDM3sRDUhJFGQhQTzIv2U6maZxpe9Et
DFmSE21sy5XkTNLF/vc9h5ItWaI9lO3spsXEcaLnIQ/PG8lDerC8J4wT5vYtt88sMo0znzxG6Tya
9skfBL5oz3Ns17L+JIsgJhS++vi/6NE+ubl+/28kWy4WSZpHIZmkyYxcUnJpPSQ5/Bsk0/AfAzMG
SWmDwUWGPxilvO/4bPwnyV8WEaGMBFM/ywh9poLalBoTMFdHEM398TSe35P3z3k0D6EXd/59Zgxq
aUGPKBeP2g0Gf0Mu4aFy8TjXERwkF4dxbauPJxeHU7bJwFglF9vy2EoutJILA8kwYwImdARpdA9Q
DKniBP70eQLCPlPf3D+Nsbm1A9uuYVsFNpifMbZFd2DLGjYvsHmHdlu7ZBLUsFmBzTq0294hE16X
Ny2w6cQc29khE47ynkUzxA4dOi7x8aU1Meew7IYdMb6hkK5GIQNqMVNDdSzH0RHUFLLqhF91wp90
6IQtmoLiPV7rhNB3ght3wnabGqQItJ3wqk54tEMnYCh0HKXfycglI5fcHKwtdb7dkyF04c9MCQRt
EljH1RvBpI5AK3JZiVx20Ru3GUSA46h64zYDbUGg7YRbdcLtojeu19RNa3+9cT1tg4+nN1I0W2vX
9UY6WpE7xomBoLRNUBtTaWkIbAhY5gTNJKEg0I4prcYUnPKECHsc56YjK6jbjC32rsHono4I1tJP
u2fVDCDUCAuSEXNhtUOY3bNro2FvyQNN8x3Rjl92z6n1wDvQD4l2/FIE2uEW1XCLDn5ItOOXUzcK
nx6YLQtIl3UEB2XLAvITHehejkc4LS8mjhpPhGBNGYut8cSpxtHpMo4uaxqsOGo8ES73dATaTthV
J+wO8US4sukTxN7xBMCaUVwcNZ4I6TT1RpZ6wzmQUar1YNTcdLzWpEf2WI1AN2PrRtCStyyVpiDg
BxK41GnOOWXp5AsCXUTsRMCaaxRAYNcI7IMJZNN2ZenkCwJd0tCJgLsbdsWAY+V9kM+R2ml5FwLP
0hG0puVRYbRRB4N1LboLuz5NlGydkEjWPSFxLbaLKagzVamPhL50Z9qMLZtMVt3RiYrJnSimRRp1
EN7musOK6KDI6FpC2/q9XKhr64Uewl8XTRwMb65JMsd+n7EeIzcXVxEJo6c4iHqE/CtZksCfFz2K
SJyTb3H+QH4AxGjkZ4vZ+SRJg+gH8+Y0PDpV83kgJeM0Du8jkifkj/ESbIQZj4LNm8uoCpSsIL/F
8zD51jSSDqEZGJrrhXoGjVpJpVbmTJvJHK98SRT0JRM6X8K7+BJ701nxbb4kLDoQdvEl9ub8r4Et
13aH2PYKH16uLbyb9Tl0R1c43aCjFZ21L53LdXT72aWzOTtbgX0/tek2R3NFcwpF7W0Gx40lAcm7
DnSLwa00qYsZiGZitoVBN8CTyZ4DLLyNVMda296Ysz6jti6XggTcMrY9lzk6Ak0CHlYOJKRu9wgo
N9cxrF3qtYdWSdGYSVBnm1YZL4bDzKGpVc5OJ1uXUTcn623mPPbGQFPBdAPdZR/F9ZinI2g5WVyb
OlPfjPcjXI+LHdh2DdsusG3zIfAsrWBa+yhBsUcD3zq026Y7sIMaNi+weYd22ztkwuvypgU266As
zg6ZbOyjBJVCwktmrpCSthyq2GZPdgdQRwe6xUuvRNPBjsDJMCMGnYA6WSxOPepMzrFds2SbE3Vn
u2seV50Y7+GaJWe2julIrllyV787r1Elx7zNsjnQ7s6Brsuo20Bb1oYliCr/DSMwPj7RDLTVIf+V
1mZCJLYOdLDOKSaFsnboxKZdiLaLLjiCKm8pKfbJW6Tl7qKrTaz9qkvjOl0HJrmdiVexp9xPRvsw
x5bOduyNSXvVixC9bMdJu7Q8rQYcNGmXtqMdA5gmgqZ+HL/NiP/kx1M1i1ZT7LE/D7/FYf5wCpCz
GG1+/AJ/75CPd/DXzwzenj8SP98oJyEngb9QIMnkH1YNXU3La08L9fgb4+Z7zXm5v81rCGNBO81y
lQJ0SwBa6UwXQ3Nos0RLz9DW/5B2M2mnuWO9k+lIhu2UizcjJXhF7IKirvQzSOaT+J5kCz+IyBwi
hR8EUZbFoB7GDJtJmbuuQIN0t29RW7f4irmNsbt1HKkj0MRVvxobeOl2GRuxi6PySmWBiN/FK4nN
Cp0VdjXpN53xA5KtQ9LG/b3m+tJtWkOxXaozYsgRTrLlOE/9II+fcMEvSMLI2F24mm1ye6tlr+Te
xd5c2tz60TPotKebZbusucGxqy8lC7X8SfmbAyXJ2jvQO9itSLEHE/dI7O1qhF3s46Lv4bH63t4c
38EeFuOLvvQ47GY6XGgY/I2/GntKx0dsRbuGYmcrgqoV4RFb0cXaatFtsopuR2mFs7FqIo+9jyZd
V0vQWpYpi/C6FOBJd3OPTm7L+SehXe2j2Xvso8nG2p7cmu6HduUU7T320aTkO/q0kZLzisnqvo8m
5eY+mjxKSi6lFnSv9XrpUa4Dk3vn93Yrv8cCmI38HmtMtuT3slt671lS1/r/p11A6dnNsLN1+Vga
65BnNz2pfvl408S7ZApeqxxt9wJ1zSjsbjmJVy7i1BJ/IILx+fL1egCpfghO0BDL4wKMeHBxc1UI
+GqeR2m6XOTkM+rfH5+//DQAt311+0tGbOISRgljhNmEOW/IvxuzWJhJ7GR5dwwWrP/cyXJxBBYb
Y/JOlssViwU8+7JgtNvJ8v4YfcHavZ0sH47AoqaRO1k+HoPF/V5fPh2BRWD5RcHy/qJP4jXLcj6e
JsFjZDof80TVXkSKnqL5Xihrnf/P0fDdqAd9p73hu9uPvfcXdNQnH2/en8Ps6hRIRhfXl2/h2/AC
3hFCvXU5uBvgT6ahDgjd3YRfMwhmfkbGCU5Rh5d3QIMe+wFCHoQHSP/mGWaAyRyi4jwsOm4atj2X
a9cBn+59Px1D+I7yHCPWiv/Xj4MyUB2JoAIkfgg5R79MY7PzOPknuPbT5Nt8/RqHMjufJ/NjsZeh
JEjmeZpMySLptJ5ToK+wpokfmuuZenR4MbyCDGmcvWQ5RLF4HuexP43/7ggzjcd+7pOnKM1AC4gF
eUzZml4nnPeXgwtyDbbza5T2EaZnbMbqedBcVFeV4YBCE0hTCPgHkiZLVCIzLCFs3HJVWBiTAz94
iEaQNkWjDCSDGonaL2xI8PLIUM8BFMvXI8lVQp1FKcyXbgfXZLycTKK0NuHzomA14fM6JBFIIL5P
MPbHbnl2ZDzutM1hShD4bEUw6UzgGhCE1Lb2JcCKj+8TrOsRX4dAWpP1hFpaXSkcPJTysIhy4IDZ
xPX11c+YfUbFNskpUfGQnxJ5apozbmJa4IxmCz/18yTNTonFz3AdG496MMkkJdef/oa/WGKYNISX
NsIHyncmS5g49MkQJhRgVSEaUu0XJM+Cs8hPpy9m0BITnj/Jrx+GfXIZZ4/kr2WSQ6QI8ftI9ISp
/5CYB6yA8OEzZfUQ4rIHkqtZEMS0NI6yPnEA7SRJQxhQELdNPVE4AsPZmRRUVYvMF5DWzG8KR4WO
1/RxhgtZpcMuZwqlYkXVQk20UivsAhlH0XylkIaeHXm8Js/NFB7FEH8z9V+KlhehE9TuMiM3X25o
QBk5KdaDjAVi4aJ7jYmtV2aoTccHdMHCOeIW4FAcBOxtAy69d4CbYfvj49RzCz7OvA4AZluBnaLh
zmEN59vx+UHAW3UkEMFBwPZ24EPsR50F2wIcFqIODxO12I7PC3zrIPytxhOEdoHvHIQvt+OLAt89
CH+7jYaywD9ofMVWG5WFD5DeYfhbTWmsSubw7P5B+Fstyiva79HD8LcalscKfHYY/jb7mkTFMlw0
iQ7Cb+t/udQXVZVt+FLFWciJpqHalh9He3C1bWHFFVVcUcm1f5/cts6ueIq096x4eWDuoEqUtvEI
tuZxD+5P20bWY8SqMWIH87R1ed2fanzCo+iC29brkmtSnZQ6PL+z3JZ/NMrveOf8zqGbo8QrT8A9
5Qm4f0hPVLHOJv5r9cRiKnUnRZW9Cc2Y0u40clPdqpoWyFuVwOyDUgdHuk38VxKY4JtMzqsxuRhu
VkMj4DfhzCe03POKQsP5NeCoQ00VjkFznT3mPOpMQk0w7qsJxpObPl/WfSSvfCRH53Wg7/Kk1eR6
nV65kFw1JtF9MkmWwOOV+IYrc57FMZHYWJ7wg0U8Wsz6ZOZnj32ycrfw4/MoeAmmuAywevNUvRuH
02g0h7c5lY5LGeU2mZu3oHlj0OHHJBG0eWjnuMckgaFVJv46xySRqXnX2sHH2hC0WeN53GNtyNAs
s331Y21A6jWPAB58WAtB/28OayFT0xYOPhuDoM1TEsc9G4MMTWt7nbMxnmXR5lAcfOIDQZsG9jon
PpCpORQHl54jqLae/Wil58DQvBHmlUrPkUl7WeVrlp4jqbY2U19LbA76umXDyNC84uZ1yoaBSX9/
0SE1TAj6ujVMwNC6KfN1apiQydHUMEECWezs2Dsqqs0pxC4KZ0fZtDmFrhJrTSF21EabU8hdFO6O
AmhjivKYxxYKaVDlfCQqz6CU2ZyK76Ji1KBg2ZyrdRSH1bjoIWmzVZZDbsFmx0iYLbtljVzX/n2y
WstumWEdmx85n7XslklaenHtn3RadssmbZ249skM1V7hdmx2lJzQaVmho+c4IHErjzzWOIRORntl
V07LtIW2/YfkVU7LpIVObY+VUTktK3d14tor7XFa1u3qh/uAhMdpWbl77HjutCzbPXY8d1qG7R47
njst+3aPHc9Fy7zd14rnomXl7mvFc9EyevfV4rloGb/UWeNeObZoWbrUW+P+2bWN931/eX/XJ7fR
fZzlURqF4I+SPAmSKZn4s3j6QgxLfj1LHfS5uiFxiJW62ionLjiz7bLQqU+8U8Kp5zKHdyp28oRq
eB4sRlNs9XyEZ3H8MExHilTHzIQlK2JxumpKR15cRrq7uCFRhvhxhtVmr9lRDxdDkXAMmqllEo5j
iTWRPAUNt6Xjdisfg6aVPeuTT2uSrDwcvkS1OKl3eSU8bJRqgDEPxzT16+WNwSC5p8ThNpeyY1dU
jAGKs89xri+2Ow6Pujfge9ZjeNuT5wqM7Lc3Fxtoc38G/379cvU7ybDePy/q4lHdySwJl9PIsBR6
C/4yXByC6LQRwShfAfHLh+GT3WNk7AePwYM/h+f2YmE9Krz2+ojaYPhrGaePo2U2Hqla0REeREgm
k39CKHpLn10IHHmSPBKBVkmWWRSYbMSwHrN56x664nMEDAnBa1CrAyFnjue1T6M7nQjdLoQSF6ob
hKJTDwW87EQohPb6lV8h9iSrgxfqeGH24ENEBzW6/fkaK5u3JxomUbPkdstC/ovPw3XF/inQTvzl
NId3TJFcLOf8Ol+AVuPpAqzXTf3ZJOv1TJSZ9yxmq9uzPqRRtAYICXQxSV/AzVHO7Z/MkYrzCWeX
1wNV+Lw61fnxxrg1DC9RXWP4iyjNIXiA2WYR+ZGMy4yLqBMPReD66d1+2Et1HuPj4PaOXP18ff21
QxN5DeZWbUUjlLCv35FkUqARP418ECfJHyIUwLorhiyuxF1AfxaOlvMgSaM+GVxfki/vVjXuGShL
HgW50R64AlSJwOdf76CJEzwrQomfZfH9HG/7SFLyBGDwjT6b3ciPkJKqxeconRStu3o3XLeKnBRT
MFxgMYmHCk+VM31LUtRlaGKf5PEMk4bZYgTz3OzcFmpTW0Xdc26R8RIjWvmzcaslXmdzNQfcqVLP
x/kkg/YGyeIlje8fcnJy8YYwcNIkeYzTH2fJ3A972bdxL4zemCqJ9LAcevjxivz+YVj4kcHFZzBx
cFHLNM5fwJNAKjFeKrsHVZliV0/JHH3PGCiKM86Gg8upuuPIz17mwSh/RruJ64emyIn6leE4IBo0
/qfopbjnAJ6dzSJobYBH7sug2glqUCE8AurCT8FmyA/PDvV+2AcTd1feYWEEmfovgKSOi91H8wgZ
TsbZ/RsSpvFTlK6PftGeXZ78Iicz/79A0blDzeWBWQVMxDI8GwKJQgrjlCz2aTnWOW4ABZO/ajjk
pAwBpk2DQAs+dwgd9+FtCZ16y8At0rL/p8Qm6pYBdf4GQ1mKGt9JuWxOcdG2XJfK85chxTB49RbP
91gTSU7i9C9yTuxT5aVHY38Zwo8MpiqUviFxRnyi2jQw5VOrbp/j+fKZ+PeLex8SNHX8dYIXTD3R
HqOWORTY+id/fg8CDx77BIw+Vec2H1bvKR+TYvYI2eFJHsM70GQ8UQSmmszDDAtp0nvw5PC2WL9r
6gkgd8OitlkE3fDjkASzGV7HxmmP91xychtNIwxtl36Ox4+Wc/IfyymIq6x8hLTt/fAOZn7UaH6k
+NRVLiu+ksvBvm1y3T0syZfkCbmY07d433L24OKy4Mp8LD1yey6WF+A5y7M0MJm4FCi4qTFb5Bag
rC2WCxhnSMlodWjTFM/D6wH9h3oyqT5zrnYO1BDKoni2UAM1+HRxhW/BDyAwYnGSTZMc9KYwNyLI
x/EiU9e5kHi2mJLh4G6A0wzD+I/M+k5Mpv49TtrVyu88+Itk83xC4ino7WJGpngf2zSBlwuyQEcz
Xc7Q35qc4lK06jBlFmQxeUgydZYPmmD6sLDrD7NuD7uqZnr1MO/2sPTqzFanh2260Wy728MMSzz8
3IfeXn69vv5X1+d45+c89Zy153N21+fwXjJ4DmZ/hQ77z+QrZL5vmWURf+ynZIZVhT9Wn+CoTICs
PsYRfsb4wDxTQo5b3TXFX910PBwOlfLjQedT1GlI32ASj4ubGd4Ks6qoNeZxpJZnm2nzpmlb+1k2
RASqJdZbNkSs++1mTYIgINmzyaxXcauPRlirutNN1QWqwvph0fFht9AjsV2PHMZ/rPYbKzVSNz0W
asSlOZ+l+Nz9+GRnPiy0+7BUAeb65q6YsZZZKAQcu2f0AVkV1EU1HQnUdMQ7A3WU5DOkuhdJCo31
8WoLU0y1UFBr3nAwJJ9gFPdsosS6LAjZ2Ms+ZLQB6O+VmnCo7GqMaeZyYYQmcLHJ2dANdSVVmHyb
k5PhMPdz3L+AJL+8jAJcikmCYvWYB5M9+8+yeSA46DSjQr4n78B7XuANV/EU2hxl5/9dNj5J/8cI
GjJvqT7nOAtwCWAS4zT6bnixcWo8gNnXuBimPrEEK+7Jvf70tymFh8n9RgW44tus/q6+GnXgFvp8
fyICKRrF4BDyXM/hjLng3YzKwYvm4E676Xn574OCPCwcIbGKL1kyybGyPycTP54WsyG1DodV/zBH
Dl8Mxh0/mw36Juquyu1rdeCUfPh2Gz2dU8bU9uTDKblBF3/OTsm1//zLOce7a2DidM4NohcQWxZl
eHF43TDYfobB3B4T0sH6jwLkeOrLeQ8/oxRX848od+70XMnUDW9rucu+tvEd5G7gkIBYwnBjDR7I
XU1EClI/z/3gAaWe4S0wRZ8gzH4brTYA6Cn+BLMyeLF4eMFv8PwI9wExdeec0dqXWVOwHsUqZSD7
VP1HLuM0CvKzgboYGe2JoJtTX79dXuA/Q3Dud+yWDgijv92Sm1/Agsngy/CqTxxDYk+6zgEyYIUM
mF4GrIsMbK4+In4tA2Ygg98uOX3/4fb3M9QROpB8HxlAgoOLs1lYif6PLPT/l7dr/WobWfLf96/o
/ZTMWWxa6la35N3cszySCXtDwgKZmbtzcjhCkkEX2/L4AeH+9VtVkmzZSE5ZdsiZMITHr/pR766u
/iZUIK10AxAp7JPRwXw7BJV3KahoQY2wYMXeon4W18eHDjCUuE6PeVzv6/zSVOuFd/OFd+sX3t1q
4QNJrSXi5bLD/G9/7vw95eJ7LS+J/j7B49OLSYYpYUyfZP0+H9KrgzzHnoNXyQiVq1XYghX/Yzhp
hArMoSts6b6WaHqeW2HLFytEPV16ZVaO0sHxiy/GWTIdvZmVfUPF6cUXkU3Eh6+MtBqOwUiNVwVa
c6nKuVTVc6nahkuNY+ki6Qspbc8wCOnVQe7EMMbVblWXq+302BHqMdmGYYyn8EZv0wq9DsMYx1uK
tVuMIfq5usRYg6zRmkt1zqW6nkv1NlxqZWCWQquK+cc/d/4WIquqitJMFeWUKkq2VFFWB0rXzba9
TAKkroXcSSatMThQgMUujPEtI8tMv2alVs3zexWJ8h0XkyCtmdvLmdurZ25vG+b2leuZCp95r+Wh
+TpXqS+0Sns+Q0ivDnInPvM9QznleCmHgJp8ExAGK8/1Nou/U4h/AAH2r2zpJ+au8xOOiEkgMqOT
zjidPnABfbNhtV+H6wMP66lbc73Jud7Uc73ZhusDhx5/hvUIUXeETN0RQFi7tMZesYr9n2sJAs9V
tfzXXlAQ0q+D3ElQ8NU6jxY1xkWNuYsKO6fqFnWH+QGkrYPcbX7WU1Un0LyWSaamH80c8CrCGwR5
0r9hl15jDBBc252SOzZXILZegdgtFEggPeP6FV6wrxQQBBJMg1PnvrS0DIEMdEVWTAF49zPNW+A4
PnZESn2psRXS54ue+JyJi6tDt2w0jRUx1C2FUV2RI1Kd1TCbTxNggV4ORv8sazijbDjMRlTiFg4G
Ysjq0F1gY757MotuomE2LVsrXV6f0CMUT+FDkj+TdcWo1iRAV6LPtQ5Yqf4Jp/hdJi8CnK0ZXzgI
J8OpmI8xJ5+NEliNEb7+8aweDoTjFLWmYvQ4CYcH1FwXD7oYZwA5TYoJ86XtDMPxGMvf59RZfVlf
AdzRZVToFIDBS0AQ8Rn8kO6qoCs79C+wo9LxO1J3pPplUds2pb7oww78fjL4b1jC+3DWhR3nEzcv
iOdlM5+yMEbtMgsnd7BEy6k5mlM9ksNTXgx04GyS3nWi8Xxls2F70lEMcgUCRk2GsCoQSJxcfGXv
Bjnx8SQb38Aup7NsUh42DNJ/4ehHyQzLKelHRPEjgupV2VLgUmOMH15SsGw4tCc/hGOqRYDDrjI/
vIDE80kATmMTk0XlYzya3uB9qQGekG5T7ZeDeeh7D9Es5b3frTg/eY8v8jywN9jDU2zQWZMMe//3
lp+CgMch1tlSXTwy0yh5EuNwFt3fDFAa3snv5Bwbxd5pD5vpVIgBJ4JZ2BUzWMd0dsU0aEVWMd2d
MSk5uoKpdsZUq3M/X2zeV9o8cUpn76A43a7LtXguXcOhAtIbOnIF3JAqpsU0v6T0FhZdBtaXxgcf
yMW0t/R/6fztLUzSxSJ9EzgHouOCMcAabsW13q6Pp5FVDRZOH4DmbFm0x5UzJVWNJSzf1CgatdHs
kLNd6aqO9DuI6/WU6YEV+wpm+K0DM4HpeVZz56A8myePIoxVOCWK+a/RKXXhLNnCWbr/qQEggGrq
kPciB9zW5XOs59i6WbSOuAgyqIPcJeLCPcV31gE2wV1KHPzg4geuV+H7jmye6atELQ7mPWgSfZxE
n8lqrpSeW+eXt98khFR1kDttkutSHVvTQF9ljV1fVY4JK9FpWxFRhpqIvAy5WwP6vu/UJeBaAwYO
ZtMA8Q7Z6g5l4w5l444pG1pSAhZ+4x4B7pl8qeEXa1Vg24l4RttaRm8DqNxugAVNblnSQhVkICTT
QfaEJgS8uHE2ApYb5zXwtwna9hRfwnpLFS7vODVlnu1q67lyvxVLBarRy8EPUzKEy2K46TjJQ4b/
mo8eRtnT6G8/xjVuF0wIJa/2ONoCNVhUBVcRD8RdSnfhOCVOgBSYvEVepU5zH7V/RkGY5rtoA8qL
jfMRpgiKnxLpMLxLlrccAZVxyRFRPcfHlui5jhvnypjCxPukxMaF7GQjcMrBxwuLq+IMHiZ45QQO
b9BYDModtDKYJWEthTWc+54lKl62no/EIcbjmL2g/8OyYCaMhYJVhf7i0T6s5abA6+vV8VbxFiFh
pcw3MZ/e5vclK44qhkbLG0RFxSv8YJ87SFzsLaDv57dsYKxIaQIuxHM5YC5qgA8pT3zwjxeNsPIa
8yhEe1uUytNzq/8pvlwtDPF9+Jh/tUzIMQkqHw9IkvsovbmP4h7tH7i94s370X04ipL4TV5sfLJM
8719//Hk7JciBGKSMR5qeCTTGUdpTyAEtTocD8JZP5sMi6Xiwhm8AvC/X88u/w5Y+aOyeI/14tMn
0U+/s1Gw8qQcVLUlgFuMcG3qbFxMbTTgInfgIqPELJnmYHmlF78xmg9vYaUZFr4kqBsJhuPx4Jku
c8MCXR1bKQ+vjn34+HEeT7NRxz1U+WTj+XD4LP66p3u84QSTuVz6VrqN9PNbseQlsudjdTMe3Umx
B3gZs+yC4+H7IozcHoFbz9aKmEhm9xKzxJ/gW37/0Hccp38AXnXPgJeT9Dyv53s9HR2IP85OhcaH
E/zieTShuDOzHurMRuL/hH3PRD8J8b75VPzZn4RDLAnHSKBsNTD7Luj64xS2C7a1Jx4yRvsCou4r
vJqWrQg7Ptb85ss4GdUI+pftBd3Pu+an6Xd9Mx1W+yo61Kn66vwYvrZOCR+xxjZvGG08pvm9XzZB
zKU3E8wTeKWkARk3oiOFfCDEltNkkES8KxlEMpDUULeR5NH8ezpIw8nzxtlyKqSRnPI9dFwapKHU
13Q9FvUIiTKe8nDRDb5NCRYK/zo98bnQT4UFozMdELb4t2QUZ5N3Tmxu8Z8QzsbzaPYO61wPxG0U
n9LPvxO6y7kwVpL2N5CezrDkHrj/vD95pw5ESRLo5demP5OWfMeUPSQXVMkVeLuoesBE87nEPA9H
c/AnUHwnveImNK5IF1sMlVaWj+1WsauT7q2wARMwkNjUEVwc4XTgF0k6YLnxC32+tkeYYA3GK27Y
8Ttb5Ega9Xw0eR7P4l5+B2Y8v/lrkIzKN1Edtl5XgYeX3b8Xa7zo65l7T9/bb3Hg4WFiA+421py5
Tdp1sUzu6Lc/FsnZrC/uouFNMooO4yQSyegOPH/OSWuJhw9Sv78SJ9eXdN8RTIkvsvEMotV/0SUn
fl8BRPRdix1Ih/Ehnrg5vWHsuLaXH4UVrXdckc1nOG5XDNPJJJsw/fXA99FANqz2fRTR9dHhlF76
kbKPt/3wPuaiW8T3wOSth6aibGNCf3y8CMEcAxYbfQM/cpI8wd+bbHnh0xZd7OldZ4HmUTyCAZWL
956n4KdP6FaKBsdA/Ifwxdk1ueTJd+zlsBiaw9RaQaDkUkm6r6mfgbQjN5Des35Gck6V3EI/txde
xFRVzI36Gbmuw9bPiK2r2HX6OedcLqDGY0dUrO4O+hlg8P31FRi3lX7GEqLauELtFiAVuHtX1YDr
1gZeatvAi5GRLQnuxzYwClFKgs078vMjPaCvmtUzbVpxIjClqSvwTK/m42RyhVlQPo3a6E+1iyYB
zzbj0VVxZy2atGyvA8HtQgnonvg9EXGGCRnM9VJyMRzcZROwiWC0MO74dHFO/5/dp1O6anlQJHVw
4+CbTKse5O/TLwlvbxdUa7tgXbuB9N7tgq2ECXpPdsFWYgG9Z7tglaxi724XfFX47Xonu+Cjg7wC
08ouaCk1IhVu36JvXBSOwwhLobCO864osZN5GQB4Icb1Au0Z3qS141Hbkwap3THq1djhahlbqVf0
qoi03kB6v9JD5Lwqud2jXsI0Vcz9Rb2EbavYDVGvYka9Gk9mCndItZcehHGDNZhWUS8gaXxpcM2G
ert6P4gbvPSqvBbOCKOEDwla7ePd2AaCrxKraaxiWRoH7zUFGY+T5QbSexZkJOdUye1uBgnTrWLu
zwwStqpi1wmyxzeDAEhP6KAEejsIMsAYuQbTzgxaz8PqnL0LMuLavQiyYRM0L8MYb59ePdLwlx6X
eTVHGQgb7VYJv5qjTKTVBtJ71xBGe1Vye9EQ1BlwiblXDWG0rWLvriEspmpRtM1OGsLigcsKTEsN
YSy2xHvpxJqdEiiIq2vTAGbbRAej+L8kWOuNm1fJOyB9r3kht84JIJ7fPB/KCai1nIDm5gS0hc2R
K+nx/STHEdijuGubqEt5DnjrvPyStoGDNayVoav9DD1w/PrUnNlHOIdlw0vNZ1/TC0TSdgPpPet4
JOdXye0hnEPMoIq5x3AOi6llFbshnDPccC4Af78I5+wOOj7AtoxrMLqVjg9ckvZsUdr0ZZfSJoDz
sIAieyEo9E7JAhv9ocrVSz520Ii9jdlgVJoXBAO/kSAV8vhrajbkqllPKh9PxkhF8bUheGSO4vnF
EPHTW1MVbSj3og0ROFfkkjd04ysTBMyCEYhvtF07nt3TsI3GK5+Exxg29Z0EowW2k4ePiUWzMnCz
n4FrpSxZZMMaeADeBqhEqQNmthICNrpxXKg5v40BctoZICKtNpDerwEicrpKbmGAdtJNhOtVcTca
oWwbI0TYpordWEnD3W5DF7jRevjtjRDC+MEaTKucooeBpq1TtGpnq4HY2mnE3sZqcDkawthaM6VK
q+HKNavhc62GcYx0l5IavKKkEml3A+n9SiqRU1Vy+5FUwtVV3P1JKmF7VezG7D97u50yaRi0l1SE
KZOGwU6SCjha10oqvdK2685or1ZSCXurwnP28mpT6+ARxVoHz7BF1RpZMQmOfE1ZRdpmE+09CyvS
syv09iStCOyvAO9RXBE8WAFvkFdgBy6iY4pDakfuILCA48t1nFZJPIBS2MrhJY+bnW0rYddqA7Ot
bWXWEyLFoHk2ZFzdNYn1uBJrFYR7S5PjtKombymxRNvbRHu/Ekv0zAq9/UgsAdsV4P1JLIH7K+CN
CRnunmMD30LSdigrR5zgBU6rlIxvfc8tkk5Bx8nlqD8fDDr5XdwKT5SV2cWTkqVUsMgE0veQ4xZ1
wngRcK1OOJok1OqlZP8n+NqvX89O4cecxKfXS7xQ3SYaeJD1eqPRXWncwOjK9H4gY9LYFRlz1YsD
rW0om2bKKxLmNEvYFtRshdpCvoBkJwes3qo55aP6FdRV4QIag7SfRuI6ie5H2SC7exZno4hz1gjY
vvbxMs0gy8a94mVi9gNo8Pv4cqheMK7LYFy1PePqbuDLhRIgMj9iIM+JN2bLJcgCm3KgmilzGYhT
nltQMxVqCwY6DqOHzteLK3F86YB1+/VMfPi9B2qj+0mJ7hmNCL7waQsy1eVc5aijIb5tGY7ERfYE
OwYMW9S/MMEdWZZ9EPiqulbHjqODPyTIOHewnou68T6NJ+ETtkx7Eh9BH1EfuGl5XxmfUf2fdJKK
v2fAXiEPOVBl5Rb7FjeMgo+dL/F9WtxbxFGTxmVn1xEH5EvR7Dvlo6N4vt8DFj/tIV/jOz+gFOAH
gCXlQb5Mcknxkfon5owv/mzc21UO+7cNLCa+Yec4mFinGtx23MN0NJ7PGGJlg64D8kwNBfGJ7WFP
DB7hw3xUfUZ2nn8vb+bytmwliP9iNGVAEtr3sGfA+z+udac/FW+HsfML6jh80jgGGzhIit5PlKil
d33R7mGHT7xx1BVfxjNsqTQCdcYjaZRWGIOF0TjFe2H9SfJXT2SwwpOUGvwdn325wpYFjylexrm5
uDolejxw7QRYZU6r3Cv273g+m8FmhFNxmCuk6eGnz39c/ePq+hw2Jv/8+OsVfn7x+UKeyBP8lCC2
2S6i7ZWdE1ZI/3nx++Ux4zZvgYKO15YzQAKf14bN8HhLgkHjsD8wh+15mvqXjz3QbDezKAOddoGf
5zUD4vrki/gdm7edZnfiml545V5AzuHJhObwHYCvfFpeBoawJol9fPGQCoyekFoM1M7Pz77g1a4J
qwdGTo3uKjRQqwhgV9wn4WR2C+7gu/wpWhCF7Cl8zuYzVgMbpGZcBx3OETB8GvZve6UeOjvF997j
RGqX0ViqRLJVpKI3jfj8283R5clHHoqV1prVPmeLFkDUaLfUsdM7mXcHYQqIldSwrtpNvQnY2RbY
D1abOjUBu1sCB66/2uW3CVhtC2zW+lo1AevtgJ0XXbybgL1tgfVae7EmYLMtsF1rWdcEbLcBRlws
ES816Ym4GifhA17Ur+jR8jT/cBxNxw+Tqv5klC4gGbRnoCzOT95jr9dO/m1qLBonURZXnvdmhBsI
qI3FA4X3p0cnIhzGBq/i4O1e7Gx9eXQu3p+cLN5W3QJSrUJWUWCNqFSTTG+Gj6nTt6PyRbvngzLs
eUoHA+pOhfHPdsTFe3AhYPXzxcgJYMMLCnSwyzS+U1iJruh1vudFD8o3SRTd5L97U3gLyZstR/D2
czZLYKbhTGBD6qxPsy7RxDB8hjnjd0q9OcUvJ/1+Es2mXZ46t55HicXpKL65j8MbbC8a3YBLNpgl
DwK+Mo/T7ESeYs3BHJvijvrpHRmso08nfuBSqzSY4nw2fafFW/nd0YfwwcMPBj9Y+CB/IUno4Y/y
R+WxRgV/prmg5IOQOAh5uPZ3i8WwXLL345yiQ9O+3YGkzyU5zEZZjz7ekMn+ztQtSCTgEonTu06O
7ji4g/wto36jLBqksaY9PrLLRRbiwyQbzbBZLs6AkbctSfCkgP5cghtVUmBUIZUUNJ/CJxAVROcF
EtZiJ+uF8fh4eiSOrs8EhnflYqyakSgtAr3DyumIezjFpMshNg8oXHNGPJ+TpxvuL8mXC9WOOqNi
p6COyuIldVzEdpQZB0U5ZY21Qg2Uv8xnxfq3GgOjPiwfg4cn4RvGcDWfUJVzu2EwirOLYQS1HLgY
xsmnD+/bDYEpYtYx3ubduEID2WoITD0CLly9IOR88DEJ4/F91pYrOQfiNAqI/txlJiaagENCrRXj
jGmAfcdSC+RRNn9MwnlxoGCKyziffzs7PTsSv/oGTJ9v+lKGLs/c+digcsv83JSSjTeFX80mU5SH
5L+d586KdH3ZLrhCGx2a7Qh4TnHNhTeP8QBPPNjYxQEHf/Db4dPTUPmv0PkDHXMV/44of4hdyvjn
XYjqGWlU5UjjBRzesArLUGmWidnsGebFY+lAaRc7m9bz422aTZfPhxjZ9U3Xwndk1+EtSeDhn83w
59KV6pqiCeaBYglsGMDvCXgY0nPo/87Htk3YmE9xPQPG91icnl4yokNfdV3lUxPFP6+vz7+J/0NF
tfiRo8cwHVAsdDcJx/dpNF12fTUqsIHW4iE95tPxVumIeBgqdyMdVwZo7bYjY0oyKy+bjLNsgA/6
ZBG+es5Gc7xatNPzo7aIupHtTi/Pe+I3CKEXG8kH9TeC/np0eY3JOu17djtgrLrdAHx9fnol8lck
SmlklbOW6JuHfXpyvIBlvaJTwJpGxbGAhXhnjM9ICJBFB/s50w9K6TJcj5LK5o1cUgHdKB2i4hZU
OHa9pPLjJcqpuERFSuW0mIvlrpiiFUMqLeZiNzMTUgHrMaJ9ARW5BXCjVlwDhq3AfeABe4GDV+3/
jCfDb3jzOC8KebwdhKMHMUuHyXQWDsf0SAHqhMvkUbjirYud2brAVeoXRvqnpOOWdPJTh+XN5/Ek
idJp8pLsX/Nk8sykYIzGnM+GJTqHv/mh/snlPy6uycW4nff7MJQoG6cJ42QCCClpqLFzPpWTcETG
M8VIZPQMbukswlTaNP3XFnhoTXO8s8rJYjkVp6u6DjCL40pfOjTs6uzwlHOYjvCrPIIqb7ixtwkY
RV109oWnwVXEqGvtQHSSdIoz0W1PPAHTSuljAe9g3Cud17x6BBhghrnWImzhekEE6dM553hMj+zN
wa3tTMfoHWNvjsEgGeT3ZrmH6AipHLJy6cy3PfGBwtuza9+6zgcB8jfO29u6QbWZL8MXBOTAGhdP
USprKstDZsqOf58pOmou3xnK5QRTs/AtDaJ6m3+DR8336LpRHbWfcaTta+zvrh0geXbxaPKH6rCc
Ezc3jEE4IKqYhHjbCV8gKDLuuIi3Gb3ygK1Scv89z24zSfpUk3Q7SeM7fGYzHUBEgMv2mIYinIwP
0/8fCJmBmw7FoIs3gOksJz8vHTT9AW8PJgEdlJqWWJpToge7AasyvxSYX5KLMoGBAHITKKUCbYnP
Sy0B2sEF6nZkpoFUAXtlIFdnZBYTU0YCXWxsbA7acJJUBOoZgTd1a4BOx9YEehvS6wLfzwS9NquE
yGAAGWqEz1D4FAdphoLuiIGuXgKZBzeuoCg/N7M4uTS/tBicWogz0MTQHHTqFegMciNDQ1cF98z0
xKTMEgVX0IQIMGQhJ4frGkGGKhB9ugCPSFiJEY1TcywwiWdmxieVFlsVZFSCr1O1BZvHBTVQB7T+
19bT3c8/yJW4BG1qYgLOQ0THFQBpuYwJOgcBAA==

--nextPart5399117.uRT4B2qXSz--

