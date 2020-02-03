Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE829150E3D
	for <lists+linux-scsi@lfdr.de>; Mon,  3 Feb 2020 17:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbgBCQ6X (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 3 Feb 2020 11:58:23 -0500
Received: from sonic315-20.consmr.mail.ne1.yahoo.com ([66.163.190.146]:40994
        "EHLO sonic315-20.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727540AbgBCQ6X (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 3 Feb 2020 11:58:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1580749101; bh=ccCAWoSF5BLfDOatu3qpU6l9KI5KeJz6QggOEqZVG6E=; h=Date:From:Reply-To:Subject:References:From:Subject; b=JtVKuED9onImVsVf3lH6o3T+5GRS9+iWnsDq0tWDHVHqYrLoxu5R9ZcpkuVG5MGiEOM9RhAgOnK82VjLMEiLCgE6PtoeHoG4ToftO4oYjVVNuM+NfYl8FASliHb0/xZsrp9Z9/Z5299WLoXNSy76YoJl/HexleAqVGiCMyVSRX4jmal51l+qZ7JjN18hryGfPzGDns5ApPSWI8KChVNXcHNYLNVsqaGPXspMvI7LpZdZHCUdm4Wb1AHtoG6mhO9BkThlxjhn0KQuxJnCOoVPRXFCM//3Pf1dW3iu+TOy5yjXCyFvh+4GgYYXe53mQ25sCV4yg7iMBh8Ryv60+NTJbw==
X-YMail-OSG: bvkeNRkVM1n1sVEcEPLKY0nrNxWPSJspmWPpnUPhFLoDz4nKKdVg_9Xtk_KzJbB
 Qd_VC2yYlCAwE4zPOhToAkeWuFwfWZ7A7aaQ18nhn1RiyEISAgknia_RI4c5UJ4E6vdOfpI17TjI
 mtXzEvqwgLt0LWJpzffo0id4m5aAnhZff15AC7gvBenn5JDzVEHsy8GIS6B8VusIClnEdH_Vkyb6
 _g_3eINtyO5GHSB2amxn3uAKuUhwFF_M5bkmG7BJzkE3x0FFmWMQpMsvdbg.aMhUHfvhOY1hAPaN
 QANdB367bmNO5tPU8EYrxxv6JAUnITsYcmzFqLKwOi4lWqUaRQc.9naXSc2sjflyhKbf0JRPmBnH
 IlhDo.6_LmVFRh8gYY2GLJNkDv4fGCiiK31Vpm00to8FrzMBwesEh5CsTBgXtlZmXwKaW8C8nc1o
 MH8dzvUIJRg5LFY4hN4TiJ2YL60xww49HKDR8CcgOUq8v9_ljU8ebP4s7ZgLIkLlPQrOf5nMGbvz
 sas9QGqODoG161szivF5U1nYjoE.cUXoaULN6yi9CrfFDxOL8_rn6TDZ.ltazZ6f7qPJdp10Novh
 T.SIqPIUPat03ExBcO1qCLFRmY3AmWpZ_N2rlsp7.lFtfmaps7DzSPFz8gILwvXQe390PB2MF4cz
 HyA.WS8ArzactN_C4KQ6XwfXgDATTbEcP_vjKCL_7pP275eL0UzmW646PH5Hkuzd3FgG5zylIdYO
 uV.EU2kLg5FQvVf.AnPZmNejsRe_Oj5abHXeCezl2OW.pz3KaZSSczEXnKy7KisL47qy1b_RM0T2
 RRUwI_3yTwx9DMVRuKO4AW9pZHe0.9EGPaI9cHVMerRSEaibU8iPdKDSHBXHsYGkn27H7CDyAxGb
 idakrJCGHaIMf935g2C4DG60uPnYFLiQlh76whS8yHqrUYuTaUoHaLiVl8_jUzvOXIbvLnSIAuYt
 HfsInhE1d3JtjgAyPHFGHsdxwj8SxnzgxyvCAZV__I7WZao5YQa1_A5T2aHMD7BAZQFEsQb_8u1w
 Hjqg6CDNxnWqnn.b_4dPKmwDgb3orpt2m8EbtimY.JCAWU15kVtFpa27.fvm8m.dZP2t_763v2OC
 DhDl.mND8enViL3LHxtBDn_zbffx_AmBLm1LmbL5H0UYB9KByi9ITA9t26bIf6Q2lpDk7fQKkqn1
 PICQUshFXMniN6TuP2xYmSyjvHWVt8enB3AAqNGenJB9SgisG.HSAHNob3FS4E8W7goTRz0Cdtv2
 RcxyDPtSYTnMpH9bJy7MNWafeMHt4Bv7QhxQYJMgCW2En30jy1S2wLE0lRmmMQgDAHC5iy4YU1Ko
 7Fyv.1tYYEgAyUlFPZ0rAE5Hi
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.ne1.yahoo.com with HTTP; Mon, 3 Feb 2020 16:58:21 +0000
Date:   Mon, 3 Feb 2020 16:58:16 +0000 (UTC)
From:   MRS SABAH IBRAHIM <absa50602@gmail.com>
Reply-To: mrs2018sabahibrahim1@gmail.com
Message-ID: <1367039307.1016336.1580749096809@mail.yahoo.com>
Subject: Compensation for your effort
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1367039307.1016336.1580749096809.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15149 YMailNodin Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Dear Friend,

How are you I hope you are very fine with your entire family? If so glory be to  Almighty God.
I'm happy to inform you about my success in getting those funds transferred under the cooperation of a new partner from  GREECE, Presently i'm in GREECE for a better treatment  and building of the orphanage home projects with the total  money.

Meanwhile, I didn't forget your past efforts and attempts to assist me in transferring those funds and use it for the building of the orphanage home and helping the less privilege.

Please contact my nurse in Burkina Faso, her  name is Mrs. Manal Yusuf , ask her to send you the compensation of $600,000.00USD which i have credited with  the ECOBANK bank into an ATM card before i traveled for my treatment, you will indicate your contact as my else's business associate that tried to help me, but it could not work out for us, and I appreciated your good efforts at that time very much. so feel free and get in touched with the nurse Mrs. Manal Yusuf (email:
mrs1manalyusuf@gmail.com ) and instruct her the address where to send the ATM card to you.

Please i am in the hospital here, i would not have much time to check emails or  respond to you, but in case you have any important message do send me as an update, i might instruct the doctor to check it and respond to you, meanwhile, once you received the ATM CARD,  do not delay to inform me.

Finally, remember that I had forwarded an instruction to the nurse on your behalf to deliver the ATM  card to you, so feel free to get in touch with her by email  she will send the ATM card to you without any delay.

Thank you and God bless you.
MRS SABAH IBRAHIM
