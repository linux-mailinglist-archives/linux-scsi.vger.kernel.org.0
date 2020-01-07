Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90054132928
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jan 2020 15:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgAGOoa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 Jan 2020 09:44:30 -0500
Received: from sonic309-13.consmr.mail.bf2.yahoo.com ([74.6.129.123]:41921
        "EHLO sonic309-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726937AbgAGOoa (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 Jan 2020 09:44:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1578408268; bh=E+ks7AydzaUb4ISZTuxin7s0E6gVmk5020fTLYVYB5E=; h=Date:From:Reply-To:Subject:References:From:Subject; b=UA2ED7nwSCDJ5+pZ/2hzvGogPSTx64IJYWPmlWykRKnWeH7mJQ0SfXcIGEY1ZHBOuvt1s3LFhhphIVusPuHPYg5Fj2gJkKca+J8AuHRj0U9k9vZYphbkaq5kA7/5HiMaPZ7xNHNMHMrUxA8MU1zB/nQ8G6BCbksXfosWiUOp6kVjcfSw894aI4NPYb4Oi4Eu6g7x4Bu4m783mB1q7kAbULFT36C4lBk04aqDBD0K8j1CSZvOLFKAQMOKVjxGtXGYDG4OYkPc9NJqQ4jRLWsNcjW4qu6jJBOcQD1D3gxIzYXDtm2AKzwUF6pU+1oZ9tmx5/fo+ORqJOvZ+71zCycidg==
X-YMail-OSG: vL7sdEwVM1mrebXaZBKKqokVl0661s5_J3g3j0XHRJX648nCgkYRHRi89H9C05e
 4CjN68ch5Cifg5Ub6DccLzmX5wtE__ThKxDxjXIMd1ERbKulxdK3GCiZu8z8hM_MaPAm_Yvn0pa9
 GHtnsgAiI36R0Y9HM7kcpSEF4LXUSpf6o1kKEQu.X8yPv.kV51PNUsf6OjXZiWM_COJf3jSB0ZfL
 YSNlcF2H3VFfa5uP1T2mSpEzTm5WK5743eo2ioUctF2OzT88DzTKe0Nn8flB2jFVrE3tIgwBenOf
 RMxA2eNx2Td73CqxP0Js4gKshV35YrjgLWpT6nuCJLHxFZqOb75qxucNNYNDdpD.XCCudegRVcx2
 eD6Sa0.FcpGuyr_IUQnbfuGo_p3bB9bGnmo8TEi.U3ApfevISMF0Up0vBDBBGs1828GuyGMDDbnP
 y11JGj9mUF5YdEO7OR80rLRS8Wkr2tpwvPXayqp857E9oTpTMLawUhRhGGKFHjmxDt_MJfWbSCmM
 TQUjkDFyotVAlSBl7PQ0IxI5MB5rfxl_hzQpMJ99De058FDAfpBb5j0BLucVHqillBOn8SUW3DtX
 QVp1WRV1rYdoE38Qtp3OSawZlV1GwDdQ7f6HNq4HqMZdzwfmv_r4C7IGusFVqhMKaMG10VPNqjC.
 it07SR0M2yl8Hire6LwOxdz4WWeyvplbIRiZtCvU.VDdLwFIqEF4sAWUNlPt6__MR_G6qxnZyoDQ
 OKx5tuCuwoG4sZGyMoXYke2Tln0OZ4bZgI0uS1VxgH3uItHaMDCkxMEQPAwLkvwQG4fpNZKQy4xp
 TRDeQXKC0JhL9OZjyg.8PxZ1JiqTsCULfGi13w.SKzPA_iR.aXMAeZVvwyKcEn3ZPVeikK.VBAXU
 aFjh_uC.VFVf_7NnEZ9CASrkjt_TvBpzELrWp6hEFt.x7qIx1b1vD1eOj3bjQg8jvYKSSJRWCwPT
 LT26Lt947_lCTDbkfLsjLCnd5wSVLFV6TCsoqjJc5yIwitFlEc1PAs9SzKpat8M9qf3c36b0bSRL
 SbWw3ClKzBDg_XnBwievk8ysLOgBWuOT9TYRHfkctTGnaEdm6yUtR_Rgnr7ZmDay5ihuJRAPn3wg
 0DFWtzU8HUBR53TvA4LYDJqJMEJvF7vQyh34LeslARrEvEawipP.zyCNebDHgdfmlH.dCpTdEUgC
 bkRXbP5tUP21ktDEjEBkgRxaU_q8N0yXZp9De6j.UQe5wRVYmqW5DqQ27fhuzPpKVJIP88MUZ5wY
 3YodygTbJTlA4kcqXEKRkU8DdyBRWjdqAKKnF5W5Hy9SKTv1hCCstn4tomAXexIbnBHWvUrPW4uE
 ._f0dCj6eX4aAsuHX.3wdgQigiQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Tue, 7 Jan 2020 14:44:28 +0000
Date:   Tue, 7 Jan 2020 14:44:24 +0000 (UTC)
From:   Aisha Gaddafi <gaisha983@gmail.com>
Reply-To: gaddafia504@gmail.com
Message-ID: <286698621.5177103.1578408264683@mail.yahoo.com>
Subject: Dear Friend,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <286698621.5177103.1578408264683.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.14873 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:71.0) Gecko/20100101 Firefox/71.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Dear Friend,

I came across your e-mail contact prior a private search while in need of 
your assistance. My name is Aisha  Gaddafi a single Mother and a Widow with 
three Children. I am the only biological Daughter of late Libyan President 
(Late Colonel Muammar Gaddafi).

I have investment funds worth Twenty Seven Million Five Hundred Thousand 
United State Dollar ($27.500.000.00 ) and i need a trusted investment 
Manager/Partner because of my current refugee status, however, I am 
interested in you for investment project assistance in your country, may be 
from there, we can build business relationship in the nearest future.

I am willing to negotiate investment/business profit sharing ratio with you 
base on the future investment earning profits.

If you are willing to handle this project on my behalf kindly reply urgent 
to enable me provide you more information about the investment funds.

Your Urgent Reply Will Be Appreciated.

Best Regards
Mrs Aisha Gaddafi
(gaddafia504@gmail.com)
