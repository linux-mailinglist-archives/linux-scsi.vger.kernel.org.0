Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34752586B1B
	for <lists+linux-scsi@lfdr.de>; Mon,  1 Aug 2022 14:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbiHAMp0 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 1 Aug 2022 08:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234919AbiHAMow (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 1 Aug 2022 08:44:52 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32C945F4C
        for <linux-scsi@vger.kernel.org>; Mon,  1 Aug 2022 05:31:08 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id u76so12877303oie.3
        for <linux-scsi@vger.kernel.org>; Mon, 01 Aug 2022 05:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc;
        bh=kCSqCOP5NnmgqzMKAvoC+xj8lkHVueu0SPSEqGKA1Ew=;
        b=TsnfoUQOE/+QihQpvQPinG0iQST10WRCiYY7OPfklMlHc3yLCUb+J4WfBxrvUnsgcA
         JsL8sdk6n/vgVLN0HG5NnDn3vGPss1fXmTxWGyfPUcdI74xAAat/9mmhNbD9rWbpKYR7
         TK37Uz+gt/MFEukcUJ7TK9mCsTmRcELTgWScfxOsbGx6kL7pl/1v57eImNAysunwYMiR
         ICQqWOD9pvR+HK+WTYqzX9FSXE1qFeOJ+3s9watughqNJLXYQiP3OxMIlCxaDcxFTO49
         wYj9W2DcoXd94Q7M5RIOTt+6d+A2Ov6/u34KM/rVjDV/TUH3IKp//prYQ7QVOmw/d75R
         g8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kCSqCOP5NnmgqzMKAvoC+xj8lkHVueu0SPSEqGKA1Ew=;
        b=WS6c2Y/Z37z2Phmie10sLPh9vf3yqJAa3Ompn/aDMc5Sf5AX2zc00KcM3CPG1VL/vf
         jjEHBPK5igWVGlAQFb7aPHqdzIJuKUHnjwVTGP9aymIUj1ncn6ZImB+AHHsASSKvNEKy
         Y49R7NXlGC5aLv4y9ADG6DUldZl093PuPASXn/25lje/mj1DZHf0QVtPCsVgJ5+0HRi6
         /FHEhq0kZ78F8Zaoa+YZc/YqTP9I//s7GY6uSJKj09xN4A6usV6wEULeH013qb21okoX
         oloF5DRLqMVQKjUQbCGQd3ZIQfS23Hz+EAEe9oPwCQoAZCiX/JUnfRB1KJNnEGR4OC1l
         1t6w==
X-Gm-Message-State: AJIora+A7LqWUPCbmsGdetdxEySu5y7NCCXrbtXnHud5Ozs3LZQDt9b2
        GyqA05baC/ms9LF27fSaqOXLTAdDhvAvBRwhz2c=
X-Google-Smtp-Source: AGRyM1sl5ROXbLLk18AVKg6UGR0eY5+mTpByIMK652n1RkTpFNnARd93odKe7mpLvmy/0eTH9N5uSPTSQ9voeyjQwMM=
X-Received: by 2002:a05:6808:308c:b0:33a:73a9:a1ca with SMTP id
 bl12-20020a056808308c00b0033a73a9a1camr5979245oib.279.1659357068300; Mon, 01
 Aug 2022 05:31:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6850:e61c:b0:314:dc02:5b77 with HTTP; Mon, 1 Aug 2022
 05:31:07 -0700 (PDT)
Reply-To: lisarobinsongift02@gmail.com
From:   Lisa Robinson <masesedinah132@gmail.com>
Date:   Mon, 1 Aug 2022 15:31:07 +0300
Message-ID: <CAPaG1UTtPJzROH7Hre+MncDRbLYWMSvtdHL3Cd4fV2b0JkgBww@mail.gmail.com>
Subject: Donation
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:232 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lisarobinsongift02[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [masesedinah132[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [masesedinah132[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

--=20
You were chosen by God to receive my Grant Donation of 1.200.000,00 =E2=82=
=AC
Please contact: Mrs Lisa Robinson via email:
lisarobinsongift02@gmail.com
Surname:
Country:
WhatsApp phone number:
