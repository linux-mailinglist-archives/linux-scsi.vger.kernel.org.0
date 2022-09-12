Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B234F5B5A1C
	for <lists+linux-scsi@lfdr.de>; Mon, 12 Sep 2022 14:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiILM3V (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 12 Sep 2022 08:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiILM3U (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 12 Sep 2022 08:29:20 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE6927FED
        for <linux-scsi@vger.kernel.org>; Mon, 12 Sep 2022 05:29:19 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id d25-20020a9d72d9000000b00655d70a1aeaso2643985otk.3
        for <linux-scsi@vger.kernel.org>; Mon, 12 Sep 2022 05:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=osSAgKM1j6DRNQcQXA842NXUQk2GubTJs0svjrfNTko=;
        b=kKJ4H/PNkKCeosIqa29cRsjuCWisZ58xFa/3I+kDo0uFxXf1tRLc3Ia+TqwrtD2jYz
         DVbq0+8AVB9ffTxgBdGfFg35fIbp0cRfC75tmkFiA8iTXbY3A8D6V2sLNUgaioj51bzR
         gIHts0c/GKaoEuYSq72wpe3axRMo80wi0JK9BojMlTM5kEaG2CYlWZ3xQh9KQ7Nk1cE8
         8IZDHyRSzk3Y9ZcRUI3ryC8MrPTpBwVGFZaRoqHF3pSe/t/49pXw41lxmC7acgnoi2sI
         FU4ewU7RrW38bM76q7i7uwgRyvdIaFyjo/MIx2fWmUFFAC7Js7XCHb6zY0m038wg9vlk
         apKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=osSAgKM1j6DRNQcQXA842NXUQk2GubTJs0svjrfNTko=;
        b=Y3hYzRLErHIcHKRTZRqNEWay449+nIaSz8nE+9aZNaM3VDe0yPzMb1IFsdoJP1MuGE
         Z52iO71x9J8ZG3HKJzzG58v4JMYxGpW6+AJoiQ2gkP6Hn/8lJCtTsflCvVFjVv2Lhgci
         kMSgACWW0gLfY4xqnm0+vpBr2nCGLxP5ESy54rk0IZHTPjfszhpoaAUIvVGLMGBZwhsn
         FAlOOSq45JAHRF6Z6mHQeOiIod2TQWkjHKGNZT8d7FhSobEzOM9KX+z9SotGgW76EHv2
         aEQakuME8jf3nBD/xiWaPzu5SlmJhnC0K1SQIcrhv8zCNVFNlvQTELYygYbrE6FQnDAz
         68PA==
X-Gm-Message-State: ACgBeo0ZS4zhhIujnrPZtQtkqq94rU3u5DdPL+0ije7x1CXXztNXOh0N
        a17byKKlP9YcWYvjEXXCC8x5iXPEzIIsWAFaPIjqLC/+r14Opw==
X-Google-Smtp-Source: AA6agR7A86HAdgOfAFISy42FU7QXVFzsblLc7hoM7fB7SwK8kTfvmFZjia84QKNu73h0xXKe7PId3/eRia03INR40aM=
X-Received: by 2002:a9d:2f48:0:b0:655:bba3:2e1a with SMTP id
 h66-20020a9d2f48000000b00655bba32e1amr4950525otb.124.1662985758638; Mon, 12
 Sep 2022 05:29:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:3c4a:0:0:0:0:0 with HTTP; Mon, 12 Sep 2022 05:29:18
 -0700 (PDT)
From:   Michelle Goodman <michellegoodman45@gmail.com>
Date:   Mon, 12 Sep 2022 12:29:18 +0000
Message-ID: <CA+PxuvUBsjSgsFJjkVF6MRbtvjtKbK+8t93T7eqeHKRC2jYgmw@mail.gmail.com>
Subject: Hallo
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hallo, ich hoffe du hast meine Nachricht erhalten.
Ich brauche schnelle Antworten

Vielen Dank.
Michelle
