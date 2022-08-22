Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCE459B98B
	for <lists+linux-scsi@lfdr.de>; Mon, 22 Aug 2022 08:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbiHVGcE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 22 Aug 2022 02:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbiHVGcD (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 22 Aug 2022 02:32:03 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE97A24F1E
        for <linux-scsi@vger.kernel.org>; Sun, 21 Aug 2022 23:32:00 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l33-20020a05600c1d2100b003a645240a95so3064013wms.1
        for <linux-scsi@vger.kernel.org>; Sun, 21 Aug 2022 23:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=o31t8HDG7QptfeLJ+04Jkz8j9NFHlDWTE2XxPfy4mY4=;
        b=WkmBV7ApXFb3L+10iHMOyXMb9NfH558TJP7OMkIyv+1tZVGb+gPc0RyeiYIe/h4GdO
         InXpIRUzRApofByqxum4fqgXaPfxHb2G1afLnvfGzQlMH4YTBPcj7Rm3IMkECkhm8G4H
         yMopm1tbOpl/bHkh59n3MxephKEAAelE3btKwr8EIkuZjfuugfTpIoY0cEhAhFDzxfcH
         /gJfMR/dIc6KI+6Ge22i7baeR6+DSf8K2fZQ6RiVjyqisJLiB5/R9HEAfqcPP4M84Qzb
         3RYHnWbVAtriTSLnmChYUH773cEqEH1/3sNs0PvCMynhC8i1pUwJmJDzHnRwSyGzduQP
         QWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=o31t8HDG7QptfeLJ+04Jkz8j9NFHlDWTE2XxPfy4mY4=;
        b=jKqleZe25eD2s+4sU2uBP34XjEhA+ZTldKeTr6C+T5cWNzEop8czdzhCyN/Y71GiV/
         ZsSqYMr4o98K/5jj2Hki4leroIOsXP1kKiwuWFR37ZqfeRfUwBeDShgYgiv13sL2VAml
         tYV5zML+B1EDAl4ytnhZVgcL5Di0We/N67obAWvVuW104nRKLvs0mkTB94gWNcm91DZR
         IiQ6E7c4sJcB/g/e+UPlqm2H/O9KW2YW7FhITQwEA1MHKQdCXoWPiS73NFo0JHi6b01e
         BQe3O2IjayXg+AtlUk2gMCvCpujH8ooLA7M3KsG8h0lF1E8xjXfrqSBKCZGKn0Vt9H+b
         +dng==
X-Gm-Message-State: ACgBeo3M4E3uss92l5SwPEu7Ub4rtY8aSU5wl06JbSHwfBJUARTAFWbA
        i4qKUT2XesDCwrPxjypoCZKz7foz+PVoTsF/O9k=
X-Google-Smtp-Source: AA6agR54gcObDCJwTIDbuVf+gqlwPTpmOCYwBTpzBk78YiVmVkXSLWAmPKqNPbv8q1S8h8D8RBFCBUuxdh1tVNe3Vms=
X-Received: by 2002:a05:600c:5008:b0:3a6:1cd8:570d with SMTP id
 n8-20020a05600c500800b003a61cd8570dmr11190552wmr.57.1661149919293; Sun, 21
 Aug 2022 23:31:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:5444:0:0:0:0:0 with HTTP; Sun, 21 Aug 2022 23:31:58
 -0700 (PDT)
Reply-To: maddahabdwabbo@gmail.com
From:   Abd-jaafari Maddah <sheishenalyeshmanbetovichu@gmail.com>
Date:   Sun, 21 Aug 2022 23:31:58 -0700
Message-ID: <CALX-7+1EtAH-+94sA4Gcb6NRLviVCbhzAAc+WfsyZBEwsKnfJQ@mail.gmail.com>
Subject: Why No Response Yet?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.9 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

-- 
Dear,
I had sent you a mail but i don't think you received it that's why am writing
you again,it's important we discuss.
Am waiting,
Abd-Jafaari Maddah
