Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDA06A2870
	for <lists+linux-scsi@lfdr.de>; Sat, 25 Feb 2023 10:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjBYJa2 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 25 Feb 2023 04:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjBYJa1 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 25 Feb 2023 04:30:27 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED9CFF03
        for <linux-scsi@vger.kernel.org>; Sat, 25 Feb 2023 01:30:26 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id b20so854628pfo.6
        for <linux-scsi@vger.kernel.org>; Sat, 25 Feb 2023 01:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwJ3djsgu7EpFGFjesrarL0td1XXwZi3NukCRezNELs=;
        b=optnimXpIydzp/+PWndFOQjbgLlMpy3vFttLCCQRdLUitavfgO3O8hWdo5CjF/sTe0
         Wm8wrBn7zBQG+1EKFdrRWBOQ83MEHrmfryE0Szri53CrRwl0YalIfzI5VW20MAf73E++
         6ZFFwJeLOlgkwII48SVvuntW4LeUU27IdF0RvUV4h1JsrMgMyzhc7lhpuSAxtt4VOiW0
         v0a4/sylwTCgoyKsJZ8Zt7yEY/yEDoFjDPTjl1Mijb1Ya9yoI8hKiYua/iCVVKRScdg8
         fBBDXNEyJ5ykM5+PslILzk8ey7LhEyOM/AdPbbfitSdV+GE3n7Rs+NztqSEQfTFb81vf
         WZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QwJ3djsgu7EpFGFjesrarL0td1XXwZi3NukCRezNELs=;
        b=ufoc96N1DpOQfm8chdtz1D7QCPOv/lhoKhoTDCu3fNmuzTgttkhKDi7VQ/S4pHgSn7
         UUoi/QnMEC+rULYlUJHVy92v2WfCKdR13vRqxo7Fc3O0FjSOQPKiPyYeynqOSijK1AoG
         2YjL3Fcbsp4pTNwl+OiYDNnm7maUbiLv2L2rDLzplB0jmwUW/D1urB6xw35x2FjWuDXg
         Bwr1J59mLglRUeQX8fmNE9RXucIu772BuhfOGUoUJxG2bFUgGIW9ZB+UUxzWcAinD+Ov
         go4feiNNhLfxlGvWvtzeRtWNkM091x2DwwfO5VIk2PZHTuYqbjfhypvuk5tE+ybYR/Uq
         5XUw==
X-Gm-Message-State: AO0yUKVM6omdw4r3Ht+bRggDcbbEhKb+2eNeQV4cTm/WKex0lwjUHuvf
        fLObzy5Zy9AWEh1Y7Mpmqdp+6U9q8GkeadjiOis=
X-Google-Smtp-Source: AK7set8DjEjXobqY1+0xwn7dDh6+tMMwGXg8yycT4d+IfKsY14jRQSpBywK26Am9dX6t1Bl5lHQa8e1kSXjNvWKsErw=
X-Received: by 2002:a05:6a00:7c8:b0:5df:9809:621f with SMTP id
 n8-20020a056a0007c800b005df9809621fmr2406272pfu.0.1677317426001; Sat, 25 Feb
 2023 01:30:26 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:902:9a87:b0:19c:92af:ad17 with HTTP; Sat, 25 Feb 2023
 01:30:25 -0800 (PST)
Reply-To: lassounadage5@gmail.com
From:   Ms Nadage Lassou <nadagelassou@gmail.com>
Date:   Sat, 25 Feb 2023 10:30:25 +0100
Message-ID: <CAJ97MqQUY4HeeHOPN6sWPSeFG-4bUAmVuOwd3SbU8BnrwM7Zmw@mail.gmail.com>
Subject: YOUR URGENT ATTENTION
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,SUBJ_ATTENTION,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:42a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lassounadage5[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [nadagelassou[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.5 SUBJ_ATTENTION ATTENTION in Subject
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Greetings.

I am Ms Nadage lassou,I have something important to tell you
Thanks, i will send you the details once i hear from you.
Regards.
Ms Nadage Lassou
