Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6DA52217F
	for <lists+linux-scsi@lfdr.de>; Tue, 10 May 2022 18:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347599AbiEJQrH (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 10 May 2022 12:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347572AbiEJQrE (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 10 May 2022 12:47:04 -0400
Received: from mail-yw1-x1144.google.com (mail-yw1-x1144.google.com [IPv6:2607:f8b0:4864:20::1144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C950550E28
        for <linux-scsi@vger.kernel.org>; Tue, 10 May 2022 09:43:03 -0700 (PDT)
Received: by mail-yw1-x1144.google.com with SMTP id 00721157ae682-2f83983782fso186619657b3.6
        for <linux-scsi@vger.kernel.org>; Tue, 10 May 2022 09:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=FRo/ATiHi18y5eGWMPtqMab2ppBYGs71AR/aSWrmm9o=;
        b=liwDaNTQWQ/B/zdGnBcgrFEhxJZoIR4WCzM1EF36vicCJxDeeO/ruw2Oj5SKP/a3AO
         gow1yGEek+PF7SbR0+nnoeHLUATbzbctyWCVUjUf6Z5niD2ef2ArvxbaQ3qfbWT5vG7U
         lDUgVEYG1j4hDDktGZ6OGkdQ6z7zojc9hWmAJx9m9rRj8D9GYJlVFTLZ35CW6gTr1sAv
         JtEaVNilBuGGAcyXAEzwOvFsxF84ifNqFilwo7WCfP6GvFRWzu0tPvmR/QzMnRqPXneU
         AYy72fIexiYV57XKXIcg7ph5PRYSXithgn89rmY74EXQ3tf1O/WUCwVpWPc1DR5io/ia
         fDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=FRo/ATiHi18y5eGWMPtqMab2ppBYGs71AR/aSWrmm9o=;
        b=NOB5hFQrDmBBkzc10W+yJaT8BhkdZcfxpHiQlVFiPwh+jX4cN37bBhFXBLWUo3+VBA
         GxkEhWhanhe4ub4nzbMVHTcs/tgZBj+R7QMupjo9RsGR04KVoCw7eA8bj9xbz1JXL+LA
         8Z9e8551xlB+Eu16maocCKp0ECdwo1wTUiKdD6U2Jg6DVDteHPqombvN8znFTaDdYWxG
         9Bg9CQRuMrA6TcH2IvlsiZTCSkI50UccYUFShNfyAsR3ZbYo/SwrOir7MBe1Zx9JLSfx
         edGH3F6VqtBSGUc5zZ+FhhhM6iJ9qg0ZLvpzG7bem73UEVk23bBm2pfpozGqzkkWdlUm
         bFtg==
X-Gm-Message-State: AOAM533tyVDzsbu9IGGbXxXkDG7UdOZtgGqyXTpejhFiXNsFIksv5nde
        U7mC9bPL3WHyFBiyJKjS0IaVcmz7/STHUnOcLqM=
X-Google-Smtp-Source: ABdhPJzYZ/KLn+EHRNF0DftiqS9fVR+eO22Kyc18ChENj3VAF2SXZO3VzxLEcNxSlqSgP4vMge79bMPyrDint2047sg=
X-Received: by 2002:a81:1b54:0:b0:2fa:f842:bd7b with SMTP id
 b81-20020a811b54000000b002faf842bd7bmr20165536ywb.170.1652200982605; Tue, 10
 May 2022 09:43:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:3cd:b0:28b:e76d:8ab with HTTP; Tue, 10 May 2022
 09:43:01 -0700 (PDT)
Reply-To: biiioqq@gmail.com
From:   Rev Sister Grace <kiasskiww@gmail.com>
Date:   Tue, 10 May 2022 22:13:01 +0530
Message-ID: <CAOWny3PnVuFHwpxjP4u5N-sY7q5fp8zBQpx8wh6Z6_Zw-s66+g@mail.gmail.com>
Subject: Rev Sis Grace Charity Work.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1144 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [kiasskiww[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  0.2 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.5 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

-- 
My Name Is Rev Sister Grace, Contact me for a Charity donation of $2.2
MILLION Dollars to you for charity work. Send Your Full Name & Your
Phone No At: biiioqq@gmail.com
