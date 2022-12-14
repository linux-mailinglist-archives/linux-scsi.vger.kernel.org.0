Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323E264C9C3
	for <lists+linux-scsi@lfdr.de>; Wed, 14 Dec 2022 14:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238542AbiLNNJH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 14 Dec 2022 08:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238550AbiLNNJA (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 14 Dec 2022 08:09:00 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C145C17060
        for <linux-scsi@vger.kernel.org>; Wed, 14 Dec 2022 05:08:57 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id y25so10315032lfa.9
        for <linux-scsi@vger.kernel.org>; Wed, 14 Dec 2022 05:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PedTboiFtvABud73ZD3U4hUNQIS0oeFWRBzeT0lU6t8=;
        b=KxNdjgQBBMefpFtO1FEOgrggLT8o+qZDfroZw26F0Wv0Nxpn0xu9xNsdKWRy3Tw8bn
         3uBMa/7AEqqjC/PMfuoqKWvVC5DOyip+tZtU9MJs5nl4fxwWT0YGm7OMC2MTSporlAgR
         uNGX8CUL49SHU8ddhDx3ElaxyXbolwzGfnMMmldXQp7emry9hbmp/KuPRA9F0MjIiQ2Z
         dSkIzopkbTiIVz4K7tlH0kGmyqbalMk02wZGbh3IlqwfrbR9rDnnd2pXSwUjeh/EtUjQ
         +M9S8N5KIWGbu1MopCKi+Y+KYZHT6cDTVnC+/G9IM5GpspwyQ30hFg/66iuFDlheHyUP
         TBPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PedTboiFtvABud73ZD3U4hUNQIS0oeFWRBzeT0lU6t8=;
        b=6xgZn5I4DtpNPFZ2SbK40MTopsKbNhTpBxHe6P0LdHoqQTgWUV/0QxbPuE2DxTlqxJ
         vSHrUkGo4iLzDkPwXyVvPrdsgEnpwogvA3AYIifzwpY0FQiJYXZ/Xwwu8kNuRjBxMHYr
         DNB9nPwt7SwGcYm8lOEiIC3wCto2CbEYq42ZRy2dQZLAQ6rKLEI3yWtjMjC1aV6XsOq/
         CEnHjMYhb2mgPvaDTICKzB0ROqKmUXXhTRYifT+S3sxkosoWQI38w8mCc6JwPmsEVJOx
         rxRzTYEloUq84HF/GFzdg89Wx1KfxSJisE2Hf/kvIqGyJNNmq2knKnLAlpIT+lJB7CG9
         YzNg==
X-Gm-Message-State: ANoB5pnliGUQ38Q7aUW3rEehj3VLGSJS1fokDYjX/G/ZIb3O1JSx3Szy
        s5x/2N+fJ549DGQK6QxXBZ0AdohX7FfWVK+2xBI=
X-Google-Smtp-Source: AA0mqf7aqfGeGqDDOw+H/ntC+nwy73TSEmbwetV0rbXvZf5FsiA5pNXvyDL3eCkdfjVsC5t7TR7v31XEbh/l8BEoqhU=
X-Received: by 2002:ac2:4563:0:b0:4b5:afc6:1f74 with SMTP id
 k3-20020ac24563000000b004b5afc61f74mr1466029lfm.577.1671023336032; Wed, 14
 Dec 2022 05:08:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:651c:1597:0:0:0:0 with HTTP; Wed, 14 Dec 2022 05:08:55
 -0800 (PST)
Reply-To: a2udu@yahoo.com
From:   "." <urri8344@gmail.com>
Date:   Wed, 14 Dec 2022 14:08:55 +0100
Message-ID: <CAKzm1Z4NTZFpkD10SG0cQ6+WLXF0_7ELoUXkkr9FewwDX5Z7SA@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

-- 
Hello

The money is ready to be transferred, kindly acknowledge your interest.
