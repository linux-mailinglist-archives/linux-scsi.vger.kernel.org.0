Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F8B4A5ED7
	for <lists+linux-scsi@lfdr.de>; Tue,  1 Feb 2022 16:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239636AbiBAPCz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 1 Feb 2022 10:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239675AbiBAPCq (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 1 Feb 2022 10:02:46 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9F6C061714
        for <linux-scsi@vger.kernel.org>; Tue,  1 Feb 2022 07:02:45 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id i34so14147129lfv.2
        for <linux-scsi@vger.kernel.org>; Tue, 01 Feb 2022 07:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=qq9wIiVWHN2WAUtj0B7xD2yz2moOuwSz6aN0pUPieSs=;
        b=fMapvbJiHmjTkNsa7yBUFLSJIA+MTw6A1MbkA2b2rQQQo+Wob0zTbkeeEbfQPYGIQf
         U4sk4G90IXofoUHL7XE+VEVpAZnQbCP/QZg0Wbl+Q1sdgz8Yi4Y7Zw5xlkZB3g0BcYNr
         053gUmJHk781tNJOr1hIDcENWimzXXx50S/ksy+aIXm/xpyeqWuUfEeubbL6TONIVJra
         4O7rX28q2NXLNN7SrnWsLwGRZ+vDssoJDVrRGyeXvE+SgRWUKW0M2N4NA5+jml/NLKyP
         5NdFsA+bFO7MJlBz4xAsvx8m/InEXlJhdXqVqgdpMqTJEHOeVIbSB4kMjyqBPtZKM9z2
         EUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=qq9wIiVWHN2WAUtj0B7xD2yz2moOuwSz6aN0pUPieSs=;
        b=MwUwovUVbIk3CD1J2/LreFa2wuS5nOw18MsXYfZNRGwz23At2SxF1e6+Eoox8Cl45c
         /cCjYAizhcACUUTFYWqKfVEBMnGqxO8pVSpL2Pzsq2ihs9/I+TuvIlXRC2ZZ1f7+Fa23
         VaMkjTmHeVnxnCyHLlC6FZ1OG476NqvCj0Hx6bavMNUYiYQPuVx6Ixo/kMO2p7fiVXug
         zMkKe1xmqhACBCahjHjkKfg8rllprjESJWPT1VbYcAOVWSR2J+H8c7gxBmtm/IIw1KUT
         AMjOJu16cotWVun/67EfDaOBAfHp08O1tUs47fr4WKa7/BpHkrBy5Upf5l+rGYPgsicB
         kzuA==
X-Gm-Message-State: AOAM5313vsgx/jCCt/xaBY/CsShM7xpfmq4H6FDB5S7Fuv+HZlhaEq4w
        t9h0i6ImNC3LNV7jrhE8/FhLFhDL7zMbKz8Ir/8=
X-Google-Smtp-Source: ABdhPJw/kHI0JPnhnq6C7SG3auwrRNfiX1R9F6LVV5RQucbRe1+Vjtlhosrdz53WnfHrz370fFvzPmJXfcjRUF0rgKE=
X-Received: by 2002:a05:6512:3da5:: with SMTP id k37mr10482818lfv.511.1643727764237;
 Tue, 01 Feb 2022 07:02:44 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6504:3067:0:0:0:0 with HTTP; Tue, 1 Feb 2022 07:02:43
 -0800 (PST)
Reply-To: attorneyjoel4ever1@gmail.com
From:   Felix Joel <aldewshpoi@gmail.com>
Date:   Tue, 1 Feb 2022 15:02:43 +0000
Message-ID: <CABv=ag58g9myeQwFREq5+L9fE=2eNB0PixN4=TKs8SW6fDo0tQ@mail.gmail.com>
Subject: =?UTF-8?Q?jeg_venter_p=C3=A5_svaret_ditt?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--=20
Hallo,
V=C3=A6r s=C3=A5 snill, godta mine unnskyldninger. Jeg =C3=B8nsker ikke =C3=
=A5 invadere
privatlivet ditt, jeg er Felix Joel, en advokat av yrke. Jeg har
skrevet en tidligere e-post til deg, men uten svar, og i min f=C3=B8rste
e-post nevnte jeg til deg om min avd=C3=B8de klient, som har samme
etternavn som deg. Siden hans d=C3=B8d har jeg mottatt flere brev fra
banken hans hvor han foretok et innskudd f=C3=B8r hans d=C3=B8d, banken har=
 bedt
meg om =C3=A5 gi hans n=C3=A6rmeste p=C3=A5r=C3=B8rende eller noen av hans =
slektninger som
kan gj=C3=B8re krav p=C3=A5 hans midler, ellers vil de bli konfiskert og si=
den
Jeg kunne ikke finne noen av hans slektninger. Jeg bestemte meg for =C3=A5
kontakte deg for denne p=C3=A5standen, derfor har du samme etternavn som
ham. kontakt meg snarest for mer informasjon.
Vennlig hilsen,
Barrister Felix Joel.
