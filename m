Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8AC4D3E56
	for <lists+linux-scsi@lfdr.de>; Thu, 10 Mar 2022 01:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239041AbiCJApq (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 9 Mar 2022 19:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239060AbiCJApp (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 9 Mar 2022 19:45:45 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642261255A8
        for <linux-scsi@vger.kernel.org>; Wed,  9 Mar 2022 16:44:44 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id w12so6683451lfr.9
        for <linux-scsi@vger.kernel.org>; Wed, 09 Mar 2022 16:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=fNxQZUenjMYTRaLZ8bVRtrts/KBsq8qlTn4csxEcmJM=;
        b=QQ3IaSXjga+bqFNYqeQRJF7TOrau3j6WrJllhdrn7TSnfNZMjRYPIsbmrKnaxDRZLs
         esWotoBiy1Dtv+e7ouUCNUSk1epfURjL4g/HCD2Iy2UWmUslYaP2xdBSCJMQE0ZWkOhg
         XapKMk2LMEGZwxJgDT/b7eH2QASLNnD36832s6/Ly5EDSUskH0IuS3oxzqcJe5Wr76mk
         u/NQWKy7XRAJ2qI9Lv7pz1lI1RvDA0EFK1oPKFIZHjQF1a/MUotLrAho+NTz6SL1sYkF
         UKOIQFrktBSbEcoGAwuBtyeCszbu4pDOFwm4vBVXLsOZWzh7628ieNMfpZesJQQVOViG
         KjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=fNxQZUenjMYTRaLZ8bVRtrts/KBsq8qlTn4csxEcmJM=;
        b=c9HeGyzQ99bN3BnUrOZz8GZxL3cZlX7jaBmHfvGaSOsNTc974+T4Ild8fhjJgZCIz4
         9z5q//vSmpn5Zyo0SMAogmY/DhCn90jp0syfSy3GizQGRWa+F7YYnMLhdbePmIG5zoY9
         B6gdTfjZ2qQWgWZqdAM6Z/epg14kuMCe1BFGZ7+OTrPrt8IVysNvcAPppT+5a6yPZyVJ
         yGZr3m+3QX9lXKNjTIIwio55qVkpNQsocabf1KA3VYwal98BnI8aRio9veJqwu6K40OV
         xWzSfoX7jwTJpkpuaDHwDpxMtDEJccoshSni44oumyBdgkLu7roBYExBvgzxaG2GJKAg
         fz1w==
X-Gm-Message-State: AOAM531LY7z90fKpzkTLAPXV4LzV454LyIlm9iyo5bvZzKy6f+QeBUg1
        Qs247T7wfmit1EyETnR10TZ8AQrnswI857X+feqn5G7S6L/KWg==
X-Google-Smtp-Source: ABdhPJyv7NjZ5lJd0JDYz+wQ/ptNNnXYx23U51aOnIJBDY5Jc7ErfsS4sbqZAamAuQIsyb62anmSaRAr4B2XfTYzVak=
X-Received: by 2002:a05:6512:1597:b0:443:bd68:6a70 with SMTP id
 bp23-20020a056512159700b00443bd686a70mr1436631lfb.548.1646873081319; Wed, 09
 Mar 2022 16:44:41 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6512:b83:0:0:0:0 with HTTP; Wed, 9 Mar 2022 16:44:40
 -0800 (PST)
From:   "Capt. Sherri" <latobaba3@gmail.com>
Date:   Thu, 10 Mar 2022 00:44:40 +0000
Message-ID: <CAHi4UtkZr4y-3ZdARi99UbzfprDG-EJG49NGjtt+0Li2FDXXKg@mail.gmail.com>
Subject: Re: Hello Dear, How Are You
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

5L2g5aW977yMDQoNCuS9oOaUtuWIsOaIkeS5i+WJjeeahOa2iOaBr+S6huWQl++8nyDmiJHkuYvl
iY3ogZTns7vov4fkvaDvvIzkvYbmtojmga/lpLHotKXkuobvvIzmiYDku6XmiJHlhrPlrprlho3l
hpnkuIDmrKHjgIIg6K+356Gu6K6k5oKo5piv5ZCm5pS25Yiw5q2k5L+h5oGv77yM5Lul5L6/5oiR
57un57ut77yMDQoNCuetieW+heaCqOeahOetlOWkjeOAgg0KDQrpl67lgJnvvIwNCumbquiOieS4
iuWwiQ0K
