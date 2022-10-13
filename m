Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675315FDE02
	for <lists+linux-scsi@lfdr.de>; Thu, 13 Oct 2022 18:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiJMQKL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 13 Oct 2022 12:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiJMQKJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 13 Oct 2022 12:10:09 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6154BD16
        for <linux-scsi@vger.kernel.org>; Thu, 13 Oct 2022 09:10:07 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id j7so2589115ybb.8
        for <linux-scsi@vger.kernel.org>; Thu, 13 Oct 2022 09:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7yjFQDpt1A0PVB6Y+z0WDz8WhkQFK/ECc36rIFhhsU8=;
        b=gl8Yr7f0+rYVV9sNgkoTbuWBKPTv4bo6yQLugOL/XqGa12mXRpO4gXQBxWaDFx3JTk
         0s5i2s7SKZPHqhzBakBtg2KhnIjKsmLI9wBsfeQSKIuRKRjYO/DRXJn2oByDeo8EOqI/
         lbvwWe/WKa1AWuXnh3I+0lu1YM0bp762lI4mg7dekE8upYQFcbLDI/Uq1fpbJD+obYU2
         X8QF4JoRenSy1EV+Uu12F00KCIYhK3YcvWSkSOd2RuKgSWJpmmH/l163UZZjY4ublKw5
         CY+4sSbhbTAkUb5fXmvf4gAlx7v81I14nvhGLxyPdTpGClm2splNf3tHkgryVkfSOsFw
         xyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7yjFQDpt1A0PVB6Y+z0WDz8WhkQFK/ECc36rIFhhsU8=;
        b=uam+ouDDiKueu/ZNa/4ZJiBYfGo2SYibXmgP1PGYQTdZej/+o+xaxFHopumrHyssjo
         kxe2DPye6oNoPyKz6HbVuVShgCaXE9DPblOsRORp58keiGUa1ouPX1LKntDR24uT5gZX
         Gr2kmGHtuT7jTSEoj7w2HKnRoZrudyzOMqc9QhdZQakKBrKf0Y4ZuCQWMgFqXq2Fwn62
         mw+UJ/CjgCqaSZBGzSZNAOB0Nhs5kxDVutRxY25HFNPahy09crOqbpBjUMGwOFWeHs4A
         e3zV7G8mWtOsHQa3xhNLIzvMJKK8wjKOpOM71bSahDIKwlevq7rz5jaEwMD4W8Mb6z7w
         GIuQ==
X-Gm-Message-State: ACrzQf1h/sU4kLq4dnKT1nkAyq3ko7r9goQy4K3kFGQJWe0UcY5at4g/
        u6bog1LVW2+VYCFxzlq+9IU2eKYWhIEuGZTW1ZI=
X-Google-Smtp-Source: AMsMyM4zsZHg9JyCYNxR1tMV59gL2d8MUKWPmcX6CVYGKoNf8trHbQmDSgNTqsijsQgb9ZKQbC838YB/tv2LPJMP+zo=
X-Received: by 2002:a25:ba07:0:b0:6a7:82bb:1041 with SMTP id
 t7-20020a25ba07000000b006a782bb1041mr691983ybg.102.1665677406258; Thu, 13 Oct
 2022 09:10:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a26:7d7:0:0:0:0:0 with HTTP; Thu, 13 Oct 2022 09:10:05 -0700 (PDT)
Reply-To: rosedarrendr@gmail.com
From:   Rose Darren <uwasunday50@gmail.com>
Date:   Thu, 13 Oct 2022 16:10:05 +0000
Message-ID: <CAP4SeLB7kQ4rV42UcFa5f9Fx46ftCxwqS6KwFm50z23QOtRMUA@mail.gmail.com>
Subject: =?UTF-8?B?SGFsbMOl?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Sn=C3=A4lla svara mig, jag skrev till dig f=C3=B6rut.

H=C3=A4lsningar
Rose Darren
