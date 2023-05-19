Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8FC070A0A6
	for <lists+linux-scsi@lfdr.de>; Fri, 19 May 2023 22:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjESUgT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 19 May 2023 16:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjESUgS (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 19 May 2023 16:36:18 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6238A1A8
        for <linux-scsi@vger.kernel.org>; Fri, 19 May 2023 13:36:17 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id 6a1803df08f44-6238200c584so16178226d6.3
        for <linux-scsi@vger.kernel.org>; Fri, 19 May 2023 13:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684528576; x=1687120576;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQlu0Oc2Q0nPMBCNq5iTPUZpwrRZlsMdPt2zjra8+VI=;
        b=iKPz9Oh4/TvVutVjYTfPi0mjubOCm5vM4CVbTGjh1CEUB63GubzRmFCVaqX3GyvjSH
         UvJlkmD4v1juCbNVwQ3OIs6PDGP7Jf8uqyXqRinbquXuvulf9PbLIoMKagLcY3edyWRo
         XDQlSVsRSXCOSnkrEt9igXA5SXejdTxCR1fUZ1gP8KSIS/7tsrxUUVtQ7VJy6pmjEzRL
         uRO4ZT4zlnvL9MpYySpXjW3JwOPLE6/og/rMjLYZCkQGv/7YL5nIqFUOMFxkbvL6u9pN
         gueIhAcEq8omC2de4/PPfLI+selElP2mz6un1jXu2QmxZiEPiQ++7JKkD9AJMR3vsOMf
         vkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684528576; x=1687120576;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dQlu0Oc2Q0nPMBCNq5iTPUZpwrRZlsMdPt2zjra8+VI=;
        b=gQxu2qAeQfskwsi/vbFBs+pzIoZ+m02+ijKKofxrxzib8bYVuTI76e/PXCd+R77LJ+
         Esb9T9sQxnxUUxaQRTlyYBa9AQqlJvt4GNvlE7AxZf2ph21szmJOYWeH+sKvTyPFxHaK
         HnhOh40kegdC92+5LF12ZsDa6t6r+ooSj1jS/AZFOqsm/h+MIXhLn/VexyyAdzzUA7Oo
         ChGRCmwbAu0shQryPMUFg3MjoIaAQdJfzMTAN6smzLO9uyQr2dt3OS4LHblUTuQH4AAb
         3Ugj1t0FlKoLR2PedRCDtLXj6h489VquQREA0dLTpL5XTDVNuYusp1ZjXx9slWtLaDda
         lenw==
X-Gm-Message-State: AC+VfDxhMOGvAKZ8G842Y4BTLiklO+obIutrXf5cNQNBF2Bzsif+I6UK
        HyGJMz3FC+ItmgrztkUbhE9LQUR2Z5jz5wbpUQE=
X-Google-Smtp-Source: ACHHUZ4oVWzrM2Cl1CQkqiQLJ1xIhyBwUZcbcH94LKkZdYasH6Ds0Jf0Yom27k6E9aoxU7l5KEU+PRUAWlhkwCoUc1U=
X-Received: by 2002:a05:6214:c8d:b0:5ca:83ed:12be with SMTP id
 r13-20020a0562140c8d00b005ca83ed12bemr6007898qvr.21.1684528576436; Fri, 19
 May 2023 13:36:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:f205:0:b0:623:7c92:8385 with HTTP; Fri, 19 May 2023
 13:36:16 -0700 (PDT)
Reply-To: regionalmanager.mariam@hotmail.com
From:   Mariam Kouame <mariamkouame1993@gmail.com>
Date:   Fri, 19 May 2023 13:36:16 -0700
Message-ID: <CAJF_a36r4b6Dr8-hkX=x2WOwmphyEtxVNkc+uRSvO4CLqcW6AA@mail.gmail.com>
Subject: from mariam kouame
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Dear,

Please grant me permission to share a very crucial discussion with
you. I am looking forward to hearing from you at your earliest
convenience.

Mrs. Mariam Kouame
