Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17EEA26D4FD
	for <lists+linux-scsi@lfdr.de>; Thu, 17 Sep 2020 09:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgIQHqy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 17 Sep 2020 03:46:54 -0400
Received: from sonic306-19.consmr.mail.ir2.yahoo.com ([77.238.176.205]:38275
        "EHLO sonic306-19.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726269AbgIQHqr (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Thu, 17 Sep 2020 03:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1600328803; bh=AvKiqkXaiBoApu/bCD8nrF8C++5A98G78RHlkax3xM0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=XIJfUx+8Vf86T4QcENKp5NVHvX1dhH/B2HvMV2BK0Hse79olc/Sm4EFNBrqta5UxoAQpcdcCLd9+/MPvEJqdtx+4BH/o3bKdaJdjJEn+00xHcbk7PGqHv+bfTvPudJ1F0Wjwe1IzM6VGb8T96DA8Fp8ILbfuKoQaRIgJSSWsheNm9XEOk1ct+0DAw86/JCkIl2Bw4PTQFNdZotMfHo451jVj9Cp7zCOwMXD93P5XFlfjMfrlzF9otxJo7aMfcH/FLZooMgoqsoiJCOsmeLH5U8Tfb97KPgVpxBCLyYxHfuOfjRRTKakxvpl7/Oq8q0j0Vp5W3xCK6qKnavxV1onf6Q==
X-YMail-OSG: s4ksKKMVM1mcnC9ylB5eclWRIn36EwmxfsUjOFjPPCOUNUO36aicfsJc5TJceJh
 x.N94fOcZtuqZgR48evjD47n6iOtLWgNUgqD83KLPBlgiXxVkyVOsPiVpTP5ctv7dhpxss9DmSPb
 dcYBtUleF1jGhYjx69rWBaLTPYALeWHOAYu2AlrqSi5sGCCgq30FLh9L8J5Dv6qhCNcWH1w5AzN9
 qfrLLBn1jEt9Izm_fmtP_jDbwYPDVwwBwgozbqyfdPY4c4MZGiIFPPrrG3HJVUgfARLh3Q33YtWV
 XYe2vWIzP87CFOCoZmP6MN7tQqSrbcAjoK4vOQSNb.HmjRiuI5oiCug7KtmGjiBUQr3nzpP7SqFP
 6.miQPqYLakRdrMJQmMpF9LmxAiepovJ._UciUblaAhaqGJL8WRooGEjhzFiTqroWvH9MpfrCSNL
 ZUwBCJ0aggnijUerirt_y_o0BnkN5lLQfcYCSmfljmFs7z3C8PnjzVM8eOUTQWnYdqrhBCEtGDgb
 UoTP1dNO5.JSTCYOWK0BQFDBFYQUy7ylDiEe_FX1MHpp7xXjFeCBdtrCzVDH_4khLm74Qe57BNdN
 s.i1SSEQLrWv.t.ZGabwAitlibprCac.gSXQgs8D5Tak._EXRrSMnAX8ZoNPGwL_O001a3t5GWI4
 YwEkBHFkiNzl8VqQs88I343hR3qSJOToojhPBunv4ez59kGusE.dLnYr4WQfVFmkMbfn5IXASX4m
 yQ4tpS0Z8ZrfjnY0dC40ar8UZCN.lhtvDwkv5PralhYMVjIn9yYvJ6vgda0V96bdal4sazKG_41y
 5UxEzIT.K288hI2iT2n_5.e6PjEs8H3M7.8Pyda9QgEoP3ycXdbzqz5fe17PaDQ76Gnu3FqT5Ndx
 sOhf.zF_yOOCEqaku6uYy7TuljjkML7VW2pjmM.b_w_PbR7xuNl4BlF5et90pQHJMnyESCkD1pki
 W19cg7Oae6l9oUiLqYODBOs3CS4SF2AuoyCZBK92zOiUCBohTRnyLazfq12GLo4nfqIZy8_m3GXb
 QeBQNjhxW35vv9mTA9Ey7VBm1w9niNO2QHF5.dCshpG1CaWhC1f0jrcexUS.IqE6XLgPHm78ol8G
 oIvM2aYWEunkH74TprJct3iyvM1sBhqDxaf0gzLOQVbNkgDFGiJl6yIQcuBQqysXcaN.rY9t4VFp
 DuAAL6fxUXYC1H0AH.xHoUDpiu3YF2YERtK1dASE9jzEZmOoRNjkOXx16XY8Kt0OHBNL1sMxvvMv
 he4N6H2aVjJ6MYAqD9tmRB.YWlYuOkQ_5xVU0UKZtQj6BOGUvbQFG5BTnzuq0earJhQOkjoMSTzH
 l9RUJlLMSCo9TXKS2SSMmKXphrNbeYKat014u39XMsny_lPPpJ8nKRWp_jRgxXn1DO6lmM4vQ0n_
 J9aE5bIp7y6k9VIumqLm1MEdQQYmNv5BEaBWW6S8G.ZGdLQy81o9JOfeFpn8-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ir2.yahoo.com with HTTP; Thu, 17 Sep 2020 07:46:43 +0000
Date:   Thu, 17 Sep 2020 07:46:41 +0000 (UTC)
From:   Francis <francismr4752@gmail.com>
Reply-To: francismr4752@gmail.com
Message-ID: <739173431.810763.1600328801065@mail.yahoo.com>
Subject: Please forgive me if my request is not acceptable by your kind
 person.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <739173431.810763.1600328801065.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16583 YMailNodin Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.102 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Dear Sir or Madam,

Please forgive me if my request is not acceptable by your kind person.

I am Mr.Francis Hashim, who works in ADB (BURKINA FASO) as a non-independent non-executive Director and President of AFRICAN DEVELOPMENT BANK. During our last banking audits, we discovered that an account abandoned belongs to one of our deceased foreign clients, the Mr. Wang Jian, co-founder and co-chair of the HNA Group, a conglomerate Chinese with important real estate properties throughout the US. in a accident during a business trip in France on Tuesday.

Go to this link:
ttps://observer.com/2018/07/wang-jian-hna-founder-dies-tragic-fall/

I got your contact from yahoo tourist search while I was searching for a foreign partner. I am assured of your capability and reliability to champion this business opportunity when I prayed about you.

I am writing to request your assistance to transfer the sum of $15,000,000.00 (fifteen million United States dollars) at its counts as Wang Jian's last foreign business partner, which I plan use the fund to invest in public benefit as follows

1. Establish an orphanage home to help orphaned children.
2. Build a hospital to help the poor.
3. Build an asylum for the elderly and homeless.

Meanwhile, before contacting you, I did an investigation staff to locate one of the relatives of the late Mr. Wang Jian who knows the account, but I didn't succeed. However, I took this decision to support orphans and less privileged children with this fund, because I don't want this fund transferred to our Account of Government treasury as unclaimed fund. I am willing to offer you the 50% of the fund for your support and assistant to transfer the fund to your account.

More detailed information will be sent to the desegregation explaining how the fund will be transferred to you Please continue to achieve the purpose, Reply me on my private E-Mail Address: francismr4752@gmail.com

Waiting for your urgent response.
Attentively
Mr.Francis Hashim.
