Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78AF4D52CF
	for <lists+linux-scsi@lfdr.de>; Thu, 10 Mar 2022 21:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237613AbiCJUGe (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 10 Mar 2022 15:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiCJUGe (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 10 Mar 2022 15:06:34 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B52018BA50
        for <linux-scsi@vger.kernel.org>; Thu, 10 Mar 2022 12:05:32 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so4066622wmb.3
        for <linux-scsi@vger.kernel.org>; Thu, 10 Mar 2022 12:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=p4GORicRfKYMmuTaUvzvYC0X6pcYWYL8sK1k4bp9fMA=;
        b=K5A1Cw0nX7nFeFojfw3VFYcFcjFSGV7Hkte702Yt9iIUwKQLIn99gk81rk6GVJLkXf
         jZRN+IGCboBJqw6py5EoHP5jwY1qdgKTVF9g/xVfh0Ch9QaM4sgl2bv9ggL6jNpyE60f
         SZkEuVi7K7Q0MXcOLNsCkpRporwM3ELJie89ZjzHypX2mzxuhXYkAVEFlnAbAMeEejJo
         W1eZ4Oj43jwONTBaN05R2XDSjIazLpvVrOGXrI8Z6b8oJQAubZKyrrXfBYEwEOiIZxwL
         RzhKUBGFd+SOE+gkavf74ZcMSpJyXvkgrGDdSYa1d3Pbb2FZBJyG0vZ/NYkGaF9G1ZaE
         WuZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=p4GORicRfKYMmuTaUvzvYC0X6pcYWYL8sK1k4bp9fMA=;
        b=p/27+j0L11m6Gc32ezwrajIEweaFoFdZ+6xvHSdNA5yT0RUMbLvZA2q79fsMaIwZoR
         iwjolnNaFb6OvI73qiLYCXYY0KeOlSWW1iOwNNdn+bLnBrRmYGL/48WqIsQUjODMewhF
         SRLzzF02grIqMTn7/OQTeIQMW8fQuKbEybe8lZwcvypXwCrzxXKEUnb7a85Gx8Wk4dSU
         hP+OtPJbOSL1HURPbI9vagKmhpHf+XEEQNyFi2QMev5al3sLDv/R3Oqc4NBqImgWpaY2
         jlUX6ydQ2XRWAnLp1SWRZe3+uMv7PnoDt7LuCYLGlrDSI3feR89Uo/JnGX5V82VKrkhX
         q9ww==
X-Gm-Message-State: AOAM533aDNIlVQjuJ6So4RLQu+S+Eb/lqEGLu5lga+wqeM0qZS0Wslkt
        pXbsuQEFW3rJZrsPkFEcNbY=
X-Google-Smtp-Source: ABdhPJw1Z5eFnfJpKn1Sra8ohn8X01pycL6lowYm1e2PlLmE2Oqj37wtgpX7udFrotb8qxRZI9ulNA==
X-Received: by 2002:a7b:c4c9:0:b0:389:9348:9ade with SMTP id g9-20020a7bc4c9000000b0038993489ademr12886812wmk.70.1646942731074;
        Thu, 10 Mar 2022 12:05:31 -0800 (PST)
Received: from DESKTOP-26CLNVD.localdomain ([102.91.5.198])
        by smtp.gmail.com with ESMTPSA id w6-20020adfee46000000b001e4bf01bdfbsm4847763wro.46.2022.03.10.12.05.25
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 10 Mar 2022 12:05:30 -0800 (PST)
Message-ID: <622a5a0a.1c69fb81.9187e.4031@mx.google.com>
From:   Mrs Maria Elisabeth Schaeffler <ndireal70@gmail.com>
X-Google-Original-From: Mrs Maria Elisabeth Schaeffler  <info@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Spende
To:     Recipients <info@gmail.com>
Date:   Thu, 10 Mar 2022 12:05:19 -0800
Reply-To: mariaelisabethschaeffler88@gmail.com
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        HK_NAME_FM_MR_MRS,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Hallo,

Ich bin Frau Maria Elisabeth Schaeffler, eine deutsche Wirtschaftsmagnatin,=
 Investorin und Philanthropin. Ich bin der Vorsitzende von Wipro Limited. I=
ch habe 25 Prozent meines pers=F6nlichen Verm=F6gens f=FCr wohlt=E4tige Zwe=
cke ausgegeben. Und ich habe auch versprochen, die restlichen 25% dieses Ja=
hr 2022 an Einzelpersonen zu verschenken. Ich habe mich entschieden, 1.500.=
000,00 Euro an Sie zu spenden. Wenn Sie an meiner Spende interessiert sind,=
 kontaktieren Sie mich f=FCr weitere Informationen.

Unter folgendem Link k=F6nnen Sie auch mehr =FCber mich lesen

https://www.forbes.com/profile/maria-elisabeth-schaeffler-thumann/#443b4a6e=
19c7

Gr=FC=DFe
Gesch=E4ftsf=FChrer Wipro Limited
Maria-Elisabeth_Schaeffler
Email:mariaelisabethschaeffler88@gmail.com

