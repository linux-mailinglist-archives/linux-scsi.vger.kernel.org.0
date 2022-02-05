Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97FA4AACBB
	for <lists+linux-scsi@lfdr.de>; Sat,  5 Feb 2022 22:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377527AbiBEVdo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 5 Feb 2022 16:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237675AbiBEVdn (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 5 Feb 2022 16:33:43 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE2EC061353
        for <linux-scsi@vger.kernel.org>; Sat,  5 Feb 2022 13:33:42 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id o1-20020a1c4d01000000b0034d95625e1fso11801535wmh.4
        for <linux-scsi@vger.kernel.org>; Sat, 05 Feb 2022 13:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=4D2XO13bmKH6KEZ3rCIFVRJ29Rca69+/OJs6jQDOjGo=;
        b=gYvmip7okyn/CUPiuGkGtwNastzNfrEtY7Ice8pj0uAN9OWYDgQNcGSctl1EymGBDy
         HWm1/oKyNbW/X6pLs/mMPZiSFJ4fiwm5g5VAwHDBnc77/Zb1L4mtQWbcIVQG6xBf7fFT
         WkLpbuy6feDNRmc2EBA4RZ8Wuevw9YTzsCXNyQQH5TSJqce5PO29gQadx9tk8r7/YmE7
         jpHHdDIlQwcqiRwYHpKzCN21T/nNVcxnnhQz/FPIFdSLqsH4BX6u3OTty7F76RNGYejl
         hAMz69kdJkyIBEQ/QRPEq3Y+RfZc6jLi0jgP+OWH+W6s95fcQI6a0V+UpTkI5LlRDBzV
         t6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=4D2XO13bmKH6KEZ3rCIFVRJ29Rca69+/OJs6jQDOjGo=;
        b=fku3ifpkurejJfxJMle9BU3YDzWQ5x2AsxqdCPCr+uF91HqF7h27fokaaaCN3vsF1E
         OwUwTO3xgyiobpTu4qYAKz9Cmjndo0z8NYqVM0CR1EJUq/IWmwxzoMczywhgLw0hmIww
         FLZeEoYkhPC81fKPupLbuhb6BJq8yoPYzvI6EhS6/yhG5jBDTpUzJMTQh491oUkQhWBB
         bdiZ0W5oq90/xWg7N9iANnJs8MDOgTh8y6pIyX17e56IZ3wHJcAlWEhwWeiXsBaK/Vvl
         xG75PsIzAocOKVZY+AIPyiBe1pw/k8q38RnkzeAP57pVr/XhljZTnfNC1XSnqthLwAQV
         0dpA==
X-Gm-Message-State: AOAM530+0i1bxTUCRcANaQDW0uIwZ9NyqXKd1yN1dMoyVvCiz33zoHWQ
        e4t7edIhoJyP10JjgW0xrydnL+uFLAMcxlVFhs0=
X-Google-Smtp-Source: ABdhPJw7pJoqyRJY1Y/eKFjPdvs03zurSgRqpOaU0QE2lXbLJV4liTAP71Ouzf3AelpxVgkNmWkk5jbNv4n6SVI/4Xc=
X-Received: by 2002:a05:600c:4f53:: with SMTP id m19mr8102883wmq.150.1644096820394;
 Sat, 05 Feb 2022 13:33:40 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a5d:4ec8:0:0:0:0:0 with HTTP; Sat, 5 Feb 2022 13:33:39 -0800 (PST)
Reply-To: mmd475644@gmail.com
From:   "Dr. Irene Lam" <confianzayrentabilidad@gmail.com>
Date:   Sat, 5 Feb 2022 13:33:39 -0800
Message-ID: <CANrrfX6SVB4oux07RQS69RLW1w5xTU_fZR1vmtotC+YFOYgpcw@mail.gmail.com>
Subject: Good Day,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_40,DKIM_SIGNED,
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

-- 
I'm Dr. Irene Lam, how are you doing ope you are in good health, the
Board director
try to reach you on phone several times Meanwhile, your number was not
connecting. before he ask me to send you an email to hear from you if
you are fine. hoping to hear from you soonest.

Sincerely
Dr. Irene Lam
