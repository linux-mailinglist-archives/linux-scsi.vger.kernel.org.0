Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166952D7059
	for <lists+linux-scsi@lfdr.de>; Fri, 11 Dec 2020 07:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395566AbgLKGva (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 11 Dec 2020 01:51:30 -0500
Received: from sonic316-13.consmr.mail.bf2.yahoo.com ([74.6.130.123]:43999
        "EHLO sonic316-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2395565AbgLKGvF (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 11 Dec 2020 01:51:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1607669423; bh=2Zmg0K2FiYCWUpWWlXBUtn3RmdLha4OQ1PU1MuF0nU0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=RWMYQ1NYtlN+lreGjQAP41hwl3BodGcLnpoUwI5xbZhjCaE8FgPEdWmHc5+lvLNLSrOD0ySqyQGzVaBT0mg+BQbzX/uTAaUPfcdERoLmDMEBnI32c1BodN++WaP6VAIvnrrP++dLwC1nxOvsY0UmB6yBJCOU81qMjUeuEhnRrvWEvTn6A3siIPF3OiQJkNV077RyDASkCxMgSbiQLkjf41AZnY5d1/OCP+xtBFyz+9qfVvbr1NB1lcWrOvsLq+4X+So3QCKRzQA0J+UHkdmbnEhOhhJpAtFfvhGZUnJSSfu78MTDKa5m+gkw8lOADfN8vD+OuWoewf6SwxGVdr1vhg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1607669423; bh=drG9/Cb8RP3Lse3psG91yiGASZ+Zrrpu0UfZ6J/8l3t=; h=Date:From:Subject:From:Subject; b=jdWxC+H5xIHRmoZ2WweGo1OH+6zKGhWKfyu5dbgzfx+4c7pol13QuW0unq+hbWScV6v3fE4LxknH+cSlXaR/npjuvNa1t7G6zruiT+D0F8pxjxtEcM61jxQWRIv65gB/yNSkZYpVN58kEhH02cyCX2rFc22M5ylyh9/bz3l/WXVvn+oyA/U+QcIuugmyS5p6WaMGW8VjZOTqA4VuT15vpYsjvv06hOK/QvawYYYWALBCI4sUGmi3xXKYpS+n7CdGyCPT5RnrpA5BcGeDlq7bUUvGwbqPUsWFUXrxC1dXvonC/5TOlF5QWSZkrRIfOyI6Kz4aeMGsQf4kDUdXniuSdA==
X-YMail-OSG: r0vvLbAVM1k0eNveMAYjIWz4v6zi8FVkyMoLLWzwn..UGsEp3IG.WS2ON9INAT_
 F.XIo5L6z7Ip1uAvPuyWLt9OV1qSWsTiUZipp8Dn5TsJgAW3Pzi.P0MKwWVx0lochOtMXVOFi_8H
 birZN3LJ4OuCzWbLCR.DZmIYFFKJD1MmjVlIzkl6H2Gd39ufKhF.2oIsd4MXTE5GkeBTBm8w4E9P
 TM1rIb7CWjaJqHYLfE4kYtnhYgKy1ujdxKF9jVSdnmEU9Qww3b_7NLAh8oTMcQNgOnjykJdc40VG
 2VE.U8vLQaYYZFT29n8Wb78qKVW26ZmfJUnpJZj8IkbcVpncyR6xpfAv56OpHrpow8EA5A5Q50Wt
 m52aJQeVM5bbJDgK6sv4hu4rfZ9y1oIO6GxegrsmzkCPdyJfGCvHCleOsfUR5Baf4pAbSa47eKOr
 LQGelCNzKyYw43ApdGnV2WuwwpLNQC6v8k2mGfkhwdR_Q6zgkTZD3kr0qMyytabafZCOacbDqSw6
 9o1p9h1iIUXc_fogfQhOWRT9Ik19bBXTxKjZIgaJ2WXamWokc91aUQqpHxuaAEC0Qja6UFPsyLjX
 yoXOROL3C4smRBEPlEvehns8gi.W2EIi1cPBN3LLAvri03c56oxuqVzKhWPyiBxopVJc61uW94E9
 aOJRiGHnhQwvD_EKQvxTgDVg1pEzRGHxo.9BxBvc2M5K_FlH_h3M_LEop2iUFjLkSV2dyP6Px6ZM
 _aW36Sn.2kT0tx9FYSyftpkD5lliMG_S5OVTOvh_C0G9DRB4r2O9xI28iL2jQKdmzNC9kSCw9rYB
 s6rELEFWUQ15Awe5YkfjdHFpktY1dVzKlNyJNQlNEjbIH0hwMyCGemKCzWcZL8G4__LrKnwaetue
 4ow0QSbeA7j5xW6IvJRrbyNAXV3DS1Petjo3yHBMaETZSzJ66Og8CTls.9vXGk6mWYtfNWuJbCOU
 NhukBN22xfmZbq_XGFl5gzuTEvMThWzkC86gz7Ny2VV1vYqGlsTFzNzmpCUYzMPEx1eJ4cEtI0b5
 GjjYVCsXONCaeXOjw9KoVfwk6twd2gHy0CyDXATg89yRLVXpb4pxXDiVKWRurLmwdb2UpWruIaCt
 9ezFRP3S1s0QD5XM3gQkpL1L56czWeAXopuT3518Lnq1LK4Idn4BxKSWs6ap1K2k0OZmZYksxnk.
 J8VyadFUs58vf08WAyBJ9tKCarkfNsSNqjH0F5piSCsvWhfg4ScSQQ.QeP8VWavn9gwYdFxLnOvh
 mQPCKN1ZXKmy8E9VTgGReF2sZFnMXqYNi7_JrNAsLa8HYMzCTMErmBhhtszFIBITwrhsp5voaqQA
 Me794MUIsPs_ygSLp8Ts1gCNPKVpnMuTdg9yc5Paux3ynHaoVJCG6evTIFPBpCWqCFC1LDvU6Hzr
 TZ8bMCdD3taINRke6kC35V19BWMWyJldHTdCXbG4jUWJ4oxRV6jvyChV1tlKC_BfxuNzFts8qViY
 nLyz8xFYv77v.b_Jrxg5WkzNzlYb_FPeKvf_ys2_xutG.g1iOGKdfo8aG0EuxODZKyLDwi9uBERY
 U_CsbTVv4CzJSocMJS9eN_3bs1U4ucBv9u6CYhXzngLRaVSyatUa1Rg_.pMM9R5EDHsYJJ.vQHup
 i7Z6dk0.aLnxmxIgZfEzbOYvFCeyA9tTCkrB.8N0o4rAis2jhDcJxQmOUaqz0xr9s9B7tP0CDWEn
 7p.FPEl.mi6mBT3yT3OKH33JqwjsQgp2t9j6ZAb0XDYcYoVl5e9vYisToBLXhgjKtpkuNeKq.eEK
 7LuRVblYr06yPKGEr8DXnU5zTaeJT2iwDO3KVWn_LUxSn5qFTANuBAfc_cNkhcHynLPtF.KKpX5S
 gJDyyiHiml11ImMajYomsmaT5mgWVn3SSEchjCbAyNjmpwVvUICQqHIGmg9.1PlzSixRf.hhnZo2
 Q8dx_gVsd5QYw0pz4avwnCNy0O4YkGl4LyFTbiQyMeY_4E6IUfkC0PwzxxsY4VzDRGPNhwE7lKyB
 Opg82y73EXR1tzqhhBOncp8FpC2j30bU6uhYpWPv92N3alh8rNxQyZIdk85nbHNRYtLmkf2qQ7yd
 ouRva49hFOhsZp6zmJH7JURhaB_4DJXtbol6CrOG3A3z4wiTz8WDRCIVrPGe15OWp73C8wgj1Bau
 EqW7iwq_2w11BFS3edmtlc1Zg1BWAHqOg6Cu3xnZw2rkDco6HB4X2KVZBwc7P0wvkNnFaULHKvoG
 zLBONlkYf9NSjt7V9cArHkKvckBxySJ5codBG7H3pInYlJFe8bw3f4aPo1xTpyKRgRIPiwKNy6qj
 H17KWsRtC0wmqIHIQ3_qil8eIVOBFtBNeJA4x5sn81PZEFU4qyYi.xXoCTnI6bLDENyYDg.N8PTp
 j20XG2o27HVZM.IAEl1DXoySqWdeuREnTlIlZB_AEiwWYcZo3ZkvDaAHu67NkbPZCzqoBJIvVX2V
 5viOid_Q2JRYScJqOT8pPk8kuPW6H55eWrfXNQ9rd4MSyCLDl3ezlqFF2nJU9Cgoz3i_zOj12LI1
 FBcjiJgLiftdk7C0FF87X6LtzJ1q1wdzpJn5sTEBzZmEhP8ed_lhig7im_mz28eDjwKclBgdJT0v
 ABAVWZHfZ2wkUNgh68tvGNoyEOTkfwKruseQJEAsASZly4J178GdyxXtLW9VLtQ5GYpjhOODa5Oj
 RKr.ZXhHCk.zZq3j4dws1utnCd80Q0aZGdDIEs18g3vVmmdkbyiP2a3YmQib0qCsPyR57oIsJmP9
 vnDMvPbnm54Yt4IbohbryZpTf6MIJmHmRN4r2wxK3UWQjDy_p1ocW6qKcSZy0q.3s9dWME9kOk7.
 oygXgtGznZ1a1FUyVa7xt_SuV15XN9brnTu_LS3bBiGM829J1JpWUDwy6qegpZS4LVvF8uDSf5g6
 XwkxPJzDuBlnp7p9nBPBFZSBPIxMLItdoSb8b8.C2oKH16IMV8w0IH9g36uf0gN18L42flsIqVq9
 IUkbGlYYCAlSnCf.gYk_CVgefqa_SdT_gGispuYhhV9MmLuUee44HNu3qFzDQTSn_z7tifFlH0I6
 bI8az6K3RvJ2iM5nsMk2GjQd93_ftmqtRw1ur.zKWDAb6wUbEGAQVTQitbcV28PsJOnSHPgWJ5ss
 kyIteny0..PO6yFiBe42k4qIiuYWHmKwF8MbFlbTa45D9TmSYJRPkd8YeeWIGqeoPN4N4DC5K3EJ
 rx96tfJscE9n3HR06iyEgMtuNLcn1uwNDrj7gDJLH9cMmnXjmqu4H2DUilICSug4HwXS2NK.aBOx
 y9JYR8.X6hpEBBPv42.dZeKLPw8oaXbpGaOMJZIs6HqkO21H0u3316l8Im7A1feuZk9a3RZwvMeJ
 ErzNOgOXbmImtx1DK47feB0G8BikB7hCf9_9jHZeRdsUzQPexrCBFeehCXfN8kAaeuZf8U1ttV0c
 x2nwOLj_HwPO3ISfGFt0kRLho9FLsLnb.iYM6COKh79hh0lO9pr1zpZDYAEfn2fk3xOAP1HkeAx2
 ROFBjJ9p8wo.0zqJwikxngLQCC93uD.Tzvau1Z07VXTsSocaPOJhBNBTlIV0dNjr7YPKciz94dv2
 mW8ZKlf2KE8QRA.IzwerFWeU5Y_hEYxpLSPR9YKh1CrZ6AaNhVRWohpFa1Jp00DBK3oFkqQF4.Rt
 iXY6PlK8DwxJfNdWEUZf3U7PCrSkf0tN9EV8p3HyP7LtTGSxZaHWfEUhk3tJHvmsd5CGICipKbT1
 GVNm56LP7e33lCFxEVGgzE6dIT_0F23EBXp80Q9oo2XSyOTeA_ukWDoq.sQdJ8RIc0toN0TnJNCG
 8fBzRvKc_VK6AD2a8uyEhhZkk1IjlbcUqIXJO7ZTG6YlMOMsHWm292WpKWVlcUYJDIhAeGr72xKI
 4COCF7xaFXlBadbsPCujLpv4cVP7_K1AZa7Xbfktw4eNxYwuR99U0GgX0Qvnctlc0QKQRr6yc4Fx
 Oenzhw55raj7dkOYcZFTrI83NhSYGGJWlFqWZ51LADBVLbnlfQXj4s7gjJMBkfUNU8hPQkShkTjS
 LOrJ._M67J0b53RJyR4tn8elNmVBl541ukLMKV18QcKiz_Z_fbRK_h7fqXlNDHeAU7_Ti12ENBE6
 FVMz9F08Tlw0yTjcTZnySX2TrIjhDscOWLnEbwCfJis5DP3vbcbEY8tmwuKKqd6zL5k0xrSy3u59
 NrJTRD69xTVVEk_PFmpLRe0wngWCN5EGHXYg8O2ccnXE8BVmLAOMZMXko6BRNXM0GHc_sW0lp2D0
 QQ2K.XCzxercs.pWcwy3IoiEvN_XrIV1eTgCyax8Gvcwakwe8pCiDtThMtM0qllqyGzWkHDCJJnG
 UgGGxxWAUlOMEgGxtZdFaL1ivTt0Z6DfTLrTXwQUipw3f57j0JZ5YPXfEsuLQYudzLRQw5shm4li
 GQIWwa_nOarPfavS3p9v9jE5nYFm6BWO__lsOywrA9i_nSvldllWKpvB73P5c39z2t7MFBgEHBg3
 Dnw4BK7P6SBzFlhIC7W0HBMKydHAHIizBMffDWEx5k1TjRxPwNwYF67QCgbz7OI4RCJMF.euU0uY
 I9b0gOzzfoUpTe2m6tpVj.nHvAhV1IMtX90IXiCQMnJhL2n5lCvizU5241BHBU2YT4n6wLq__LzP
 sZGMM7BUPVKDsFejp_tS7CkVtsz40wP0wAD3s0_V.u8x4HKD_KDTI95iWtXGq3Ego48b7H2s35XW
 MFTuIkJBJhkNbNrCZho8buJmHd49gEZ_YdZ3NCPhjPYHIDCcUFZ1ZxUe85nVfIIaHpxBT8Oo95ds
 odfiej1A5dw_sGwqJmytTXpYW6oxbNaIitk9wv9qNhQiaXWxCxnulmKyg7upGjrLUmmTiJGejRrC
 UUVd4Ie.ETr02O8rD094XrLLe8sC9T91UUyaA_bkgNlkfdp7njuVC4T175PuikfYd2N9OiKdy948
 n8hV1SOyzxI1v2z8UsRAbT6qaWptBQBmFwqquHugk8BQJ31EH5FcGHhbHXMY1vrq8yFH0OBB1KFi
 6LYLGaEOG_NzDS9sEEFOi281lWCTjyCl.8sLqa.eJDPw_N7LTWq6rU53gbUqaLUY58Ny37YZfVlS
 E8m22gGbULlzrLa2iEhb3tkanhX06EIJ7_P2lRUMunBoLXnVl30maunLuInG8JgJ3wQa0KJ3S3sL
 4zC89cw5FuICGcpjJQG21rr7Kroi4SmKQujBzI_KfReqAKywh6fy5PVasLBQtVe95Y9gTj_387n3
 4oa0vsjq7uPjV__SP6M38qdzbg7goiUE32ZkLOIzJjP60E43yUPE1NpD0oUqGTD3zdZZ2UD1mvA-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Fri, 11 Dec 2020 06:50:23 +0000
Date:   Fri, 11 Dec 2020 06:50:23 +0000 (UTC)
From:   Ms Lisa Hugh <lisa.hugh111@gmail.com>
Reply-To: ms.lisahugh000@gmail.com
Message-ID: <1135530829.4350229.1607669423443@mail.yahoo.com>
Subject:  BUSINESS INTEREST.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1135530829.4350229.1607669423443.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.17111 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:83.0) Gecko/20100101 Firefox/83.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



Dear Friend,

I am Ms lisa hugh, work in the department of Audit and accounting manager here in the Bank.

Please i need your assistance for the transferring of this fund to your bank account for both of us benefit for life time investment,

I have every inquiry details to make the bank believe you and release the fund in within 5 banking working days with your full co-operation with me for success.

Below information is what i need from you so will can be reaching each other

1)Private telephone number for communication
2)Age
3)Country


Thanks.

Ms lisa hugh.
