Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE9A6BD624
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Mar 2023 17:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjCPQpM (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 16 Mar 2023 12:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjCPQpH (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 16 Mar 2023 12:45:07 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6241BB1A6A
        for <linux-scsi@vger.kernel.org>; Thu, 16 Mar 2023 09:44:43 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id x22-20020a056830409600b0069b30fb38f7so1314830ott.5
        for <linux-scsi@vger.kernel.org>; Thu, 16 Mar 2023 09:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678985082;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5ZrXU5jgXQn0XVrjMqAH34ooe0I0t296BlYZYfw7/M=;
        b=lmHdfF3YSZ3AeVRd+pSJgzKHLUUfDhiJAUCzz4m0UL7Cm/zp00qfhABHNh5qTVJH5G
         TQskqbIMmGQItMzy7BxQGPFSkPYuphaCRwkcpIlqSQuaWYZvtsU8r95D5TGjX3SbJoag
         ucrFM26h5M+NRgE/ofrDhryXtKyHKQIKRWe1N/JH/G8qrnWWMz7qLfoqB7K6xh2qEqWz
         YBVmlSwVfSaOJbCIQbA3622tl2/BExORQazAoJ+3QBjSGo+4XVV0uoABa9OV056SP8AB
         jrgtbBaKfrwxRoCMZu9LLexh2Xows0DKWtjjZ8SKsbQaN5ygIOmFRaOHSZiMeS7bb05Z
         Y1Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678985082;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C5ZrXU5jgXQn0XVrjMqAH34ooe0I0t296BlYZYfw7/M=;
        b=X8ghNzfhaqmXyZQq6DASvet6mDpWeyagb/SVwp/OwRGooJw6oHdJlvtVk1G96nszp3
         eMfQ000lpSmpWgSeqSeh90WkYEeRePWApc9pAK8KSKNx2Ag0hXZBtm9dDCSh0PsaYeIq
         hsIcQGed8A9JZqLQ8N2SqmRQDu6hdsG9fy89uzNUX8v/6XOot0BOUSDOf/9ZhQ0w/PMM
         NwvxFmletD5PPdDhJG+cmrTGm1pRsqohXDXh1fBoCiEtYdgYhzE/dUDWWBX6H2QK/0hY
         mUK1matiHz50FQHfjZbZ+3B9bSalJVJkcPTpfVHMDCcDhAxLPZZwP7BCFgTfUwmckYms
         R48A==
X-Gm-Message-State: AO0yUKVLYlruQX5VFeve50yUdPOqBHilY1/mhN6iPCTqQwOrtXZ9YaYQ
        DrPj3v2HQQyZRXaJC9rZij+GQbPIGcNQC3D5pRY=
X-Google-Smtp-Source: AK7set+okvY3OalL6HUqDq88KsQAB8RMQQJFmktp+eH1mGvNpzAci6JEqBT5Cye8pFdanFwG763R/PaVa4kZaTX0DnI=
X-Received: by 2002:a9d:5904:0:b0:69e:18a2:56b2 with SMTP id
 t4-20020a9d5904000000b0069e18a256b2mr60370oth.1.1678985082679; Thu, 16 Mar
 2023 09:44:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:44c3:b0:105:5db3:6fac with HTTP; Thu, 16 Mar 2023
 09:44:42 -0700 (PDT)
Reply-To: enocvendor6777@gmail.com
From:   " Emirates National Oil Company (ENOC)" <jw9867974@gmail.com>
Date:   Thu, 16 Mar 2023 09:44:42 -0700
Message-ID: <CAGzFteW+WzATO9zFpjo0bwB+yMqLRQ8xw_z=yZ4U8rGhYy3xpQ@mail.gmail.com>
Subject: Emirates National Oil Company (ENOC)
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:343 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [jw9867974[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jw9867974[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [enocvendor6777[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

We are inviting your esteemed company for vendor registration and
intending partners for Emirates National Oil Company (ENOC)
2023/2024 projects.
These projects are open for all companies around the world, if you
have intention to participate in the process,
please confirm your interest by contacting us through our official
email address  project-ae@enocvendor-ea.com
MR. Nasir Khalid
Senior Project Manager
