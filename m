Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BF254A088
	for <lists+linux-scsi@lfdr.de>; Mon, 13 Jun 2022 22:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244988AbiFMU4k (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 13 Jun 2022 16:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245601AbiFMUzQ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 13 Jun 2022 16:55:16 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB74DE4
        for <linux-scsi@vger.kernel.org>; Mon, 13 Jun 2022 13:27:41 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id e20so7015882vso.4
        for <linux-scsi@vger.kernel.org>; Mon, 13 Jun 2022 13:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=f/v1gZW2d1xf+y6gXLTGdOPEOS7UDztcZyURQzQMDp0=;
        b=iV1wU8igYYc8aFTG1C2qNx2u/f1vdLEov7GeicSvbHQJwCzJR0+XmynJx9EhU4ie4F
         jPg2I0s24/+ikZkCDiwK9s851r85HJc84RAu/6Z9EWDPGcxEH0BkxikcnAiZNnYC4rBh
         /+8diQYw3nvFmOf5AOjqc7uQIeTxHeWLvbABSAtmbLVAF1NmmrE5VokEB3GpJFtV92mz
         Z2COsLqUeh6XgwXZ7ZyQ1GmDF7XuVOW4bZn06Ua10m6oIFxzgOPGMHhUQn+uW3pYfBk4
         LBF0fM/lwZx42G5aXtLzCTUPZZt2HYZhzSfRSBRTeRUDW0PmG3EvWAfnfWKvLf5wRfvv
         2i/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=f/v1gZW2d1xf+y6gXLTGdOPEOS7UDztcZyURQzQMDp0=;
        b=McrX6mhPMrt9zpSvD+PXHA1rstrnwxcuoN+GJPEGEzYNDCHUWNm3rppKJTdD39k8yO
         sRy4typyA/VuYnIN+pfF5NKMnEzOWcq3ctUsqPjYU9Za/ZxBEFcr968s9fzuqeMdr0WO
         ZeOc7RCRSnOyWGMeC/UdZdLnz9m1QITtsIlbNPYOnIM5D/8AvKM1Cy9wo8IIx4vUdkpN
         m3aIeAplC5NHQRkcmAfs3oA6jVq9BRSU+pYOnCp8cC42zQlKc7m6aJjpjVABxfSohqui
         kZCtMp4DQNvU1xFNjCnqRX23FJXMgZfKbAtP/1o7sP1WPdx01BJfuWr2/8ff3Nof1GWM
         rrpQ==
X-Gm-Message-State: AJIora91TUU1W5rl4i1wUroNTlBJpmjDe7e/li9214N1OwU79uWdraPi
        DsQejGIeuwu8Wg1QwigZL2dbDwiiIAo2YpUMPhU=
X-Google-Smtp-Source: AGRyM1sBYWpfyeQkD6pA6OKHKwqiBSHC1n08vQLFMztJw0fYixZgsglIR54SedZWa1PF/xdhd5MBW5VKoso+VKSHPNY=
X-Received: by 2002:a05:6102:953:b0:34b:920f:e8f0 with SMTP id
 a19-20020a056102095300b0034b920fe8f0mr531465vsi.73.1655152060498; Mon, 13 Jun
 2022 13:27:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:bf8a:0:b0:2ca:3b5c:ca48 with HTTP; Mon, 13 Jun 2022
 13:27:39 -0700 (PDT)
Reply-To: nikkifenton79@gmail.com
From:   Nikki Fenton <gustaviagrowe629@gmail.com>
Date:   Mon, 13 Jun 2022 22:27:39 +0200
Message-ID: <CAEmpkiDpmTS23rOA8toDpKQQ=QyB46=VH66FoEcjAULoj5VWog@mail.gmail.com>
Subject: Please Read
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Good Day,
I viewed your profile on Linkedin regarding a proposal that has
something in common with you, reply for more details on my private
email:nikkifenton79@gmail.com

Nikki Fenton,
nikkifenton79@gmail.com
