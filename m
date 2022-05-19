Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9355152DD9E
	for <lists+linux-scsi@lfdr.de>; Thu, 19 May 2022 21:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241263AbiESTSa (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 19 May 2022 15:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236174AbiESTS2 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 19 May 2022 15:18:28 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 608D6939E7
        for <linux-scsi@vger.kernel.org>; Thu, 19 May 2022 12:18:27 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id j2so10774023ybu.0
        for <linux-scsi@vger.kernel.org>; Thu, 19 May 2022 12:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sldeoUHN+XKV/25qdr8o1yS1uyCAwpn/8BNmGuwP1dE=;
        b=W7vER1CJgLuLZN7/pekzEqMHHpM6NJHQVbipYKw5pM3E8VRylGxndVn8JdSS6BHUN6
         3ZxUteHpq7VassCKw8ZlQfsdlnNTF86UGz+ozzEZJYKFwsGBNzB8uuyru42HmY2c2+X3
         pei0jtAYfrK3eM8MK9DRyjAeXbkW3nr5/sF1C7sh/MyDUgEDDCYw5Fg9VutCkqqVk72O
         7C7nKBTuamT0/RHieeI3ZHZFxKJCIQDSlnb4UbtgJ0MJ5zlF9bhQ3yzDz5OHGsqtIuiB
         9rMBjhpqHcXLB/4GJngCltJVyYoZqjW3JzstCyKwHIoRfx4PsuYcwxSVBa7uSReKnLOg
         rs7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sldeoUHN+XKV/25qdr8o1yS1uyCAwpn/8BNmGuwP1dE=;
        b=R+KUHeMJ8mR0twQBvayigmEISe+ZsMlfP+7lhfkXF85crLU8gLf3fRh1OoYSVMgLvy
         IvrPFu3m6ZZoHpfEuIhocf+5c+lQcJcFJGkFFjcSEEpQqr4qf4dTGseBnBLPR4kAhqAe
         TJzUSHBHhQ2C/FI9oDKAaGC2t9Yx96751jTsdRbIfW2aK6wX0oO5Ur1qEJXHmpqODM3j
         G1Fqqe8UdNtU92raheSahd1kT3jIcRm3Ppspp0Ou/Bd9f16K1HSSqEUUnbEPIDVkV5Vh
         j36gva/hTbUAH335d2zmNEXys60yLSOk0tw+FEYL2n70RzziUtovN3u+9MrO9vzFpWcs
         Ow/g==
X-Gm-Message-State: AOAM530glTW7L8PbWufTdmeL70QnHgLB67tal4QEWeepUszVEe6bv65D
        zG9L+apcI8DOcGI+hr2ZdLMsnHWfUWxsx9F66sg=
X-Google-Smtp-Source: ABdhPJxyFt8BCFWs4lDRGcG1+gJYKsyIadPOcypbFQ+/v21/4ggH7eYOE+1W4wUMoA9aVoLPdW0guXEJ1T3MfiHHCeQ=
X-Received: by 2002:a05:6902:114d:b0:644:ba0d:e95c with SMTP id
 p13-20020a056902114d00b00644ba0de95cmr6258671ybu.516.1652987906529; Thu, 19
 May 2022 12:18:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:6b12:b0:2ad:f417:94bd with HTTP; Thu, 19 May 2022
 12:18:26 -0700 (PDT)
From:   Manuel Franco <manuelfrancolove048@gmail.com>
Date:   Thu, 19 May 2022 12:18:26 -0700
Message-ID: <CA+PGJtCVE3WdKtpgunnmBdc97Duk8b0vSh1D7hTkS595FzmUpw@mail.gmail.com>
Subject: Der Betrag von 500.000,00 Euro wurde Ihnen gespendet. Kontakt: manuelfranco4love@gmail.com
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Ich bin Manuel Franco und habe am 23. April 2019 den Power Ball
Jackpot im Wert von 758,7 Millionen Dollar gewonnen. Ich gew=C3=A4hre 5
Personen jeweils 500.000,00 Euro und Sie geh=C3=B6ren zu den 5 gl=C3=BCckli=
chen
Gewinnern, die ausgew=C3=A4hlt wurden, um meine Spende von 500.000,00 Euro
zu erhalten.

Kontaktieren Sie mich f=C3=BCr weitere Informationen unter:
manuelfranco4love@gmail.com
