Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6826282AB9
	for <lists+linux-scsi@lfdr.de>; Sun,  4 Oct 2020 14:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgJDMvy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 4 Oct 2020 08:51:54 -0400
Received: from sonic310-13.consmr.mail.bf2.yahoo.com ([74.6.135.123]:35164
        "EHLO sonic310-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726063AbgJDMvy (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 4 Oct 2020 08:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1601815912; bh=NajTNMrfMLb6UXcjRhYpYerQX8PtVBLz0oFgaMINSWY=; h=Date:From:Reply-To:Subject:References:From:Subject; b=dS7X9uDfOohYAFbz8/gXDjruhiJJQeVQIIl9RMYzLcXl3aHqo5gZaWJOysGwfkiKAEJauCu0uNf1bj7fNSynYykYQLgQHVP++cgLZCJLViF08+FBYChg+z/dPb+ZaZGRB/0eTMOBTYoAooCDMFldI4IK9fYgzeHrNHth1TYTdu3uEFEesqF42mZTDrKrxn4gLHMak1GYEOWTndfB4v5CmFak7e/GV/CTXtX9X3BhPf5HrV8JmGlGS0sh60yUzWR2ujkFFMYUVp3t9CTrZMnOVlqudNeyha3+uvsdASPQfqZ9xAva54Jcm3wc5N4StU8JwSXX93iOsG/AkkWwawO8mw==
X-YMail-OSG: ujUgNYoVM1k7mn0FN6fa7q8y5IQILZWRMIs49q1Gsza_fP7_kjyoicaOloUMEmX
 Fzbdx_COEmkhYGsnzp2obQ2CQOEXgCiVWikgmZBPKqm2T7exqRGZOm9M6CaB68wOCsVpvedExuvn
 QdIQ6Pipq4H1BzELiNQsQKPZs6K.4oXyBIsZescDnkan77SobIICIm5AYlZVoIH872Fc3mqoo0AL
 rKvjMFOqC84LXe9ewl1ZRsI1WyOVxhJwoKS4_hUfz1jo6Rydp9CShlTbk83bhTonhqnLbgnlo3OT
 2Cz2bsw8ArXTiLkAcpBp6LiLZWHWKmAzhgPyz2ZVbq.fFMKvF8RIPc8swVIIw3jWKaUyqRP8rxmp
 3OY_EhsIIgsm8jYaTQ39feN5QK0.HH175WtQl1XwgdRfUR62ZRt68ag7G9G1056DGIEBvFA52Eqj
 zNv.hcGqgAQDU1ltJjosKIJXPIPGogvoiffDXI8PE5xv9dhD1M42DfINZ.gn_iRoVWmatJbsbW9.
 Lgu5qy2XGduC2Ga7vQaJo5YLCKoRzroeZgHnNsKhV7NMCLdLlLQBID4nBZbp3BiiPuh8aThfhsOI
 8Cy1Bb3YxRkGkUbQbjlaOC3LezYjO0ZN_iziIB.IpDp5ZZj1n_Mr0ONF8NjkpUIZiYG7.HaOHP8s
 lifvLQAgCu9n0L9_xIwnzUBbfdLskW_YDmI4E6lh4W2_DI2STVnWkS245utf_UTDDjnAIvNDgJsr
 SiaCN78QCl9q5Dga4FmRDGPNRLT1VsOBNABBYmzjg54S72eP5TGQU2iamTMb3GY70Q7wwzfvNx.4
 dyHb.UyK8drc.0Ajp_P42DAxL6clHjSf7yWrYp4Mmx4_zBLCw_piqwb4Jhfhlo4ffz17lCSxJ5T6
 lVIX94qjpzewD_e8ThIaGoK.HarTbIxTRIJ4LFWQGpN7HYrgL4sVrQ9NLUZOoiX.c58WDjao.y5R
 KlmJZccO_2mxudqMEMJyHReqL3CdPLQhS9XEvu31UJ3WNoI5g0TQYqeB8KasYXgyNeUNYscv.TBL
 J7XgQjwpvFckQ.MrUYq7Vvf22lkIM.9JoQXJpN7jaMcBIrK5BrXXgw0bEsMPyyiXGKX3EWuGVhAy
 2N05gHswM02cHvRWiltHMrKIXryl52eFs7gy1oEqLaFckoBCryLbTzt2a09XKlQ03XMokdjo88_p
 DjC2DfSRl4gSw0dIzk3SWbKds4rtBagZyqz_9_WI131Ox_IYo1r4xyJ98PYKp1Po9WODfvrLFAWs
 2bFlVb400WYvCb7gEluD59jv43FBIK_9vSt04VBYjRCqiMd5n7j3Uta04vYBFnHFXUXAMFEw2vbW
 w0e59QXbJZMARkFDwhcL9FqN_m73EkhSdSltQnd8ggo8kDj0AxeOlorvObrYWD6hDAH9Ut5b5fVE
 qu7Ka1HkUrmAprBJAX1yRu6ZRtZLhqglz2FltybwN1h_RrQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.bf2.yahoo.com with HTTP; Sun, 4 Oct 2020 12:51:52 +0000
Date:   Sun, 4 Oct 2020 12:46:54 +0000 (UTC)
From:   Ms Lisa Hugh <lisa.hugh111@gmail.com>
Reply-To: ms.lisahugh000@gmail.com
Message-ID: <1490295133.1570366.1601815614446@mail.yahoo.com>
Subject: BUSINESS CO-OPERATION BENEFIT(Ms Lisa Hugh).
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1490295133.1570366.1601815614446.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16718 YMailNodin Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



Dear Friend,

I am Ms Lisa hugh, work with the department of Audit and accounting manager here in the Bank(B.O.A).

Please i need your assistance for the transferring of thIs fund to your bank account for both of us benefit for life time investment, amount (US$4.5M DOLLARS).

I have every inquiry details to make the bank believe you and release the fund in within 5 banking working days with your full co-operation with me for success.

Note/ 50% for you why 50% for me after success of the transfer to your bank account.

Below information is what i need from you so will can be reaching each other

1)Full name ...
2)Private telephone number...
3)Age...
4)Nationality...
5)Occupation ...


Thanks.

Ms Lisa hugh.
