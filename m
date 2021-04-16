Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73800361E60
	for <lists+linux-scsi@lfdr.de>; Fri, 16 Apr 2021 13:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239137AbhDPLDz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 16 Apr 2021 07:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240039AbhDPLDx (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 16 Apr 2021 07:03:53 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5476C061756
        for <linux-scsi@vger.kernel.org>; Fri, 16 Apr 2021 04:03:27 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id u22so2745103vsu.6
        for <linux-scsi@vger.kernel.org>; Fri, 16 Apr 2021 04:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=F+IuJT0hgzvpcV4D7IiN+RvqQSrL8J3rCid04rVRp7Y=;
        b=tdoaAc57AHopBR35s9oo/yi+SfEQ5Fpm8sEZ/vPL6sM/2OKctuRIq8AtZMyTwMl8dZ
         HKye4DmIqFZ8WYKcTcJtMiRL8ayvG1UgGbK/6IuqQkEW3TS/H3kh2qVkchCHw1wadJPR
         /ZXiP+zKQJpQG1Ww0WZ7Xq2f05De7Y4zv66qTVYNGIN6suANhB2CVW9H7vn95G7V3SaR
         SVaUyU4YfVULJb0AUSdATq0Zof1bmA6cZZt/ANjsb562yW/5cVnkLZl+a7pAVnXe+bq6
         kMMPTLnmkFBrnQ96fNM7JMwsA3XxucYCHS799XrEjoaBDHCcAyc41wGeXCOrCfX+EOUA
         bA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=F+IuJT0hgzvpcV4D7IiN+RvqQSrL8J3rCid04rVRp7Y=;
        b=jKcH2VTwT7KxZF/dGM0vbij2KRHSiLy8Qs9aW0fsKKM6iFFb1O+e+pEchQ040fS6Ay
         svTgEk8y7eXYIWlopAuwOCi7jnny1oWKQpxG2Q5dbfvi/CZgvO8mENOTvZ23hpH5nUBb
         nGzNyR3/TG16PJUrB7+qZr93PjhOpRKbqWKu0xWRAmJFpKCoTf1OJ1dwvV30VSUD1fet
         xDu+RjQ9BFirHLbG4wQdivpZ5q24dSEHeN2LRGwe5ZmPWj4gAjI1vpSAzKlWurtggRyU
         iQi/dgWJYpACyYpLeiXg3R+AkRaAk9ENJ1npyIjWiTcacY0Nq5MwY1O0ScUPx4ELOhyT
         7sGA==
X-Gm-Message-State: AOAM530SoIgpHFSpLIKs7UVbdDmEviqXsjdKPbaVTMYwJV2MCWnWDjy/
        ShM/mkqmqQnyGaJur0DzFGiMNmUy77oevHoXgTE=
X-Google-Smtp-Source: ABdhPJy5mfsY+/y2N02FKzOxiLS5wA9OHFNOYVfHCheNjT27MQG2bOU6pYKKbTXhq3qCVbD+e55n7f20ufaLNCW3qn8=
X-Received: by 2002:a05:6102:e8e:: with SMTP id l14mr5908841vst.32.1618571001155;
 Fri, 16 Apr 2021 04:03:21 -0700 (PDT)
MIME-Version: 1.0
Sender: engineerruebenwi21@gmail.com
Received: by 2002:ab0:68a:0:0:0:0:0 with HTTP; Fri, 16 Apr 2021 04:03:20 -0700 (PDT)
From:   Lila Lucas <lila.luca112@gmail.com>
Date:   Fri, 16 Apr 2021 13:03:20 +0200
X-Google-Sender-Auth: vx-N5cF9_Cg_O6w6Q67KZM2iySE
Message-ID: <CAAweWXuhAs=5oS4=xPh5C3NCgyW7OSwgVY014mn8NM=x-EJTWw@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Very Urgent

Hello Dear,

I know this revelation will keep you wondering why I should trust you
with this information I am about to reveal to you. I do not have
another way to communicate with you only to send you this email. I am
in despair and my heart bleeds when I send you this letter with the
hope that it will hold your attention and also I want you to make out
time to read this mail attentively in order to understand the reason
why I decided to contact you. My dear, haven=E2=80=99t met with you before =
I
decided to contact you due to the urgency of my present health
situation here in the hospital. I am a widow diagnosed with brain
tumor disease which has gotten to a very bad stage which has gotten to
a very bad stage and presently I am partially suffering from a stroke
illness which has become almost impossible for me to move around. I
was married to my late husband for many years before he died,
unfortunately we don't have any children of our own, my doctor
confided to me that I have less chance to live as a result of my
illness. My late husband and I made a substantial deposit with the
Bank, which I have decided to hand over and entrust the sum of ($
11,000,000.00, Eleven Million Dollars) in our joint Account to you to
Invest into a charitable project in your country/position. Based on my
present health status I am permanently indisposed to handle finances
or any financial related project following my diagnoses. Having known
my present health condition, I decided to contact you to claim the
fund since I don't have any relation, I decided to donate what I have
to you for the support and mutual benefit of the orphans, gives
justice and help to the poor, needy, elderly ones, disables and to
promote the words of God and the effort that the house of God will be
maintained says The Lord, as I have been touched by God to donate from
what I have because it will be a great loss in spending the fund on my
health treatment hence my doctor has confirmed to me that i will not
survive this illness.

This is the reason I contacted you for your support and help to stand
as my rightful beneficiary and claim the money for humanitarian
purposes for the mutual benefits of the less privileged ones. Because
If the money remains unclaimed with the bank after my death, those
greedy bank executives will place the money as an unclaimed Fund and
share it for their selfish and worthless ventures. However I needs
your sincerity and ability to carry out this transaction and fulfill
my final wish in implementing the charitable investment project in
your country as it requires absolute trust and devotion without any
failure and It will be my pleasure to compensate you with part of the
money as my Investment Manager/Partner for your effort in handling the
transaction, while the remaining amount of the money will be invested
into the charity project there in your country. I am waiting for your
prompt response if only you are interested I will give you further
details of the transaction.

May the peace of God be with you.
Sincerely Mrs. Lila Lucas.
