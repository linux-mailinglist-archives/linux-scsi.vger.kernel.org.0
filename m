Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA60D550414
	for <lists+linux-scsi@lfdr.de>; Sat, 18 Jun 2022 12:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbiFRKuH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 18 Jun 2022 06:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiFRKuE (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 18 Jun 2022 06:50:04 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2059017585
        for <linux-scsi@vger.kernel.org>; Sat, 18 Jun 2022 03:50:04 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id n16so148651ual.12
        for <linux-scsi@vger.kernel.org>; Sat, 18 Jun 2022 03:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=4IWjHL/5Vo6JeFN3XdXq446L6FUUmY7SjaH1cuJ3kmM=;
        b=oJSXsd+hjcTa+5FRMo128dmamy8HwEW4emTcZB5C+W36LZnM3Qp+82V6pSpBruvhHS
         ZE+JPwiRMSFpA1vH12xHM0vfQXP0FmMjZjPFVjoomJ+xARCAfiBE+vjm3kIE13wOqTYG
         jaT4wmCVLb0Fhl06xKBIPd6YHUwjPDMzPd2QCm0gLUPF5qnlZz+mFg2R8y9PaB/cch0r
         fUir5FJbyzsPg3T+zdEoE//wp3Wl1hKyhGPbAfstIkz9HbFtl7cbiyn7LFoX0ufNDyUL
         z6e/jqtqSZoPGFV1tSFstsMd+7nrBWD6oJ541nENUK8SFIgCmFUkc18nweQWbCKfzgcG
         Pwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=4IWjHL/5Vo6JeFN3XdXq446L6FUUmY7SjaH1cuJ3kmM=;
        b=yifrZWAUdH7JuUj0pKUlvw/MTq10Zm0wYGz3cM/r887SZXT9fMDvl9pk+JjA3ftBgn
         dW9r8mVFQV70bdzvuQAe3lZu0bdHy4hNQ2ehEGSGy5G+q913iemsHvA9KMPA+d2LGCj2
         UUIkNTTjATrvdXlN08kHPNOUtEOx/33JwTPVSblSFeusvCHCu+wg4XA4qyazQkXwFlUh
         HvP3x3KeTEmFE8FRs2OD0s+OleiLcGfOlhZRmaDgmdLnhVcvG3sPncnlWZsEbvAfRUc0
         wR+WvxCp2e+UIvNPZ6GqlbD+P1KhtHLEmaX11AFYRSZ59cB/qCpEnMKehnJU2Slkvkpq
         17pQ==
X-Gm-Message-State: AJIora/wt3geRCfmWgXPFgQC6kesufukQ/uzyA45FkSaGkrmRkp+UDsh
        6GmUyfat0VvproNqTJHV9NP+XoUt0KZ1NwAzFlI=
X-Google-Smtp-Source: AGRyM1v2pjODsdgfxXbrdO/zn6uURIp17S3n5xM1FoMLGjSY7BJnTa7zbLRZSBeY9MJBZjjeDR26iMUFtBfAGDKADbw=
X-Received: by 2002:ab0:2c05:0:b0:379:6a23:a570 with SMTP id
 l5-20020ab02c05000000b003796a23a570mr5955653uar.50.1655549403178; Sat, 18 Jun
 2022 03:50:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:c18d:0:0:0:0:0 with HTTP; Sat, 18 Jun 2022 03:50:02
 -0700 (PDT)
Reply-To: jub47823@gmail.com
From:   Julian Bikram <woloumarceline@gmail.com>
Date:   Sat, 18 Jun 2022 03:50:02 -0700
Message-ID: <CAKM2rXsu=5p6XDw+_BRHQjTV_ofOR7yjShmp5=ANKk63kWpCjg@mail.gmail.com>
Subject: Please can i have your attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

Dear ,

  Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.
Please if you can respond, i have an issue that i will be most
grateful if you could help me deal with it please.

Julian
