Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF60620EE8
	for <lists+linux-scsi@lfdr.de>; Tue,  8 Nov 2022 12:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233953AbiKHLYY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 8 Nov 2022 06:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbiKHLYP (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 8 Nov 2022 06:24:15 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C21C4875C
        for <linux-scsi@vger.kernel.org>; Tue,  8 Nov 2022 03:24:14 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id x7so3808230ilg.0
        for <linux-scsi@vger.kernel.org>; Tue, 08 Nov 2022 03:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5B7dfi7xVJ3OslQ0ALi00lhJojz9IHhiYsVHA/RHqOE=;
        b=LXzLwEfFEIjs9nRQ/0D9sK0UdFF/hcYD1/7lPcxtKxGf+ipiOyxIUkG9FxWjTQwnxI
         D0k1pcJ4r9HbGweGR8VttiL8E2qc4lcsz3jC3X1z+Myzw30J2a8GCz5AS/bkRvOOAlHD
         E+tAU65cwh01zP65Dht/AwghXmg8POvqM5wMW+NclASoJJ1M+p89BgFOSDch5BgQ0Avc
         9JiZIkvYkz5qbwJiVyZnhn8aEs4dsNPEV6aJ60VBa1B1c4nkJvkSo/q1xUjbvGvnQsI2
         YCKRfjADZRvavXIhrgWVqvohpAMKlTCL5cT3Ex4YqBvyGRv/IX591YGJ8Vqkx1vqKbDZ
         WAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5B7dfi7xVJ3OslQ0ALi00lhJojz9IHhiYsVHA/RHqOE=;
        b=Y7YqyUWHkOiPF38q7agD8AeSNs7QcDGSNEhUpoDbVRwKM35UxUTuRmkunqSpL3KCbZ
         +beoYmupTH19+V4FJ1EtEs1r4+hHAyO7qaO+yZJdjHPV+xGTcT7Aj96i19XRcA3TryoP
         /zy4oqMJKC1LdLa3c3V5zgDuk1r78nQszrTCG4YEwGuw9mX8U0W0SJUVMX1m6Pdd2VVB
         E8ZmOwi+7Ivrg1uH6XjQqfhyW/vU9V+8uqBKN6Ph8gJMolweQTBHgIf/0mOqF33jkCj0
         ciHZ6jEMWNKCJR7gq/PiUrXYvT7TcU9GnHbHmafAfunQOcwXE1Tm8iNLWnlodINMMeC/
         Walw==
X-Gm-Message-State: ACrzQf0Dq+C/gA5Gh5SJjSCbf/yeahMPjBHffUgxpjxHgqND4o3Vlv3k
        SxDFBpZf2tCbMRoG1295BbKtT6j+KQciM2CDQ5c=
X-Google-Smtp-Source: AMsMyM7l9664LpWj9QcPDmFBWC92J2k8lgTtaMBq0d8Kn2LaY6/WvjL6jmQ58ep7k3CUc1mU0tvXdcs9IQAedNtHTSY=
X-Received: by 2002:a92:bf0e:0:b0:300:cc8e:fe07 with SMTP id
 z14-20020a92bf0e000000b00300cc8efe07mr18642833ilh.184.1667906653482; Tue, 08
 Nov 2022 03:24:13 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6638:1921:0:0:0:0 with HTTP; Tue, 8 Nov 2022 03:24:13
 -0800 (PST)
Reply-To: mrinvest1010@gmail.com
From:   "K. A. Mr. Kairi" <ctocik10@gmail.com>
Date:   Tue, 8 Nov 2022 03:24:13 -0800
Message-ID: <CAEbPynvxfjzGLRVVaaVB9fasgmGPWiH+Ceaj9c3oE5eqT5_+0Q@mail.gmail.com>
Subject: Re: My Response..
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:12e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrinvest1010[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ctocik10[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ctocik10[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

-- 
Dear

How are you, I have a serious client, whom will be interested to
invest in your country, I got your Details through the Investment
Network and world Global Business directory.

Let me know if you are interested for more details.....

Sincerely,
Mr. Kairi Andrew
