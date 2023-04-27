Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A4B6F0798
	for <lists+linux-scsi@lfdr.de>; Thu, 27 Apr 2023 16:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243956AbjD0OhT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 27 Apr 2023 10:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243906AbjD0OhS (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 27 Apr 2023 10:37:18 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EBE3C25
        for <linux-scsi@vger.kernel.org>; Thu, 27 Apr 2023 07:37:17 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-54f99770f86so101159407b3.1
        for <linux-scsi@vger.kernel.org>; Thu, 27 Apr 2023 07:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682606237; x=1685198237;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=Yj5Eg0Zpcx6Pe3LBYtbVvsFEouHbmoNmaIrf9VBt5yQszbaEcbD2EuswbDOU+Y+rvx
         2HHQ9YcTrhz3JJhbl3IHSsjYnAme/guXoN9FHiBofylFzhIx4i6vPyEQeF50xfPNqHSb
         ifa9aCLrOX3qzMIDBFCR+Ppcpf++El/jA8ZbwbTDDUrZRNi5SFeHEJON+tanlYeq/TP/
         fKxOCKCMKRMYCQMRROfawiLZvd3H8TDUQChky4nwcZokzauqOf5z0NpCS6WQgxooK3mi
         dvp+NOoRRYCiZwDfZuvbRmzy09kwyjSr1bJNBmAmCcAWO9KqwgyREjnFxV50MGsd8vVv
         RIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682606237; x=1685198237;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=Qxfq3ZxeLbgjGHuJjmNV1GwQd5daMyUXHANjut+LUcBE1YbRlPU0WUNfesRNmuoeCg
         tiAVZ/81ab9KLPLR2RZXX6Ag0gl/oAU7BviwDwANSY/xY4CR+brUJrtx8Hqm5+DLs3dv
         E4g/ZKN1CLLxz13mOyuO5JZ+5BXbd4e7tDvc6lfrP9csrARtXU4otgcIRah9vhoIH8VP
         0vaydhdqnHb75042Vs+KzzGX5t1Lyrfn5mz+Pj2JbD2DiXEIy7/Ua7Qwokoy0btBGAuh
         /R7iL5BsqT3ONcxQ7ZvYsLhsHwtJ8sSJGiLqkq/3zeorEiKkwAR7oflDeHh47HmxfgwT
         hfYA==
X-Gm-Message-State: AC+VfDzjvj1tVuUk8dUFdTxR+u4ifu8D/wq+UfSt+2ChZwe5KsCJcJJE
        yTSh6GLZ7M57jL7htsvm+v1Iy5RsH0uU89Ms9Dw=
X-Google-Smtp-Source: ACHHUZ5Buvi3qdZFtrszzwkuEiPriZzNe7PMorVETeFTFwzoB+zPHQUPPYaGWhBhuxEJPgEHkbHpcd342LWmGFAHQ/Q=
X-Received: by 2002:a81:d354:0:b0:54f:c657:d80c with SMTP id
 d20-20020a81d354000000b0054fc657d80cmr1265024ywl.50.1682606236592; Thu, 27
 Apr 2023 07:37:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:6701:b0:348:dc97:ae8a with HTTP; Thu, 27 Apr 2023
 07:37:15 -0700 (PDT)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <gracebanneth@gmail.com>
Date:   Thu, 27 Apr 2023 07:37:15 -0700
Message-ID: <CABo=7A0UkbVaXd4P9W6scrGSboFX8UCb-Br=2B93UXv4P+4xqA@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
