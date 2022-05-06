Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C2051DDC0
	for <lists+linux-scsi@lfdr.de>; Fri,  6 May 2022 18:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443860AbiEFQqC (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 6 May 2022 12:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443847AbiEFQqB (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 6 May 2022 12:46:01 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C6056221
        for <linux-scsi@vger.kernel.org>; Fri,  6 May 2022 09:42:17 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j15so10780739wrb.2
        for <linux-scsi@vger.kernel.org>; Fri, 06 May 2022 09:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=eqRg70934LOhEuzCeWKXpYN3LktkIf1z9etsTpdQxp4=;
        b=NqStOMtSrjohqHtVyWyX4PjiF2ZdmS+p1A7qDDqxHhNkrTUmPsmysH1uIVTN8OoXqh
         4tWH0C25+daQNl8Cbp4qOuOzdDzqYvPMn0HxUDpU67yMrLcPXIcfanJWUnCDE80V57+X
         Xl6xuf/ulJwK9z6nopTtxAxh53TjLqpxJyP71JRagOE293r9iQ9ZHN48AGDi5jKvZxi/
         MmGCirRX1bvrA6/CQQuZ1jdMR5caZBBDdg8hzxoAcCazJh8OTzusUxQkgkpbVwbC5n1T
         VlX2IQ6w5Q32Ruh3oF9iidbBpr3QR2ENP2CsUDVHBd0MrbcOFHuHx0gUcRjoS1kKtxoq
         NUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=eqRg70934LOhEuzCeWKXpYN3LktkIf1z9etsTpdQxp4=;
        b=2boQl+RBferUzagrtDhoaXIyp0pLIqJS4jSTJyHzku8HEUYdLeZaFirMkJ30258nF3
         qLhX4+dLgBwHKeH1Ap/oTA2ORWgpVKjhPGENv41H4eSV0kMOSJHS7qUDVBBJhEBrHZ+v
         TBzpW1cem8gpDvCyi+MmgXlAlC4z8PNckfi5S8Ate8CEO1QoBRvLRulq0QgC2wQmdhZR
         7tgbW+gqRmHH9YT/JnuvysBVaia7JGalZ6UeVz6xQ3deDB0QPc0WdZQ2HXQP0M51VJ/P
         tcMtY18C6QPAf4Cl51AglfygD9jiteJVIQUVSvKy2EywRlETjiE1aExQhvC7kb85j+F8
         W0Fw==
X-Gm-Message-State: AOAM5330s37QgwvDSkjP+wkUL6/ke4p8S27OERAO1Fc76hBbbKz3rf4n
        rnA4njYt4FaakqkdTG1cO5OrPdZ+mb06gu2OBi0=
X-Google-Smtp-Source: ABdhPJxgsFxySZ+0oDjXgMs58f8oTrkHjDaPiljHI1tVZK3uiPqHfsLAFBtOdwePe/Iz2bt0oto1W4q50PH2cYoHgRE=
X-Received: by 2002:a5d:648b:0:b0:20c:5aec:1c06 with SMTP id
 o11-20020a5d648b000000b0020c5aec1c06mr3338368wri.525.1651855336433; Fri, 06
 May 2022 09:42:16 -0700 (PDT)
MIME-Version: 1.0
Sender: ilyasouhamani@gmail.com
Received: by 2002:a05:6020:ab26:b0:1db:67a7:2424 with HTTP; Fri, 6 May 2022
 09:42:15 -0700 (PDT)
From:   "Capt. Sherri" <sherrigallagher409@gmail.com>
Date:   Fri, 6 May 2022 16:42:15 +0000
X-Google-Sender-Auth: vF6tzRiH44X3Zztiv2sho08YGVM
Message-ID: <CAC5U01GKzTx9Gq7fojRfhmfaEYMM31txTZVRsttm5PVbLPBvKA@mail.gmail.com>
Subject: Re: Hello Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

5L2g5aW977yMDQoNCuS9oOaUtuWIsOaIkeS5i+WJjeeahOa2iOaBr+S6huWQl++8nyDmiJHkuYvl
iY3ogZTns7vov4fkvaDvvIzkvYbmtojmga/lpLHotKXkuobvvIzmiYDku6XmiJHlhrPlrprlho3l
hpnkuIDmrKHjgIIg6K+356Gu6K6k5oKo5piv5ZCm5pS25Yiw5q2k5L+h5oGv77yM5Lul5L6/5oiR
57un57ut77yMDQoNCuetieW+heS9oOeahOetlOWkjeOAgg0KDQrpl67lgJnvvIwNCumbquiOieS4
iuWwiQ0K
