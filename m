Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033075F32CC
	for <lists+linux-scsi@lfdr.de>; Mon,  3 Oct 2022 17:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiJCPow (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 3 Oct 2022 11:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiJCPou (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 3 Oct 2022 11:44:50 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4E2BF75
        for <linux-scsi@vger.kernel.org>; Mon,  3 Oct 2022 08:44:45 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v128-20020a1cac86000000b003b7a6ad5ccdso3079853wme.3
        for <linux-scsi@vger.kernel.org>; Mon, 03 Oct 2022 08:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=pSKuz9BJS/Qwel4yBJUKsJP++c1z8gtIosTtEbMtN5I=;
        b=TNzyg0UzAnXZpoIQMzbZ86dnubMpwfhKufDpDTnPuxleteDaQsf5Z5FxHVntC+Rqmd
         6010p4JbhQ129jIqnv4SDzPtDIC0k4Pz1Clmx1ySUWPDg5WrPT0EvLDzGIKcB4Obh1BC
         rPmTIZvXslRiqwebdhRK5JA6tXk4rqUykPsxqwrqq7HhBKfJ9PSCpIW5jrBzSzukV42s
         fHxjCjjOekqhiD5xQEFyyAktqERte/oK37l3zdAo3jgQUp+P9yvpCK3E7g79fhLnjs+Z
         78zk1moQkntZ7RN6HqpXTAk4W0is28mBcbpW+RSkD1bb5EGeQZkEurTwnQD0nEdK7ZUS
         PV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=pSKuz9BJS/Qwel4yBJUKsJP++c1z8gtIosTtEbMtN5I=;
        b=4M415pA1jUqxL8H36SPBZ7Z3qbbGE5LLYCiFqGpKVUsSUZtRX0CfyYT2Pzg/meHS52
         VcBXfTVCP/1Iua94utH2STrsVRy0WOK50ngUEjgSvmSNIZ7vxLWSzjkMkUi9mw4Ggb8X
         hohq597lA9G7t3XVcI1m/lbnRjSUfIio7K49D1GatbqfVTbrtrFBn1qNbZWfk3dGtlnA
         lXeyweVRQDqEcPt6SC+d/Qb0tpuQUBlXXFUCuZrM3dtIn+tlVUE/IygShIA3sR84o4GS
         fbc+fczeFQyman9vzGcp39m4mOab+l5KH480V0pAZqQfu0pWiNNqJJM/s6Shf9PWQjyj
         zveQ==
X-Gm-Message-State: ACrzQf0fCtMcix1qUN/WiNQq9Wi82dCaGiIZ6vpi2H0hla+a5zE+k8U6
        OJRWbzTsZYzBcl2mG+8zjJOGiYmZjbhiv5jkMlc=
X-Google-Smtp-Source: AMsMyM7NxrSkIGMA4opePuEHpZdW8RxzA2+hkHHxigVLVbJ0JN9TXq3Mxx7k6tHkYYKreyqu1YjLp6S1Hba92flW6nY=
X-Received: by 2002:a05:600c:1da2:b0:3b4:856a:162c with SMTP id
 p34-20020a05600c1da200b003b4856a162cmr7130555wms.28.1664811884231; Mon, 03
 Oct 2022 08:44:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:4748:0:0:0:0:0 with HTTP; Mon, 3 Oct 2022 08:44:43 -0700 (PDT)
Reply-To: davidnelson7702626@gmail.com
From:   hapy udu <hapy7367@gmail.com>
Date:   Mon, 3 Oct 2022 16:44:43 +0100
Message-ID: <CADgecZ0oDYEiSU4MUmJhkT1muk9nMCytv6-rue+S-YsQUC2Zmg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:343 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [hapy7367[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [hapy7367[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [davidnelson7702626[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hello friend, I want to send money to you to enable me invest in your
country get back to me if you are interested.
