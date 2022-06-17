Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09BA354F666
	for <lists+linux-scsi@lfdr.de>; Fri, 17 Jun 2022 13:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382224AbiFQLJz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 17 Jun 2022 07:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382253AbiFQLJw (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 17 Jun 2022 07:09:52 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246006CA88
        for <linux-scsi@vger.kernel.org>; Fri, 17 Jun 2022 04:09:50 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id h23so6413594lfe.4
        for <linux-scsi@vger.kernel.org>; Fri, 17 Jun 2022 04:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Jh3M8LDovYWs/mBJiVJoI/DS8xun0EDDqspVSX/swmY=;
        b=EsSqKI1SMSLuenvGcu7WTL3V7zFTGmjUsljSLgtVwAHqlLErA5xxmBy2JmMaFxtxeX
         u2znEqr5Id9yXIy65CeL2zDYYkXd+7OH7tXB6MSECLWix0wwJclUqK/T3laLowK3jTwK
         u51+r1p6BgxAEzgsBqjmgUREPoVWrTDeqBBOyQGyVUzPxo1LeU+SXn5VLzhTuh2ZzYXS
         i/nd1xzfCcfKnrSlaGbTLNZe7t3ZDUTkow24oui9dblNY2w/aB61eq8G3FPsu2+aM81U
         IWClR+QxexYx2l3uwJyqdCqUolou7LtJ13pi/hqqz0CyFs93zGIKLXx3UgGWaPEEXUpW
         /9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Jh3M8LDovYWs/mBJiVJoI/DS8xun0EDDqspVSX/swmY=;
        b=tzZ9D3D9bX/UHT9jkqcS+rilcK+kZHWcoay/8BW5fD6UzXepVW32QoLLUwp/fxb5Z+
         jh6e84EZdQzJcMOTZR7BmuV5VTBx9iDGa4JPhyhor4RWUkknjf87SzbjD1qp3UrDeT2Q
         EKF8xI6qLJks5Shj5S8+CdYJFcqc3kYIQu2kSDrYX6DY3FPEp3RDVZqW+YMaWKssg3y+
         b2NI6salNTecO4bQV6Wa46IhrdRdIgbFq42W9Vlh0zSNmu26RamcpEzZQ+TuJZ8j5xe3
         AV7KaVJjr7u+FzMSby4R+M4shlalDAm2gnv6CS4vv8W8VFHXCw85yLhhsM4yiJ+iHjJQ
         YKnA==
X-Gm-Message-State: AJIora/j9THn0vE0HTeLzzMeC7bLPkgOAxhjqBywb8CeUuAzGRtMQJ3w
        83ECiS4i4cXHJCa7X/Ry51rx0AuXQysTchbtbK4=
X-Google-Smtp-Source: AGRyM1vLzwF4FCaudnvd5ad3/nPHQ4t1msEdIFVsz7XwgUhRC0T/B1APVaOIMfuMW9/Dnyg7I4ZnkRf9phgujEwZYBg=
X-Received: by 2002:a05:6512:791:b0:479:3fc7:e91a with SMTP id
 x17-20020a056512079100b004793fc7e91amr5186313lfr.388.1655464188537; Fri, 17
 Jun 2022 04:09:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:680f:0:0:0:0:0 with HTTP; Fri, 17 Jun 2022 04:09:47
 -0700 (PDT)
Reply-To: sj7209917@gmail.com
From:   Joseph smith <maelyskpeta@gmail.com>
Date:   Fri, 17 Jun 2022 04:09:47 -0700
Message-ID: <CACKGxpwNntSiDYpo4jDZAURubmoyC63t47YzZ=2dVK24mhgW2g@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hi   are you available to  speak now
Thanks
