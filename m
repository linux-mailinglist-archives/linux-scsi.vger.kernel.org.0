Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5026E1F44
	for <lists+linux-scsi@lfdr.de>; Fri, 14 Apr 2023 11:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjDNJ1r (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 14 Apr 2023 05:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDNJ1q (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 14 Apr 2023 05:27:46 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7C92100
        for <linux-scsi@vger.kernel.org>; Fri, 14 Apr 2023 02:27:45 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-187878a90e6so7278181fac.0
        for <linux-scsi@vger.kernel.org>; Fri, 14 Apr 2023 02:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681464465; x=1684056465;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y5t9haSUmu6+LRsJr/oOTk9eZWnzPg4O73mmGdbJGS8=;
        b=mnBIqAQ2L5Ze9F2kBJ8W2oieZItv/QJkyU3jvSFUohV042BVHDi03huxptU/Cuq2z6
         gI8Cz0QPtjX6jGxcB6GBpdosvUFqER56eRrzVmb/MyxBBtjwXJY7hEALaIDGbysKWkgJ
         cymBPwhOfwGH9tfLNfebXs5kkxZLHfbHkSVfZDjqJw6y9hMUjD4MRaaxohpJoAOCg2Xj
         g+u8hYvvTd+2RfoHWRSewEA93dONk4Pf6ygJdwXNOlFLCv4GpteqNlowrhZXHXjo2XDW
         LeuncbvhGK/uzNwC60OymMOmJxdlz0mJ7wqfaykNl+ik96L43/Ekv7IerTXBtT+wWRZM
         6VwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681464465; x=1684056465;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y5t9haSUmu6+LRsJr/oOTk9eZWnzPg4O73mmGdbJGS8=;
        b=U00nlsip/rwMYS7aynlhpbFgXjDcgD5UoMuA7FEgKCkx1O085oexxxOQlt6gdMZbhU
         Ww5XPX1oSwIgz0l1Cp+/0Y2VXZcqy9ws6ou1lQboqcuyJ6jtHMvGxqNq8tos/UnLcbW8
         0/lx6T3nx0K8ZeHTgk3F0lL+ir7dKOTxbNmH/8yU6fUz788OwgSZCT9+AKdFTBiET1KP
         jFuE3jx2ruxVyzcevNG8w/QgQPvL4vabFna9/Gzar5AgUjNe3xYrvo9/BP1TYL6sB1WG
         dXdvcAHrNf8M1uCAQls8klmRFDFlCIomGM5Nv1Q9XYbiilOjTkgLs0CewYQbkd45tYr+
         PcEw==
X-Gm-Message-State: AAQBX9dfdgbJ8adSdu7KCZGNiKMTtD08UhmiWNrdPbFZ1v3LH0a+ukj+
        EVWZYw09mSaKpP3mZA7YK/x78bgpeB8AgPPUrJw=
X-Google-Smtp-Source: AKy350Yzfo5Bw2CHdA1XxIFSMmjIAl5hoYHTb6reyp6zrf/18GsEX+3P9LzNDs9Uhm7Kz2nl1QXS8A2g1K4k3CBRgII=
X-Received: by 2002:a05:6870:5606:b0:184:68ea:5205 with SMTP id
 m6-20020a056870560600b0018468ea5205mr2717600oao.7.1681464465046; Fri, 14 Apr
 2023 02:27:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:914b:b0:10e:bef1:3a6e with HTTP; Fri, 14 Apr 2023
 02:27:44 -0700 (PDT)
Reply-To: felixglas37@gmail.com
From:   "Mr. Douglas Felix" <legalrightschambersfb01@gmail.com>
Date:   Fri, 14 Apr 2023 09:27:44 +0000
Message-ID: <CAEMzxqVtwPqLbPigXmpMv=LOnnrUvWYnoxm95W=cno0bP9ozLg@mail.gmail.com>
Subject: =?UTF-8?B?5YaN5Lya?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

LS0gDQrkuIrlkajmn5DkuKrml7blgJnlr4TkuobkuIDlsIHpgq7ku7bnu5nkvaDvvIzmnJ/mnJsN
CuaUtuWIsOS9oOeahOWbnuS/oe+8jOS9huS7pOaIkeaDiuiutueahOaYr+S9oOS7juadpeayoeac
iei0ueW/g+WbnuWkjeOAgg0K6K+35Zue5aSN6L+b5LiA5q2l55qE6Kej6YeK44CCDQoNCuiCg+eE
tu+8jA0K5b6L5biI44CCIOmBk+agvOaLieaWr+iPsuWIqeWFi+aWrw0K
