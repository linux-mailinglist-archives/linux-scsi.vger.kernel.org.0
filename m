Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34225A0241
	for <lists+linux-scsi@lfdr.de>; Wed, 24 Aug 2022 21:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239911AbiHXTrZ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 24 Aug 2022 15:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237608AbiHXTrX (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 24 Aug 2022 15:47:23 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8E379EDD
        for <linux-scsi@vger.kernel.org>; Wed, 24 Aug 2022 12:47:21 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id o198so5394926vko.4
        for <linux-scsi@vger.kernel.org>; Wed, 24 Aug 2022 12:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=1WzdQc60kQFcuCijtsbZKgiFqjkRFGJBENyAUnBYwFc=;
        b=E+1aPhSC3SDJsi6mXiWPYeos2d0konbK1h79ttrhzr84uw/TJ4A7uZfy3g9xFFCMQ3
         7oiy+RkEU7pwY3aDh9M3uFK0DYc6AAG/PAqE0ICMUdjrR1TILRRnCUK+bhiyXhRikPzR
         9/Vqqg3o07m0uqOT4qSsgIAj00knsd53br2c2nKxrrlEMIPU+DrTy3Ai/2pkimoZ9o79
         zPQInb/IJOX7Nz0XXUDrYdLwSGX/QTas9dFoh2/TlUjn47BQ94I9+T8kaJ6p9yTGR9UP
         szMrmCVufawRvVlTOWtASq9J2o4LJ+3JdHyL9m15+DsdK78HZBZKs8HGKwP944K65rsr
         Cz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=1WzdQc60kQFcuCijtsbZKgiFqjkRFGJBENyAUnBYwFc=;
        b=ti8g0WYtskM5tJ5pzq+kQWKx6DxtrCdmQZIbPUH/DBZkcgIewRw19y7u74VwQtqza5
         O1qeRs9s7mbPJDRSMWLA/QoIB64wTuPCa94lKBB/HqsH6q9P5kjf5F2Ysdn/d4yphYiS
         NZFFGeyGOZx2kb2Wks2RoYLanOykOVTZXLZzMY/j8VG8EJzOKB+KpwTCbyjHaYs42BwB
         NoN199gyQfxQjyegIHOL0NyccNJJe13k3vP+n6dc4zrD10rYarpHAZ0AlYuA715I1zPi
         D+9rI4rOwiDirrnennWgJzYGsVdiAuzRtSY1z3zDs3UV8UnFjha6JjMexd61aT8X9RRn
         o3JQ==
X-Gm-Message-State: ACgBeo24xycXM7HHQHS++ZU5BXyLKNgMhyOXX267E1KH8qjWjzvIdU1m
        Yi6jwKVpdoSruXEmrwzGb3H7KtllmHX3gJ2NLaU=
X-Google-Smtp-Source: AA6agR7X0XXxZwlxwjdQqPcyl6ft9mIiA54zpEXxBa6SsuoNCz/+4x/tgSyIBFJozfv2FA5aWRJ9+zUwiYmvT4pOW18=
X-Received: by 2002:a1f:ac83:0:b0:388:9d97:b5a9 with SMTP id
 v125-20020a1fac83000000b003889d97b5a9mr226624vke.22.1661370441087; Wed, 24
 Aug 2022 12:47:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:6209:0:0:0:0:0 with HTTP; Wed, 24 Aug 2022 12:47:20
 -0700 (PDT)
Reply-To: ab8111977@gmail.com
From:   Ms Nadage Lassou <kadirifalila@gmail.com>
Date:   Wed, 24 Aug 2022 12:47:20 -0700
Message-ID: <CAB=uj4NnUseD65KxYE_fGrj+X7Pe6JgBfZrkj7MmAprrcBG9rw@mail.gmail.com>
Subject: Waiting to hear from you >>>
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

Greetings.

I am Ms Nadage Lassou, I have a important  business  to discuss with you,
Reply back to my email to have the  full details,Thanks for your time
and  Attention.

Regards.
Ms Nadage Lassou
