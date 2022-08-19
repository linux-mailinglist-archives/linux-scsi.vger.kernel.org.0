Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117DB599A24
	for <lists+linux-scsi@lfdr.de>; Fri, 19 Aug 2022 12:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348019AbiHSKnw (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 19 Aug 2022 06:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347912AbiHSKnv (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 19 Aug 2022 06:43:51 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A482433A35
        for <linux-scsi@vger.kernel.org>; Fri, 19 Aug 2022 03:43:49 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x19so1193246pfq.1
        for <linux-scsi@vger.kernel.org>; Fri, 19 Aug 2022 03:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=vTR/8Rp3ZPOCxUywjE3qAbiASt8/c0tKigqqky7YLrE=;
        b=Bv2OIWEOoRmkpGiXKormo0a6AYWDKoICK0phwKlqGsauqWMA9hJHrx4y1HlqVmt00U
         Gammu6uD9Jv/MHPWUHwEskcYwivqcYxQheMDLG+DMLdLyVWXH2e838Bz1iY3rBvZLdE5
         y7uVMj4Jlif7nsEbIz8nSEvmx1/Dk7+wknm4dA5B72zFJAuzkFImdn1x7y269GjFSkxJ
         zjGcFMd7EV2VyvOTYrNnydqkqMEhbKJmv3S9Tblkbn3eG1yRl0b4x57Rb4uvS8x7S5Ky
         tqKzlA31OcVRDd2yGakg3zPv32Jfy+f0yOUWBw/HbZjvvcS4ipecsp5z9XR7Zn4SKc1u
         h+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=vTR/8Rp3ZPOCxUywjE3qAbiASt8/c0tKigqqky7YLrE=;
        b=BCyUONf57KdYAaflt8I7yT+3ORGNAlx1BvVITXJPvxH7vJbU4LWUWPJ/jBIc2OW7j2
         o6fIDN0CGe9jnMIRz1M44B7RMoHlWuweVAKUzpnf+RNJjtDW6Guoil9EpcPehHWCQ7VU
         gAXsmxWgZxRtZVfUWSt9131mRLvcZ81KHep4ONUwVXYQYzXcdPXOkdxShssk6UL6AKQo
         0liP/8CcdOtXRdzKrX4a/uNE/2yPLsVjbvigbDCUxVDuPiIXspHI9EgLxe41ORqVs4us
         ILhxmfxccZPlK1j+4HT9Cc9QckKXHyxlbMevbYclu6qSOWj6HFjCA4v+ohOgjMkCoEcU
         pzxg==
X-Gm-Message-State: ACgBeo2R0NNVgVQtmsk1ESM0UfVRvww6dRzayqFo3vAeCwScKZAATVvd
        7UQgo2cJl5kyYoHJloqN496W3mb/hknaDWeq+zY=
X-Google-Smtp-Source: AA6agR6kkEbYRVd0fbUmV0rs2wcP7kbQMAWmqwltViv3ASwk2/M2R3DX65SKAw+ieBFM3E4okv2AKdKQ0l1Hk+9E4cU=
X-Received: by 2002:a63:fc20:0:b0:41d:234f:53e2 with SMTP id
 j32-20020a63fc20000000b0041d234f53e2mr5879739pgi.199.1660905828719; Fri, 19
 Aug 2022 03:43:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:4fc3:0:0:0:0 with HTTP; Fri, 19 Aug 2022 03:43:48
 -0700 (PDT)
Reply-To: donaldcurtis3000@gmail.com
From:   Donald Curtis <alexandrinekengbo@gmail.com>
Date:   Fri, 19 Aug 2022 11:43:48 +0100
Message-ID: <CAH9ijYk46M7wgC34TXzgfAz36JrafpBQOGXuyGeOUOipVRowpQ@mail.gmail.com>
Subject: Donald
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

HI,
Good day.
Kindly confirm to me if this is your correct email Address and get
back to me for our interest.
Sincerely,
Donald
