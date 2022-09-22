Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30425E5FE0
	for <lists+linux-scsi@lfdr.de>; Thu, 22 Sep 2022 12:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiIVKaB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 22 Sep 2022 06:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiIVK37 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 22 Sep 2022 06:29:59 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004F945991
        for <linux-scsi@vger.kernel.org>; Thu, 22 Sep 2022 03:29:58 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id t3so8395391ply.2
        for <linux-scsi@vger.kernel.org>; Thu, 22 Sep 2022 03:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date;
        bh=Tw+A+ZtdC8h8Zfb08viGcTl4VVq5OdePtSRuCSulGEc=;
        b=f3U9/N12cSVjxxlYHevW+OOty+hMy4BIqmIsQFWrNEljROAh+LuoIc1bIwohQ71Bpn
         pP9fm/2GPJKXbVAccgKyGO6ygkQ5bfu58iUVYwIDOiWqvzEgJYWoqi22s3bkoxnGN0Up
         KMJT75pqkAALJR5IjSMOb/WXwiaR9OOThH2OK9KFVFKM/iw5pl5KDoAzRoi37Jhx1SsX
         4WYT0CuuPeGCQVC0sYjPL/3cXpWWD/4GCMMyWG91YF3+YVlxsKEpsI/l/OFLIl0jI85H
         e1pT3TXnUU5rZljl5hWPFVK40gjoUKucJgDi8O7ZYCIAreBf4t/9Wl9W87g+0DuMh+yO
         tdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Tw+A+ZtdC8h8Zfb08viGcTl4VVq5OdePtSRuCSulGEc=;
        b=MYEFPrJKK1ETk9Jybe+tQ8JCryT7r+HzVmmxp5slzP8w6hhqoaj0OPEaHaFyUU5s2E
         7Cz5WJTNb/pbd0LFzXsP7m+W8trQIQqBkK4ZR6DBnBwzkkMnUN+CmGGpY9a/ugRx8Nsc
         Jdg4PKhKBauI3rkWqPrL7dKpUzDRVlnBXW3XB1Z7ly7uH3yJlibrBDwwLP+wRAQI8Y83
         63hnpbNKS2a+H071QGiq8CXoMliAiAqQNP9v7rxOTlL//grioodHeXsMuf+wt3ONGEY3
         D0gLSltmPxkOi+y2FsG0s97kSJb9VPNCUNAa1gpjoX8hFEYH2uxwJxPzN+YrNZwzardP
         pOEA==
X-Gm-Message-State: ACrzQf0D5voTSI4iKA83vAOhk6Bx8ltKTdQ5qxy+oMJwCftlucIObB2F
        W0xg5vB6yOsQp2JwY4Zaxkvl2SggXUOOGujRD3A=
X-Google-Smtp-Source: AMsMyM4d9PUzmUJxMn8faLFadg4NfbEWuSPu26a4Y3Smv9fRDb7DBn76hTeihsYhbVoHSDN+Hh0gXIxLgZxGEVCscuI=
X-Received: by 2002:a17:90b:4c8e:b0:202:be8c:518e with SMTP id
 my14-20020a17090b4c8e00b00202be8c518emr3057869pjb.26.1663842598598; Thu, 22
 Sep 2022 03:29:58 -0700 (PDT)
MIME-Version: 1.0
Sender: gaterefoyiuut@gmail.com
Received: by 2002:a05:7300:72c8:b0:7a:58ce:c095 with HTTP; Thu, 22 Sep 2022
 03:29:58 -0700 (PDT)
From:   Felix Joel <attorneyjoel4ever2021@gmail.com>
Date:   Thu, 22 Sep 2022 10:29:58 +0000
X-Google-Sender-Auth: aUMgwiULP5uaize1PDmu0YP7ocI
Message-ID: <CAGU9bY49SgsMKefoEUir7rz-Gbi58seN=P5j11NVh262hupc1A@mail.gmail.com>
Subject: Erbschaftsfonds
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--=20
Gr=C3=BC=C3=9Fe
Ich m=C3=B6chte, dass Sie sich bez=C3=BCglich der =C3=9Cberweisung Ihres Ge=
ldes
umgehend an mich wenden. Ihre dringende Antwort wird zur weiteren
Kl=C3=A4rung ben=C3=B6tigt.
Rechtsanwalt Felix Joel
