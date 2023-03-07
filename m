Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBD06AFA9D
	for <lists+linux-scsi@lfdr.de>; Wed,  8 Mar 2023 00:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjCGXjn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 7 Mar 2023 18:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjCGXjm (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 7 Mar 2023 18:39:42 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D7B12BC2
        for <linux-scsi@vger.kernel.org>; Tue,  7 Mar 2023 15:39:41 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-53916ab0c6bso274821967b3.7
        for <linux-scsi@vger.kernel.org>; Tue, 07 Mar 2023 15:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678232380;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9o9mSQYdte3TybDAk9zVURLP9csTfrGChqi4RacfPlI=;
        b=aRXtodBPIIc8DXW1l0DNLpqBt1RoMIFvnfZdKhFejFqivJjId3warMWSO9AVT8FhT8
         7x/WFAalSOUJYVEbm8W5OEGfDo/TokT/eGNM5D5caruTgX3qn5OZvtkrdPUWba2qKbgh
         z7btfawqdhMwIeMUrktH8gB69ZM6Tb9V3y4afGlDvYXyowuhsJ6yanKxpaFx4HD4aA9y
         xXNOPV/sTcxOwnqAxqSiRJqABjVXfLiHVyP8Bt1IjXaES0SH2x3XCl9fp03qsFPvDFIl
         nSw+nVqZ9ukCz3OQlc1+8ymcYyVbhq1rph8b3NRG3NQzqu16MkJulGeQ63GWKsN4AWVY
         Tv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678232380;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9o9mSQYdte3TybDAk9zVURLP9csTfrGChqi4RacfPlI=;
        b=UZhZv+SoDSmQQ2mLnCGckrlRVA93sEE2a8TV+XpH706BLS3rKqLZ6vVPNMpHL0havs
         WD219MgMZ3J7cwIU2FLeTHrqVRJ1XEpqn1ntQlTdXdiLjsEiy5cu/S04Xfa1L2MdFutd
         kT1b9FwCi+05lwe9Iiar40+oOrPiQDF6v9418a6KwhQsgh2KA3Co86E92LCZYZkS1C1u
         FfCOCiVfe6i1Z59yVmDX84s0Aw0PS44G4oNMXF4b6iombOXP16iwk64WCFo7g1TITo+a
         d1IaeYyWJxiIJ97Hq/djgKFqZdH066+0OnarkE1h4JtXXR3pasrk6VhZqvHellzIqQcH
         nQYA==
X-Gm-Message-State: AO0yUKUWYcKkWDyCwt39IILsA0W11NUlDSdZ9nQrM6r1MNjobTSwhp1W
        /PRfBekX4vai5HRbo5Gu5ePFIvp8QtoesEB4PYA=
X-Google-Smtp-Source: AK7set8R/tUrR4mS90G4au+VLK8NvBgoFOwFJ9MaRvWhQ85Riy1eySofU7GzS50j1KgpgoaxfA1zNxy2NOWwOTzQFQo=
X-Received: by 2002:a81:ac60:0:b0:52f:184a:da09 with SMTP id
 z32-20020a81ac60000000b0052f184ada09mr10420039ywj.2.1678232380273; Tue, 07
 Mar 2023 15:39:40 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7000:16d2:b0:48d:e100:7602 with HTTP; Tue, 7 Mar 2023
 15:39:39 -0800 (PST)
Reply-To: ceciliathompson70mrs@gmail.com
From:   "Mrs. Cecilia Thompson" <ubankusabk@gmail.com>
Date:   Wed, 8 Mar 2023 00:39:39 +0100
Message-ID: <CAG8Aq=VjZZPA_F6d98yrp7E2kMdm-0EZan=E0BekocHug3+5Yw@mail.gmail.com>
Subject: Hoe is het
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM,UNDISC_MONEY,URG_BIZ autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1131 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4995]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ubankusabk[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Heb je het laatste vorige bericht ontvangen dat ik je heb gestuurd?
Als je het niet hebt ontvangen, laat het me dan weten, zodat ik het je
opnieuw kan sturen, omdat het een zeer belangrijk en urgent probleem
is. Antwoord heel snel. MIJN NAAM IS MEVROUW CECILIA THOMPSON

Did You received the last previous message I sent to you? If you did
not receive it please let me know so that I can send it back to you
again because the issue is very important and urgent, please reply
very fast. MY NAME IS MRS.CECILIA THOMPSON
