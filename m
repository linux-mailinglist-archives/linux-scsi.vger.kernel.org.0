Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1975B9A9C
	for <lists+linux-scsi@lfdr.de>; Thu, 15 Sep 2022 14:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiIOMVB (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 15 Sep 2022 08:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiIOMU7 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 15 Sep 2022 08:20:59 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DCC8604A
        for <linux-scsi@vger.kernel.org>; Thu, 15 Sep 2022 05:20:59 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id w8so30059540lft.12
        for <linux-scsi@vger.kernel.org>; Thu, 15 Sep 2022 05:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=AGcO71WbIxFnFilwxT5lepgFitr4TaGnrBHJH6c53wCHMxnREdZ9/Ok+pkaEoT41+b
         svc6oZK9aPKEc+iSamlNw0fB9fGVIMAN69z9Q0HgiGedDTdDszCRVH5lqrRYFGW0pObE
         t20nmVaUybdGG9bfcCmlUdo7Ti55M/jD21ePCXLenKlWQTFeleF063cuSiGaPp7v8jHU
         g4EkXp6avGQFwQPnjGtiTvybwxd2KcORrQac6D6b8by7wl8Jkkf51p+bylO3M9qJYic8
         HYbPqlATWQPId1TMd9+A+GA5s1evEgpDygmgk0ePQXJtwpmsyf2/lnFq0qkMChvBx6nf
         KVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=xDiO4kHkeckfmFgje9VfyEt+JboWpMuIPYUtMD9yOG5l+w2criWaNpQ+G3LtiIA5yV
         O0TTThgOECMbfrOc7a3wD8OBRbfdpjRxGrnHanpQ5mx/cBgQWKCllW0uRncYe6Fl6Dqd
         aNVyFQy3oE45exc78eAnaCgmfJ3Ox2Zb+vbNRV/MCp2KO+AnONA4EbcY4pwjFiUsSSwz
         s8NT05yVChNkW51+vYnyK9Epn8idd15aAJak+YIAFiTp+1on6/QS/bh+NcEDuU4PfSjV
         zubROOZpjJtbdoNftuvzpapRGMK4e0kUNkh4qm5F1hnmtqBl8ikHXFeFyG9B5KeWCHb8
         J/Zw==
X-Gm-Message-State: ACgBeo2x2kWzAfOaMUDD0bKnzmfIv5Izu+7apC24/WjyDxRR5f5dO1Gg
        m/lD8deUL58AFFbQSkmt5OjdcbJT8pKAcZmcDgk=
X-Google-Smtp-Source: AA6agR42DwGGYoPlecodV1pKeT+9oZbKGeydvoD8p/mfMpmHh0fzgtuo5pSflgCVGjoYGfCsX3XM4KxQ8zmxpKDBb7E=
X-Received: by 2002:a05:6512:1101:b0:492:da22:bc58 with SMTP id
 l1-20020a056512110100b00492da22bc58mr14048721lfg.219.1663244457335; Thu, 15
 Sep 2022 05:20:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:7ad6:0:b0:1e7:20cb:db2e with HTTP; Thu, 15 Sep 2022
 05:20:56 -0700 (PDT)
Reply-To: kl145177@gmail.com
From:   Ken Lawson <cazareehzohg892@gmail.com>
Date:   Thu, 15 Sep 2022 12:20:56 +0000
Message-ID: <CA+u1qxuC7-WXbezTsep2ZQrGwgJ6NuHoPSB8YzMxKoJ3masSyw@mail.gmail.com>
Subject: Did you receive the email I sent for you?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:12d listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4956]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [cazareehzohg892[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [kl145177[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [cazareehzohg892[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


