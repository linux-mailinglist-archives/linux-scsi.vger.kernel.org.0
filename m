Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CDA67E781
	for <lists+linux-scsi@lfdr.de>; Fri, 27 Jan 2023 14:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbjA0N6w (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 27 Jan 2023 08:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbjA0N63 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 27 Jan 2023 08:58:29 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89F47C713
        for <linux-scsi@vger.kernel.org>; Fri, 27 Jan 2023 05:58:19 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id jl3so4985697plb.8
        for <linux-scsi@vger.kernel.org>; Fri, 27 Jan 2023 05:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=jfaQyTcXNS/3hz/2ojh/I2/6P3PkVpdOvil3A9BYWFIMZALqb0YsT3O/+yoVjTgLfe
         nR1kjfNeYMpdfeltKu3IkpuZn1u14PslWeofdqXdldO/1Tc9fYs8rGOkSLnH8jiEiEd/
         sXp8QBGV3tNidLzp532DbyOWwKvra+KOqidLQqGdVZ5GR9A9dtAXNF8qbvSwiHIKr20b
         XOdN3qer2LAEjIEs3DvR8KEU+8DqgsMznf4qIwJlXwAgik3Y4iobsf2RZm+suwnoI7vs
         ji4utWxmpPOvz6MZxia9V5uL6DjT5jUx429wN5wc/NW99ifdi2jx3quE+KW1brm7tjEQ
         b3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=EKRqGs7dRypyuYfKPPltriw4MwlgeD5Mi2W4N6nffSLouyuKd58Evkp1tIoWCiU3lR
         34AzzG6D8hu0uVv13PQPmhkmZKLq+ZKN/zuWd+ELoOSYBUuw14XUEg3uN9cmZiTpt2+1
         QXxSfEge82JhYeZsxz+de+lwED+MayKtdpzkQyz7AeeK5X6phjIq3ts6a4cD9Ee0K6Kp
         ADOqSbzBwItbpxIjGJo3S8PrdP5PAEK1M3Qfz5fOCq0gbwOfrSTFiuY8alMzUMmzlt3g
         lMeAFskelPOloCpx84qfGZ3W1vF3RNrRJd5B9MpCS+76oTowpr1JrWYCHSajjhuGjdr/
         R7ew==
X-Gm-Message-State: AFqh2kqYlBzlzWdJdPmn585W2V2HnK9rapa5/jrZyg7+yh+kHM2FbBE7
        UXClypjCJZHhuKgGaYgAXzKE6/7QJuH+Y91B4Cg=
X-Google-Smtp-Source: AMrXdXuG/lw7dKtRB0UidQ9DXzaGa82K/spXodN5wAh+tMCEA8UDJbhAZiqwnH88OELsRuG0y4EtQYYMm5vspHUdNAk=
X-Received: by 2002:a17:90a:7e8a:b0:229:d04:ec7 with SMTP id
 j10-20020a17090a7e8a00b002290d040ec7mr4783816pjl.20.1674827899231; Fri, 27
 Jan 2023 05:58:19 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:2d44:b0:3bf:7a41:d805 with HTTP; Fri, 27 Jan 2023
 05:58:18 -0800 (PST)
Reply-To: subik7633@gmail.com
From:   Bikram Susan <susanbikram73@gmail.com>
Date:   Fri, 27 Jan 2023 05:58:18 -0800
Message-ID: <CALpyRY03J667awS6H6FA4MqjmWmaQY6ORqtPhThBu0m70tbfUg@mail.gmail.com>
Subject: please can i have your attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Dear ,

Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.
Please if you can respond, i have an issue that i will be most
grateful if you could help me deal with it please.

Susan
