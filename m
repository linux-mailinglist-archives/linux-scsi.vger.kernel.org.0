Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6C4578718
	for <lists+linux-scsi@lfdr.de>; Mon, 18 Jul 2022 18:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbiGRQQD (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 18 Jul 2022 12:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234234AbiGRQQC (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 18 Jul 2022 12:16:02 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBF66364
        for <linux-scsi@vger.kernel.org>; Mon, 18 Jul 2022 09:16:01 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id d4so6247002ilc.8
        for <linux-scsi@vger.kernel.org>; Mon, 18 Jul 2022 09:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=MUDd76TinUcA5JyTPJBAHn1VumWVzYjA1fKwU0h/HzI=;
        b=F6ABfGXp5jt+z5hHdjsGmYB4EravlJ+RqekEqnDkdrJGiMuWxMlmwDX9LcdTD4kWcV
         n1cqvpZ/XFI/TQpYGnbi5KMhuLvWFvcOWDj4H7kPilzXTwthkm0susVG+wDVJGlLfb7M
         ouk7C9W5SL0tUq42Bb7ZZITiPJ+r1J5REu3YJmwuDIJqDz8BGb3v7hK/6Db4CEYPHPoE
         wxDlsJJPJwdoS5MYWTDmGlBow0dFIvb6wi7To/vEpa7OTvUPVm6xLBSpLipXoQvly3Vx
         q1glwIWb65lz80+yRqxTq4RSumMAGTv2UARFXNIuaajxL/c6Eikzs1Ql2PbfX99Tcj3S
         BVCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=MUDd76TinUcA5JyTPJBAHn1VumWVzYjA1fKwU0h/HzI=;
        b=KnB301GK7SXVtWfKIV0dAEv9qElNuey8V/wuYZwl4WJpfunCZpLgDNgwigN500WEE9
         vGIQc+p9424pJjkWvAVJ3wN8WdahmLNvN0/4d+bmZ9vOPo9w9DZ402szlp5wD64Lswoe
         L//O9qcX7zZpiRU0aLb5nigEDRHuhNnf84iwwBiOd7hv3yK6OUlAGiawyrAdAesbV6qz
         YHhtqTHnd6CH5rQ9EjREEvdxMHOC1f7uP4fCEABGKEPYfPhB8qpKhhoyspe+o95GC0JU
         FVVJ5mAGa6NixCsRqZVyTuzKVTL07uBVWCOJNnmDkY5TcAsLns27+INX1NyYxEbPXiw1
         XWEA==
X-Gm-Message-State: AJIora+50HWgzvESGC6nV7bFRSHqtNzHcKhlQPJvSf9KyZTOnlSteW5s
        f7qrlSKDKBIQtYGLEVOER98MFYq/Esf2d58rkxo=
X-Google-Smtp-Source: AGRyM1vNmq9FgELz6uTHCbLjcblEfmCkLAnTqK+T0q21oKAEhX0fk7/Ox9DgvUbx2REBzGpZMmn14jZgvRkL4pVmz9c=
X-Received: by 2002:a92:c241:0:b0:2dc:7408:ad66 with SMTP id
 k1-20020a92c241000000b002dc7408ad66mr14790746ilo.137.1658160960878; Mon, 18
 Jul 2022 09:16:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:13c5:0:0:0:0 with HTTP; Mon, 18 Jul 2022 09:16:00
 -0700 (PDT)
Reply-To: marykaya3n@gmail.com
From:   Mary Kayash <reynoldbill21@gmail.com>
Date:   Mon, 18 Jul 2022 11:16:00 -0500
Message-ID: <CALDGGy9G0WyivhixnJR1qspz8kKq98hJpF44G8D9U+TrAKvQCA@mail.gmail.com>
Subject: Dear In Christ,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:130 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.7894]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [reynoldbill21[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [reynoldbill21[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
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

Please I want to know if the email is valid to reach you.

Mrs Mary.
