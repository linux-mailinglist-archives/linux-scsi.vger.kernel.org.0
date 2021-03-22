Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAFD6344BE6
	for <lists+linux-scsi@lfdr.de>; Mon, 22 Mar 2021 17:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbhCVQkk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 22 Mar 2021 12:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231950AbhCVQkG (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 22 Mar 2021 12:40:06 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDE8C061574
        for <linux-scsi@vger.kernel.org>; Mon, 22 Mar 2021 09:40:05 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id a143so7232360ybg.7
        for <linux-scsi@vger.kernel.org>; Mon, 22 Mar 2021 09:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=DYfaicAOehb5zQydfeSGelJNMvzJ7Pby8HrjoL/bqDo=;
        b=pXSh5SBhukSWztfzSeIa1d3OaD7TsCsUxdC2L2bfx6GL5BXWBTgQdYXyYOTK3Hkkoo
         utVNBL3AIStWQfK7D+LiWb+HrwfRJ1dan/Z3pS491/ymVYq7EzqmDmRELG8/3R0gd6bQ
         4FWWA/f+Ccygjf83Xn0pFRGJNOoBaGAtvVklouDPgIz09Biz18oZ2zy9cMMQPbS2xZO2
         n28htWaID9q/c3iVMSUBMgZVmbURhiWAi5uMrMj4Wlhjf+BZMq2Xh9cSCNxXeR4O/NNO
         6wYaoOGCiWFhUFSOjkRx3FbixI7nEr6waIwtgg7FLRzfR3f8oJCuyjb4JWGrdAFhAp/8
         A+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=DYfaicAOehb5zQydfeSGelJNMvzJ7Pby8HrjoL/bqDo=;
        b=nH52bLNl+/5zEZbBmrwdwo+bydv+QtKMlOMng9lRyCLkj02+TZuE2/UB9JJxRhj1jW
         o4xjU6VJXG4mbJMQ2D6rg2VCqJkD38DzelYN/2y6MyOsHwkq6IgoEh4TGpPJTZbF7kR8
         FknxMJlJ//uzhuVB1XBvksrGG4X6ua2+yXTUjBOrnHY0mya1RtpqUBsiMcQcVm0BETLL
         +icsgbONUxnUsrhZTYcTKLjHucZV4mJoyfiYIS3g2sXd52egTt6z0oBgM24898QOI+Oi
         mbc+CPYyt1Hjaqzvbjz3fSC47sG8WLNVyJA0MO24C2NOtNpTJjhQwJTvv1FewYVUU8Lk
         XpTQ==
X-Gm-Message-State: AOAM531m7bX3qKtnJBF3W6q3Sm3Qn3yf16o22vpgjzRGkQIN8trd8gdk
        Ix2gOg54ysydnSL7gMcquPXmu10CZFEy+vgKtLg=
X-Google-Smtp-Source: ABdhPJxfVNXDm/5jiy2GyKXakg47Z6d89aKilRkqgfGFrkSFaRxfYyrG1srVsADs3w3y6Xu6e7z0gluzsbwBTyrppB4=
X-Received: by 2002:a25:aca1:: with SMTP id x33mr566857ybi.412.1616431204885;
 Mon, 22 Mar 2021 09:40:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:8044:b029:3e:402f:1c5b with HTTP; Mon, 22 Mar 2021
 09:40:04 -0700 (PDT)
Reply-To: bazaatg@gmail.com
From:   Tchao Ago Bazaa <pokpouku@gmail.com>
Date:   Mon, 22 Mar 2021 09:40:04 -0700
Message-ID: <CAGUTktwfPmG=yb6NfNDmrxr2ULALmDPBvw0xdRiOZz6SxAFVEQ@mail.gmail.com>
Subject: Hei
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hei

Pahoittelen, ett=C3=A4 k=C3=A4ytin t=C3=A4t=C3=A4 mediaa ottaakseni yhteytt=
=C3=A4 sinuun.
Nimeni on Tchao Ago Bazaa ja olen ammatiltani asianajaja. Otan sinuun
yhteytt=C3=A4 my=C3=B6h=C3=A4isest=C3=A4 asiakkaastani, jolla on sama sukun=
imi kuin sin=C3=A4
ja maasi kansalainen. Edesmennyt asiakkaani kuoli auto-onnettomuudessa
perheens=C3=A4 kanssa vuosia sitten, j=C3=A4tt=C3=A4en l=C3=A4hisukulaisens=
a. My=C3=B6h=C3=A4inen
asiakkaani oli liikemies, joka harjoitteli =C3=B6ljy- ja
kulta-liiketoimintaa t=C3=A4=C3=A4ll=C3=A4 maassani.

H=C3=A4n j=C3=A4tti rahan talletuksen arvon (vain viiden miljoonan yhdeks=
=C3=A4n
sadan tuhannen Yhdysvaltain dollarin arvosta) pankki, johon n=C3=A4m=C3=A4 =
rahat
talletettiin, yritt=C3=A4=C3=A4 takavarikoida sen, koska en l=C3=B6yd=C3=A4=
 yht=C3=A4=C3=A4n
perheenj=C3=A4sent=C3=A4 kauan h=C3=A4nen kuolemansa j=C3=A4lkeen, joten et=
si
kumppanuutesi, koska sinulla on samat sukunimet my=C3=B6h=C3=A4styneeni kan=
ssa
asiakas ja luultavasti samasta maasta, =C3=A4l=C3=A4 ep=C3=A4r=C3=B6i l=C3=
=A4hett=C3=A4=C3=A4 minulle
seuraavat tiedot alla olevan viestinn=C3=A4n helpottamiseksi ja yrit=C3=A4
vastata yksityisen s=C3=A4hk=C3=B6postiosoitteeni kautta saadaksesi lis=C3=
=A4tietoja:

T=C3=A4ydelliset nimesi
S=C3=A4hk=C3=B6postiosoitteesi
Yksityinen puhelinnumerosi

Kiitos

Herra Tchao Ago Bazaa
