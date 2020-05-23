Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA3A1DF3A4
	for <lists+linux-scsi@lfdr.de>; Sat, 23 May 2020 02:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387433AbgEWAyS (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 22 May 2020 20:54:18 -0400
Received: from sonic308-10.consmr.mail.ne1.yahoo.com ([66.163.187.33]:43714
        "EHLO sonic308-10.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387413AbgEWAyS (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Fri, 22 May 2020 20:54:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1590195257; bh=/TJiIzIIuce6D2+HRnkGz5JeLRmuoukM3R4ut1a7FUg=; h=Date:From:Reply-To:Subject:References:From:Subject; b=LgYGSVB4+HO9vh28aYMowhkV6OQMiKx+2YrlfeCp1u0wexsxV0KlU/lCTBTzJC4kTweg3uFtMpFJe24+I7EEoA1VA/227pL1d9GRrJY9bMXRpn+deb/mIPD2DuLXVQkZk5N08QMhO+d+k1Djx0qFQLHkXz95L5KJj3vYaeZSIy72N0vDAT4f90QJT6Zd/Ke2J5LDC0ckUVUS9SLwntoyb6hLYNBZoJn3v+HHF0SpvpnYlI8mOzg/hlm6crxq8pfTaeVkpCdLx7osWpIW15qOMFyaGEwvqDedO+aAC+zIJ5JZovCAExdzlUfYx1OEvCqp68b5L1I7TPhlwJBfeQSogA==
X-YMail-OSG: FFhi3dsVM1n.cXyPNd4J0RVXLPZ.3NoHIPluIVkuGQec8kSMYuhxmYzqCl5pZ5u
 1TpwKyN4rxtc_S.vHLQlAk4._NDsy.xu4fMhmZo4cYDaVR1ZEk5dJ8Tn.0Ctu07s.QkdRi0OLcAQ
 CitDRXnYfzSHsbfgcox8rw3lmS1NV8U6WYY8HdghEcDnZmc6i6pia40s4HK4YRxrnd_PMeqqUOdn
 jERJfvc9eiBVq2fXPS0zEOgi7Rra0Ve.GIJ0CstMbUBfXa99LQxrVsUFPh2Hw4KzvU0eClulmbYO
 VEwoKVvsjOHgzoNz8KINDTlYmg2ewq3lapWzDU.FnO9b23R6lze3Fz6nn6enDW97M7lkco8V8zpY
 JYVJ_9qrf2wnx.rpqkwUh5PwVxoFAOnEIax6Ft3sagFf5.NlDsGa5Bm4yOHl7sAxjNX44L6kRz7I
 5tSzK4TvtcvA2yMvQeU.QNEuqZuFrHUkkkpIVXG9xgmKmRVPXW30Gdj8AvtG4hJrZUmTDdYdlUlF
 jgk.t52u9CHKPFSJUczfvFdnKitAPv1.UhsdKwD8Z7dU2sbTOmzlhCxnItQo9TSX__RwzMSnbJZ3
 QwsuwYK6VSQem0LScZVL7w2c_LeMkkvG6WEH1WiQBUIJEi3ztSSdPOwBJ3pXoxWBTQQVRltCcI9m
 oU49_.ok5PdEDhv9hZv.sYQNqgJK9VQHv.zNECEeEaIEyRjQ0nu572r0TYLzl4b0VIhlVSOoFJpT
 WykEqzLjhRnNGcjHG1TJizYmX2aj4eN9eKVyZzSb1lDSZ2TyGT59xdl6PN6EFGsv_1dV0cAZ_iSe
 K.nq1lZjDmH2vlkT2wf0nSaUf.zuRxHJh5vkHkSpsY9PteYYhNeBwMe6VQZl04C_Lelg8G1D0fIa
 hawo2hpxHN5kQUMldTvF2j9K8sNJf90jjQRK5hvO4oaohjBQWLoCnAIF7U39rP1TsK1C9IrJxZga
 TmqNZYI0v7G3nnOr2GvPsTT8p6JEuUErE6rpo150nxRpBo0snRIeVQQhnLEOCE.Mqv3U21fqEEk5
 YCz0QIyr0TBinbc1.WEo4KdwWNft0DoPSHJCLLPvU_4R9WvKrcnqz7y.ZdPddmiFSQMWAAMFrvKM
 _BZDv54oIMX7X3Hq3qoi8uNcprSL4XE3SgblhvllPKC..eOzPzIYYZV8LeLZjqsm9ADX_LeJJ2q9
 ypvIK0l1KUMYce7X9AR5lgCBjbnqn.iGhJpCnrOD_QFcIA1ziARsB6BXIPNj2Gwj8nCP.lGAwB1F
 1n6oNp.eFk5.Pw1hLbTkKDaruklc0sv.x_9v0j4KOQAGWu5nUAZQbQKmZ5PZIsKlsrKDgHuVrXqF
 MK1ugSPGzl9eVdzdQAfIfzQS9ySpyfJ_0oL_zvA_f9SfHjLodtIe4UZvhRUVOPYqDOxjuoERK9Pn
 ZFrY-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Sat, 23 May 2020 00:54:17 +0000
Date:   Sat, 23 May 2020 00:54:11 +0000 (UTC)
From:   Mohaiyani Binti <mohaiyanibintis100@gmail.com>
Reply-To: mohaiyanibintis100@gmail.com
Message-ID: <567257572.136224.1590195251917@mail.yahoo.com>
Subject:  Dear Sir or Madam
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <567257572.136224.1590195251917.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15960 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:76.0) Gecko/20100101 Firefox/76.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Dear Sir or Madam

I am Mohaiyani binti Shamsudin, who works in ADB (BURKINA FASO) as a
non-independent non-executive Director and President of AFRICAN
DEVELOPMENT BANK.
During our last banking audits, we discovered that an account
abandoned belongs to one of our deceased foreign clients, the Mr. Wang
Jian, co-founder and co-chair of the HNA Group, a conglomerate Chinese
with important real estate properties throughout the US UU. in a
accident during a business trip in France on Tuesday.

Go to this link:
https://observer.com/2018/07/wang-jian-hna-founder-dies-tragic-fall/

I am writing to request your assistance to transfer the sum of $
15,000,000.00 (fifteen million United States dollars) at its counts as
Wang Jian's last foreign business partner, which I plan use the fund
to invest in public benefit as follows

1. Establish an orphanage home to help orphaned children.
2. Build a hospital to help the poor.
3. Build an asylum for the elderly and homeless.

Meanwhile, before contacting you, I did an investigation staff to
locate one of the relatives of the late Mr. Wang Jian who knows the
account, but I didn't succeed. However, I took this decision to
support orphans and less privileged children with this fund, because I
don't want this fund transferred to our Account of Government treasury
as unclaimed fund. I am willing to offer you the 40% of the fund for
your support and assistant to transfer the fund to your account.

More detailed information will be sent to the disaggregation
explaining how The fund will be transferred to you. Please continue to
achieve the purpose.

Waiting for your urgent response.
Attentively
Mohaiyani Binti Shamsudin.
