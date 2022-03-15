Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC504DA0B0
	for <lists+linux-scsi@lfdr.de>; Tue, 15 Mar 2022 18:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349556AbiCORCT (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 15 Mar 2022 13:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbiCORCS (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 15 Mar 2022 13:02:18 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0D057B26
        for <linux-scsi@vger.kernel.org>; Tue, 15 Mar 2022 10:01:06 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id j3-20020a9d7683000000b005aeed94f4e9so14399729otl.6
        for <linux-scsi@vger.kernel.org>; Tue, 15 Mar 2022 10:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=71QdEmlwBmyzW2/4qEGlb6RuQKZwUgr5VIqT5E3Y77g=;
        b=EMvbBJQ8umXMzPcrCni4xACFRGtpXPtFBT6QtTDFCtWvRJKptJw/kIKVAvWGYPphlO
         hzKiP5MSfTvz0FxLLB/3YiVzgCT961XdNOhUtCxAynX54i2PiGOLNLQhF7RcPft8RVt/
         ZSnXHYO7se/Dm9RFdYfwbn5xGRiV2nKvPcyirPOzxW2GomONZW1A0gIsJQK74uBDfHfd
         RpDJGriEIbkAK4KNCZVF+22OKJuemvpKuvIOwMwjJGlrLheg/utBeqptfqitY4tumpu+
         rFjZW1ue8vLAFL82qZHjRLaB9rInruQwytKRypa6psMmWeqZ/F3+r+bQK8fUAYbYY2hO
         H3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=71QdEmlwBmyzW2/4qEGlb6RuQKZwUgr5VIqT5E3Y77g=;
        b=G4ioXsWnDNnZWURH+2sNkPXoyKOOKVVGCL0VqXzVpEoavj10VGBVPPmDzM172O8Ueg
         bR76PN51CmgyfXlFvuiVzVUlDzKWE60Du0pMJQRypyfLVOvNnBI9NuPYdwj+9Z5zxZNW
         9Ct1/D9uUfHeCtlvE+ATvgmetmrP0Oa+NljKwpViABZ7jdfnTUYaDqHM/ngugz8D8rr1
         9Uqcwd1v48w51dE4VAk9qAjVV4rYgRka2dw05JNgKA//adfT6kF25XIUTJcpXeFaRM3G
         5uz5xE4ZwB6y89mjno7pee8Ee/iYWy8eezbwVb5lfo+rfUZkmW1FMOMLKMjRhDk54pHc
         S3aQ==
X-Gm-Message-State: AOAM5324lkz9lzHL3VHLXxCE3Y+9dLo7PIuMa+02fl5gkXh6NHbgpOnW
        YnIb52TjrsHvmu3gciC9MHQg2+FF5BmHFhU/tFQ=
X-Google-Smtp-Source: ABdhPJwYwLCq/lAQk9i0iGSpXcKiyVT6KN4uRH1yoPDKdfAtL3Bo3RgfXv8vz8+1cILh6HjW4CHpHMy5aY2KkLgjSlU=
X-Received: by 2002:a05:6830:4489:b0:5c9:4650:dbf7 with SMTP id
 r9-20020a056830448900b005c94650dbf7mr8316451otv.346.1647363666074; Tue, 15
 Mar 2022 10:01:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:e01:0:0:0:0:0 with HTTP; Tue, 15 Mar 2022 10:01:05 -0700 (PDT)
Reply-To: jeai2nasri@yahoo.com
From:   Jean nasri <jhadgrs@gmail.com>
Date:   Tue, 15 Mar 2022 17:01:05 +0000
Message-ID: <CAKxEN0uUwTi_6nYBPOzJq3C2GN1xz1+2=Zq-EoGDQd=GJ9ysKQ@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hello,
Do you have an account to receive donation funds? Please reply for
further explanation.
Nasri.
