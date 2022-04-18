Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33707505EE6
	for <lists+linux-scsi@lfdr.de>; Mon, 18 Apr 2022 22:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238622AbiDRUcq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 18 Apr 2022 16:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238619AbiDRUco (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 18 Apr 2022 16:32:44 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651A67659
        for <linux-scsi@vger.kernel.org>; Mon, 18 Apr 2022 13:30:04 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id v133so10153841vsv.7
        for <linux-scsi@vger.kernel.org>; Mon, 18 Apr 2022 13:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=WK6OLngTEGMQZnXAmgyK8gksEaTtYBKX+MRhgq0dtFw=;
        b=eElSDq7CGUrBUELwyGhC5xEfeCIqHyKpefehh3iC7GGJ06B7iw8ooq8GcEgO87oQVy
         DC7ZAClsfXqfBhNyhDsQUhAZWZz5ZzzJS87s93tYuSb71duN7u2wKRByjccCPXvzswcS
         3sQRszw8y+Wn1vlCoB3WrTnoKhwE8x2lX8u0qoDRMzt3GbiAHsiFVy7vP3EzdvrESBv7
         mEmpJk7KaiiSbDvrcxs8XTuuifLCJ3qZ6qipUei/TcZzxNxVirjiOROSNZOKTVM+7n1c
         DMOKdzSZinRw+rBYHoYUnxyEksvqYGiWo59ONOkytdYFTG9ruOxb3rLBMbW1VGCJm56U
         ntxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=WK6OLngTEGMQZnXAmgyK8gksEaTtYBKX+MRhgq0dtFw=;
        b=IF72LwvRkGRrGkA5YNgiszPZeXYI3gacy6IhJZqrG4+WA8HjaLuE+Z8u/RutPMvXj/
         KhyyU5PaKIxnkoZH9f0KW77T1K3WvVmZfesLQaWt1cb74xMaZH3vl1d99VBSybi9cS4M
         xQMmKX95uplCHDotSqwF8hoOXXEYst0EzBf9whUP5eE1nrzTp/Xj1GyirrZ8zy/GID47
         /OdalGTWEk8ukk/pX2lVSSHW2xfo7QwaMhQa4d/71wv/z6Uy3tXT/H3IVMQnRy7dskd6
         92VAjnrqAHOeWEOrYQaAqGEg2vx3LULxSokKXjYw/7ODWRIJbsT+F/Ld6y6wocWXu9d1
         HBTw==
X-Gm-Message-State: AOAM530ZHnqOGkhAbXmbTj/D301XsxWjVwXJH1iNhqz6Xlyo/1W+qxSo
        TsdH9KasmWEYNJ+hRGTxdydAkfLQ7B9gJ+QyRCI=
X-Google-Smtp-Source: ABdhPJzKLhGgtDyCi/1w2kYRgIGrsFyCfPql8qrjNo6iItVIGP5AwxVaVL1imcSZmBGyShBl3Mq0jkLukEjZFVuOw/Y=
X-Received: by 2002:a67:b349:0:b0:32a:28cb:118f with SMTP id
 b9-20020a67b349000000b0032a28cb118fmr3658610vsm.32.1650313803565; Mon, 18 Apr
 2022 13:30:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:a643:0:0:0:0:0 with HTTP; Mon, 18 Apr 2022 13:30:03
 -0700 (PDT)
Reply-To: sgtkaylam28@gmail.com
From:   SgtKayla Manthey <maichibigracemichael@gmail.com>
Date:   Mon, 18 Apr 2022 14:30:03 -0600
Message-ID: <CAN8GoAYY8L73Cyh4LMy60AEYMChRuGcD+uSmoC_sTtsX0UAuZg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_40,DKIM_SIGNED,
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
Greetings,
Please did you receive my previous message? Write me back
