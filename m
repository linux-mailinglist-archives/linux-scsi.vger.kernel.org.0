Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8594D1C628E
	for <lists+linux-scsi@lfdr.de>; Tue,  5 May 2020 23:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgEEVBz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 5 May 2020 17:01:55 -0400
Received: from sonic314-14.consmr.mail.bf2.yahoo.com ([74.6.132.124]:44804
        "EHLO sonic314-14.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728969AbgEEVBz (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 5 May 2020 17:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1588712514; bh=TYgdp/zNeW9P5rVjVpFopjba7a+Fm8hxyemx2bQVZd8=; h=Date:From:Reply-To:Subject:References:From:Subject; b=TZcybDLxX4dkZhvXjiufsU35A4MzMOsgjFXidE50enOkCjQXvUuHcmWlJOBbJw3nmcARIQNrWiT9reS6H/GLVmr8B3BOGUHmjb9CaZFk1+QXxIt8jIOu+f5B19BnJUPgcSp2r1vVEL3BBMuyp0ydLdlUSf044b+5PW2flSGCWyhs+eKCXr5DYbHUoaQjhag55TFXJHBfVFsila22X/N6eC5OPTR8xK9zgOuppqBzyxdzSjYF57VOgs7tqlqiw7IgzqOBE9F8ZbNgE1wbKQP80Gsgeieed9S/iT22PKv/v92FCl+WjNwnBjtbeNZxbhKadb5efp8DEin2MQZAepv5eg==
X-YMail-OSG: tGpajZEVM1nzAsv3uVnqTQgVa0tyz.Km7Zh92hzC2kou0zYoAbYvv8bVBdK2wwb
 J.b72zI2OqMvCp4tlcAoTQ0meVT4vxPpYs7l_ZWvdWD6V4._Gjvawk1bXr9K7oLlPmMmH2r0LVps
 21fNpXnB64ANppoOCSF3R9KoSQnBHwV3UasL2hJga44MBot4Bbnrj5KIDR.QjbMxbXcgS0Ph2XIX
 j56OH6kO1RLvEzvMVqbLsNqbNTFzu5KUqjeFsU.HgS9iIXYfQjwnrRIB1LFG2WoPzTLMshMElXnw
 xT.3oijGyPJXtP58CPUjjinmbc6QlZNirMdXzTxZ4xD776hTfUmKHL1NNoQje2gyv2udojFZpKY4
 lWJFIUudsOCvVbb32tYwBhKr6T5UiisJr.6LvcSfQSsCnhANNcRjYRpF_3eVeH4quCgTPu3UqO9X
 HNLOogNbncOrsUf4DWzAFBBW2wSLiu6bqP1MIeB5_2F9UzCliV6e_6xb4zivKj6RNiZ7zDcmLdqi
 5NFQg2_yuGwzIe6t3nDuoL5ZYOW.eMqPKlJoOa3fGB13RImGIUuPy2D51cm4Ww5dobAb4llIp_Yz
 Ona4kOaOcxQFh.hTgjC3Oos6wz4HyUbz9sHLq8kK6tiw7T_ofne2PO0FtVNogbQFQ8w7AdKa1qka
 0IUga1HbgAVCVqqfzChR_KuOxaL4EjCK8y3AEd06h12BTlXVQUg4HNZz_VyXjPBwk9TgpvJoBY4A
 t1hjp6KMq5OCsxkH8rVwZqfZW11hY4w4InpiHQ7YueqDIa2WMcyqmsLV1UaetsNaT5xJ3BJsfZOJ
 BRGmktwna2JublBhkp1LIbbRCBVMAC9BWTVOpNw.O2OP7Yh2d83HsDIBXrCUHJ_vTjL4hMEFbuDk
 vAu3.NztL.JWyOlr8WYx1rwMR_avHF7CsvRo67WxymPEvxu4SVffP_bC7284IBwuM7mgUmTn8CEy
 dM2QlBhrolO4x9bFZexMfeyP40XRpGbq0grAwdI4R2lD2.qFYe1BBk0q.TBtpAP6j4TQ8B9p0_Yn
 qd8kCHjEuz9j2ZM9_eE4ZJFr7TwEcKomXd1qJOjWjAsmDOtgUMypZxiHaffIGtH_u_V1Op8m_HGO
 p2rodbVmJm4XQ2En09G2GTJMhHI0_nr4Szgm8rEb8e5jMOWvFhpP3oCt2b9Psz9ibkZVewVPlKiA
 R2Au91POdNXoATC3Eo8OQrV4Wqhh44d7RKmKcdGK9peq1PNz.dax71MYwJ9KSRA1dIG96uf0.kTT
 5X3w1JMwQ6o4QDXWdZjXRgegzBtCKgpeOCima5rFf..a_.erKXqnGZs4mtbD1dwn63SuOhnEz6C_
 RECWKj0dm1wZKeKePhGbTm8D4TiP_
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.bf2.yahoo.com with HTTP; Tue, 5 May 2020 21:01:54 +0000
Date:   Tue, 5 May 2020 21:01:53 +0000 (UTC)
From:   Mrs m compola <mmrsgrorvinte@gmail.com>
Reply-To: mcompola444@gmail.com
Message-ID: <1871545299.1235281.1588712513516@mail.yahoo.com>
Subject: Dear Friend, My present internet connection is very slow in case
 you
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1871545299.1235281.1588712513516.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15756 YMailNodin Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.129 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org



Dear Friend, My present internet connection is very slow in case you
received my email in your spam

How are you today?.With due respect to your person and much sincerity
of purpose,Well it is a pleasure to contact you on this regard and i
pray that this will turn out to be everlasting relationship for both
of us. However it's just my urgent need for a Foreign partner that
made me to contact you for this Transaction,I got your contact from
internet, while searching for a reliable someone that I can go into
partnership with. I am Mrs.mcompola, from BURKINA FASO, West
Africa .Presently i work in the Bank as bill and exchange manager.

I have the opportunity of transferring the left over fund $5.4 Million
us dollars of one of my Bank clients who died in the collapsing of the
world trade center on september 11th 2001.I have placed this fund to
and escrow account without name of beneficiary.i will use my position
here in the bank to effect a hitch free transfer of the fund to your
bank account and there will be no trace.

I agree that 40% of this money will be for you as my foriegn
partner,50% for me while 10% will be for the expenses that will occur
in this transaction .If you are really interested in my proposal
further details of the Transfer will be forwarded unto you as soon as
I receive your willingness mail for successful transfer.

Yours Faithfully,
Mrs.mcompola444@gmail.com
