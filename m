Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A22B6CFFC8
	for <lists+linux-scsi@lfdr.de>; Thu, 30 Mar 2023 11:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjC3J3s (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 30 Mar 2023 05:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjC3J3r (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 30 Mar 2023 05:29:47 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE9246B4
        for <linux-scsi@vger.kernel.org>; Thu, 30 Mar 2023 02:29:46 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id f14so149004oiw.10
        for <linux-scsi@vger.kernel.org>; Thu, 30 Mar 2023 02:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680168586;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnFj1muq8Mk40IlFzxpOA9bHZ5y7d3hhb5wUcsTAgT4=;
        b=M0w/EPa4EpxvTOoQRPXjj3jdPDOPOtDHEh38jhej9hfQBf787wA6t0/rvoagl3sJ/c
         E+W398uWTVV4W9S1KhBb8NyiPq/DU1aTqzTcvoAZVD3YpPQW7FffndLKzPbkUbbNt7mb
         Xc3VFz3utACJ4vMFo+ZBHE3ReEqXAyZUBwlEn3VTXP4hHa26B6ditURbd9gNhYCRsLl+
         /pb4df5PeH90rMUGBqS5DXHgMdJS5kzTcgamkMNBmdO9RO8WCoCaUGAn/UIpBOgbWkmO
         B1IqaAe8DwfYZU+tj7A6RPUEs6t2jc55IypX5OtG7Xw1wmqKjLz5ziEYphgYFqromLYY
         e3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680168586;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WnFj1muq8Mk40IlFzxpOA9bHZ5y7d3hhb5wUcsTAgT4=;
        b=08oOeofskwOjHMdFSG0SWWc/xhEmZfS1tfHu9hTOlHSp+O1TmhuSkMA3Qt4VxKMvC1
         3CvdyLMVvrBvumQn8j82AjxA0ycIUjD0drbZyTVywiwZ8AQSoGhBzTkt7cYaXBzCdDo9
         l5O5GoSdtOghlBLSXKpLSh5UOIIH77nRKn5N23teNmvlZKModeTEo2oEnyywP2DjcL/A
         m0wGaG4f6YIxz6oGpmv10pTH+taeR1M6+6AKJJOOPKLsXAtVAXP/xaNQsnUGm8VZ/YDl
         itK2Dx3jhMzBSZj6ymCtlqSy2AJ0FkI9oyo41zzS4lFi6e3vkU96CswJYoN+BkYky4VW
         gzGQ==
X-Gm-Message-State: AO0yUKXqtQTySfRyo+p3BRDtCu71Tiv1IN4287X+KtIuvlCpeXC1t2X6
        ooi9WUBXK+bJ7yTQxZ8TbeIsGhkXAB7KA5RF7Bo=
X-Google-Smtp-Source: AK7set8XQ80DbpoRdNH97HksBZxycrUkM+kwUO2MUUi/pp9jbZ1czJzrPCQpTn+PSXd3hZkC6P7dTbtzt9Dgfje5O1k=
X-Received: by 2002:a54:4694:0:b0:386:a6d2:30ac with SMTP id
 k20-20020a544694000000b00386a6d230acmr6686721oic.1.1680168585761; Thu, 30 Mar
 2023 02:29:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:895:b0:112:b17b:b8f4 with HTTP; Thu, 30 Mar 2023
 02:29:45 -0700 (PDT)
Reply-To: justinekevin013@gmail.com
From:   justine <pastordavidekennadhl@gmail.com>
Date:   Thu, 30 Mar 2023 09:29:45 +0000
Message-ID: <CAAMZHjepzs3+_zL4chO-+UKGn9ZV1QOQZhD9JtGgr87C2TQcYQ@mail.gmail.com>
Subject: Good day,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM,UNDISC_MONEY,URG_BIZ autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:230 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [pastordavidekennadhl[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [justinekevin013[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.9 URG_BIZ Contains urgent matter
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

I have very important information for you, but due to the sensitivity
and importance of the information, I want to make sure I am
communicating with the correct person owner of this email address. I
await your urgent response and thank you for your understanding.
Email:justinekevin013@gmail.com
