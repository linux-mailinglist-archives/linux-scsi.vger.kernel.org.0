Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1A4700359
	for <lists+linux-scsi@lfdr.de>; Fri, 12 May 2023 11:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240389AbjELJGz (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 12 May 2023 05:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240378AbjELJGy (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 12 May 2023 05:06:54 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B20D04D
        for <linux-scsi@vger.kernel.org>; Fri, 12 May 2023 02:06:52 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-24e16918323so6710187a91.2
        for <linux-scsi@vger.kernel.org>; Fri, 12 May 2023 02:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683882411; x=1686474411;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7upYASidmeqEEydII3qqc7RD6bnaXjO6ELYE2uwAgE=;
        b=qE6GzOtYW281GDhq/AEJaReNIL7xesJkaPMjmmgLXzESt3ZWS8IkTXhsGKWaxAla4A
         8U4xMJpvJBKcm53nIjU8V7H3U+Lf6RgWWrQ6F4oXVrz4Sqa5kZssynQR8qGGousiWCrG
         l/7/uLaBRyjLqmqnu8DcB6C8gOYVCPXlHsYXKjWJSbwUDQtL/r7dctbTe0p9m915GU2o
         Wu7fZdGmTM2V8w44N2mWI+0k0HlFUXSnEkzcjufRSC+1N+Lr8wJQnm0dh68eSjlKDbRi
         g1duGz9fV7afSzWtXPpe5+38qdWrIZ974oTeLom0wk08rf2urhdeev+N1hxz57yKacxD
         ds9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683882411; x=1686474411;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G7upYASidmeqEEydII3qqc7RD6bnaXjO6ELYE2uwAgE=;
        b=km28u0q2GgZECZhNGm3yi5IrmNLDgPozzT9/yvazMaI3DYxQqmlUQBmrC5HNVtNZrK
         +yLBg06FeR7nprTm4roGvOjbe98iqgj1y1ktX93SCYSQH3N0nPhDmeO7wB9d9Vob7NrF
         oIxVZ+FR6a6P8QGlYaLowvsh0E+Te2OFggzPq7HjSODpV0k3Iz/1KgNiUW8bH6pdHs3M
         IgRTcK7AhdoUwVQmsnecIpX7Phbbc5IY4p6W4KgTBOuxsE2b84FSZ2/sJWr948Zyyb/n
         L0OHQt4k+WIzvAy/rqspRlbUxBcG0TmRHx2wDfZxk3uNn/9nfpT2L70lfJWJ/80GOl6T
         TbNA==
X-Gm-Message-State: AC+VfDwq+2+dM3u+p7kcIYKZzjq9mIeNI8tWu2OeeSSgKxcXd18u4mV8
        SPeCF4843pcaDf22BxhR3K9iz/hsY5LXwxG8qBU=
X-Google-Smtp-Source: ACHHUZ5L+56qjRoZ0ElPbLz96Y8prJs+A7z3h1CfGaJWbQppb/OiQwN+Y3aGqssmGYqHiK4mtNI85ATilRgYXaBmHZc=
X-Received: by 2002:a17:90a:82:b0:252:8f70:c807 with SMTP id
 a2-20020a17090a008200b002528f70c807mr5057071pja.12.1683882411291; Fri, 12 May
 2023 02:06:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:c64b:b0:47b:66fa:94f3 with HTTP; Fri, 12 May 2023
 02:06:50 -0700 (PDT)
Reply-To: mariamkouame.info@myself.com
From:   Mariam Kouame <mariamkouame002@gmail.com>
Date:   Fri, 12 May 2023 02:06:50 -0700
Message-ID: <CAA_std6YN-M4ETaSbwqQ+ymi4dMszMnn6y2e2ETQEXeAgobzUw@mail.gmail.com>
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
you.I am looking forward to hearing from you at your earliest
convenience.

Mrs. Mariam Kouame
