Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECD14BCF7A
	for <lists+linux-scsi@lfdr.de>; Sun, 20 Feb 2022 16:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244203AbiBTPis (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sun, 20 Feb 2022 10:38:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbiBTPin (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sun, 20 Feb 2022 10:38:43 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F0741323
        for <linux-scsi@vger.kernel.org>; Sun, 20 Feb 2022 07:38:17 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id u18so24478607edt.6
        for <linux-scsi@vger.kernel.org>; Sun, 20 Feb 2022 07:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=ymEpgIXl54yuSlZg88NLeYK1RJf0YDtYgXWD/9J1GQ0=;
        b=degv64KeFtdi2zbjsMqCg99XUBwRsWWRsat8pVSE1dsJMyLEQebzW+u8gL6CBfEQQn
         TR573CG7WA+9vnEdvbzyisLdqVfd2L7tW255YjXAv70Nz6z7oKmPah1XlxlqBd5nDgXH
         ePUhHpcz6Nz3MIgpiiVSbZwwadbd4mnHSGmsNzIMifS2uWsr5SlJ5m2rsNUPByoI5zhb
         SR83azGcCTW//SbmgQ0y+vLGSla0uKvjbMIVO2C3U/MToeM9d3wUPHwP8BDBVACmWkyb
         mbrrj1iz1ehyoQ1IJSYmVaPjfehHwDHBxgq0J/uzM167cyMcPy58BK3LuVjr98uUFJPh
         U0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=ymEpgIXl54yuSlZg88NLeYK1RJf0YDtYgXWD/9J1GQ0=;
        b=EMaZwJ4XZUTRynEZr7ar5XkWxNTP83GKZF4B3uo5N2vUlBzIRos7aBjB9r3qjYClMS
         Mt9nzF5+MeQI79IDfMUUYAiVL/znD637tIiiQvISJdhkNhE6GwcvMs9DR7+ed03rwIls
         bAEzrccvjAeWLd8oe0HlmPy2gzP7p8qGCamSy8V4jW+9hStV/1QQl5vBTq51H6PTXS55
         loomYWAoSeyYcy7ZQ3LAScoMlVXCtXvPGi1nh66Eyd22zVHd2Oq640u4H1wwDu/MumRK
         Y8IoFptwpgpAMkIhDZq5Zn4wk5mD5iR65k1vreoc2y+7u37hBIgpVpJVW3yDGOGJAAHJ
         9YZw==
X-Gm-Message-State: AOAM530E5+Ti3d9flfEDwaiovuvdnTMTCpruT2ZMEykKl3Yi3Qa0s+03
        Y4GpIlM9OyenXEMkELM1UJeu4LO9mDpA9W4U91s=
X-Google-Smtp-Source: ABdhPJz0AN7o9No0fhs6xZEm8hzyX6WOZhNi8B3U8PCYdBi3itNU8MBgMEdAbbMqhnsTf7H9NACa5LH5MJlqKIgsin0=
X-Received: by 2002:aa7:ce92:0:b0:40f:b89c:18fe with SMTP id
 y18-20020aa7ce92000000b0040fb89c18femr17517323edv.67.1645371495858; Sun, 20
 Feb 2022 07:38:15 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a54:38c1:0:0:0:0:0 with HTTP; Sun, 20 Feb 2022 07:38:15
 -0800 (PST)
Reply-To: fatibaro01@yahoo.com
From:   Fatimah Baro <imanosose@gmail.com>
Date:   Sun, 20 Feb 2022 16:38:15 +0100
Message-ID: <CAFEyOE7M=ZUrSROmPGAE3yrv-g10xHU=UARo1h+trJF7vepfMA@mail.gmail.com>
Subject: Business invitation
To:     imanosose <imanosose@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.8 required=5.0 tests=ADVANCE_FEE_3_NEW,BAYES_50,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Greetings from Burkina Faso,
Please pardon me if my request offend your person; I need you to stand
as my foreign partner for investment in your country. Please reply
immediately if you are interested, so that I can give you more
information.
Fatimah Baro
