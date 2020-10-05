Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9F92833F4
	for <lists+linux-scsi@lfdr.de>; Mon,  5 Oct 2020 12:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgJEK05 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 5 Oct 2020 06:26:57 -0400
Received: from sonic316-13.consmr.mail.bf2.yahoo.com ([74.6.130.123]:38315
        "EHLO sonic316-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725901AbgJEK05 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 5 Oct 2020 06:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1601893616; bh=51b8iCv2o/XuW5NVwz+YASBZ55BtniRIGnUtcG5W61I=; h=Date:From:Reply-To:Subject:References:From:Subject; b=hpV51MXJw+rQcQuH9L8rzQG0zLch7bgT7MvlYeqoe5y3qx/B9aO8vPKD1rXMkLpctf8Fcdlyvqqh3+9NtZc681XZf1HsC4TWw4rEQ2J2q+hV6vD2CiekPKCPTA7IUgQCeCimlEYywtuobENuqYksELtg5AJrRnr9ekMRqkc3U8zggL68AIaUBHf9Q3pEpYDnuRZqyhFjxzlHhc+5Zl7SwhhWi87g1XVDRFLHv9aO88BHQhIyAAagG1fyXrEPpiZx3zoq9w5tzGUR0u2uDcAt5vgjqIAuEtuBpfzk61mwE8VwW+xyJtfuuSXuOeKx5duMid6SvBhr7/P2fWiXf+T7+w==
X-YMail-OSG: zSXmAJUVM1koTUtcNZuePo8NgigklJw1LMxz74NrWXwZvtUa_ZLy.L3POH0CoxL
 68R9UeejnewdwsvMWqhCJO0RA6VOCJ4YwvmCtRTJuUw5Tjzh4IXZ9diSIX9Z0okU3TIzE9YIp8LD
 Vz4.Knh1Ns9_.iwAXvVEvZQaJ6FL4RS0sSfnBgQxoXl0aqVTasbHqRBGQN0a.SNDoL0pEd.LJGe7
 KfUJQGUvA.oNZDRjRyn4Supz3OhHJIlfVT6e0uKOs8SinhWifsKGXttReNUKVqos_FRkdU9duBV7
 zSdPrL_GGOO6GIOQj4TEz7FGZlW4THQ2UfTMZMbxtUE8h8hGvDthfNvpC4EeUcstZwrFUHdIYK7f
 1GVuEGb8JfRW_glWVQ4ud2rb31hwBv7nqSHjBNx7RutohsqDhOpyYyF4jC5zpks..yPr2kbWlbdd
 vitpNZ4Au6.n52mIAfkdjZIfkLSnbp1VfxkwGlDAKfaBmitFkFa7XgXo8w5.FJHq_vX37jVT8g.M
 pUJ4fS4ba1k4empjV8j92dEviUhQsabZhWVgp6LOBswGYQxsP.FBCWsA3UNhAwPWfBXFGdxURV7P
 3U9Ggg5AIL8xkXiNSTRM5FapUOlwlb02nBm8SW3dgFlvSWg.TH_pwv0QM7Wn_WF2meXsD2Afj3u4
 Wv3825RzQUi1Firjy1S1_ig8NePMGeqrUoUMM0eOzGPy2gQ6P_3ao55bz7wU.YchrM07PMJ5q_h_
 Gg.jxPTEddhYJ_Q8idaJpVKqcdn8ByMV3rqklsRZOHaQJLD_FCXm1XksbUOJK6xh2fQQEHNVCmDh
 eD5fuXimxgmSbbvPPO9YraJKi_LzCmQgLV_6sLtF5o108ohRdxQrOP6RdwsCrj4hFGQdmtvUDkS5
 3sikeGwFOMADygyVvqAUN5uFND2qLS7w3.XY4h676UjvquhZco3Jzel0Qx1.mQXwj0dA2nj7Gdmt
 MZxeJYCuhVnnGNPNfjyJQjAliAnOL0RB_8XflpC5Wk_.Dq5AgZTp5VFhWgkE2.TdvqweBrULY1EP
 C5ktxGKS3GfUrrtSLifqvAqMZljNJeudNYBXHZXNJ.yHjjqZ2HmshLc4DkLB1syeo79XnpK3kRjk
 0RfR_0axn.buvMiCDPhx7ELEb9TUI.3cKC73.h7oI0hRG3MuMJkwdJlnf8zvL8yYNpzmld0Jpr63
 .y8oQQ466UbV2Gn6no2qpS0KMOgrMSHHqlcZV6sntzeGL6kTPzas3O.YeliXhONPeKhcd8CpVvfh
 snjN_kxjSg6D.YCzUIqZMBHIxxkBTfQjQtxh5eW0THTvtxbT7RBUJcUSNf0NcZTntKQDmNKgoxWJ
 z.aDquh_3BER7ND94R7xk4jyr.RJ7._dsjBk0zHUe42oopdRqcf6kAR0LAbzcDGw7_75mL2f4bUK
 4lGlfFqTiHjdrJC1SwOq3PIJaZ3jcGxQf1eraAtvFouu3eaY-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Mon, 5 Oct 2020 10:26:56 +0000
Date:   Mon, 5 Oct 2020 10:26:55 +0000 (UTC)
From:   Ali Shareef Al-Emadi <alishareefalemadi465@gmail.com>
Reply-To: alishareefalemadi465@gmail.com
Message-ID: <869424730.1792978.1601893615045@mail.yahoo.com>
Subject: SORRY FOR INTRODUCING INTO YOUR PRIVACY
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <869424730.1792978.1601893615045.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16718 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:81.0) Gecko/20100101 Firefox/81.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



Greetings.

I am Mr. H.E. Ali Shareef Al-Emadi, Finance and Account, Qatar Petroleum. I have $30m for Investment. Contact me if you are interested; I have all it will take to move the fund to any of your account designate as a Contract Fund to avoid every query by the authority in your Country.

I sent this message from my private Email; I will give you more details through my official
Email upon the receipt of your response to prove myself and office to you.

Email Address: alishareefalemadi465@gmail.com

Regards.

Mr. H.E. Ali Shareef Al-Emadi,
Minister Of Finance.
Qatar Petroleum
