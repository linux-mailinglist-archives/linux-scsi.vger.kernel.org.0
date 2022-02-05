Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94324AAA4B
	for <lists+linux-scsi@lfdr.de>; Sat,  5 Feb 2022 17:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355320AbiBEQ42 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 5 Feb 2022 11:56:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbiBEQ42 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 5 Feb 2022 11:56:28 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 252BCC061353
        for <linux-scsi@vger.kernel.org>; Sat,  5 Feb 2022 08:56:25 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id z4so3921134lfg.5
        for <linux-scsi@vger.kernel.org>; Sat, 05 Feb 2022 08:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=5+T6LvvALsCqS8hwQIXtZ7PKoyb/aQqkyAFbfBNDrRo=;
        b=lC72mreDxOaUCTaTMeuc1Gg2y+AeKqqYgFR0lRIrWAZh3tKq2xii2H6bdJ2JnSlthD
         meCi3ah870+N23+CZSMv8IpS5HTS093chPUw8HKHGAGxwOSFbTdONP3kW4rIrjRLWz0o
         0WsW5yv6rjD6uSyUVS40KV0YMoogMgDceni5NL+HMCQ303q9MztwEJMB6G7XDK8XzNKB
         2TbNOfN1tKAIdXmDdZrtVwMioCVsxE87KdoWYMU2s7DWfjLQia6sy+XCvCTnKFclErX1
         Hy6LMagx3+HBpgYHgU00kOtQMlpUssNR9Ii0aK8mzYgAzvzvJJaeaBoyuc/ozMbS7V9A
         cICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=5+T6LvvALsCqS8hwQIXtZ7PKoyb/aQqkyAFbfBNDrRo=;
        b=d39a/0MpvkRHPs/wuI4+8+694OcnmfZPOCUhGDHzRJUi/sYjrrvG7GDAzAzOS9NIKS
         EGOwlcuaa0Pv6VbbxT8xQshVSLcoVwZtkG2N5fpr/rLbkvEgjIBNqD4M33ZbDk6IiwRP
         Rqq/zZYwMUzq8CPjgZfyu0f1Tb+puZCQWduABuk27SqHYTasPB7qv0x7964B187bc0sC
         VPIkHjLK8XDP1lfiaQhy7yBwQEkipYebD/23VjGvpsWAkpmrK8AtZD28I423/9OryIZN
         yeKd5XHZJEefUj1lMpEFx17GY07QXB7wkSgQMeN9hVTwqBSyNT6LpA04i2LlmzH/j0OT
         7fzA==
X-Gm-Message-State: AOAM532iuJjckFvnoGCVSnQNioNUVazWQw3EF9MuR3sJnSC6sUi43LJH
        HqF0r9t3iTlObXaq24j7VWYXugNaIwa1epmyyhA=
X-Google-Smtp-Source: ABdhPJzs4Q00n+1jv2FfzqnSkINu7We/v0FHcC53p25WfTMX57xMC3SgSLQYEPVXTkiEzoX4McXegm+hJ7umPvRvD+Q=
X-Received: by 2002:a05:6512:228a:: with SMTP id f10mr3080048lfu.22.1644080182830;
 Sat, 05 Feb 2022 08:56:22 -0800 (PST)
MIME-Version: 1.0
Sender: uba250mirobe@gmail.com
Received: by 2002:a05:6504:3241:0:0:0:0 with HTTP; Sat, 5 Feb 2022 08:56:22
 -0800 (PST)
From:   Folson Terfah <terfahfol@gmail.com>
Date:   Sat, 5 Feb 2022 16:56:22 +0000
X-Google-Sender-Auth: 9VrrL0ACD6CfO6_TlRtS_fDoDl4
Message-ID: <CADV0=y=WKhjCL+DiCc+RRumXSa=-R9W0CJs6pCfkE-1M1sg_fg@mail.gmail.com>
Subject: Hej
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Mukava p=C3=A4iv=C3=A4,
Miten sin=C3=A4 ja perheesi voit t=C3=A4n=C3=A4=C3=A4n? Toivottavasti olet =
kunnossa!
Yst=C3=A4v=C3=A4llisin terveisin, olen Folson Terfah. Ota minuun yhteytt=C3=
=A4, koska
minun on keskusteltava kanssasi t=C3=A4rke=C3=A4st=C3=A4 asiasta, joka kosk=
ee
lunastamatonta omaisuuttani
(5,5 miljoonaa dollaria). Lis=C3=A4tietoja / selvennys asiaan
Arvostamme nopeaa vastaustasi.
Parhain terveisin
