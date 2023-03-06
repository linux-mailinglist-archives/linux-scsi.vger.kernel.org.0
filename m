Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F68E6ACF99
	for <lists+linux-scsi@lfdr.de>; Mon,  6 Mar 2023 21:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjCFUzL (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 6 Mar 2023 15:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCFUzK (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 6 Mar 2023 15:55:10 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE8E3B21A
        for <linux-scsi@vger.kernel.org>; Mon,  6 Mar 2023 12:55:08 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id s18so6410666pgq.1
        for <linux-scsi@vger.kernel.org>; Mon, 06 Mar 2023 12:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678136108;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ZZZdjoB/M7aLHtUWeNwJwsyHFYWeUmbWoGEQvZrODI=;
        b=VFc8b4kVMKZt6VOxj/S/2HFa51ssPQp5qOB6cGY3/WEO5/U+R+e5NryjCkeomCAEfK
         LlH1zDIcHznWBxK6yNubgjrguM/x1L6P44kfidoPrWA/LVL8ylOSl75RRHSUgcg06Xgi
         Jg86F3ehxHGtq26u/dNOh8kiiJIrQ4M0jdWKE4jxHhkH7ZV9EgnpCM5FGJ3SCN92jV9L
         SNhOYxAJ9gJl9JDnTfusvucmBmmFIRxSrk/78zPNEF0mAaiWprDy5hX8o2mg2SDJI5+R
         SOU8pLzUH9ZOYlLCX1ei2ZVzWEfjsrknkBY8of/iMPR4sY92COUAXmU2wjsJfBHMQr8B
         PV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678136108;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZZZdjoB/M7aLHtUWeNwJwsyHFYWeUmbWoGEQvZrODI=;
        b=XJm6zoJoXPPeeGWTNxXA0JTM6FtotjY8cdAKSzDC9Mgp5ar+8K1VPfpUg8kZ6Z09t9
         3l4WReqAJwAOyJ3dpFPrSZR4ItZZNevkCtKbPubcWGnIgNSJLeSqD6S3OHoGRM0pItsX
         EvxB2M0XhqcI198manfeCoGkuPQi+GfsiKJD0Rat6t1/eEmZvbcsyL/aeOuvH1vMypHF
         vQzX3vIYcvdHPj6gEBc62uACYbM6CnOtclq6aAoT+kisOoFkoOVx+tVkqxrOFgCQsKie
         3fiorSAnCaSjlJr1+aNQV4JnYxAqVP4gACuww+Bg/5MRnjT1og+yuFegEbPk46X17GKW
         cKjA==
X-Gm-Message-State: AO0yUKXtlOGGxq28h8N5ISI3n0IYSF0OjIeKzgyY11FH6HpThn0Qr8TG
        MabYZ2wYIkWWUdx22pK0pH2NKthYcsim7ZOYz/U=
X-Google-Smtp-Source: AK7set+hJsxHOzQ7Z/oRJu/e5s7RyJDE4PoTqlouOJQ/hP1+biWPVB/B6jzwu8W/GJ7zXwmrNcPtKeLJeiH9APprP+I=
X-Received: by 2002:a63:7f5d:0:b0:501:26b5:f0d2 with SMTP id
 p29-20020a637f5d000000b0050126b5f0d2mr4204699pgn.3.1678136108078; Mon, 06 Mar
 2023 12:55:08 -0800 (PST)
MIME-Version: 1.0
Sender: un30110@gmail.com
Received: by 2002:a17:522:d272:b0:4cf:317:32a1 with HTTP; Mon, 6 Mar 2023
 12:55:07 -0800 (PST)
From:   Calib Cassim <calibcassim00@gmail.com>
Date:   Mon, 6 Mar 2023 22:55:07 +0200
X-Google-Sender-Auth: jfZ4-_pjAHh8-usUkSrZNsNJyZ4
Message-ID: <CAL6GujSD=j8GYJKtrbZ52QzEr8vVWTWooHBQ8hPT1MYPdRt5WA@mail.gmail.com>
Subject: 
To:     calibcassim0@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.2 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLY,LOTS_OF_MONEY,
        MILLION_USD,MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:536 listed in]
        [list.dnswl.org]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [un30110[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [calibcassim00[at]gmail.com]
        *  1.0 MILLION_USD BODY: Talks about millions of dollars
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  1.4 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

GoodDay,

How are you?

My name is Calib Cassim, I work in Eskom Holdings Limited as a
Financial Director, Auditing and Project Implementation.

I got your email from my personal search on the internet for a
reputable company or individual to assist me sincerely.

I have in my possession an overdue contract payment executed by a
Foreign Contracting Firm through my Department, which I officially
over-invoiced the amount of USD25 Million from the contract of
USD500,000,000.00 (Five Hundred Million United States Dollars).

Though the actual contract amount has been paid to the original
contractor, the excess balance of USD 25 Million unclaimed.

Since our Reserve Bank is busy paying our foreign contractors and
agencies, I need your urgent help to front as the beneficiary of the
unclaimed amount as a Foreign Agency to enable me to obtain the
payment approvals on your name for the transfer.

This deal is completely safe, secured and requires confidentiality,
and your line of business does not matter. If you are interested,
please indicate your percentage for your time and help to receive the
money.

Kindest Regards,

Mr. Calib
Email calibcassim0@gmail.com
