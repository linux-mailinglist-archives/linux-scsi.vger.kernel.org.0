Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A064717DEB
	for <lists+linux-scsi@lfdr.de>; Wed, 31 May 2023 13:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbjEaLXk (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 31 May 2023 07:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjEaLXj (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 31 May 2023 07:23:39 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AC2D9
        for <linux-scsi@vger.kernel.org>; Wed, 31 May 2023 04:23:38 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-6262d8688baso24998516d6.1
        for <linux-scsi@vger.kernel.org>; Wed, 31 May 2023 04:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685532218; x=1688124218;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0vYtin6Pt9fk/KX6NzIP5a0qHlH+oqnq5Q+uztXALyQ=;
        b=km5YymgqFzS+eie2XCxTd4uVSj/nHlbKiPzffKJLMM07G+QdfDSTwdcyYMcxDOGuHA
         JI9iAUZY7hUYsU7sTXnZLl6rW7uRHwJW+q3z1hWfIzVheA1BLmU+aoezVM9vlX9PfTfQ
         3rVpbkmMA3/DNSp3klpoPhh/15Uaa8PW+whGZW8e+23x6N9+pGk3yf5YF+SKN7TErnzq
         Qa7ESGvZGwArSesZxTerT2X16Iky4hK25O87zO3hxINHJBHls05yjJK4P1fODCKgPUzd
         4A2T/lRwQ9f1tZEwOD+xyCRTqlX5B/AYvGksHB6LRC8wNCk+Nua7TtOl9W0bxhbZR273
         Vn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685532218; x=1688124218;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0vYtin6Pt9fk/KX6NzIP5a0qHlH+oqnq5Q+uztXALyQ=;
        b=Obf1uAdV3/v5ybu/pUp8dsWk7rXToeFME5J+rkD3wG2Nsp8D+jZIg8QWvZ6VQ4e0GV
         RUSCQu8RKGA/nPJILbCtqmjbI3+REZNGTrGn9ncns7QU76fSdTcYd048+mu6XN9M2cfQ
         tIIuI89nu0DZbeUEaMGyf/5GX5ATIf/HR8IcPZAbxcLnwyJZR9EiNurGtMHPiskafIZu
         wZFENgQYxakzzqs4/jaxikrk/TI0YsiI3Any247I6/PumTPdLCPWq9DMDIMTDZ1HfFRh
         oZcc1M9YDOcuE5fgBUmt/s/RY03wtaREZ6hySD5xAyDfcssE+Tm89Dqzq3+R1UnHa575
         YGug==
X-Gm-Message-State: AC+VfDwZ6Ogni2wZs8/TauFMChct5cb5FIH9bi4ZKl+d71F9L2e8OsQO
        0EdeFSirzQXXiW+l8pugTSoeMtUBtGX8D+7swlc=
X-Google-Smtp-Source: ACHHUZ5YzOTHh4dqyrt6BzbpD+EpgPvoAuuag7ucWyNR/0qspkOYZDK4GXn0kYjJs6K+SNw5Lg58FZVVWJbp75VuUHg=
X-Received: by 2002:ad4:5d64:0:b0:626:29d4:9a0d with SMTP id
 fn4-20020ad45d64000000b0062629d49a0dmr7107057qvb.53.1685532217867; Wed, 31
 May 2023 04:23:37 -0700 (PDT)
MIME-Version: 1.0
Sender: mellisabamba40@gmail.com
Received: by 2002:ab0:224d:0:b0:689:a8c0:29ff with HTTP; Wed, 31 May 2023
 04:23:37 -0700 (PDT)
From:   =?UTF-8?Q?=D0=BB_Denis_Malo?= <denismalo92@gmail.com>
Date:   Wed, 31 May 2023 13:23:37 +0200
X-Google-Sender-Auth: jjPjdJkyISF58gKBL7jFSrzhSks
Message-ID: <CAFrrkapRJ05jvwCmVvLk6n+KzP-bBubuY0WsOPC1vhcAQLwt7g@mail.gmail.com>
Subject: Hello Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hello Dear,

Be informed that we have received an approved payment file from
FEDERAL MINISTRY OF FINANCE in conjunction with International Monetary
Fund (IMF) compensation for scam victims and your email address is
among the listed victim's.

I write to inform you that we will be sending you $ 5000.00 USD daily
from our office here as we have been given the mandate to transfer
your full compensatory payment of $ 800,000.00 USD by the
International Monetary Fund (IMF) and FEDERAL MINISTRY OF FINANCE.
Your Personal Identification Number given by the I.M.F Team is
CPP0920TG. Here is the payment information that we shall be using to
forward your daily remittance.

Sender's Name:Cynthia Eden.
Amount: $5,000.00USD
City: Lome
Country: Togo

NOTE: The MTCN will be sent to you upon your response and confirmation
of your receiver information to avoid wrong transfer.  We await your
urgent response to enable us proceed with the payment.

Our branch manager Miss Cynthia Eden will direct you specifically on the
procedure.


Your Faithfully,

Miss Mellissa  Bamba.
