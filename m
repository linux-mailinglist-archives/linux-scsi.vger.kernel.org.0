Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582E46ECAAB
	for <lists+linux-scsi@lfdr.de>; Mon, 24 Apr 2023 12:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjDXKv6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 24 Apr 2023 06:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbjDXKv4 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 24 Apr 2023 06:51:56 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAF535AA
        for <linux-scsi@vger.kernel.org>; Mon, 24 Apr 2023 03:51:51 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-54f8d59a8a9so50704167b3.0
        for <linux-scsi@vger.kernel.org>; Mon, 24 Apr 2023 03:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682333511; x=1684925511;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQlu0Oc2Q0nPMBCNq5iTPUZpwrRZlsMdPt2zjra8+VI=;
        b=BDOU7+6CjKGfGxohfwPSUG5dvZEz+JIUkSiwN2TDnXREO1m7tnshm1ywQFqtwjCtuy
         sdc62qMh2n/GKkLEd6inRVKNj3gr719YRClRe48cHw3AS8uelP+ymyFB0srKimerVisT
         13Xtkz0SBiM8bJqS0byCbOX7vMjZt1uP8WbY7Dvmdpvz4bea0qvNLSFK3Fpq3xaNdk1A
         qM5VVSk6ocRnmhVuQME3HxgmrkTm+A9wuvOqJRe5jylGoGOAUFMgmutSHMerkJpOSlvK
         vk/P+3RIGhTNsyHCwljHvfrhHmReD3nCq/AILJxglY3kVglksym9zePn5jHaXsmq1bcD
         nsfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682333511; x=1684925511;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dQlu0Oc2Q0nPMBCNq5iTPUZpwrRZlsMdPt2zjra8+VI=;
        b=bvo6vucVM6+8J2orwsDHlLJ7YkbWnuKrmE3/2JQdl96coP0my9Hxr+j5kDZhuQ+aHV
         11gfea+/iw84mDXuZVV+agbhAIR06gwI4CmhCEIzoErCqpMDC5PToBovgLDJNMzR8buK
         QWGRVVOkVouQIqw5xEzgOixfeSGxQ6ZwMJCVxJgpKfWhjcebhetwtW/lcD/0YMWbFPFK
         0cSBHvgSAM+1sONEOjuBTTH2C3oAaXqY4uzWW9/nG8iUiosh6BzHyHTeVKzdDoQbWEBQ
         I3woYIqhUAJvqf28CYDLV1mMRkoDJ8LMHPBFiKi8aP4GraZMx/QIztCC6tPHqhNrR1vV
         KsYg==
X-Gm-Message-State: AAQBX9d65eM+8emlPvGptFyu2DMoj/BPf/Xhse+xMS4TQvIh10FKpgof
        AXOrniWjKKWriJIG0gvgZK+lSe06zOkq6v4X3HA=
X-Google-Smtp-Source: AKy350YG4FdHU8gQxPU2msbtN2QdEjv9b6BhW9wIbc0BoX66FKTBxxpsjwaRJQwRDUNbtvTNf1tLcLROs6TnCelMCbI=
X-Received: by 2002:a81:4809:0:b0:533:9fa7:bbe9 with SMTP id
 v9-20020a814809000000b005339fa7bbe9mr7936227ywa.8.1682333511052; Mon, 24 Apr
 2023 03:51:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:7499:b0:32d:e51f:dee8 with HTTP; Mon, 24 Apr 2023
 03:51:50 -0700 (PDT)
Reply-To: mariamkouame.info@myself.com
From:   Mariam Kouame <mariamkouame1990@gmail.com>
Date:   Mon, 24 Apr 2023 03:51:50 -0700
Message-ID: <CAKXL+w08stRVVXkGQO0pBQ1x_ozGpGTcLNjscr9ZhQ3xnJgTTA@mail.gmail.com>
Subject: from mariam kouame
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
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
