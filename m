Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9D453F710
	for <lists+linux-scsi@lfdr.de>; Tue,  7 Jun 2022 09:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237571AbiFGHWh (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 Jun 2022 03:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbiFGHWf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 Jun 2022 03:22:35 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FD913D04
        for <linux-scsi@vger.kernel.org>; Tue,  7 Jun 2022 00:22:32 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id h19so21791755edj.0
        for <linux-scsi@vger.kernel.org>; Tue, 07 Jun 2022 00:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=OHbou33WPhW0PDy9/CZae9mIrL4buN3/FALSld4obAM=;
        b=gbUPyH9FhMYDGLkSiDAHDIKaSoblWLvMidaaT/8fxgWHYqQvwKXHB2yDCs1UmDZAd/
         VmjPAKDK3YTKasP3rJspx4x+GAO62S0j/TpwxCsaVcve0/Op3TpU6FP6FgjOm8N93CPR
         7d4x7IeWB9jGvhBngdGYYgOmeIXKcLFSLRbvqQSnTKKb6fQ7vfv51haw1BcwMtsg3Bbv
         AWHTFl4XhtDBPAkG/j6uYg9/4EdI1Mx4CCXWvHBqBO1U2PwrUAVJNNUKdWNs6eSk7o6P
         RIA45bfJPUvJ+fM99WlNYfZ+EZIQFHMXYHV2sPuwtKT/6KJxIHblmrDdylKu4+7/eFew
         sD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=OHbou33WPhW0PDy9/CZae9mIrL4buN3/FALSld4obAM=;
        b=A8+G0PKulSuegRPuBazqW6JJdvppnstjRT+v6F2t0rZxGQldtbQWFP83tWqbSk6sTp
         yPoZPCYVYA9FA4lzT5sQfosLYRIyLz2ywqfuCHyhOhem2u0hEQtxJWMxOS2D8CoNQR/D
         xNjehCpiovEs7Qcrj3J97OarbxeBxcaPLBEHcCOsaDxWAZcnsWAzJdLtkS4JverR93h4
         tbNwMqPSwZYeziuyPao5wgAf9rXwo5TqgPlvNz0XTJnDte86nWgfwcdVgW4idHX9szUF
         BNDyWBlWANSPWAoZBhw7llKzExgXcXiFE0VCxRCuAVWjXR5UDvpjatul8rCA+vhvlLUd
         sNyg==
X-Gm-Message-State: AOAM5336VotnEs8h2xaO40I0yV2W605wzccKNqK1MXgwt7d2cLBl1V+A
        Vb8Md581ayE0/JjGJt8supFr+U+kfZjtE5TDjmE=
X-Google-Smtp-Source: ABdhPJwdMIItCqZqOHed9Z3Wev1gU3Bl4yKtT+tkEc71GYlqm7jeaNKIsrKYwP3kZjRD8QHPgqQhpbLx+cw2/CHAbOE=
X-Received: by 2002:aa7:d303:0:b0:42d:d192:4c41 with SMTP id
 p3-20020aa7d303000000b0042dd1924c41mr32071420edq.178.1654586551382; Tue, 07
 Jun 2022 00:22:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6402:26c8:0:0:0:0 with HTTP; Tue, 7 Jun 2022 00:22:30
 -0700 (PDT)
Reply-To: andyhalford22@gmail.com
From:   Andy Halford <fameyemrf@gmail.com>
Date:   Tue, 7 Jun 2022 00:22:30 -0700
Message-ID: <CAATdNavv99j6iodD2vEQKOz9W6KZi4DJ5o4_e0G9xx4vSY09qQ@mail.gmail.com>
Subject: Dear Friend
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.8 required=5.0 tests=BAYES_50,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:542 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5162]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [fameyemrf[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [andyhalford22[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.3 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

-- 
Hello Sir



  I am Andy Halford from London, UK. Nice to meet you. Sorry for the
inconvenience it's because of the time difference. I contacted you
specifically regarding an important piece of information I intend
sharing with you that will be of interest to you. Having gone through
an intelligent methodical search, I decided to specifically contact
you hoping that you will find this information useful. Kindly confirm
I got the correct email by replying via same email to ensure I don't
send the information to the wrong person.



REGARDS
Andy Halford
